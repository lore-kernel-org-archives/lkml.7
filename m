Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA242192B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BeDcW34Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfCVPh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:37:29 -0400
Received: from mail-eopbgr00067.outbound.protection.outlook.com ([40.107.0.67]:50409
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbfCVPhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eXZD9aLRFXtbhNBq+VUiXcrylfmNLHaeGeUu9PlyNs=;
 b=BeDcW34YmtcHztww9ROKMyT2wwD4BNdgPGI+oZBucKray1hVf0yhksvBSSYufTbIzqZfAtjNzK/FUXD8Sr2MuWi+RrMDDb4j/nwVMoQgIOeVUb15QcZDk4bwxSYBXljU1UL3wUGTNwg/ZH4O25k5F1AcGqrSRoCO3ZPRR7sQ+v4=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4802.eurprd04.prod.outlook.com (20.176.215.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:37:13 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::9579:32ab:898e:6769%2]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 15:37:13 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RFC 13/19] clk: imx: Switch wrappers to clk_hw based API
Thread-Topic: [RFC 13/19] clk: imx: Switch wrappers to clk_hw based API
Thread-Index: AQHU4MUevhiD3tL7ukmfOL+UxYCvCA==
Date:   Fri, 22 Mar 2019 15:37:13 +0000
Message-ID: <1553269010-15591-14-git-send-email-abel.vesa@nxp.com>
References: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1553269010-15591-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR08CA0170.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::24) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [212.146.100.6]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f656912d-6cd7-4278-7207-08d6aedc411c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4802;
x-ms-traffictypediagnostic: AM0PR04MB4802:
x-microsoft-antispam-prvs: <AM0PR04MB4802F0EC7F77748754FEA61EF6430@AM0PR04MB4802.eurprd04.prod.outlook.com>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(366004)(189003)(199004)(446003)(71190400001)(99286004)(25786009)(8676002)(478600001)(71200400001)(256004)(66066001)(305945005)(7736002)(14444005)(4326008)(14454004)(68736007)(81166006)(5660300002)(8936002)(97736004)(53936002)(81156014)(50226002)(6512007)(36756003)(26005)(186003)(105586002)(102836004)(6436002)(3846002)(76176011)(52116002)(106356001)(6486002)(6116002)(386003)(486006)(44832011)(86362001)(476003)(2616005)(11346002)(54906003)(2906002)(6506007)(110136005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4802;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HwgEwMyEwRqFQjT6CpxkdQdSnr7UHoA+Q3wXyoZ6vFiGnmlH68kX6UZiaJCEFHI1tngTMFsPkzHLdO01RY4cba1QuGlFsWXmQgUWONkHGIaZOCg7Ta7f//WAHMux5Zt38LqljL2rDyxnZZTa5wdv7dYMW53sOLOy86QAi3sZVXm3h19pzYZ+h3GTInH1XQDQ0omP+SixbkXUkOehRdDmTiycSJc2nhFfHGwPv86hS6eVTTcd1ZGnuKpSGoiRkqJipnBHcxiKY//RP4HJa3dKSdPARxahV3h6cYjKy6vJOffyMiUBpCrjfI6d349Zh8KT2kuFPIlZ6pojS5Hsyy6SqtIE7mhsYY+vrTO9yNfbYodgwNMYhYKyARXF04nf9b2ZftyOeTch7SCP5Xw5p7omkS3pHW/G7B9LrPX7utnXye0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f656912d-6cd7-4278-7207-08d6aedc411c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:37:13.0306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch all the wrappers to clk_hw based API and rename
them to indicate that. Add macros for clk based legacy users.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 91 ++++++++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index a8da9dc..1832379 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -78,6 +78,45 @@ struct imx_pll14xx_clk {
 #define imx_clk_fixup_mux(name, reg, shift, width, parents, num_parents, f=
ixup) \
 	imx_clk_hw_fixup_mux(name, reg, shift, width, parents, num_parents, fixup=
)->clk
=20
+#define imx_clk_mux_ldb(name, reg, shift, width, parents, num_parents) \
+	imx_clk_hw_mux_ldb(name, reg, shift, width, parents, num_parents)->clk
+
+#define imx_clk_fixed_factor(name, parent, mult, div) \
+	imx_clk_hw_fixed_factor(name, parent, mult, div)->clk
+
+#define imx_clk_divider2(name, parent, reg, shift, width) \
+	imx_clk_hw_divider2(name, parent, reg, shift, width)->clk
+
+#define imx_clk_gate_dis(name, parent, reg, shift) \
+	imx_clk_hw_gate_dis(name, parent, reg, shift)->clk
+
+#define imx_clk_gate_dis_flags(name, parent, reg, shift, flags) \
+	imx_clk_hw_gate_dis_flags(name, parent, reg, shift, flags)->clk
+
+#define imx_clk_gate_flags(name, parent, reg, shift, flags) \
+	imx_clk_hw_gate_flags(name, parent, reg, shift, flags)->clk
+
+#define imx_clk_gate2(name, parent, reg, shift) \
+	imx_clk_hw_gate2(name, parent, reg, shift)->clk
+
+#define imx_clk_gate2_flags(name, parent, reg, shift, flags) \
+	imx_clk_hw_gate2_flags(name, parent, reg, shift, flags)->clk
+
+#define imx_clk_gate2_shared(name, parent, reg, shift, share_count) \
+	imx_clk_hw_gate2_shared(name, parent, reg, shift, share_count)->clk
+
+#define imx_clk_gate2_shared2(name, parent, reg, shift, share_count) \
+	imx_clk_hw_gate2_shared2(name, parent, reg, shift, share_count)->clk
+
+#define imx_clk_gate3(name, parent, reg, shift) \
+	imx_clk_hw_gate3(name, parent, reg, shift)->clk
+
+#define imx_clk_gate4(name, parent, reg, shift) \
+	imx_clk_hw_gate4(name, parent, reg, shift)->clk
+
+#define imx_clk_mux(name, reg, shift, width, parents, num_parents) \
+	imx_clk_hw_mux(name, reg, shift, width, parents, num_parents)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -171,19 +210,19 @@ static inline struct clk_hw *imx_clk_hw_fixed(const c=
har *name, int rate)
 	return clk_hw_register_fixed_rate(NULL, name, NULL, 0, rate);
 }
