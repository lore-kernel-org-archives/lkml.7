Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E349CC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB90216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SRsMJ20W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfE2M1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:27:47 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:23783
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbfE2M04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlZjdPJCp1MCmge1PPrAOrbXmogdvICvsR0Bf95MuxI=;
 b=SRsMJ20WG7/B1E4flM/ZO2JNiTCKRwgt1MUDoAvey4qTt16N7JrYTMJX840wUrODKQOwICfLcxipVqs34DZ3jS63tP9I+Q5TPW4IBLnzda6VFlekFmwsR1feYLy1VQTs8k5qWiwI89q6Gy9rf3fj/CUP2PjVx+cV0ginwG/yF50=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:45 +0000
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
Subject: [RESEND 09/18] clk: imx: clk-gate-exclusive: Switch to clk_hw based
 API
Thread-Topic: [RESEND 09/18] clk: imx: clk-gate-exclusive: Switch to clk_hw
 based API
Thread-Index: AQHVFhnGT3lmZG8wxEOdWY3zvgoVIA==
Date:   Wed, 29 May 2019 12:26:43 +0000
Message-ID: <1559132773-12884-10-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: cdef34c2-068f-4398-d839-08d6e430e9e1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB604999E4CF823094188AEA00F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mks3SNtiZ9jyk4uEbpJSUJJvvmO8JpaMAWCM/hUNDfBs+tLlfq1CriUpt1AL0CX93eu0KF8ZnmHELlKej1+z5jC2arJ6s2jExfFYPpgItrgS3rNvdBlQo/uO/G3gwDzBQQTL7eVjNq8EcCXKc/yHku9NsFbhSgUf1eBz/uyY1caMODiu62Xsi8rXcXl4zJ1QT37lOtH9a3V8icBNKWUWralCDwfdLKSOR+bNmaI+I9CWf8l2C02Swi6eglkcIFcxrd76H3FMh8cBurBaBMxLeAIyr5Upyyio8qJg/QRVXkKlrQITRttN6jnlugCKnp2LItT2V6bBpvsHO3mrpH+HoXisn2JdNZ+FR8pVppQBGTvNIPZ0ZOE0ORj6enES6OVpp2AROkIzaS0Vd7YZQfxvehOvTtboHH5YJnwhO4tJTAo=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <87F380E5A3F9404BA3C8F9B0E29A4C57@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdef34c2-068f-4398-d839-08d6e430e9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:44.0326
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

Switch the imx_clk_gate_exclusive function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to move
closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-gate-exclusive.c | 17 +++++++++++------
 drivers/clk/imx/clk.h                |  5 ++++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-gate-exclusive.c b/drivers/clk/imx/clk-gat=
e-exclusive.c
index 3bd9dee..7bd9f14 100644
--- a/drivers/clk/imx/clk-gate-exclusive.c
+++ b/drivers/clk/imx/clk-gate-exclusive.c
@@ -58,13 +58,14 @@ static const struct clk_ops clk_gate_exclusive_ops =3D =
{
 	.is_enabled =3D clk_gate_exclusive_is_enabled,
 };
=20
-struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_gate_exclusive(const char *name, const char *par=
ent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask)
 {
 	struct clk_gate_exclusive *exgate;
 	struct clk_gate *gate;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	if (exclusive_mask =3D=3D 0)
 		return ERR_PTR(-EINVAL);
@@ -86,9 +87,13 @@ struct clk *imx_clk_gate_exclusive(const char *name, con=
st char *parent,
 	gate->hw.init =3D &init;
 	exgate->exclusive_mask =3D exclusive_mask;
=20
-	clk =3D clk_register(NULL, &gate->hw);
-	if (IS_ERR(clk))
-		kfree(exgate);
+	hw =3D &gate->hw;
=20
-	return clk;
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
+		kfree(gate);
+		return ERR_PTR(ret);
+	}
+
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 87a1a88..1c6300a 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -70,6 +70,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_pfd(name, parent_name, reg, idx) \
 	imx_clk_hw_pfd(name, parent_name, reg, idx)->clk
=20
+#define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask) \
+	imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -123,7 +126,7 @@ struct clk_hw *imx_obtain_fixed_clock_hw(
 struct clk_hw *imx_obtain_fixed_clk_hw(struct device_node *np,
 				       const char *name);
=20
-struct clk *imx_clk_gate_exclusive(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_gate_exclusive(const char *name, const char *par=
ent,
 	 void __iomem *reg, u8 shift, u32 exclusive_mask);
=20
 struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
--=20
2.7.4
