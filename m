Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94023C28CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62A742085A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 13:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P95vLWNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390348AbfFJN35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 09:29:57 -0400
Received: from mail-eopbgr140078.outbound.protection.outlook.com ([40.107.14.78]:35138
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388833AbfFJN35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 09:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+Akrz1tMgkYolKEEh09/juzcvhS178MvU4WLcvf8Jg=;
 b=P95vLWNA6ej+h5Fz3A9rwkJiKH3jMnUApjOwqaJZX267arUXfNa0ylnBKGJII3KY+NY3O8A7bURLMx40kVRugjO4M1csJ6YPg0fWLRQHyr5HXT2hoB1JDIUjfEz8NKCHwrBRmCK6vwT0qR8XED4nHtCQH55JNfBW+IuSXf8LcUI=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6706.eurprd04.prod.outlook.com (20.179.255.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 10 Jun 2019 13:29:11 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::5c91:9215:bcd9:49cc]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::5c91:9215:bcd9:49cc%5]) with mapi id 15.20.1943.023; Mon, 10 Jun 2019
 13:29:11 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mark Rutland <mark.rutland@arm.com>
CC:     Abel Vesa <abelvesa@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Topic: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Index: AQHVH4Y/3naZJOmQTkOgrNdQmlNuA6aU3y6AgAACvgA=
Date:   Mon, 10 Jun 2019 13:29:11 +0000
Message-ID: <20190610132910.srd4j2gtidjeppdx@fsr-ub1664-175>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <20190610131921.GB14647@lakrids.cambridge.arm.com>
In-Reply-To: <20190610131921.GB14647@lakrids.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e24b38f2-4e22-480a-bd5c-08d6eda79fed
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6706;
x-ms-traffictypediagnostic: AM0PR04MB6706:
x-ms-exchange-purlcount: 4
x-microsoft-antispam-prvs: <AM0PR04MB6706B4AE67D1001BBAD9D6A6F6130@AM0PR04MB6706.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(189003)(199004)(43544003)(73956011)(86362001)(6506007)(76116006)(64756008)(561944003)(66946007)(66446008)(91956017)(8676002)(81156014)(81166006)(1076003)(6306002)(6436002)(5660300002)(9686003)(6486002)(6512007)(66476007)(66556008)(186003)(33716001)(54906003)(53546011)(53936002)(76176011)(8936002)(102836004)(66066001)(6116002)(3846002)(45080400002)(229853002)(14454004)(6246003)(26005)(966005)(7736002)(305945005)(316002)(11346002)(7416002)(446003)(71190400001)(71200400001)(25786009)(14444005)(256004)(44832011)(486006)(68736007)(476003)(2906002)(99286004)(4326008)(6916009)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6706;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jp/b3PGYlNVRq6EPAZO40iqlYv2hPwmsvNE2RXAflLz1TwEmjlww+H7wWye7PTEowitQenA2oi9eUYK8QKYMTJycr5EtyDbZOmNRV3PiZkfEf9UyON+49tzuU5HepINIzh2Bl8oOhHRetzetejHvkxwBJaCM51MQcYUcuSECeKKHt7wlE4o2Hg7+N+zOq6anx1AKkimwzZV9LK3xwurw/RZhdePQwyFLRdZnuQ6XmYC8GnL12MVKvqK0jUTBG0wpWvo4udGbJbcSVLvTbWceu+p71+4ccnNfBcP3u0vKu+l0VENtQWK5CWkLj0GEbezzB7TLVh8mCOiIPLMyzWghI7VRI5boIEBWR5BbAHYKl2W6GbCfGGlrpNL3hjNbww7Az7Y/TqIeDm8FsAwgxgn3kbHN0nveNcxMVeoVYfzu20Y=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FE565A73B09DD54A9E4FF7ECB4905445@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24b38f2-4e22-480a-bd5c-08d6eda79fed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 13:29:11.6633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6706
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-10 14:19:21, Mark Rutland wrote:
> On Mon, Jun 10, 2019 at 03:13:44PM +0300, Abel Vesa wrote:
> > This is another alternative for the RFC:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l.org%2Flkml%2F2019%2F3%2F27%2F545&amp;data=3D02%7C01%7Cabel.vesa%40nxp.com=
%7C05d512f83dfa4d4f52d908d6eda64321%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%=
7C1%7C636957695741584637&amp;sdata=3Dd3X0xyWiaotq4VPNW306wdRhsY4TI%2BBjRSAB=
k6vzf%2B8%3D&amp;reserved=3D0
> >=20
> > This new workaround proposal is a little bit more hacky but more contai=
ned
> > since everything is done within the irq-imx-gpcv2 driver.
> >=20
> > Basically, it 'hijacks' the registered gic_raise_softirq __smp_cross_ca=
ll
> > handler and registers instead a wrapper which calls in the 'hijacked'=20
> > handler, after that calling into EL3 which will take care of the actual
> > wake up. This time, instead of expanding the PSCI ABI, we use a new ven=
dor SIP.
>=20
> IIUC from last time [1,2], this erratum affects all interrupts
> targetting teh idle CPU, not just IPIs, so even if the bodge is more
> self-contained, it doesn't really solve the issue, and there are still
> cases where a CPU will not be woken from idle when it should be (e.g.
> upon receipt of an LPI).
>=20

