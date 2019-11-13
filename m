Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582E8222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 12:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s9TuKWx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfKMMZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:25:29 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:47362
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727427AbfKMMZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 07:25:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpkWcc8YDoS18HRAkEQACKlhi84nxApCg08MPZTbk9XV0iRg8m+9017FnnKOua9xjCIAnAxL7YUS2nITnQbmZtbJFC8fjl4dyg+6n+vYEqeg+zzsSTis80cTj1qwHRDZJrK1WeSV4aVeGovwPj3rkMnH8TYkcIQRd8+WkFur4LdLV1+2kbPyfdqZcPyTSztTpkUiHQpEZ/6lUk44CfrVHLD/ZwJyUHZoCySLV3aUtxFuLKW/1YVpUIX6T/uaM9+Rx/4jsZGlcFHTINu0CbiolJHD7V4XwaLdkCU/zmjlpHwXGdRnFjFXWS9A2nB5qVpoa052Ozi3PZ8hEcxLeRUL8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9awv5pDMUgD3nyqQRd0DGfUiukExSMdEM6U3q3P1Kvk=;
 b=N64xqLoR2KeLx9IoaOxhW+0eVYDaAeMcbKl4RHfrn9AvTlRkFfp0tuLY3wC9GycBv8Nxtbhz5XmwV96jvLbG9SaqZ072c4OuZ+ibpDBaA0pCnB7FgecO4u0bsW0uNJFTlF7btwnZMib5rlwgGRWDzG6SyhBDbqIM7G29ymvZM4IOzVG4iKCgQxJp+zDjRSK6fqqJvuxY41aTRrvAXGjXIdeJAiBQjNnvqwuOmJKgpo5na4avVnJAXOwl/nooCjFCk0i0YNkQhRRPDMAiZj1Px1GmIwC4Gtcc+jOddyOQlf/aHoG0RDWUuerLBXIrPCT31Z5MXEWpgBxT+wlEUht/IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9awv5pDMUgD3nyqQRd0DGfUiukExSMdEM6U3q3P1Kvk=;
 b=s9TuKWx/3mdkKXSWajNH//8iFLxUXSeJqRDE0UCzynUMiv5HYpBg3eNQVMu76Pf+YpKbskea9gwweP5uP3zb9/SyMt8Xur/VlHGWmaES8BdfXW4J567asjXDza0dNBTHsyGdEmmTzQqpZZa037lHq0e9VSzsbyd01pL4W8eczNU=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4499.eurprd04.prod.outlook.com (52.135.151.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Wed, 13 Nov 2019 12:25:15 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::fd44:1b14:587c:9fde%7]) with mapi id 15.20.2430.027; Wed, 13 Nov 2019
 12:25:15 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: [PATCH 3/3] clk: imx8qxp: Add ACM driver
Thread-Topic: [PATCH 3/3] clk: imx8qxp: Add ACM driver
Thread-Index: AQHVmh1noYxDOD5oOE6Oh5sdRghxRg==
Date:   Wed, 13 Nov 2019 12:25:15 +0000
Message-ID: <1573647909-31081-3-git-send-email-abel.vesa@nxp.com>
References: <1573647909-31081-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1573647909-31081-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM0PR0402CA0014.eurprd04.prod.outlook.com
 (2603:10a6:208:15::27) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [89.37.124.34]
