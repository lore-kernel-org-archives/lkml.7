Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39858C28CC3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08949217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 12:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PSctVgwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfE2M1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 08:27:01 -0400
Received: from mail-eopbgr30051.outbound.protection.outlook.com ([40.107.3.51]:23783
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbfE2M06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 08:26:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMEH0yPLRtE++k7rLVtyxg94NoWAPiCAM0s2Rpxx0f0=;
 b=PSctVgwQNHlAtF+yF9QOgX2ur1MtZzRF+GuR0iF2yioZ+nH1qw9ADPgyYshyoEjCyctWLk8iUM7g5AzSGaNSbBfOFJ/a4c1H86x/9ZzzGtpe4eCioFnetGhDLVak10zWito02d7A8MEeKY/ri/Pyrf0MzyLhxz+Ue9xONabAo6Q=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6049.eurprd04.prod.outlook.com (20.179.32.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 29 May 2019 12:26:46 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::c19b:5964:bfcb:96a8%7]) with mapi id 15.20.1922.021; Wed, 29 May 2019
 12:26:46 +0000
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
Subject: [RESEND 10/18] clk: imx: clk-fixup-div: Switch to clk_hw based API
Thread-Topic: [RESEND 10/18] clk: imx: clk-fixup-div: Switch to clk_hw based
 API
Thread-Index: AQHVFhnGJpqQ6ImPike2rFxxqoYjUA==
Date:   Wed, 29 May 2019 12:26:44 +0000
Message-ID: <1559132773-12884-11-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: a97363fd-19b4-48ce-778e-08d6e430ea6c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6049;
x-ms-traffictypediagnostic: AM0PR04MB6049:
x-microsoft-antispam-prvs: <AM0PR04MB6049166F578B099262560A41F61F0@AM0PR04MB6049.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 0052308DC6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(1496009)(396003)(136003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6436002)(476003)(73956011)(53936002)(486006)(11346002)(446003)(76116006)(186003)(5660300002)(102836004)(66446008)(66476007)(66946007)(26005)(44832011)(64756008)(36756003)(91956017)(66556008)(8936002)(316002)(2616005)(66066001)(99286004)(256004)(6116002)(6512007)(3846002)(76176011)(68736007)(305945005)(81156014)(81166006)(6486002)(6506007)(54906003)(110136005)(478600001)(2906002)(7736002)(8676002)(14454004)(86362001)(71190400001)(71200400001)(25786009)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6049;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hrHuM3TacZQwZLboW7CmaRJhZKOW1kbR+Fhemq01QdI6kwZQuRdINSiVQ210ZAnlVi6n3tZaBUic87A33qnJqf5w+ys8e+8xGeXzqQFe+ZT/Qulu/wRvxY+kverS9y8WoYXztVSXZ6fNuzfUhOHyjPVSXefFMy+JFZEDxv7siCeCvWbpiu0QvqG/rhffakxgR9LZOYq/GcFOxIgou9U2YwfbyCFh+Y7ryAVfgMEuQZjiHKrrWv5Z5ttPNYxL6UxYHrio9oHdsUTYJFPYW7GHpbqWWtxU+Hl4VgjgegsD4sT7CU5nOXrHmelmmK2InEjVH67qBkOfA0zn8JJjEmlpM1n+T5Le1Zg9FCa2B3DdFNPsw4Y19bH09VltxK6DycA+a0gE9Wg0obnnwtWc9i53I2rOTDupri0fAmc2ImknMJM=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <61EFB215A2021A4A93F4C3CCC846D66E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97363fd-19b4-48ce-778e-08d6e430ea6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2019 12:26:44.4124
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

Switch the imx_clk_fixup_divider function to clk_hw based API, rename
accordingly and add a macro for clk based legacy. This allows us to
move closer to a clear split between consumer and provider clk APIs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-fixup-div.c | 15 ++++++++++-----
 drivers/clk/imx/clk.h           |  7 +++++--
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/imx/clk-fixup-div.c b/drivers/clk/imx/clk-fixup-di=
v.c
index ce572273..287539b 100644
--- a/drivers/clk/imx/clk-fixup-div.c
+++ b/drivers/clk/imx/clk-fixup-div.c
@@ -91,13 +91,14 @@ static const struct clk_ops clk_fixup_div_ops =3D {
 	.set_rate =3D clk_fixup_div_set_rate,
 };
=20
-struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_fixup_divider(const char *name, const char *pare=
nt,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val))
 {
 	struct clk_fixup_div *fixup_div;
-	struct clk *clk;
+	struct clk_hw *hw;
 	struct clk_init_data init;
+	int ret;
=20
 	if (!fixup)
 		return ERR_PTR(-EINVAL);
@@ -120,9 +121,13 @@ struct clk *imx_clk_fixup_divider(const char *name, co=
nst char *parent,
 	fixup_div->ops =3D &clk_divider_ops;
 	fixup_div->fixup =3D fixup;
=20
-	clk =3D clk_register(NULL, &fixup_div->divider.hw);
-	if (IS_ERR(clk))
+	hw =3D &fixup_div->divider.hw;
+
+	ret =3D clk_hw_register(NULL, hw);
+	if (ret) {
 		kfree(fixup_div);
+		return ERR_PTR(ret);
+	}
=20
-	return clk;
+	return hw;
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 1c6300a..e199d73 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -73,6 +73,9 @@ struct imx_pll14xx_clk {
 #define imx_clk_gate_exclusive(name, parent, reg, shift, exclusive_mask) \
 	imx_clk_hw_gate_exclusive(name, parent, reg, shift, exclusive_mask)->clk
=20
+#define imx_clk_fixup_divider(name, parent, reg, shift, width, fixup) \
+	imx_clk_hw_fixup_divider(name, parent, reg, shift, width, fixup)->clk
+
 struct clk *imx_clk_pll14xx(const char *name, const char *parent_name,
 		 void __iomem *base, const struct imx_pll14xx_clk *pll_clk);
=20
@@ -149,11 +152,11 @@ struct clk_hw *imx7ulp_clk_composite(const char *name=
,
 				     bool rate_present, bool gate_present,
 				     void __iomem *reg);
=20
-struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
+struct clk_hw *imx_clk_hw_fixup_divider(const char *name, const char *pare=
nt,
 				  void __iomem *reg, u8 shift, u8 width,
 				  void (*fixup)(u32 *val));
=20
-struct clk *imx_clk_fixup_mux(const char *name, void __iomem *reg,
+struct clk_hw *imx_clk_hw_fixup_mux(const char *name, void __iomem *reg,
 			      u8 shift, u8 width, const char * const *parents,
 			      int num_parents, void (*fixup)(u32 *val));
=20
--=20
2.7.4
