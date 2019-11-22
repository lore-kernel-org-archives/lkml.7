Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6C2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6902071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QHgRJ8NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbfKVLSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:18:07 -0500
Received: from mail-eopbgr20045.outbound.protection.outlook.com ([40.107.2.45]:34373
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbfKVKsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dr8mcAnNfYTsTHeMI0xrxzNS/lHSOV1VfCFd9Kf+RC0FwMDhadxk68spsgouB0hlPM7WKwHa7ln+hNg2WBdsVJF/Pjc8xQU+gj7sWQ24FjpDNfO7CLjAxC5E6jS4yd9LtNdsRmfQqKgJWnj7+mHWxvHipa2H9hQ/6QcDXtpX24QQXMfELqCSF1o+5S0zoF6WOG5N6NEMnQLThC+DE032VnnkKS3xGWRWXL23lXYg3hG5gO3RDEfLdr+exfQC36J3qZwMQ9F/owtw6Sb5W5d5BKS2n/7gGRgzjv/XdgnZ4FoS2COInMs6Pt+3FBpgHezP6sItX/HG2ZQDuSX/Fd15uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un1i3gNue6RKakpZXjbAvTO4R81IjhwJPhyb/Fpc08g=;
 b=mTIxW3X1jZSiH99J+yX83jyE3wX1OXSG6pFqz0cxIO1BehVwAcsWe988NTkrjqqUqlSXPNEjEXwtEOaKUCYJXFjwxSpRIn3K1qiFNrlXcslKJx1hoJGV8lMpDevxuNnxwhcPzIjHiWbXada3uQ44q23eRyTiceIpuLkaxM6h/6nvjuVGL0vVEu/FD/d4VcyMk8IDdy4oj/yrL00bRYjzCbgWRnO3qWXJYTqG7dgpgb2rDOtB6dRPAUANXQJWHlDfZXYRc0ZIOfTVrKZzJzJppTcR7x6JMW1UY5iXnXhzNbHQ0CfJK/YGWx+RCV9PMo+Pr5SNfkE46XZXka7qNTuKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=un1i3gNue6RKakpZXjbAvTO4R81IjhwJPhyb/Fpc08g=;
 b=QHgRJ8NZyHxHCJ+lhxdW8t6TUNAZ2q5xKg7Q4u7+XJSvo6P0NJzQ9kn7aiY/HJkix0WtKTsem6eIpfr9TTDQxZmCT1J6E14DJB3+Qr65YRpitaF7eTJTXlL4P/Zmq70ERA9Y051A3JfbHEoXyoDFZZPz8pxG7RtScGgXiHyx9P8=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5074.eurprd04.prod.outlook.com (20.177.42.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:14 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2 03/11] clk: imx: Replace all the clk based helpers with
 macros
Thread-Topic: [PATCH v2 03/11] clk: imx: Replace all the clk based helpers
 with macros
Thread-Index: AQHVoSJWy75DOhHmpkOy2/m972l94w==
Date:   Fri, 22 Nov 2019 10:48:13 +0000
Message-ID: <1574419679-3813-4-git-send-email-abel.vesa@nxp.com>
References: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574419679-3813-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:15::33) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f526b208-06be-48d8-d0ed-08d76f3978ee
x-ms-traffictypediagnostic: AM0PR04MB5074:|AM0PR04MB5074:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5074AB4BD0A9EA6E7FAF5893F6490@AM0PR04MB5074.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(189003)(199004)(478600001)(14444005)(256004)(6506007)(54906003)(7736002)(305945005)(316002)(71200400001)(5660300002)(110136005)(102836004)(186003)(86362001)(66066001)(71190400001)(2906002)(4326008)(76176011)(99286004)(36756003)(26005)(52116002)(386003)(8936002)(3846002)(2616005)(446003)(44832011)(11346002)(66556008)(66476007)(66446008)(64756008)(6486002)(66946007)(6436002)(81166006)(8676002)(81156014)(6636002)(6512007)(25786009)(14454004)(50226002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5074;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5jcNx0D+v9v5j8utzEbjUz3ZG6Z0/H7V5kJnFRMVxDwf78WMvqk89Z8b0CjwzrJeHpPAvGxBK6W5W5qI5wLADGJiTNRTQp79R0o+zsClFftOZbYr3xYV24SAXM3HdzAShGy8HO2f5Ak/6YgLj6kv8s1EDwXbkNuUXCUTtrqJzAU+uoMh2K/Qgj5PYLfnaGroEyQw6wh5XXw7jwyV1s3LX4s9OOLUkvq/fHYO1sddz2Af67ymzraQYfnkD0mn6DM04yH/hjyWtGC/h/QmEdDYdTKUq9wjVmfleqwjDDg1/1gk0g3+gpEh1zbCZSiK73Gs3hrIB+DvqJrpiEwp6wBzdsYQhD+pHMVzWhA6NzxhQES1Knsx0gY6gev1aGprxxSE6UG8ltomBho+YOsUUW5yEtdRyt2RwHggQy6qLncRorOr5drPQ5THV7qw8aKsU+m
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f526b208-06be-48d8-d0ed-08d76f3978ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:13.0589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anDvX0+G8cNbG6I3nA20WsSiQTp5lBc4MVX8OPYRUn08lTJ1CY2HbmbGr5CghYkvRbv64kk9YwBqtL9CWb9T4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing with macros all the clk based API helpers we reduce the code
duplication. The end goal is to get rid of all these macros when there
will be no more users of the clk based API, that is, when all the i.MX
clock provider drivers will be switched completely to the clk_hw based
API.

This is another step in moving away from the non clk_hw based API usage
throughout the i.MX clock drivers. The reason for doing that is to
have a clear split between the clock provider and the clock consumer API.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk.h | 39 ++++++++++++---------------------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 9330632..3ed17a1 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -70,12 +70,24 @@ extern struct imx_pll14xx_clk imx_1443x_pll;
 #define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask) \
 	to_clk(imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask=
))
=20
+#define imx_clk_fixed(name, rate) \
+	to_clk(imx_clk_hw_fixed(name, rate))
+
 #define imx_clk_fixed_factor(name, parent, mult, div) \
 	to_clk(imx_clk_hw_fixed_factor(name, parent, mult, div))
