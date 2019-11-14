Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB49C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73117206E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 03:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NAE9awcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfKNDi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 22:38:27 -0500
Received: from mail-eopbgr20040.outbound.protection.outlook.com ([40.107.2.40]:13118
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726393AbfKNDi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 22:38:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfWeCTYU0cZTsKNxEZCFmH6lfdU2dvfUGYtjmXM1ud616u8BEDUO2glRYa/vKIkHrkkhTc/Uzrz92msJSZYTMlNXYpPlexbGaNtylYjYIiuFh9b1vI6Qsw1VQvW8HCgS0BHtszNVpr/fHz/lNlsOm/QTwJjW7xLp+j17+gjDtZ/DcRdVBDRaprirD8lSLVzEaNLfqawn2qdhdVbwQL4giRLLgUQyhQSeTolucpiwHcbdkVR0ZEYeelxbChDOr2UYwqhY/JKSuZwt4czFJesu4oGxAoBaqvajXy6c0KSeo8pEAk/pvGh2AJlOx2BorBcoEwVZwegBGwQ7lWf7JSKEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwDoOPplVVWmM4FL4TrbrZgTJYQ5a3XuMkq+5Ilz0l8=;
 b=cNCK6hKbdLc7pIpAgUVKk42BS1Z9hSADnDe2oZrxoXvwQq8CZdCAXrOWFVMaACStcvUSM/n9/sG27ACoq2uw/B4zZGUoKVOv4mUd3KIxLl2aufr+0k2+c/JisU72LV5uLre6TrmacJdeq2R/rbI5qbLAFukAJr805NqHdjCL2y39UWaEWzPO/sZpPa/tTPZklh8K5YE8gRni2hM4/ZS6CnKCy7J/JPfef/tzm6PNWWAj7BZg2wiEKTD6SWr6J6RtQx0bp5xbShRJS54AhDk815v1iZ7FAy5ab16uwFo2QzuQob8n2udklA8hF1YKzB6u/TrppLLJyZA2YhTdPxNp8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwDoOPplVVWmM4FL4TrbrZgTJYQ5a3XuMkq+5Ilz0l8=;
 b=NAE9awcgq072S+4zk3SegiX3zeVYKZOGz6NCKJ+hiVEjs7aqEaC+TPjaCgNSJDLU8GiBmLBJ7oz0TvCK7UZJ2m/uLP3JQRgAyuESPKgtXZc89WHDD0+b3LEwd94iou2jt5jFuyJHJsyJRUpVo0cjPet9lnziE5TPgJcLK9GUvK4=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4994.eurprd04.prod.outlook.com (20.176.215.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Thu, 14 Nov 2019 03:38:23 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.024; Thu, 14 Nov 2019
 03:38:23 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Alice Guo <alice.guo@nxp.com>,
        "will@kernel.org" <will@kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/4] clk: imx: sccg: use relaxed io api
Thread-Topic: [PATCH V2 3/4] clk: imx: sccg: use relaxed io api
Thread-Index: AQHVmpz3UF9PMPyc9Ee3JLDaqOkCIg==
Date:   Thu, 14 Nov 2019 03:38:23 +0000
Message-ID: <1573702559-2744-4-git-send-email-peng.fan@nxp.com>
References: <1573702559-2744-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1573702559-2744-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::21) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f4e93ff-f1e4-4c37-11f6-08d768b419aa
x-ms-traffictypediagnostic: AM0PR04MB4994:|AM0PR04MB4994:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4994205DE3E5EEE2550F3EB088710@AM0PR04MB4994.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(199004)(189003)(66066001)(305945005)(14454004)(36756003)(71200400001)(71190400001)(7736002)(2501003)(99286004)(4326008)(486006)(81156014)(81166006)(25786009)(86362001)(44832011)(2616005)(476003)(50226002)(446003)(11346002)(8676002)(8936002)(52116002)(76176011)(186003)(478600001)(6506007)(386003)(6486002)(6512007)(6436002)(2201001)(102836004)(26005)(316002)(5660300002)(54906003)(110136005)(256004)(14444005)(3846002)(6116002)(66556008)(6636002)(66446008)(66946007)(64756008)(66476007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4994;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhK0Khxo0bE9fm7FXU52n9RSZB41cBOtEKsZtJ4GJN//4VX5SZAyx/CiFuRCPdciiEXyJ8+QR1z2SjdZASOkFXgDjHL9uVy3Kny2HkZoJL2lj0xLLp0vl8SnQETz7TvjOKMHfd2bXX/SFkY0fb/JF1FetRyOKL4RV10Ra5/J4Kg14m0k8X8DzBCEMJ4Xau2uqfNmNtKsZLTdO51C7DFDFN9wJ69KWZv3qyqgHvR8+nkjiOktZLwMy6FsQL8xZHYjhYqivsuCQgVMdZsNNB3Am7M7MJukaB2ELXS4BJAh1b8O3rPOYA3tCo6EMVvk/DZTu3ai5dhrfLz+BvSBmPCr7AADjY/YM7USbjT9hcJTbub8MaokWlTItFY2LDM25T1zaCloUKvD48XHgtLoJoJoQ2rnkOjSax5ZE6iiE8/aX/sPULCrIs3i3R5+7gP8TFns
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4e93ff-f1e4-4c37-11f6-08d768b419aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 03:38:23.1791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9guOHkUnk0JPSGajIDKTjnvYdVYfUxoQSHujEnBpBujohcJE5lBXfY7Gbsc0+Rgiq9HW42/Aab31yz1e7YZYrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4994
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

writel/readl has a barrier, however that barrier is not needed,
because device memory mapping is nGnRE mapping and access is
in order and clk driver has spin lock or other lock to make
sure write finished. It is ok to use relaxed api here, no need
to use stronger readl/writel

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-sccg-pll.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.=
c
index 2cf874813458..e03f8acb1e82 100644
--- a/drivers/clk/imx/clk-sccg-pll.c
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -106,8 +106,9 @@ static int clk_sccg_pll_wait_lock(struct clk_sccg_pll *=
pll)
=20
 	/* don't wait for lock if all plls are bypassed */
 	if (!(val & SSCG_PLL_BYPASS2_MASK))
-		return readl_poll_timeout(pll->base, val, val & PLL_LOCK_MASK,
-						0, PLL_SCCG_LOCK_TIMEOUT);
+		return readl_relaxed_poll_timeout(pll->base, val,
+						  val & PLL_LOCK_MASK,
+						  0, PLL_SCCG_LOCK_TIMEOUT);
=20
 	return 0;
 }
