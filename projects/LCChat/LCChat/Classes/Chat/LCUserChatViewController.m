//
//  LCChatViewController.m
//  Pods
//
//  Created by MengLingChao on 2018/7/10.
//

#import "LCUserChatViewController.h"
#import "LCUserModuleProtocol.h"
//#import <LCMediator/LCWebModuleProtocol.h>
#import "LCWebModuleProtocol.h"
#import "LCMomentModuleProtocol.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface LCUserChatViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UILabel *nicknameLabel;
@property (nonatomic,strong)UIButton *seeMomentButton;//显示动态
@property (nonatomic,strong)UIButton *seeH5Button;//显示h5
@property (nonatomic,strong)UIButton *cameraButton;//
@property (nonatomic,strong)UIButton *albumButton;//

@property (nonatomic, strong) UITableView   *tableView;
@property (nonatomic, strong) NSArray   *dataSource;

@end

@implementation LCUserChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@0);
    }];
    
    self.dataSource = @[@{@"title":@"用户信息",@"module":@"LCUserModule"},
                        @{@"title":@"查看动态",@"module":@"LCMomentModule"},
                        @{@"title":@"H5",@"module":@"LCWebModule"}];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    NSDictionary *item = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = item[@"title"];
    cell.detailTextLabel.text = item[@"module"];
    
    if ([item[@"module"] isEqualToString:@"LCUserModule"]) {
        NSString *nickname = [LCGetModuleInstance(LCUserModule) nickname];
        cell.textLabel.text = [NSString stringWithFormat:@"%@-%@",item[@"title"],nickname];
        NSString *urlString = [LCGetModuleInstance(LCUserModule) avatarUrlString];
        [cell.imageView setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"lc_root_tab_me_normal"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = [self.dataSource objectAtIndex:indexPath.row];
    
    if ([item[@"module"] isEqualToString:@"LCMomentModule"]) {
        [LCGetModuleInstance(LCMomentModule) pushMomentDetailViewControllerWithMomentId:@"110" fromViewController:self];
    } else if  ([item[@"module"] isEqualToString:@"LCWebModule"]) {
        [LCGetModuleInstance(LCWebModule) pushWebViewControllerWithUrlString:@"https://github.com/mlcldh/" fromViewController:self];
    }
}


@end
