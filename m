Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D9BC20854
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z9jFeQ89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbfCONkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:40:09 -0400
Received: from mail-eopbgr50085.outbound.protection.outlook.com ([40.107.5.85]:25561
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727705AbfCONkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpNyWjohMCD3qmEv2KSeRfI4oSecGwph3Ca1a2o3bfY=;
 b=Z9jFeQ89IRnMjGmSJWBhqDU4ZUzJtTuYGezySzS/R0q0Xq+t1ObpNZ+oOvC1N5rNd2AT/njeZLZw9VgSBmy1dpNjBIUMOARbZzkY5P7PA3yhjWTunAEpMoyTTxIC/IFSe1oM3k+fbr/6ZjRt/NFIt+3wMjrZRJHZ1koHipSJ990=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4435.eurprd04.prod.outlook.com (52.135.150.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 13:40:04 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 13:40:04 +0000
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
Thread-Index: AQHU2Xv6rc4iD5C/cU2/vwnpPpurWaYMfhWQgAAseACAAAtq8A==
Date:   Fri, 15 Mar 2019 13:40:04 +0000
Message-ID: <AM0PR04MB42118397D4F1F1DD2F14E7FB80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313091757.16410-1-peng.fan@nxp.com>
 <20190313091757.16410-2-peng.fan@nxp.com>
 <AM0PR04MB4211FE93F235498D795C2FED80440@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <AM0PR04MB44817A913A33ECEC6D572D7E88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB44817A913A33ECEC6D572D7E88440@AM0PR04MB4481.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbfcc04d-757b-471b-1ade-08d6a94bbb14
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4435;
x-ms-traffictypediagnostic: AM0PR04MB4435:
x-microsoft-antispam-prvs: <AM0PR04MB443525A2B433E3C8999F4A1680440@AM0PR04MB4435.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(366004)(39860400002)(376002)(346002)(199004)(189003)(4326008)(71190400001)(86362001)(76176011)(6116002)(33656002)(3846002)(478600001)(7696005)(486006)(6436002)(102836004)(105586002)(106356001)(14454004)(476003)(2501003)(8676002)(74316002)(81156014)(305945005)(68736007)(7736002)(44832011)(81166006)(256004)(11346002)(93886005)(2201001)(6246003)(8936002)(2906002)(71200400001)(5660300002)(53936002)(229853002)(6506007)(110136005)(99286004)(26005)(97736004)(9686003)(316002)(186003)(66066001)(55016002)(446003)(14444005)(52536014)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4435;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VYjDwldJuMtzm6rtadKqY4T5+2aTz/lPESBmpnfPPjOrjEzx/Yb1WNGCZdr3tR0WJSBhz/d5W5JPIdk60bNS7QOEusE7tAH8x0s9MBYLHlF2S5DwLcZgotJNgwPi9/R4gkZDIkXGh4h3P7zJSmXwgzx1AKJC3KglSgh7GIt3wK4mesBDnOnmHlojFZRjtssl7Hiieco2I4lwWJ9bfaIbLb3M20OkjN7mQCIjjTN/ktqzNFlzKtO2A7vjSTQ04arfcaKfOQAq0L6DuivwcwVeYdMIQ5qWOnckrY1L1UuFJLAk1cgdJjSoRQyWOQCCr+P0zUWD2D/q3gNZXdl6hiSDeO7pn5RtV3xMO8hLsUO0ZqGn08TBtBpFGFZ4+MFxThUUQnnC23OTxHaoQyIE7S2W89CbMNLoe4Rr6s6beR0YlMo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfcc04d-757b-471b-1ade-08d6a94bbb14
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 13:40:04.5201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4435
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > Follow other i.MX6/7 machince code to check return value of
> > > imx_soc_device_init and warn when fail.
> > >
> > > Also drop of_platform_default_populate, because
> > > "arch_initcall_sync(of_platform_default_populate_init);" could be
> > > used to populate the device tree.
> > >
> >
> > This could be in separate patch.
>=20
> I'll do it in v2 after we agree the change in the first patch.
>=20

I think imx7ulp does not have the issue in patch 1.

Regards
Dong Aisheng

> >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  arch/arm/mach-imx/mach-imx7ulp.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm/mach-imx/mach-imx7ulp.c
> > > b/arch/arm/mach-imx/mach-imx7ulp.c
> > > index 11ac71aaf965..6d823f05d9aa 100644
> > > --- a/arch/arm/mach-imx/mach-imx7ulp.c
> > > +++ b/arch/arm/mach-imx/mach-imx7ulp.c
> > > @@ -53,11 +53,16 @@ static void __init imx7ulp_set_revision(void)
> > >
> > >  static void __init imx7ulp_init_machine(void)  {
> > > +	struct device *soc_dev;
> > > +
> > > +	soc_dev =3D imx_soc_device_init();
> > > +	if (soc_dev =3D=3D NULL)
> > > +		pr_warn("failed to initialize soc device\n");
> > > +
> >
> > Should this be under set revision?
>=20
> Just follow other i.MX6/7 platforms practice, I could move this under set
> revision in v2 if you prefer.
>=20
> Thanks,
> Peng.
>=20
> >
> > Regards
> > Dong Aisheng
> >
> > >  	imx7ulp_pm_init();
> > >
> > >  	mxc_set_cpu_type(MXC_CPU_IMX7ULP);
> > >  	imx7ulp_set_revision();
> > > -	of_platform_default_populate(NULL, NULL, imx_soc_device_init());
> > >  }
> > >
> > >  static const char *const imx7ulp_dt_compat[] __initconst =3D {
> > > --
> > > 2.16.4