@@ -349,7 +350,7 @@ static unsigned long clk_sccg_pll_recalc_rate(struct cl=
k_hw *hw,
=20
 	temp64 =3D parent_rate;
=20
-	val =3D readl(pll->base + PLL_CFG0);
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
 	if (val & SSCG_PLL_BYPASS2_MASK) {
 		temp64 =3D parent_rate;
 	} else if (val & SSCG_PLL_BYPASS1_MASK) {
@@ -372,10 +373,10 @@ static int clk_sccg_pll_set_rate(struct clk_hw *hw, u=
nsigned long rate,
 	u32 val;
=20
 	/* set bypass here too since the parent might be the same */
-	val =3D readl(pll->base + PLL_CFG0);
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
 	val &=3D ~SSCG_PLL_BYPASS_MASK;
 	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, setup->bypass);
-	writel(val, pll->base + PLL_CFG0);
+	writel_relaxed(val, pll->base + PLL_CFG0);
=20
 	val =3D readl_relaxed(pll->base + PLL_CFG2);
 	val &=3D ~(PLL_DIVF1_MASK | PLL_DIVF2_MASK);
@@ -396,7 +397,7 @@ static u8 clk_sccg_pll_get_parent(struct clk_hw *hw)
 	u32 val;
 	u8 ret =3D pll->parent;
=20
-	val =3D readl(pll->base + PLL_CFG0);
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
 	if (val & SSCG_PLL_BYPASS2_MASK)
 		ret =3D pll->bypass2;
 	else if (val & SSCG_PLL_BYPASS1_MASK)
@@ -409,10 +410,10 @@ static int clk_sccg_pll_set_parent(struct clk_hw *hw,=
 u8 index)
 	struct clk_sccg_pll *pll =3D to_clk_sccg_pll(hw);
 	u32 val;
=20
-	val =3D readl(pll->base + PLL_CFG0);
+	val =3D readl_relaxed(pll->base + PLL_CFG0);
 	val &=3D ~SSCG_PLL_BYPASS_MASK;
 	val |=3D FIELD_PREP(SSCG_PLL_BYPASS_MASK, pll->setup.bypass);
-	writel(val, pll->base + PLL_CFG0);
+	writel_relaxed(val, pll->base + PLL_CFG0);
=20
 	return clk_sccg_pll_wait_lock(pll);
 }
--=20
2.16.4

