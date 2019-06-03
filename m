Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637AAC28CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398D127CCD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MJMwKFHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFCHcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:32:18 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:63523
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfFCHcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g4q9/O2dGLjm+Le6JzlgAyifZOQAHRKB743xmfbmoE=;
 b=MJMwKFHEp3ciWisy0oaaakdlLbHf/kAmz+KTtV2wqBOOfkKim59lh123TRGvsfpQQaVlqBD2bNrFEMIESbRRxM6qcNApKZ/tIELGs7C+rbJl8vlF3Kq1iRnDY7I5Fzw6RZGhlszTcCqRMWuVBjXOKOyUxHTA4lwnH94gLXkDKi0=
Received: from VI1PR04MB5790.eurprd04.prod.outlook.com (20.178.127.224) by
 VI1PR04MB4078.eurprd04.prod.outlook.com (10.171.183.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 07:32:13 +0000
Received: from VI1PR04MB5790.eurprd04.prod.outlook.com
 ([fe80::607a:a473:5c73:7d7e]) by VI1PR04MB5790.eurprd04.prod.outlook.com
 ([fe80::607a:a473:5c73:7d7e%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 07:32:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
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
        Leonard Crestez <leonard.crestez@nxp.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 3/3] arm64: defconfig: Select CONFIG_CLK_IMX8MN by
 default
Thread-Topic: [PATCH V2 3/3] arm64: defconfig: Select CONFIG_CLK_IMX8MN by
 default
Thread-Index: AQHVGaxef4gq0FBOl0qNeIPzUu861qaJiZIA
Date:   Mon, 3 Jun 2019 07:32:13 +0000
Message-ID: <20190603073212.hgdc4mwqwqvrc6kg@fsr-ub1664-175>
References: <20190603013503.40626-1-Anson.Huang@nxp.com>
 <20190603013503.40626-3-Anson.Huang@nxp.com>
In-Reply-To: <20190603013503.40626-3-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb8b84e5-1676-4817-04d8-08d6e7f5989b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4078;
x-ms-traffictypediagnostic: VI1PR04MB4078:
x-microsoft-antispam-prvs: <VI1PR04MB407811AFEED43EA1EBCA74C1F6140@VI1PR04MB4078.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:489;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(346002)(376002)(366004)(136003)(39860400002)(199004)(189003)(25786009)(99286004)(2906002)(305945005)(6436002)(71190400001)(4744005)(7736002)(476003)(71200400001)(7416002)(102836004)(6512007)(33716001)(9686003)(6862004)(8676002)(11346002)(81166006)(81156014)(53936002)(446003)(8936002)(6486002)(3846002)(1076003)(6246003)(6116002)(54906003)(6636002)(186003)(6506007)(486006)(66946007)(14454004)(76116006)(53546011)(66556008)(66476007)(66446008)(64756008)(86362001)(5660300002)(316002)(68736007)(478600001)(73956011)(66066001)(256004)(26005)(229853002)(4326008)(44832011)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4078;H:VI1PR04MB5790.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Bb+8gDj0J1DBVLMaac/pvmazLYa+LMCcUSBb0L9wlpsdhen6zYi05rtQgqgFrIskep9xmWhGaUYyCn4PkNNA79RAoJYVi8CLAGZU+gG+0XLwNY6F2AOv01mKXcdb2YKzxB5GwYrbJqHOYmjUecj1D4UaQ84b9UWFR1vHAQv0pOwH88HjbyQoVxcVWOEFHvzUpGL0yNYwMaYzA6e6Kp9v7uCEt4KgWDNyyREP9LS83pnwmfiILs5WamysfsIzQ27iyrUA6faYz9+/f41W7M5Fi+QWrc/k828AhXTnr/67e2eQODdO2NFIgfAXCbuqIHE026KjeKxmJVe87aeUtt0v7fm3XHGuZTL0vefTg85rRkDb+eQmCNTRw46YbajR2feCq3HTebiPDS1XTl0+0fofOuDUsAXC8y2BZsd2KxMp1A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A1E0E3CAD1331D4C866338A97F69F3D0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8b84e5-1676-4817-04d8-08d6e7f5989b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 07:32:13.2154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-03 09:35:03, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> Enable CONFIG_CLK_IMX8MN to support i.MX8MN clock driver.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8d4f25c..aef797c 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -654,6 +654,7 @@ CONFIG_COMMON_CLK_CS2000_CP=3Dy
>  CONFIG_COMMON_CLK_S2MPS11=3Dy
>  CONFIG_CLK_QORIQ=3Dy
>  CONFIG_COMMON_CLK_PWM=3Dy
> +CONFIG_CLK_IMX8MN=3Dy

Nitpick: Move this after IMX8MM so it can stay alphabetically ordered.

>  CONFIG_CLK_IMX8MM=3Dy
>  CONFIG_CLK_IMX8MQ=3Dy
>  CONFIG_CLK_IMX8QXP=3Dy
> --=20
> 2.7.4
> =
