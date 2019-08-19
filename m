Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9C5C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC6D21852
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 09:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfHSJWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:22:37 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45735 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727469AbfHSJWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:22:30 -0400
X-UUID: 5b806eb5f9a944d18862df2c6133646a-20190819
X-UUID: 5b806eb5f9a944d18862df2c6133646a-20190819
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <mars.cheng@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0707 with TLS)
        with ESMTP id 788118059; Mon, 19 Aug 2019 17:22:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 19 Aug 2019 17:22:01 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 19 Aug 2019 17:22:01 +0800
From:   Mars Cheng <mars.cheng@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, mtk01761 <wendell.lin@mediatek.com>,
        <linux-clk@vger.kernel.org>
Subject: [PATCH v2 10/11] clk: mediatek: Add MT6779 clock support
Date:   Mon, 19 Aug 2019 17:21:41 +0800
Message-ID: <1566206502-4347-11-git-send-email-mars.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
References: <1566206502-4347-1-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: mtk01761 <wendell.lin@mediatek.com>

Add MT6779 clock support, include topckgen, apmixedsys,
infracfg, and subsystem clocks.

Signed-off-by: mtk01761 <wendell.lin@mediatek.com>
---
 drivers/clk/mediatek/Kconfig           |   56 ++
 drivers/clk/mediatek/Makefile          |    9 +
 drivers/clk/mediatek/clk-mt6779-aud.c  |  117 +++
 drivers/clk/mediatek/clk-mt6779-cam.c  |   66 ++
 drivers/clk/mediatek/clk-mt6779-img.c  |   58 ++
 drivers/clk/mediatek/clk-mt6779-ipe.c  |   60 ++
 drivers/clk/mediatek/clk-mt6779-mfg.c  |   55 ++
 drivers/clk/mediatek/clk-mt6779-mm.c   |  113 +++
 drivers/clk/mediatek/clk-mt6779-vdec.c |   67 ++
 drivers/clk/mediatek/clk-mt6779-venc.c |   58 ++
 drivers/clk/mediatek/clk-mt6779.c      | 1315 ++++++++++++++++++++++++++++++++
 11 files changed, 1974 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6779-aud.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-ipe.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt6779.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ce3d9b3..7efc361 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -117,6 +117,62 @@ config COMMON_CLK_MT2712_VENCSYS
 	---help---
 	  This driver supports MediaTek MT2712 vencsys clocks.
 
+config COMMON_CLK_MT6779
+	bool "Clock driver for MediaTek MT6779"
+	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK && ARM64
+	help
+	  This driver supports MediaTek MT6779 basic clocks.
+
+config COMMON_CLK_MT6779_MMSYS
+	bool "Clock driver for MediaTek MT6779 mmsys"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports MediaTek MT6779 mmsys clocks.
+
+config COMMON_CLK_MT6779_IMGSYS
+	bool "Clock driver for MediaTek MT6779 imgsys"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports MediaTek MT6779 imgsys clocks.
+
+config COMMON_CLK_MT6779_IPESYS
+	bool "Clock driver for MediaTek MT6779 ipesys"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports MediaTek MT6779 ipesys clocks.
+
+config COMMON_CLK_MT6779_CAMSYS
+	bool "Clock driver for MediaTek MT6779 camsys"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports MediaTek MT6779 camsys clocks.
+
+config COMMON_CLK_MT6779_VDECSYS
+	bool "Clock driver for MediaTek MT6779 vdecsys"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports MediaTek MT6779 vdecsys clocks.
+
+config COMMON_CLK_MT6779_VENCSYS
+	bool "Clock driver for MediaTek MT6779 vencsys"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports MediaTek MT6779 vencsys clocks.
+
+config COMMON_CLK_MT6779_MFGCFG
+	bool "Clock driver for MediaTek MT6779 mfgcfg"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports MediaTek MT6779 mfgcfg clocks.
+
+config COMMON_CLK_MT6779_AUDSYS
+	bool "Clock driver for Mediatek MT6779 audsys"
+	depends on COMMON_CLK_MT6779
+	help
+	  This driver supports Mediatek MT6779 audsys clocks.
+
 config COMMON_CLK_MT6797
        bool "Clock driver for MediaTek MT6797"
        depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 672de00..8cdb76a 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
 
+obj-$(CONFIG_COMMON_CLK_MT6779) += clk-mt6779.o
+obj-$(CONFIG_COMMON_CLK_MT6779_MMSYS) += clk-mt6779-mm.o
+obj-$(CONFIG_COMMON_CLK_MT6779_IMGSYS) += clk-mt6779-img.o
+obj-$(CONFIG_COMMON_CLK_MT6779_IPESYS) += clk-mt6779-ipe.o
+obj-$(CONFIG_COMMON_CLK_MT6779_CAMSYS) += clk-mt6779-cam.o
+obj-$(CONFIG_COMMON_CLK_MT6779_VDECSYS) += clk-mt6779-vdec.o
+obj-$(CONFIG_COMMON_CLK_MT6779_VENCSYS) += clk-mt6779-venc.o
+obj-$(CONFIG_COMMON_CLK_MT6779_MFGCFG) += clk-mt6779-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT6779_AUDSYS) += clk-mt6779-aud.o
 obj-$(CONFIG_COMMON_CLK_MT6797) += clk-mt6797.o
 obj-$(CONFIG_COMMON_CLK_MT6797_IMGSYS) += clk-mt6797-img.o
 obj-$(CONFIG_COMMON_CLK_MT6797_MMSYS) += clk-mt6797-mm.o
