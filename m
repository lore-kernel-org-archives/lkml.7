Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C10C04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79A3217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wj1zED1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfEJHbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:31:04 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:40674
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbfEJHbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/HulLwxu+EG6kzqReFShjr6ZPorzPB10t+g8rxdqNU=;
 b=Wj1zED1ifmq9+i750lYBmd7RHVuA330m0rnYljaJqqYToMP3rw5gVbIohrE5fR5ta0tFZg0eXfxNgtY5qZvk5TmHLvhLw9A9Q+CtUOiLpsEUghbhHIZthFSadeRPMcrxbZxyTPYd3Cy6GTubyIlyGkCPsbQXwQvQ81tjGxmc03Q=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4289.eurprd04.prod.outlook.com (52.134.124.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Fri, 10 May 2019 07:30:20 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1856.012; Fri, 10 May 2019
 07:30:20 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
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
Subject: Re: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Topic: [PATCH 1/2] soc: imx-sc: add i.MX system controller soc driver
 support
Thread-Index: AQHU+KWWicVqVQQzP0ClKRUbB9ME9qZjwquAgABQeoA=
Date:   Fri, 10 May 2019 07:30:20 +0000
Message-ID: <20190510073019.rkf6zxkxoj4sgxpy@fsr-ub1664-175>
References: <1554965048-19450-1-git-send-email-Anson.Huang@nxp.com>
 <20190421073958.GC19962@dragon> <20190421074152.GD19962@dragon>
 <DB3PR0402MB39161C0DDFF0EEA6D8A90378F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <DB3PR0402MB39164B30B26CAF62EE807168F5220@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <VI1PR04MB5533CED52723AE8292CFC305EE220@VI1PR04MB5533.eurprd04.prod.outlook.com>
 <20190510024215.GA15856@dragon>
In-Reply-To: <20190510024215.GA15856@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57db8cd2-ed1d-416b-34ae-08d6d5195ba4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4289;
x-ms-traffictypediagnostic: AM0PR04MB4289:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM0PR04MB4289820794B6E3CFA3AA9B24F60C0@AM0PR04MB4289.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(199004)(189003)(13464003)(76176011)(14454004)(54906003)(26005)(99286004)(53546011)(5660300002)(6506007)(478600001)(1076003)(102836004)(71190400001)(71200400001)(6512007)(9686003)(25786009)(6246003)(53936002)(14444005)(256004)(4326008)(2906002)(316002)(3846002)(6116002)(86362001)(66066001)(33716001)(66556008)(66476007)(66446008)(64756008)(6486002)(44832011)(6436002)(8936002)(11346002)(446003)(476003)(73956011)(76116006)(91956017)(229853002)(305945005)(66946007)(7736002)(486006)(186003)(6916009)(7416002)(81156014)(81166006)(68736007)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4289;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4c4wmY2m71lMSXqKozi7eS53aUcSQMFCvt4KlUOz5IWEdV8zM8o2gWN+QN0qey65MQ+roNjlFoH/8S9fpgLUFVvF3BuzRVzEVabj/L+f5ZK1CPoi4coksZmDJiqAwUJTcCWKHZYc1WH+Zw9DumUHL42y5aVvQsh2PDQcP+/X4/E5KXTwTBiZ0hV0CBhEjAb5WPdcfDluGcYnpDQa+yq98yozGhCSUXftRqrCoZzKDgYTEtiWKAGO+xfAwwhHeISduM4iA624VVeLsFnJHHIE9ZHSLp4Nf3zl96Aguxsc725g/tFmmsKkgFBE6LcRjiWGmjzSW4yj5mB8FRNmg5LXQtVMhwNM0WppidhyrkAwnlDuuXTm5lOwR9OfONODqPPEiO893HwuEmNiN2KhdVQEOINKLC5d2ZMPrpJOwbCj6HQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69A407636461B248A9D298170B2FC4BD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57db8cd2-ed1d-416b-34ae-08d6d5195ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 07:30:20.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-10 10:42:17, Shawn Guo wrote:
> On Mon, Apr 22, 2019 at 08:48:56AM +0000, Leonard Crestez wrote:
> > On 4/22/2019 9:46 AM, Anson Huang wrote:
> > >> -----Original Message-----
> > >> From: Anson Huang
> > >>> From: Shawn Guo [mailto:shawnguo@kernel.org]
> > >>> On Sun, Apr 21, 2019 at 03:40:00PM +0800, Shawn Guo wrote:
> > >>>> On Thu, Apr 11, 2019 at 06:49:12AM +0000, Anson Huang wrote:
> > >>>>> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> > >>>>> inside, the system controller is in charge of controlling power,
> > >>>>> clock and fuse etc..
> > >>>>>
> > >>>>> This patch adds i.MX system controller soc driver support, Linux
> > >>>>> kernel has to communicate with system controller via MU (message
> > >>>>> unit) IPC to get soc revision, uid etc..
> > >>>>>
> > >>>>> With this patch, soc info can be read from sysfs:
> > >>>>>
> > >>>>>   drivers/soc/imx/Kconfig      |   7 ++
> > >>>>>   drivers/soc/imx/Makefile     |   1 +
> > >>>>>   drivers/soc/imx/soc-imx-sc.c | 220
> > >>>>> +++++++++++++++++++++++++++++++++++++++++++
> > >>>>>   3 files changed, 228 insertions(+)  create mode 100644
> > >>>>> drivers/soc/imx/soc-imx-sc.c
> > >>>>
> > >>>> Rather than creating a new driver, please take a look at Abel's
> > >>>> generic
> > >>>> i.MX8 SoC driver, and see if it can be extended to cover i.MX8QXP.
> > >>
> > >> Got it, I didn't notice that this patch bas been accepted, I will re=
do the patch
> > >> based on it, thanks.
> > >=20
> > > I have sent the new patch set to support i.MX8QXP SoC revision based =
on generic i.MX8
> > > SoC driver, however, the Kconfig modification is NOT good, it may bre=
ak i.MX8MQ if IMX_SCU
> > > is NOT enabled, although we can add some warp function for SCU firmwa=
re API call to fix it,
> > > but after further thought and discussion with Dong Aisheng, I think w=
e may need to roll back to
> > > use this patch series to create a new SoC driver dedicated for i.MX8 =
SoCs
> > > with system controller inside, such as i.MX8QXP, i.MX8QM etc., the re=
ason are as below:
> > >=20
> > > For i.MX8MQ/i.MX8MM:
> > > 	1. SoC driver does NOT depends on i.MX SCU firmware, so no need to u=
se platform driver
> > > 	     probe model, just device_init phase call is good enough;
> > > 	2. The SoC driver no need to depends on IMX_SCU, so it can be always=
 built in, no need to
> > > 	     check IMX_SCU config;
> > > 	3. The fuse check for CPU speed grading, HDCP status, NoC settings e=
tc. could be added to this driver,
> > > 	    but they are ONLY for i.MX8MQ/i.MX8MM etc..
> > > For i.MX8QXP/i.MX8QM:
> > > 	1. SoC driver MUST depends on IMX_SCU;
> > > 	2. MUST use platform model to support defer probe;
> > > 	3. No fuse check for CPU speed grading.
> > >=20
> > > So, I guess the reused code for i.MX8MQ and i.MX8QXP is ONLY those pa=
rt of creating SoC id device node (less than
> > > 30% I think), all other functions are implemented in total different =
ways, that is why I created the imx_sc_soc driver
> > > in this patch series, so do you think we can add new SoC driver for i=
.MX8 SoC with SCU inside? Putting 2 different architecture
> > > SoCs' driver into 1 file looks like NOT making enough sense.
> >=20
> > +1 for separate SOC driver. The 8mq/8mm and 8qm/8qxp families are very=
=20
> > different, they just happen to share the imx8 prefix.
> >=20
> > It makes sense to allow people to compile one without the other and thi=
s=20
> > is easier with distinct SOC drivers.

Totally agree.

>=20
> Leonard, Abel,
>=20
> Can you guys help review the patch?  Thanks.
>=20
> Shawn

Looks good to me.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>=
