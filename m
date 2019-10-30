Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F956CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C2F20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UPIGTtiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfJ3IIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:08:44 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:39271
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725923AbfJ3IIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:08:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAIOak/8r0xqk59mlLEXB0yEMNAJV7KxW9vzHykYWaCMpr/mD56YLrlEYzA68Z9kU6FdM8mzBGJPWLmwowaPv681u/BJjO0/HgYn9s0l9yhG79agz+vAjbe6NkqVg8ruFm3/z/PKovl4EENwmR58XfWKwZthddUp2+4ZC+M2xIKOSdBoWIo03d6FpquIZCbO0CfDPFnLvBmI7OOoiuOKpj5M9L9hOTZuQRBZ3/mr+C7IO7Ug4G4RI9MDx2MDtX+M04Csi6/Vl2Z9b4iRKkPQl0YAIt3coK9aY/4P1F34maITDbJA0hCsiGtUjSyESU7AK551NgjpVuMaozYo2R1SBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLthxlZB1YGbA8aAPO/M6xvpM09nTqQ6mhgHnl9AMlc=;
 b=l46m1WBx52GaGF54sKKrQKtkh/JhUFD3kXn9fspgFOkdf3btfAR8xtREnGUpc1FOKLI0nfVymsz2UmZqAKNwwsDs8Y3wj1kEVacd7BLnd68p29YtHhSjewnTtncA/yhixtc+4GqvaIGJlbDk1zziTo3H5NP1lnzJo0UE2hX2Z7Hi3+ms8ZHqlgXbNjmU5XtAl/F+YcTO5SnZ/vNh3SBWAH+Ji2N+ShYpiKx9RFH6h7PxrNgI0oF6aBIJm9Qc8QHZlpU5tbUPD/oBUn1HefFVGfiKg5hPPrkUqj7T7THoOnycoScYy9iOsQ3KcO6oWpx7AMmlPTdUwMnQfAIq+NtY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLthxlZB1YGbA8aAPO/M6xvpM09nTqQ6mhgHnl9AMlc=;
 b=UPIGTtiWdTo5METWj+WoFkxu2GjIqEu2B9ZHj2UAxdgusiSb538v+CbeFMCRKi/lwtwVb31Zxr/6rI0CP9PXDJFNScGnfR/fWTK+0cKhP2HxBgODPJSFHw4umRUe/4qnAxV34zuhLbdXat2jDXa5kSITDbeIzkTfy9/ETY4Vjl0=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5299.eurprd04.prod.outlook.com (20.177.42.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Wed, 30 Oct 2019 08:08:25 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::4122:fda5:e903:8c02%3]) with mapi id 15.20.2347.033; Wed, 30 Oct 2019
 08:08:25 +0000
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
Thread-Index: AQHVH4Y/3naZJOmQTkOgrNdQmlNuA6apM84AgMpe64CAACCggA==
Date:   Wed, 30 Oct 2019 08:08:25 +0000
Message-ID: <20191030080727.7pcvhd4466dproy4@fsr-ub1664-175>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <d217a9d2-fc60-e057-6775-116542e39e8d@posteo.de>
 <7d3a868a-768c-3cb1-c6d8-bf5fcd1ddd1c@posteo.de>
In-Reply-To: <7d3a868a-768c-3cb1-c6d8-bf5fcd1ddd1c@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0502CA0009.eurprd05.prod.outlook.com
 (2603:10a6:203:91::19) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9085088d-c282-4d29-511d-08d75d10567a
