Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46EFC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3FB222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OIN1MnEa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391125AbfKHLuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:50:11 -0500
Received: from mail-eopbgr00080.outbound.protection.outlook.com ([40.107.0.80]:57742
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388183AbfKHLuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:50:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmXtum3KL9TtYMBGPjMXQ8vki1/K6GKQyfHttHzFp9jT2SZLU2EhQjieM+8pbiy9DkI8Ps4iwihUAut0TAKQ5nmxPsLnBHBXahmTYZ7nrgMetBcmwL+4rj5xBS51nYlvAr3eLla76VQ7vwBarw8mf4eDjYPlXtcJiYcV9xAX6tmE13FzK55ZJjTfOWi2qnEthpKbrQq6GMKdtubSyZeUqEWZrTtZLnZ5fZbjhDEMZ13l097Qce8a8Vt3cpq20Kf/g1rb3OC4xfbXMAdrNyoao4Gte99w+K6uPZokO+PzBXtpbejc8ElATaAdhpdV8wydMsn3ZcAFcQk/uY1lmdxP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL85FRq6GUEqIb1S3M+p28VVKiAEQXD2TKbjWZ/rrpU=;
 b=DRmuZ8Cxk+ymtvAEcYWky0crGWj7d5UO3J982WyBpJwf8U9DpMk7qON+6qQMU/zbDVRmmq62SdZ+1bg+OFeWqGaKtwP4Hzt+TfF9pEQhoAzNH/OqEOlUGUoSfYVF1L6JSCdv4jHluQnwS6HcVjUcooDeS8z0gmhfpeWxI3vY7ng+vxDJF2AC99pcYXMdkvw1yacTsME25n6T7qYiPjXx0l2FagYn3RoZnHb2sEGlIBMWFaid1Ah3U4H3UGsfpZ5pK3h9f+8Z0DqiqQrofaft91qCmGZd+L7yTqB5MkbJHSQHXVAHF5e2qyk/H/HdeCqj5jeXbK3PiaQrZRAJFmALzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL85FRq6GUEqIb1S3M+p28VVKiAEQXD2TKbjWZ/rrpU=;
 b=OIN1MnEa/03XoYLOVhMXk9g6J9pZaU/GiIyEgIMgp+U6ER/nRWxpABUGMssc2n0GZwHL0gcE0ZRDGW9YWmerfF3QSFm/y/AH0VZVbZDBN94NOaauT6EeWFSW6ETPSzYCwhR0OfFneP3ngljQGHZiOAovMBZzlQ/NOXhK5vb0X4g=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4241.eurprd04.prod.outlook.com (52.134.95.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Fri, 8 Nov 2019 11:50:04 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.023; Fri, 8 Nov 2019
 11:50:04 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>
CC:     Leonard Crestez <leonard.crestez@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Topic: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Thread-Index: AQHVH4Y/3naZJOmQTkOgrNdQmlNuA6eCDj6AgAAIBAA=
Date:   Fri, 8 Nov 2019 11:50:03 +0000
Message-ID: <20191108115002.cqzvpxydzwos64vp@fsr-ub1664-175>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <d217a9d2-fc60-e057-6775-116542e39e8d@posteo.de>
 <7d3a868a-768c-3cb1-c6d8-bf5fcd1ddd1c@posteo.de>
 <20191030080727.7pcvhd4466dproy4@fsr-ub1664-175>
 <523f92bd-7e89-b48a-afd0-0a9a8bca8344@posteo.de>
 <20191104103525.qjkxh2zhhgaaectk@fsr-ub1664-175>
 <433f3f03-f780-c327-f1e8-fbf046a8374c@posteo.de>
 <VI1PR04MB70231EA80BB20C9A84B1B799EE790@VI1PR04MB7023.eurprd04.prod.outlook.com>
 <c3519156-9769-980b-d9e7-af372ced8797@posteo.de>
In-Reply-To: <c3519156-9769-980b-d9e7-af372ced8797@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0102CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::25) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 233d9d2a-fc1d-4147-444d-08d76441cb07
x-ms-traffictypediagnostic: AM0PR04MB4241:|AM0PR04MB4241:
x-ms-exchange-purlcount: 4
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4241C258BB0E250555960967F67B0@AM0PR04MB4241.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0215D7173F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(39860400002)(346002)(376002)(396003)(136003)(189003)(199004)(44832011)(6512007)(14454004)(966005)(33716001)(4326008)(7416002)(5660300002)(1076003)(6916009)(99286004)(6486002)(66476007)(229853002)(256004)(71200400001)(71190400001)(66946007)(66556008)(64756008)(66446008)(476003)(316002)(6506007)(102836004)(486006)(3846002)(53546011)(6116002)(11346002)(186003)(446003)(66066001)(386003)(2906002)(86362001)(6436002)(7736002)(81156014)(81166006)(8676002)(305945005)(8936002)(76176011)(9686003)(26005)(54906003)(52116002)(6246003)(478600001)(45080400002)(6306002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4241;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YR6sLKvCr30/CW7DNPmTD6zABJHd3AIfojk0c2u/aqyVRBI3qHZDy+iP1JB1jJ+AgcmujVz3uGgYsGAMPb2fHJSeiiWd95IXzCKGnlInVjShGJNIAeLQT1WH+b8bZOSwsTgv/ZSzRknxPyhhtvFmawsVIxTI2BEc/GPMwpY3Lz9aZg8A35vj7tqt7Zm0Ve9aUH0br0dZd9k34wasHAQBdBBXTMctiR3oYjyJiSoMWPNBCopc/MwR4QA79EIBAhXoians6tXWoqWXelTQ2Zcx/NhEWnYQCIZhrNOch+UK2030svczBkEI7jg4qiwXjja7BM4q8tRKsnoBd5MM4gEdPtnXdDNKgWrMoLlyM5IE8yiPCqj6M3dLHwaefQfA2/3KUP8/DIL77LjH0g94EXstWOQuQm9vX/lz1XWwZ7SrEklcr71+jx7QuS/qDGRm7S+P4isIb/lxYmj4GblKGr8YjlcCt4h8wyKoMuYkksfVKY8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB93741E731CC44CB7CD708840BD8F8C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233d9d2a-fc1d-4147-444d-08d76441cb07
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2019 11:50:04.0336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HMu6batiaO0ACAfzt3sKe4gyVKis40ODSw0tNEjJARWHDgRPNLdU5rNUjdJ18YAakLZ7iVpGogXqP1VyGq5eWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4241
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-11-08 12:21:21, Martin Kepplinger wrote:

> Hi Leonard, hi Abel,
>=20
> Thanks for having a look! To sum up this problem and not to get confused:
>=20
> We have the workaround that changes irq-imx-gpcv2 from this very email
> thread, to be used with mainline ATF. when applying Abel's recent diff,
> Linux 5.4 boots but I still don't have a cpuidle driver.
>=20
> When I enable CONFIG_ARM_PSCI_CPUIDLE, the kernel hangs during boot
> (after probing mmc, but that doesn't tell much)
>=20
> What do I miss?
>=20

OK, please fetch the branches called "imx8mq-err11171" from both following =
github repos and give it a try:

https://github.com/abelvesa/linux.git

and

https://github.com/abelvesa/arm-trusted-firmware.git

I just tested it. Works with defconfig.

>=20
> Then (in parallel) we have NXP's ATF:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsourc=
e.codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2Flog%2F%3Fh%3Dimx_4.19.35_1.0.=
0&amp;data=3D02%7C01%7Cabel.vesa%40nxp.com%7C0a5a09f616c84932e06d08d7643dcc=
af%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637088088896134121&amp;sdat=
a=3Dtq0aUGawG%2FhRRXZB9jdIi2xSNGHINhbWM1ZpDKPFrqU%3D&amp;reserved=3D0
> that I test in parallel (and will actually want to have cpuidle right
> now too). The workaround in Linux in that case looks like so:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsourc=
e.codeaurora.org%2Fexternal%2Fimx%2Flinux-imx%2Fcommit%2F%3Fh%3Dimx_4.19.35=
_1.0.0%26id%3D26a59057f88997dfe48ab7f81898ddd6b6d3903e&amp;data=3D02%7C01%7=
Cabel.vesa%40nxp.com%7C0a5a09f616c84932e06d08d7643dccaf%7C686ea1d3bc2b4c6fa=
92cd99c5c301635%7C0%7C0%7C637088088896134121&amp;sdata=3DGqmtzpS8fB4bxmOXxT=
NQZrWNCV18lNu7XpX5dmcAEaY%3D&amp;reserved=3D0
> which changes irq-gic-v3 only.
>=20

Forget about the NXP arm-trusted-firmware for now. It will never work with =
mainline + the workaround patches.

> Since 5.4, also no cpu-sleep state anymore. What would need to change in
> that "NXP" case, for 5.4 to have cpuidle again?
>=20
> When I enable ARM_PSCI_CPUIDLE here, right now Linux hangs during boot
> (during probing sdhci but again that seems random).
>=20
> I'm still happy for hints :)
>=20
> Thanks,
>=20
>                               martin
>=20
