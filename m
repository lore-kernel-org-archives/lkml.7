Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048A4C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F5F2253C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 08:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SVJsieYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfFCIpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 04:45:21 -0400
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:47052
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726653AbfFCIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 04:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsRZSm4Q5uwPKH6PCtg57Kl8pOILzAAs4yb0cXdQ9S4=;
 b=SVJsieYMD3RVfQG3XIh8/o8j3wdB7AJ0XWb/Z0KbqLFJPZZKF/GYRciIAtdlwKs1Nn3Bw0UVgRVccwyJoIbYdkvjeHrln82D9RQCEJsAqxHnj+Ec0G0pgdWP/rUo1BqJoiZZS/CvSeWFAn/iDRE1QaxNot8CxR6x3bGhKh6prkk=
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com (20.177.50.140) by
 VI1PR04MB5405.eurprd04.prod.outlook.com (20.178.121.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.21; Mon, 3 Jun 2019 08:45:16 +0000
Received: from VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1]) by VI1PR04MB5055.eurprd04.prod.outlook.com
 ([fe80::9577:379c:2078:19a1%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 08:45:16 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Topic: [PATCH V2 2/3] clk: imx: Add support for i.MX8MN clock driver
Thread-Index: AQHVGaxdHZzNGD6lS0CX40Io7wcnXg==
Date:   Mon, 3 Jun 2019 08:45:16 +0000
Message-ID: <VI1PR04MB5055D6EB38E84E370E881425EE140@VI1PR04MB5055.eurprd04.prod.outlook.com>
References: <20190603013503.40626-1-Anson.Huang@nxp.com>
 <20190603013503.40626-2-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [192.88.166.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20ad664a-a97c-4f7d-92bd-08d6e7ffcd1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5405;
x-ms-traffictypediagnostic: VI1PR04MB5405:
x-microsoft-antispam-prvs: <VI1PR04MB54057A5A759C2315741C96B9EE140@VI1PR04MB5405.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:85;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(39860400002)(366004)(136003)(199004)(189003)(73956011)(66946007)(5660300002)(8936002)(256004)(33656002)(53936002)(110136005)(81166006)(66476007)(64756008)(55016002)(66446008)(68736007)(4326008)(81156014)(66556008)(9686003)(229853002)(6246003)(316002)(186003)(76116006)(91956017)(6436002)(7416002)(26005)(8676002)(52536014)(99286004)(7736002)(53546011)(86362001)(486006)(305945005)(44832011)(14454004)(71200400001)(71190400001)(6506007)(4744005)(7696005)(102836004)(478600001)(2906002)(76176011)(74316002)(25786009)(3846002)(6116002)(446003)(2201001)(476003)(2501003)(66066001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5405;H:VI1PR04MB5055.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: b+cMDmjrLCiyDc+HtJ7JzACpOq1FoEPFi/g54Ze0MIGQlkBJcTYmhEyksME2cMiIujn+WrYBBroLp/PINgmv36VeS7BobFHKkKyQzkuUZOW7SUnKtcHf7adiJwWBgE3LJSR8IyhMeEIu3Dr6QmJBBwGerjf/nCQXbevFbn992mtIPDaVg7IUXA07lXZDNiWjaZOFkwjyIgWh1c0BBzgoEY35OWC8MUMTzHEixPPw4SqKlENVXAxiHozFghGyvPg7ODHBMKPggXWnkonrx7+5mmz2OkebyHE4/NbU1VZthuYiTiGbpnumN1j1Dn74vt31FsZuKuD8l3biTRKmcv2sEmJhkIpAihJubEaXhe7pjEZuGeSXRXyHBq6X0mgQB7HZ7iIhjc+slQppb8iOkMWafm8zUSTra7xHNt/VI9hENdc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ad664a-a97c-4f7d-92bd-08d6e7ffcd1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 08:45:16.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leonard.crestez@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5405
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/2019 4:33 AM, Anson.Huang@nxp.com wrote:=0A=
> From: Anson Huang <Anson.Huang@nxp.com>=0A=
> =0A=
> This patch adds i.MX8MN clock driver support. =0A=
=0A=
> +#include "clk.h"=0A=
> +=0A=
> +#define PLL_1416X_RATE(_rate, _m, _p, _s)		\=0A=
> +	{						\=0A=
> +		.rate	=3D	(_rate),		\=0A=
> +		.mdiv	=3D	(_m),			\=0A=
> +		.pdiv	=3D	(_p),			\=0A=
> +		.sdiv	=3D	(_s),			\=0A=
> +	}=0A=
> +=0A=
> +#define PLL_1443X_RATE(_rate, _m, _p, _s, _k)		\=0A=
> +	{						\=0A=
> +		.rate	=3D	(_rate),		\=0A=
> +		.mdiv	=3D	(_m),			\=0A=
> +		.pdiv	=3D	(_p),			\=0A=
> +		.sdiv	=3D	(_s),			\=0A=
> +		.kdiv	=3D	(_k),			\=0A=
> +	}=0A=
=0A=
These macros are shared with clk-imx8mm (and perhaps some future chips) =0A=
so they should be moved to driver/clk/imx/clk.h=0A=
