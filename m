Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01DEC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D01218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="15DE6QGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfGCM0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:26:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33582 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:26:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so2610865wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JILUVyhQViuGdxVU7msStBtHX6blqTuLXOnzbseIUxY=;
        b=15DE6QGNII0vC99FAxzXL/XNAKOz1spvux5aiNDajerPemkY0N0Yvhp2NZCZ56aXTd
         V2F1xuct6cDSpr46JtcIMfT0bY+qWkhe+ryMJyyN3VyCojjWzkFD36pkScxrT6gquK2Z
         mNf6E4S6+B9Vjc3sY/l4IQ40/p5dnlRb044FAl8PI7y18/lcpTNGk2LBS1A4BV2d5VkC
         UVkkVb7iyhWRM4GL6g9a1XzJi/zV/bzZ3psfBINcuReBkawJoee3Vf9yBnestkcfkdaZ
         Rji7UjMscG4KTSfq2gpJBzs8UNT7oFgw3yE4242/k0j/r450VClhz57RXPNJt3Rba9cJ
         gcng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JILUVyhQViuGdxVU7msStBtHX6blqTuLXOnzbseIUxY=;
        b=dkgxeHl1kfKh59ZROBZk87/A8mZfOS0F3+rK5Sex/hzLTqUxtdFV42xZytzhT+AIl5
         WaHzZVLMX3ELDYA0NLpyDRPFAL4WP+J8zUPnH9lD4sB6HRqOjhYn3yt2Dqa6YGhg/ROV
         W91Oa+xl/zPxJGyK0e5J2B/ok68s8R8DaYWMKFcMHK/S63Pnj3p3dFoHuggyeUMSXFp4
         pxFKpiWICoAaPM3kv8p7bw1AVeqAzRYKjYGbtobNO6Z0tew8muC/CK2XiWYo+FgK1dRg
         6MxP34eD/kxAM1C7ul7+UsAlq1Xofw22k9dc/Ibq3vcAgb4vCJA+uxXodf9zqDP5WdFm
         yovQ==
X-Gm-Message-State: APjAAAXMI+0fOJ4+fVaeHdBhWvHhaGhirCwKHLFJxxMZbX4XeEZEpRoN
        s0MH8tSx27mQlcER37/fIgUI7w==
X-Google-Smtp-Source: APXvYqw/fJylWhA1wOFDAASQ7snUTEyMNdcCC+ljsbuq5ZdsSzk61cFVRouS0SUaOm+SNLZ6a3mjPA==
X-Received: by 2002:a5d:4ecc:: with SMTP id s12mr29803490wrv.157.1562156784072;
        Wed, 03 Jul 2019 05:26:24 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v67sm2868132wme.24.2019.07.03.05.26.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:26:23 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: meson: axg-audio: add g12a reset support
Date:   Wed,  3 Jul 2019 14:26:14 +0200
Message-Id: <20190703122614.3579-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190703122614.3579-1-jbrunet@baylibre.com>
References: <20190703122614.3579-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the g12a, the register space dedicated to the audio clock also
provides some resets. Let the clock controller register a reset
provider as well for this SoC family.

the axg SoC family does not appear to provide this feature.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 107 +++++++++++++++++++++++++++++++++-
 drivers/clk/meson/axg-audio.h |   1 +
 2 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 8028ff6f6610..ce163bd03aad 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/reset-controller.h>
 #include <linux/slab.h>
 
 #include "axg-audio.h"
@@ -916,6 +917,84 @@ static int axg_register_clk_hw_inputs(struct device *dev,
 	return 0;
 }
 
