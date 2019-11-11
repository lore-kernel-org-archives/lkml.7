Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D80EC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEC52190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="fu03YDwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKMT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:19:28 -0500
Received: from mail-eopbgr800089.outbound.protection.outlook.com ([40.107.80.89]:29204
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbfKKMT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:19:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JpKoVjs84rhfeCmAyfIbx0Af7CGABHhz6r855meB9Vjy1EIVOBpO3iNSSR19VgVZKzO0H3KuBJ3s7jdGG1fHkel8ZHlJDB6IlVCu92lF8tZrRe1ZmbXfEX7Nq5958vX6VSFK5pmSXS7Krwif9Dm21ZMb7yZLcxl41yXkFfAqeUyDqJycKR5GIPISu7ut9uRP2kQCGkuAQuuBgt+LfYtmPJd0VYV6sidUUdevLeww1k0+cjVdPaTh/KOarzBNO0zyGIzx0svi65YuGcO/qwaQJpMqOuvP45VLhUnSq3Nh+4+H/3I46W5ugNX5wRpyuYd3KG4kwbmykxpXJMmsSLjiDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI7psLc+KipriYCBSjka7e03nAsGcSfEMa7hCccwIPc=;
 b=QltYyAPCP4ENaYw409Uso+/9tEs9PVsESMIg12gY7ZAQlndhdt+HxtnrU5EzMJttERacFIIVkOQvdiPxUlev6EF0j4Mc/CZQFL5bEZe/YigkZkRxFNjgkJ4/liKhW7PJEjZIkQyfQ8XuS5Z8ODtHB9mHqcBOhnnp+sYiTs1HaqYh3GA68aIQooL7el10l8ZRBnxlkfOB2wSwhl1I+bmdgXzd37QKmyuj9Du4WtHHwYSAPZmSp3QVSTgro1hKDZl4y1BkNDxDFbbHR9rwU/UzfyuBYib7jqDaAG+LhmZmamD4dBh6GuIagChLUgOxCglMYc24mRtd2NzMx2V4P1/QhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI7psLc+KipriYCBSjka7e03nAsGcSfEMa7hCccwIPc=;
 b=fu03YDwIZrgJnr3XGpoToyZjOu0hGy2RCgfX2D8LpEH5DzvftBP3ZhgLJZeYmCMqpUctfB3QUN5KVn+TFb/JrYbP2rZsb97MJgOHDlUojNNjd0a3d/PXBDdK4xIEWE53X3VYzRQVseCPCb41O6fut3dO1I1zWVYctdqcnnYUPNw=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (52.135.202.143) by
 BYAPR02MB5191.namprd02.prod.outlook.com (20.176.254.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.25; Mon, 11 Nov 2019 12:19:22 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::fccc:d399:e650:9a9e%5]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 12:19:22 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Michael Tretter <m.tretter@pengutronix.de>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>,
        Radhey Shyam Pandey <radheys@xilinx.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] clk: zynqmp: Add support for clock with
 CLK_DIVIDER_POWER_OF_TWO flag
Thread-Topic: [PATCH] clk: zynqmp: Add support for clock with
 CLK_DIVIDER_POWER_OF_TWO flag
Thread-Index: AQHVlUkv/SfvLcaY5E2Ze3HWYusTcKd//yyAgAXQRjA=
Date:   Mon, 11 Nov 2019 12:19:22 +0000
Message-ID: <BYAPR02MB4055DF3A4FC080C746C21825B7740@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1573116902-7240-1-git-send-email-rajan.vaja@xilinx.com>
 <20191107185751.4bb873d9@litschi.hi.pengutronix.de>
