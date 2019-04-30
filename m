Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC339C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EAD2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="P5g0wcUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfD3HfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:35:20 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:7758
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726145AbfD3HfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vbjdh2AfeHkuvuS2ySYHDZD5qcbaXKW2Tm84wUv7+E4=;
 b=P5g0wcUhqbRTgDkZW2C2Es2aWCbOTVe0BEQutEawh2NKnupRDEgmAOEBCdS+Zs7W8gf+zaPvX+skAi6C6spblKeeRMqHvLKPROPYq2al3X28c7VFAXVmkNOPNdMostDrXEZCaied2CstyPWbvv3vNBueQivUermFjffVITFs4cY=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB4973.eurprd08.prod.outlook.com (10.255.158.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 07:35:11 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::6841:2153:b91f:759%4]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 07:35:11 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        nd <nd@arm.com>
Subject: Re: [v1,1/2] drm/komeda: Adds SMMU support
Thread-Topic: [v1,1/2] drm/komeda: Adds SMMU support
Thread-Index: AQHU/yc+xmv2QA5efE+dpUJtxoIdaQ==
Date:   Tue, 30 Apr 2019 07:35:11 +0000
Message-ID: <20190430073505.GA9516@james-ThinkStation-P300>
References: <1556605118-22700-2-git-send-email-lowry.li@arm.com>
In-Reply-To: <1556605118-22700-2-git-send-email-lowry.li@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK2PR0302CA0016.apcprd03.prod.outlook.com
 (2603:1096:202::26) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d83dda2-8fff-41e7-a3dc-08d6cd3e60a0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB4973;
