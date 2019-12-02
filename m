Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D0AC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4BC214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 05:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NQnIIpi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfLBFMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 00:12:05 -0500
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:45700
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfLBFME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 00:12:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo+9EO7LxBpQDG5/xYboi8tkFYMp3myorGMSM4oDfn734tAYpQIT8fSiB1HVjnQVLa1q+Sx/vdrY6PTLqD56ZXf4kqWtfaON4eO0MzxGyXqufsM80+TmmyPpEACzJ36+2aRo+nyZeox8WNRR+bcjkNqglz3ZrSM/9k1INx02+2Z2gIn22im9hZ05HX2283/W9y83GI/h9+hSNyBFw+JEK1g704lRwNAUsRre1KQ3PvxNihxIsENof4ulJdkhX2igIH6VX0E+R5d44ZqNbPAwUQTzajSoyQAngIZwANz8HVFLcLVnTbTbRNinUHs9q0JR6OHLLxkK41Zm+mJ7vADWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb2V7EmhsvkGeib2VwpJFua40AIVlAO+p2k1ZHEHfbs=;
 b=Lp+rwPnpZJz2frNYDNS5xq+pjCfLnN/Wh1hjNfgH506IGI11Dgzxn3Yb4LssxUzEmpwblkSJ4OIPUJ7M8jPkU6dt4qQ6A3sx0lL3VHtrReyOKYjLsCbFe9f51+41E8fqHuiGm/hQQvuNUTOXedBCHEpwQ05ib5o4X6ki1JpZYq1Ee6ps0kwsfjhxjTsNUHp0cAK9vA1fMP6kKXS0HxqiJe9476Hz1L0ZAcPTpRK8YaugPi4uxXuVV8vUc3ODkO2tveOs5pTgcVDbniqLLHvn8e2TiGuv+vOeRVnV5nL23oj4fM4AaK+YbfqgKvHWHp8tHsryhONSrxtz4z/K2gEdRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yb2V7EmhsvkGeib2VwpJFua40AIVlAO+p2k1ZHEHfbs=;
 b=NQnIIpi3BuB5+PII8A3mx2QgvzPtQfgUhfnH2IekbP3VOCjkpXZeZE2L1qbI2vA2QJP2B4sgty1F9F11FltIVOGtRuRKc4/n6bYqsmBdJQzDHq5/WV3tBXSof751Be3rYS25VQrRg715A8uoCn5VeYHtntKhZwm1oLwtI0CKRC4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4674.eurprd04.prod.outlook.com (52.135.149.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Mon, 2 Dec 2019 05:12:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 05:12:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     Shawn Guo <shawnguo@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Topic: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based API
Thread-Index: AQHVjl58vmyH5lHO9kisrA51FWxJAKemgOdg
Date:   Mon, 2 Dec 2019 05:11:59 +0000
Message-ID: <AM0PR04MB448194CBA97704849500B72B88430@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
 <1572356175-24950-2-git-send-email-peng.fan@nxp.com>
 <20191202011721.GA17574@dragon>
 <AM0PR04MB4481B7D74A1861558523F21488430@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <VI1PR04MB7023CAEB8ADA6B1CA0907A72EE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB7023CAEB8ADA6B1CA0907A72EE430@VI1PR04MB7023.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [114.220.170.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 916f958b-6607-46c3-67c1-08d776e62927
x-ms-traffictypediagnostic: AM0PR04MB4674:|AM0PR04MB4674:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB46742BDE9CC06EF91189AC9B88430@AM0PR04MB4674.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(26005)(44832011)(99286004)(186003)(71200400001)(256004)(33656002)(71190400001)(76176011)(6436002)(3846002)(53546011)(6506007)(229853002)(7696005)(4326008)(6246003)(6306002)(9686003)(86362001)(55016002)(74316002)(8676002)(6636002)(102836004)(81156014)(2906002)(6116002)(8936002)(81166006)(446003)(11346002)(110136005)(54906003)(66066001)(14454004)(316002)(966005)(76116006)(66946007)(7736002)(66476007)(66556008)(64756008)(66446008)(52536014)(478600001)(5660300002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4674;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DH97Y5D4EyO9dnbDu6Ki5URuZhS93HUfEiVzzBB5t8Bjdls9YeTCHTO/Nyj2TEcinTLz0cC4NYpZuFtVxCKEKul8LkJ85CBRlHOD5eex1LDgoqz+y8Ekd750Ml4iZHUFWhR7SeuKtL5v0ZxOGD4aGOMwkaxiihGfK4M+QiilSWJry5O4NtPpaPvHSyLSa17m+s1+95CTIrcfXB9dGQh80e4yINmPLMRP8n52gPrd2JUNGg4lQlOVdvL/Kgf0/+Bd9Y03SZadaYpVsIdD4Y3LtwYVAqvmyWmJVrzFrwtp4U4ia6+HPLQn0jXO1YaEjGZ8uQ8z7BeDY3AeZbAaOVcYxwPOu/edgfs5RC3daVr8OjZoftFjS8QWOGupr9s6TzxUg3YyVXey26HEojlFL80w4TB0vVTCfUqEdD1dWIxrzl9jt3c9NgVjxCHeEnkg553au7TLqpULL2bAoNmmWPJ/coA9yUzliNoABRidqJutWM4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916f958b-6607-46c3-67c1-08d776e62927
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 05:11:59.9839
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lJykbdQhXbwElO3oePJAZnua6oBz4R5nzIgHaNJV7eqJ/BEenlbhyEAcF0AS9voD+vjEvrCHlKe138jUQULMZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4674
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw based AP=
I
>=20
> On 2019-12-02 4:26 AM, Peng Fan wrote:
> >> Subject: Re: [PATCH 1/7] clk: imx: clk-pll14xx: Switch to clk_hw
> >> based API On Tue, Oct 29, 2019 at 01:40:54PM +0000, Peng Fan wrote:
> >>> From: Peng Fan <peng.fan@nxp.com>
> >>>
> >>> Switch the imx_clk_pll14xx function to clk_hw based API, rename
> >>> accordingly and add a macro for clk based legacy. This allows us to
> >>> move closer to a clear split between consumer and provider clk APIs.
> >>>
> >>> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h index
> >>> bc5bb6ac8636..5038622f1a72 100644
> >>> --- a/drivers/clk/imx/clk.h
> >>> +++ b/drivers/clk/imx/clk.h
> >>> @@ -97,8 +97,12 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
> >>> #define imx_clk_mux(name, reg, shift, width, parents, num_parents) \
> >>>   	imx_clk_hw_mux(name, reg, shift, width, parents,
> >>> num_parents)->clk
> >>>
> >>> -struct clk *imx_clk_pll14xx(const char *name, const char *parent_nam=
e,
> >>> -		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
> >>> +#define imx_clk_pll14xx(name, parent_name, base, pll_clk) \
> >>> +	imx_clk_hw_pll14xx(name, parent_name, base, pll_clk)->clk
> >>> +
> >>
> >> I would suggest to use an inline function for this, which will be
> >> more readable and complying to kernel coding style.
> >
> > ok, I'll send out v2.
>=20
> Blindly dereferencing ->clk will crash instead of propagating errors so y=
ou
> might want to use the to_clk helper from here:
>=20
> https://patchwork.kernel.org/patch/11257811/

I not see Abel's patch applied, should I include Abel's patchset in my v2?
Or I posted out my v2 with only my changes based on Abel's patchset?

Thanks,
Peng.

>=20
> --
> Regards,
> Leonard
