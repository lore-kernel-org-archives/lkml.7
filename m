Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD38C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF8D92070B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AAkf3Fhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbfHZJnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:43:04 -0400
Received: from mail-eopbgr60050.outbound.protection.outlook.com ([40.107.6.50]:64203
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729320AbfHZJm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBObm3zD3qkWwlxo+AYFpWi6ZJVEDQWh1OjXkIaKwaLsTbf/ZtCZHIAAVUM7haKoqEn2u5qk8nszVauS7wOFgKgLThTYHknGDATGHoRpDUgi23kkjvwPLApULe3fRs96ecXeZURbadBFzZCQc4LABRLllUlqAq4lNwpRWWTlM5JfsesgvE0nUVAW11aBrwgkQL00r6Z/NErxwh52eBRc5VLJIHUWrtH5VKmX1cboyWHIoDKSPQ9rt56k5irNSghPMWRfnbWTceQ/2BAVOV+21HUIbiHZZ76hBdkmo+2HwS5262wM4OMiqdKPH7JBAIl3UFnl09tY5zo3xFkcbrOLOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8af/frXjd38yFS1iHWXqIhZ3UJI97y8DlOSShgwFJCI=;
 b=Z1oKbl0ct+2hHPzirT8O9KEfPyQOEJEcHIef82403IhxGHf/AtDVAuGdmJroaKKUG2MQ/9qTJa8c+vVP8XynXNEocNKj3tI2IA5vevi4b1vOEF+j0NWDqNPRBixdg/EIZj26E8Y3wgFZutr+M+7kysfdoSrDTGV/L0Ss39At7jCkEkGoU7TU+rh+R+YJoxEYrYsrbJ4gOlfZQuRlqAgQ9QzNPdppZQoDzwrTlQC1H1aAa5LJB0Z8Z/aWO3TjODpU3G7whoi2qiT6fbvxgwPLfudkCVB3KocN/KLVVKvtiMhktEd7dKhsYHP9yQ4zCWF8RE9jzxw10//0IYKcLnDsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8af/frXjd38yFS1iHWXqIhZ3UJI97y8DlOSShgwFJCI=;
 b=AAkf3FhiCcR4p8xHyIIaTTOskzxuN3aRjizsLKkAB50vk4Pj4UqRATxbnrC39Qt/L6fowPQpqEFT9R7f46byo5B+cwA3T36V2cTo3Sc6HYsYw7oRr0jYRdCr5xW4vTH4O67LNtwARIavBZHxUCbFpIg6bLfkgNWIIxEwHYIarbI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4194.eurprd04.prod.outlook.com (52.134.126.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Mon, 26 Aug 2019 09:42:19 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::5d98:e1f4:aa72:16b4%4]) with mapi id 15.20.2178.022; Mon, 26 Aug 2019
 09:42:19 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/4] clk: imx: clk-pll14xx: unbypass PLL by default
Thread-Topic: [PATCH V2 2/4] clk: imx: clk-pll14xx: unbypass PLL by default
Thread-Index: AQHVW/KNXPUGosN6ZEmtCpcLIOxLdQ==
Date:   Mon, 26 Aug 2019 09:42:19 +0000
Message-ID: <1566855676-11510-2-git-send-email-peng.fan@nxp.com>
References: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1566855676-11510-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR04CA0047.apcprd04.prod.outlook.com
 (2603:1096:202:14::15) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a5d27da-8f83-4749-3800-08d72a09aff5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4194;
x-ms-traffictypediagnostic: AM0PR04MB4194:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB41949DEF795833B2B5C4125688A10@AM0PR04MB4194.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(189003)(199004)(478600001)(2501003)(25786009)(66066001)(81166006)(81156014)(66476007)(44832011)(7736002)(486006)(305945005)(2616005)(476003)(36756003)(8676002)(66946007)(66556008)(66446008)(64756008)(14454004)(316002)(110136005)(54906003)(6116002)(256004)(8936002)(50226002)(2201001)(99286004)(4326008)(6512007)(2906002)(86362001)(53936002)(386003)(76176011)(71200400001)(71190400001)(6506007)(102836004)(186003)(11346002)(446003)(26005)(5660300002)(52116002)(3846002)(6436002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4194;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hZzKvHJAKezKpFqgA20Cxl+b4vUj3KPVbEEe4kQb1Tv+itPUXrmjJm6wUqPKEsD0vyvtkfQCtWc+ZZS+zgZewY5kDQLaSdqbNrJqXLS7Xjf2CaKIrWi3OwOmp5hCARAlEWK0zCFwY5duj98EakiZuj3xLDKb5VA1TFdH797oeybLj5nNMdUCmPDgIDG8Hv+tkmSobeNx2Xon+3PGw4QaIuF4DH7rOOYpB4uKPjlDlZq0cWSEBkb/SaJs7DchMj3+673Th5nJS4m4TpUgt5LrKOTbjQ4JScHQbyS9E15bsPrRJj0V4NpPyrqBso0W/oSNDC5EJsgmzRpxd/LHGXUOOb9JnnJWV3joKnY0+DyZsgie/wFcAZS4gU1WcD1EgPCkzNHX0HK7grTbJ6On+o2whQ96SSmAXJTbOciIQEaCvoo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5d27da-8f83-4749-3800-08d72a09aff5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 09:42:19.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3jDLbEqmKRi8qczEJP1cvM0aU8iMYPBzlfYduQErkpu+owVY1njy5cr1c0LNVlGFI9/taeKsuqGteYPQyh+aVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When registering the PLL, unbypass the PLL.
The PLL has two bypass control bit, BYPASS and EXT_BYPASS.
we will expose EXT_BYPASS to clk driver for mux usage, and keep
BYPASS inside pll14xx usage. The PLL has a restriction that
when M/P change, need to RESET/BYPASS pll to avoid glitch, so
we could not expose BYPASS.

To make it easy for clk driver usage, unbypass PLL which does
not hurt current function.

Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 New patch

 drivers/clk/imx/clk-pll14xx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
index 656f48b002dd..7a815ec76aa5 100644
--- a/drivers/clk/imx/clk-pll14xx.c
+++ b/drivers/clk/imx/clk-pll14xx.c
@@ -368,6 +368,7 @@ struct clk *imx_clk_pll14xx(const char *name, const cha=
r *parent_name,
 	struct clk_pll14xx *pll;
 	struct clk *clk;
 	struct clk_init_data init;
+	u32 val;
=20
 	pll =3D kzalloc(sizeof(*pll), GFP_KERNEL);
 	if (!pll)
@@ -399,6 +400,10 @@ struct clk *imx_clk_pll14xx(const char *name, const ch=
ar *parent_name,
 	pll->rate_table =3D pll_clk->rate_table;
 	pll->rate_count =3D pll_clk->rate_count;
=20
+	val =3D readl_relaxed(pll->base + GNRL_CTL);
+	val &=3D ~BYPASS_MASK;
+	writel_relaxed(val, pll->base + GNRL_CTL);
+
 	clk =3D clk_register(NULL, &pll->hw);
 	if (IS_ERR(clk)) {
 		pr_err("%s: failed to register pll %s %lu\n",
--=20
2.16.4

