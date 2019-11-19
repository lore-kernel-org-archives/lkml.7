Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2673EC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A9720857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="C73pTijy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfKSOI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:08:59 -0500
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:9830
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727096AbfKSOIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:08:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1f41hBSxZVtz74hFHKZ9YnsM44MbTwla0ogK1vcYCSWfDmXK3xdNcw1VtB2jYyU6Z3/DajKWIkPbsQKhiefY82YmTTGJ1bJoFPdkvRsFJ4ckrXdl7EljFw3QjPb8wT6ScoTKN4uX+HgVTFNG3I/f17nY9kidaPVfGoh0jOeYLpVjwHPec5stM9iCQ8ZDBq7OIb9Ae2Qasj5B/mi8+ug5PoGYaLY7M3WVI6ruMNn4x6yMeLm28bjmEKKL9bZjntsBHBlIuVn3LGU1Oo20zwNXNAVwp47DVmL8zB5xfoW0fmLif/VofgKF+SJQbb2KB7g9VqidjP0qWNNg3YpqrqYPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC2GU343O4t5XNii+GfUD1nkNS/Xmi7yZ1PmlFO1U5Q=;
 b=PLO16IHFBFGrvT8etwdxU9Pl80sBHLsreTqXq4cmB+czJukrNOFHkusFFek6/F6uvMCE6Ep1CrdwRnU2Z0FFUXqE5bTnuoXBBfL13tOe2u2KPKQpm4+qZORlbDgZU+nLmp8YelyAnA2oaodbyAp5Um4Osf3aQjfLorFY34zL2+/yViA3r3hz4qaMm6UxYYb+Mycwu1q+7g/vyc5i/0A1G9YDF0XwU0eHREXRXQRfJyLoW5cy1iP7B1iKmK/aRvTfi4ldDbTmB5TVZJjTCj0XGPnOhrB6ZF0ksZOlCpLXDttAMNpGlVZLit6/og+qtMrvv3gsKmnPMwx8cIU0ZRnreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pC2GU343O4t5XNii+GfUD1nkNS/Xmi7yZ1PmlFO1U5Q=;
 b=C73pTijyjBFTkXk12Qzd9tjBp5rsRV5AiI/KYdd3Gci/Xy9LHgfIiwhSXqfdA/iNuHpd8wgJU+qabxFzQnJmxhMQ/jnh5CnFX2zuNmCYojarxr4xQJKJ6w3LzWsBaeok83+sfu6y5sqP8DFLyXaO9Sf6ZgTVdanZpyWp1uTpA5Q=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5428.eurprd04.prod.outlook.com (20.178.113.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 14:08:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 14:08:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>
CC:     Peng Fan <peng.fan@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH 7/9] clk: imx: Rename the imx_clk_pfdv2 to imply it's clk_hw
 based
Thread-Topic: [PATCH 7/9] clk: imx: Rename the imx_clk_pfdv2 to imply it's
 clk_hw based
