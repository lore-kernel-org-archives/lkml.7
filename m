Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E36C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF09206A3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zn9ACM7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfGaIkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:40:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42466 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfGaIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:40:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id x1so18783029wrr.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UZEGkmIeWiT5hBpyp0ACkTcmSjWFn04wW/+HzMQyHDk=;
        b=Zn9ACM7HfkJSQhAq/MdKwCmYbB4LvQnv3KVxTCqTN5sHdG2qRaW+STulLmmsCF5MIL
         uhem8pAiAIuqz7ljFbcwEm57+V4FZC6ZKxWaTGBtUsyTevnGJgpi7ltHZK54ZVftaX+H
         OLSMchk2atWUOmL7NmtBzJ7kINfD3AqmPB8C2n6FA+WGQNYGgYsbIbRIHzYOgXr5qfnF
         X9OryCdUALlBgl3ehY/hb1OGxuUn7yKjxmHegYTqNsVdFwbzNcbagUch6K1hN+QQvMkq
         +KONfOu0nm9tlaLYiyDAUIl1Yds+HLOzl3gbCrx+H6XVyOk158D1DPtsBQZr01XZiAsy
         PbDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UZEGkmIeWiT5hBpyp0ACkTcmSjWFn04wW/+HzMQyHDk=;
        b=pP/gHyDDsQ6OL3OYgSK455+dnWGElZLMIQR0Ss8dosZU24UsuPy4o/jIKQcJx5em4m
         UoPBd435c0zUS7wATw64Ai+j6K7KxoW1R2q630HQndYbGcVzX/FlDfdLebdqeu2KiRgo
         V+I6wdV3VP3kxK/3+AxEkCpk1XFA6apgXYYLwI5dfh3bnKD49OkCKP39aMZpWMLfg9MT
         /UnVKc8i5RH/VmovDAsMrt61B6+RCLUXlxSXe5KtgXanWhOU2Rn+p77QxsxIz/oHVACA
         ePh7/Xc4DtsCoe/+1E0ZQ5PpiP9zqgeLvsqj3e2KARvJe54wVUirABCGPyO+0/A8f8hp
         iJVg==
X-Gm-Message-State: APjAAAW4KYdcPdfi6NQqcNYZuAudRR6DiAhG7vW/CRsQfeH0VikwSi0O
        3eBLNKEp4PY+laytSU8jEGWFrw==
X-Google-Smtp-Source: APXvYqxsBYOyVGb8BxpjIKvFabYmPG59X3eLGU9JynBZjIFkT+4mN5ikBb3M4GW5QsRsgHYs7L1tyQ==
X-Received: by 2002:adf:ce88:: with SMTP id r8mr7706080wrn.42.1564562424599;
        Wed, 31 Jul 2019 01:40:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 18sm56049308wmg.43.2019.07.31.01.40.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 01:40:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] clk: meson: add g12a cpu dynamic divider driver
Date:   Wed, 31 Jul 2019 10:40:17 +0200
Message-Id: <20190731084019.8451-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190731084019.8451-1-narmstrong@baylibre.com>
References: <20190731084019.8451-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a clock driver for the cpu dynamic divider, this divider needs
to have a flag set before setting the divider value then removed
while writing the new value to the register.

This drivers implements this behavior and will be used essentially
on the Amlogic G12A and G12B SoCs for cpu clock trees.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/Kconfig          |  5 ++
 drivers/clk/meson/Makefile         |  1 +
 drivers/clk/meson/clk-cpu-dyndiv.c | 73 ++++++++++++++++++++++++++++++
 drivers/clk/meson/clk-cpu-dyndiv.h | 20 ++++++++
 4 files changed, 99 insertions(+)
 create mode 100644 drivers/clk/meson/clk-cpu-dyndiv.c
 create mode 100644 drivers/clk/meson/clk-cpu-dyndiv.h

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index 500be0b0d473..dabeb435d067 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -36,6 +36,10 @@ config COMMON_CLK_MESON_EE_CLKC
 	tristate
 	select COMMON_CLK_MESON_REGMAP
 
+config COMMON_CLK_MESON_CPU_DYNDIV
+	tristate
+	select COMMON_CLK_MESON_REGMAP
+
 config COMMON_CLK_MESON8B
 	bool
 	depends on ARCH_MESON
@@ -98,6 +102,7 @@ config COMMON_CLK_G12A
 	select COMMON_CLK_MESON_PLL
 	select COMMON_CLK_MESON_AO_CLKC
 	select COMMON_CLK_MESON_EE_CLKC