diff --git a/drivers/clk/mediatek/clk-mt6779-aud.c b/drivers/clk/mediatek/clk-mt6779-aud.c
new file mode 100644
index 0000000..11b209f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-aud.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt6779-clk.h>
+
+static const struct mtk_gate_regs audio0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs audio1_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x4,
+};
+
+#define GATE_AUDIO0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio0_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_no_setclr)
+#define GATE_AUDIO1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &audio1_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate audio_clks[] = {
+	/* AUDIO0 */
+	GATE_AUDIO0(CLK_AUD_AFE, "aud_afe", "audio_sel", 2),
+	GATE_AUDIO0(CLK_AUD_22M, "aud_22m", "aud_eng1_sel", 8),
+	GATE_AUDIO0(CLK_AUD_24M, "aud_24m", "aud_eng2_sel", 9),
+	GATE_AUDIO0(CLK_AUD_APLL2_TUNER, "aud_apll2_tuner",
+		    "aud_eng2_sel", 18),
+	GATE_AUDIO0(CLK_AUD_APLL_TUNER, "aud_apll_tuner",
+		    "aud_eng1_sel", 19),
+	GATE_AUDIO0(CLK_AUD_TDM, "aud_tdm", "aud_eng1_sel", 20),
+	GATE_AUDIO0(CLK_AUD_ADC, "aud_adc", "audio_sel", 24),
+	GATE_AUDIO0(CLK_AUD_DAC, "aud_dac", "audio_sel", 25),
+	GATE_AUDIO0(CLK_AUD_DAC_PREDIS, "aud_dac_predis",
+		    "audio_sel", 26),
+	GATE_AUDIO0(CLK_AUD_TML, "aud_tml", "audio_sel", 27),
+	GATE_AUDIO0(CLK_AUD_NLE, "aud_nle", "audio_sel", 28),
+	/* AUDIO1 */
+	GATE_AUDIO1(CLK_AUD_I2S1_BCLK_SW, "aud_i2s1_bclk",
+		    "audio_sel", 4),
+	GATE_AUDIO1(CLK_AUD_I2S2_BCLK_SW, "aud_i2s2_bclk",
+		    "audio_sel", 5),
+	GATE_AUDIO1(CLK_AUD_I2S3_BCLK_SW, "aud_i2s3_bclk",
+		    "audio_sel", 6),
+	GATE_AUDIO1(CLK_AUD_I2S4_BCLK_SW, "aud_i2s4_bclk",
+		    "audio_sel", 7),
+	GATE_AUDIO1(CLK_AUD_I2S5_BCLK_SW, "aud_i2s5_bclk",
+		    "audio_sel", 8),
+	GATE_AUDIO1(CLK_AUD_CONN_I2S_ASRC, "aud_conn_i2s",
+		    "audio_sel", 12),
+	GATE_AUDIO1(CLK_AUD_GENERAL1_ASRC, "aud_general1",
+		    "audio_sel", 13),
+	GATE_AUDIO1(CLK_AUD_GENERAL2_ASRC, "aud_general2",
+		    "audio_sel", 14),
+	GATE_AUDIO1(CLK_AUD_DAC_HIRES, "aud_dac_hires",
+		    "audio_h_sel", 15),
+	GATE_AUDIO1(CLK_AUD_ADC_HIRES, "aud_adc_hires",
+		    "audio_h_sel", 16),
+	GATE_AUDIO1(CLK_AUD_ADC_HIRES_TML, "aud_adc_hires_tml",
+		    "audio_h_sel", 17),
+	GATE_AUDIO1(CLK_AUD_PDN_ADDA6_ADC, "aud_pdn_adda6_adc",
+		    "audio_sel", 20),
+	GATE_AUDIO1(CLK_AUD_ADDA6_ADC_HIRES, "aud_adda6_adc_hires",
+		    "audio_h_sel",
+		    21),
+	GATE_AUDIO1(CLK_AUD_3RD_DAC, "aud_3rd_dac", "audio_sel",
+		    28),
+	GATE_AUDIO1(CLK_AUD_3RD_DAC_PREDIS, "aud_3rd_dac_predis",
+		    "audio_sel", 29),
+	GATE_AUDIO1(CLK_AUD_3RD_DAC_TML, "aud_3rd_dac_tml",
+		    "audio_sel", 30),
+	GATE_AUDIO1(CLK_AUD_3RD_DAC_HIRES, "aud_3rd_dac_hires",
+		    "audio_h_sel", 31),
+};
+
+static const struct of_device_id of_match_clk_mt6779_aud[] = {
+	{ .compatible = "mediatek,mt6779-audio", },
+	{}
+};
+
+static int clk_mt6779_aud_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
+
+	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt6779_aud_drv = {
+	.probe = clk_mt6779_aud_probe,
+	.driver = {
+		.name = "clk-mt6779-aud",
+		.of_match_table = of_match_clk_mt6779_aud,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_aud_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-cam.c b/drivers/clk/mediatek/clk-mt6779-cam.c
new file mode 100644
index 0000000..244d420
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-cam.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/mt6779-clk.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+static const struct mtk_gate_regs cam_cg_regs = {
+	.set_ofs = 0x0004,
+	.clr_ofs = 0x0008,
+	.sta_ofs = 0x0000,
+};
+
+#define GATE_CAM(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &cam_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate cam_clks[] = {
+	GATE_CAM(CLK_CAM_LARB10, "camsys_larb10", "cam_sel", 0),
+	GATE_CAM(CLK_CAM_DFP_VAD, "camsys_dfp_vad", "cam_sel", 1),
+	GATE_CAM(CLK_CAM_LARB11, "camsys_larb11", "cam_sel", 2),
+	GATE_CAM(CLK_CAM_LARB9, "camsys_larb9", "cam_sel", 3),
+	GATE_CAM(CLK_CAM_CAM, "camsys_cam", "cam_sel", 6),
+	GATE_CAM(CLK_CAM_CAMTG, "camsys_camtg", "cam_sel", 7),
+	GATE_CAM(CLK_CAM_SENINF, "camsys_seninf", "cam_sel", 8),
+	GATE_CAM(CLK_CAM_CAMSV0, "camsys_camsv0", "cam_sel", 9),
+	GATE_CAM(CLK_CAM_CAMSV1, "camsys_camsv1", "cam_sel", 10),
+	GATE_CAM(CLK_CAM_CAMSV2, "camsys_camsv2", "cam_sel", 11),
+	GATE_CAM(CLK_CAM_CAMSV3, "camsys_camsv3", "cam_sel", 12),
+	GATE_CAM(CLK_CAM_CCU, "camsys_ccu", "cam_sel", 13),
+	GATE_CAM(CLK_CAM_FAKE_ENG, "camsys_fake_eng", "cam_sel", 14),
+};
+
+static const struct of_device_id of_match_clk_mt6779_cam[] = {
+	{ .compatible = "mediatek,mt6779-camsys", },
+	{}
+};
+
+static int clk_mt6779_cam_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_CAM_NR_CLK);
+
+	mtk_clk_register_gates(node, cam_clks, ARRAY_SIZE(cam_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt6779_cam_drv = {
+	.probe = clk_mt6779_cam_probe,
+	.driver = {
+		.name = "clk-mt6779-cam",
+		.of_match_table = of_match_clk_mt6779_cam,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_cam_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-img.c b/drivers/clk/mediatek/clk-mt6779-img.c
new file mode 100644
index 0000000..26292a4
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-img.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/mt6779-clk.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+static const struct mtk_gate_regs img_cg_regs = {
+	.set_ofs = 0x0004,
+	.clr_ofs = 0x0008,
+	.sta_ofs = 0x0000,
+};
+
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate img_clks[] = {
+	GATE_IMG(CLK_IMG_LARB5, "imgsys_larb5", "img_sel", 0),
+	GATE_IMG(CLK_IMG_LARB6, "imgsys_larb6", "img_sel", 1),
+	GATE_IMG(CLK_IMG_DIP, "imgsys_dip", "img_sel", 2),
+	GATE_IMG(CLK_IMG_MFB, "imgsys_mfb", "img_sel", 6),
+	GATE_IMG(CLK_IMG_WPE_A, "imgsys_wpe_a", "img_sel", 7),
+};
+
+static const struct of_device_id of_match_clk_mt6779_img[] = {
+	{ .compatible = "mediatek,mt6779-imgsys", },
+	{}
+};
+
+static int clk_mt6779_img_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_IMG_NR_CLK);
+
+	mtk_clk_register_gates(node, img_clks, ARRAY_SIZE(img_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt6779_img_drv = {
+	.probe = clk_mt6779_img_probe,
+	.driver = {
+		.name = "clk-mt6779-img",
+		.of_match_table = of_match_clk_mt6779_img,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_img_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-ipe.c b/drivers/clk/mediatek/clk-mt6779-ipe.c
new file mode 100644
index 0000000..bb51907
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-ipe.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/mt6779-clk.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+static const struct mtk_gate_regs ipe_cg_regs = {
+	.set_ofs = 0x0004,
+	.clr_ofs = 0x0008,
+	.sta_ofs = 0x0000,
+};
+
+#define GATE_IPE(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &ipe_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ipe_clks[] = {
+	GATE_IPE(CLK_IPE_LARB7, "ipe_larb7", "ipe_sel", 0),
+	GATE_IPE(CLK_IPE_LARB8, "ipe_larb8", "ipe_sel", 1),
+	GATE_IPE(CLK_IPE_SMI_SUBCOM, "ipe_smi_subcom", "ipe_sel", 2),
+	GATE_IPE(CLK_IPE_FD, "ipe_fd", "ipe_sel", 3),
+	GATE_IPE(CLK_IPE_FE, "ipe_fe", "ipe_sel", 4),
+	GATE_IPE(CLK_IPE_RSC, "ipe_rsc", "ipe_sel", 5),
+	GATE_IPE(CLK_IPE_DPE, "ipe_dpe", "ipe_sel", 6),
+};
+
+static const struct of_device_id of_match_clk_mt6779_ipe[] = {
+	{ .compatible = "mediatek,mt6779-ipesys", },
+	{}
+};
+
+static int clk_mt6779_ipe_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_IPE_NR_CLK);
+
+	mtk_clk_register_gates(node, ipe_clks, ARRAY_SIZE(ipe_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt6779_ipe_drv = {
+	.probe = clk_mt6779_ipe_probe,
+	.driver = {
+		.name = "clk-mt6779-ipe",
+		.of_match_table = of_match_clk_mt6779_ipe,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_ipe_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-mfg.c b/drivers/clk/mediatek/clk-mt6779-mfg.c
new file mode 100644
index 0000000..c6ee2a8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-mfg.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt6779-clk.h>
+
+static const struct mtk_gate_regs mfg_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_MFG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mfg_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mfg_clks[] = {
+	GATE_MFG(CLK_MFGCFG_BG3D, "mfg_bg3d", "mfg_sel", 0),
+};
+
+static int clk_mt6779_mfg_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_MFGCFG_NR_CLK);
+
+	mtk_clk_register_gates(node, mfg_clks, ARRAY_SIZE(mfg_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static const struct of_device_id of_match_clk_mt6779_mfg[] = {
+	{ .compatible = "mediatek,mt6779-mfgcfg", },
+	{}
+};
+
+static struct platform_driver clk_mt6779_mfg_drv = {
+	.probe = clk_mt6779_mfg_probe,
+	.driver = {
+		.name = "clk-mt6779-mfg",
+		.of_match_table = of_match_clk_mt6779_mfg,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_mfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
new file mode 100644
index 0000000..fb5fbb8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/mt6779-clk.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x0104,
+	.clr_ofs = 0x0108,
+	.sta_ofs = 0x0100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x0114,
+	.clr_ofs = 0x0118,
+	.sta_ofs = 0x0110,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+#define GATE_MM1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
+	GATE_MM0(CLK_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 1),
+	GATE_MM0(CLK_MM_SMI_LARB1, "mm_smi_larb1", "mm_sel", 2),
+	GATE_MM0(CLK_MM_GALS_COMM0, "mm_gals_comm0", "mm_sel", 3),
+	GATE_MM0(CLK_MM_GALS_COMM1, "mm_gals_comm1", "mm_sel", 4),
+	GATE_MM0(CLK_MM_GALS_CCU2MM, "mm_gals_ccu2mm", "mm_sel", 5),
+	GATE_MM0(CLK_MM_GALS_IPU12MM, "mm_gals_ipu12mm", "mm_sel", 6),
+	GATE_MM0(CLK_MM_GALS_IMG2MM, "mm_gals_img2mm", "mm_sel", 7),
+	GATE_MM0(CLK_MM_GALS_CAM2MM, "mm_gals_cam2mm", "mm_sel", 8),
+	GATE_MM0(CLK_MM_GALS_IPU2MM, "mm_gals_ipu2mm", "mm_sel", 9),
+	GATE_MM0(CLK_MM_MDP_DL_TXCK, "mm_mdp_dl_txck", "mm_sel", 10),
+	GATE_MM0(CLK_MM_IPU_DL_TXCK, "mm_ipu_dl_txck", "mm_sel", 11),
+	GATE_MM0(CLK_MM_MDP_RDMA0, "mm_mdp_rdma0", "mm_sel", 12),
+	GATE_MM0(CLK_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 13),
+	GATE_MM0(CLK_MM_MDP_RSZ0, "mm_mdp_rsz0", "mm_sel", 14),
+	GATE_MM0(CLK_MM_MDP_RSZ1, "mm_mdp_rsz1", "mm_sel", 15),
+	GATE_MM0(CLK_MM_MDP_TDSHP, "mm_mdp_tdshp", "mm_sel", 16),
+	GATE_MM0(CLK_MM_MDP_WROT0, "mm_mdp_wrot0", "mm_sel", 17),
+	GATE_MM0(CLK_MM_MDP_WROT1, "mm_mdp_wrot1", "mm_sel", 18),
+	GATE_MM0(CLK_MM_FAKE_ENG, "mm_fake_eng", "mm_sel", 19),
+	GATE_MM0(CLK_MM_DISP_OVL0, "mm_disp_ovl0", "mm_sel", 20),
+	GATE_MM0(CLK_MM_DISP_OVL0_2L, "mm_disp_ovl0_2l", "mm_sel", 21),
+	GATE_MM0(CLK_MM_DISP_OVL1_2L, "mm_disp_ovl1_2l", "mm_sel", 22),
+	GATE_MM0(CLK_MM_DISP_RDMA0, "mm_disp_rdma0", "mm_sel", 23),
+	GATE_MM0(CLK_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 24),
+	GATE_MM0(CLK_MM_DISP_WDMA0, "mm_disp_wdma0", "mm_sel", 25),
+	GATE_MM0(CLK_MM_DISP_COLOR0, "mm_disp_color0", "mm_sel", 26),
+	GATE_MM0(CLK_MM_DISP_CCORR0, "mm_disp_ccorr0", "mm_sel", 27),
+	GATE_MM0(CLK_MM_DISP_AAL0, "mm_disp_aal0", "mm_sel", 28),
+	GATE_MM0(CLK_MM_DISP_GAMMA0, "mm_disp_gamma0", "mm_sel", 29),
+	GATE_MM0(CLK_MM_DISP_DITHER0, "mm_disp_dither0", "mm_sel", 30),
+	GATE_MM0(CLK_MM_DISP_SPLIT, "mm_disp_split", "mm_sel", 31),
+	/* MM1 */
+	GATE_MM1(CLK_MM_DSI0_MM_CK, "mm_dsi0_mmck", "mm_sel", 0),
+	GATE_MM1(CLK_MM_DSI0_IF_CK, "mm_dsi0_ifck", "mm_sel", 1),
+	GATE_MM1(CLK_MM_DPI_MM_CK, "mm_dpi_mmck", "mm_sel", 2),
+	GATE_MM1(CLK_MM_DPI_IF_CK, "mm_dpi_ifck", "dpi0_sel", 3),
+	GATE_MM1(CLK_MM_FAKE_ENG2, "mm_fake_eng2", "mm_sel", 4),
+	GATE_MM1(CLK_MM_MDP_DL_RX_CK, "mm_mdp_dl_rxck", "mm_sel", 5),
+	GATE_MM1(CLK_MM_IPU_DL_RX_CK, "mm_ipu_dl_rxck", "mm_sel", 6),
+	GATE_MM1(CLK_MM_26M, "mm_26m", "f_f26m_ck", 7),
+	GATE_MM1(CLK_MM_MM_R2Y, "mm_mmsys_r2y", "mm_sel", 8),
+	GATE_MM1(CLK_MM_DISP_RSZ, "mm_disp_rsz", "mm_sel", 9),
+	GATE_MM1(CLK_MM_MDP_AAL, "mm_mdp_aal", "mm_sel", 10),
+	GATE_MM1(CLK_MM_MDP_HDR, "mm_mdp_hdr", "mm_sel", 11),
+	GATE_MM1(CLK_MM_DBI_MM_CK, "mm_dbi_mmck", "mm_sel", 12),
+	GATE_MM1(CLK_MM_DBI_IF_CK, "mm_dbi_ifck", "dpi0_sel", 13),
+	GATE_MM1(CLK_MM_DISP_POSTMASK0, "mm_disp_pm0", "mm_sel", 14),
+	GATE_MM1(CLK_MM_DISP_HRT_BW, "mm_disp_hrt_bw", "mm_sel", 15),
+	GATE_MM1(CLK_MM_DISP_OVL_FBDC, "mm_disp_ovl_fbdc", "mm_sel", 16),
+};
+
+static const struct of_device_id of_match_clk_mt6779_mm[] = {
+	{ .compatible = "mediatek,mt6779-mmsys", },
+	{}
+};
+
+static int clk_mt6779_mm_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+
+	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt6779_mm_drv = {
+	.probe = clk_mt6779_mm_probe,
+	.driver = {
+		.name = "clk-mt6779-mm",
+		.of_match_table = of_match_clk_mt6779_mm,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-vdec.c b/drivers/clk/mediatek/clk-mt6779-vdec.c
new file mode 100644
index 0000000..1900da2
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-vdec.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt6779-clk.h>
+
+static const struct mtk_gate_regs vdec0_cg_regs = {
+	.set_ofs = 0x0000,
+	.clr_ofs = 0x0004,
+	.sta_ofs = 0x0000,
+};
+
+static const struct mtk_gate_regs vdec1_cg_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x000c,
+	.sta_ofs = 0x0008,
+};
+
+#define GATE_VDEC0_I(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr_inv)
+#define GATE_VDEC1_I(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate vdec_clks[] = {
+	/* VDEC0 */
+	GATE_VDEC0_I(CLK_VDEC_VDEC, "vdec_cken", "vdec_sel", 0),
+	/* VDEC1 */
+	GATE_VDEC1_I(CLK_VDEC_LARB1, "vdec_larb1_cken", "vdec_sel", 0),
+};
+
+static const struct of_device_id of_match_clk_mt6779_vdec[] = {
+	{ .compatible = "mediatek,mt6779-vdecsys", },
+	{}
+};
+
+static int clk_mt6779_vdec_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_VDEC_GCON_NR_CLK);
+
+	mtk_clk_register_gates(node, vdec_clks, ARRAY_SIZE(vdec_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt6779_vdec_drv = {
+	.probe = clk_mt6779_vdec_probe,
+	.driver = {
+		.name = "clk-mt6779-vdec",
+		.of_match_table = of_match_clk_mt6779_vdec,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-venc.c b/drivers/clk/mediatek/clk-mt6779-venc.c
new file mode 100644
index 0000000..b41d1f8
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779-venc.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt6779-clk.h>
+
+static const struct mtk_gate_regs venc_cg_regs = {
+	.set_ofs = 0x0004,
+	.clr_ofs = 0x0008,
+	.sta_ofs = 0x0000,
+};
+
+#define GATE_VENC_I(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate venc_clks[] = {
+	GATE_VENC_I(CLK_VENC_GCON_LARB, "venc_larb", "venc_sel", 0),
+	GATE_VENC_I(CLK_VENC_GCON_VENC, "venc_venc", "venc_sel", 4),
+	GATE_VENC_I(CLK_VENC_GCON_JPGENC, "venc_jpgenc", "venc_sel", 8),
+	GATE_VENC_I(CLK_VENC_GCON_GALS, "venc_gals", "venc_sel", 28),
+};
+
+static const struct of_device_id of_match_clk_mt6779_venc[] = {
+	{ .compatible = "mediatek,mt6779-vencsys", },
+	{}
+};
+
+static int clk_mt6779_venc_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_VENC_GCON_NR_CLK);
+
+	mtk_clk_register_gates(node, venc_clks, ARRAY_SIZE(venc_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt6779_venc_drv = {
+	.probe = clk_mt6779_venc_probe,
+	.driver = {
+		.name = "clk-mt6779-venc",
+		.of_match_table = of_match_clk_mt6779_venc,
+	},
+};
+
+builtin_platform_driver(clk_mt6779_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
new file mode 100644
index 0000000..608a9a6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -0,0 +1,1315 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: Wendell Lin <wendell.lin@mediatek.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt6779-clk.h>
+
+static DEFINE_SPINLOCK(mt6779_clk_lock);
+
+static const struct mtk_fixed_clk top_fixed_clks[] = {
+	FIXED_CLK(CLK_TOP_CLK26M, "f_f26m_ck", "clk26m", 26000000),
+};
+
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_CLK13M, "clk13m", "clk26m", 1, 2),
+	FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),
+	FACTOR(CLK_TOP_MAINPLL_CK, "mainpll_ck", "mainpll", 1, 1),
+	FACTOR(CLK_TOP_MAINPLL_D2, "mainpll_d2", "mainpll_ck", 1, 2),
+	FACTOR(CLK_TOP_MAINPLL_D2_D2, "mainpll_d2_d2", "mainpll_d2", 1, 2),
+	FACTOR(CLK_TOP_MAINPLL_D2_D4, "mainpll_d2_d4", "mainpll_d2", 1, 4),
+	FACTOR(CLK_TOP_MAINPLL_D2_D8, "mainpll_d2_d8", "mainpll_d2", 1, 8),
+	FACTOR(CLK_TOP_MAINPLL_D2_D16, "mainpll_d2_d16", "mainpll_d2", 1, 16),
+	FACTOR(CLK_TOP_MAINPLL_D3, "mainpll_d3", "mainpll", 1, 3),
+	FACTOR(CLK_TOP_MAINPLL_D3_D2, "mainpll_d3_d2", "mainpll_d3", 1, 2),
+	FACTOR(CLK_TOP_MAINPLL_D3_D4, "mainpll_d3_d4", "mainpll_d3", 1, 4),
+	FACTOR(CLK_TOP_MAINPLL_D3_D8, "mainpll_d3_d8", "mainpll_d3", 1, 8),
+	FACTOR(CLK_TOP_MAINPLL_D5, "mainpll_d5", "mainpll", 1, 5),
+	FACTOR(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2", "mainpll_d5", 1, 2),
+	FACTOR(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4", "mainpll_d5", 1, 4),
+	FACTOR(CLK_TOP_MAINPLL_D7, "mainpll_d7", "mainpll", 1, 7),
+	FACTOR(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2", "mainpll_d7", 1, 2),
+	FACTOR(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4", "mainpll_d7", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_CK, "univpll", "univ2pll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D2_D2, "univpll_d2_d2", "univpll_d2", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D2_D4, "univpll_d2_d4", "univpll_d2", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D2_D8, "univpll_d2_d8", "univpll_d2", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D2, "univpll_d3_d2", "univpll_d3", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D4, "univpll_d3_d4", "univpll_d3", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D8, "univpll_d3_d8", "univpll_d3", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D16, "univpll_d3_d16", "univpll_d3", 1, 16),
+	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll_d5", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll_d5", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D8, "univpll_d5_d8", "univpll_d5", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7),
+	FACTOR(CLK_TOP_UNIVP_192M_CK, "univpll_192m_ck", "univ2pll", 1, 13),
+	FACTOR(CLK_TOP_UNIVP_192M_D2, "univpll_192m_d2", "univpll_192m_ck",
+	       1, 2),
+	FACTOR(CLK_TOP_UNIVP_192M_D4, "univpll_192m_d4", "univpll_192m_ck",
+	       1, 4),
+	FACTOR(CLK_TOP_UNIVP_192M_D8, "univpll_192m_d8", "univpll_192m_ck",
+	       1, 8),
+	FACTOR(CLK_TOP_UNIVP_192M_D16, "univpll_192m_d16", "univpll_192m_ck",
+	       1, 16),
+	FACTOR(CLK_TOP_UNIVP_192M_D32, "univpll_192m_d32", "univpll_192m_ck",
+	       1, 32),
+	FACTOR(CLK_TOP_APLL1_CK, "apll1_ck", "apll1", 1, 1),
+	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1", 1, 2),
+	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1, 4),
+	FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", "apll1", 1, 8),
+	FACTOR(CLK_TOP_APLL2_CK, "apll2_ck", "apll2", 1, 1),
+	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", "apll2", 1, 2),
+	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2", 1, 4),
+	FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", "apll2", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL_CK, "tvdpll_ck", "tvdpll", 1, 1),
+	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_ck", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll", 1, 16),
+	FACTOR(CLK_TOP_MMPLL_CK, "mmpll_ck", "mmpll", 1, 1),
+	FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4", "mmpll", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D4_D2, "mmpll_d4_d2", "mmpll_d4", 1, 2),
+	FACTOR(CLK_TOP_MMPLL_D4_D4, "mmpll_d4_d4", "mmpll_d4", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D5, "mmpll_d5", "mmpll", 1, 5),
+	FACTOR(CLK_TOP_MMPLL_D5_D2, "mmpll_d5_d2", "mmpll_d5", 1, 2),
+	FACTOR(CLK_TOP_MMPLL_D5_D4, "mmpll_d5_d4", "mmpll_d5", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D6, "mmpll_d6", "mmpll", 1, 6),
+	FACTOR(CLK_TOP_MMPLL_D7, "mmpll_d7", "mmpll", 1, 7),
+	FACTOR(CLK_TOP_MFGPLL_CK, "mfgpll_ck", "mfgpll", 1, 1),
+	FACTOR(CLK_TOP_ADSPPLL_CK, "adsppll_ck", "adsppll", 1, 1),
+	FACTOR(CLK_TOP_ADSPPLL_D4, "adsppll_d4", "adsppll", 1, 4),
+	FACTOR(CLK_TOP_ADSPPLL_D5, "adsppll_d5", "adsppll", 1, 5),
+	FACTOR(CLK_TOP_ADSPPLL_D6, "adsppll_d6", "adsppll", 1, 6),
+	FACTOR(CLK_TOP_MSDCPLL_CK, "msdcpll_ck", "msdcpll", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
+	FACTOR(CLK_TOP_MSDCPLL_D8, "msdcpll_d8", "msdcpll", 1, 8),
+	FACTOR(CLK_TOP_MSDCPLL_D16, "msdcpll_d16", "msdcpll", 1, 16),
+	FACTOR(CLK_TOP_AD_OSC_CK, "ad_osc_ck", "osc", 1, 1),
+	FACTOR(CLK_TOP_OSC_D2, "osc_d2", "osc", 1, 2),
+	FACTOR(CLK_TOP_OSC_D4, "osc_d4", "osc", 1, 4),
+	FACTOR(CLK_TOP_OSC_D8, "osc_d8", "osc", 1, 8),
+	FACTOR(CLK_TOP_OSC_D10, "osc_d10", "osc", 1, 10),
+	FACTOR(CLK_TOP_OSC_D16, "osc_d16", "osc", 1, 16),
+	FACTOR(CLK_TOP_AD_OSC2_CK, "ad_osc2_ck", "osc2", 1, 1),
+	FACTOR(CLK_TOP_OSC2_D2, "osc2_d2", "osc2", 1, 2),
+	FACTOR(CLK_TOP_OSC2_D3, "osc2_d3", "osc2", 1, 3),
+	FACTOR(CLK_TOP_TVDPLL_MAINPLL_D2_CK, "tvdpll_mainpll_d2_ck",
+	       "tvdpll", 1, 1),
+	FACTOR(CLK_TOP_FMEM_466M_CK, "fmem_466m_ck", "fmem", 1, 1),
+};
+
+static const char * const axi_parents[] = {
+	"clk26m",
+	"mainpll_d2_d4",
+	"mainpll_d7",
+	"osc_d4"
+};
+
+static const char * const mm_parents[] = {
+	"clk26m",
+	"tvdpll_mainpll_d2_ck",
+	"mmpll_d7",
+	"mmpll_d5_d2",
+	"mainpll_d2_d2",
+	"mainpll_d3_d2"
+};
+
+static const char * const scp_parents[] = {
+	"clk26m",
+	"univpll_d2_d8",
+	"mainpll_d2_d4",
+	"mainpll_d3",
+	"univpll_d3",
+	"ad_osc2_ck",
+	"osc2_d2",
+	"osc2_d3"
+};
+
+static const char * const img_parents[] = {
+	"clk26m",
+	"mainpll_d2",
+	"mainpll_d2",
+	"univpll_d3",
+	"mainpll_d3",
+	"mmpll_d5_d2",
+	"tvdpll_mainpll_d2_ck",
+	"mainpll_d5"
+};
+
+static const char * const ipe_parents[] = {
+	"clk26m",
+	"mainpll_d2",
+	"mmpll_d7",
+	"univpll_d3",
+	"mainpll_d3",
+	"mmpll_d5_d2",
+	"mainpll_d2_d2",
+	"mainpll_d5"
+};
+
+static const char * const dpe_parents[] = {
+	"clk26m",
+	"mainpll_d2",
+	"mmpll_d7",
+	"univpll_d3",
+	"mainpll_d3",
+	"mmpll_d5_d2",
+	"mainpll_d2_d2",
+	"mainpll_d5"
+};
+
+static const char * const cam_parents[] = {
+	"clk26m",
+	"mainpll_d2",
+	"mmpll_d6",
+	"mainpll_d3",
+	"mmpll_d7",
+	"univpll_d3",
+	"mmpll_d5_d2",
+	"adsppll_d5",
+	"tvdpll_mainpll_d2_ck",
+	"univpll_d3_d2"
+};
+
+static const char * const ccu_parents[] = {
+	"clk26m",
+	"mainpll_d2",
+	"mmpll_d6",
+	"mainpll_d3",
+	"mmpll_d7",
+	"univpll_d3",
+	"mmpll_d5_d2",
+	"mainpll_d2_d2",
+	"adsppll_d5",
+	"univpll_d3_d2"
+};
+
+static const char * const dsp_parents[] = {
+	"clk26m",
+	"univpll_d3_d8",
+	"univpll_d3_d4",
+	"mainpll_d2_d4",
+	"univpll_d3_d2",
+	"mainpll_d2_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"univpll_d3",
+	"mmpll_d7",
+	"mmpll_d6",
+	"adsppll_d5",
+	"tvdpll_ck",
+	"tvdpll_mainpll_d2_ck",
+	"univpll_d2",
+	"adsppll_d4"
+};
+
+static const char * const dsp1_parents[] = {
+	"clk26m",
+	"univpll_d3_d8",
+	"univpll_d3_d4",
+	"mainpll_d2_d4",
+	"univpll_d3_d2",
+	"mainpll_d2_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"univpll_d3",
+	"mmpll_d7",
+	"mmpll_d6",
+	"adsppll_d5",
+	"tvdpll_ck",
+	"tvdpll_mainpll_d2_ck",
+	"univpll_d2",
+	"adsppll_d4"
+};
+
+static const char * const dsp2_parents[] = {
+	"clk26m",
+	"univpll_d3_d8",
+	"univpll_d3_d4",
+	"mainpll_d2_d4",
+	"univpll_d3_d2",
+	"mainpll_d2_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"univpll_d3",
+	"mmpll_d7",
+	"mmpll_d6",
+	"adsppll_d5",
+	"tvdpll_ck",
+	"tvdpll_mainpll_d2_ck",
+	"univpll_d2",
+	"adsppll_d4"
+};
+
+static const char * const dsp3_parents[] = {
+	"clk26m",
+	"univpll_d3_d8",
+	"mainpll_d2_d4",
+	"univpll_d3_d2",
+	"mainpll_d2_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"univpll_d3",
+	"mmpll_d7",
+	"mmpll_d6",
+	"mainpll_d2",
+	"tvdpll_ck",
+	"tvdpll_mainpll_d2_ck",
+	"univpll_d2",
+	"adsppll_d4",
+	"mmpll_d4"
+};
+
+static const char * const ipu_if_parents[] = {
+	"clk26m",
+	"univpll_d3_d8",
+	"univpll_d3_d4",
+	"mainpll_d2_d4",
+	"univpll_d3_d2",
+	"mainpll_d2_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"univpll_d3",
+	"mmpll_d7",
+	"mmpll_d6",
+	"adsppll_d5",
+	"tvdpll_ck",
+	"tvdpll_mainpll_d2_ck",
+	"univpll_d2",
+	"adsppll_d4"
+};
+
+static const char * const mfg_parents[] = {
+	"clk26m",
+	"mfgpll_ck",
+	"univpll_d3",
+	"mainpll_d5"
+};
+
+static const char * const f52m_mfg_parents[] = {
+	"clk26m",
+	"univpll_d3_d2",
+	"univpll_d3_d4",
+	"univpll_d3_d8"
+};
+
+static const char * const camtg_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d3_d8",
+	"univpll_192m_d4",
+	"univpll_d3_d16",
+	"csw_f26m_ck_d2",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+static const char * const camtg2_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d3_d8",
+	"univpll_192m_d4",
+	"univpll_d3_d16",
+	"csw_f26m_ck_d2",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+static const char * const camtg3_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d3_d8",
+	"univpll_192m_d4",
+	"univpll_d3_d16",
+	"csw_f26m_ck_d2",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+static const char * const camtg4_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d3_d8",
+	"univpll_192m_d4",
+	"univpll_d3_d16",
+	"csw_f26m_ck_d2",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+static const char * const uart_parents[] = {
+	"clk26m",
+	"univpll_d3_d8"
+};
+
+static const char * const spi_parents[] = {
+	"clk26m",
+	"mainpll_d5_d2",
+	"mainpll_d3_d4",
+	"msdcpll_d4"
+};
+
+static const char * const msdc50_hclk_parents[] = {
+	"clk26m",
+	"mainpll_d2_d2",
+	"mainpll_d3_d2"
+};
+
+static const char * const msdc50_0_parents[] = {
+	"clk26m",
+	"msdcpll_ck",
+	"msdcpll_d2",
+	"univpll_d2_d4",
+	"mainpll_d3_d2",
+	"univpll_d2_d2"
+};
+
+static const char * const msdc30_1_parents[] = {
+	"clk26m",
+	"univpll_d3_d2",
+	"mainpll_d3_d2",
+	"mainpll_d7",
+	"msdcpll_d2"
+};
+
+static const char * const audio_parents[] = {
+	"clk26m",
+	"mainpll_d5_d4",
+	"mainpll_d7_d4",
+	"mainpll_d2_d16"
+};
+
+static const char * const aud_intbus_parents[] = {
+	"clk26m",
+	"mainpll_d2_d4",
+	"mainpll_d7_d2"
+};
+
+static const char * const fpwrap_ulposc_parents[] = {
+	"osc_d10",
+	"clk26m",
+	"osc_d4",
+	"osc_d8",
+	"osc_d16"
+};
+
+static const char * const atb_parents[] = {
+	"clk26m",
+	"mainpll_d2_d2",
+	"mainpll_d5"
+};
+
+static const char * const sspm_parents[] = {
+	"clk26m",
+	"univpll_d2_d4",
+	"mainpll_d2_d2",
+	"univpll_d2_d2",
+	"mainpll_d3"
+};
+
+static const char * const dpi0_parents[] = {
+	"clk26m",
+	"tvdpll_d2",
+	"tvdpll_d4",
+	"tvdpll_d8",
+	"tvdpll_d16"
+};
+
+static const char * const scam_parents[] = {
+	"clk26m",
+	"mainpll_d5_d2"
+};
+
+static const char * const disppwm_parents[] = {
+	"clk26m",
+	"univpll_d3_d4",
+	"osc_d2",
+	"osc_d4",
+	"osc_d16"
+};
+
+static const char * const usb_top_parents[] = {
+	"clk26m",
+	"univpll_d5_d4",
+	"univpll_d3_d4",
+	"univpll_d5_d2"
+};
+
+static const char * const ssusb_top_xhci_parents[] = {
+	"clk26m",
+	"univpll_d5_d4",
+	"univpll_d3_d4",
+	"univpll_d5_d2"
+};
+
+static const char * const spm_parents[] = {
+	"clk26m",
+	"osc_d8",
+	"mainpll_d2_d8"
+};
+
+static const char * const i2c_parents[] = {
+	"clk26m",
+	"mainpll_d2_d8",
+	"univpll_d5_d2"
+};
+
+static const char * const seninf_parents[] = {
+	"clk26m",
+	"univpll_d7",
+	"univpll_d3_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"mmpll_d4_d2",
+	"mmpll_d7",
+	"mmpll_d6"
+};
+
+static const char * const seninf1_parents[] = {
+	"clk26m",
+	"univpll_d7",
+	"univpll_d3_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"mmpll_d4_d2",
+	"mmpll_d7",
+	"mmpll_d6"
+};
+
+static const char * const seninf2_parents[] = {
+	"clk26m",
+	"univpll_d7",
+	"univpll_d3_d2",
+	"univpll_d2_d2",
+	"mainpll_d3",
+	"mmpll_d4_d2",
+	"mmpll_d7",
+	"mmpll_d6"
+};
+
+static const char * const dxcc_parents[] = {
+	"clk26m",
+	"mainpll_d2_d2",
+	"mainpll_d2_d4",
+	"mainpll_d2_d8"
+};
+
+static const char * const aud_engen1_parents[] = {
+	"clk26m",
+	"apll1_d2",
+	"apll1_d4",
+	"apll1_d8"
+};
+
+static const char * const aud_engen2_parents[] = {
+	"clk26m",
+	"apll2_d2",
+	"apll2_d4",
+	"apll2_d8"
+};
+
+static const char * const faes_ufsfde_parents[] = {
+	"clk26m",
+	"mainpll_d2",
+	"mainpll_d2_d2",
+	"mainpll_d3",
+	"mainpll_d2_d4",
+	"univpll_d3"
+};
+
+static const char * const fufs_parents[] = {
+	"clk26m",
+	"mainpll_d2_d4",
+	"mainpll_d2_d8",
+	"mainpll_d2_d16"
+};
+
+static const char * const aud_1_parents[] = {
+	"clk26m",
+	"apll1_ck"
+};
+
+static const char * const aud_2_parents[] = {
+	"clk26m",
+	"apll2_ck"
+};
+
+static const char * const adsp_parents[] = {
+	"clk26m",
+	"mainpll_d3",
+	"univpll_d2_d4",
+	"univpll_d2",
+	"mmpll_d4",
+	"adsppll_d4",
+	"adsppll_d6"
+};
+
+static const char * const dpmaif_parents[] = {
+	"clk26m",
+	"univpll_d2_d4",
+	"mainpll_d3",
+	"mainpll_d2_d2",
+	"univpll_d2_d2",
+	"univpll_d3"
+};
+
+static const char * const venc_parents[] = {
+	"clk26m",
+	"mmpll_d7",
+	"mainpll_d3",
+	"univpll_d2_d2",
+	"mainpll_d2_d2",
+	"univpll_d3",
+	"mmpll_d6",
+	"mainpll_d5",
+	"mainpll_d3_d2",
+	"mmpll_d4_d2",
+	"univpll_d2_d4",
+	"mmpll_d5",
+	"univpll_192m_d2"
+
+};
+
+static const char * const vdec_parents[] = {
+	"clk26m",
+	"univpll_d2_d4",
+	"mainpll_d3",
+	"univpll_d2_d2",
+	"mainpll_d2_d2",
+	"univpll_d3",
+	"univpll_d5",
+	"univpll_d5_d2",
+	"mainpll_d2",
+	"univpll_d2",
+	"univpll_192m_d2"
+};
+
+static const char * const camtm_parents[] = {
+	"clk26m",
+	"univpll_d7",
+	"univpll_d3_d2",
+	"univpll_d2_d2"
+};
+
+static const char * const pwm_parents[] = {
+	"clk26m",
+	"univpll_d2_d8"
+};
+
+static const char * const audio_h_parents[] = {
+	"clk26m",
+	"univpll_d7",
+	"apll1_ck",
+	"apll2_ck"
+};
+
+static const char * const camtg5_parents[] = {
+	"clk26m",
+	"univpll_192m_d8",
+	"univpll_d3_d8",
+	"univpll_192m_d4",
+	"univpll_d3_d16",
+	"csw_f26m_ck_d2",
+	"univpll_192m_d16",
+	"univpll_192m_d32"
+};
+
+/*
+ * CRITICAL CLOCK:
+ * axi_sel is the main bus clock of whole SOC.
+ * spm_sel is the clock of the always-on co-processor.
+ * sspm_sel is the clock of the always-on co-processor.
+ */
+static const struct mtk_mux top_muxes[] = {
+	/* CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "axi_sel", axi_parents,
+				   0x20, 0x24, 0x28, 0, 2, 7,
+				   0x004, 0, CLK_IS_CRITICAL),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MM, "mm_sel", mm_parents,
+			     0x20, 0x24, 0x28, 8, 3, 15, 0x004, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP, "scp_sel", scp_parents,
+			     0x20, 0x24, 0x28, 16, 3, 23, 0x004, 2),
+	/* CLK_CFG_1 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IMG, "img_sel", img_parents,
+			     0x30, 0x34, 0x38, 0, 3, 7, 0x004, 4),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IPE, "ipe_sel", ipe_parents,
+			     0x30, 0x34, 0x38, 8, 3, 15, 0x004, 5),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPE, "dpe_sel", dpe_parents,
+			     0x30, 0x34, 0x38, 16, 3, 23, 0x004, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAM, "cam_sel", cam_parents,
+			     0x30, 0x34, 0x38, 24, 4, 31, 0x004, 7),
+	/* CLK_CFG_2 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CCU, "ccu_sel", ccu_parents,
+			     0x40, 0x44, 0x48, 0, 4, 7, 0x004, 8),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSP, "dsp_sel", dsp_parents,
+			     0x40, 0x44, 0x48, 8, 4, 15, 0x004, 9),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSP1, "dsp1_sel", dsp1_parents,
+			     0x40, 0x44, 0x48, 16, 4, 23, 0x004, 10),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSP2, "dsp2_sel", dsp2_parents,
+			     0x40, 0x44, 0x48, 24, 4, 31, 0x004, 11),
+	/* CLK_CFG_3 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSP3, "dsp3_sel", dsp3_parents,
+			     0x50, 0x54, 0x58, 0, 4, 7, 0x004, 12),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_IPU_IF, "ipu_if_sel", ipu_if_parents,
+			     0x50, 0x54, 0x58, 8, 4, 15, 0x004, 13),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG, "mfg_sel", mfg_parents,
+			     0x50, 0x54, 0x58, 16, 2, 23, 0x004, 14),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_F52M_MFG, "f52m_mfg_sel",
+			     f52m_mfg_parents, 0x50, 0x54, 0x58,
+			     24, 2, 31, 0x004, 15),
+	/* CLK_CFG_4 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG, "camtg_sel", camtg_parents,
+			     0x60, 0x64, 0x68, 0, 3, 7, 0x004, 16),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG2, "camtg2_sel", camtg2_parents,
+			     0x60, 0x64, 0x68, 8, 3, 15, 0x004, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG3, "camtg3_sel", camtg3_parents,
+			     0x60, 0x64, 0x68, 16, 3, 23, 0x004, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG4, "camtg4_sel", camtg4_parents,
+			     0x60, 0x64, 0x68, 24, 3, 31, 0x004, 19),
+	/* CLK_CFG_5 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART, "uart_sel", uart_parents,
+			     0x70, 0x74, 0x78, 0, 1, 7, 0x004, 20),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI, "spi_sel", spi_parents,
+			     0x70, 0x74, 0x78, 8, 2, 15, 0x004, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "msdc50_hclk_sel",
+			     msdc50_hclk_parents, 0x70, 0x74, 0x78,
+			     16, 2, 23, 0x004, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "msdc50_0_sel",
+			     msdc50_0_parents, 0x70, 0x74, 0x78,
+			     24, 3, 31, 0x004, 23),
+	/* CLK_CFG_6 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "msdc30_1_sel",
+			     msdc30_1_parents, 0x80, 0x84, 0x88,
+			     0, 3, 7, 0x004, 24),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD, "audio_sel", audio_parents,
+			     0x80, 0x84, 0x88, 8, 2, 15, 0x004, 25),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS, "aud_intbus_sel",
+			     aud_intbus_parents, 0x80, 0x84, 0x88,
+			     16, 2, 23, 0x004, 26),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_FPWRAP_ULPOSC, "fpwrap_ulposc_sel",
+			     fpwrap_ulposc_parents, 0x80, 0x84, 0x88,
+			     24, 3, 31, 0x004, 27),
+	/* CLK_CFG_7 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ATB, "atb_sel", atb_parents,
+			     0x90, 0x94, 0x98, 0, 2, 7, 0x004, 28),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SSPM, "sspm_sel", sspm_parents,
+				   0x90, 0x94, 0x98, 8, 3, 15,
+				   0x004, 29, CLK_IS_CRITICAL),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI0, "dpi0_sel", dpi0_parents,
+			     0x90, 0x94, 0x98, 16, 3, 23, 0x004, 30),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCAM, "scam_sel", scam_parents,
+			     0x90, 0x94, 0x98, 24, 1, 31, 0x004, 0),
+	/* CLK_CFG_8 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_PWM, "disppwm_sel",
+			     disppwm_parents, 0xa0, 0xa4, 0xa8,
+			     0, 3, 7, 0x008, 1),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_USB_TOP, "usb_top_sel",
+			     usb_top_parents, 0xa0, 0xa4, 0xa8,
+			     8, 2, 15, 0x008, 2),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SSUSB_TOP_XHCI, "ssusb_top_xhci_sel",
+			     ssusb_top_xhci_parents, 0xa0, 0xa4, 0xa8,
+			     16, 2, 23, 0x008, 3),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "spm_sel", spm_parents,
+				   0xa0, 0xa4, 0xa8, 24, 2, 31,
+				   0x008, 4, CLK_IS_CRITICAL),
+	/* CLK_CFG_9 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C, "i2c_sel", i2c_parents,
+			     0xb0, 0xb4, 0xb8, 0, 2, 7, 0x008, 5),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF, "seninf_sel", seninf_parents,
+			     0xb0, 0xb4, 0xb8, 8, 2, 15, 0x008, 6),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF1, "seninf1_sel",
+			     seninf1_parents, 0xb0, 0xb4, 0xb8,
+			     16, 2, 23, 0x008, 7),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF2, "seninf2_sel",
+			     seninf2_parents, 0xb0, 0xb4, 0xb8,
+			     24, 2, 31, 0x008, 8),
+	/* CLK_CFG_10 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC, "dxcc_sel", dxcc_parents,
+			     0xc0, 0xc4, 0xc8, 0, 2, 7, 0x008, 9),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENG1, "aud_eng1_sel",
+			     aud_engen1_parents, 0xc0, 0xc4, 0xc8,
+			     8, 2, 15, 0x008, 10),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_ENG2, "aud_eng2_sel",
+			     aud_engen2_parents, 0xc0, 0xc4, 0xc8,
+			     16, 2, 23, 0x008, 11),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_FAES_UFSFDE, "faes_ufsfde_sel",
+			     faes_ufsfde_parents, 0xc0, 0xc4, 0xc8,
+			     24, 3, 31,
+			     0x008, 12),
+	/* CLK_CFG_11 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_FUFS, "fufs_sel", fufs_parents,
+			     0xd0, 0xd4, 0xd8, 0, 2, 7, 0x008, 13),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_1, "aud_1_sel", aud_1_parents,
+			     0xd0, 0xd4, 0xd8, 8, 1, 15, 0x008, 14),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_2, "aud_2_sel", aud_2_parents,
+			     0xd0, 0xd4, 0xd8, 16, 1, 23, 0x008, 15),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_ADSP, "adsp_sel", adsp_parents,
+			     0xd0, 0xd4, 0xd8, 24, 3, 31, 0x008, 16),
+	/* CLK_CFG_12 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPMAIF, "dpmaif_sel", dpmaif_parents,
+			     0xe0, 0xe4, 0xe8, 0, 3, 7, 0x008, 17),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VENC, "venc_sel", venc_parents,
+			     0xe0, 0xe4, 0xe8, 8, 4, 15, 0x008, 18),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_VDEC, "vdec_sel", vdec_parents,
+			     0xe0, 0xe4, 0xe8, 16, 4, 23, 0x008, 19),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTM, "camtm_sel", camtm_parents,
+			     0xe0, 0xe4, 0xe8, 24, 2, 31, 0x004, 20),
+	/* CLK_CFG_13 */
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM, "pwm_sel", pwm_parents,
+			     0xf0, 0xf4, 0xf8, 0, 1, 7, 0x008, 21),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_H, "audio_h_sel",
+			     audio_h_parents, 0xf0, 0xf4, 0xf8,
+			     8, 2, 15, 0x008, 22),
+	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG5, "camtg5_sel", camtg5_parents,
+			     0xf0, 0xf4, 0xf8, 24, 3, 31, 0x008, 24),
+};
+
+static const char * const i2s0_m_ck_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const i2s1_m_ck_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const i2s2_m_ck_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const i2s3_m_ck_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const i2s4_m_ck_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const char * const i2s5_m_ck_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static const struct mtk_composite top_aud_muxes[] = {
+	MUX(CLK_TOP_I2S0_M_SEL, "i2s0_m_ck_sel", i2s0_m_ck_parents,
+	    0x320, 8, 1),
+	MUX(CLK_TOP_I2S1_M_SEL, "i2s1_m_ck_sel", i2s1_m_ck_parents,
+	    0x320, 9, 1),
+	MUX(CLK_TOP_I2S2_M_SEL, "i2s2_m_ck_sel", i2s2_m_ck_parents,
+	    0x320, 10, 1),
+	MUX(CLK_TOP_I2S3_M_SEL, "i2s3_m_ck_sel", i2s3_m_ck_parents,
+	    0x320, 11, 1),
+	MUX(CLK_TOP_I2S4_M_SEL, "i2s4_m_ck_sel", i2s4_m_ck_parents,
+	    0x320, 12, 1),
+	MUX(CLK_TOP_I2S5_M_SEL, "i2s5_m_ck_sel", i2s5_m_ck_parents,
+	    0x328, 20, 1),
+};
+
+static struct mtk_composite top_aud_divs[] = {
+	DIV_GATE(CLK_TOP_APLL12_DIV0, "apll12_div0", "i2s0_m_ck_sel",
+		 0x320, 2, 0x324, 8, 0),
+	DIV_GATE(CLK_TOP_APLL12_DIV1, "apll12_div1", "i2s1_m_ck_sel",
+		 0x320, 3, 0x324, 8, 8),
+	DIV_GATE(CLK_TOP_APLL12_DIV2, "apll12_div2", "i2s2_m_ck_sel",
+		 0x320, 4, 0x324, 8, 16),
+	DIV_GATE(CLK_TOP_APLL12_DIV3, "apll12_div3", "i2s3_m_ck_sel",
+		 0x320, 5, 0x324, 8, 24),
+	DIV_GATE(CLK_TOP_APLL12_DIV4, "apll12_div4", "i2s4_m_ck_sel",
+		 0x320, 6, 0x328, 8, 0),
+	DIV_GATE(CLK_TOP_APLL12_DIVB, "apll12_divb", "apll12_div4",
+		 0x320, 7, 0x328, 8, 8),
+	DIV_GATE(CLK_TOP_APLL12_DIV5, "apll12_div5", "i2s5_m_ck_sel",
+		 0x328, 16, 0x328, 4, 28),
+};
+
+static const struct mtk_gate_regs infra0_cg_regs = {
+	.set_ofs = 0x80,
+	.clr_ofs = 0x84,
+	.sta_ofs = 0x90,
+};
+
+static const struct mtk_gate_regs infra1_cg_regs = {
+	.set_ofs = 0x88,
+	.clr_ofs = 0x8c,
+	.sta_ofs = 0x94,
+};
+
+static const struct mtk_gate_regs infra2_cg_regs = {
+	.set_ofs = 0xa4,
+	.clr_ofs = 0xa8,
+	.sta_ofs = 0xac,
+};
+
+static const struct mtk_gate_regs infra3_cg_regs = {
+	.set_ofs = 0xc0,
+	.clr_ofs = 0xc4,
+	.sta_ofs = 0xc8,
+};
+
+#define GATE_INFRA0(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &infra0_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+#define GATE_INFRA1(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &infra1_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+#define GATE_INFRA2(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &infra2_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+#define GATE_INFRA3(_id, _name, _parent, _shift)		\
+	GATE_MTK(_id, _name, _parent, &infra3_cg_regs, _shift,	\
+		&mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate infra_clks[] = {
+	/* INFRA0 */
+	GATE_INFRA0(CLK_INFRA_PMIC_TMR, "infra_pmic_tmr",
+		    "axi_sel", 0),
+	GATE_INFRA0(CLK_INFRA_PMIC_AP, "infra_pmic_ap",
+		    "axi_sel", 1),
+	GATE_INFRA0(CLK_INFRA_PMIC_MD, "infra_pmic_md",
+		    "axi_sel", 2),
+	GATE_INFRA0(CLK_INFRA_PMIC_CONN, "infra_pmic_conn",
+		    "axi_sel", 3),
+	GATE_INFRA0(CLK_INFRA_SCPSYS, "infra_scp",
+		    "axi_sel", 4),
+	GATE_INFRA0(CLK_INFRA_SEJ, "infra_sej",
+		    "f_f26m_ck", 5),
+	GATE_INFRA0(CLK_INFRA_APXGPT, "infra_apxgpt",
+		    "axi_sel", 6),
+	GATE_INFRA0(CLK_INFRA_ICUSB, "infra_icusb",
+		    "axi_sel", 8),
+	GATE_INFRA0(CLK_INFRA_GCE, "infra_gce",
+		    "axi_sel", 9),
+	GATE_INFRA0(CLK_INFRA_THERM, "infra_therm",
+		    "axi_sel", 10),
+	GATE_INFRA0(CLK_INFRA_I2C0, "infra_i2c0",
+		    "i2c_sel", 11),
+	GATE_INFRA0(CLK_INFRA_I2C1, "infra_i2c1",
+		    "i2c_sel", 12),
+	GATE_INFRA0(CLK_INFRA_I2C2, "infra_i2c2",
+		    "i2c_sel", 13),
+	GATE_INFRA0(CLK_INFRA_I2C3, "infra_i2c3",
+		    "i2c_sel", 14),
+	GATE_INFRA0(CLK_INFRA_PWM_HCLK, "infra_pwm_hclk",
+		    "pwm_sel", 15),
+	GATE_INFRA0(CLK_INFRA_PWM1, "infra_pwm1",
+		    "pwm_sel", 16),
+	GATE_INFRA0(CLK_INFRA_PWM2, "infra_pwm2",
+		    "pwm_sel", 17),
+	GATE_INFRA0(CLK_INFRA_PWM3, "infra_pwm3",
+		    "pwm_sel", 18),
+	GATE_INFRA0(CLK_INFRA_PWM4, "infra_pwm4",
+		    "pwm_sel", 19),
+	GATE_INFRA0(CLK_INFRA_PWM, "infra_pwm",
+		    "pwm_sel", 21),
+	GATE_INFRA0(CLK_INFRA_UART1, "infra_uart1",
+		    "uart_sel", 23),
+	GATE_INFRA0(CLK_INFRA_UART2, "infra_uart2",
+		    "uart_sel", 24),
+	GATE_INFRA0(CLK_INFRA_UART3, "infra_uart3",
+		    "uart_sel", 25),
+	GATE_INFRA0(CLK_INFRA_GCE_26M, "infra_gce_26m",
+		    "axi_sel", 27),
+	GATE_INFRA0(CLK_INFRA_CQ_DMA_FPC, "infra_cqdma_fpc",
+		    "axi_sel", 28),
+	GATE_INFRA0(CLK_INFRA_BTIF, "infra_btif",
+		    "axi_sel", 31),
+	/* INFRA1 */
+	GATE_INFRA1(CLK_INFRA_SPI0, "infra_spi0",
+		    "spi_sel", 1),
+	GATE_INFRA1(CLK_INFRA_MSDC0, "infra_msdc0",
+		    "msdc50_hclk_sel", 2),
+	GATE_INFRA1(CLK_INFRA_MSDC1, "infra_msdc1",
+		    "axi_sel", 4),
+	GATE_INFRA1(CLK_INFRA_MSDC2, "infra_msdc2",
+		    "axi_sel", 5),
+	GATE_INFRA1(CLK_INFRA_MSDC0_SCK, "infra_msdc0_sck",
+		    "msdc50_0_sel", 6),
+	GATE_INFRA1(CLK_INFRA_DVFSRC, "infra_dvfsrc",
+		    "f_f26m_ck", 7),
+	GATE_INFRA1(CLK_INFRA_GCPU, "infra_gcpu",
+		    "axi_sel", 8),
+	GATE_INFRA1(CLK_INFRA_TRNG, "infra_trng",
+		    "axi_sel", 9),
+	GATE_INFRA1(CLK_INFRA_AUXADC, "infra_auxadc",
+		    "f_f26m_ck", 10),
+	GATE_INFRA1(CLK_INFRA_CPUM, "infra_cpum",
+		    "axi_sel", 11),
+	GATE_INFRA1(CLK_INFRA_CCIF1_AP, "infra_ccif1_ap",
+		    "axi_sel", 12),
+	GATE_INFRA1(CLK_INFRA_CCIF1_MD, "infra_ccif1_md",
+		    "axi_sel", 13),
+	GATE_INFRA1(CLK_INFRA_AUXADC_MD, "infra_auxadc_md",
+		    "f_f26m_ck", 14),
+	GATE_INFRA1(CLK_INFRA_MSDC1_SCK, "infra_msdc1_sck",
+		    "msdc30_1_sel", 16),
+	GATE_INFRA1(CLK_INFRA_MSDC2_SCK, "infra_msdc2_sck",
+		    "msdc30_2_sel", 17),
+	GATE_INFRA1(CLK_INFRA_AP_DMA, "infra_apdma",
+		    "axi_sel", 18),
+	GATE_INFRA1(CLK_INFRA_XIU, "infra_xiu",
+		    "axi_sel", 19),
+	GATE_INFRA1(CLK_INFRA_DEVICE_APC, "infra_device_apc",
+		    "axi_sel", 20),
+	GATE_INFRA1(CLK_INFRA_CCIF_AP, "infra_ccif_ap",
+		    "axi_sel", 23),
+	GATE_INFRA1(CLK_INFRA_DEBUGSYS, "infra_debugsys",
+		    "axi_sel", 24),
+	GATE_INFRA1(CLK_INFRA_AUD, "infra_audio",
+		    "axi_sel", 25),
+	GATE_INFRA1(CLK_INFRA_CCIF_MD, "infra_ccif_md",
+		    "axi_sel", 26),
+	GATE_INFRA1(CLK_INFRA_DXCC_SEC_CORE, "infra_dxcc_sec_core",
+		    "dxcc_sel", 27),
+	GATE_INFRA1(CLK_INFRA_DXCC_AO, "infra_dxcc_ao",
+		    "dxcc_sel", 28),
+	GATE_INFRA1(CLK_INFRA_DEVMPU_BCLK, "infra_devmpu_bclk",
+		    "axi_sel", 30),
+	GATE_INFRA1(CLK_INFRA_DRAMC_F26M, "infra_dramc_f26m",
+		    "f_f26m_ck", 31),
+	/* INFRA2 */
+	GATE_INFRA2(CLK_INFRA_IRTX, "infra_irtx",
+		    "f_f26m_ck", 0),
+	GATE_INFRA2(CLK_INFRA_USB, "infra_usb",
+		    "usb_top_sel", 1),
+	GATE_INFRA2(CLK_INFRA_DISP_PWM, "infra_disppwm",
+		    "axi_sel", 2),
+	GATE_INFRA2(CLK_INFRA_AUD_26M_BCLK,
+		    "infracfg_ao_audio_26m_bclk", "f_f26m_ck", 4),
+	GATE_INFRA2(CLK_INFRA_SPI1, "infra_spi1",
+		    "spi_sel", 6),
+	GATE_INFRA2(CLK_INFRA_I2C4, "infra_i2c4",
+		    "i2c_sel", 7),
+	GATE_INFRA2(CLK_INFRA_MODEM_TEMP_SHARE, "infra_md_tmp_share",
+		    "f_f26m_ck", 8),
+	GATE_INFRA2(CLK_INFRA_SPI2, "infra_spi2",
+		    "spi_sel", 9),
+	GATE_INFRA2(CLK_INFRA_SPI3, "infra_spi3",
+		    "spi_sel", 10),
+	GATE_INFRA2(CLK_INFRA_UNIPRO_SCK, "infra_unipro_sck",
+		    "fufs_sel", 11),
+	GATE_INFRA2(CLK_INFRA_UNIPRO_TICK, "infra_unipro_tick",
+		    "fufs_sel", 12),
+	GATE_INFRA2(CLK_INFRA_UFS_MP_SAP_BCLK, "infra_ufs_mp_sap_bck",
+		    "fufs_sel", 13),
+	GATE_INFRA2(CLK_INFRA_MD32_BCLK, "infra_md32_bclk",
+		    "axi_sel", 14),
+	GATE_INFRA2(CLK_INFRA_UNIPRO_MBIST, "infra_unipro_mbist",
+		    "axi_sel", 16),
+	GATE_INFRA2(CLK_INFRA_SSPM_BUS_HCLK, "infra_sspm_bus_hclk",
+		    "axi_sel", 17),
+	GATE_INFRA2(CLK_INFRA_I2C5, "infra_i2c5",
+		    "i2c_sel", 18),
+	GATE_INFRA2(CLK_INFRA_I2C5_ARBITER, "infra_i2c5_arbiter",
+		    "i2c_sel", 19),
+	GATE_INFRA2(CLK_INFRA_I2C5_IMM, "infra_i2c5_imm",
+		    "i2c_sel", 20),
+	GATE_INFRA2(CLK_INFRA_I2C1_ARBITER, "infra_i2c1_arbiter",
+		    "i2c_sel", 21),
+	GATE_INFRA2(CLK_INFRA_I2C1_IMM, "infra_i2c1_imm",
+		    "i2c_sel", 22),
+	GATE_INFRA2(CLK_INFRA_I2C2_ARBITER, "infra_i2c2_arbiter",
+		    "i2c_sel", 23),
+	GATE_INFRA2(CLK_INFRA_I2C2_IMM, "infra_i2c2_imm",
+		    "i2c_sel", 24),
+	GATE_INFRA2(CLK_INFRA_SPI4, "infra_spi4",
+		    "spi_sel", 25),
+	GATE_INFRA2(CLK_INFRA_SPI5, "infra_spi5",
+		    "spi_sel", 26),
+	GATE_INFRA2(CLK_INFRA_CQ_DMA, "infra_cqdma",
+		    "axi_sel", 27),
+	GATE_INFRA2(CLK_INFRA_UFS, "infra_ufs",
+		    "fufs_sel", 28),
+	GATE_INFRA2(CLK_INFRA_AES_UFSFDE, "infra_aes_ufsfde",
+		    "faes_ufsfde_sel", 29),
+	GATE_INFRA2(CLK_INFRA_UFS_TICK, "infra_ufs_tick",
+		    "fufs_sel", 30),
+	GATE_INFRA2(CLK_INFRA_SSUSB_XHCI, "infra_ssusb_xhci",
+		    "ssusb_top_xhci_sel", 31),
+	/* INFRA3 */
+	GATE_INFRA3(CLK_INFRA_MSDC0_SELF, "infra_msdc0_self",
+		    "msdc50_0_sel", 0),
+	GATE_INFRA3(CLK_INFRA_MSDC1_SELF, "infra_msdc1_self",
+		    "msdc50_0_sel", 1),
+	GATE_INFRA3(CLK_INFRA_MSDC2_SELF, "infra_msdc2_self",
+		    "msdc50_0_sel", 2),
+	GATE_INFRA3(CLK_INFRA_SSPM_26M_SELF, "infra_sspm_26m_self",
+		    "f_f26m_ck", 3),
+	GATE_INFRA3(CLK_INFRA_SSPM_32K_SELF, "infra_sspm_32k_self",
+		    "f_f26m_ck", 4),
+	GATE_INFRA3(CLK_INFRA_UFS_AXI, "infra_ufs_axi",
+		    "axi_sel", 5),
+	GATE_INFRA3(CLK_INFRA_I2C6, "infra_i2c6",
+		    "i2c_sel", 6),
+	GATE_INFRA3(CLK_INFRA_AP_MSDC0, "infra_ap_msdc0",
+		    "msdc50_hclk_sel", 7),
+	GATE_INFRA3(CLK_INFRA_MD_MSDC0, "infra_md_msdc0",
+		    "msdc50_hclk_sel", 8),
+	GATE_INFRA3(CLK_INFRA_CCIF2_AP, "infra_ccif2_ap",
+		    "axi_sel", 16),
+	GATE_INFRA3(CLK_INFRA_CCIF2_MD, "infra_ccif2_md",
+		    "axi_sel", 17),
+	GATE_INFRA3(CLK_INFRA_CCIF3_AP, "infra_ccif3_ap",
+		    "axi_sel", 18),
+	GATE_INFRA3(CLK_INFRA_CCIF3_MD, "infra_ccif3_md",
+		    "axi_sel", 19),
+	GATE_INFRA3(CLK_INFRA_SEJ_F13M, "infra_sej_f13m",
+		    "f_f26m_ck", 20),
+	GATE_INFRA3(CLK_INFRA_AES_BCLK, "infra_aes_bclk",
+		    "axi_sel", 21),
+	GATE_INFRA3(CLK_INFRA_I2C7, "infra_i2c7",
+		    "i2c_sel", 22),
+	GATE_INFRA3(CLK_INFRA_I2C8, "infra_i2c8",
+		    "i2c_sel", 23),
+	GATE_INFRA3(CLK_INFRA_FBIST2FPC, "infra_fbist2fpc",
+		    "msdc50_0_sel", 24),
+	GATE_INFRA3(CLK_INFRA_DPMAIF_CK, "infra_dpmaif",
+		    "dpmaif_sel", 26),
+	GATE_INFRA3(CLK_INFRA_FADSP, "infra_fadsp",
+		    "adsp_sel", 27),
+	GATE_INFRA3(CLK_INFRA_CCIF4_AP, "infra_ccif4_ap",
+		    "axi_sel", 28),
+	GATE_INFRA3(CLK_INFRA_CCIF4_MD, "infra_ccif4_md",
+		    "axi_sel", 29),
+	GATE_INFRA3(CLK_INFRA_SPI6, "infra_spi6",
+		    "spi_sel", 30),
+	GATE_INFRA3(CLK_INFRA_SPI7, "infra_spi7",
+		    "spi_sel", 31),
+};
+
+static const struct mtk_gate_regs apmixed_cg_regs = {
+	.set_ofs = 0x20,
+	.clr_ofs = 0x20,
+	.sta_ofs = 0x20,
+};
+
+#define GATE_APMIXED_FLAGS(_id, _name, _parent, _shift, _flags)	\
+	GATE_MTK_FLAGS(_id, _name, _parent, &apmixed_cg_regs,		\
+		_shift, &mtk_clk_gate_ops_no_setclr_inv, _flags)
+
+#define GATE_APMIXED(_id, _name, _parent, _shift)	\
+	GATE_APMIXED_FLAGS(_id, _name, _parent, _shift,	0)
+
+/*
+ * CRITICAL CLOCK:
+ * apmixed_appll26m is the toppest clock gate of all PLLs.
+ */
+static const struct mtk_gate apmixed_clks[] = {
+	GATE_APMIXED(CLK_APMIXED_SSUSB26M, "apmixed_ssusb26m",
+		     "f_f26m_ck", 4),
+	GATE_APMIXED_FLAGS(CLK_APMIXED_APPLL26M, "apmixed_appll26m",
+			   "f_f26m_ck", 5, CLK_IS_CRITICAL),
+	GATE_APMIXED(CLK_APMIXED_MIPIC0_26M, "apmixed_mipic026m",
+		     "f_f26m_ck", 6),
+	GATE_APMIXED(CLK_APMIXED_MDPLLGP26M, "apmixed_mdpll26m",
+		     "f_f26m_ck", 7),
+	GATE_APMIXED(CLK_APMIXED_MM_F26M, "apmixed_mmsys26m",
+		     "f_f26m_ck", 8),
+	GATE_APMIXED(CLK_APMIXED_UFS26M, "apmixed_ufs26m",
+		     "f_f26m_ck", 9),
+	GATE_APMIXED(CLK_APMIXED_MIPIC1_26M, "apmixed_mipic126m",
+		     "f_f26m_ck", 11),
+	GATE_APMIXED(CLK_APMIXED_MEMPLL26M, "apmixed_mempll26m",
+		     "f_f26m_ck", 13),
+	GATE_APMIXED(CLK_APMIXED_CLKSQ_LVPLL_26M, "apmixed_lvpll26m",
+		     "f_f26m_ck", 14),
+	GATE_APMIXED(CLK_APMIXED_MIPID0_26M, "apmixed_mipid026m",
+		     "f_f26m_ck", 16),
+	GATE_APMIXED(CLK_APMIXED_MIPID1_26M, "apmixed_mipid126m",
+		     "f_f26m_ck", 17),
+};
+
+#define MT6779_PLL_FMAX		(3800UL * MHZ)
+#define MT6779_PLL_FMIN		(1500UL * MHZ)
+
+#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
+			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
+			_pd_shift, _tuner_reg,  _tuner_en_reg,		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_pcw_chg_reg, _div_table) {			\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.fmax = MT6779_PLL_FMAX,				\
+		.fmin = MT6779_PLL_FMIN,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = _pcwibits,					\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcw_chg_reg = _pcw_chg_reg,				\
+		.div_table = _div_table,				\
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags,		\
+			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_pcw_chg_reg)					\
+		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
+			_rst_bar_mask, _pcwbits, _pcwibits, _pd_reg,	\
+			_pd_shift, _tuner_reg, _tuner_en_reg,		\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_pcw_chg_reg, NULL)
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_ARMPLL_LL, "armpll_ll", 0x0200, 0x020C, BIT(0),
+	    PLL_AO, 0, 22, 8, 0x0204, 24, 0, 0, 0, 0x0204, 0, 0),
+	PLL(CLK_APMIXED_ARMPLL_BL, "armpll_bl", 0x0210, 0x021C, BIT(0),
+	    PLL_AO, 0, 22, 8, 0x0214, 24, 0, 0, 0, 0x0214, 0, 0),
+	PLL(CLK_APMIXED_CCIPLL, "ccipll", 0x02A0, 0x02AC, BIT(0),
+	    PLL_AO, 0, 22, 8, 0x02A4, 24, 0, 0, 0, 0x02A4, 0, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, BIT(0),
+	    (HAVE_RST_BAR), BIT(24), 22, 8, 0x0234, 24, 0, 0, 0,
+	    0x0234, 0, 0),
+	PLL(CLK_APMIXED_UNIV2PLL, "univ2pll", 0x0240, 0x024C, BIT(0),
+	    (HAVE_RST_BAR), BIT(24), 22, 8, 0x0244, 24,
+	    0, 0, 0, 0x0244, 0, 0),
+	PLL(CLK_APMIXED_MFGPLL, "mfgpll", 0x0250, 0x025C, BIT(0),
+	    0, 0, 22, 8, 0x0254, 24, 0, 0, 0, 0x0254, 0, 0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0260, 0x026C, BIT(0),
+	    0, 0, 22, 8, 0x0264, 24, 0, 0, 0, 0x0264, 0, 0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0270, 0x027C, BIT(0),
+	    0, 0, 22, 8, 0x0274, 24, 0, 0, 0, 0x0274, 0, 0),
+	PLL(CLK_APMIXED_ADSPPLL, "adsppll", 0x02b0, 0x02bC, BIT(0),
+	    (HAVE_RST_BAR), BIT(23), 22, 8, 0x02b4, 24,
+	    0, 0, 0, 0x02b4, 0, 0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0280, 0x028C, BIT(0),
+	    (HAVE_RST_BAR), BIT(23), 22, 8, 0x0284, 24,
+	    0, 0, 0, 0x0284, 0, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x02C0, 0x02D0, BIT(0),
+	    0, 0, 32, 8, 0x02C0, 1, 0, 0x14, 0, 0x02C4, 0, 0x2C0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x02D4, 0x02E4, BIT(0),
+	    0, 0, 32, 8, 0x02D4, 1, 0, 0x14, 1, 0x02D8, 0, 0x02D4),
+};
+
+static int clk_mt6779_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+
+	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+
+	mtk_clk_register_gates(node, apmixed_clks,
+			       ARRAY_SIZE(apmixed_clks), clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static int clk_mt6779_top_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	void __iomem *base;
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+
+	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
+				    clk_data);
+
+	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+
+	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
+			       node, &mt6779_clk_lock, clk_data);
+
+	mtk_clk_register_composites(top_aud_muxes, ARRAY_SIZE(top_aud_muxes),
+				    base, &mt6779_clk_lock, clk_data);
+
+	mtk_clk_register_composites(top_aud_divs, ARRAY_SIZE(top_aud_divs),
+				    base, &mt6779_clk_lock, clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static int clk_mt6779_infra_probe(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+
+	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
+			       clk_data);
+
+	return of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+}
+
+static const struct of_device_id of_match_clk_mt6779[] = {
+	{
+		.compatible = "mediatek,mt6779-apmixed",
+		.data = clk_mt6779_apmixed_probe,
+	}, {
+		.compatible = "mediatek,mt6779-topckgen",
+		.data = clk_mt6779_top_probe,
+	}, {
+		.compatible = "mediatek,mt6779-infracfg_ao",
+		.data = clk_mt6779_infra_probe,
+	}, {
+		/* sentinel */
+	}
+};
+
+static int clk_mt6779_probe(struct platform_device *pdev)
+{
+	int (*clk_probe)(struct platform_device *pdev);
+	int r;
+
+	clk_probe = of_device_get_match_data(&pdev->dev);
+	if (!clk_probe)
+		return -EINVAL;
+
+	r = clk_probe(pdev);
+	if (r)
+		dev_err(&pdev->dev,
+			"could not register clock provider: %s: %d\n",
+			pdev->name, r);
+
+	return r;
+}
+
+static struct platform_driver clk_mt6779_drv = {
+	.probe = clk_mt6779_probe,
+	.driver = {
+		.name = "clk-mt6779",
+		.of_match_table = of_match_clk_mt6779,
+	},
+};
+
+static int __init clk_mt6779_init(void)
+{
+	return platform_driver_register(&clk_mt6779_drv);
+}
+
+arch_initcall(clk_mt6779_init);
-- 
1.7.9.5