x-ms-traffictypediagnostic: AM0PR04MB5299:|AM0PR04MB5299:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5299BFFCDBA9C7AA302B87C4F6600@AM0PR04MB5299.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02065A9E77
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(189003)(43544003)(199004)(9686003)(186003)(25786009)(305945005)(71190400001)(7416002)(6246003)(561944003)(71200400001)(1076003)(478600001)(66066001)(8676002)(4326008)(45080400002)(81166006)(81156014)(33716001)(54906003)(14454004)(14444005)(476003)(486006)(966005)(8936002)(316002)(256004)(11346002)(446003)(6916009)(386003)(99286004)(6506007)(53546011)(6512007)(44832011)(102836004)(5660300002)(229853002)(7736002)(26005)(66946007)(3846002)(52116002)(6116002)(66476007)(66446008)(64756008)(6486002)(6436002)(86362001)(6306002)(66556008)(2906002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5299;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7JqvnNWss7cofZtOeuqDBy8CwL9sKSgLa79vgkr51eeGoLD6xtCVa+dX7H81XCS4O0vpEmYRDg0GtqXDpcOU+8nUeGVpNN6lJFjEYwFNKZs3YLkMknS0zcdsGca7x8cJLYlmRGMjhQV40SrtN6gAOrG8+MH+YcTZkV1PKVHPaVS7rJ18D10qx+et5JjhRk0rB/NwLUeGRwJXev4xC2MPWUpUpO14pIaYEsJGveSW6eycI4d1unZ9NfFFtn1hXi/E+WpgQcshn3HnQdD+2XpeKa5L+XtFKnasHwEL4+vMhOQasE/ol5xL4g7/ETjRB507ugS9P+WRpKVYrnCTZ6DoI8aZX+a8rJGiW3FZtdD4ajScIx8Eq+JEszT+xGeX8nlAMB+XwvKFjexEVc21foy6TrW/szGm+gZ+jOga+9du7JL0+zfnQNqjUIvy+nvZDShyeLCSa+G9+uCMP/oqJO7CN4s5OhQ8InHT7WzzvPh3kMU=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB8B11A4C0983D4180C46EC0E6D8AF86@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9085088d-c282-4d29-511d-08d75d10567a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2019 08:08:25.0459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7+gJ0utMzMekiEXxQ/dTEVe9TYUq18xFj6vbu5ZhNI8tgka0a1vS66S4u8jCWCFUTvFKV4SSxSwdzFnXTtFJDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5299
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-30 07:11:37, Martin Kepplinger wrote:
> On 23.06.19 13:47, Martin Kepplinger wrote:
> > On 10.06.19 14:13, Abel Vesa wrote:
> >> This is another alternative for the RFC:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flk=
ml.org%2Flkml%2F2019%2F3%2F27%2F545&amp;data=3D02%7C01%7Cabel.vesa%40nxp.co=
m%7Cf5f8d8dd37974234fcb108d75d000944%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0=
%7C1%7C637080127051582184&amp;sdata=3DqZEo1fY1lkTjqZWuuQftYJ5euEsSxjEAqGILC=
Y8ChnU%3D&amp;reserved=3D0
> >>
> >> This new workaround proposal is a little bit more hacky but more conta=
ined
> >> since everything is done within the irq-imx-gpcv2 driver.
> >>
> >> Basically, it 'hijacks' the registered gic_raise_softirq __smp_cross_c=
all
> >> handler and registers instead a wrapper which calls in the 'hijacked'=
=20
> >> handler, after that calling into EL3 which will take care of the actua=
l
> >> wake up. This time, instead of expanding the PSCI ABI, we use a new ve=
ndor SIP.
> >>
> >> I also have the patches ready for TF-A but I'll hold on to them until =
I see if
> >> this has a chance of getting in.
> >=20
>=20
> Hi Abel,
>=20
> Running this workaround doesn't seem to work anymore on 5.4-rcX. Linux
> doesn't boot, with ATF unchanged (includes your workaround changes). I
> can try to add more details to this...
>=20

This is happening because the system counter is now enabled on 8mq.
And since the irq-imx-gpcv2 is using as irq_set_affinity the=20
irq_chip_set_affinity_parent. This is because the actual implementation
of the driver relies on GIC to set the right affinity. On a SoC
that has the wake_request signales linked to the power controller this
works fine. Since the system counter is actually the tick broadcast
device and the set affinity relies only on GIC, the cores can't be
woken up by the broadcast interrupt.

> Have you tested this for 5.4? Could you update this workaround? Please
> let me know if I missed any earlier update on this (having a cpu-sleep
> idle state).
>=20

The solution is to implement the set affinity in the irq-imx-gpcv2 driver
which would allow the gpc to wake up the target core when the broadcast
irq arrives.

I have a patch for this. I just need to clean it up a little bit.
Unfortunately, it won't go upstream since everuone thinks the gic
should be the one to control the affinity. This obviously doesn't work
on 8mq.

Currently, I'm at ELCE in Lyon. Will get back at the office tomorrow
and sned you what I have.

> thanks!
>=20
>                               martin
