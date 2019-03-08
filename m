Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81FDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD91920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 02:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NTlRkMAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfCHC1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 21:27:30 -0500
Received: from mail-eopbgr130058.outbound.protection.outlook.com ([40.107.13.58]:37252
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfCHC1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 21:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbRzOwJeM++sA3QSxtgWAVvc++1TeeE0W9usjQtxkvc=;
 b=NTlRkMAN+4L5Bv7MY0VQu4f2ri5JyC6FvD3AoW9xbhhLhMjwDOV2iTXTuIIoyDJNy39L79kW9aWXRTCjDUdON4iQcnRUEYDMtpQxl78ZtViZjaMnpR/SqCACy0MWJtGGQ0AqPojReuRM2Svh2kE4jccnuWh5aBKcUZp1yNpT9+U=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4404.eurprd04.prod.outlook.com (52.135.149.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 8 Mar 2019 02:25:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1686.018; Fri, 8 Mar 2019
 02:25:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Andy Gross <andy.gross@linaro.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Topic: [PATCH V7 1/3] watchdog: imx_sc: Add i.MX system controller
 watchdog support
Thread-Index: AQHU07jNtorBWhAbJkylCtaCxH6iDKYAGsHAgAAXwOCAAAGQcIAAA5JQgADMeyA=
Date:   Fri, 8 Mar 2019 02:25:48 +0000
Message-ID: <AM0PR04MB4211321FEC8827FD105F7028804D0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1551834095-19950-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB4211060E8DA8BA9CEAAA0F15804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB391677CB27E45A6EC16D6F69F54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <AM0PR04MB42118452D9B975337E3BDDAD804C0@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <DB3PR0402MB391641F558061A561162136CF54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB391641F558061A561162136CF54C0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e72182e-0937-4b0a-6471-08d6a36d60ac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4404;
x-ms-traffictypediagnostic: AM0PR04MB4404:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB4404;23:Gpce1O/wGFUrvhM3SOr6HNP5BzL5rL2AoW+k34v/K?=
 =?us-ascii?Q?GMRxjQHwixv0Jbn9tYCbeJ9Y09+Z6kKZ5I/ZDS4rdn74GixcvwqpU1+dyj+z?=
 =?us-ascii?Q?4nfBiiHD1p/V4viyN5I7wTdhKJWtU/VRRUEd+Lotjq/4ZiOi1ZmUGUUGpelJ?=
 =?us-ascii?Q?cjpSuLEZ11BGw7Y95xB8s/E3GKEcz1lH30iMVemkIl3wVSmyLS0FMY2QuuHR?=
 =?us-ascii?Q?kmlpt9RN1neBePeNw3Utn12ICYU2SabFx/eeQta8yy73ymB1m0NYCamAffGd?=
 =?us-ascii?Q?ZS8oADccsOby7QM5ddqEed0HbpNRUS62rO8RBsUyCNZU0gBS9i/ZkzDuk8yu?=
 =?us-ascii?Q?rJqU93cZwz4QUbBHw4UjfmESJnUFEq8faVJ6qTVej32+6EHwC/r9cNR37Y6/?=
 =?us-ascii?Q?bh33SxXXEF52E5oGr/OMUCLSrYeDTgQXEEI9evFkFrosAlvlYfNHuj9lvMpE?=
 =?us-ascii?Q?DyNzhS0wNLWkNEnFMKpO8GP6O4pQzGpWu2JUV2iEQRGvac/Vf6/gFvNXMqc5?=
 =?us-ascii?Q?XQwDniOuj+rNZF0gNbWpRe1opLCok66X4+ut3lBeJCNosoo8e1VbOEIDqznM?=
 =?us-ascii?Q?SlWh4ShvLgFVtBYTx83P5zOQhfTCesGVMZnlx/JWuNwr+gaO4CodDr6t6uvw?=
 =?us-ascii?Q?Y4iXrU9+l29nFDcNqRdsLTT0Wx6FjuKOBjXNjLqr0eTfcE5HuCk9IH+SXu1Q?=
 =?us-ascii?Q?E2VOtvzTYg0unJUAHyiUeaGImkU6CMuKAPwx8LkNJT/gtx7rycQkNljYepOq?=
 =?us-ascii?Q?wD8qrNEFulg/Q5kIxL91rET6x2AzukVmse9pgHW6j+PKwpAOws2OVtKcbwaH?=
 =?us-ascii?Q?9hcrEunXZG5iiQb9Ow5aPeo7orLFV5x5WZFTrk4YfH6xDYG85wDsxf5Jt5lq?=
 =?us-ascii?Q?OYS+2Zrc5vGFv1+atgKvB6E5TRWDRha2OFglqlBuIchY43S0Yyg/PtCtbTGh?=
 =?us-ascii?Q?vKelMnGV7qW4WfJneP3qDeHA+BPryCP+dX0JTdSi0bYZ/dub/DKL+VZOc1A0?=
 =?us-ascii?Q?iXw9v2+xIjV0Eqk1hPbBYTr/N8a20qjr17/D2q15BY8Vg+l4efXQLh02NO4O?=
 =?us-ascii?Q?RSOuY7iL5Hq7rDizZS4xYYWoT0wLdaSo2h3RrhYPjcaBVVhnfjn7HVVtsHS4?=
 =?us-ascii?Q?VT3u2rSce1/8RCa5++36qrUTh81kU9zVC0VAlVv5FtpocdcHo5Ios8BBG9Z+?=
 =?us-ascii?Q?V2bCjtYbncfCFFvtkcpzfrTdEAdHNTG1yHP/AGCG6dfwZ5d1YhjP2JVlb7Gj?=
 =?us-ascii?Q?qtenJVCerhslUoIL8BKPgwq1TzyHid31p4iXvaRzO69ltm5bBRjb21vIzr3n?=
 =?us-ascii?Q?5f9IfXp6iQfn1dBJ9KR835+49RCi1/MvEyp+Ev2qdifR91tJZZTk1EOYJRU6?=
 =?us-ascii?Q?4qmug=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB440480AF166507F6AB306803804D0@AM0PR04MB4404.eurprd04.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(376002)(39860400002)(346002)(52314003)(189003)(199004)(305945005)(2906002)(7416002)(66066001)(6246003)(8676002)(68736007)(71190400001)(71200400001)(7736002)(81156014)(5660300002)(81166006)(4326008)(8936002)(2501003)(256004)(6116002)(3846002)(52536013)(74316002)(105586002)(106356001)(86362001)(2201001)(44832011)(102836004)(6436002)(486006)(76176011)(6506007)(11346002)(446003)(7696005)(229853002)(476003)(478600001)(99286004)(186003)(25786009)(316002)(9686003)(26005)(55016002)(14454004)(33656002)(97736004)(110136005)(93886005)(53936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4404;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uz7X1occJ9f19xIuvg/NbqstRfAWrgROeDEywelW38ss4dQwbdSDTlSn32whDooWdvRGkLAf/2gK/CrXv8l3PV3C9RykkjG3gNyHycqCMUbWBgf6WdoQ4a9an786p9uEXZUBMpy+uFrrZV2G27Ilm3SAFPa0bt/YXIR9w+dO4bPdoRiOmq9VJ/13pYWCOlKB0IYG9ci1qZTFxcnAWEZ0v/ImIlMoDSHdMbl5j8CpT1rUgzGU/UGBGhgNcPMGbFbvFvbCxzf5lMAZQHdyuNKbEHXdFBDyGyPHSudh1Mnbm0di3UWenVxZsRzeJ+qDYI+URr2QCGwQZKVqz+J9teaDla3X5nZIxaXBFpXzDFMNBXlbaqwa7DwMstqmfuWq54M2S18CwT5vLSqNOsy3XPkYw9KBxy313l1BMLSeU3S47Pc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e72182e-0937-4b0a-6471-08d6a36d60ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 02:25:48.7356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> >
> > > > As I replied in another mail, it actually does not depend on SCU.
> > > > Let's wait for Rob's comment on whether we could move watchdog Out
> > > > of SCU node.
> > >
> > > Per previous discussion, the dependency here is to prevent enabling
> > > this module for platform without IMX SCU, although it does NOT use
> > > SCU IPC call, but the SMC call trap into ARM-Trusted-Firmware will
> > > eventually call SCU API, so it still depends on IMX SCU hardware, I
> > > am NOT very sure if it is correct to remove it here.
> > >
> >
> > Then it's ATF depends on SCU, not this virtual watchdog based on ARM
> > SIP, right?
>=20
> But we don't have ATF driver in Linux kernel..., I am confused, anyway, i=
f
> Guenter agrees, I can remove this dependency here.
>=20

So far the only thing that watchdog depends on SCU driver is that it needs
SCU driver to create a platform devices for it.
We need wait Rob's feedback, if he agree moved the watchdog node
Out of SCU, we can remove this dependency.

Regards
Dong Aisheng

> Anson.
>=20
> >
> > Regards
> > Dong Aisheng
> >
> > > >
> > > > > +	depends on HAVE_ARM_SMCCC
> > > > > +	select WATCHDOG_CORE
> > > > > +	help
> > > > > +	  This is the driver for the system controller watchdog
> > > > > +	  on the NXP i.MX SoCs with system controller inside.
> > > > > +	  If you have one of these processors and wish to have
> > > > > +	  watchdog support enabled, say Y, otherwise say N.
> > > > > +
