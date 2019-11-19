Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B52C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808C72084D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YaS8OVWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfKSOIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:08:51 -0500
Received: from mail-eopbgr00045.outbound.protection.outlook.com ([40.107.0.45]:9830
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfKSOIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:08:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgTfBxNBi71ANPRWN4LYnDE21WHuL3F1HRBS9Hi2FLP2+QMXaENxNx1KwNfbbXwgMmw+Nxbld7wOQQjaBwGTvAW/yLuEvl1p06PrbSDIn1pHbu5NB9wrIJ4w6fMpXAEAYgM3WjTe2IObgM3VBIN7Rd3ej5P0HA3jdiu+qJ8W6b8jkV4TXIAvGhX6KH15wugkxx3PlML5xgZyYJki7XrTwAl0L9xE0wF12ApDhxy4/TfETYUkfoVcGOtMmtt6KvNxskkO+MlxcaAwBTxV/KJ12syKcYcskRdojvYhD0T/obZj63fXPh4tso7s4SN2SzuTzB1PXuAUOrtcc4aaHVGJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em0+tEPm+fM1RQoTt9eGFjCNYY65xs32kEmPB8KeYu8=;
 b=Z39Sel7Vmu7x+F+QyhZx2FFFpJORlipOio41qGVpNmZdb/oVvrlpj11KtFL1WhN557TX4ycnQduP0G4DvArgSdMheIgYRXwYoaXtZ+RL7vJpkayGz4gSGS23apFymdou6Hyerkdp0gVjq4jNK+jVGD0BAVnXqIzg08wP+Isk6T3+mishodGTQLUDoJm1b1PicqfJkW940HefXDV0gC59ALSAweJ0BuEwXDHbAOma0mXwTWdvzGyVDxdKTzb/4YmAecO9l/Cf77ipfHhXmlv12ix+pPL7d97jcLI65T/BvqxeTXZNJV1H6L9CQQFDjC2aOr9vspfeH2PixGgPCTZI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Em0+tEPm+fM1RQoTt9eGFjCNYY65xs32kEmPB8KeYu8=;
 b=YaS8OVWLISb2BkgRWwbhy+Kw9oymsjmXtgOBNfrHhKBkRUsURD72ogk9jya4gnqZmg2HSm8afEOs24Tjf4AmWYHWLitu7wpv2H4sXOpO80+9QKY35UD095BMiBnjeUyNJCpGpojJk/EwQIyc2b2QwTw1gQYAA1knXoVa+ztulZg=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5428.eurprd04.prod.outlook.com (20.178.113.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Tue, 19 Nov 2019 14:08:42 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2451.029; Tue, 19 Nov 2019
 14:08:42 +0000
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
Subject: [PATCH 4/9] clk: imx: imx7ulp composite: Rename to show is clk_hw
 based
Thread-Topic: [PATCH 4/9] clk: imx: imx7ulp composite: Rename to show is
 clk_hw based
Thread-Index: AQHVnuLZxl6Ebo5i+U2W0HkqwIIVAQ==
Date:   Tue, 19 Nov 2019 14:08:41 +0000
Message-ID: <1574172496-12987-5-git-send-email-abel.vesa@nxp.com>
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
x-ms-office365-filtering-correlation-id: f94137f9-41f6-49f7-cc34-08d76cf9fb7a
x-ms-traffictypediagnostic: AM0PR04MB5428:|AM0PR04MB5428:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB54284389D567864B132525F2F64C0@AM0PR04MB5428.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:619;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(189003)(199004)(110136005)(14444005)(256004)(86362001)(316002)(66446008)(66556008)(66476007)(64756008)(66946007)(36756003)(446003)(7736002)(305945005)(186003)(3846002)(6116002)(26005)(5660300002)(478600001)(52116002)(76176011)(99286004)(2616005)(66066001)(54906003)(2906002)(11346002)(6506007)(476003)(44832011)(386003)(6636002)(486006)(6486002)(102836004)(30864003)(25786009)(8936002)(71200400001)(81156014)(81166006)(71190400001)(50226002)(6512007)(4326008)(6436002)(8676002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5428;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LfvADEZVtXX0he5lfrtC2cKGrCIrKF5lhG4Woze0EKfABUbYwqMlZdvbGLhE1WPf6LA/569KJhwDRnb9t17UQzhDhiW3dkeZ5EHVcvDdc9K1KI7ocqLanqLAsN6BfBM+9QrryZkvqlq4/H1HI4itOFWGqOoOtKGOIwKuxiObEuE8p0yLXQ5RC34A6b+MkmKSTiES3vcT6pi9wa4J5qsjX9sz1nHXdmJITVKJuMK+J22U1+wdBm8xFWPaNRQgaDotIfNZFVpMseJQgahLn/u5ByJ5GA3X66WsEWyZSXjElhZTQusYn2lGG3tsin635Fg0AiL2koN/uFLRAXp2372iNwLqFdz2No+dkH6e3IBiJgRMBMtpokJDhdsTPp8jQILrSndkvPpqwxLDO+ekAV0Vxnm9gO6Q4IrD+86UwlIpy+DuQkL/um7WMYN2Y1RrT4Zx
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f94137f9-41f6-49f7-cc34-08d76cf9fb7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 14:08:41.9579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ETGJKzbdZ0wMdg44MbfRgM2KbiIRzv2Bs8ko9IvwKaxf7yrdTvArrJyc/63u0iZwYpkhTlYAY0NuvIx+Yp1uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5428
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renaming the imx7ulp_clk_composite register function to
imx7ulp_clk_hw_composite to show it is clk_hw based.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-composite-7ulp.c |  2 +-
 drivers/clk/imx/clk-imx7ulp.c        | 52 ++++++++++++++++++--------------=
----
 drivers/clk/imx/clk.h                |  2 +-
 3 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-7ulp.c b/drivers/clk/imx/clk-com=
posite-7ulp.c
index 060f860..b9efcc8 100644
--- a/drivers/clk/imx/clk-composite-7ulp.c
+++ b/drivers/clk/imx/clk-composite-7ulp.c
@@ -21,7 +21,7 @@
 #define PCG_PCD_WIDTH	3
 #define PCG_PCD_MASK	0x7
=20
-struct clk_hw *imx7ulp_clk_composite(const char *name,
+struct clk_hw *imx7ulp_clk_hw_composite(const char *name,
 				     const char * const *parent_names,
 				     int num_parents, bool mux_present,
 				     bool rate_present, bool gate_present,
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 3fdf3d4..64b79a8 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -165,23 +165,23 @@ static void __init imx7ulp_clk_pcc2_init(struct devic=
e_node *np)
 	clks[IMX7ULP_CLK_RGPIO2P1]	=3D imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk"=
, base + 0x3c, 30);
 	clks[IMX7ULP_CLK_DMA_MUX1]	=3D imx_clk_hw_gate("dma_mux1", "nic1_bus_clk"=
, base + 0x84, 30);
 	clks[IMX7ULP_CLK_CAAM]		=3D imx_clk_hw_gate("caam", "nic1_clk", base + 0x=
90, 30);
-	clks[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_composite("lptpm4",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
-	clks[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_composite("lptpm5",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
-	clks[IMX7ULP_CLK_LPIT1]		=3D imx7ulp_clk_composite("lpit1",   periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
-	clks[IMX7ULP_CLK_LPSPI2]	=3D imx7ulp_clk_composite("lpspi2",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
-	clks[IMX7ULP_CLK_LPSPI3]	=3D imx7ulp_clk_composite("lpspi3",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
-	clks[IMX7ULP_CLK_LPI2C4]	=3D imx7ulp_clk_composite("lpi2c4",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
-	clks[IMX7ULP_CLK_LPI2C5]	=3D imx7ulp_clk_composite("lpi2c5",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
-	clks[IMX7ULP_CLK_LPUART4]	=3D imx7ulp_clk_composite("lpuart4", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
-	clks[IMX7ULP_CLK_LPUART5]	=3D imx7ulp_clk_composite("lpuart5", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
-	clks[IMX7ULP_CLK_FLEXIO1]	=3D imx7ulp_clk_composite("flexio1", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
-	clks[IMX7ULP_CLK_USB0]		=3D imx7ulp_clk_composite("usb0",    periph_plat_=
sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
-	clks[IMX7ULP_CLK_USB1]		=3D imx7ulp_clk_composite("usb1",    periph_plat_=
sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
+	clks[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_hw_composite("lptpm4",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_hw_composite("lptpm5",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPIT1]		=3D imx7ulp_clk_hw_composite("lpit1",   periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_LPSPI2]	=3D imx7ulp_clk_hw_composite("lpspi2",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa4);
+	clks[IMX7ULP_CLK_LPSPI3]	=3D imx7ulp_clk_hw_composite("lpspi3",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xa8);
+	clks[IMX7ULP_CLK_LPI2C4]	=3D imx7ulp_clk_hw_composite("lpi2c4",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xac);
+	clks[IMX7ULP_CLK_LPI2C5]	=3D imx7ulp_clk_hw_composite("lpi2c5",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb0);
+	clks[IMX7ULP_CLK_LPUART4]	=3D imx7ulp_clk_hw_composite("lpuart4", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb4);
+	clks[IMX7ULP_CLK_LPUART5]	=3D imx7ulp_clk_hw_composite("lpuart5", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xb8);
+	clks[IMX7ULP_CLK_FLEXIO1]	=3D imx7ulp_clk_hw_composite("flexio1", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0xc4);
+	clks[IMX7ULP_CLK_USB0]		=3D imx7ulp_clk_hw_composite("usb0",    periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xcc);
+	clks[IMX7ULP_CLK_USB1]		=3D imx7ulp_clk_hw_composite("usb1",    periph_pl=
at_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xd0);
 	clks[IMX7ULP_CLK_USB_PHY]	=3D imx_clk_hw_gate("usb_phy", "nic1_bus_clk", =
base + 0xd4, 30);
-	clks[IMX7ULP_CLK_USDHC0]	=3D imx7ulp_clk_composite("usdhc0",  periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
-	clks[IMX7ULP_CLK_USDHC1]	=3D imx7ulp_clk_composite("usdhc1",  periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
-	clks[IMX7ULP_CLK_WDG1]		=3D imx7ulp_clk_composite("wdg1",    periph_bus_s=
els, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
-	clks[IMX7ULP_CLK_WDG2]		=3D imx7ulp_clk_composite("sdg2",    periph_bus_s=
els, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
+	clks[IMX7ULP_CLK_USDHC0]	=3D imx7ulp_clk_hw_composite("usdhc0",  periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xdc);
+	clks[IMX7ULP_CLK_USDHC1]	=3D imx7ulp_clk_hw_composite("usdhc1",  periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xe0);
+	clks[IMX7ULP_CLK_WDG1]		=3D imx7ulp_clk_hw_composite("wdg1",    periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xf4);
+	clks[IMX7ULP_CLK_WDG2]		=3D imx7ulp_clk_hw_composite("sdg2",    periph_bu=
s_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0x10c);
=20
 	imx_check_clk_hws(clks, clk_data->num);
=20
@@ -216,17 +216,17 @@ static void __init imx7ulp_clk_pcc3_init(struct devic=
e_node *np)
 	base =3D of_iomap(np, 0);
 	WARN_ON(!base);
=20
-	clks[IMX7ULP_CLK_LPTPM6]	=3D imx7ulp_clk_composite("lptpm6",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
-	clks[IMX7ULP_CLK_LPTPM7]	=3D imx7ulp_clk_composite("lptpm7",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
+	clks[IMX7ULP_CLK_LPTPM6]	=3D imx7ulp_clk_hw_composite("lptpm6",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x84);
+	clks[IMX7ULP_CLK_LPTPM7]	=3D imx7ulp_clk_hw_composite("lptpm7",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x88);
=20
 	clks[IMX7ULP_CLK_MMDC]		=3D clk_hw_register_gate(NULL, "mmdc", "nic1_clk"=
, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 							       base + 0xac, 30, 0, &imx_ccm_lock);
-	clks[IMX7ULP_CLK_LPI2C6]	=3D imx7ulp_clk_composite("lpi2c6",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
-	clks[IMX7ULP_CLK_LPI2C7]	=3D imx7ulp_clk_composite("lpi2c7",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
-	clks[IMX7ULP_CLK_LPUART6]	=3D imx7ulp_clk_composite("lpuart6", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
-	clks[IMX7ULP_CLK_LPUART7]	=3D imx7ulp_clk_composite("lpuart7", periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
-	clks[IMX7ULP_CLK_DSI]		=3D imx7ulp_clk_composite("dsi",     periph_bus_se=
ls, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
-	clks[IMX7ULP_CLK_LCDIF]		=3D imx7ulp_clk_composite("lcdif",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
+	clks[IMX7ULP_CLK_LPI2C6]	=3D imx7ulp_clk_hw_composite("lpi2c6",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x90);
+	clks[IMX7ULP_CLK_LPI2C7]	=3D imx7ulp_clk_hw_composite("lpi2c7",  periph_b=
us_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
+	clks[IMX7ULP_CLK_LPUART6]	=3D imx7ulp_clk_hw_composite("lpuart6", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
+	clks[IMX7ULP_CLK_LPUART7]	=3D imx7ulp_clk_hw_composite("lpuart7", periph_=
bus_sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x9c);
+	clks[IMX7ULP_CLK_DSI]		=3D imx7ulp_clk_hw_composite("dsi",     periph_bus=
_sels, ARRAY_SIZE(periph_bus_sels), true, true,  true, base + 0xa4);
+	clks[IMX7ULP_CLK_LCDIF]		=3D imx7ulp_clk_hw_composite("lcdif",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, true,  true, base + 0xa8);
=20
 	clks[IMX7ULP_CLK_VIU]		=3D imx_clk_hw_gate("viu",   "nic1_clk",	   base +=
 0xa0, 30);
 	clks[IMX7ULP_CLK_PCTLC]		=3D imx_clk_hw_gate("pctlc", "nic1_bus_clk", bas=
e + 0xb8, 30);
@@ -234,8 +234,8 @@ static void __init imx7ulp_clk_pcc3_init(struct device_=
node *np)
 	clks[IMX7ULP_CLK_PCTLE]		=3D imx_clk_hw_gate("pctle", "nic1_bus_clk", bas=
e + 0xc0, 30);
 	clks[IMX7ULP_CLK_PCTLF]		=3D imx_clk_hw_gate("pctlf", "nic1_bus_clk", bas=
e + 0xc4, 30);
=20
-	clks[IMX7ULP_CLK_GPU3D]		=3D imx7ulp_clk_composite("gpu3d",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
-	clks[IMX7ULP_CLK_GPU2D]		=3D imx7ulp_clk_composite("gpu2d",   periph_plat=
_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
+	clks[IMX7ULP_CLK_GPU3D]		=3D imx7ulp_clk_hw_composite("gpu3d",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x140);
+	clks[IMX7ULP_CLK_GPU2D]		=3D imx7ulp_clk_hw_composite("gpu2d",   periph_p=
lat_sels, ARRAY_SIZE(periph_plat_sels), true, false, true, base + 0x144);
=20
 	imx_check_clk_hws(clks, clk_data->num);
=20
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index bb5243e..71b21ab 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -202,7 +202,7 @@ struct clk_hw *imx_clk_hw_busy_mux(const char *name, vo=
id __iomem *reg, u8 shift
 			     u8 width, void __iomem *busy_reg, u8 busy_shift,
 			     const char * const *parent_names, int num_parents);
=20
-struct clk_hw *imx7ulp_clk_composite(const char *name,
+struct clk_hw *imx7ulp_clk_hw_composite(const char *name,
 				     const char * const *parent_names,
 				     int num_parents, bool mux_present,
 				     bool rate_present, bool gate_present,
--=20
2.7.4