+	select COMMON_CLK_MESON_CPU_DYNDIV
 	select MFD_SYSCON
 	help
 	  Support for the clock controller on Amlogic S905D2, S905X2 and S905Y2
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index f09d83dc3d60..3939f218587a 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -2,6 +2,7 @@
 # Amlogic clock drivers
 
 obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) += meson-aoclk.o
+obj-$(CONFIG_COMMON_CLK_MESON_CPU_DYNDIV) += clk-cpu-dyndiv.o
 obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) += clk-dualdiv.o
 obj-$(CONFIG_COMMON_CLK_MESON_EE_CLKC) += meson-eeclk.o
 obj-$(CONFIG_COMMON_CLK_MESON_MPLL) += clk-mpll.o
diff --git a/drivers/clk/meson/clk-cpu-dyndiv.c b/drivers/clk/meson/clk-cpu-dyndiv.c
new file mode 100644
index 000000000000..36976927fe82
--- /dev/null
+++ b/drivers/clk/meson/clk-cpu-dyndiv.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+
+#include "clk-regmap.h"
+#include "clk-cpu-dyndiv.h"
+
+static inline struct meson_clk_cpu_dyndiv_data *
+meson_clk_cpu_dyndiv_data(struct clk_regmap *clk)
+{
+	return (struct meson_clk_cpu_dyndiv_data *)clk->data;
+}
+
+static unsigned long meson_clk_cpu_dyndiv_recalc_rate(struct clk_hw *hw,
+						      unsigned long prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_cpu_dyndiv_data *data = meson_clk_cpu_dyndiv_data(clk);
+
+	return divider_recalc_rate(hw, prate,
+				   meson_parm_read(clk->map, &data->div),
+				   NULL, 0, data->div.width);
+}
+
+static long meson_clk_cpu_dyndiv_round_rate(struct clk_hw *hw,
+					    unsigned long rate,
+					    unsigned long *prate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_cpu_dyndiv_data *data = meson_clk_cpu_dyndiv_data(clk);
+
+	return divider_round_rate(hw, rate, prate, NULL, data->div.width, 0);
+}
+
+static int meson_clk_cpu_dyndiv_set_rate(struct clk_hw *hw, unsigned long rate,
+					  unsigned long parent_rate)
+{
+	struct clk_regmap *clk = to_clk_regmap(hw);
+	struct meson_clk_cpu_dyndiv_data *data = meson_clk_cpu_dyndiv_data(clk);
+	unsigned int val;
+	int ret;
+
+	ret = divider_get_val(rate, parent_rate, NULL, data->div.width, 0);
+	if (ret < 0)
+		return ret;
+
+	val = (unsigned int)ret << data->div.shift;
+
+	/* Write the SYS_CPU_DYN_ENABLE bit before changing the divider */
+	meson_parm_write(clk->map, &data->dyn, 1);
+
+	/* Update the divider while removing the SYS_CPU_DYN_ENABLE bit */
+	return regmap_update_bits(clk->map, data->div.reg_off,
+				  SETPMASK(data->div.width, data->div.shift) |
+				  SETPMASK(data->dyn.width, data->dyn.shift),
+				  val);
+};
+
+const struct clk_ops meson_clk_cpu_dyndiv_ops = {
+	.recalc_rate = meson_clk_cpu_dyndiv_recalc_rate,
+	.round_rate = meson_clk_cpu_dyndiv_round_rate,
+	.set_rate = meson_clk_cpu_dyndiv_set_rate,
+};
+EXPORT_SYMBOL_GPL(meson_clk_cpu_dyndiv_ops);
+
+MODULE_DESCRIPTION("Amlogic CPU Dynamic Clock divider");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/meson/clk-cpu-dyndiv.h b/drivers/clk/meson/clk-cpu-dyndiv.h
new file mode 100644
index 000000000000..f4908404792e
--- /dev/null
+++ b/drivers/clk/meson/clk-cpu-dyndiv.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef __MESON_CLK_CPU_DYNDIV_H
+#define __MESON_CLK_CPU_DYNDIV_H
+
+#include <linux/clk-provider.h>
+#include "parm.h"
+
+struct meson_clk_cpu_dyndiv_data {
+	struct parm div;
+	struct parm dyn;
+};
+
+extern const struct clk_ops meson_clk_cpu_dyndiv_ops;
+
+#endif /* __MESON_CLK_CPU_DYNDIV_H */
-- 
2.22.0

