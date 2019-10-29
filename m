Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB09CA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543CB2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lF4Vnny8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388850AbfJ2NlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:41:05 -0400
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:32162
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388773AbfJ2NlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:41:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5Cx/v/RepUVLb9OAoW/bcSEv45jIb24IwyZ5Iwnhc//0rPjS873wbVIqkPLbhVFQKKsG7cdknfrDgWy3bqztn38hHSR7CI70zJ3B6sWDlsAuf/HjpC2Ln+ZHu0a8M0pNYuOLBoS4BIuDq0FUSyy7PEHHRgzYC8kr4ejq+5LqM2mGPNmmJDe/u15YzVTxpMGi2arF3N5srs/dpUl5hepYCecVxF2yC+o1V13A26RTj2SDdM3OBEpUzDkghH1y87vylMrXMDHERTzOGp39JDmf7o9dJnW1sCo719b0DB3lx8BnQltezsAuSzFvzbQnh7i/uKKwCt1/i0mKt9xgPLnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FERQ5JOsBgqrd/FD6A6Wz2tt3T3WGVvqxaHe7Ec/gpY=;
 b=T0ZFW0fpbXmggO9Lh7hfIrXRmnlhxvNeQyKO1TF0EIFYLulFwifEvu3zhpCgP+0o4hbMJxVaM5SBLYLy38tDmMwgh6st5RplviM410tdr6g9tMnpaYTrPTOS8Slp6a9tvEbkDAaePcKtTXh9njtxjzq9qkMfTF8w3w7Il5R7eh8hn7CJGp/7JPYy9UEOosZolXoceF51tbr0evKHMl96heBOuwy0MRqw/Do5ptLHzmFKkQUKQv/Hjm4PcRREfbIwqmD3PvgNXWk2+NUJklWgZpWyGc995WUR1nWD8tmVYqUXCuFPDfxvrtuFS7kPl9ZuPndAaCmbU1YztfuaNahWUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FERQ5JOsBgqrd/FD6A6Wz2tt3T3WGVvqxaHe7Ec/gpY=;
 b=lF4Vnny8/y+wJLA8xDIvuX9qV+u9Aaw8fRdf7DsgHuF+Hvhk7eD3PnlI0ROrMyo8SEXJ4wJ/AlTodvOF7dhtuilC6b3/H4Uap1WYwA+E59ltMhMCQirC1+BecgDkRqSqKM6hxU7EUM/WqEwsB+yyAnuPg7PRh3tqGRbGhTlj7vg=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5139.eurprd04.prod.outlook.com (20.176.215.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Tue, 29 Oct 2019 13:41:00 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::843c:e722:27cb:74e1%5]) with mapi id 15.20.2387.023; Tue, 29 Oct 2019
 13:41:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/7] clk: imx: clk-composite-8m: Switch to clk_hw based API
Thread-Topic: [PATCH 2/7] clk: imx: clk-composite-8m: Switch to clk_hw based
 API
