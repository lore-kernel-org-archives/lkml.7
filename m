Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B6C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4C021872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="rrMb3Qjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfKKMmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:42:55 -0500
Received: from mail-eopbgr700069.outbound.protection.outlook.com ([40.107.70.69]:12480
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726888AbfKKMmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:42:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IaN51tHEyBfNW2At9p356sJx1SYPy1r2qcq5AWsKv/IMmRoZ/CgfHN0/2eHxn/mLqjXeeChGne3d5Lm61+3Ov9TS36QlH/idtGugkWSXT6Dpfaxzw5vr2r0jil9KAW0FiTZS+o42ym72acNepwmWki/85RpPpwr2+0KRZrZPRddCbsM+SXRt5h67NxtCyQClqmHwXxqsObxw2qZ0G6qmAGhW4fI5ACNzCE8MNwp4qqj6YwWElN7YwXWUxJkbBLiVeOOrg9xHLDwQmQkSjzfsjaSvK2DhJosyCGo5dLa3gXR7ruZZSJp79TCBth+7IjTVuf/KMJ7dpZNbWe6ROUIFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/eBMQ/mwmzxujazhd9j+BUVZRwUdsF/ca2hi5qNF0I=;
 b=GgMi2ZYFyBcox4PkTNbTTT2NDvVzsMnlW+udgyCyfT6wG6OMiUH+FGledwtG61ElnKW1a/UG2vRqyFm/7pbLewtBPAUrUmLG0C/2HW4CZsiFHt+dyNxkd1X0egG3GBpH/YFBp8AjE2oKdT+1zSb4+NT6F5KruvcQpgCjcvwvuqTVp0YQrLGZXcauEK/jXcYhBSWWZuhIexskGTMAVf1ccvd64uTHnNyFxAJHDm9GXVodqAMBUNai33zTYd+MwBtUORGnL+i2HF3PM36rpBc6ckaDt8D1ZvN1iKkvLZ6JGXgGy9qW6h68dM27WA6QpyFEbV2Hviug9MqOHX2in/Ejfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/eBMQ/mwmzxujazhd9j+BUVZRwUdsF/ca2hi5qNF0I=;
 b=rrMb3QjkaZFU5ZN1BFxxuvE5Ax+SIukYuxDMpfBSrhFybNCbcovbx5TV7O12Zz0RxRZFuyZGcisRqD1m1UDIijwGTCH3wvB4TLAV4/wkp/ylWFMCynP4sEpVi3zmNNrMW/EDf9rgcucJMxqhw//AP+pvypbvaivj46No2aBJeDU=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (52.135.202.143) by
 BYAPR02MB4040.namprd02.prod.outlook.com (20.176.248.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Mon, 11 Nov 2019 12:42:51 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 12:42:51 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Michael Tretter <m.tretter@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] clk: zynqmp: Add support for custom type flags
Thread-Topic: [PATCH] clk: zynqmp: Add support for custom type flags
Thread-Index: AQHVlUmOtzK6cxVYuU2nwcMuzOsMk6d/7BAAgAXqeBA=
Date:   Mon, 11 Nov 2019 12:42:51 +0000
Message-ID: <BYAPR02MB40557E376D93824F48D103A3B7740@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1573117086-7405-1-git-send-email-rajan.vaja@xilinx.com>
 <20191107174928.71a921f0@litschi.hi.pengutronix.de>
In-Reply-To: <20191107174928.71a921f0@litschi.hi.pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: acb7db0f-7110-46bd-aeff-08d766a4aa88
x-ms-traffictypediagnostic: BYAPR02MB4040:|BYAPR02MB4040:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4040B767537E3542728E00B5B7740@BYAPR02MB4040.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(13464003)(199004)(189003)(51914003)(66476007)(66556008)(14454004)(66946007)(33656002)(478600001)(5660300002)(476003)(26005)(66446008)(64756008)(102836004)(71200400001)(25786009)(7736002)(305945005)(53546011)(52536014)(71190400001)(4326008)(86362001)(76116006)(6506007)(6246003)(74316002)(2906002)(6436002)(11346002)(446003)(76176011)(316002)(54906003)(99286004)(229853002)(186003)(55016002)(8936002)(486006)(6916009)(3846002)(6116002)(9686003)(7696005)(66066001)(14444005)(81166006)(81156014)(256004)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4040;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: anASdKWDbp1la3M/tD7jbVceLZQxA6rdmCxf7ybAyGsF3xaX+fxswal3h5jqQWowg7yLRlJeWX/xcM/h9pzTt74aSyqRAxPls09MyoBuq3LMaDC+wNJD+4Q6TGxoFQUZ9RHiOyVEDFEXlJaPLfC5i3a0DB6QO6m6z0CqtTdolb626UFtRJ63BAm54T5JoKTka9jjLpO7XSqLLpkIkIafRBBATzUm3JZWC3wcaKash2snjkk9npxs0oDOs40XefqVfPKqyaRxWC9OYcJjPMXUqMHLkwj3fzvRXQlrmwQnjqRUD7OSRuXSizTuhAkG1fYe355xYP1Fe4jnpX3oU9aSwNQ/bswRP0moeKpnqOwBNcOasXkGPIuMEOJYaFWbBN40C2ciZw2LymuJphPC4A+sFrH7tZFIitFIErC2VccGsBefpsw47siNfW1PVoeVYwgy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb7db0f-7110-46bd-aeff-08d766a4aa88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 12:42:51.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBJdP+/AsPVVqbmhdfdE5z0VFxb/WFiv/XdduKmEEHQNc/+SotflWO9kf0M2YSE1RLNa1PNnMQOQ0jnNLAD/SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4040
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for the review.

> -----Original Message-----
> From: Michael Tretter <m.tretter@pengutronix.de>
> Sent: 07 November 2019 08:49
> To: Rajan Vaja <RAJANV@xilinx.com>
> Cc: mturquette@baylibre.com; sboyd@kernel.org; Michal Simek
> <michals@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>;
> dan.carpenter@oracle.com; gustavo@embeddedor.com; linux-
> clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; kernel@pengutronix.de
> Subject: Re: [PATCH] clk: zynqmp: Add support for custom type flags
>=20
> EXTERNAL EMAIL
>=20
> On Thu, 07 Nov 2019 00:58:06 -0800, Rajan Vaja wrote:
> > Store extra custom type flags received from firmware.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jolly.shah@xilinx.com>
> > Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> > ---
> >  drivers/clk/zynqmp/clkc.c    | 8 +++++++-
> >  drivers/clk/zynqmp/divider.c | 4 ++--
> >  2 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> > index a11f93e..0dea55e 100644
> > --- a/drivers/clk/zynqmp/clkc.c
> > +++ b/drivers/clk/zynqmp/clkc.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * Zynq UltraScale+ MPSoC clock controller
> >   *
> > - *  Copyright (C) 2016-2018 Xilinx
> > + *  Copyright (C) 2016-2019 Xilinx
> >   *
> >   * Based on drivers/clk/zynq/clkc.c
> >   */
> > @@ -86,6 +86,8 @@ struct topology_resp {
> >  #define CLK_TOPOLOGY_TYPE            GENMASK(3, 0)
> >  #define CLK_TOPOLOGY_FLAGS           GENMASK(23, 8)
> >  #define CLK_TOPOLOGY_TYPE_FLAGS              GENMASK(31, 24)
> > +#define CLK_TOPOLOGY_TYPE_FLAG2              GENMASK(7, 4)
>=20
> What kind of function do these flags indicate? The name is really not
> obvious to me.
>=20
> I would prefer if the defines are kept in the order of the bits in the
> field, i.e., the new define should go between CLK_TOPOLOGY_TYPE and
> CLK_TOPOLOGY_FLAGS.
[Rajan] Ok I will change this in next version.

>=20
> > +#define CLK_TOPOLOGY_TYPE_FLAG_BITS  8
> >       u32 topology[CLK_GET_TOPOLOGY_RESP_WORDS];
> >  };
> >
> > @@ -396,6 +398,10 @@ static int __zynqmp_clock_get_topology(struct
> clock_topology *topology,
> >               topology[*nnodes].type_flag =3D
> >                               FIELD_GET(CLK_TOPOLOGY_TYPE_FLAGS,
> >                                         response->topology[i]);
> > +             topology[*nnodes].type_flag |=3D
> > +                     FIELD_GET(CLK_TOPOLOGY_TYPE_FLAG2,
> > +                               response->topology[i]) <<
> > +                     CLK_TOPOLOGY_TYPE_FLAG_BITS;
>=20
> Shifting the new flags into the existing type_flag field seems like a
> source for code that is really difficult to read. Maybe use a new field
> in the topology for the new flags with a proper name?
[Rajan] Will do it in next version.

>=20
> >               (*nnodes)++;
> >       }
> >
> > diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.=
c
> > index d8f5b70d..d376529 100644
> > --- a/drivers/clk/zynqmp/divider.c
> > +++ b/drivers/clk/zynqmp/divider.c
> > @@ -2,7 +2,7 @@
> >  /*
> >   * Zynq UltraScale+ MPSoC Divider support
> >   *
> > - *  Copyright (C) 2016-2018 Xilinx
> > + *  Copyright (C) 2016-2019 Xilinx
> >   *
> >   * Adjustable divider clock implementation
> >   */
> > @@ -37,7 +37,7 @@
> >   */
> >  struct zynqmp_clk_divider {
> >       struct clk_hw hw;
> > -     u8 flags;
> > +     u16 flags;
>=20
> This change looks unrelated to the remaining patch.
[Rajan] Flag width was changed to accommodate custom flags. So needed to ch=
ange it to u16.
But as you suggested in above comment, will use new variable for custom fla=
g, and so this change won't
Be required.

Thanks,
Rajan
>=20
> Michael
>=20
> >       bool is_frac;
> >       u32 clk_id;
> >       u32 div_type;
