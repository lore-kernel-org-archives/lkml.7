Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21469C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFEA2183F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="IOKcT5Z+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfF0C5g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:57:36 -0400
Received: from mail-eopbgr40042.outbound.protection.outlook.com ([40.107.4.42]:17063
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726658AbfF0C5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:57:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=tOhWnQGUggjc0NrH4Cynrk2iUY0ZDWTRFqnALJYxpFLExukBn7AUkzvdoma8a+MIBJk1PRK/7Jw3cjGtqqi54F88ZcjcrQSbI6VMPGYuq5GQ+UXkaJM9/KwickEqbfqQh2JsC4wu0qKX5r0TaR1Y01gTqrCtAHe/EevYEDXX21U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zawpGzvPwLkyLIFLktx3aKwjXRoW8HmGzbuvKkpuV44=;
 b=AUGNoVdJSFIVYPuF9n0xg1tNKKHQ0QMxxpRG8zhCb71Yy1R3mLlhlbWtbHD1HKa+svkHGtADBP5rpfy/YL+dmWpurTyoD7UJulc9XDXISX+rIbsxPWUgWL6GaTh9KYMOCUfB66kkewbgiHQhLb8L4+xw6ZENoQ92oHBQo9d/qjM=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zawpGzvPwLkyLIFLktx3aKwjXRoW8HmGzbuvKkpuV44=;
 b=IOKcT5Z+7nKMn95QGXZ7kUlbuDxs9jl0IBpd4QUwwSMP8+yHGT9jykNynjEfjNS/DCERVWQkmGo9mCX8npniY0h7KcrgyF3g+Bq6/p2r+Gk6FVTgMeYQdcs23cgxP18U9hbVf2hDAXUq7NgAWvHB1vp+roMLfj0430MnF+FPeng=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5279.eurprd08.prod.outlook.com (20.179.31.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Thu, 27 Jun 2019 02:57:28 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::81b4:f737:4690:8605]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::81b4:f737:4690:8605%2]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 02:57:28 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH] drm/komeda: Adds register dump support for gcu, lup and
 dou
Thread-Topic: [PATCH] drm/komeda: Adds register dump support for gcu, lup and
 dou