x-ms-traffictypediagnostic: VE1PR08MB4973:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB4973117985943CBAC67AFB0DB33A0@VE1PR08MB4973.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:183;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(53936002)(52116002)(14454004)(76176011)(102836004)(71190400001)(71200400001)(9686003)(6512007)(81156014)(5024004)(4326008)(186003)(14444005)(6862004)(256004)(8936002)(7736002)(25786009)(305945005)(26005)(8676002)(6246003)(33656002)(81166006)(66066001)(6636002)(2906002)(33716001)(66446008)(11346002)(1076003)(5660300002)(6436002)(64756008)(3846002)(316002)(66556008)(66476007)(386003)(6116002)(86362001)(486006)(446003)(66946007)(476003)(54906003)(68736007)(6486002)(6506007)(478600001)(99286004)(97736004)(229853002)(55236004)(73956011)(58126008)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB4973;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VqB5iF2l4N69VvhOn0bP7TM1pvDLW2gJrK60L6kUSfg99EWDnKLKhdxdanRu9gRnQLTZMYeNxgzAYWPdtkYCQo9xhZ4IRc9BmmEZyhmjyDiq+OHAFIyy7UAV5f2aw/pH/lPCvG/DlxpRni2dOJyN0vUx1rIuWdGU2jMHHZunBDz4cyLlKi1NYCGixFdRuGbYHBfV/Lh9H//2Tgqc0s7fV6XHeLNDR4HP+a63T/Ge0o7V7fFGLezwEuIUSZUQPn2HDn9n+lxbrr7A47DYHecEAU4oBjHL3nzD1pzrgU+X0yVTohU4Mm4ZEjAolLHW+G+rTr6TWaLr5VxdTdvQ3SNy0YJM7ZZQIWemPnIxtEPKQ5OOFnqlf/+tDn0pKRhYTGU8a3/KuoQjvGk5DyKWilPhCdV7U4zDbzHykJ+0O4ASbdI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <57024DA22CC5984B82F94FF156699D59@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d83dda2-8fff-41e7-a3dc-08d6cd3e60a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 07:35:11.4722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB4973
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 06:19:29AM +0000, Lowry Li (Arm Technology China) w=
rote:
> Adds iommu_connect and disconnect for SMMU support, and configures
> TBU translation once SMMU has been attached to the display device.
>=20
> Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c |  5 +++
>  drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c   | 49 ++++++++++++++++=
++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c    | 17 ++++++++
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.h    |  7 ++++
>  .../drm/arm/display/komeda/komeda_framebuffer.c    |  2 +
>  .../drm/arm/display/komeda/komeda_framebuffer.h    |  2 +
>  6 files changed, 82 insertions(+)
>=20
> --=20
> 1.9.1
>=20
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/dri=
vers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index 33ca171..9065040 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -215,6 +215,8 @@ static void d71_layer_update(struct komeda_component =
*c,
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
> =20
> +	if (kfb->is_va)
> +		ctrl |=3D L_TBU_EN;
>  	malidp_write32_mask(reg, BLK_CONTROL, ctrl_mask, ctrl);
>  }
> =20
> @@ -348,6 +350,9 @@ static void d71_wb_layer_update(struct komeda_compone=
nt *c,
>  			       fb->pitches[i] & 0xFFFF);
>  	}
> =20
> +	if (kfb->is_va)
> +		ctrl |=3D LW_TBU_EN;
> +
>  	malidp_write32(reg, LAYER_FMT, kfb->format_caps->hw_id);
>  	malidp_write32(reg, BLK_IN_SIZE, HV_SIZE(st->hsize, st->vsize));
>  	malidp_write32(reg, BLK_INPUT_ID0, to_d71_input_id(&state->inputs[0]));
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/g=
pu/drm/arm/display/komeda/d71/d71_dev.c
> index 9603de9..45c98a7 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
> @@ -517,6 +517,53 @@ static void d71_init_fmt_tbl(struct komeda_dev *mdev=
)
>  	table->n_formats =3D ARRAY_SIZE(d71_format_caps_table);
>  }
> =20
> +static int d71_connect_iommu(struct komeda_dev *mdev)
> +{
> +	struct d71_dev *d71 =3D mdev->chip_data;
> +	u32 __iomem *reg =3D d71->gcu_addr;
> +	u32 check_bits =3D (d71->num_pipelines =3D=3D 2) ?
> +			 GCU_STATUS_TCS0 | GCU_STATUS_TCS1 : GCU_STATUS_TCS0;
> +	int i, ret;
> +
> +	if (!d71->integrates_tbu)
> +		return -1;
> +
> +	malidp_write32_mask(reg, BLK_CONTROL, 0x7, TBU_CONNECT_MODE);
> +
> +	ret =3D dp_wait_cond(has_bits(check_bits, malidp_read32(reg, BLK_STATUS=
)),
> +			100, 1000, 1000);
> +	if (ret <=3D 0) {
> +		DRM_ERROR("connect to TCU timeout!\n");
> +		malidp_write32_mask(reg, BLK_CONTROL, 0x7, INACTIVE_MODE);
> +		return -ETIMEDOUT;
> +	}
> +
> +	for (i =3D 0; i < d71->num_pipelines; i++)
> +		malidp_write32_mask(d71->pipes[i]->lpu_addr, LPU_TBU_CONTROL,
> +				    LPU_TBU_CTRL_TLBPEN, LPU_TBU_CTRL_TLBPEN);
> +	return 0;
> +}
> +
> +static int d71_disconnect_iommu(struct komeda_dev *mdev)
> +{
> +	struct d71_dev *d71 =3D mdev->chip_data;
> +	u32 __iomem *reg =3D d71->gcu_addr;
> +	u32 check_bits =3D (d71->num_pipelines =3D=3D 2) ?
> +			 GCU_STATUS_TCS0 | GCU_STATUS_TCS1 : GCU_STATUS_TCS0;
> +	int ret;
> +
> +	malidp_write32_mask(reg, BLK_CONTROL, 0x7, TBU_DISCONNECT_MODE);
> +
> +	ret =3D dp_wait_cond(((malidp_read32(reg, BLK_STATUS) & check_bits) =3D=
=3D 0),
> +			100, 1000, 1000);
> +	if (ret <=3D 0) {
> +		DRM_ERROR("disconnect from TCU timeout!\n");
> +		malidp_write32_mask(reg, BLK_CONTROL, 0x7, INACTIVE_MODE);
> +	}
> +
> +	return ret > 0 ? 0 : -1;
> +}
> +
>  static struct komeda_dev_funcs d71_chip_funcs =3D {
>  	.init_format_table =3D d71_init_fmt_tbl,
>  	.enum_resources	=3D d71_enum_resources,
> @@ -527,6 +574,8 @@ static void d71_init_fmt_tbl(struct komeda_dev *mdev)
>  	.on_off_vblank	=3D d71_on_off_vblank,
>  	.change_opmode	=3D d71_change_opmode,
>  	.flush		=3D d71_flush,
> +	.connect_iommu	=3D d71_connect_iommu,
> +	.disconnect_iommu =3D d71_disconnect_iommu,
>  };
> =20
>  struct komeda_dev_funcs *
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.c
> index e4e5b58..2d97c82 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -251,6 +251,18 @@ struct komeda_dev *komeda_dev_create(struct device *=
dev)
>  	dev->dma_parms =3D &mdev->dma_parms;
>  	dma_set_max_seg_size(dev, DMA_BIT_MASK(32));
> =20
> +	mdev->iommu =3D iommu_get_domain_for_dev(mdev->dev);
> +	if (!mdev->iommu)
> +		DRM_INFO("continue without IOMMU support!\n");
> +
> +	if (mdev->iommu && mdev->funcs->connect_iommu) {
> +		err =3D mdev->funcs->connect_iommu(mdev);
> +		if (err) {
> +			DRM_ERROR("connect iommu failed.\n");
> +			goto err_cleanup;
> +		}
> +	}
> +
>  	err =3D sysfs_create_group(&dev->kobj, &komeda_sysfs_attr_group);
>  	if (err) {
>  		DRM_ERROR("create sysfs group failed.\n");
> @@ -280,6 +292,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
>  	debugfs_remove_recursive(mdev->debugfs_root);
>  #endif
> =20
> +	if (mdev->iommu && mdev->funcs->disconnect_iommu)
> +		if (mdev->funcs->disconnect_iommu(mdev))
> +			DRM_ERROR("disconnect iommu failed.\n");
> +	mdev->iommu =3D NULL;
> +
>  	for (i =3D 0; i < mdev->n_pipelines; i++) {
>  		komeda_pipeline_destroy(mdev, mdev->pipelines[i]);
>  		mdev->pipelines[i] =3D NULL;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gp=
u/drm/arm/display/komeda/komeda_dev.h
> index 83ace71..dac1eda 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -92,6 +92,10 @@ struct komeda_dev_funcs {
>  	int (*enum_resources)(struct komeda_dev *mdev);
>  	/** @cleanup: call to chip to cleanup komeda_dev->chip data */
>  	void (*cleanup)(struct komeda_dev *mdev);
> +	/** @connect_iommu: Optional, connect to external iommu */
> +	int (*connect_iommu)(struct komeda_dev *mdev);
> +	/** @disconnect_iommu: Optional, disconnect to external iommu */
> +	int (*disconnect_iommu)(struct komeda_dev *mdev);
>  	/**
>  	 * @irq_handler:
>  	 *
> @@ -184,6 +188,9 @@ struct komeda_dev {
>  	 */
>  	void *chip_data;
> =20
> +	/** @iommu: iommu domain */
> +	struct iommu_domain *iommu;
> +
>  	/** @debugfs_root: root directory of komeda debugfs */
>  	struct dentry *debugfs_root;
>  };
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> index d5822a3..360ab70 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.c
> @@ -201,6 +201,8 @@ struct drm_framebuffer *
>  		goto err_cleanup;
>  	}
> =20
> +	kfb->is_va =3D mdev->iommu ? true : false;
> +
>  	return &kfb->base;
> =20
>  err_cleanup:
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/dr=
ivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> index 6cbb2f6..f4046e2 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> @@ -21,6 +21,8 @@ struct komeda_fb {
>  	 * extends drm_format_info for komeda specific information
>  	 */
>  	const struct komeda_format_caps *format_caps;
> +	/** @is_va: if smmu is enabled, it will be true */
> +	bool is_va;
>  	/** @aligned_w: aligned frame buffer width */
>  	u32 aligned_w;
>  	/** @aligned_h: aligned frame buffer height */

Looks good to me.

James.
--=20
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
