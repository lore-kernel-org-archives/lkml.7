Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D21C48BDB
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95382070D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 22:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RotnzN4o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfGGWzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 18:55:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37115 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbfGGWy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 18:54:56 -0400
Received: by mail-qk1-f196.google.com with SMTP id d15so11903718qkl.4;
        Sun, 07 Jul 2019 15:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=RotnzN4o9M3ZTYm5BB4/9vLl6VZTbhw1SpGx4a/PPqYXoIsYGBwoq0IAYOAmbkCsLw
         8N6SV3MDsITPixVNgGVXPQg0RWhAuT9q8aOcCHu3bQZBCcBVNvJCDKennRMcGDiDbmbk
         QVF0fhIelztTLawRBZwgKfc8c7wx+EDHXxOKPooB+h29kmAWwQPyb07cCvHxmpHh7svm
         cmgLiNpG18nZD2mhNfi0b5XLIFmLZnFdP1deIQTzSz8O4piT3exNDdXDwTyFigm3XGKi
         AV4c6/gnlYaHL9SgJd4Ihs6eOWlPkCokhWl76GR0GsSW0XJFlAYIPtdjSVwkVEIDyIXT
         I3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=DiViR6E7s0girZn7wnrwn5qyfkjgXS0+T5TdLNM6iKZVgpy6HCmEuNH1M8vP93KKCA
         YnyQjlqZf2g7GFbwKLRgAvExvbd7DUBUVw9T5lO3P1Ux/R9xgUsq2I9zWqsmRcrVNBYr
         eM/agh04SzJTjM9+ODsHlHpHMEc5KpBQNYA2fG3OIVO/1irXL0n3XZJ9V1XhLS0aqF9o
         4kStdbZeNswO5uYIQFhf8FnjizWm8vleuL2aOJo1fJ7qi8Xl2N6ycVK0iQnxjoqrE7hW
         LhQ5t86NpEj6ipAail230Vy/yiCXC6kbgB77jyrw6kLRT05cBq2X54lHSSN+wF1nQURv
         rxzA==
X-Gm-Message-State: APjAAAVOkj1chBYqOIr2I5SqiffxjUailhDpjcrcmM+TxVb3oZl0MX6d
        Q4V89ygBOj05gU7vxF7odq8=
X-Google-Smtp-Source: APXvYqzvbJjrVtN0UHCxgj0/JsjQ6D7plewOryrcTy0IuNVCrfUr6pt5h6UaeNO8M0t1pST51XEgiw==
X-Received: by 2002:a05:620a:16da:: with SMTP id a26mr12004296qkn.376.1562540095667;
        Sun, 07 Jul 2019 15:54:55 -0700 (PDT)
Received: from localhost.localdomain (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.gmail.com with ESMTPSA id t2sm8217556qth.33.2019.07.07.15.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jul 2019 15:54:55 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/13] memory: tegra20-emc: Adapt for clock driver changes
Date:   Mon,  8 Jul 2019 01:54:14 +0300
Message-Id: <20190707225424.9562-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190707225424.9562-1-digetx@gmail.com>
References: <20190707225424.9562-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now Terga20 and Tegra30 EMC drivers should provide clock-rounding
functionality using the new Tegra-CLK driver API.

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 50 ++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index da8fa592b071..b519f02b0ee9 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/tegra.h>
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -421,6 +422,44 @@ static int emc_setup_hw(struct tegra_emc *emc)
 	return 0;
 }
 
+static long emc_round_rate(unsigned long rate,
+			   unsigned long min_rate,
+			   unsigned long max_rate,
+			   void *arg)
+{
+	struct emc_timing *timing = NULL;
+	struct tegra_emc *emc = arg;
+	unsigned int i;
+
+	min_rate = min(min_rate, emc->timings[emc->num_timings - 1].rate);
+
+	for (i = 0; i < emc->num_timings; i++) {
+		if (emc->timings[i].rate < rate && i != emc->num_timings - 1)
+			continue;
+
+		if (emc->timings[i].rate > max_rate) {
+			i = max(i, 1u) - 1;
+
+			if (emc->timings[i].rate < min_rate)
+				break;
+		}
+
+		if (emc->timings[i].rate < min_rate)
+			continue;
+
+		timing = &emc->timings[i];
+		break;
+	}
+
+	if (!timing) {
+		dev_err(emc->dev, "no timing for rate %lu min %lu max %lu\n",
+			rate, min_rate, max_rate);
+		return -EINVAL;
+	}
+
+	return timing->rate;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -477,21 +516,28 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
+
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
 	if (IS_ERR(emc->clk)) {
 		err = PTR_ERR(emc->clk);
 		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
-		return err;
+		goto unset_cb;
 	}
 
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
 			err);
-		return err;
+		goto unset_cb;
 	}
 
 	return 0;
+
+unset_cb:
+	tegra20_clk_set_emc_round_callback(NULL, NULL);
+
+	return err;
 }
 
 static const struct of_device_id tegra_emc_of_match[] = {
-- 
2.22.0

