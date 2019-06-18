Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73ABC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632AA20665
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 06:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="s6U4V5I8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfFRGtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 02:49:14 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:14340
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbfFRGtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 02:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg11UFsuG8yLgVKAb2iXZ6Brtbhmfy1eccVVMXVHDCs=;
 b=s6U4V5I8bfnzzLIGfz5NbozkSc6px9SzEBmlkGR6cgG1YRLyJKGgUy29JQvSqP1X5Cmhzja3YhLbvZee6BAlGt0IKBbZeBVGcjZQ0t4TyEwI9z7bP2N3EsURbYqtCwV7GQ81H01VWvlUuaadODjkZkmnrcLkSF6r1N8EKJYVN/U=
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com (10.255.159.31) by
 VE1PR08MB5071.eurprd08.prod.outlook.com (20.179.29.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Tue, 18 Jun 2019 05:24:46 +0000
Received: from VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358]) by VE1PR08MB5006.eurprd08.prod.outlook.com
 ([fe80::206b:5cf6:97e:1358%7]) with mapi id 15.20.1987.014; Tue, 18 Jun 2019
 05:24:46 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
CC:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [v2] drm/komeda: Make Komeda interrupts shareable
Thread-Topic: [v2] drm/komeda: Make Komeda interrupts shareable
Thread-Index: AQHVJZYkGje/vtT4XU6VNPIgpehS3Q==
Date:   Tue, 18 Jun 2019 05:24:46 +0000
Message-ID: <20190618052439.GA3638@james-ThinkStation-P300>
References: <20190613151257.32297-1-ayan.halder@arm.com>
In-Reply-To: <20190613151257.32297-1-ayan.halder@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
x-originating-ip: [113.29.88.7]
x-clientproxiedby: HK0PR03CA0082.apcprd03.prod.outlook.com
 (2603:1096:203:72::22) To VE1PR08MB5006.eurprd08.prod.outlook.com
 (2603:10a6:803:113::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04387cfc-5d06-45ac-b66a-08d6f3ad46cc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VE1PR08MB5071;
x-ms-traffictypediagnostic: VE1PR08MB5071:
nodisclaimer: True
x-microsoft-antispam-prvs: <VE1PR08MB5071E1C3C230A6043E06C21DB3EA0@VE1PR08MB5071.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:104;
x-forefront-prvs: 007271867D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(136003)(366004)(346002)(396003)(376002)(199004)(189003)(66066001)(71200400001)(9686003)(6636002)(71190400001)(5660300002)(6512007)(52116002)(229853002)(256004)(7736002)(11346002)(6436002)(4326008)(5024004)(99286004)(66446008)(55236004)(102836004)(64756008)(14454004)(66946007)(14444005)(6506007)(76176011)(66476007)(305945005)(1076003)(66556008)(68736007)(81166006)(476003)(54906003)(2906002)(8676002)(81156014)(73956011)(386003)(6486002)(478600001)(26005)(86362001)(186003)(53936002)(486006)(6862004)(446003)(3846002)(58126008)(33656002)(316002)(25786009)(6116002)(8936002)(33716001)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR08MB5071;H:VE1PR08MB5006.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V4BnsgEQnxRnEl6z0SjII9ddPoYF07BJX3FaWMhOgsh6dSyqqarKXgR1JevWgjJPUd4fyAzrs64FRFVJoOMJqosQsN9Hdh0+7kWIkdbjqsyXVN0HH8WHxLY0JMhaM7hZbnbX7kYB9EOk9wh9fyVgftdkJi30k73/5x+UDMhdE1bg1NDWnKL69GdqqUoDfK9uy9mtDXkSihz44UPQmd73R46RoLPLQfmEePBuPZHimbWMy0lFJY524VhZJNBioG36SzexGzBtqYUG+5tSaLxK8DTkr1AWDFrnEe61XLr2VucGIlw8N0x1xFt14qzdlv9PlIr3s/tntXxU3OP6eVCvrgBSHaw0X5Z3UJMHiydEaLKezhPG+XFgSPbuTFKkPvr1LG9KB2QotCmI+JXUB1tTYN71dbgkdgBJlRKOgGpX5MY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F05A4150F9974B4CB2FCB81ED970D441@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04387cfc-5d06-45ac-b66a-08d6f3ad46cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2019 05:24:46.5055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: james.qian.wang@arm.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 03:13:10PM +0000, Ayan Halder wrote:
> Komeda interrupts may be shared with other hardware blocks.
> One needs to use devm_request_irq() with IRQF_SHARED to create a shared
>  interrupt handler.
> As a result of not using drm_irq_install() api, one needs to set
> "(struct drm_device *)->irq_enabled =3D true/false" to enable/disable
> vblank interrupts.
>=20
> Changes from v1:-
> 1. Squashed the following two patches into one (as the second patch is a
> consequence of the first one):-
>    drm/komeda: Avoid using DRIVER_IRQ_SHARED
>    drm/komeda: Enable/Disable vblank interrupts
> 2. Fixed the commit message (as pointed by Daniel Vetter)
> 3. Removed calls to 'drm_irq_uninstall()' as we are no longer using
> drm_irq_install()
> 4. Removed the struct member 'komeda_kms_driver.irq_handler' as it is not
> used anywhere.
>=20
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> ---
>  drivers/gpu/drm/arm/display/komeda/komeda_kms.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> --=20
> 2.21.0
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>=20

looks good to me.

Thank you Ayan.

Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gp=
u/drm/arm/display/komeda/komeda_kms.c
> index 86f6542afb40..bb2bffc0e022 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
> @@ -58,7 +58,6 @@ static struct drm_driver komeda_kms_driver =3D {
>  	.driver_features =3D DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
>  			   DRIVER_PRIME | DRIVER_HAVE_IRQ,
>  	.lastclose			=3D drm_fb_helper_lastclose,
> -	.irq_handler			=3D komeda_kms_irq_handler,
>  	.gem_free_object_unlocked	=3D drm_gem_cma_free_object,
>  	.gem_vm_ops			=3D &drm_gem_cma_vm_ops,
>  	.dumb_create			=3D komeda_gem_cma_dumb_create,
> @@ -194,23 +193,26 @@ struct komeda_kms_dev *komeda_kms_attach(struct kom=
eda_dev *mdev)
> =20
>  	drm_mode_config_reset(drm);
> =20
> -	err =3D drm_irq_install(drm, mdev->irq);
> +	err =3D devm_request_irq(drm->dev, mdev->irq,
> +			       komeda_kms_irq_handler, IRQF_SHARED,
> +			       drm->driver->name, drm);
>  	if (err)
>  		goto cleanup_mode_config;
> =20
>  	err =3D mdev->funcs->enable_irq(mdev);
>  	if (err)
> -		goto uninstall_irq;
> +		goto cleanup_mode_config;
> +
> +	drm->irq_enabled =3D true;
> =20
>  	err =3D drm_dev_register(drm, 0);
>  	if (err)
> -		goto uninstall_irq;
> +		goto cleanup_mode_config;
> =20
>  	return kms;
> =20
> -uninstall_irq:
> -	drm_irq_uninstall(drm);
>  cleanup_mode_config:
> +	drm->irq_enabled =3D false;
>  	drm_mode_config_cleanup(drm);
>  	komeda_kms_cleanup_private_objs(kms);
>  free_kms:
> @@ -223,9 +225,9 @@ void komeda_kms_detach(struct komeda_kms_dev *kms)
>  	struct drm_device *drm =3D &kms->base;
>  	struct komeda_dev *mdev =3D drm->dev_private;
> =20
> +	drm->irq_enabled =3D false;
>  	mdev->funcs->disable_irq(mdev);
>  	drm_dev_unregister(drm);
> -	drm_irq_uninstall(drm);
>  	component_unbind_all(mdev->dev, drm);
>  	komeda_kms_cleanup_private_objs(kms);
>  	drm_mode_config_cleanup(drm);
