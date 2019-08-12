Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A596EC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F8F5216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="kv92oP2M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfHLMdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:33:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33624 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfHLMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:33:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so104521783wru.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqJ4n54yjkwbFCEJq5QMHITUyQhmVlnjTeiFqDxqTrc=;
        b=kv92oP2M64Bi/XRGqe2z+1du/iOO7SPa2FaSuz5My6Bls2OISMLzxzQOJmnLEo3BeL
         M7HkQQp07U6ofG0MbpZzf9duWokZdkwK8qM/Ah+qrubLjk+v7LGFBUxOwZIXoWA8/ZAH
         eSbfFpcn99oNw61Co8/UMA12yaMZesLT5o//4C42HM8DIr3zIJH3l3spikX5rTVVBqJ5
         u1IqLYaXOF9pCyXsw6yJRjhhG40K4kcTru3eCyNTaY3AK1s0InOYefn9KaYJRylZm3wA
         tb7636NjIyS5ke7GYIp566pFb8Dx3iJu/fIz+BXeCd6eMUVcEzWIKG1mKhMItakVRjhj
         V8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqJ4n54yjkwbFCEJq5QMHITUyQhmVlnjTeiFqDxqTrc=;
        b=RoHadWq+iEqVZK0B/+7HxZ8z+RZlQ7RaxFDnNgBhoaAC9zq9bZbcu0PtQIFXLLU2hd
         0SEa7eAWWqDxBLYziEztj1Y+I9u1l0VIsDgzNdeNFnUb1f1UKDz6Kvc9ALM6avKtUxsS
         H3hwAURKqAo1qeS+H7Uwz0PIWR7No6W5oZi0IRR6U4XG9hk//1OrdbnsoZamRBGS4UyW
         SFtyZBX+Cdv3rOvQT/SQLz0FLjU2HzvGRyXoETYJGLPhXqiAZXDSPYDJnxVgnU6Fr/mN
         t/7d3vQmxfX0avQCxwUmdx1TKk4eciPmwT5K0ddg4MAQnIx6RlOoCZpi/FrFjzEicVh/
         enGw==
X-Gm-Message-State: APjAAAVWpOfTVpsW97jPJaXOTZxkoQfXHTMHSB3fo4UBAw8wbFifOOJN
        s4CWylNQ1b9uqaLVgM9CveW+Kg==
X-Google-Smtp-Source: APXvYqwqWFswOPiG61j95oJ0yTvUBxuNRukh5FHJcPalgQyz4/Z/hw+oqpV+YPw2EUIa3geP+g0NKQ==
X-Received: by 2002:adf:a348:: with SMTP id d8mr29164772wrb.235.1565613179498;
        Mon, 12 Aug 2019 05:32:59 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z6sm15886432wre.76.2019.08.12.05.32.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 05:32:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: meson: axg-audio: add g12a reset support
Date:   Mon, 12 Aug 2019 14:32:53 +0200
Message-Id: <20190812123253.4734-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190812123253.4734-1-jbrunet@baylibre.com>
References: <20190812123253.4734-1-jbrunet@baylibre.com>
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
index 741df7e955ca..6be9df1efce5 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/reset-controller.h>
 #include <linux/slab.h>
 
 #include "axg-audio.h"
@@ -918,6 +919,84 @@ static int devm_clk_get_enable(struct device *dev, char *id)
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
@@ -927,12 +1006,15 @@ static const struct regmap_config axg_audio_regmap_cfg = {
 
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
@@ -984,8 +1066,27 @@ static int axg_audio_clkc_probe(struct platform_device *pdev)
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
+	return devm_reset_controller_register(dev, &rst->rstc);
 }
 
 static const struct audioclk_data axg_audioclk_data = {
@@ -994,6 +1095,8 @@ static const struct audioclk_data axg_audioclk_data = {
 
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

