Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56206C2D0C5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E5722B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 02:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NW/I11Sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfLLC7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:59:34 -0500
Received: from mail-eopbgr70082.outbound.protection.outlook.com ([40.107.7.82]:54337
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726841AbfLLC7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 21:59:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDXbUtLxjQzHAGofWFh3VERvuvnNnoXtLZgvry992TNNNsQYx7p0kVp4pS8JNzEG1QdKO0bhelY0dhhHpEO4ZfALrGVU/nC0oTwOEmtYj11ogjTkes4GXraCV8eF6f2TtCXRjYsWE3ktBWCpuiC9enuGzPqjZzA4TEErmjZDz90aFKkqDN0dJ/YbgEvsm6OLT8HzRqx/3+JAS+NRA/3F2dSShBUy2Vba4Vy/LAIC+crCtXPndxJmkHDMQKsNXtSwnW2Di+CtdpkA3d4aRQdt10L9O0Y63Y+4ZIOg7OdG8h9glftBRme5xFOcAPvoBxLSA60OsJWNRhxKUkMb8ulTUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpl+Dx5soGUTxlTaBpLYsaowwaezpsTRUzF190iSDm8=;
 b=OnD9IaVtnY8rZW6Qc6FihUI4szYGHwKo0NRJ4ea6BG/UmshtmrVgVOUmjltXmX4Lh1ZHgjoqPSklwixQ/fTjHVy7Q0RBxl9F2xMYwcdMnHZQi+oqrM8DGW1y30sneiGUwE7XWLCEYBvJV9QLKqV6hDgaqoS+SumBlX6hJWy0A5dEit7dKAd8H39w8dzqQ1aTnHqg3otjK7vTA4K74/gnSoBRBhNI2M2m5R0RdQ7tTDVqDI9d7OttOCc4yfG/4vptiwe/Yq+6NxZyji2QAP17Dk1SZD5nFEwlnHYLqhVxcHH0C0aSauAOkQFEw/8qOPMaFqciW8NT7ACrAyI8qfd9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpl+Dx5soGUTxlTaBpLYsaowwaezpsTRUzF190iSDm8=;
 b=NW/I11SnYaWhkkHUQE1wQ8varOrNxZ/Ok4Yk///5dU91cgQlWWzrSxOaZRRVEq/Fs+7UOLYz54C/Nm+Jkqld9sU1YWsa/lFkwWDMvYnV/7Vt0yOhlZlqly4Z26KPkylleR5ynGaTN7cqa7I1r8Yut7/wqovB4v+fNfac7H5AxLc=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6196.eurprd04.prod.outlook.com (20.179.34.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 02:58:48 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::505:87e7:6b49:3d29%7]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 02:58:48 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 2/9] clk: imx: clk-composite-8m: Switch to clk_hw based API
Thread-Topic: [PATCH V2 2/9] clk: imx: clk-composite-8m: Switch to clk_hw
 based API
Thread-Index: AQHVsJgTdY4qYDarhkq5MjuDwQda7w==
Date:   Thu, 12 Dec 2019 02:58:48 +0000
Message-ID: <1576119353-26679-3-git-send-email-peng.fan@nxp.com>
References: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
In-Reply-To: <1576119353-26679-1-git-send-email-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0401CA0022.apcprd04.prod.outlook.com
 (2603:1096:202:2::32) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21ca3453-2c2f-45fa-142e-08d77eaf35e8
x-ms-traffictypediagnostic: AM0PR04MB6196:|AM0PR04MB6196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6196E4D44C349C79D79D74D788550@AM0PR04MB6196.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(199004)(189003)(81156014)(8936002)(316002)(81166006)(8676002)(36756003)(52116002)(478600001)(6512007)(6486002)(71200400001)(110136005)(54906003)(86362001)(186003)(66476007)(4326008)(5660300002)(2906002)(66446008)(64756008)(44832011)(26005)(6636002)(66946007)(6506007)(2616005)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6196;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YxlRVIjaK4vsGTwqwEaSEZQ802eMVL9ucPmnGRgK+Cq+OVmP3eteXhnczH7D/qn+OCygXqr3pFaq9OeYgRfIVPC5S6s5ER+SqfO87Uj9LedUCWQdi1eDvZ6+9xLE2yI0kN2oD4k2VghCHYSrlw+ilKchIaVsa54t4XoYgf9HMKJ8l/Kc15SWA6m2jxbQtY0U9VsNQ4sqPFWV/P1j56VbG1dI+pKP3Dk2PWJFZ+fSFHmZyRykmVtUI9HsMjyy9HToelStmBQFEN3Zthh2HJhsN0rLl3qBw9Izq/EdvzIN/ysZo2auhZ/x2F17kQnRtmYI7eoBRWUlFYR/PH4xwB0N9zbSIBDptZNjk+0iOeW4S0lpif7iI0QrCBzBQ2/dhN/sC4Zuy0isLaiLEQXLYRTbvXJjdrYxIf8z7ccM86hQES4u5iJj2gsfJzAuRVURbY02
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21ca3453-2c2f-45fa-142e-08d77eaf35e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 02:58:48.6921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4g+oRr9sf19X/MjdLioxf6oC7oBKuSF/uubUV1+MXa2fs2qFaTZKwV1DV4KeduQcXurldvxT1fJLBGSsb9nAmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Switch the imx8m_clk_hw_composite_flags function to clk_hw based API,
rename accordingly and add a macro for clk based legacy. This allows
us to move closer to a clear split between consumer and provider clk
APIs.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-composite-8m.c |  4 ++--
 drivers/clk/imx/clk.h              | 29 ++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index d3486ee79ab5..20f7c91c03d2 100644
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
@@ -171,7 +171,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 	if (IS_ERR(hw))
 		goto fail;
=20
-	return hw->clk;
+	return hw;
=20
 fail:
 	kfree(gate);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index caee661664c1..46cbac4d89a5 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -460,19 +460,34 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const=
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
+	to_clk(imx8m_clk_hw_composite_flags(name, parent_names, \
+				num_parents, reg, flags))
+
+#define __imx8m_clk_hw_composite(name, parent_names, reg, flags) \
+	imx8m_clk_hw_composite_flags(name, parent_names, \
 		ARRAY_SIZE(parent_names), reg, \
 		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
=20
+#define __imx8m_clk_composite(name, parent_names, reg, flags) \
+	to_clk(__imx8m_clk_hw_composite(name, parent_names, reg, flags))
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