=20
-static inline struct clk *imx_clk_mux_ldb(const char *name, void __iomem *=
reg,
+static inline struct clk_hw *imx_clk_hw_mux_ldb(const char *name, void __i=
omem *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
 {
-	return clk_register_mux(NULL, name, parents, num_parents,
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT | CLK_SET_RATE_PARENT, reg,
 			shift, width, CLK_MUX_READ_ONLY, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_fixed_factor(const char *name,
+static inline struct clk_hw *imx_clk_hw_fixed_factor(const char *name,
 		const char *parent, unsigned int mult, unsigned int div)
 {
-	return clk_register_fixed_factor(NULL, name, parent,
+	return clk_hw_register_fixed_factor(NULL, name, parent,
 			CLK_SET_RATE_PARENT, mult, div);
 }
=20
@@ -220,10 +259,10 @@ static inline struct clk_hw *imx_clk_hw_divider_flags=
(const char *name,
 				       reg, shift, width, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_divider2(const char *name, const char *p=
arent,
+static inline struct clk_hw *imx_clk_hw_divider2(const char *name, const c=
har *parent,
 		void __iomem *reg, u8 shift, u8 width)
 {
-	return clk_register_divider(NULL, name, parent,
+	return clk_hw_register_divider(NULL, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, width, 0, &imx_ccm_lock);
 }
@@ -244,10 +283,10 @@ static inline struct clk *imx_clk_gate(const char *na=
me, const char *parent,
 			shift, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate_flags(const char *name, const char =
*parent,
+static inline struct clk_hw *imx_clk_hw_gate_flags(const char *name, const=
 char *parent,
 		void __iomem *reg, u8 shift, unsigned long flags)
 {
-	return clk_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT,=
 reg,
+	return clk_hw_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARE=
NT, reg,
 			shift, 0, &imx_ccm_lock);
 }
=20
@@ -258,47 +297,47 @@ static inline struct clk_hw *imx_clk_hw_gate(const ch=
ar *name, const char *paren
 				    shift, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate_dis(const char *name, const char *p=
arent,
+static inline struct clk_hw *imx_clk_hw_gate_dis(const char *name, const c=
har *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_hw_register_gate(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
 			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate_dis_flags(const char *name, const c=
har *parent,
+static inline struct clk_hw *imx_clk_hw_gate_dis_flags(const char *name, c=
onst char *parent,
 		void __iomem *reg, u8 shift, unsigned long flags)
 {
-	return clk_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARENT,=
 reg,
+	return clk_hw_register_gate(NULL, name, parent, flags | CLK_SET_RATE_PARE=
NT, reg,
 			shift, CLK_GATE_SET_TO_DISABLE, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate2(const char *name, const char *pare=
nt,
+static inline struct clk_hw *imx_clk_hw_gate2(const char *name, const char=
 *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg=
,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
=20
-static inline struct clk *imx_clk_gate2_flags(const char *name, const char=
 *parent,
+static inline struct clk_hw *imx_clk_hw_gate2_flags(const char *name, cons=
t char *parent,
 		void __iomem *reg, u8 shift, unsigned long flags)
 {
-	return clk_register_gate2(NULL, name, parent, flags | CLK_SET_RATE_PARENT=
, reg,
+	return clk_hw_register_gate2(NULL, name, parent, flags | CLK_SET_RATE_PAR=
ENT, reg,
 			shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
=20
-static inline struct clk *imx_clk_gate2_shared(const char *name,
+static inline struct clk_hw *imx_clk_hw_gate2_shared(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg,
+	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT, reg=
,
 			shift, 0x3, 0, &imx_ccm_lock, share_count);
 }
=20
-static inline struct clk *imx_clk_gate2_shared2(const char *name,
+static inline struct clk_hw *imx_clk_hw_gate2_shared2(const char *name,
 		const char *parent, void __iomem *reg, u8 shift,
 		unsigned int *share_count)
 {
-	return clk_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
+	return clk_hw_register_gate2(NULL, name, parent, CLK_SET_RATE_PARENT |
 				  CLK_OPS_PARENT_ENABLE, reg, shift, 0x3, 0,
 				  &imx_ccm_lock, share_count);
 }
@@ -310,10 +349,10 @@ static inline struct clk *imx_clk_gate2_cgr(const cha=
r *name,
 			shift, cgr_val, 0, &imx_ccm_lock, NULL);
 }
=20
-static inline struct clk *imx_clk_gate3(const char *name, const char *pare=
nt,
+static inline struct clk_hw *imx_clk_hw_gate3(const char *name, const char=
 *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate(NULL, name, parent,
+	return clk_hw_register_gate(NULL, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0, &imx_ccm_lock);
 }
@@ -327,10 +366,10 @@ static inline struct clk *imx_clk_gate3_flags(const c=
har *name,
 			reg, shift, 0, &imx_ccm_lock);
 }
=20
-static inline struct clk *imx_clk_gate4(const char *name, const char *pare=
nt,
+static inline struct clk_hw *imx_clk_hw_gate4(const char *name, const char=
 *parent,
 		void __iomem *reg, u8 shift)
 {
-	return clk_register_gate2(NULL, name, parent,
+	return clk_hw_register_gate2(NULL, name, parent,
 			CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
@@ -344,11 +383,11 @@ static inline struct clk *imx_clk_gate4_flags(const c=
har *name,
 			reg, shift, 0x3, 0, &imx_ccm_lock, NULL);
 }
=20
-static inline struct clk *imx_clk_mux(const char *name, void __iomem *reg,
+static inline struct clk_hw *imx_clk_hw_mux(const char *name, void __iomem=
 *reg,
 			u8 shift, u8 width, const char * const *parents,
 			int num_parents)
 {
-	return clk_register_mux(NULL, name, parents, num_parents,
+	return clk_hw_register_mux(NULL, name, parents, num_parents,
 			CLK_SET_RATE_NO_REPARENT, reg, shift,
 			width, 0, &imx_ccm_lock);
 }
--=20
2.7.4

