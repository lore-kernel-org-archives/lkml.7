Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330E0C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC4112073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iSzUhv0i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfDQIVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:21:35 -0400
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:17028
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfDQIVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7flNenyGwtLACmtcjP8Dob0o9oLVHCqq1BQQog2XAdY=;
 b=iSzUhv0iqI0JLRxd2bXD2R7dm4CcPGRRJLLHXmoJ5L6dbqo7XzP56A3ud22p9HYpTpONGFzo0e/zWchcOVTVCsXgvoY4NA8IQIeed8efvjM/UyLqr2dlOxmJFF1v0OfCeG80GLKn65R5bGiL85ThhYRBRrwVftVWiYbd7HE7ZnU=
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com (10.168.65.10) by
 VI1PR0401MB2431.eurprd04.prod.outlook.com (10.169.134.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.19; Wed, 17 Apr 2019 08:21:30 +0000
Received: from VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7]) by VI1PR0401MB2496.eurprd04.prod.outlook.com
 ([fe80::5e3:7122:7d0e:7fb7%3]) with mapi id 15.20.1792.018; Wed, 17 Apr 2019
 08:21:30 +0000
From:   Pankaj Bansal <pankaj.bansal@nxp.com>
To:     Pankaj Bansal <pankaj.bansal@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        Peter Rosin <peda@axentia.se>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Topic: [PATCH v6 2/2] drivers: mux: Add Generic regmap bitfield-based
 multiplexer in mmio-mux
Thread-Index: AQHUz272SCrygd7YhkGtMFabrgI/qqZATUdQ
Date:   Wed, 17 Apr 2019 08:21:30 +0000
Message-ID: <VI1PR0401MB249650C901662DC8F6B51B9EF1250@VI1PR0401MB2496.eurprd04.prod.outlook.com>
References: <20190228193206.30594-1-pankaj.bansal@nxp.com>
 <20190228193206.30594-2-pankaj.bansal@nxp.com>
