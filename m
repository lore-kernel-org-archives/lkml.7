Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3738CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC91721873
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bdjRrpnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfCOCjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:39:54 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:55431
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727499AbfCOCjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSvQqFVM28XbgdBqFDjSxV2VxMGxxBOMjr2c1f+UyXs=;
 b=bdjRrpncu6Pbj66o5fpUvy71SI0IRorY6vI+pxgM7f1EhxuMlXzqr4Nkto+7oiLCxumpMwDslCHYu9p3HTvcoGqlI2kvV0xh7j9QTCFaOZMDjfxxLDZfzCrFFZFndMD72+NuVypseFOZclrv7OoaWGzh5XuQfSkw/pKqg6Cgvag=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6131.eurprd04.prod.outlook.com (20.179.35.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Fri, 15 Mar 2019 02:39:48 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 02:39:48 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Alexandre Bailon <abailon@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "georgi.djakov@linaro.org" <georgi.djakov@linaro.org>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "ptitiano@baylibre.com" <ptitiano@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Zening Wang <zening.wang@nxp.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Subject: RE: [RFC PATCH 0/3] Add support of busfreq
Thread-Topic: [RFC PATCH 0/3] Add support of busfreq
Thread-Index: AQHU2dOsYPsUDFKXNUq2eGEvBhKyoKYL+qcg
Date:   Fri, 15 Mar 2019 02:39:48 +0000
Message-ID: <AM0PR04MB421150DF12C869161E7ED4C180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313193408.23740-1-abailon@baylibre.com>
In-Reply-To: <20190313193408.23740-1-abailon@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [101.93.238.110]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccfdf8ba-ce06-4c8c-39d0-08d6a8ef7dfa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6131;
x-ms-traffictypediagnostic: AM0PR04MB6131:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB6131;23:UQ+e6Luk9Ksq0LbXnis00pegAnLmzSlWwht0VdGuL?=
 =?us-ascii?Q?chol+9ufgRxQO1Nv6e7P8r73u+DQ9rdUxwNEyrxRPWnIvOoeAwMyNN7p3YYj?=
 =?us-ascii?Q?0ANwIg8ytiSwafYoVeeAuuNQ/9+1XUh2+Ylktvt8m/SZ0x+7WaFmOOM4rTrA?=
 =?us-ascii?Q?iHW6ARAX+wdhsJuQHAjYqs1l62dDHBqX7X6P0uUvCVO20/c3HWCIyLVOocAO?=
 =?us-ascii?Q?UhervKLmPsY6zFl9bCL0RSfcpsOJzXC9ZNsYgX1m5fA1tef1HTd4tEARvaJZ?=
 =?us-ascii?Q?7JggoIFXsygy6hNzedhA8+j9ddS+dRyd6BP/Hy57cIESsCgrUDMiq7BgDxz7?=
 =?us-ascii?Q?GUJ1UGJJabTt6W1iY3Jwc9o98YohhDhHoft4YvmgOc700SAPDshiFv5JNYo2?=
 =?us-ascii?Q?KZBR5qlPLAhmngLUh/akNaV2aHK2/dNlPqobWgoGsc6sN0Yex9i8e7lOfICq?=
 =?us-ascii?Q?QMrsgU4iC3ezJdViisXZLeEPpIqMDnPpgfxiaCGQ2vnshyhRw4/SpwgRchiI?=
 =?us-ascii?Q?DdKElQcbT7Dzta9eQDpfiu2KjmBe8/To7wAkX4mUoOR6BzgajSgXZDsJnu0Y?=
 =?us-ascii?Q?hlfZoIuLZBi0mutbQ0N00eEhkhO8kMRIuB3NYLqmgMCJvz9nw6JPWK+OgfMD?=
 =?us-ascii?Q?OvXPpz5dstywWi5Oe4Kft0CM1t8hIYu++htdSxjNVQenpcpfPTvmtarERbEH?=
 =?us-ascii?Q?FxAnLji2iXk1IBZ8Ix1KXVEnllPyvKNTWAOd4vAQzolJL8fD+UKLoqk3/azS?=
 =?us-ascii?Q?eYznb2aeBFzP2FsnT82RwWZFgpghk3e3TEQNz22iLVOIkHGcAKjoAv7h8j98?=
 =?us-ascii?Q?CG6vFqgAmU3eTbsrHxar3qx8EAEZFsT89XGlro/MlWutwmlG9wceSVjoKgKl?=
 =?us-ascii?Q?hrA0A7PKg4JjyjNOvYu6V1FDn3q91lF/4qn1kfb7ZLgI9TMNO35QdEzNwo00?=
 =?us-ascii?Q?evk5DOgCnL0TSxGfZ+xbfVpSZuOTU2q9BbXGKWIjNZzEhefMvAMSjc6dxqLq?=
 =?us-ascii?Q?6ffmLh9b4N+KtqUul29YzpT/050yhA7+b9ZR7RdujFq6aBMmtnrSFRsrVF9c?=
 =?us-ascii?Q?gHp+pTpds4e3yq7aSnqnhLhUIpLcWkwvzBMTVnBzPW7o9W9W9q2arss7gXZt?=
 =?us-ascii?Q?TPvigV8cghzxoNdU0Q+5j6sgyiysQzCyoBPQs2J73k+thc5w5/VbKxDYJy6+?=
 =?us-ascii?Q?NEJOTASAerqlHqzNJyT+0T/zfn/sj6jiPwI55xQJZwMX8hmen9fUlhn55jX7?=
 =?us-ascii?Q?bQPPEni8rxo0AeL5pnWFDY+EH0kNBbsF0q0XWmLztF0HUPaxQ9x/CiHGdi9k?=
 =?us-ascii?B?dz09?=
x-microsoft-antispam-prvs: <AM0PR04MB6131651D7038A797375CC3D080440@AM0PR04MB6131.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(396003)(346002)(136003)(189003)(199004)(7736002)(486006)(186003)(68736007)(8676002)(33656002)(81166006)(305945005)(74316002)(81156014)(6116002)(3846002)(97736004)(55016002)(25786009)(14444005)(6246003)(71200400001)(14454004)(316002)(53936002)(9686003)(2906002)(66066001)(54906003)(6436002)(229853002)(44832011)(7696005)(110136005)(8936002)(102836004)(99286004)(71190400001)(256004)(6506007)(4326008)(76176011)(5660300002)(446003)(2201001)(106356001)(11346002)(105586002)(86362001)(476003)(478600001)(26005)(2501003)(52536014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6131;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0vsEk5LkvvrgWqg0YqwYEHXdFJcQPOxiZ5PmoOwEQmcXy5gNNvcDAYZtWtxkDHtD4qaWM3RRiRSofiBbzN8wMX5W0u/VNe1Dlq9ezSiT/2+0VplIqbCbbJAZPIuuuf2ZVuGkY5uL3OMBXTxxcT50Zoj70We+Xn61eMxC6v/V0TrOPJKrcvggYzFf2yBDgE9NMlKjnVzJtc7m7plFkI8MZ+JurzPS09GbETEiGHpFRca/Xwu6r+G/Z8d92ZPhMePa0lCmmFx6QnADDOBEHXFNduEvCc9BQXn9Lfx+FnWklxNNMp4ievf+dPn5YtA1FslD5ou/GOZv6iqFKxv6DC7oeKMPqUVWjmQb9aWhkaegUditQYHBhY8nFigf0azsIcC9s355aorIjmKyz59wk4dMDB3c03PbqygzH9g1cLAVBaM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfdf8ba-ce06-4c8c-39d0-08d6a8ef7dfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 02:39:48.2724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Jacky and Leonard, Ranjani

Hi Alexandre,

> From: Alexandre Bailon [mailto:abailon@baylibre.com]
>=20
> This series implements busfreq, a framework used in MXP's tree to scale t=
he
> interconnect and dram frequencies.
> In the vendor tree, device's driver request for a performance level, whic=
h is
> used to scale the frequencies.
> This series implements it using the interconnect framework.
> Devices' driver request for bandwidth which is use by busfreq to determin=
e a
> performance level, and then scale the frequency.
>=20
> Busfreq is quite generic. It could be used for any i.MX SoC.
> A busfreq platform driver just have to define a list of interconnect node=
s, and
> some OPPs.
>=20

It's really great to see this patch series.
And it should be the correct direction we're heading to upstream busfreq su=
pport.

> This series is sent as RFC mostly because the current support of i.MX SoC=
 won't
> benefit of busfreq framework, because the clocks' driver don't support
> interconnect / dram frequency scaling.
> As exemple, this series implements busfreq for i.MX8MM whose upstreaming
> is in progress. Because this relies on ATF to do the frequency scaling, i=
t won't
> be hard make it work.
>=20

How can I test this patch series?
Any additional patches you can share with us?
Or what else we need to do to test it? We can help with it.

Regards
Dong Aisheng

> As exemple, this series implements busfreq for Alexandre Bailon (3):
>   drivers: interconnect: Add a driver for i.MX SoC
>   drivers: interconnect: imx: Add support of i.MX8MM
>   dt-bindings: interconnect: Document fsl,busfreq-imx8mm bindings
>=20
>  .../bindings/interconnect/imx8mm.txt          |  24 +
>  drivers/interconnect/Kconfig                  |   1 +
>  drivers/interconnect/Makefile                 |   1 +
>  drivers/interconnect/imx/Kconfig              |  17 +
>  drivers/interconnect/imx/Makefile             |   2 +
>  drivers/interconnect/imx/busfreq-imx8mm.c     | 132 ++++
>  drivers/interconnect/imx/busfreq.c            | 570
> ++++++++++++++++++
>  drivers/interconnect/imx/busfreq.h            | 123 ++++
>  include/dt-bindings/interconnect/imx8mm.h     |  37 ++
>  9 files changed, 907 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interconnect/imx8mm.txt
>  create mode 100644 drivers/interconnect/imx/Kconfig  create mode
> 100644 drivers/interconnect/imx/Makefile  create mode 100644
> drivers/interconnect/imx/busfreq-imx8mm.c
>  create mode 100644 drivers/interconnect/imx/busfreq.c
>  create mode 100644 drivers/interconnect/imx/busfreq.h
>  create mode 100644 include/dt-bindings/interconnect/imx8mm.h
>=20
> --
> 2.19.2
