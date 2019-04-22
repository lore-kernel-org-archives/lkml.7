Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F639C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 00:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DAD20833
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 00:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YMqfkZx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfDVAwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 20:52:06 -0400
Received: from mail-eopbgr30067.outbound.protection.outlook.com ([40.107.3.67]:7206
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725908AbfDVAwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 20:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8p2wl9UJyGtDs0z3Rew11bL7CxDyA4IsI5Q8N8GlRo=;
 b=YMqfkZx7A2ZohlnFWDFTuuukfbz8b3hdZjDL0kJP4B6z9OFHM7iQr3FCutISWvM/9SSVyNZS+Rof54P6LkOCbOy2phRGg6YdnOZIRU5RRjV7CNPuiVfaboDHfeRFxSMS1bS8w38/5FlTDimIw+dP/+wvM7IUdy9+eHMLoR8bAKs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3850.eurprd04.prod.outlook.com (52.134.65.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Mon, 22 Apr 2019 00:51:58 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.017; Mon, 22 Apr 2019
 00:51:57 +0000
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
Thread-Index: AQHU8DKsAg9Kriz6B0mooDc33xId46ZGSnMAgAAAiACAAR97oA==
Date:   Mon, 22 Apr 2019 00:51:57 +0000
Message-ID: <DB3PR0402MB39161C0DDFF0EEA6D8A90378F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
 <20190421073958.GC19962@dragon> <20190421074152.GD19962@dragon>
In-Reply-To: <20190421074152.GD19962@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c405dadd-d564-4f5d-ed2f-08d6c6bcb8fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB3PR0402MB3850;
x-ms-traffictypediagnostic: DB3PR0402MB3850:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <DB3PR0402MB3850DC6827A92325E0ACDDC4F5220@DB3PR0402MB3850.eurprd04.prod.outlook.com>
x-forefront-prvs: 00159D1518
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(136003)(13464003)(199004)(189003)(186003)(8936002)(66446008)(66556008)(66476007)(76116006)(66946007)(64756008)(476003)(2906002)(73956011)(7696005)(102836004)(6506007)(486006)(26005)(76176011)(53546011)(81156014)(99286004)(44832011)(97736004)(81166006)(11346002)(446003)(5660300002)(8676002)(52536014)(68736007)(4326008)(256004)(229853002)(25786009)(55016002)(14454004)(9686003)(54906003)(86362001)(71190400001)(66066001)(71200400001)(316002)(6306002)(966005)(6246003)(305945005)(7736002)(7416002)(33656002)(6436002)(14444005)(3846002)(478600001)(6116002)(45080400002)(74316002)(53936002)(6916009)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3850;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yGl8yj7sBylOFT1D0Bp23anB3swrcDJjCXacWzkIadCWAXnarBPCuI4pw8cYlVS8J07jbXgybhPXvi6jDaNCzPVmO7oWMnzWFTpWJX8mAGZTB8ubI89IxV0FTVQOXCvnTsjRcjAG/6T4sbK0kq5UfU6KG4rJe9ekOtQfCfhHs7DsDETx9ZgLRqDG3B9DccPaliCoV0Y0FpZaO5gkNkDa97K2mQhzn17bPsb3cseDgYTydP57Oa1wF5idOgfczZZbWhJDxETATWuOdgCSDh18KI1L5OR8EBZz8OIHTeEK2sVs7VzMr5yWwm6DOI73OFxrRlxECRISLsR8fE6XhB9w5kzWxxR2gu4C8i2CB5i7Z+ZwSZSVY5wokHDvfgaNcKzlVkUt7jKkOR13a+yrpa43TCCXq0JIVhYVdIvvXbBvGBY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c405dadd-d564-4f5d-ed2f-08d6c6bcb8fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2019 00:51:57.7086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3850
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Shawn

Best Regards!
Anson Huang

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo@kernel.org]
> Sent: Sunday, April 21, 2019 3:42 PM
> To: Anson Huang <anson.huang@nxp.com>
> Cc: stefan.wahren@i2se.com; enric.balletbo@collabora.com; linux-
> kernel@vger.kernel.org; heiko@sntech.de; marc.w.gonzalez@free.fr;
> ezequiel@collabora.com; catalin.marinas@arm.com;
> s.hauer@pengutronix.de; will.deacon@arm.com; Abel Vesa
> <abel.vesa@nxp.com>; bjorn.andersson@linaro.org; Andy Gross
> <andy.gross@linaro.org>; jagan@amarulasolutions.com;
> kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>; olof@lixom.net;
> horms+renesas@verge.net.au; festevam@gmail.com; robh@kernel.org;
> linux-arm-kernel@lists.infradead.org; l.stach@pengutronix.de
> Subject: Re: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driv=
er
> support
>=20
> On Sun, Apr 21, 2019 at 03:40:00PM +0800, Shawn Guo wrote:
> > On Thu, Apr 11, 2019 at 06:49:12AM +0000, Anson Huang wrote:
> > > i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> > > inside, the system controller is in charge of controlling power,
> > > clock and fuse etc..
> > >
> > > This patch adds i.MX system controller soc driver support, Linux
> > > kernel has to communicate with system controller via MU (message
> > > unit) IPC to get soc revision, uid etc..
> > >
> > > With this patch, soc info can be read from sysfs:
> > >
> > > i.mx8qxp-mek# cat /sys/devices/soc0/family Freescale i.MX
> > >
> > > i.mx8qxp-mek# cat /sys/devices/soc0/soc_id i.MX8QXP
> > >
> > > i.mx8qxp-mek# cat /sys/devices/soc0/machine Freescale i.MX8QXP MEK
> > >
> > > i.mx8qxp-mek# cat /sys/devices/soc0/revision
> > > 1.1
> > >
> > > i.mx8qxp-mek# cat /sys/devices/soc0/soc_uid
> > > 7B64280B57AC1898
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  drivers/soc/imx/Kconfig      |   7 ++
> > >  drivers/soc/imx/Makefile     |   1 +
> > >  drivers/soc/imx/soc-imx-sc.c | 220
> > > +++++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 228 insertions(+)
> > >  create mode 100644 drivers/soc/imx/soc-imx-sc.c
> >
> > Rather than creating a new driver, please take a look at Abel's
> > generic
> > i.MX8 SoC driver, and see if it can be extended to cover i.MX8QXP.
>=20
> Forgot to give pointer to Abel's driver.
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
er
> nel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git%
> 2Fcommit%2F%3Fh%3Dimx%2Fdrivers%26id%3Da7e26f356ca12906a164d83c
> 9e9f8527ee7da022&amp;data=3D02%7C01%7Canson.huang%40nxp.com%7C9
> e2705d7449b4c2e23ed08d6c62ce0bb%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636914293400307709&amp;sdata=3D6ySEs%2B4SE8bvcBCkfoi
> VBafseAYthTED9%2F5qcf25xds%3D&amp;reserved=3D0
>=20

Got it, I didn't notice that this patch bas been accepted, I will redo the =
patch based on it,
thanks.

Anson.

> Shawn
