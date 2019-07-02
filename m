Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E61C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0AF2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A670eYfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGBLdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:33:13 -0400
Received: from mail-eopbgr30068.outbound.protection.outlook.com ([40.107.3.68]:10973
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbfGBLdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgNTgyvso+z+ZP1qR1z0yAxDqeV2cXUiKrtSM6Dduk0=;
 b=A670eYfBUegSYJR4ZlolkwFHKEuNaUZSHbclSzvF+CzbQM+cptmN5sRtsVEpEJ996zIVpRVHBko55AKUW3ePIADP1W80wz5mLLs9Cmjd8IcG+Z5tdseRCv75+eftGukg5jvQm3p8R6SE7oIXfVuogXErr67Cg0sf4HYm9VA+vMI=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4689.eurprd04.prod.outlook.com (20.176.214.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 11:33:06 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 11:33:06 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Abel Vesa <abelvesa@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Topic: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Index: AQHVH4Y/3naZJOmQTkOgrNdQmlNuA6apM84AgAerR4CABiXagIAAT9iA
Date:   Tue, 2 Jul 2019 11:33:06 +0000
Message-ID: <20190702113305.zo2w5xkfhsfpwrx7@fsr-ub1664-175>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <d217a9d2-fc60-e057-6775-116542e39e8d@posteo.de>
 <20190628085417.vezkoizip75yjjpl@fsr-ub1664-175>
 <a6ea252e-cfd4-0816-e688-3d792e956711@posteo.de>
In-Reply-To: <a6ea252e-cfd4-0816-e688-3d792e956711@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adc9ebf1-571f-4cf8-095b-08d6fee10d72
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4689;
x-ms-traffictypediagnostic: AM0PR04MB4689:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB4689208CE8B2DCA34B88E2F0F6F80@AM0PR04MB4689.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(136003)(366004)(396003)(39860400002)(376002)(43544003)(199004)(189003)(14454004)(76176011)(26005)(86362001)(229853002)(6486002)(99286004)(186003)(7416002)(54906003)(6506007)(53546011)(102836004)(561944003)(68736007)(2906002)(6436002)(25786009)(966005)(8676002)(7520500002)(446003)(4326008)(11346002)(316002)(8936002)(486006)(476003)(81156014)(81166006)(44832011)(6116002)(3846002)(66446008)(1076003)(33716001)(91956017)(76116006)(73956011)(66946007)(66066001)(66476007)(66556008)(64756008)(5660300002)(478600001)(53936002)(45080400002)(6306002)(7736002)(305945005)(71200400001)(256004)(6512007)(9686003)(6246003)(71190400001)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4689;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TMo+ZiVOFRcwCsLsM2xgNRtb4qdFYDAJRj+3/1C90xnsXGo2doRvLp6LH6evjaX98jeXLqOttOr3zZXzYBBX4P6X0ig9mEkq3Fi4L9Q4EO8zkvJp1saHFJESrdungqqX3F8yUnfChKEziZxNI3+/drSbo3TUWS4Yw+bG7qcCpnrIIfRho1crNZ/WhN4EySrATcHY8N7cn9oaP8+yEMYFzHGPpNZXbRCyenNweXkL3rmaLgLjjuVqj4n8qkZ8lVvPZLCmr/PzxEqfUSj6VfjmefyYP4ZY3uH3uoSgQSZ8FfFHEuqXTm3lFWB+eNlZ1EM3F6wt+PpS1musGlk9hsJugfxFZwlNG2canlzrpTZPGGMylRaSSoj/9DddhBJt3/BDEiXMVXJ/jlubiQ4r9b3ehR4v/0P+jRdhKM0lsH8lL6g=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C35434DD3C7F845B1D816C8CEB645CB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc9ebf1-571f-4cf8-095b-08d6fee10d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 11:33:06.4968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-02 08:47:19, Martin Kepplinger wrote:
> On 28.06.19 10:54, Abel Vesa wrote:
> > On 19-06-23 13:47:26, Martin Kepplinger wrote:
> >> On 10.06.19 14:13, Abel Vesa wrote:
> >>> This is another alternative for the RFC:
> >>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fl=
kml.org%2Flkml%2F2019%2F3%2F27%2F545&amp;data=3D02%7C01%7Cabel.vesa%40nxp.c=
om%7Ccfc582f9977d479b7dda08d6feb9258a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C=
0%7C0%7C636976468485275045&amp;sdata=3DL%2Byn29%2FBS3KMjm9eCPBTZBTl30PmZywS=
jIj11bMQw5c%3D&amp;reserved=3D0
> >>>
> >>> This new workaround proposal is a little bit more hacky but more cont=
ained
> >>> since everything is done within the irq-imx-gpcv2 driver.
> >>>
> >>> Basically, it 'hijacks' the registered gic_raise_softirq __smp_cross_=
call
> >>> handler and registers instead a wrapper which calls in the 'hijacked'=
=20
> >>> handler, after that calling into EL3 which will take care of the actu=
al
> >>> wake up. This time, instead of expanding the PSCI ABI, we use a new v=
endor SIP.
> >>>
> >>> I also have the patches ready for TF-A but I'll hold on to them until=
 I see if
> >>> this has a chance of getting in.
> >>
> >> Let's leave out of the picture for now, how generally applicable and
> >> mergable your changes are. I'd like to reproduce what you do and test
> >> cpuidle on imx8mq:
> >>
> >> When applying your changes here and the corresponding ATF changes (
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
thub.com%2Fabelvesa%2Farm-trusted-firmware%2Ftree%2Fimx8mq-err11171&amp;dat=
a=3D02%7C01%7Cabel.vesa%40nxp.com%7Ccfc582f9977d479b7dda08d6feb9258a%7C686e=
a1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636976468485275045&amp;sdata=3DVT3du=
Sl70DNxcY8Ev4FFrHlWoOjkcckeM8BgxrSkr8A%3D&amp;reserved=3D0 if
> >> I got that right) I don't yet see any difference in the SoC heating up
> >> under zero load. __cpu_do_idle() is called about every 1ms (without yo=
ur
> >> changes, that was even more often but I'm not yet sure if that means
> >> anything).
> >=20
> > You will most probably not see any change in the SoC temp since the cpu=
idle
> > only touches the A53s. There are way many more IPs in the SoC that coul=
d
> > heat it up. If you want some real numbers you'll have to measure the po=
wer
> > consumtion on VDD_ARM rail. If you don't want to go through that much t=
rouble
> > you can use the idlestat tool to measure the times each A53 speends in =
cpu-sleep
> > state.
> >=20
> >>
> >> What I also see is that I get about 10x more "arch_timer" (int.3, GICv=
3)
> >> interrupts than without your changes.
>=20
>=20
> thanks for getting back at me here. This is run on the imx8mq
> librem5-devkit with your wakeup-workaround applied. Typical measurements
> under zero load look like this:
>=20
> sudo idlestat --trace -f /tmp/mytrace -t 10 -p -c -w
> Log is 10.000395 secs long with 31194 events
> ------------------------------------------------------------------------
> | C-state  |  min   |  max    |  avg    |  total | hits | over | under |
> ------------------------------------------------------------------------
> | clusterA                                                             |
> ------------------------------------------------------------------------
> |     WFI |   14us |  3.99ms |  3.90ms |   9.93s | 2543 |    0 |     0 |
> ------------------------------------------------------------------------
> |          cpu0                                                        |
> ------------------------------------------------------------------------
> |     WFI |   14us |  3.99ms |  3.89ms |   9.96s | 2561 |    0 |     0 |
> ------------------------------------------------------------------------
> ...
>=20

I don't see the cpu-sleep state at all in your idlestat log. Maybe the cpui=
dle
isn't enabled. Or probably the workaround itself is not applied. You'll hav=
e
to look into that.

Here is how it looks like with the workaround enabled:

Log is 10.001685 secs long with 1175 events
---------------------------------------------------------------------------=
-----
| C-state  |   min    |   max    |   avg    |   total  | hits  |  over | un=
der |
---------------------------------------------------------------------------=
-----
| clusterA                                                                 =
    |
---------------------------------------------------------------------------=
-----
|      WFI |      2us |  50.04ms |  29.63ms |    9.99s |   337 |     0 |   =
  0 |
---------------------------------------------------------------------------=
-----
|             cpu0                                                         =
    |
---------------------------------------------------------------------------=
-----
|      WFI |     11us |  50.04ms |  40.44ms |    9.62s |   238 |     0 |   =
219 |
| cpu-sleep |    537us |  50.58ms |  14.11ms | 366.94ms |    26 |     7 |  =
   0 |
---------------------------------------------------------------------------=
-----
|             cpu1                                                         =
    |
---------------------------------------------------------------------------=
-----
|      WFI |     11us | 539.04ms |  93.20ms |    5.78s |    62 |     0 |   =
 38 |
| cpu-sleep |    536us | 607.90ms | 183.38ms |    4.22s |    23 |    12 |  =
   0 |
---------------------------------------------------------------------------=
-----
|             cpu2                                                         =
    |
---------------------------------------------------------------------------=
-----
|      WFI |     41us | 265.99ms |  17.51ms | 332.66ms |    19 |     0 |   =
 11 |
| cpu-sleep |    568us |    6.56s |    1.38s |    9.67s |     7 |     2 |  =
   0 |
---------------------------------------------------------------------------=
-----
|             cpu3                                                         =
    |
---------------------------------------------------------------------------=
-----
|      WFI |   7.94ms | 881.50ms | 367.81ms |    1.10s |     3 |     0 |   =
  3 |
| cpu-sleep |    549us |    2.02s | 808.72ms |    8.90s |    11 |     1 |  =
   0 |
---------------------------------------------------------------------------=
-----

You can see that the cpu2 was once for 6.56 seconds (out of 10s) in cpu-sle=
ep.

>=20
> with IRQs coming in:
>=20
> -------------------------------------------------------
> | IRQ |       Name      |  Count  |  early  |  late   |
> -------------------------------------------------------
> |             cpu0                                    |
> -------------------------------------------------------
> | IPI | Reschedulin     |      11 |       0 |       0 |
> | 3   | arch_timer      |    2505 |       0 |       0 |
> | 41  | 30be0000.ethern |      11 |       0 |       0 |
> | 36  | mmc0            |       6 |       0 |       0 |
> | 33  | 30a20000.i2c    |      12 |       0 |       0 |
> | 40  | 30be0000.ethern |       1 |       0 |       0 |
> | 43  | 38000000.gpu    |       2 |       0 |       0 |
> | 208 | dcss_drm        |      12 |       0 |       0 |
> | 207 | dcss_ctxld      |       2 |       0 |       0 |
> -------------------------------------------------------
> |             cpu1                                    |
> -------------------------------------------------------
> | IPI | Reschedulin     |      13 |       0 |       0 |
> | 3   | arch_timer      |    2500 |       0 |       0 |
> | IPI | Functio         |       1 |       0 |       0 |
> ...
>=20
>=20
> So we seem to spend most of the time in C1/WFI. As mentioned,
> "arch_timer" wakes up the cpu often.
>=20
> Why is that? Do these measurements look like what you would expect them
> to be?
>=20
> (I'm not sure how much sense it makes to come up with something to
> compare these to)
>=20
> thanks a lot,
>=20
>                                 martin
>=20
> =