+struct axg_audio_reset_data {
+	struct reset_controller_dev rstc;
+	struct regmap *map;
+	unsigned int offset;
+};
+
+static void axg_audio_reset_reg_and_bit(struct axg_audio_reset_data *rst,
+					unsigned long id,
+					unsigned int *reg,
+					unsigned int *bit)
+{
+	unsigned int stride = regmap_get_reg_stride(rst->map);
+
+	*reg = (id / (stride * BITS_PER_BYTE)) * stride;
+	*reg += rst->offset;
+	*bit = id % (stride * BITS_PER_BYTE);
+}
+
+static int axg_audio_reset_update(struct reset_controller_dev *rcdev,
+				unsigned long id, bool assert)
+{
+	struct axg_audio_reset_data *rst =
+		container_of(rcdev, struct axg_audio_reset_data, rstc);
+	unsigned int offset, bit;
+
+	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
+
+	regmap_update_bits(rst->map, offset, BIT(bit),
+			assert ? BIT(bit) : 0);
+
+	return 0;
+}
+
+static int axg_audio_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct axg_audio_reset_data *rst =
+		container_of(rcdev, struct axg_audio_reset_data, rstc);
+	unsigned int val, offset, bit;
+
+	axg_audio_reset_reg_and_bit(rst, id, &offset, &bit);
+
+	regmap_read(rst->map, offset, &val);
+
+	return !!(val & BIT(bit));
+}
+
+static int axg_audio_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return axg_audio_reset_update(rcdev, id, true);
+}
+
+static int axg_audio_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return axg_audio_reset_update(rcdev, id, false);
+}
+
+static int axg_audio_reset_toggle(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	int ret;
+
+	ret = axg_audio_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return axg_audio_reset_deassert(rcdev, id);
+}
+
+static const struct reset_control_ops axg_audio_rstc_ops = {
+	.assert = axg_audio_reset_assert,
+	.deassert = axg_audio_reset_deassert,
+	.reset = axg_audio_reset_toggle,
+	.status = axg_audio_reset_status,
+};
+
 static const struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
@@ -925,12 +1004,15 @@ static const struct regmap_config axg_audio_regmap_cfg = {
 
 struct audioclk_data {
 	struct clk_hw_onecell_data *hw_onecell_data;
+	unsigned int reset_offset;
+	unsigned int reset_num;
 };
 
 static int axg_audio_clkc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct audioclk_data *data;
+	struct axg_audio_reset_data *rst;
 	struct regmap *map;
 	struct resource *res;
 	void __iomem *regs;
@@ -1005,8 +1087,27 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
 		}
 	}
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
-					   data->hw_onecell_data);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					data->hw_onecell_data);
+	if (ret)
+		return ret;
+
+	/* Stop here if there is no reset */
+	if (!data->reset_num)
+		return 0;
+
+	rst = devm_kzalloc(dev, sizeof(*rst), GFP_KERNEL);
+	if (!rst)
+		return -ENOMEM;
+
+	rst->map = map;
+	rst->offset = data->reset_offset;
+	rst->rstc.nr_resets = data->reset_num;
+	rst->rstc.ops = &axg_audio_rstc_ops;
+	rst->rstc.of_node = dev->of_node;
+	rst->rstc.owner = THIS_MODULE;
+
+	return ret = devm_reset_controller_register(dev, &rst->rstc);
 }
 
 static const struct audioclk_data axg_audioclk_data = {
@@ -1015,6 +1116,8 @@ static const struct audioclk_data axg_audioclk_data = {
 
 static const struct audioclk_data g12a_audioclk_data = {
 	.hw_onecell_data = &g12a_audio_hw_onecell_data,
+	.reset_offset = AUDIO_SW_RESET,
+	.reset_num = 26,
 };
 
 static const struct of_device_id clkc_match_table[] = {
diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
index 5d972d55d6c7..c00e28b2e1a9 100644
--- a/drivers/clk/meson/axg-audio.h
+++ b/drivers/clk/meson/axg-audio.h
@@ -22,6 +22,7 @@
 #define AUDIO_MCLK_F_CTRL	0x018
 #define AUDIO_MST_PAD_CTRL0	0x01c
 #define AUDIO_MST_PAD_CTRL1	0x020
+#define AUDIO_SW_RESET		0x024
 #define AUDIO_MST_A_SCLK_CTRL0	0x040
 #define AUDIO_MST_A_SCLK_CTRL1	0x044
 #define AUDIO_MST_B_SCLK_CTRL0	0x048
-- 
2.21.0

