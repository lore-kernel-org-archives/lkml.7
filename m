Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37522C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B3B9208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IsSBjGrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFUGNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:13:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37079 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfFUGNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:13:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh12so2469945plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ImM7LoJ0g/LV9Msk8fC9rkqyN6ipnuYryn1oHdAjw90=;
        b=IsSBjGrF+DN7QHmXac43Ny79aaDEhysk2zRkeDW43Wox0gAQlxq2jhbf6FPNlZ0Ivg
         W5dXPLPd/Gl+e6zZvdKMuSxCqWPSObH8X+6Ftomh0xUVUeY9bJW8JlShqfj7hcs/Efjb
         WCJhUx6hG8j/IV54/quUx/94bk1d6jXYUvkajSza2zunVxXSy+NIClWkeztrxvb4bGIA
         M0VGYyvy930CJIehNbG1vyrmufkJ6KudfaIw/VvW8p0aT4auVM1Gfc1eLZmKefZGqdyb
         fWgl0VC4cT8ipH3uf17ndRAQsBWPklzGRQaHexZTkF7/F/oKNyfwQgR8BLi5BzlZwF2r
         ADDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ImM7LoJ0g/LV9Msk8fC9rkqyN6ipnuYryn1oHdAjw90=;
        b=CeJz/sOqK5v/qtZS2aveFJKYZ4H15WNYZNXUXGKqYsWxPjcgS18rAxw1PwetHUzxJ5
         3AASw6meP9lzp2Faq9yl26MZSJ6OBHWVXQeBoe5crUdinpl74VA31p4PJjz0B4vu5Jnz
         44HwrvYkZAhS8a+FmHxamyZ3geAPTsh9xIYkRxYwlah12ACaBg9iJ8hwdj4qRonSuB8Q
         RgCM1zyyscGDZyGmh5qLHlaoIr8C4xHhCHFafITcxzvXYevVbD6WQixCbCpSollhFHy9
         y7Vn3QLm6kUH6Bn4AUCpOY5VsRQRu6uwhbfI1ME5qB3kBVhPqpIf2dgNYOC0w53jYpYd
         ZWrw==
X-Gm-Message-State: APjAAAURk1ZnhXZ5+kGAhPeLE/0t5Px5Qkbf+sIvY0K77kHoi1+D0gl6
        8CrVna0XLbuUOmfJkk00ZKjQzg==
X-Google-Smtp-Source: APXvYqz898MP1cNZToQJ6foRRP/YHqudKpgx1HQy2pqhLZm61bx9cEa7MCexGOqYuMmbmiHTN0ANag==
X-Received: by 2002:a17:902:b603:: with SMTP id b3mr69912736pls.72.1561097579911;
        Thu, 20 Jun 2019 23:12:59 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x7sm1266134pfm.82.2019.06.20.23.12.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 23:12:59 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] mmc: sdhci-sprd: Add pin control support for voltage switch
Date:   Fri, 21 Jun 2019 14:12:33 +0800
Message-Id: <db6d2b2d6170fd2409916c5c41b857f4bc587a15.1561094029.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1561094029.git.baolin.wang@linaro.org>
References: <cover.1561094029.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For Spreadtrum SD card voltage switching, besides regulator setting,
it also need switch related pin's state to output corresponding voltage.

This patch adds pin control operation to support voltage switch.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c |   54 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 8b23c88..6ee340a 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
@@ -72,6 +73,9 @@ struct sdhci_sprd_host {
 	struct clk *clk_sdio;
 	struct clk *clk_enable;
 	struct clk *clk_2x_enable;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_uhs;
+	struct pinctrl_state *pins_default;
 	u32 base_rate;
 	int flags; /* backup of host attribute */
 	u32 phy_delay[MMC_TIMING_MMC_HS400 + 2];
@@ -405,6 +409,8 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 {
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	int ret;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
@@ -416,6 +422,37 @@ static int sdhci_sprd_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 	}
 
+	if (IS_ERR(sprd_host->pinctrl))
+		return 0;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_180:
+		ret = pinctrl_select_state(sprd_host->pinctrl,
+					   sprd_host->pins_uhs);
+		if (ret) {
+			pr_err("%s: failed to select uhs pin state\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+		break;
+
+	default:
+		/* fall-through */
+	case MMC_SIGNAL_VOLTAGE_330:
+		ret = pinctrl_select_state(sprd_host->pinctrl,
+					   sprd_host->pins_default);
+		if (ret) {
+			pr_err("%s: failed to select default pin state\n",
+			       mmc_hostname(mmc));
+			return ret;
+		}
+		break;
+	}
+
+	/* Wait for 300 ~ 500 us for pin state stable */
+	usleep_range(300, 500);
+	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+
 	return 0;
 }
 
@@ -504,6 +541,23 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	sprd_host = TO_SPRD_HOST(host);
 	sdhci_sprd_phy_param_parse(sprd_host, pdev->dev.of_node);
 
+	sprd_host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(sprd_host->pinctrl)) {
+		sprd_host->pins_uhs =
+			pinctrl_lookup_state(sprd_host->pinctrl, "state_uhs");
+		if (IS_ERR(sprd_host->pins_uhs)) {
+			ret = PTR_ERR(sprd_host->pins_uhs);
+			goto pltfm_free;
+		}
+
+		sprd_host->pins_default =
+			pinctrl_lookup_state(sprd_host->pinctrl, "default");
+		if (IS_ERR(sprd_host->pins_default)) {
+			ret = PTR_ERR(sprd_host->pins_default);
+			goto pltfm_free;
+		}
+	}
+
 	clk = devm_clk_get(&pdev->dev, "sdio");
 	if (IS_ERR(clk)) {
 		ret = PTR_ERR(clk);
-- 
1.7.9.5

