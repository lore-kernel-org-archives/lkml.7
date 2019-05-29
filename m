Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA649C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BD1021019
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IgnIgsOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfE2M1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:27:36 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:23783
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727019AbfE2M1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63elpXaV+M5PoT8qwRfydpHbq8xQrvyvg/OpZ/JHvcM=;
 b=IgnIgsOwMWJXNleWjBn/j9mwML+6aM0hZfVm3uFljCplBiKn9UWCQHsfKWuOHLsL90tx7g6eIaa3HMqOqSH9UcjgrjjKQcB6tL7VFGg2yPvDqnA2subXJ9xJ0Lz5oSPlnjjnrkCCGG2f4wLACkRXszhWFBxnyX+crSjWaliqDMk=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:47 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:47 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
CC:     Fabio Estevam <fabio.estevam@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [RESEND 12/18] clk: imx: Switch wrappers to clk_hw based API
Thread-Topic: [RESEND 12/18] clk: imx: Switch wrappers to clk_hw based API
Thread-Index: AQHVFhnHwJFgnmY6/0+WHIL4bEnEtw==
Date:   Wed, 29 May 2019 12:26:45 +0000
Message-ID: <1559132773-12884-13-git-send-email-abel.vesa@nxp.com>
References: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1559132773-12884-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b392600-b364-4368-23a0-08d6e430eb37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB604987A6590C5D9841F7C99BF61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(14444005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k3jR6NV7In/vzb7Sa2VC0t+um66qWcRDuDELVnqOF4JoJeEqe42Qg8ldNk3EWB+tMlfkMAKkwAyOorDVWvwg/pF1U5AaEpi28Bxbohu9ZMZrYZZjAh/mutkH2KyVZ01lias13OEwhenOLqdGKw8XGnoEnPnz/UzjeWuy9TVLr8WYXpB9b0+1Kkzxzc/5RvA0vhTa52CLusecS6scvB1bT6ekdn0TLzYWGEqW51qGgjerLH2XXKN6G+REIWxRjjhqcvtQXTr7EO4gyTi9vLMmmXkq7GlRDCCJR5TlP4Cv6ZrhGouM5XbWl4lLyZwxwmRkTGgFLAQX3322vdagstaMwXUcf+nZPLBWMZBzDy+mqwKa0jz8qG6TQxOYMFE0j9w3TSBn+3Uyb1+myFj/da5J0PxeFrbi1yRYEBkzWVz4IrU=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4E0936259FCFFA4AB811FD02EB8509CD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b392600-b364-4368-23a0-08d6e430eb37
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:45.1969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch all the wrappers to clk_hw based API and rename them to indicate
that. Add macros for clk based legacy users. This allows us to move
closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk.h | 91 ++++++++++++++++++++++++++++++++++++-----------=
----
 1 file changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5fa8b7c..d94d9cb 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -79,6 +79,45 @@ struct imx_pll14xx_clk {
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
@@ -173,19 +212,19 @@ static inline struct clk_hw *imx_clk_hw_fixed(const c=
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
@@ -222,10 +261,10 @@ static inline struct clk_hw *imx_clk_hw_divider_flags=
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
@@ -246,10 +285,10 @@ static inline struct clk *imx_clk_gate(const char *na=
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
@@ -260,47 +299,47 @@ static inline struct clk_hw *imx_clk_hw_gate(const ch=
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
@@ -312,10 +351,10 @@ static inline struct clk *imx_clk_gate2_cgr(const cha=
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
@@ -329,10 +368,10 @@ static inline struct clk *imx_clk_gate3_flags(const c=
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
@@ -346,11 +385,11 @@ static inline struct clk *imx_clk_gate4_flags(const c=
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
