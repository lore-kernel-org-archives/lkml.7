Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A697C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 684AE207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dYu6Aevx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389839AbfFJMjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:39:01 -0400
Received: from mail-eopbgr130057.outbound.protection.outlook.com ([40.107.13.57]:42580
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388848AbfFJMjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6YDDS76FnnAX7tfmPb+XcBAG8KMw0kWalvWiEA+O1c=;
 b=dYu6AevxYuQDE6VwHdxTyBS/EPh5wTD9SVZJ9AU/2Dx0bL/T8fyOnAgX8xHwjoqYS96T/vkELL0T4tajyPwM39IHzkwXuDmhNfxOFjfTtiC1GCU2VZ2zCecK/waG1kn/n8duVRWiFRfClIhh4U5FEyHCLcJ/jT07/ZYTLwxj1gw=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB3965.eurprd04.prod.outlook.com (10.171.182.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Mon, 10 Jun 2019 12:38:53 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1965.017; Mon, 10 Jun 2019
 12:38:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Abel Vesa <abelvesa@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Carlo Caione <ccaione@baylibre.com>
Subject: Re: [RFC 1/2] irqchip: irq-imx-gpcv2: Add workaround for i.MX8MQ
 ERR11171
Thread-Topic: [RFC 1/2] irqchip: irq-imx-gpcv2: Add workaround for i.MX8MQ
 ERR11171
Thread-Index: AQHVH4ZBRgLS0j7LSki7yl4lFQVwCA==
Date:   Mon, 10 Jun 2019 12:38:52 +0000
Message-ID: <VI1PR04MB5055FD984F9BBA733B4D3503EE130@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190610121346.15779-1-abel.vesa@nxp.com>
 <20190610121346.15779-2-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f54b2d9-b204-4338-e5a7-08d6eda098e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3965;
x-ms-traffictypediagnostic: VI1PR04MB3965:
x-microsoft-antispam-prvs: <VI1PR04MB3965228D534AD46F8F67EAE4EE130@VI1PR04MB3965.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0064B3273C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(39860400002)(136003)(189003)(199004)(55016002)(6436002)(4326008)(14454004)(14444005)(256004)(7416002)(305945005)(316002)(6246003)(9686003)(33656002)(26005)(186003)(25786009)(229853002)(68736007)(53936002)(66066001)(52536014)(76176011)(6116002)(66446008)(64756008)(5660300002)(3846002)(7696005)(7736002)(102836004)(53546011)(6506007)(110136005)(54906003)(99286004)(66556008)(66476007)(478600001)(66946007)(476003)(81166006)(81156014)(8676002)(486006)(74316002)(73956011)(86362001)(8936002)(2906002)(446003)(71200400001)(71190400001)(91956017)(76116006)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3965;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B64whN2MxXL4leNqNExf1XZgqekDJO8u1lPlu9g0iC12FOpqQ53+NgcbZBj9pawzIog/VNYMoOxJ5EWJEL17F6IsqqK3Uq7B9bLbE1X0rSff6pvmqqgAy9B3io/jdKQ93oXS7UtOR0NVuzt0RX+H6IuLKUtzrqVFdp6SGY0N0FDoApl7i0VZUR9ue6jm2ILmhvr6SkuQUQmbYkfIUm9fgYlFKwFGl2i4VGTvCtnEI7rEo0MA52q0BhToaNZNl6u+XgC0ZghlyuVezWUTL2zAf0HpcwMCfsHEW0L945Tiu7czEuYXwLvXVEaYcyW1pnXms3SHYGi901AfFg2eYzsrBVZujxtxTq8lU7VikJySEaBhhMi0x5BUfhJAsiqGqOolqycSPnrR+fuPzZX0VOUNBZGwTjNsGVsmwIBXNgPcokM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f54b2d9-b204-4338-e5a7-08d6eda098e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2019 12:38:53.1317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3965
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/2019 3:15 PM, Abel Vesa wrote:=0A=
> i.MX8MQ is missing the wake_request signals from GIC to GPCv2. This indir=
ectly=0A=
> breaks cpuidle support due to inability to wake target cores on IPIs.=0A=
> =0A=
> Now, in order to fix this, we can trigger IRQ 32 (hwirq 0) to all the cor=
es by=0A=
> setting 12th bit in IOMUX_GPR1 register. In order to control the target c=
ores=0A=
> only, that is, not waking up all the cores every time, we can unmask/mask=
 the=0A=
> IRQ 32 in the first GPC IMR register.=0A=
> =0A=
> Since EL3 is the one that deals with powering down/up the cores, and sinc=
e the=0A=
> cores wake up in EL3, EL3 should be the one to control the IMRs in this c=
ase.=0A=
> This implies we need to get into EL3 on every IPI to do the unmasking, le=
aving=0A=
> the masking to be done on the power-up sequence by the core itself.=0A=
=0A=
Manipulating same IMR registers in TF-A and Linux is racy so all IMR =0A=
manipulation (set_wake etc) needs to be done through SIP calls with =0A=
locking inside TF-A.=0A=
=0A=
It would make sense to have an entirely separate SIP-based =0A=
irq-imx8mq-gpc.c driver based on what is used in NXP tree.=0A=
=0A=
> +	iomux_gpr =3D syscon_regmap_lookup_by_compatible("fsl,imx6q-iomuxc-gpr"=
);=0A=
> +	if (!IS_ERR(iomux_gpr))=0A=
> +		regmap_update_bits(iomux_gpr, IOMUXC_GPR1, IMX6Q_GPR1_GINT,=0A=
> +					IMX6Q_GPR1_GINT);=0A=
=0A=
Doesn't this initialization belong in TF-A? On boot enable the irq and =0A=
keep it masked until somebody calls "wake".=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