x-mailer: git-send-email 2.7.4
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a83bad4e-b93e-4fcf-83df-08d768348967
x-ms-traffictypediagnostic: AM0PR04MB4499:|AM0PR04MB4499:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4499E44AFBB37FFC34218DB9F6760@AM0PR04MB4499.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0220D4B98D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(366004)(136003)(376002)(199004)(189003)(446003)(486006)(44832011)(2616005)(71200400001)(66446008)(66476007)(102836004)(76176011)(86362001)(6506007)(386003)(71190400001)(64756008)(256004)(14444005)(5024004)(6512007)(476003)(66066001)(5660300002)(36756003)(66946007)(11346002)(4326008)(66556008)(6636002)(6436002)(26005)(186003)(2906002)(7736002)(110136005)(8676002)(52116002)(99286004)(8936002)(316002)(478600001)(54906003)(14454004)(6116002)(3846002)(50226002)(25786009)(6486002)(305945005)(81156014)(81166006)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4499;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vxginrOtBh1sIBBSva+PaqMsWTaDw+oAET80AeyQ30CvzA/+W4eqbr7ULI+9bUJ7Wza6ch4MeDwLvuolpEDmzYBRKcB2bJa8G4snW1n/R8Y5sSRw8MDHa8HO0fn8PXZB0hfbdjwhusUmeGnxLpXrUQAhGXK5FyAsRbonSoK+DsSRmOSfOXj2MRbwcT36HGxNuUvsgATChYEsP3/aifpQHYiSbBN8TO4XYoUbNKmZSvUtGGUH/y3O9/EcnNfYkhmnrKTsNJxA8myEXDvc9txJ4Cten4ymHJEQ/L/UuCruxPRKLkEqwV61nf3VWTNr/BgYZDN7zXmiR4yYmv4S9P7UKMNAPSKNBUZWRZM9BtW0dnSQ3pPDfsiwYz2Y5moBEtQAG6fI8/rgOq8rvzBo9vaJZdBW1S87b9PVxyqlpbWoY/19KOkflrmj6onie7u4X1G0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83bad4e-b93e-4fcf-83df-08d768348967
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 12:25:15.1983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e3hqG4wWHX8XDMO3yQStSiqGZeVGH+epq0KKhuQRL8rvopziBIdzyHoyzeC6BGZGGVn6AQbWcJyW+QMJqGhhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the RM, the Audio Clock Mux (ACM) is a collection of control
registers and multiplexers that are used to route the audio source clocks
to the audio peripherals. Each audio peripheral has its dedicated audio
clock mux (which differ based on usage) and control register.
Control of ACM is behind the SCU firmware.

ACM depends on SCU PD, so its init level has to be after SCU PD
but before the LPCG. The fs_initcall ensures it's probed before LPCG clocks
also avoiding unnecessary massive defer probe.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/Makefile          |   2 +-
 drivers/clk/imx/clk-imx8qxp-acm.c | 189 ++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-imx8qxp-acm.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 77a3d71..6186839 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_MXC_CLK_SCU) +=3D \
 obj-$(CONFIG_CLK_IMX8MM) +=3D clk-imx8mm.o
 obj-$(CONFIG_CLK_IMX8MN) +=3D clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
-obj-$(CONFIG_CLK_IMX8QXP) +=3D clk-imx8qxp.o clk-imx8qxp-lpcg.o
+obj-$(CONFIG_CLK_IMX8QXP) +=3D clk-imx8qxp.o clk-imx8qxp-lpcg.o clk-imx8qx=
p-acm.o
=20
 obj-$(CONFIG_SOC_IMX1)   +=3D clk-imx1.o
 obj-$(CONFIG_SOC_IMX21)  +=3D clk-imx21.o
