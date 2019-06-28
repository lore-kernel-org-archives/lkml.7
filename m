Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920F3C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6CE21738
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ptixmngY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfF1IzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:55:03 -0400
Received: from mail-eopbgr150051.outbound.protection.outlook.com ([40.107.15.51]:48869
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726385AbfF1IzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:55:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=j8KJHSgclwFdRTJKUyyvFtDwYD8MtF093L6zANnfxDJ82aaXIbUNFoP6KgzDv0FmCYySZCDbgdN9WKDm8BlE8xrc8Nx2Rtz4Y2VDiZBKhDXd7rFxzFzi5eEP2ADjbAuWvAAQgfTBoOcMATRkW5go3GPYyJhxoHxZllpLckvC/Xg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+nzyl4zUiJgq2+bT9fuohbdG8XIoMf5/qIeiHjPpzo=;
 b=uoMHusDyyvDzjDJpOx1PMxewF+LaKJkMxqmmlKYFPjcLu7WlwwvU4xQ0DMNkF2dJTNexFtqcKol/EGM5XXKPUrbeld3MoP7R1Jrb/ekJyXzkzKmDOxLu213g0YoNCs0oc2s/nG+UPWJ5jUhUootsuXhIaXZVFXCaJ5vbjJ4+uO0=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+nzyl4zUiJgq2+bT9fuohbdG8XIoMf5/qIeiHjPpzo=;
 b=ptixmngYCB1kaQsOPMcF9pRSO0/qTfOnRxck1KdFsWDPFcVPzzx5clO2gbPbT8FZ13+Y0iQO1J1JQYWVRfiUwpxxuIUolVLIwzCBRESGuqnwPdyzfpBcis8p4lgB30IxofoFdU273Yy3G2fMlOR7esWc/GQ3pVct8Qou3BWdh5E=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5043.eurprd04.prod.outlook.com (20.177.40.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Fri, 28 Jun 2019 08:54:17 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2008.014; Fri, 28 Jun 2019
 08:54:17 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>
CC:     Abel Vesa <abelvesa@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Topic: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Index: AQHVH4Y/3naZJOmQTkOgrNdQmlNuA6apM84AgAerR4A=
Date:   Fri, 28 Jun 2019 08:54:17 +0000
Message-ID: <20190628085417.vezkoizip75yjjpl@fsr-ub1664-175>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <d217a9d2-fc60-e057-6775-116542e39e8d@posteo.de>
In-Reply-To: <d217a9d2-fc60-e057-6775-116542e39e8d@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8338b45-768b-4efc-fdff-08d6fba63439
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5043;
x-ms-traffictypediagnostic: AM0PR04MB5043:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <AM0PR04MB5043F62F7252DA8694073F2CF6FC0@AM0PR04MB5043.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00826B6158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(346002)(396003)(39860400002)(376002)(366004)(136003)(199004)(189003)(43544003)(14454004)(81166006)(6246003)(6916009)(316002)(8676002)(6506007)(66476007)(5660300002)(9686003)(76176011)(11346002)(8936002)(73956011)(81156014)(6436002)(53936002)(91956017)(2906002)(6116002)(44832011)(229853002)(53546011)(561944003)(66556008)(66446008)(3846002)(6512007)(99286004)(64756008)(66946007)(54906003)(6306002)(7416002)(66066001)(446003)(68736007)(1076003)(25786009)(102836004)(71200400001)(86362001)(71190400001)(6486002)(33716001)(186003)(76116006)(966005)(305945005)(7736002)(4326008)(26005)(256004)(45080400002)(476003)(478600001)(486006)(7520500002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5043;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AKdqmSXD0EbCOW7BgjT5uOXWsjXDik2qgStOFbR6qgRz7bpsk+zaROHWc9LqgSnAz28BB6M0eHuiCeKzs81DsbtUtA9OqzLxkZWGJ6F4IbzT5S97Q9KdzfVzViMcDX2lpMCBSy69JEnlARO/q4wYQBc3daX1TUoLvctaZK353YvUmbCmmpH1IlyN1eyXPuScsFI8CN+BoQ2OCSJ6aPtuT26oHv6GXavycM6JgQKAZu1y1Gf4VwIOBIAvkI/xJbNw0IE8U7yUu5e+sj+2fouRmq/iprUxRrLmBWOyDt0TCFatSQgQbm8OxEH+Ym9OVdF8+m5X+dETMpmti8VeU7EGXKjvlFWn3bU+vqIfkuHEpDi5aHa/MIpp9SP5nFtiaB/0oCwYYQYgssi69K1BkTTZuBWOjCU8vYRjLO0+ErU5x+M=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BD94CD1034C6640B6DAF68681C673F5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8338b45-768b-4efc-fdff-08d6fba63439
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2019 08:54:17.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-23 13:47:26, Martin Kepplinger wrote:
> On 10.06.19 14:13, Abel Vesa wrote:
> > This is another alternative for the RFC:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flkm=
l.org%2Flkml%2F2019%2F3%2F27%2F545&amp;data=3D02%7C01%7Cabel.vesa%40nxp.com=
%7C6c9d12c1017745750e3908d6f7d0935a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%=
7C0%7C636968872531886931&amp;sdata=3DDAN3TVPD%2FaQzseYUYAjsnfQM6odM1x8qzsVV=
slFXAnY%3D&amp;reserved=3D0
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
> >=20
> > I also have the patches ready for TF-A but I'll hold on to them until I=
 see if
> > this has a chance of getting in.
>=20
> Let's leave out of the picture for now, how generally applicable and
> mergable your changes are. I'd like to reproduce what you do and test
> cpuidle on imx8mq:
>=20
> When applying your changes here and the corresponding ATF changes (
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu=
b.com%2Fabelvesa%2Farm-trusted-firmware%2Ftree%2Fimx8mq-err11171&amp;data=
=3D02%7C01%7Cabel.vesa%40nxp.com%7C6c9d12c1017745750e3908d6f7d0935a%7C686ea=
1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636968872531886931&amp;sdata=3DnB%2FY=
GkuRrJYwoBJ1afTjIhoadn9Pn3c2QqRFnShWS0c%3D&amp;reserved=3D0 if
> I got that right) I don't yet see any difference in the SoC heating up
> under zero load. __cpu_do_idle() is called about every 1ms (without your
> changes, that was even more often but I'm not yet sure if that means
> anything).

You will most probably not see any change in the SoC temp since the cpuidle
only touches the A53s. There are way many more IPs in the SoC that could
heat it up. If you want some real numbers you'll have to measure the power
consumtion on VDD_ARM rail. If you don't want to go through that much troub=
le
you can use the idlestat tool to measure the times each A53 speends in cpu-=
sleep
state.

>=20
> What I also see is that I get about 10x more "arch_timer" (int.3, GICv3)
> interrupts than without your changes.
>=20
> What am I doing wrong? I'd be happy to test, again, regardless of how
> acceptable the workaround is in the end.
>=20
> thanks,
>=20
>                                   martin=