=20
+#define imx_clk_divider(name, parent, reg, shift, width) \
+	to_clk(imx_clk_hw_divider(name, parent, reg, shift, width))
+
 #define imx_clk_divider2(name, parent, reg, shift, width) \
 	to_clk(imx_clk_hw_divider2(name, parent, reg, shift, width))
=20
+#define imx_clk_divider_flags(name, parent, reg, shift, width, flags) \
+	to_clk(imx_clk_hw_divider_flags(name, parent, reg, shift, width, flags))
+
+#define imx_clk_gate(name, parent, reg, shift) \
+	to_clk(imx_clk_hw_gate(name, parent, reg, shift))
+
 #define imx_clk_gate_dis(name, parent, reg, shift) \
 	to_clk(imx_clk_hw_gate_dis(name, parent, reg, shift))
=20
@@ -205,11 +217,6 @@ static inline struct clk *to_clk(struct clk_hw *hw)
 	return hw->clk;
 }
=20
-static inline struct clk *imx_clk_fixed(const char *name, int rate)
-{
-	return clk_register_fixed_rate(NULL, name, NULL, 0, rate);
-}
-
 static inline struct clk_hw *imx_clk_hw_fixed(const char *name, int rate)
 {
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
@@ -231,13 +238,6 @@ static inline struct clk_hw *imx_clk_hw_fixed_factor(c=
onst char *name,
 			CLK_SET_RATE_PARENT, mult, div);
 }
=20
-static inline struct clk *imx_clk_divider(const char *name, const char *pa=
rent,
-		void __iomem *reg, u8 shift, u8 width)
-{
-	return clk_register_divider(NULL, name, parent, CLK_SET_RATE_PARENT,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_divider(const char *name,
 						const char *parent,
 						void __iomem *reg, u8 shift,
@@ -247,14 +247,6 @@ static inline struct clk_hw *imx_clk_hw_divider(const =
char *name,
 				       reg, shift, width, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_divider_flags(const char *name,
-		const char *parent, void __iomem *reg, u8 shift, u8 width,
-		unsigned long flags)
-{
-	return clk_register_divider(NULL, name, parent, flags,
-			reg, shift, width, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_divider_flags(const char *name,
 						   const char *parent,
 						   void __iomem *reg, u8 shift,
@@ -281,13 +273,6 @@ static inline struct clk *imx_clk_divider2_flags(const=
 char *name,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate(const char *name, const char *paren=
t,
-		void __iomem *reg, u8 shift)
-{
-	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
-			shift, 0, &imx_ccm_lock);
-}
-
 static inline struct clk_hw *imx_clk_hw_gate_flags(const char *name, const=
 char *parent,
 		void __iomem *reg, u8 shift, unsigned long flags)
 {
--=20
2.7.4

