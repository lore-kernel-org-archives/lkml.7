Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CCAC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D93D208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 23:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="A0UPjWsz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jpq/qccI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbfGaXzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 19:55:40 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21566 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfGaXzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 19:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564617339; x=1596153339;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=kJP4dx0t/Zd1V69MhKBR/aPy7qZrSsnPXJYEu/vJtm8=;
  b=A0UPjWsz8RxS8DNbrP6SWjnCQF1eBWy16XUgDxTF1VhnL2mngaLCakeV
   SBMQFNa/PJ4Tk5eNWD2tAGc0aBsyBa8kcReO5qCO6Czyw72XGg7eggTFG
   Li2Qp/qovu0RVe3d6nvazmGqYirn7Fm3ES5L6iWyjQjJ0G97y6LE5inec
   n9wpHkX0ED+olyIdT8oN/Hbw3reCrPe1c+1wuYP8TOtJCVadrXoIk4XeP
   Y8NNhzgsG5u6aLvjQHnudL71tRDNtyttS60wI+CBkefiVfCTObL5wTDqi
   AudN9Y/6nEXtIN90ydcanozzjDhceBLrk/hNM/vwRBO85eNcaaM8Rgi0/
   g==;
IronPort-SDR: a109tpcif6S4TpUrKEeLn858Vu4gFwZuagnhKQiRnYEOMJGaHTRhiBreO1vAXjo9+rjwxfaOKV
 aerhPSqulFS44LTdg6QRKDDJiYcc5hs0LUY3ZfRx72MNGJu45F2c80HOWDfGKxA4N39ricmfD2
 MSpobQ38B4chHjCTn2VcfFUt+CeouH2DPz53Bpec0I42YbnEuj1fB1IEVWOSiZ39LbOrJ6QpOT
 sMXxaB4iKHEjlrRX3G4ztpgCdVilXuw+hiOiEGOxWT0cXmFwvAElCJEOdkr5Zl/pZSQMyPuIXW
 7gw=
X-IronPort-AV: E=Sophos;i="5.64,332,1559491200"; 
   d="scan'208";a="116243208"
Received: from mail-by2nam03lp2058.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.58])
  by ob1.hgst.iphmx.com with ESMTP; 01 Aug 2019 07:55:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZN7KeAjqox8RoSbyvP83vLvd4pO0ZkM7xXzO55Z4dJdJfIyHwqVNUnay7uilsIbTB91tcc/4Pguzkvovx9ewLGpFIO3otlPk5BuVlyedOftDuSW+SBcXmpLGK7+NHq1PZ1nTMGC0QT0VNum3mSqXDbAAHGnOXwERDnu05eSqUQ4dpoHP2hJQV0IALFnj4Z7YWR9VE1SQm1nAV6uJ1CgD4A0HOGUEICN6LrgdpZCiJW/JOpbrgfwjMGVxU2jRdAJ8qSfRo72YLAu39zOUmTbPYgUy7VJC0rmj6adHrNCTTRrZg73mtxd6wUqAS1vvQKD90cz/uEYt+byvxZTWrwltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydz6E4wcN7wL7L0T2PZtfOiCYnVZA3/2vo3DVEDA5lM=;
 b=O9ghr5WGT4oBJUp69aZSNdGg9ZxMi9nMVDZPTMvMhEF3ffbd0qUkuQ/lwL2Asqij6GkfPIbK/gJzcHhbGctJ5dMZ/+vJh36dWwxz3QTg7+AAW7nPXeIssAI8XJXde44SZTLzFtaPl/ls5Ev7723BVAck7ZfBcNYBRZjhrHRQ0yNdeJz2ZSA3Me87lSRYM824CKYc5zS3aVZU8lHvQBsyagYdQe9X+/oSjgBq2np5mIj+9lrWkrBf4yHD+QmoFhJ6h7Me8YttUc67Py3hJlWuSihS2Nd0IVBMD7q6WVZs0qiJ5BYucvwoqtMBy8X88EEE9sRo93hfBqppOOu5eLZ7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ydz6E4wcN7wL7L0T2PZtfOiCYnVZA3/2vo3DVEDA5lM=;
 b=jpq/qccIhdfZu/mLKEB1MMMqEzBW84fP9sdPqlmvDmrhRki+86QRsmH47xs+MrjETWY0LM2OBW/gav+jmuiwP+i0+aAFRm7SnM3mm27DXkpiCtVMDrP8Qb3SnVNSbBA8Qi/9xO2PkbRuy2qOT0Mhj1j/XFqQltnRImay9gJ2gKo=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4230.namprd04.prod.outlook.com (20.176.250.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Wed, 31 Jul 2019 23:55:35 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::8025:ccea:a0e6:9078%5]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 23:55:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v3 4/4] nvme-core: Fix extra device_put() call on error
 path
Thread-Topic: [PATCH v3 4/4] nvme-core: Fix extra device_put() call on error
 path