In-Reply-To: <20191107185751.4bb873d9@litschi.hi.pengutronix.de>
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
x-ms-office365-filtering-correlation-id: ebb6734f-7cae-4790-a78e-08d766a162a2
x-ms-traffictypediagnostic: BYAPR02MB5191:|BYAPR02MB5191:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5191A757F9FA20FC707C354CB7740@BYAPR02MB5191.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(13464003)(199004)(189003)(5660300002)(6116002)(14454004)(478600001)(6436002)(52536014)(4326008)(6246003)(229853002)(25786009)(9686003)(3846002)(66946007)(66556008)(64756008)(66446008)(66476007)(76116006)(55016002)(486006)(256004)(14444005)(71190400001)(71200400001)(446003)(11346002)(66066001)(81166006)(8936002)(476003)(8676002)(81156014)(99286004)(186003)(74316002)(7696005)(76176011)(6506007)(53546011)(33656002)(86362001)(2906002)(7736002)(305945005)(102836004)(6916009)(316002)(54906003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5191;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7NkyRJS5ZeaSqXOE96o+JFIsgjm6yDZcwlfpzFNXEXkvDwwjzEdZ6fD7NnenwdHfRhZ4K4PH5mhRUDkP9RFXZMIPr42Ao2zI3/Sd95HaG08+BsvhdeU8rCr1mqcJdQMjx9VnyoKOAly6Ch7NSPdXGWsQkSRJlCBvQ1l3KWZEEVyw7FeI/LFhAqHDOXCXs4c8K0R2ez/N7Zoct5BQShIdQpBK7m4PlQv2IeVRWq/XwjJoPhMlchBAiUiDI0Gc+Dfpp2m4XVLartvi5Po9ZYRVN6cvFJP2jm9UiJdbGTDc+26hFlrwY1H/yRXvZJ4IYiRiF8AQLl41LuHvixr1lumhj5kfzSL5ntZnVlyzFyQoUPR6lR1xqSCwYAwarJf8k+KZy7FeAR7I09r/qtrQrDZZ0qs3BRM7mzplEBmtMDm6HjfzQpSW54Ux3zAN7Ag1JMks
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb6734f-7cae-4790-a78e-08d766a162a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 12:19:22.5250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wT+PecjJVOO9a1z/mZbU1riu72WjQ5Ln600eMP+rVw5J+J9DWP7tvBlRC0/o+Sj6OZTLJ9u1rfDmVjFcSVCQ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thanks for review.

> -----Original Message-----
> From: Michael Tretter <m.tretter@pengutronix.de>
> Sent: 07 November 2019 11:28 PM
> To: Rajan Vaja <RAJANV@xilinx.com>
> Cc: mturquette@baylibre.com; sboyd@kernel.org; Michal Simek
> <michals@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; linux-clk@vger.kern=
el.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Tejas=
 Patel
> <TEJASP@xilinx.com>; Radhey Shyam Pandey <radheys@xilinx.com>;
> kernel@pengutronix.de
> Subject: Re: [PATCH] clk: zynqmp: Add support for clock with
> CLK_DIVIDER_POWER_OF_TWO flag
>=20
> EXTERNAL EMAIL
>=20
> On Thu, 07 Nov 2019 00:55:02 -0800, Rajan Vaja wrote:
> > From: Tejas Patel <tejas.patel@xilinx.com>
> >
> > Existing clock divider functions is not checking for
> > base of divider. So, if any clock divider is power of 2
> > then clock rate calculation will be wrong.
> >
> > Add support to calculate divider value for the clocks
> > with CLK_DIVIDER_POWER_OF_TWO flag.
> >
> > Signed-off-by: Tejas Patel <tejas.patel@xilinx.com>
> > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > ---
> >  drivers/clk/zynqmp/divider.c | 36 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.=
c
> > index d8f5b70d..ce63cf5 100644
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
> > @@ -44,9 +44,26 @@ struct zynqmp_clk_divider {
> >  };
> >
> >  static inline int zynqmp_divider_get_val(unsigned long parent_rate,
> > -                                      unsigned long rate)
> > +                                      unsigned long rate, u16 flags)
> >  {
> > -     return DIV_ROUND_CLOSEST(parent_rate, rate);
> > +     int up, down;
> > +     unsigned long up_rate, down_rate;
> > +
> > +     if (flags & CLK_DIVIDER_POWER_OF_TWO) {
> > +             up =3D DIV_ROUND_UP_ULL((u64)parent_rate, rate);
> > +             down =3D parent_rate / rate;
>=20
> Maybe use DIV_ROUND_DOWN_ULL()?
[Rajan] Ok. Will update in next version .

>=20
> > +
> > +             up =3D __roundup_pow_of_two(up);
> > +             down =3D __rounddown_pow_of_two(down);
> > +
> > +             up_rate =3D DIV_ROUND_UP_ULL((u64)parent_rate, up);
> > +             down_rate =3D DIV_ROUND_UP_ULL((u64)parent_rate, down);
> > +
> > +             return (rate - up_rate) <=3D (down_rate - rate) ? up : do=
wn;
>=20
> The calculation looks correct. Maybe there could be a common helper
> with the _div_round_closest() function?
[Rajan] _div_round_closest() is static function, and yes there is divider_r=
ound_rate_parent()
which ultimately uses _div_round_closest(), but it requires divider width w=
hich is not exposed
by firmware to driver.
=20
>=20
> > +
> > +     } else {
> > +             return DIV_ROUND_CLOSEST(parent_rate, rate);
> > +     }
> >  }
> >
> >  /**
> > @@ -78,6 +95,9 @@ static unsigned long zynqmp_clk_divider_recalc_rate(s=
truct
> clk_hw *hw,
> >       else
> >               value =3D div >> 16;
> >
> > +     if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> > +             value =3D 1 << value;
>=20
> Not sure, but I think a small helper similar to _get_div() would help
> with the readability. Just hide the difference between the normal and
> power of two divisors behind some helper functions.
[Rajan] _git_dev() requires divider width which is not exposed
by firmware to user. So _get_div() can't used here. Also, there is no simil=
ar
helper available in linux. Correct me if I am missing something.

Thanks,
Rajan
>=20
> Michael
>=20
> > +
> >       if (!value) {
> >               WARN(!(divider->flags & CLK_DIVIDER_ALLOW_ZERO),
> >                    "%s: Zero divisor and CLK_DIVIDER_ALLOW_ZERO not set=
\n",
> > @@ -120,10 +140,13 @@ static long zynqmp_clk_divider_round_rate(struct
> clk_hw *hw,
> >               else
> >                       bestdiv  =3D bestdiv >> 16;
> >
> > +             if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> > +                     bestdiv =3D 1 << bestdiv;
> > +
> >               return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
> >       }
> >
> > -     bestdiv =3D zynqmp_divider_get_val(*prate, rate);
> > +     bestdiv =3D zynqmp_divider_get_val(*prate, rate, divider->flags);
> >
> >       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_f=
rac)
> >               bestdiv =3D rate % *prate ? 1 : bestdiv;
> > @@ -151,7 +174,7 @@ static int zynqmp_clk_divider_set_rate(struct clk_h=
w
> *hw, unsigned long rate,
> >       int ret;
> >       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> >
> > -     value =3D zynqmp_divider_get_val(parent_rate, rate);
> > +     value =3D zynqmp_divider_get_val(parent_rate, rate, divider->flag=
s);
> >       if (div_type =3D=3D TYPE_DIV1) {
> >               div =3D value & 0xFFFF;
> >               div |=3D 0xffff << 16;
> > @@ -160,6 +183,9 @@ static int zynqmp_clk_divider_set_rate(struct clk_h=
w
> *hw, unsigned long rate,
> >               div |=3D value << 16;
> >       }
> >
> > +     if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
> > +             div =3D __ffs(div);
> > +
> >       ret =3D eemi_ops->clock_setdivider(clk_id, div);
> >
> >       if (ret)