diff --git a/drivers/clk/imx/clk-imx8qxp-acm.c b/drivers/clk/imx/clk-imx8qx=
p-acm.c
new file mode 100644
index 00000000..7c00fd3
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8qxp-acm.c
@@ -0,0 +1,189 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2018 NXP
+ *	Dong Aisheng <aisheng.dong@nxp.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/pm_domain.h>
+
+#include "clk.h"
+#include "clk-scu.h"
+
+#include <dt-bindings/clock/imx8-clock.h>
+
+static const char * const aud_clk_sels[] =3D {
+	"aud_rec_clk0_lpcg_clk",
+	"aud_rec_clk1_lpcg_clk",
+	"ext_aud_mclk0",
+	"ext_aud_mclk1",
+	"esai0_rx_clk",
+	"esai0_rx_hf_clk",
+	"esai0_tx_clk",
+	"esai0_tx_hf_clk",
+	"spdif0_rx",
+	"sai0_rx_bclk",
+	"sai0_tx_bclk",
+	"sai1_rx_bclk",
+	"sai1_tx_bclk",
+	"sai2_rx_bclk",
+	"sai3_rx_bclk",
+};
+
+static const char * const mclk_out_sels[] =3D {
+	"aud_rec_clk0_lpcg_clk",
+	"aud_rec_clk1_lpcg_clk",
+	"dummy",
+	"dummy",
+	"spdif0_rx",
+	"dummy",
+	"dummy",
+	"sai4_rx_bclk",
+};
+
+static const char * const sai_mclk_sels[] =3D {
+	"aud_pll_div_clk0_lpcg_clk",
+	"aud_pll_div_clk1_lpcg_clk",
+	"acm_aud_clk0_sel",
+	"acm_aud_clk1_sel",
+};
+
+static const char * const esai_mclk_sels[] =3D {
+	"aud_pll_div_clk0_lpcg_clk",
+	"aud_pll_div_clk1_lpcg_clk",
+	"acm_aud_clk0_sel",
+	"acm_aud_clk1_sel",
+};
+
+static const char * const spdif_mclk_sels[] =3D {
+	"aud_pll_div_clk0_lpcg_clk",
+	"aud_pll_div_clk1_lpcg_clk",
+	"acm_aud_clk0_sel",
+	"acm_aud_clk1_sel",
+};
+
+static const char * const mqs_mclk_sels[] =3D {
+	"aud_pll_div_clk0_lpcg_clk",
+	"aud_pll_div_clk1_lpcg_clk",
+	"acm_aud_clk0_sel",
+	"acm_aud_clk1_sel",
+};
+
+static int imx8qxp_acm_clk_probe(struct platform_device *pdev)
+{
+	struct device *dev =3D &pdev->dev;
+	struct device_node *np =3D dev->of_node;
+	struct clk_onecell_data *clk_data;
+	struct resource *res;
+	struct clk **clks;
+	void __iomem *base;
+	int num_domains;
+	int i;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base =3D devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return -ENOMEM;
+
+	clk_data =3D kzalloc(sizeof(*clk_data), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	clk_data->clks =3D kcalloc(IMX_ADMA_ACM_CLK_END,
+					sizeof(*clk_data->clks), GFP_KERNEL);
+	if (!clk_data->clks)
+		return -ENOMEM;
+
+	clk_data->clk_num =3D IMX_ADMA_ACM_CLK_END;
+
+	clks =3D clk_data->clks;
+
+	num_domains =3D of_count_phandle_with_args(dev->of_node, "power-domains",
+						 "#power-domain-cells");
+	for (i =3D 0; i < num_domains; i++) {
+		struct device *pd_dev;
+		struct device_link *link;
+
+		pd_dev =3D dev_pm_domain_attach_by_id(&pdev->dev, i);
+		if (IS_ERR(pd_dev))
+			return PTR_ERR(pd_dev);
+
+		link =3D device_link_add(&pdev->dev, pd_dev,
+			DL_FLAG_STATELESS |
+			DL_FLAG_PM_RUNTIME |
+			DL_FLAG_RPM_ACTIVE);
+		if (IS_ERR(link))
+			return PTR_ERR(link);
+	}
+
+	clks[IMX_ADMA_EXT_AUD_MCLK0]     =3D imx_clk_fixed("ext_aud_mclk0", 0);
+	clks[IMX_ADMA_EXT_AUD_MCLK1]     =3D imx_clk_fixed("ext_aud_mclk1", 0);
+	clks[IMX_ADMA_ESAI0_RX_CLK]      =3D imx_clk_fixed("esai0_rx_clk", 0);
+	clks[IMX_ADMA_ESAI0_RX_HF_CLK]   =3D imx_clk_fixed("esai0_rx_hf_clk", 0);
+	clks[IMX_ADMA_ESAI0_TX_CLK]      =3D imx_clk_fixed("esai0_tx_clk", 0);
+	clks[IMX_ADMA_ESAI0_TX_HF_CLK]   =3D imx_clk_fixed("esai0_tx_hf_clk", 0);
+	clks[IMX_ADMA_SPDIF0_RX]         =3D imx_clk_fixed("spdif0_rx", 0);
+	clks[IMX_ADMA_SAI0_RX_BCLK]      =3D imx_clk_fixed("sai0_rx_bclk", 0);
+	clks[IMX_ADMA_SAI0_TX_BCLK]      =3D imx_clk_fixed("sai0_tx_bclk", 0);
+	clks[IMX_ADMA_SAI1_RX_BCLK]      =3D imx_clk_fixed("sai1_rx_bclk", 0);
+	clks[IMX_ADMA_SAI1_TX_BCLK]      =3D imx_clk_fixed("sai1_tx_bclk", 0);
+	clks[IMX_ADMA_SAI2_RX_BCLK]      =3D imx_clk_fixed("sai2_rx_bclk", 0);
+	clks[IMX_ADMA_SAI3_RX_BCLK]      =3D imx_clk_fixed("sai3_rx_bclk", 0);
+	clks[IMX_ADMA_SAI4_RX_BCLK]      =3D imx_clk_fixed("sai4_rx_bclk", 0);
+
+
+	clks[IMX_ADMA_ACM_AUD_CLK0_SEL] =3D imx_clk_mux("acm_aud_clk0_sel", base+=
0x000000, 0, 5, aud_clk_sels, ARRAY_SIZE(aud_clk_sels));
+	clks[IMX_ADMA_ACM_AUD_CLK1_CLK]	=3D imx_clk_mux("acm_aud_clk1_sel", base+=
0x010000, 0, 5, aud_clk_sels, ARRAY_SIZE(aud_clk_sels));
+
+	clks[IMX_ADMA_ACM_MCLKOUT0_SEL]	=3D imx_clk_mux("acm_mclkout0_sel", base+=
0x020000, 0, 3, mclk_out_sels, ARRAY_SIZE(mclk_out_sels));
+	clks[IMX_ADMA_ACM_MCLKOUT1_SEL]	=3D imx_clk_mux("acm_mclkout1_sel", base+=
0x030000, 0, 3, mclk_out_sels, ARRAY_SIZE(mclk_out_sels));
+
+	clks[IMX_ADMA_ACM_ASRC0_MUX_CLK_SEL] =3D imx_clk_mux("acm_asrc0_mclk_sel"=
, base+0x040000, 0, 2, NULL, 0);
+	clks[IMX_ADMA_ACM_ASRC1_MUX_CLK_SEL] =3D imx_clk_mux("acm_asrc1_mclk_sel"=
, base+0x050000, 0, 2, NULL, 0);
+
+	clks[IMX_ADMA_ACM_ESAI0_MCLK_SEL] =3D imx_clk_mux("acm_esai0_mclk_sel", b=
ase+0x060000, 0, 2, esai_mclk_sels, ARRAY_SIZE(esai_mclk_sels));
+	clks[IMX_ADMA_ACM_SAI0_MCLK_SEL] =3D imx_clk_mux("acm_sai0_mclk_sel", bas=
e+0x0E0000, 0, 2, sai_mclk_sels, ARRAY_SIZE(sai_mclk_sels));
+	clks[IMX_ADMA_ACM_SAI1_MCLK_SEL] =3D imx_clk_mux("acm_sai1_mclk_sel", bas=
e+0x0F0000, 0, 2, sai_mclk_sels, ARRAY_SIZE(sai_mclk_sels));
+	clks[IMX_ADMA_ACM_SAI2_MCLK_SEL] =3D imx_clk_mux("acm_sai2_mclk_sel", bas=
e+0x100000, 0, 2, sai_mclk_sels, ARRAY_SIZE(sai_mclk_sels));
+	clks[IMX_ADMA_ACM_SAI3_MCLK_SEL] =3D imx_clk_mux("acm_sai3_mclk_sel", bas=
e+0x110000, 0, 2, sai_mclk_sels, ARRAY_SIZE(sai_mclk_sels));
+	clks[IMX_ADMA_ACM_SAI4_MCLK_SEL] =3D imx_clk_mux("acm_sai4_mclk_sel", bas=
e+0x140000, 0, 2, sai_mclk_sels, ARRAY_SIZE(sai_mclk_sels));
+	clks[IMX_ADMA_ACM_SAI5_MCLK_SEL] =3D imx_clk_mux("acm_sai5_mclk_sel", bas=
e+0x150000, 0, 2, sai_mclk_sels, ARRAY_SIZE(sai_mclk_sels));
+
+	clks[IMX_ADMA_ACM_SPDIF0_TX_CLK_SEL] =3D imx_clk_mux("acm_spdif0_mclk_sel=
", base+0x1A0000, 0, 2, spdif_mclk_sels, ARRAY_SIZE(spdif_mclk_sels));
+	clks[IMX_ADMA_ACM_MQS_TX_CLK_SEL] =3D imx_clk_mux("acm_mqs_mclk_sel", bas=
e+0x1C0000, 0, 2, mqs_mclk_sels, ARRAY_SIZE(mqs_mclk_sels));
+
+	for (i =3D 0; i < clk_data->clk_num; i++) {
+		if (IS_ERR(clks[i]))
+			pr_warn("i.MX clk %u: register failed with %ld\n",
+				i, PTR_ERR(clks[i]));
+	}
+
+	return of_clk_add_provider(np, of_clk_src_onecell_get, clk_data);
+}
+
+static const struct of_device_id imx8qxp_acm_match[] =3D {
+	{ .compatible =3D "nxp,imx8qxp-acm", },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver imx8qxp_acm_clk_driver =3D {
+	.driver =3D {
+		.name =3D "imx8qxp-acm",
+		.of_match_table =3D imx8qxp_acm_match,
+		.suppress_bind_attrs =3D true,
+	},
+	.probe =3D imx8qxp_acm_clk_probe,
+};
+
+static int __init imx8qxp_acm_init(void)
+{
+	return platform_driver_register(&imx8qxp_acm_clk_driver);
+}
+fs_initcall(imx8qxp_acm_init);
--=20
2.7.4