Thread-Index: AQHVLJQNtdiaLQx0v0eTPMMNOHuPOw==
Date:   Thu, 27 Jun 2019 02:57:27 +0000
Message-ID: <20190627025720.GA18620@james-ThinkStation-P300>
References: <1561544365-23862-1-git-send-email-lowry.li@arm.com>
In-Reply-To: <1561544365-23862-1-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::21) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef777917-b4e8-499c-635b-08d6faab2f54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5279;
x-ms-traffictypediagnostic: VE1PR08MB5279:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB5279CF3B81AB9248B44F8C15B3FD0@VE1PR08MB5279.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(199004)(189003)(6636002)(11346002)(66946007)(476003)(386003)(81156014)(66476007)(68736007)(76176011)(186003)(5660300002)(71200400001)(52116002)(6246003)(6436002)(256004)(1076003)(6506007)(54906003)(3846002)(25786009)(6116002)(71190400001)(2906002)(66066001)(33716001)(305945005)(55236004)(446003)(64756008)(99286004)(8936002)(102836004)(229853002)(14454004)(26005)(6862004)(6512007)(73956011)(486006)(7736002)(86362001)(66556008)(4326008)(6486002)(316002)(9686003)(53936002)(8676002)(58126008)(33656002)(478600001)(81166006)(66446008);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5279;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bav2U7IPysDsgyWkyojKVhAiZ9yFHC82qJ+7BDoFoXpq8k+7i+6tibcqKG6hl1jpOICHg+Gu5thpx+N0ACtz9+m3O8r2tSv0umYfxdfu/RFEhmLDjpY4Qa+C+WTVJBfwAx2PB6Q0bwFKJVrnnE9LmxNx1bCI8e8WF8IhUNsgZmkyRuVjxf8LnNpLRSdQ2mLrGaE5l4b66R71BBMY4H9IzxX6NJ0AhkyFf3YqRLPXmJDnj56l5A5vH2s/AnW5X/nkL+HOPeNt/ZxDihi5VFlLd3sE25GODSpxfoA+mz2bgBOknU5yFeHII83OuTn48XaJno0ii3WOmG6d7UfZMeZDFFOsRgTHVjXpBWqek2v2fesv/zeL//ifMW0Y53b2yLVTLUW37GiOkLo+SKbqNt9v/UVME0jiBkjROa4p0BuXkJ8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5E8DE44315EBD4419F7920547458EBA1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef777917-b4e8-499c-635b-08d6faab2f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 02:57:28.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5279
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 06:20:09PM +0800, Lowry Li (Arm Technology China) w=
rote:
> Adds to support register dump on lpu and dou of pipeline and gcu on D71
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c | 86 ++++++++++++++++=
+++++-
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   | 23 +++---
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h   |  2 +
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c    |  2 +
>  4 files changed, 101 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index ecec6ce..ed3f273 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -1253,6 +1253,90 @@ int d71_probe_block(struct d71_dev *d71,
>  	return err;
>  }
> =20
> +static void d71_gcu_dump(struct d71_dev *d71, struct seq_file *sf)
> +{
> +	u32 v[5];
> +
> +	seq_printf(sf, "\n------ GCU ------\n");
> +
> +	get_values_from_reg(d71->gcu_addr, 0, 3, v);
> +	seq_printf(sf, "GLB_ARCH_ID:\t\t0x%X\n", v[0]);
> +	seq_printf(sf, "GLB_CORE_ID:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "GLB_CORE_INFO:\t\t0x%X\n", v[2]);
> +
> +	get_values_from_reg(d71->gcu_addr, 0x10, 1, v);
> +	seq_printf(sf, "GLB_IRQ_STATUS:\t\t0x%X\n", v[0]);
> +
> +	get_values_from_reg(d71->gcu_addr, 0xA0, 5, v);
> +	seq_printf(sf, "GCU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
> +	seq_printf(sf, "GCU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "GCU_IRQ_MASK:\t\t0x%X\n", v[2]);
> +	seq_printf(sf, "GCU_IRQ_STATUS:\t\t0x%X\n", v[3]);
> +	seq_printf(sf, "GCU_STATUS:\t\t0x%X\n", v[4]);
> +
> +	get_values_from_reg(d71->gcu_addr, 0xD0, 3, v);
> +	seq_printf(sf, "GCU_CONTROL:\t\t0x%X\n", v[0]);
> +	seq_printf(sf, "GCU_CONFIG_VALID0:\t0x%X\n", v[1]);
> +	seq_printf(sf, "GCU_CONFIG_VALID1:\t0x%X\n", v[2]);
> +}
> +
> +static void d71_lpu_dump(struct d71_pipeline *pipe, struct seq_file *sf)
> +{
> +	u32 v[6];
> +
> +	seq_printf(sf, "\n------ LPU%d ------\n", pipe->base.id);
> +
> +	dump_block_header(sf, pipe->lpu_addr);
> +
> +	get_values_from_reg(pipe->lpu_addr, 0xA0, 6, v);
> +	seq_printf(sf, "LPU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
> +	seq_printf(sf, "LPU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "LPU_IRQ_MASK:\t\t0x%X\n", v[2]);
> +	seq_printf(sf, "LPU_IRQ_STATUS:\t\t0x%X\n", v[3]);
> +	seq_printf(sf, "LPU_STATUS:\t\t0x%X\n", v[4]);
> +	seq_printf(sf, "LPU_TBU_STATUS:\t\t0x%X\n", v[5]);
> +
> +	get_values_from_reg(pipe->lpu_addr, 0xC0, 1, v);
> +	seq_printf(sf, "LPU_INFO:\t\t0x%X\n", v[0]);
> +
> +	get_values_from_reg(pipe->lpu_addr, 0xD0, 3, v);
> +	seq_printf(sf, "LPU_RAXI_CONTROL:\t0x%X\n", v[0]);
> +	seq_printf(sf, "LPU_WAXI_CONTROL:\t0x%X\n", v[1]);
> +	seq_printf(sf, "LPU_TBU_CONTROL:\t0x%X\n", v[2]);
> +}
> +
> +static void d71_dou_dump(struct d71_pipeline *pipe, struct seq_file *sf)
> +{
> +	u32 v[5];
> +
> +	seq_printf(sf, "\n------ DOU%d ------\n", pipe->base.id);
> +
> +	dump_block_header(sf, pipe->dou_addr);
> +
> +	get_values_from_reg(pipe->dou_addr, 0xA0, 5, v);
> +	seq_printf(sf, "DOU_IRQ_RAW_STATUS:\t0x%X\n", v[0]);
> +	seq_printf(sf, "DOU_IRQ_CLEAR:\t\t0x%X\n", v[1]);
> +	seq_printf(sf, "DOU_IRQ_MASK:\t\t0x%X\n", v[2]);
> +	seq_printf(sf, "DOU_IRQ_STATUS:\t\t0x%X\n", v[3]);
> +	seq_printf(sf, "DOU_STATUS:\t\t0x%X\n", v[4]);
> +}
> +
> +static void d71_pipeline_dump(struct komeda_pipeline *pipe, struct seq_f=
ile *sf)
> +{
> +	struct d71_pipeline *d71_pipe =3D to_d71_pipeline(pipe);
> +
> +	d71_lpu_dump(d71_pipe, sf);
> +	d71_dou_dump(d71_pipe, sf);
> +}
> +
>  const struct komeda_pipeline_funcs d71_pipeline_funcs =3D {
> -	.downscaling_clk_check =3D d71_downscaling_clk_check,
> +	.downscaling_clk_check	=3D d71_downscaling_clk_check,
> +	.dump_register		=3D d71_pipeline_dump,
>  };
> +
> +void d71_dump(struct komeda_dev *mdev, struct seq_file *sf)
> +{
> +	struct d71_dev *d71 =3D mdev->chip_data;
> +
> +	d71_gcu_dump(d71, sf);
> +}
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index caaa2b2..7e7c9e9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -561,17 +561,18 @@ static int d71_disconnect_iommu(struct komeda_dev *=
mdev)
>  }
> =20
>  static const struct komeda_dev_funcs d71_chip_funcs =3D {
> -	.init_format_table =3D d71_init_fmt_tbl,
> -	.enum_resources	=3D d71_enum_resources,
> -	.cleanup	=3D d71_cleanup,
> -	.irq_handler	=3D d71_irq_handler,
> -	.enable_irq	=3D d71_enable_irq,
> -	.disable_irq	=3D d71_disable_irq,
> -	.on_off_vblank	=3D d71_on_off_vblank,
> -	.change_opmode	=3D d71_change_opmode,
> -	.flush		=3D d71_flush,
> -	.connect_iommu	=3D d71_connect_iommu,
> -	.disconnect_iommu =3D d71_disconnect_iommu,
> +	.init_format_table	=3D d71_init_fmt_tbl,
> +	.enum_resources		=3D d71_enum_resources,
> +	.cleanup		=3D d71_cleanup,
> +	.irq_handler		=3D d71_irq_handler,
> +	.enable_irq		=3D d71_enable_irq,
> +	.disable_irq		=3D d71_disable_irq,
> +	.on_off_vblank		=3D d71_on_off_vblank,
> +	.change_opmode		=3D d71_change_opmode,
> +	.flush			=3D d71_flush,
> +	.connect_iommu		=3D d71_connect_iommu,
> +	.disconnect_iommu	=3D d71_disconnect_iommu,
> +	.dump_register		=3D d71_dump,
>  };
> =20
>  const struct komeda_dev_funcs *
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.h
> index 84f1878..c7357c2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.h
> @@ -49,4 +49,6 @@ int d71_probe_block(struct d71_dev *d71,
>  		    struct block_header *blk, u32 __iomem *reg);
>  void d71_read_block_header(u32 __iomem *reg, struct block_header *blk);
> =20
> +void d71_dump(struct komeda_dev *mdev, struct seq_file *sf);
> +
>  #endif /* !_D71_DEV_H_ */
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index 4218d6e..85b8604 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -23,6 +23,8 @@ static int komeda_register_show(struct seq_file *sf, vo=
id *x)
>  	struct komeda_dev *mdev =3D sf->private;
>  	int i;
> =20
> +	seq_printf(sf, "\n=3D=3D=3D=3D=3D=3D Komeda register dump =3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
> +
>  	if (mdev->funcs->dump_register)
>  		mdev->funcs->dump_register(mdev, sf);
> =20
> --=20
> 1.9.1
>=20

Looks good to me.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
