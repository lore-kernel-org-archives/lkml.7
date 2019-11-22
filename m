Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6C2C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61179205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mXXF+LWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfKVKsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:48:36 -0500
Received: from mail-eopbgr60040.outbound.protection.outlook.com ([40.107.6.40]:54809
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729436AbfKVKs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:48:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYpU/1zeYYaLbkAjSAg6Xpu7uEj+io/JKROx5vpfPHnL0ZLMpAn08nUnUdsOgS3hULSmBeg8vHgdrFCVsfLMdQJcFUV62jeL2I5rPI/izRFj5NcFt//kvA2YOPPKVy3+p2Zj+COtHXe8kECCAVXfqO6M9arXUVnSPdMHPnlCszkcvq0502pGIA3xt5C0hJjyCiksJ8Pv4elLO6ng8zC/NSBmSjRzPZ+bPooe5n0Y4gR8gI7esTiuoQo9vkSUUUyAT6C8ivdZXFbCPZ6lVzmEG8bU8NYPEVyPPtCxtVaSl3kGQZh6028O+zSyEADhj63kmPX89rqBonUB0ODOKKybvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXi72J5YNtjeIM9Q9CYHEdM7/7lXpwQrwZq1xG5b5rQ=;
 b=Wv784Xvu/Hh2qefi65V2GEyVU+pThduWIN57EprBzPmklYOOGKCOhvnoncgzYAquN9QwvqgHCttgS6dfkikY+UsBv14ZMFqvjaBPIxRB7P2/rJ/9nCPnYcIrcr/NAkvwBt7a0yByf5JkbEVnKPtmKotaMbVNzTpUkEdPGrwd6Lil8ftRjRpPmMIKcqSne2KOCAqILCL1k5Jao1BQhltabsaWVkFpjbL90s33FHzKhgikpefTIyO725kjeTft6h7WrTRIRYxVHwIEt5IJ+mQQjAGdoWAps2uenrNcm422Gs2sJjfjY/8gxDrJTo7rlzbk7LIzpO2MnBk+0lH+uPeh1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXi72J5YNtjeIM9Q9CYHEdM7/7lXpwQrwZq1xG5b5rQ=;
 b=mXXF+LWdeRO+Xomt3VqdxJNCJnmB5+y/4tjqQl3+1m0iyyWomMlPMazjDbiZ0XOsKmVDSU3YBy4+jUHr9UCuEck+bRdODlbu++YZKNzXTPIXU+dXYIIO1B+T6nDAkcsOdM51LQ4xs0mo9uFGe9AQqEyAR8giUb3ngcQ0TBDhWys=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6961.eurprd04.prod.outlook.com (52.132.212.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Fri, 22 Nov 2019 10:48:20 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 10:48:20 +0000
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
Subject: [PATCH v2 10/11] clk: imx: Rename the imx_clk_divider_gate to imply
 it's clk_hw based
Thread-Topic: [PATCH v2 10/11] clk: imx: Rename the imx_clk_divider_gate to
 imply it's clk_hw based
Thread-Index: AQHVoSJa60rJnfieYEWB/AveoN7W2Q==
Date:   Fri, 22 Nov 2019 10:48:19 +0000
Message-ID: <1574419679-3813-11-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: 740287b7-edf2-487b-acff-08d76f397cc5
x-ms-traffictypediagnostic: AM0PR04MB6961:|AM0PR04MB6961:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB69619A72D140235C2E064136F6490@AM0PR04MB6961.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(189003)(199004)(186003)(44832011)(446003)(11346002)(2616005)(52116002)(76176011)(66446008)(64756008)(66556008)(66476007)(7736002)(478600001)(6636002)(36756003)(14444005)(5660300002)(6506007)(26005)(2906002)(86362001)(14454004)(102836004)(386003)(305945005)(25786009)(66946007)(256004)(110136005)(8936002)(50226002)(6116002)(316002)(99286004)(54906003)(81166006)(81156014)(8676002)(6436002)(6512007)(4326008)(71190400001)(3846002)(71200400001)(66066001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6961;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyJCDvqKpE3vYso1lRiIEbq+nqDsymUMv712tuv7rhhV7XEULnKYrWdTv+UqEUsGcib+Ppo3LL1cMcOGokTxEcjrIflwoFV2Nn3R4kre6z+0xzB4MkMCkVV/fYGBk8rouPiUdUSTWX0hl7VFIRnCFSDiR0mPuXEl3LmiR+B8zAwh75gcD4bxl/F0MMM74NfjoRFcvolXc3x319OBOjb71Du4bZgTgaWGVqeerAVl+MDF4t9w5vWMcHs+bgKbZN4WIN7ljRX4y6FiiuXCamnXH/Tljw7IxVpdvWSBoYxVXkYWdxuA3czEYT/yz2+dcFy/nvg4yP7vzYHx6CJtZnlr57bMepdQ7h1omlKPufB6R7M8TSMBgV8sczlMdLo+d4WFLrzTaX/gtMAREX3sO7nX3rWG3IYhiEiTrFK+tg2VlpIfwl3j5kl1Vpk983Yg2dYd
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740287b7-edf2-487b-acff-08d76f397cc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 10:48:19.5491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83ccdoIRkDHzG6zDtMz7l27XI35cui4VpjTD7WuIv90xtbZEZwgLJQsATXMk5dzLKwkx3q/L9KFHrltG9+bSCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6961
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx_clk_divider_gate register function to imx_clk_hw_divider_g=
ate
to be more obvious it is clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
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
index c9f626e..a1cb2d5 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -468,7 +468,7 @@ struct clk *imx8m_clk_composite_flags(const char *name,
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