In-Reply-To: <20190228193206.30594-2-pankaj.bansal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.bansal@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba11812f-8b30-4311-773a-08d6c30db1ef
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0401MB2431;
x-ms-traffictypediagnostic: VI1PR0401MB2431:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0401MB24310A366DCDC58E75DB735CF1250@VI1PR0401MB2431.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(13464003)(305945005)(66066001)(7736002)(256004)(7696005)(68736007)(4326008)(99286004)(76176011)(102836004)(25786009)(2906002)(6246003)(86362001)(229853002)(53546011)(6506007)(74316002)(478600001)(8936002)(71200400001)(106356001)(81156014)(486006)(53936002)(44832011)(52536014)(6436002)(71190400001)(8676002)(186003)(110136005)(105586002)(26005)(6116002)(3846002)(33656002)(55016002)(81166006)(966005)(316002)(97736004)(6306002)(476003)(14454004)(5660300002)(9686003)(446003)(11346002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2431;H:VI1PR0401MB2496.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UgEBpJazGhBOcgrNma/Cl6/xq5OlCuB/lr6NkhalDvJn8jTOJCXQQcaySb4kHpGwO3vvKDDLHQ6AYal7zsLXBqLFnTYkFg5J1Hw0YcJ36uJde66167B04hHFf7ujVv5rVxCTJngf39YHld5f1WJo5+sGWuVZ7suDuVzMShF1K303IPfGzrk6ASF7wIE8pqnNIaP5/7OTLMs3f00n86zDaLIosr6b/1OCxUkzdTSlo4dZQ1qhYu+IAFXs7KGkn2gD/IH9PAiJyNU7JQ8Owfl+BCZZ7YA5BoB7aqQlb1tCa4mEiSPJrgzqu7cvnb6A/rgvVRlZPVgnGbYcqeSACqAT8Kdm6W1z09e7kyf+7ruxpRTf2V/s2FV5tEOYFc7Z/sWLba1BzAm6EsAKrn371UpSnA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba11812f-8b30-4311-773a-08d6c30db1ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 08:21:30.5675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Peter,

Have these changes been applied in any linux branch? I did not see these ch=
anges in https://elixir.bootlin.com/linux/v5.1-rc5/source/drivers/mux/mmio.=
c#L46

Regards,
Pankaj Bansal

> -----Original Message-----
> From: Pankaj Bansal [mailto:pankaj.bansal@nxp.com]
> Sent: Thursday, 28 February, 2019 07:38 PM
> To: Leo Li <leoyang.li@nxp.com>; Peter Rosin <peda@axentia.se>
> Cc: Pankaj Bansal <pankaj.bansal@nxp.com>; linux-kernel@vger.kernel.org
> Subject: [PATCH v6 2/2] drivers: mux: Add Generic regmap bitfield-based
> multiplexer in mmio-mux
>=20
> Generic register bitfield-based multiplexer that controls the multiplexer=
 producer
> defined under a parent node.
> The driver corresponding to parent node provides register read/write
> capabilities.
>=20
> Signed-off-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> ---
>=20
> Notes:
>     V6:
>     - No Change
>     V5:
>     - No Change
>     V4:
>     - As per Peter's suggestion fixup the NULL from dev_get_regmap as ear=
ly as
>       possible using ternary operator.
>     V3:
>     - Added the patch in series with device tree binding patch
>     - Added the NULL return handling for regmap
>     V2:
>     - removed seperate driver regmap.c and added the regmap function in m=
mio.c
>       based on compatible field, the syscon or regmap function would be c=
alled
>     - Modified the KConfig as per Peter's comments
>=20
>  drivers/mux/Kconfig | 12 ++++++------
>  drivers/mux/mmio.c  |  6 +++++-
>  2 files changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig index
> 7659d6c5f718..e5c571fd232c 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -46,14 +46,14 @@ config MUX_GPIO
>  	  be called mux-gpio.
>=20
>  config MUX_MMIO
> -	tristate "MMIO register bitfield-controlled Multiplexer"
> -	depends on (OF && MFD_SYSCON) || COMPILE_TEST
> +	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
> +	depends on OF || COMPILE_TEST
>  	help
> -	  MMIO register bitfield-controlled Multiplexer controller.
> +	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
>=20
> -	  The driver builds multiplexer controllers for bitfields in a syscon
> -	  register. For N bit wide bitfields, there will be 2^N possible
> -	  multiplexer states.
> +	  The driver builds multiplexer controllers for bitfields in either
> +	  a syscon register or a driver regmap register. For N bit wide
> +	  bitfields, there will be 2^N possible multiplexer states.
>=20
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-mmio.
> diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c index
> 935ac44aa209..44a7a0e885b8 100644
> --- a/drivers/mux/mmio.c
> +++ b/drivers/mux/mmio.c
> @@ -28,6 +28,7 @@ static const struct mux_control_ops mux_mmio_ops =3D {
>=20
>  static const struct of_device_id mux_mmio_dt_ids[] =3D {
>  	{ .compatible =3D "mmio-mux", },
> +	{ .compatible =3D "reg-mux", },
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, mux_mmio_dt_ids); @@ -43,7 +44,10 @@ static
> int mux_mmio_probe(struct platform_device *pdev)
>  	int ret;
>  	int i;
>=20
> -	regmap =3D syscon_node_to_regmap(np->parent);
> +	if (of_device_is_compatible(np, "mmio-mux"))
> +		regmap =3D syscon_node_to_regmap(np->parent);
> +	else
> +		regmap =3D dev_get_regmap(dev->parent, NULL) ?: ERR_PTR(-
> ENODEV);
>  	if (IS_ERR(regmap)) {
>  		ret =3D PTR_ERR(regmap);
>  		dev_err(dev, "failed to get regmap: %d\n", ret);
> --
> 2.17.1

