Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0109EC17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5CCB222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D9hwoOyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfKMKCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:02:08 -0500
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:23271
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726338AbfKMKCH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:02:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXruUUhSi3HNjtFy9UF7jwkFfavCzE0hqhLoSzI23mzt3Ie7QUjBpDVnczjzSBCSrH4U/ErNy+QY5OcajkjVcu9Z2reK7pYJWRVOuESJrKe/yDTdqVAMtVOC4gOjByDf4ryU0NopILKNHeZyVf9eGyqJDU+DLTbDTZMcXCvkKnkdqZW9ypR/BiOcadgUOXMwwusAtsAdiscbUeWuBj0tB9GSX3zW25126TJQNCXC2z8mG0FeEiBoqDfLizutlwFBArQnp4/JET+gqcBMuEKA5AtwhfJsnOajXlimj4hooTZxAzXWa+u/M6buMnjbWL1+WhdTqovCKDLzXCbt26LeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLmrB5D04yOJegmBFfizvGX9OeLI7oDQb4m2MVPRTFE=;
 b=O8Zt7gjvGcC8wQZEZRQU0buLW3ILULn0TqshgzDB0houOeQPWblKw5/0o40rGOBH5QGQC6mVsw/FUi3dzWU7OjaXcP558U+GBQB5UVuZ4BbGSrAYbzlMLJmhSBeTrzLkh3u+KifsJK4kYsxPYNxMJFJaA8ZDxohikr6konksm2tY8mp9V3hniYdl4SqwlZgAd5bVvlLjMVkHnSzs715OjLhYKbUwwzx1Gjzs7/S5opG6/wQQw2wc9Xsj+ArjAkTwsOaOv2U7fYdZLBGAGLxJhHyKhqvxj96uWNiz8rNiaQRGzP5GtT8vOqME7Kww0gymA/+BopFENJ8SHmr8JP5sWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLmrB5D04yOJegmBFfizvGX9OeLI7oDQb4m2MVPRTFE=;
 b=D9hwoOyRdNDRIuYdfVXuGs603Ym+QXSeUcO0XsfuqUMPBYSIKDJ9VsfNLkoKbOEefngYNp88nYof5KVsUJMrJztuASFE8GCfcYPm71w0mCsMVx+C7trPq1mH/ztSLgvXY7kbBPZEfolqpT/5GrYU/PEc8qlzB+S6oghn/2xQUnI=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5812.eurprd04.prod.outlook.com (20.178.119.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Wed, 13 Nov 2019 10:02:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::f16d:a26a:840:f97c%4]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 10:02:03 +0000
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
        Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/2] clk: imx: sccg: use relaxed io api
Thread-Topic: [PATCH 1/2] clk: imx: sccg: use relaxed io api
Thread-Index: AQHVmgllyVcYHISGfUyhube4yQW84A==
Date:   Wed, 13 Nov 2019 10:02:03 +0000
Message-ID: <1573638817-4363-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd3e53d3-b599-48e2-4d0a-08d768208730
x-ms-traffictypediagnostic: AM0PR04MB5812:|AM0PR04MB5812:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5812ABFD218BC89BBFDD236988760@AM0PR04MB5812.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(199004)(189003)(110136005)(8676002)(2201001)(478600001)(71190400001)(71200400001)(54906003)(50226002)(486006)(81156014)(36756003)(99286004)(86362001)(476003)(25786009)(81166006)(2616005)(8936002)(2906002)(66066001)(7736002)(305945005)(256004)(26005)(14444005)(386003)(102836004)(6506007)(316002)(186003)(2501003)(6636002)(6116002)(52116002)(3846002)(4326008)(66446008)(6512007)(6486002)(6436002)(5660300002)(44832011)(64756008)(66556008)(66476007)(14454004)(66946007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5812;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2R0XVAQJfZK7vl5Ug2OROohyq8RndcOwX0O8gwwdQuAubP6zLY9G9hxQhAFb/R7E/OwOYPRtNy/EJjVCi5FnAA5IjPSNe0hdpWNFHIsJpgk/Dji+lI4cGNdp6jE51fpqaJkEYn7J71SUMdwQsnHAjgmKn8+ifXSwrn6Veoy5tmkIpQ6cR49XggFpnVX+0jstO8WJ2vhenejscZAKSbvPN0sWv08QVIx+ioDPM1WTOpANucCd8Dw9iIViRLtYAEeaUu1ui39kUpHZN9u3oyWmHL2zDcTmp6r09hbMe/RSuPlWfZkMSmqL6xaXKhKTHziJxF29bLFmY+SnL/js2/U0LFsWjUU32bVmwCv9LsuPH+FbmFhxJLE4TEvwK4P6VkXH9LUXnkQTw/A6RfjcSaOu1OOx802E4t4C3nk/ys8gDb2wD5YYWATb/pJc+jwGWav
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e53d3-b599-48e2-4d0a-08d768208730
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 10:02:03.2374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mp5ovHvzUmbbRsYktpZSHOtp9HuX3dCm25nj9UsV/c8xP+x9lxTLOt3ee8Bh/KDTQhlrta0AENtTJXbrLPAbGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5812
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

It is ok to use relaxed api here, no need to use stronger readl/writel

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