Thread-Index: AQHVR/i+1fhdZr0kF06eWlqDWEoVqQ==
Date:   Wed, 31 Jul 2019 23:55:35 +0000
Message-ID: <BYAPR04MB5749D1E8D9D093CDEEC7108486DF0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190731233534.4841-1-logang@deltatee.com>
 <20190731233534.4841-5-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c20dbf36-e33a-4fb4-81cf-08d7161294b3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4230;
x-ms-traffictypediagnostic: BYAPR04MB4230:
x-microsoft-antispam-prvs: <BYAPR04MB4230976DC3AA77C6C377293186DF0@BYAPR04MB4230.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(199004)(189003)(25786009)(256004)(186003)(86362001)(26005)(14444005)(486006)(6246003)(6506007)(53546011)(2201001)(2501003)(66066001)(74316002)(305945005)(68736007)(81166006)(3846002)(102836004)(446003)(76176011)(99286004)(476003)(33656002)(8936002)(7696005)(53936002)(66556008)(2906002)(81156014)(4326008)(8676002)(6116002)(6436002)(229853002)(9686003)(66476007)(71190400001)(5660300002)(76116006)(66946007)(71200400001)(7736002)(52536014)(478600001)(54906003)(55016002)(14454004)(110136005)(316002)(64756008)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4230;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wdt6hhaX21fdWsBoicmXCzL1FU8lYFTCe8ntMITT/VrE/6wDoAxY04PbDHXXOD8IsmRVq0oxbQO1TIzEo9jz1fX1j/aALW7yXeteG9bgp6AIOHKm225wmW3WPtTPAb6dSUX88XaQyxPaOkvS+8zYG9OW5VYq69kZbnGnURpkIzkp2En/es2gC/P/EuVi4PYPPrQrjX6IVB43jhEHlUwKDKqqKfU1Wa4Yg7lJsez5NEhHieGpuvC7kw8FAcyG3IUKUzVYfpUZVBCPqI7zkRLi7QyEDJWlXzFHSk7eaf5eZKSOqQP1SWtP/w5dXHUOb+HB2kR+onfyT1ha6+xt36xusXPg4bUSJ75MnnalP7Pjfly4FTQSJsw8njnhkn0xluAE7/2gMA/ayfIlwPKNQAlry0RGaMd5cX+YjeguJ/Z/u7M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20dbf36-e33a-4fb4-81cf-08d7161294b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 23:55:35.4699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 07/31/2019 04:36 PM, Logan Gunthorpe wrote:=0A=
> In the error path for nvme_init_subsystem(), nvme_put_subsystem()=0A=
> will call device_put(), but it will get called again after the=0A=
> mutex_unlock().=0A=
>=0A=
> The device_put() only needs to be called if device_add() fails.=0A=
>=0A=
> This bug caused a KASAN use-after-free error when adding and=0A=
> removing subsytems in a loop:=0A=
>=0A=
>    BUG: KASAN: use-after-free in device_del+0x8d9/0x9a0=0A=
>    Read of size 8 at addr ffff8883cdaf7120 by task multipathd/329=0A=
>=0A=
>    CPU: 0 PID: 329 Comm: multipathd Not tainted 5.2.0-rc6-vmlocalyes-0001=
9-g70a2b39005fd-dirty #314=0A=
>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 0=
4/01/2014=0A=
>    Call Trace:=0A=
>     dump_stack+0x7b/0xb5=0A=
>     print_address_description+0x6f/0x280=0A=
>     ? device_del+0x8d9/0x9a0=0A=
>     __kasan_report+0x148/0x199=0A=
>     ? device_del+0x8d9/0x9a0=0A=
>     ? class_release+0x100/0x130=0A=
>     ? device_del+0x8d9/0x9a0=0A=
>     kasan_report+0x12/0x20=0A=
>     __asan_report_load8_noabort+0x14/0x20=0A=
>     device_del+0x8d9/0x9a0=0A=
>     ? device_platform_notify+0x70/0x70=0A=
>     nvme_destroy_subsystem+0xf9/0x150=0A=
>     nvme_free_ctrl+0x280/0x3a0=0A=
>     device_release+0x72/0x1d0=0A=
>     kobject_put+0x144/0x410=0A=
>     put_device+0x13/0x20=0A=
>     nvme_free_ns+0xc4/0x100=0A=
>     nvme_release+0xb3/0xe0=0A=
>     __blkdev_put+0x549/0x6e0=0A=
>     ? kasan_check_write+0x14/0x20=0A=
>     ? bd_set_size+0xb0/0xb0=0A=
>     ? kasan_check_write+0x14/0x20=0A=
>     ? mutex_lock+0x8f/0xe0=0A=
>     ? __mutex_lock_slowpath+0x20/0x20=0A=
>     ? locks_remove_file+0x239/0x370=0A=
>     blkdev_put+0x72/0x2c0=0A=
>     blkdev_close+0x8d/0xd0=0A=
>     __fput+0x256/0x770=0A=
>     ? _raw_read_lock_irq+0x40/0x40=0A=
>     ____fput+0xe/0x10=0A=
>     task_work_run+0x10c/0x180=0A=
>     ? filp_close+0xf7/0x140=0A=
>     exit_to_usermode_loop+0x151/0x170=0A=
>     do_syscall_64+0x240/0x2e0=0A=
>     ? prepare_exit_to_usermode+0xd5/0x190=0A=
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>    RIP: 0033:0x7f5a79af05d7=0A=
>    Code: 00 00 0f 05 48 3d 00 f0 ff ff 77 3f c3 66 0f 1f 44 00 00 53 89 f=
b 48 83 ec 10 e8 c4 fb ff ff 89 df 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0=
 ff ff 77 2b 89 d7 89 44 24 0c e8 06 fc ff ff 8b 44 24=0A=
