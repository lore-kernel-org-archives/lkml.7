Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8638CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5034F2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WjOwbub2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEBMSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:18:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46361 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEBMSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:18:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id r7so2997761wrr.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GgusURE/W8WQalA33cEWfpRjVdXD5wgJb44vpMIQJIA=;
        b=WjOwbub2CHS1lEAR4PJpFWurl6WPeh5AUPx3XVhxTlB6Hx86nhqpr263GBgcxcM371
         oyHujRiVkACMN1FmTMuu7oidpncrUfL4EK/riYLsKOaYPbYTy7/nFKhRrjFoP/zJraWF
         bz57mAh+V/aGF9idDq1WN/BXsmcjYfS0wLI7EZsoUxJxQ7u7dK9fBCELS9QnTvftpObc
         eLlBZDIVmoH4/Fvi11y80wkptE+q88nT8V6Se+GdtbVr9lw063HhUsOSSShj+cts5QCA
         CtveCcOCx65P9jYCKjp0ajcbpQSbVCyJyRTj04XI4KH8fGKae6luNAC+Wye4E/SmHYsi
         ZLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GgusURE/W8WQalA33cEWfpRjVdXD5wgJb44vpMIQJIA=;
        b=ReXzGadI8xRgbHS3rdYY8cOzOIrhpyju0sLthiZFqQelck87kdonO7Wq11u0BLmgjT
         d9JNFLZzqjBqz4eJFflQNewnq2yzLy0tU/fPQCLheDj2SWlgDFY9zuvXQFQKvDIiM439
         qb4DHVx2fKGfHNh0gWX7ySxtY6zEn/p8mkp/us2Hodv9an+HF/rzAjZG9GHgrV9FyIsd
         9Mbzg0RyS73P6pZ6kWdGe0rLAhACD8ZwTebAqtXdKg68wwAXm8rmfVOn2YDUj4cVTayx
         96h3DqWWMPLQwpyJRP/HbcQdXrC+G1VVXqjBa+pQD3tXd3JDvY8+r4kztqbxCFdGCR5G
         /0DQ==
X-Gm-Message-State: APjAAAVL7s8ALamY3FZxSvAeeZyZBy5TY/kb48LWzOmmzMF6DN1Dx7G1
        H/Gn7CUMm+6PAhAytlATvGJO2Q==
X-Google-Smtp-Source: APXvYqzI3XtuiIeyOUfzg89EuKrmLgDXyD/nCaZXAAQHkUUw4+T5rfoLd5ak94G/nvhN2sm24ARLVw==
X-Received: by 2002:a5d:55cc:: with SMTP id i12mr2560960wrw.179.1556799527780;
        Thu, 02 May 2019 05:18:47 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-8-187.w90-86.abo.wanadoo.fr. [90.86.125.187])
        by smtp.gmail.com with ESMTPSA id f6sm4392842wmh.13.2019.05.02.05.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:18:47 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, wenzhen.yu@mediatek.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/2] clk: mediatek: add audsys clock driver for MT8516
Date:   Thu,  2 May 2019 14:18:43 +0200
Message-Id: <20190502121843.14493-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502121843.14493-1-fparent@baylibre.com>
References: <20190502121843.14493-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audsys clock driver for MediaTek MT8516 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/clk/mediatek/Kconfig          |  6 +++
 drivers/clk/mediatek/Makefile         |  1 +
 drivers/clk/mediatek/clk-mt8516-aud.c | 65 +++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8516-aud.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 1e951ae49982..f9cd45e7760a 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -225,4 +225,10 @@ config COMMON_CLK_MT8516
 	help
 	  This driver supports MediaTek MT8516 clocks.
 
+config COMMON_CLK_MT8516_AUDSYS
+	bool "Clock driver for MediaTek MT8516 audsys"
+	depends on COMMON_CLK_MT8516
+	help
+	  This driver supports MediaTek MT8516 audsys clocks.
+
 endmenu
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index c4f413ef5aad..a2557b0c9273 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_COMMON_CLK_MT7629_HIFSYS) += clk-mt7629-hif.o
 obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135.o
 obj-$(CONFIG_COMMON_CLK_MT8173) += clk-mt8173.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
+obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8516-aud.c b/drivers/clk/mediatek/clk-mt8516-aud.c
new file mode 100644
index 000000000000..6ab3a06dc9d5
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8516-aud.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ *         Fabien Parent <fparent@baylibre.com>
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
+#include <dt-bindings/clock/mt8516-clk.h>
+
+static const struct mtk_gate_regs aud_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_AUD(_id, _name, _parent, _shift) {	\
+		.id = _id,			\
+		.name = _name,			\
+		.parent_name = _parent,		\
+		.regs = &aud_cg_regs,		\
+		.shift = _shift,		\
+		.ops = &mtk_clk_gate_ops_no_setclr,		\
+	}
+
+static const struct mtk_gate aud_clks[] __initconst = {
+	GATE_AUD(CLK_AUD_AFE, "aud_afe", "clk26m_ck", 2),
+	GATE_AUD(CLK_AUD_I2S, "aud_i2s", "i2s_infra_bck", 6),
+	GATE_AUD(CLK_AUD_22M, "aud_22m", "rg_aud_engen1", 8),
+	GATE_AUD(CLK_AUD_24M, "aud_24m", "rg_aud_engen2", 9),
+	GATE_AUD(CLK_AUD_INTDIR, "aud_intdir", "rg_aud_spdif_in", 15),
+	GATE_AUD(CLK_AUD_APLL2_TUNER, "aud_apll2_tuner", "rg_aud_engen2", 18),
+	GATE_AUD(CLK_AUD_APLL_TUNER, "aud_apll_tuner", "rg_aud_engen1", 19),
+	GATE_AUD(CLK_AUD_HDMI, "aud_hdmi", "apll12_div4", 20),
+	GATE_AUD(CLK_AUD_SPDF, "aud_spdf", "apll12_div6", 21),
+	GATE_AUD(CLK_AUD_ADC, "aud_adc", "aud_afe", 24),
+	GATE_AUD(CLK_AUD_DAC, "aud_dac", "aud_afe", 25),
+	GATE_AUD(CLK_AUD_DAC_PREDIS, "aud_dac_predis", "aud_afe", 26),
+	GATE_AUD(CLK_AUD_TML, "aud_tml", "aud_afe", 27),
+};
+
+static void __init mtk_audsys_init(struct device_node *node)
+{
+	struct clk_onecell_data *clk_data;
+	int r;
+
+	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
+
+	mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks), clk_data);
+
+	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
+	if (r)
+		pr_err("%s(): could not register clock provider: %d\n",
+			__func__, r);
+
+}
+CLK_OF_DECLARE(mtk_audsys, "mediatek,mt8516-audsys", mtk_audsys_init);
-- 
2.20.1

