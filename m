Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FFC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E69D2184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 04:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SDFvafV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfCTE5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 00:57:05 -0400
Received: from mail-eopbgr140079.outbound.protection.outlook.com ([40.107.14.79]:23170
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725930AbfCTE5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 00:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVfFQ+quVfsbdEBBO33oYVZWjSR4tNae783CY/e0iXs=;
 b=SDFvafV3QpDIFhk5EIwiGuIJDPngGw8m6yaGUixM7DVXdXlxb2z7VlIm2QIwGYPND8/TenzQz1xnMV4LGxLPOF57luqPbEYrLX9pLRP9FMfnNSz8+rzVfLmPKjoBYdiueAOeQlx7qhMPE5wSFuHAI8X2nH3h5AzL32lCV+chDA8=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4083.eurprd04.prod.outlook.com (52.134.125.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 20 Mar 2019 04:57:00 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.015; Wed, 20 Mar 2019
 04:57:00 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when imx_soc_device_init
 fail
Thread-Topic: [PATCH 2/2] ARM: imx: mach-imx7ulp: warn when
 imx_soc_device_init fail
Thread-Index: AQHU2Xv6rc4iD5C/cU2/vwnpPpurWaYMfhWQgAAseACAAAtq8IAGNZeAgAEAaTA=
Date:   Wed, 20 Mar 2019 04:57:00 +0000
Message-ID: <AM0PR04MB421136D0720C912390DF100080410@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <20190313091757.16410-2-peng.fan@nxp.com>
 <AM0PR04MB4211FE93F235498D795C2FED80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB44817A913A33ECEC6D572D7E88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <AM0PR04MB42118397D4F1F1DD2F14E7FB80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB44819E0CEE2EFD6F52CA695388400@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44819E0CEE2EFD6F52CA695388400@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73edf261-c9c0-4f43-d799-08d6acf07ca5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4083;
x-ms-traffictypediagnostic: AM0PR04MB4083:
x-microsoft-antispam-prvs: <AM0PR04MB408391FA2578A3AA8A77AE8880410@AM0PR04MB4083.eurprd04.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(199004)(189003)(14444005)(53936002)(186003)(93886005)(97736004)(99286004)(110136005)(74316002)(68736007)(2906002)(66066001)(71200400001)(305945005)(52536014)(71190400001)(6246003)(4326008)(7696005)(105586002)(2201001)(8676002)(44832011)(6436002)(76176011)(11346002)(26005)(8936002)(6116002)(81166006)(3846002)(9686003)(476003)(446003)(106356001)(86362001)(5660300002)(316002)(478600001)(55016002)(25786009)(81156014)(14454004)(486006)(256004)(6506007)(229853002)(102836004)(2501003)(7736002)(33656002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4083;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yBHEiW8zy8rfVi164gkegPww2rD+PH9HDQM6sc3m9pBUD9dNvmuMwmvQdX7HXW6OJArZVMJ/VJKR4fPTepsGxd6VW0F3hZKYGJYhMZc58dAy1UVzWIDv9BCgADgTwATls9epYi9KF2p8HIj2L1nBtH8mrqyhEkDJHnCgmN18LvAziGXqebWItf0wzBcEKy3xcHKyrKpsEOJpjbSnSJde34gQNf6mbLAD3z630BzLB6zt6nCLEI65qH0QlUv7hWkKGijC5cYWUs4QlF0njtbIBhUa/NvA5IyD5JQpSf5N166YoX+KfOtwBLbCRthzTzZEyaclheM2Kh9+2QsUVcPUdk+bEuh92Co6jbVBkHvOUKsSOlezc4nRvNwEYJQwHqGCcpnQMetHQtscZgMQpYXzRaDO5Roc4dFCdCDmM+pz7d0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73edf261-c9c0-4f43-d799-08d6acf07ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 04:57:00.1734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4083
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Peng Fan
>
> > > > > Follow other i.MX6/7 machince code to check return value of
> > > > > imx_soc_device_init and warn when fail.
> > > > >
> > > > > Also drop of_platform_default_populate, because
> > > > > "arch_initcall_sync(of_platform_default_populate_init);" could
> > > > > be used to populate the device tree.
> > > > >
> > > >
> > > > This could be in separate patch.
> > >
> > > I'll do it in v2 after we agree the change in the first patch.
> > >
> >
> > I think imx7ulp does not have the issue in patch 1.
>=20
> Missed to reply you.
> So do you agree to split this patch into two patches ? or leave the code =
as it is?
>=20

A bit more thinking, i wonder that warning may not be quite necessary
for a new patch.=20
So probably leave as it is unless we have more strong reasons.
Sorry about that.

Regards
Dong Aisheng

> The first is follow other i.mx6/7 to check return value of imx_soc_device=
_init.
> The second is drop the call to of_platform_default_populate.
>=20
> Thanks,
> Peng
>=20
> >
> > Regards
> > Dong Aisheng
> >
> > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > ---
> > > > >  arch/arm/mach-imx/mach-imx7ulp.c | 7 ++++++-
> > > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-imx/mach-imx7ulp.c
> > > > > b/arch/arm/mach-imx/mach-imx7ulp.c
> > > > > index 11ac71aaf965..6d823f05d9aa 100644
> > > > > --- a/arch/arm/mach-imx/mach-imx7ulp.c
> > > > > +++ b/arch/arm/mach-imx/mach-imx7ulp.c
> > > > > @@ -53,11 +53,16 @@ static void __init
> > > > > imx7ulp_set_revision(void)
> > > > >
> > > > >  static void __init imx7ulp_init_machine(void)  {
> > > > > +	struct device *soc_dev;
> > > > > +
> > > > > +	soc_dev =3D imx_soc_device_init();
> > > > > +	if (soc_dev =3D=3D NULL)
> > > > > +		pr_warn("failed to initialize soc device\n");
> > > > > +
> > > >
> > > > Should this be under set revision?
> > >
> > > Just follow other i.MX6/7 platforms practice, I could move this
> > > under set revision in v2 if you prefer.
> > >
> > > Thanks,
> > > Peng.
> > >
> > > >
> > > > Regards
> > > > Dong Aisheng
> > > >
> > > > >  	imx7ulp_pm_init();
> > > > >
> > > > >  	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
> > > > >  	imx7ulp_set_revision();
> > > > > -	of_platform_default_populate(NULL, NULL, imx_soc_device_init())=
;
> > > > >  }
> > > > >
> > > > >  static const char *const imx7ulp_dt_compat[] __initconst =3D {
> > > > > --
> > > > > 2.16.4

