Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1203C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8E06218AF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 06:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="u+OIphS+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfDVGqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 02:46:17 -0400
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:24351
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726519AbfDVGqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 02:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdL5Y/+kJoMmL1Kcc7uRvIvDPflNqTkGgNtyQTbbyco=;
 b=u+OIphS+gX7uVf4YyxLzTCKcXc3gbEtju3Jfym5Rjw1nSoPrpAP0UWbhOgpc8X4hc8L0/VjbrSBppQdHd+GXvRR0bQcN6poa3zIv3N72Jnln/F83ctU87BQ25FH1dAY590rIN/XQnPv89kTNaTd2eSdLtvpRI1s77mBI1U92kjQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.16; Mon, 22 Apr 2019 06:46:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 06:46:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Subject: RE: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Topic: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Index: AQHU8DKsAg9Kriz6B0mooDc33xId46ZGSnMAgAAAiACAAR97oIAAXhVQ
Date:   Mon, 22 Apr 2019 06:46:10 +0000
Message-ID: <DB3PR0402MB39164B30B26CAF62EE807168F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
 <20190421073958.GC19962@dragon> <20190421074152.GD19962@dragon>
 <DB3PR0402MB39161C0DDFF0EEA6D8A90378F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39161C0DDFF0EEA6D8A90378F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0bacf32-512a-43c9-1f8d-08d6c6ee347b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB37559E3083B39186AE92FE59F5220@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(13464003)(74316002)(81156014)(71190400001)(71200400001)(81166006)(33656002)(9686003)(8676002)(2940100002)(66556008)(25786009)(7416002)(6306002)(55016002)(76116006)(7696005)(966005)(14444005)(8936002)(256004)(99286004)(54906003)(316002)(93156006)(14454004)(64756008)(6436002)(53936002)(486006)(52536014)(45080400002)(5660300002)(6116002)(6916009)(478600001)(229853002)(44832011)(11346002)(446003)(476003)(3846002)(4326008)(66476007)(7736002)(66446008)(6246003)(66066001)(102836004)(186003)(97736004)(66946007)(93886005)(86362001)(73956011)(6506007)(53546011)(305945005)(68736007)(26005)(76176011)(2906002)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k8+iWtl4YKtjRDfyauvteMccHRRqiSbDxGt9e9sjxqi0p55GhSrByXzj3/+R4EIB4knFcifX6sS3a7I9sRdvZ2XQjODRvMmV1AzmlDsHeDn8d6xvsRNTb3AlLlCCq49QpDfZ0N5cJCGHtBY1kfw5pNEOG4yNaDreHhAcNvPEWncIP5oDhVPQeKnSXERhfCet8sL9fSTXoChQPeL1srcJzU2s62o3jQt32K3Jk50V+CS/qHKX7W5o/c7cvenKVKCxyY7Xrqs2N08xujrRvFfhFiu5wlA2PGqsVgNtfedwNQzRgvGddPPi1MYrL1n0QTjQ4ExP7DA2qpPwzy1PjZbWv7RmpF+YrKsOpG4XxsxLDYavgF8T27784pgBFQQinbece/HxDSxSCe6NEiISBPTzK4R+RhaD50UWZdtaL3sCiyk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0bacf32-512a-43c9-1f8d-08d6c6ee347b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 06:46:10.2462
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn

Best Regards!
Anson Huang