>    RSP: 002b:00007f5a7799c810 EFLAGS: 00000293 ORIG_RAX: 0000000000000003=
=0A=
>    RAX: 0000000000000000 RBX: 0000000000000008 RCX: 00007f5a79af05d7=0A=
>    RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000008=0A=
>    RBP: 00007f5a58000f98 R08: 0000000000000002 R09: 00007f5a7935ee80=0A=
>    R10: 0000000000000000 R11: 0000000000000293 R12: 000055e432447240=0A=
>    R13: 0000000000000000 R14: 0000000000000001 R15: 000055e4324a9cf0=0A=
>=0A=
>    Allocated by task 1236:=0A=
>     save_stack+0x21/0x80=0A=
>     __kasan_kmalloc.constprop.6+0xab/0xe0=0A=
>     kasan_kmalloc+0x9/0x10=0A=
>     kmem_cache_alloc_trace+0x102/0x210=0A=
>     nvme_init_identify+0x13c3/0x3820=0A=
>     nvme_loop_configure_admin_queue+0x4fa/0x5e0=0A=
>     nvme_loop_create_ctrl+0x469/0xf40=0A=
>     nvmf_dev_write+0x19a3/0x21ab=0A=
>     __vfs_write+0x66/0x120=0A=
>     vfs_write+0x154/0x490=0A=
>     ksys_write+0x104/0x240=0A=
>     __x64_sys_write+0x73/0xb0=0A=
>     do_syscall_64+0xa5/0x2e0=0A=
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>=0A=
>    Freed by task 329:=0A=
>     save_stack+0x21/0x80=0A=
>     __kasan_slab_free+0x129/0x190=0A=
>     kasan_slab_free+0xe/0x10=0A=
>     kfree+0xa7/0x200=0A=
>     nvme_release_subsystem+0x49/0x60=0A=
>     device_release+0x72/0x1d0=0A=
>     kobject_put+0x144/0x410=0A=
>     put_device+0x13/0x20=0A=
>     klist_class_dev_put+0x31/0x40=0A=
>     klist_put+0x8f/0xf0=0A=
>     klist_del+0xe/0x10=0A=
>     device_del+0x3a7/0x9a0=0A=
>     nvme_destroy_subsystem+0xf9/0x150=0A=
>     nvme_free_ctrl+0x280/0x3a0=0A=
>     device_release+0x72/0x1d0=0A=
>     kobject_put+0x144/0x410=0A=
>     put_device+0x13/0x20=0A=
>     nvme_free_ns+0xc4/0x100=0A=
>     nvme_release+0xb3/0xe0=0A=
>     __blkdev_put+0x549/0x6e0=0A=
>     blkdev_put+0x72/0x2c0=0A=
>     blkdev_close+0x8d/0xd0=0A=
>     __fput+0x256/0x770=0A=
>     ____fput+0xe/0x10=0A=
>     task_work_run+0x10c/0x180=0A=
>     exit_to_usermode_loop+0x151/0x170=0A=
>     do_syscall_64+0x240/0x2e0=0A=
>     entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
>=0A=
> Fixes: 32fd90c40768 ("nvme: change locking for the per-subsystem controll=
er list")=0A=
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>=0A=
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>=0A=
> ---=0A=
>   drivers/nvme/host/core.c | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index 80c7a7ee240b..e35f16b60fc9 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -2488,6 +2488,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)=0A=
>   		if (ret) {=0A=
>   			dev_err(ctrl->device,=0A=
>   				"failed to register subsystem device.\n");=0A=
> +			put_device(&subsys->dev);=0A=
>   			goto out_unlock;=0A=
>   		}=0A=
>   		ida_init(&subsys->ns_ida);=0A=
> @@ -2510,7 +2511,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ct=
rl, struct nvme_id_ctrl *id)=0A=
>   	nvme_put_subsystem(subsys);=0A=
>   out_unlock:=0A=
>   	mutex_unlock(&nvme_subsystems_lock);=0A=
> -	put_device(&subsys->dev);=0A=
>   	return ret;=0A=
>   }=0A=
>=0A=
>=0A=
=0A=