Wrong, this erratum does not affect any other type of interrupts, other
than IPIs. That is because all the other interrupts go through GPC,
which means the cores will wake up on any other type (again, other than IPI=
).

> IIUC, Marc, Lorenzo, and Rafael [1,2,3] all thought that that this was
> not worthwhile. What's changed?

The fact that this is done in the imx-gpcv2 driver and it's not spread
around like the old RFC. Yes, I agree that fixing something like this
from the core subsystems (like cpuidle) or irq-gic-v3 driver is a bad
idea, but this is not the case anymore with this new RFC.

>=20
> Thanks,
> Mark.
>=20
> [1] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
kml.org%2Flkml%2F2019%2F3%2F28%2F197&amp;data=3D02%7C01%7Cabel.vesa%40nxp.c=
om%7C05d512f83dfa4d4f52d908d6eda64321%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C=
0%7C1%7C636957695741584637&amp;sdata=3DcA5UKbFuZHHnk1599lJi2QXCMTKxCJmPPzoB=
aRhbdCE%3D&amp;reserved=3D0
> [2] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
kml.org%2Flkml%2F2019%2F3%2F28%2F203&amp;data=3D02%7C01%7Cabel.vesa%40nxp.c=
om%7C05d512f83dfa4d4f52d908d6eda64321%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C=
0%7C1%7C636957695741584637&amp;sdata=3DTrWSY3eozWSd0KwZgIprmPazdDno979NqGnV=
jpdzi50%3D&amp;reserved=3D0
> [3] https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
kml.org%2Flkml%2F2019%2F3%2F28%2F198&amp;data=3D02%7C01%7Cabel.vesa%40nxp.c=
om%7C05d512f83dfa4d4f52d908d6eda64321%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C=
0%7C1%7C636957695741584637&amp;sdata=3Dge%2FOXE40T6GSb0x1SmYFXtwLIdyVy1W0Yl=
0EItKyXNU%3D&amp;reserved=3D0
>=20
> >=20
> > I also have the patches ready for TF-A but I'll hold on to them until I=
 see if
> > this has a chance of getting in.
> >=20
> > Abel Vesa (2):
> >   irqchip: irq-imx-gpcv2: Add workaround for i.MX8MQ ERR11171
> >   arm64: dts: imx8mq: Add idle states and gpcv2 wake_request broken
> >     property
> >=20
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 +++++++++++++++
> >  drivers/irqchip/irq-imx-gpcv2.c           | 42 +++++++++++++++++++++++=
++++++++
> >  2 files changed, 62 insertions(+)
> >=20
> > --=20
> > 2.7.4
> > =