> -----Original Message-----
> From: Anson Huang
> Sent: Monday, April 22, 2019 8:52 AM
> To: Shawn Guo <shawnguo@kernel.org>
> Cc: stefan.wahren@i2se.com; enric.balletbo@collabora.com; linux-
> kernel@vger.kernel.org; heiko@sntech.de; marc.w.gonzalez@free.fr;
> ezequiel@collabora.com; catalin.marinas@arm.com;
> s.hauer@pengutronix.de; will.deacon@arm.com; Abel Vesa
> <abel.vesa@nxp.com>; bjorn.andersson@linaro.org; Andy Gross
> <andy.gross@linaro.org>; jagan@amarulasolutions.com;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; olof@lixom.net;
> horms+renesas@verge.net.au; festevam@gmail.com; robh@kernel.org;
> linux-arm-kernel@lists.infradead.org; l.stach@pengutronix.de
> Subject: RE: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driv=
er
> support
>=20
> Hi, Shawn
>=20
> Best Regards!
> Anson Huang
>=20
> > -----Original Message-----
> > From: Shawn Guo [mailto:shawnguo@kernel.org]
> > Sent: Sunday, April 21, 2019 3:42 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: stefan.wahren@i2se.com; enric.balletbo@collabora.com; linux-
> > kernel@vger.kernel.org; heiko@sntech.de; marc.w.gonzalez@free.fr;
> > ezequiel@collabora.com; catalin.marinas@arm.com;
> > s.hauer@pengutronix.de; will.deacon@arm.com; Abel Vesa
> > <abel.vesa@nxp.com>; bjorn.andersson@linaro.org; Andy Gross
> > <andy.gross@linaro.org>; jagan@amarulasolutions.com;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>;
> > olof@lixom.net;
> > horms+renesas@verge.net.au; festevam@gmail.com; robh@kernel.org;
> > linux-arm-kernel@lists.infradead.org; l.stach@pengutronix.de
> > Subject: Re: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc
> > driver support
> >
> > On Sun, Apr 21, 2019 at 03:40:00PM +0800, Shawn Guo wrote:
> > > On Thu, Apr 11, 2019 at 06:49:12AM +0000, Anson Huang wrote:
> > > > i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> > > > inside, the system controller is in charge of controlling power,
> > > > clock and fuse etc..
> > > >
> > > > This patch adds i.MX system controller soc driver support, Linux
> > > > kernel has to communicate with system controller via MU (message
> > > > unit) IPC to get soc revision, uid etc..
> > > >
> > > > With this patch, soc info can be read from sysfs:
> > > >
> > > > i.mx8qxp-mek# cat /sys/devices/soc0/family Freescale i.MX
> > > >
> > > > i.mx8qxp-mek# cat /sys/devices/soc0/soc_id i.MX8QXP
> > > >
> > > > i.mx8qxp-mek# cat /sys/devices/soc0/machine Freescale i.MX8QXP
> MEK
> > > >
> > > > i.mx8qxp-mek# cat /sys/devices/soc0/revision
> > > > 1.1
> > > >
> > > > i.mx8qxp-mek# cat /sys/devices/soc0/soc_uid
> > > > 7B64280B57AC1898
> > > >
> > > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > > ---
> > > >  drivers/soc/imx/Kconfig      |   7 ++
> > > >  drivers/soc/imx/Makefile     |   1 +
> > > >  drivers/soc/imx/soc-imx-sc.c | 220
> > > > +++++++++++++++++++++++++++++++++++++++++++
> > > >  3 files changed, 228 insertions(+)  create mode 100644
> > > > drivers/soc/imx/soc-imx-sc.c
> > >
> > > Rather than creating a new driver, please take a look at Abel's
> > > generic
> > > i.MX8 SoC driver, and see if it can be extended to cover i.MX8QXP.
> >
> > Forgot to give pointer to Abel's driver.
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
.
> > ker
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git%
> >
> 2Fcommit%2F%3Fh%3Dimx%2Fdrivers%26id%3Da7e26f356ca12906a164d83c
> >
> 9e9f8527ee7da022&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C9
> >
> e2705d7449b4c2e23ed08d6c62ce0bb%7C686ea1d3bc2b4c6fa92cd99c5c3016
> >
> 35%7C0%7C0%7C636914293400307709&amp;sdata=3D6ySEs%2B4SE8bvcBCkfoi
> > VBafseAYthTED9%2F5qcf25xds%3D&amp;reserved=3D0
> >
>=20
> Got it, I didn't notice that this patch bas been accepted, I will redo th=
e patch
> based on it, thanks.

I have sent the new patch set to support i.MX8QXP SoC revision based on gen=
eric i.MX8
SoC driver, however, the Kconfig modification is NOT good, it may break i.M=
X8MQ if IMX_SCU
is NOT enabled, although we can add some warp function for SCU firmware API=
 call to fix it,
but after further thought and discussion with Dong Aisheng, I think we may =
need to roll back to
use this patch series to create a new SoC driver dedicated for i.MX8 SoCs
with system controller inside, such as i.MX8QXP, i.MX8QM etc., the reason a=
re as below:

For i.MX8MQ/i.MX8MM:
	1. SoC driver does NOT depends on i.MX SCU firmware, so no need to use pla=
tform driver
	     probe model, just device_init phase call is good enough;
	2. The SoC driver no need to depends on IMX_SCU, so it can be always built=
 in, no need to
	     check IMX_SCU config;
	3. The fuse check for CPU speed grading, HDCP status, NoC settings etc. co=
uld be added to this driver,
	    but they are ONLY for i.MX8MQ/i.MX8MM etc..
For i.MX8QXP/i.MX8QM:
	1. SoC driver MUST depends on IMX_SCU;
	2. MUST use platform model to support defer probe;
	3. No fuse check for CPU speed grading.

So, I guess the reused code for i.MX8MQ and i.MX8QXP is ONLY those part of =
creating SoC id device node (less than
30% I think), all other functions are implemented in total different ways, =
that is why I created the imx_sc_soc driver
in this patch series, so do you think we can add new SoC driver for i.MX8 S=
oC with SCU inside? Putting 2 different architecture
SoCs' driver into 1 file looks like NOT making enough sense.

Anson.

>=20
> Anson.
>=20
> > Shawn
