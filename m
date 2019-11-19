Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0AAC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07294208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="naxpto7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbfKSOJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:09:08 -0500
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:59905
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728022AbfKSOIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:08:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeZEOE4YVqRACaoha5UeoE6xX8ZOoiPhB/C9IhVi3xsJHISbcbtHiyxTuFtqVJS3KH4q8mXuffzpgm9/snWWr71mwH6GDCNseBOfB/PCv8xnbq2Lix529ZPoaeFry//1HgxUJ5rDFxCUGH2POHuF04T7rRXha38fQlT7kKsQBcJtMVkEg5HTbw1KGGw6y6H1BMAv/DdFvjMvHO95+bMMJ52C+cWxQ18ZERlGEvqidRNFxsDgxoAQIOxF6ILBK6hNMU2Q9iv/CtvAb6OelOUrF6fTfHaHHIYyD5jcM1tpiITZxIxOIZJ7N7zYpQVts+i+eDCIvH0aRFzb7Qnp/vFtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKo4iETy/t5rcqsD1LTgU3eCYJoZ3zKdixPiu8oLCA8=;
 b=jcz6Zl8p+un3+y1hyhfF8euqVbFlMOidcBE5sEY1WuEtnZDA4RDc+Y4C4kqMfpHlZWKsM5W2TiauYuivbS1qKqS1aJcv/rRhAbKi/vvGOKehYOXiEfpRaCHvIbgx057zbfGwKL+Gydpj3RHnyGhZjOAR3nctsh+xTEnQ0g/o/Fhz+vTCNNrG55uaqd1giP1NGoDWx37g/EfEgQOhRc/3+zdA3uwHEM6NC0B/yNVpYMoi0DWmZMxp1OdiTU8CbQc1Srw8d+2NI6l3wm7uHeO2JOdv+ZtOY2IDuSvDM6RmsuOI4XlMijALrfhplgjY1v+Vvwd4YWQ3Y080VKm80p3wPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKo4iETy/t5rcqsD1LTgU3eCYJoZ3zKdixPiu8oLCA8=;
 b=naxpto7/fPydbZfiiUKU8+SjMEFuZzr9foiM0ycisu5na6TNWnZ3Ebk6ARXeNK22IG2KabUNyup7eCp27FrK6+80JiVpy4jZSmDUukgjCBs2BS/HegQkQN+NQuvIB6kG2ogiddxQf1OEYfbw+xt2mltmE+ut2hpzlcRbQfH+WR4=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB7044.eurprd04.prod.outlook.com (10.186.128.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 14:08:46 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 14:08:46 +0000
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
Subject: [PATCH 8/9] clk: imx: Rename the imx_clk_divider_gate to imply it's
 clk_hw based
Thread-Topic: [PATCH 8/9] clk: imx: Rename the imx_clk_divider_gate to imply
 it's clk_hw based
Thread-Index: AQHVnuLbBfYfxYumjke+VVHiHCYc0g==
Date:   Tue, 19 Nov 2019 14:08:46 +0000
Message-ID: <1574172496-12987-9-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 45feb489-ff2b-47d6-67c3-08d76cf9fe23
x-ms-traffictypediagnostic: AM0PR04MB7044:|AM0PR04MB7044:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB7044E0F4D23F36D34CDCF4EDF64C0@AM0PR04MB7044.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(199004)(189003)(86362001)(66066001)(50226002)(386003)(486006)(102836004)(6506007)(26005)(66946007)(2906002)(6116002)(3846002)(6512007)(6486002)(4326008)(5660300002)(6436002)(7736002)(25786009)(14454004)(76176011)(71200400001)(305945005)(8936002)(6636002)(478600001)(44832011)(476003)(71190400001)(2616005)(446003)(11346002)(36756003)(256004)(14444005)(316002)(66476007)(81156014)(81166006)(186003)(54906003)(110136005)(99286004)(8676002)(66446008)(52116002)(64756008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7044;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fZa3geh0fojzrEa3l37jIWsmiOT3WZFXUl3s89i4xQVssoeYJ0UdzXkYsXCFgEiGWP2Z7DQRq/7oqQZxtt7ooksDqWoON/BgDscIm9BoX9LTxEAgm+AcFk3Kxc+F7Qympb356RoEcRhPRSHBB+IdZf3DrNSkXEhHRcH+ie5u97EbeoEvRWxNkAWkpkXVfvYjxkwamn/3JRh3QfJeUd2oSnOUkBeTfU7hQRDZCgzBGcjAoYaXGcJnXo2AjDYFpKxYUcZX+nz6279GF79AB18w/6hHLCmW1sN02MrgLTIV2D9dIJI8V/hrQDplqOqTVOrTfK6tHkg7/DKJ2/+SikQeP4xJ2wAeN3DDUL5yCgttH1xTwNaGF7H9nX+B4tGaY5gbIl9JmCETDb3CG84BQ1nR8s4PvOdHBUbnqb1WaoY1n6+4JlZ43RFPfd+PtfSUGlCo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45feb489-ff2b-47d6-67c3-08d76cf9fe23
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:08:46.5002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JzOo3lYsAjuguyFUPB5nWmL7FWLp0SoRDH0GiX1a0a64110VPWwxU9lZBru/ZRxPq1Ytp+Z2tm3peL+cJAixOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx_clk_divider_gate register function to imx_clk_hw_divider_g=
ate
to be more obvious it is clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-divider-gate.c | 2 +-
 drivers/clk/imx/clk-imx7ulp.c      | 8 ++++----
 drivers/clk/imx/clk.h              | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-divid=
er-gate.c
index 2a8352a..905aee5 100644
--- a/drivers/clk/imx/clk-divider-gate.c
+++ b/drivers/clk/imx/clk-divider-gate.c
@@ -173,7 +173,7 @@ static const struct clk_ops clk_divider_gate_ops =3D {
  * default as our HW is. Besides that it supports only CLK_DIVIDER_READ_ON=
LY
  * flag which can be specified by user flexibly.
  */
-struct clk_hw *imx_clk_divider_gate(const char *name, const char *parent_n=
ame,
+struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *paren=
t_name,
 				    unsigned long flags, void __iomem *reg,
 				    u8 shift, u8 width, u8 clk_divider_flags,
 				    const struct clk_div_table *table,
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 314f9c2..8657e5f 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -111,7 +111,7 @@ static void __init imx7ulp_clk_scg1_init(struct device_=
node *np)
 	clks[IMX7ULP_CLK_APLL_SEL]	=3D imx_clk_hw_mux_flags("apll_sel", base + 0x=
508, 1, 1, apll_sels, ARRAY_SIZE(apll_sels), CLK_SET_RATE_PARENT | CLK_SET_=
PARENT_GATE);
 	clks[IMX7ULP_CLK_SPLL_SEL]	=3D imx_clk_hw_mux_flags("spll_sel", base + 0x=
608, 1, 1, spll_sels, ARRAY_SIZE(spll_sels), CLK_SET_RATE_PARENT | CLK_SET_=
PARENT_GATE);
=20
-	clks[IMX7ULP_CLK_SPLL_BUS_CLK]	=3D imx_clk_divider_gate("spll_bus_clk", "=
spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, 0, ulp_div_table, &imx_cc=
m_lock);
+	clks[IMX7ULP_CLK_SPLL_BUS_CLK]	=3D imx_clk_hw_divider_gate("spll_bus_clk"=
, "spll_sel", CLK_SET_RATE_GATE, base + 0x604, 8, 3, 0, ulp_div_table, &imx=
_ccm_lock);
=20
 	/* scs/ddr/nic select different clock source requires that clock to be en=
abled first */
 	clks[IMX7ULP_CLK_SYS_SEL]	=3D imx_clk_hw_mux2("scs_sel", base + 0x14, 24,=
 4, scs_sels, ARRAY_SIZE(scs_sels));
@@ -122,7 +122,7 @@ static void __init imx7ulp_clk_scg1_init(struct device_=
node *np)
 	clks[IMX7ULP_CLK_CORE_DIV]	=3D imx_clk_hw_divider_flags("divcore",	"scs_s=
el",  base + 0x14, 16, 4, CLK_SET_RATE_PARENT);
 	clks[IMX7ULP_CLK_HSRUN_CORE_DIV] =3D imx_clk_hw_divider_flags("hsrun_divc=
ore", "hsrun_scs_sel", base + 0x1c, 16, 4, CLK_SET_RATE_PARENT);
=20
-	clks[IMX7ULP_CLK_DDR_DIV]	=3D imx_clk_divider_gate("ddr_clk", "ddr_sel", =
CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
+	clks[IMX7ULP_CLK_DDR_DIV]	=3D imx_clk_hw_divider_gate("ddr_clk", "ddr_sel=
", CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, base + 0x30, 0, 3,
 							       0, ulp_div_table, &imx_ccm_lock);
=20
 	clks[IMX7ULP_CLK_NIC0_DIV]	=3D imx_clk_hw_divider_flags("nic0_clk",		"nic=
_sel",  base + 0x40, 24, 4, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL);
@@ -131,9 +131,9 @@ static void __init imx7ulp_clk_scg1_init(struct device_=
node *np)
=20
 	clks[IMX7ULP_CLK_GPU_DIV]	=3D imx_clk_hw_divider("gpu_clk", "nic0_clk", b=
ase + 0x40, 20, 4);
=20
-	clks[IMX7ULP_CLK_SOSC_BUS_CLK]	=3D imx_clk_divider_gate("sosc_bus_clk", "=
sosc", 0, base + 0x104, 8, 3,
+	clks[IMX7ULP_CLK_SOSC_BUS_CLK]	=3D imx_clk_hw_divider_gate("sosc_bus_clk"=
, "sosc", 0, base + 0x104, 8, 3,
 							       CLK_DIVIDER_READ_ONLY, ulp_div_table, &imx_ccm_lock);
-	clks[IMX7ULP_CLK_FIRC_BUS_CLK]	=3D imx_clk_divider_gate("firc_bus_clk", "=
firc", 0, base + 0x304, 8, 3,
+	clks[IMX7ULP_CLK_FIRC_BUS_CLK]	=3D imx_clk_hw_divider_gate("firc_bus_clk"=
, "firc", 0, base + 0x304, 8, 3,
 							       CLK_DIVIDER_READ_ONLY, ulp_div_table, &imx_ccm_lock);
=20
 	imx_check_clk_hws(clks, clk_data->num);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index afc87e4..5cf2b38 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -461,7 +461,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 #define imx8m_clk_composite_critical(name, parent_names, reg) \
 	__imx8m_clk_composite(name, parent_names, reg, CLK_IS_CRITICAL)
=20
-struct clk_hw *imx_clk_divider_gate(const char *name, const char *parent_n=
ame,
+struct clk_hw *imx_clk_hw_divider_gate(const char *name, const char *paren=
t_name,
 		unsigned long flags, void __iomem *reg, u8 shift, u8 width,
 		u8 clk_divider_flags, const struct clk_div_table *table,
 		spinlock_t *lock);
--=20
2.7.4

