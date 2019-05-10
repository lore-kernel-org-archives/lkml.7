Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF4DC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618EB2173B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0mH9YjY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfEJIXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:23:52 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54269 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfEJIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:23:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so6462689wme.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vmeMuMSDMRsdloGxuoikGok3kV3ygZ9BvAD0hdZ7+1Q=;
        b=0mH9YjY5pN4altS8m8esAKUXR8IjrVzuxHW1h+AtZQx1kLM9VnfJwqhePnEaJ3+tcQ
         LDsHRX5weQ9wgdfEnAhU2tnojIKrjQyaRKZBpIiIC/6QOSZxzPqq8AVQh0dQcOvopUCT
         MmZPZTadQtHXyNJpU2dKz9hO1m/Kuh7a06sz6g0BzBnVl2JndWzmNQFQgG3WHVB7bBAg
         chdGBxSgbo/1Nwsc6TAmltJjr2DtkcNk0bJl+qbmNHHzu6thGLT7IAxq+ahgEcy8qYHy
         LItGoR6khG+/yWSoyynqqrIjzgfYTQRuqO8gHCKgi8DfrNVIG1F0tbq1XgHLBAZJhHIV
         unFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vmeMuMSDMRsdloGxuoikGok3kV3ygZ9BvAD0hdZ7+1Q=;
        b=jhyAvoV+OSGt2IjgOtcf0IcfPdlvOMkrCITCeHyzaloIyV+ONf3JgP2mC9tBd25Qjk
         3TQz8nmmTMm9g+G3i0cd7cceSFXqhYW4Xnj1xqDmq437cPhYweU6PVQPo2EWc3El8LIt
         wcRLnquY+kDIri5MuQHaEY1I47zgdjhA7Zf6vZSg8hTSxUj+3HdAJ5efSDrzIBRpccb1
         gddx9s8+oIoe2bDLPWEi4prKxT65XALXfzu9U5jQY6Bivpev1bpVzLMc+OCJyb86Tqki
         AYfI7cMsuKxLRp/OYrhHANloGP4AuEfUXFHyHH+dC2WsE/YqZSrgA8flfTmeYUyXVh61
         FEng==
X-Gm-Message-State: APjAAAVDbstIJRVL5cIVhx7gVJ78SybBaa9mKUpF78+JEEJ1eYp0mMro
        jcKnwX4hoCO2f+U9chvBdX3uHg==
X-Google-Smtp-Source: APXvYqzH46oUYeeQfj80hmpJooPiNtx258oSc9+1YhNuanvgtlSfyRKNdwfzGIXGbohEiEHZM9Vyuw==
X-Received: by 2002:a1c:2109:: with SMTP id h9mr6127281wmh.68.1557476610628;
        Fri, 10 May 2019 01:23:30 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z4sm3790285wmk.5.2019.05.10.01.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 01:23:30 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/6] pinctrl: meson: Rework enable/disable bias part
Date:   Fri, 10 May 2019 10:23:22 +0200
Message-Id: <20190510082324.21181-5-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190510082324.21181-1-glaroque@baylibre.com>
References: <20190510082324.21181-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rework bias enable/disable part to prepare drive-strength integration
no functional changes

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson.c | 85 +++++++++++++++------------
 1 file changed, 49 insertions(+), 36 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson.c b/drivers/pinctrl/meson/pinctrl-meson.c
index 96a4a72708e4..8ea5c1527064 100644
--- a/drivers/pinctrl/meson/pinctrl-meson.c
+++ b/drivers/pinctrl/meson/pinctrl-meson.c
@@ -174,62 +174,75 @@ int meson_pmx_get_groups(struct pinctrl_dev *pcdev, unsigned selector,
 	return 0;
 }
 
-static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
-			     unsigned long *configs, unsigned num_configs)
+static int meson_pinconf_disable_bias(struct meson_pinctrl *pc,
+				      unsigned int pin)
 {
-	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
 	struct meson_bank *bank;
-	enum pin_config_param param;
-	unsigned int reg, bit;
-	int i, ret;
+	unsigned int reg, bit = 0;
+	int ret;
 
 	ret = meson_get_bank(pc, pin, &bank);
 	if (ret)
 		return ret;
 
+	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit), 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int meson_pinconf_enable_bias(struct meson_pinctrl *pc, unsigned int pin,
+				     bool pull_up)
+{
+	struct meson_bank *bank;
+	unsigned int reg, bit, val = 0;
+	int ret;
+
+	ret = meson_get_bank(pc, pin, &bank);
+	if (ret)
+		return ret;
+
+	meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
+	if (pull_up)
+		val = BIT(bit);
+
+	ret = regmap_update_bits(pc->reg_pull, reg, BIT(bit), val);
+	if (ret)
+		return ret;
+
+	meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg, &bit);
+	ret = regmap_update_bits(pc->reg_pullen, reg, BIT(bit),	BIT(bit));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int meson_pinconf_set(struct pinctrl_dev *pcdev, unsigned int pin,
+			     unsigned long *configs, unsigned num_configs)
+{
+	struct meson_pinctrl *pc = pinctrl_dev_get_drvdata(pcdev);
+	enum pin_config_param param;
+	int i, ret;
+
 	for (i = 0; i < num_configs; i++) {
 		param = pinconf_to_config_param(configs[i]);
 
 		switch (param) {
 		case PIN_CONFIG_BIAS_DISABLE:
-			dev_dbg(pc->dev, "pin %u: disable bias\n", pin);
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULLEN, &reg,
-					       &bit);
-			ret = regmap_update_bits(pc->reg_pullen, reg,
-						 BIT(bit), 0);
+			ret = meson_pinconf_disable_bias(pc, pin);
 			if (ret)
 				return ret;
 			break;
 		case PIN_CONFIG_BIAS_PULL_UP:
-			dev_dbg(pc->dev, "pin %u: enable pull-up\n", pin);
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
-					       &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pullen, reg,
-						 BIT(bit), BIT(bit));
-			if (ret)
-				return ret;
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pull, reg,
-						 BIT(bit), BIT(bit));
+			ret = meson_pinconf_enable_bias(pc, pin, true);
 			if (ret)
 				return ret;
 			break;
 		case PIN_CONFIG_BIAS_PULL_DOWN:
-			dev_dbg(pc->dev, "pin %u: enable pull-down\n", pin);
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULLEN,
-					       &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pullen, reg,
-						 BIT(bit), BIT(bit));
-			if (ret)
-				return ret;
-
-			meson_calc_reg_and_bit(bank, pin, REG_PULL, &reg, &bit);
-			ret = regmap_update_bits(pc->reg_pull, reg,
-						 BIT(bit), 0);
+			ret = meson_pinconf_enable_bias(pc, pin, false);
 			if (ret)
 				return ret;
 			break;
-- 
2.17.1