Thread-Index: AQHVnuLb/o3xDTwCkUG1Z/K9VcMjgA==
Date:   Tue, 19 Nov 2019 14:08:45 +0000
Message-ID: <1574172496-12987-8-git-send-email-abel.vesa@nxp.com>
References: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1574172496-12987-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:208:122::39) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5da2ffe6-24f3-466b-4ecf-08d76cf9fd9a
x-ms-traffictypediagnostic: AM0PR04MB5428:|AM0PR04MB5428:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5428400FACA43866C2BEBFDAF64C0@AM0PR04MB5428.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1247;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(110136005)(256004)(86362001)(316002)(66446008)(66556008)(66476007)(64756008)(66946007)(36756003)(446003)(7736002)(305945005)(186003)(3846002)(6116002)(26005)(5660300002)(478600001)(52116002)(76176011)(99286004)(2616005)(66066001)(54906003)(2906002)(11346002)(6506007)(476003)(44832011)(386003)(6636002)(486006)(6486002)(102836004)(25786009)(8936002)(71200400001)(81156014)(81166006)(71190400001)(50226002)(6512007)(4326008)(6436002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5428;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ttLaML7MdmJOsqnWS68TTPS7uEKvbktTO4Y1tg3MMBysQryS7LLWWPyUO5DB5quaX8/zOtFdXaXHMBCrMxUZ81S4dnU2kc6P0ErCxHsAgjPtN921EOBTq7kdmvXLGekx6Ur70Jp4OUYNMSVUEx4DxPCPO8diYnPs/54dKmPHpcFRm6ajOzqJYczPMzi2yiQBXLo/gxZbXS2dGOHV2dnOFQddoCLEp0qFlI9w7/49MoJcJ/ETtvndtEvhsQR51thbenMdF1HjtjbT7dHFUWMc7qoKFYrI5NtRPJ3oyc805LqN3mbk0AKsgNzWKifHLQeUYgTzHdCYVotrLDyn1qz/CADdG73llgI85WgrJ4fu0u3IRXr5O3cgeFvT40urIa8ptAins3WRG91SMmLOCrjgatFWBGQVKhUqfSspBPV/+aCHTT38Si/fGDrAVTkdHw3N
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da2ffe6-24f3-466b-4ecf-08d76cf9fd9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:08:45.5768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8imNGxWbPgD3ovQmV5g1+fsAjII2ho4uNsCTcdQCPX/+6m9YGIDccNG7CgMoUYGUisBtIu/FIzRzlrCMbwhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5428
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx_clk_pfdv2 register function to imx_clk_hw_pfdv2 to be
more obvious it is clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 16 ++++++++--------
 drivers/clk/imx/clk-pfdv2.c   |  2 +-
 drivers/clk/imx/clk.h         |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index afd2c2c..314f9c2 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -94,16 +94,16 @@ static void __init imx7ulp_clk_scg1_init(struct device_=
node *np)
 	clks[IMX7ULP_CLK_SPLL]		=3D imx_clk_hw_pllv4("spll",  "spll_pre_div", bas=
e + 0x600);
=20
 	/* APLL PFDs */
-	clks[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_pfdv2("apll_pfd0", "apll", base +=
 0x50c, 0);
-	clks[IMX7ULP_CLK_APLL_PFD1]	=3D imx_clk_pfdv2("apll_pfd1", "apll", base +=
 0x50c, 1);
-	clks[IMX7ULP_CLK_APLL_PFD2]	=3D imx_clk_pfdv2("apll_pfd2", "apll", base +=
 0x50c, 2);
-	clks[IMX7ULP_CLK_APLL_PFD3]	=3D imx_clk_pfdv2("apll_pfd3", "apll", base +=
 0x50c, 3);
+	clks[IMX7ULP_CLK_APLL_PFD0]	=3D imx_clk_hw_pfdv2("apll_pfd0", "apll", bas=
e + 0x50c, 0);
+	clks[IMX7ULP_CLK_APLL_PFD1]	=3D imx_clk_hw_pfdv2("apll_pfd1", "apll", bas=
e + 0x50c, 1);
+	clks[IMX7ULP_CLK_APLL_PFD2]	=3D imx_clk_hw_pfdv2("apll_pfd2", "apll", bas=
e + 0x50c, 2);
+	clks[IMX7ULP_CLK_APLL_PFD3]	=3D imx_clk_hw_pfdv2("apll_pfd3", "apll", bas=
e + 0x50c, 3);
=20
 	/* SPLL PFDs */
-	clks[IMX7ULP_CLK_SPLL_PFD0]	=3D imx_clk_pfdv2("spll_pfd0", "spll", base +=
 0x60C, 0);
-	clks[IMX7ULP_CLK_SPLL_PFD1]	=3D imx_clk_pfdv2("spll_pfd1", "spll", base +=
 0x60C, 1);
-	clks[IMX7ULP_CLK_SPLL_PFD2]	=3D imx_clk_pfdv2("spll_pfd2", "spll", base +=
 0x60C, 2);
-	clks[IMX7ULP_CLK_SPLL_PFD3]	=3D imx_clk_pfdv2("spll_pfd3", "spll", base +=
 0x60C, 3);
+	clks[IMX7ULP_CLK_SPLL_PFD0]	=3D imx_clk_hw_pfdv2("spll_pfd0", "spll", bas=
e + 0x60C, 0);
+	clks[IMX7ULP_CLK_SPLL_PFD1]	=3D imx_clk_hw_pfdv2("spll_pfd1", "spll", bas=
e + 0x60C, 1);
+	clks[IMX7ULP_CLK_SPLL_PFD2]	=3D imx_clk_hw_pfdv2("spll_pfd2", "spll", bas=
e + 0x60C, 2);
+	clks[IMX7ULP_CLK_SPLL_PFD3]	=3D imx_clk_hw_pfdv2("spll_pfd3", "spll", bas=
e + 0x60C, 3);
=20
 	/* PLL Mux */
 	clks[IMX7ULP_CLK_APLL_PFD_SEL]	=3D imx_clk_hw_mux_flags("apll_pfd_sel", b=
ase + 0x508, 14, 2, apll_pfd_sels, ARRAY_SIZE(apll_pfd_sels), CLK_SET_RATE_=
PARENT | CLK_SET_PARENT_GATE);
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index a03bbed..de93ce7 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -166,7 +166,7 @@ static const struct clk_ops clk_pfdv2_ops =3D {
 	.is_enabled     =3D clk_pfdv2_is_enabled,
 };
=20
-struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfdv2(const char *name, const char *parent_name,
 			     void __iomem *reg, u8 idx)
 {
 	struct clk_init_data init;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 0ac6614..afc87e4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -199,7 +199,7 @@ struct clk_hw *imx_clk_hw_gate_exclusive(const char *na=
me, const char *parent,
 struct clk_hw *imx_clk_hw_pfd(const char *name, const char *parent_name,
 		void __iomem *reg, u8 idx);
=20
-struct clk_hw *imx_clk_pfdv2(const char *name, const char *parent_name,
+struct clk_hw *imx_clk_hw_pfdv2(const char *name, const char *parent_name,
 			     void __iomem *reg, u8 idx);
=20
 struct clk_hw *imx_clk_hw_busy_divider(const char *name, const char *paren=
t_name,
--=20
2.7.4

