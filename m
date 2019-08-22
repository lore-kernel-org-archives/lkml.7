Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E91DC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97FD2377B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 08:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kFYWucBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfHVIU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 04:20:57 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:44005
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731254AbfHVIU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 04:20:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vohuy/a56J+RB0c/BPZZrnG/qoN0Tq7dgsl7QTO6KpEejaeBRgCVxClXenB2A6RFJH0qZ/kjD9/N24anH/GYD4CeGGg+35Hl8jeVp8dmOdTEUciXrjFZVtz0niJoljSw75wybpwNVKjeGdfpMJHoHah6UebkF+2tm71tXpLc4xfgbxYVTMVbXoNSiPDQOpHgpt5VFAF7Orl8kh7DbM12yGkylsAf2/pe8HjmBarLCnq+xlU5FFfWau8kyp+rio369dSLxlT26+wH6Opf0nc0Y3k2vj5UOPKw+eXFpofktJ/4QbxjmzvMIqmuENCDyt4kIRRbo365KXXZSzvIrpZUYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBHp7PQwrfxLXYCoxyFMboqqH1abiq1Q8BQCOIs+ugk=;
 b=G5WDavEexWnJp+O5hsNwUIdEhCWt4X8V5B3Q6xOQmIWsI7sP+ezexsiiw8rYryvRj3hJTFz6y5NEDBfCBtpewxDwy/8IntDQH+tR2xpTXQOQF+vuq4XU4W7GoStJ7aEm9DnWtULc283NkEmpne9tszjdERPZgMkPYN69TTB47gIf1+hXYvT7SUMpGGTebG01RUa8SuGiq0IuEwZz7hkSjp97ckg0KA4BPHeDmi9tAkZR7+ow7a2mLt8aFohxG/PnDBWdPHkNnUTRcvp9HOYM0mGcEMMJEgk0I1Ofjneemcf8t8eewWbBcB5pF9Uet3Fx5u0riIliDnfUZpwbrj8REg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zBHp7PQwrfxLXYCoxyFMboqqH1abiq1Q8BQCOIs+ugk=;
 b=kFYWucBW0u3gqMbwwgJFfCcpDe6gleEb1wo19nrWdimJldNsJWjQWNvw/OQ0JvrIJS421I1du6AdcCRbKscDkf1/R8dOHaBGnss+vjHdDtRu/49LYlnv0Ge9T9ezhfHYWGLiBQHZOj7jbDqom09SP6NHCDey3GImluDKZPL65ao=
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com (10.186.159.144) by
 VI1PR04MB5598.eurprd04.prod.outlook.com (20.178.125.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Thu, 22 Aug 2019 08:20:53 +0000
Received: from VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e]) by VI1PR04MB7023.eurprd04.prod.outlook.com
 ([fe80::c5e8:90f8:da97:947e%3]) with mapi id 15.20.2178.020; Thu, 22 Aug 2019
 08:20:53 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>
CC:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: imx: pll14xx: avoid glitch when set rate
Thread-Topic: [PATCH] clk: imx: pll14xx: avoid glitch when set rate
Thread-Index: AQHVVv10E+OF2Euht0ilryFWSAJw8w==
Date:   Thu, 22 Aug 2019 08:20:53 +0000
Message-ID: <VI1PR04MB7023C1017F60BF132B6A3F8CEEA50@VI1PR04MB7023.eurprd04.prod.outlook.com>
References: <1566266337-21597-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
x-originating-ip: [2a04:241e:500:9200:e6e7:49ff:fe63:c221]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d2950e3-38f2-470f-5e16-08d726d9a620
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5598;
x-ms-traffictypediagnostic: VI1PR04MB5598:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB5598ED6BD955F43C2FEF4E71EEA50@VI1PR04MB5598.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01371B902F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(39860400002)(396003)(136003)(346002)(189003)(199004)(229853002)(14454004)(53936002)(76116006)(74316002)(66946007)(2501003)(478600001)(86362001)(81166006)(81156014)(4326008)(76176011)(6246003)(52536014)(66446008)(6116002)(66476007)(66556008)(64756008)(33656002)(8936002)(5660300002)(8676002)(186003)(305945005)(476003)(14444005)(256004)(53546011)(6506007)(44832011)(71200400001)(102836004)(71190400001)(46003)(55016002)(25786009)(2906002)(9686003)(99286004)(6636002)(7696005)(6436002)(486006)(54906003)(110136005)(446003)(7736002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5598;H:VI1PR04MB7023.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XGnpm5K/IzcepYQ8VDDHRvktGBUax+XVQZkaYPK0RIrl6VWu7TrLNbm1GYsnKb0lpTJ74+e/2Kn9USEvBojITPc9x004+/oEhr/Qp4rQw4COy+Q7RM+otJsP38ohPcMnq+EuQDvYm4hJ+2p+223zQfOaQzzeldbwz7r2elbDVIqgJEZHaA+kxPrTerIt15HoLgNMP1bLOQ/DJ5ZOyAIXcaPfymXlMklLrUFdf4rMaUkaerhS07j5aKjvX4JkOEahAepBalBI/01T0Rs6OfY9oQh2Xhg94zFwpVFD0AEg00gVxl1ADDaMPPkgY7HN+6LLi/GQY6yK4v4AQhQ+uY4ESPt3xlDU+ECfKbft1uzgucZALviScLJ9s49YigkRShG4XxsV/XAg7Q6WCNOml7bnFixrJaieaBQfV0LHU9tyxKs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2950e3-38f2-470f-5e16-08d726d9a620
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2019 08:20:53.1310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gkCf+oa3sCBfNiXLW0nucUu3I7CkZmWliwiWTobkaGGBGPsJQnyDjGDnSjN7mvT+vik98obzxkwPSo4+TzqH5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5598
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.08.2019 05:17, Peng Fan wrote:=0A=
> According to PLL1443XA and PLL1416X spec,=0A=
> "When BYPASS is 0 and RESETB is changed from 0 to 1, FOUT starts to=0A=
> output unstable clock until lock time passes. PLL1416X/PLL1443XA may=0A=
> generate a glitch at FOUT."=0A=
> =0A=
> So set BYPASS when RESETB is changed from 0 to 1 to avoid glitch.=0A=
> In the end of set rate, BYPASS will be cleared.=0A=
> =0A=
> @@ -191,6 +191,10 @@ static int clk_pll1416x_set_rate(struct clk_hw *hw, =
unsigned long drate,=0A=
>   	tmp &=3D ~RST_MASK;=0A=
>   	writel_relaxed(tmp, pll->base);=0A=
>   =0A=
> +	/* Enable BYPASS */=0A=
> +	tmp |=3D BYPASS_MASK;=0A=
> +	writel(tmp, pll->base);=0A=
> +=0A=
=0A=
Shouldn't BYPASS be set before reset?=0A=
=0A=
Also, isn't a similar bypass/unbypass dance also needed in =0A=
clk_pll14xx_prepare? As far as I understand that could also output =0A=
glitches until the PLL is locked. It could be a separate patch.=0A=
=0A=
It's strange that this BYPASS bit is also handled by muxes like =0A=
audio_pll1_bypass in clk-imx8mm.c but that's a separate issue not =0A=
strictly related to the glitches you're trying to fix here.=0A=
=0A=
--=0A=
Regards,=0A=
Leonard=0A=