Thread-Index: AQHVjl5/j/spRpTKgUuA1T2shZJKLw==
Date:   Tue, 29 Oct 2019 13:41:00 +0000
Message-ID: <1572356175-24950-3-git-send-email-peng.fan@nxp.com>
References: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1572356175-24950-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0030.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::18) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aca7b2c6-30a2-41ba-90ae-08d75c75a24f
x-ms-traffictypediagnostic: AM0PR04MB5139:|AM0PR04MB5139:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5139D813D728518B2330542488610@AM0PR04MB5139.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(199004)(189003)(6436002)(102836004)(66946007)(52116002)(66556008)(66066001)(5660300002)(66476007)(2501003)(81166006)(8676002)(486006)(81156014)(6506007)(386003)(66446008)(6486002)(64756008)(256004)(478600001)(26005)(2906002)(3846002)(76176011)(186003)(25786009)(99286004)(71190400001)(71200400001)(6116002)(6512007)(6636002)(54906003)(14454004)(7736002)(36756003)(446003)(11346002)(476003)(2616005)(305945005)(4326008)(44832011)(50226002)(316002)(110136005)(86362001)(2201001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5139;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z6putwva7H0y+woQWxeX2g+IZioGwkXEGrtFtPYsZhMcHWYYmpIMoC+yAmC34jUJcRpZucTWi6GntA1NqBwfPDx30IYxg2T9k9vOkF/0EdthoYse61mmM2ElyszAxa6ZiP0FYrKmcXX6QTmnTDllZsbVt/f6ZGEDGHztFgHSoIdCoOXqYQH4tnWULnOljJ6q0YZAxKugNTrCi00+Xt0IpOlURN3wBXIlUtw5AdL6ypiVFw5qzB+aj1Rk1MCLoySfIyb4QLYyPZZ4irj7Nm25qiBoliTT71U9xrjx9Gxuom0Bp9mA32CtKJkcX0aoe0G/ZN5SkLFxpcaao6H4inPVVfOhNwNmBHNc/jD1XOaC+ERJ7VDZtlEjv/Ri07fxqZXloDfRj87Hh9AjNP2cGH+TZNy5J/gBXzShCPYrKkYRdAphWkTdOGr88IGgxCgIjfqx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca7b2c6-30a2-41ba-90ae-08d75c75a24f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 13:41:00.2615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivqTWe/p5oyU6YWhKFeAClwRBz2SgEfHxoA1oNGYE/bdB9b2Vs5ZX+T1Ow+7yoJUbfFOU39SKpXl4nrkaBqPkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the imx8m_clk_hw_composite_flags function to clk_hw based API,
rename accordingly and add a macro for clk based legacy. This allows
us to move closer to a clear split between consumer and provider clk
APIs.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c |  4 ++--
 drivers/clk/imx/clk.h              | 29 ++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index 388bdb94f841..e0f25983e80f 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -123,7 +123,7 @@ static const struct clk_ops imx8m_clk_composite_divider=
_ops =3D {
 	.set_rate =3D imx8m_clk_composite_divider_set_rate,
 };
=20
-struct clk *imx8m_clk_composite_flags(const char *name,
+struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
 					const char * const *parent_names,
 					int num_parents, void __iomem *reg,
 					unsigned long flags)
@@ -169,7 +169,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 	if (IS_ERR(hw))
 		goto fail;
=20
-	return hw->clk;
+	return hw;
=20
 fail:
 	kfree(gate);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5038622f1a72..e67f7d4ab1dd 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -450,19 +450,34 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const=
 char *parent_name,
 		struct clk *div, struct clk *mux, struct clk *pll,
 		struct clk *step);
=20
-struct clk *imx8m_clk_composite_flags(const char *name,
-					const char * const *parent_names,
-					int num_parents, void __iomem *reg,
-					unsigned long flags);
-
-#define __imx8m_clk_composite(name, parent_names, reg, flags) \
-	imx8m_clk_composite_flags(name, parent_names, \
+struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
+					    const char * const *parent_names,
+					    int num_parents,
+					    void __iomem *reg,
+					    unsigned long flags);
+
+#define imx8m_clk_composite_flags(name, parent_names, num_parents, reg, \
+				  flags) \
+	imx8m_clk_hw_composite_flags(name, parent_names, num_parents, \
+				     reg, flags)->clk
+
+#define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \
+	imx8m_clk_hw_composite_flags(name, parent_names, \
 		ARRAY_SIZE(parent_names), reg, \
 		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
=20
+#define __imx8m_clk_composite(name, parent_names, reg, flags) \
+	__imx8m_clk_hw_composite(name, parent_names, reg, flags)->clk
+
+#define imx8m_clk_hw_composite(name, parent_names, reg) \
+	__imx8m_clk_hw_composite(name, parent_names, reg, 0)
+
 #define imx8m_clk_composite(name, parent_names, reg) \
 	__imx8m_clk_composite(name, parent_names, reg, 0)
=20
+#define imx8m_clk_hw_composite_critical(name, parent_names, reg) \
+	__imx8m_clk_hw_composite(name, parent_names, reg, CLK_IS_CRITICAL)
+
 #define imx8m_clk_composite_critical(name, parent_names, reg) \
 	__imx8m_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
=20
--=20
2.16.4

