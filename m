Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5E2C32756
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E55F2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqS0R2SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfHKVCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:02:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41937 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKVBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:32 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so68069767lfa.8;
        Sun, 11 Aug 2019 14:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=iqS0R2SDrlicqLgn5suktXs9AFtzniJ/Vaer5C9DqjIXiQajwBUDDI+V3GXngWZzWX
         JQBzVibEVd/zV4jcDkwlKJYDenpYH0rdR0Q6vmrmrNiuOb/ULXZLkmOaHJLLzjA24NCD
         SKGimlm+vGo5HN8gIRg/BghUl24f6r4Zeno/aDd2z/INWNi1ehxZP9LyCyT54UqOadhi
         fKY+17qfDoJKGzwtDyH0Noq2IEmAecgV+4ChlDSeDP+R1nkG/OvHAndY6il2NpL9HVTF
         O7nmSu01A13VI9yaTGn7R0ak/p2V1+eRM+ViTZIBGFZ+chZLxl9BS++xOkCvLtHYCtl9
         3t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCQNSQK+2muyk726fUJhk7VrSnWFFmbUV5XprGSciK8=;
        b=joSu8Lm4DOqiXL+3MCm1zEvIm6UudWa2HQ40QgL0Xv2gOegSG+3ZDNLJ/tlhyJVTz7
         BneZqpRNiaUyuLeIfAgL2Nvu1NyrmTslk+CsbZrr5fC1qLw0X8Ja35dmvZ/KXnFpNnuz
         Hl5naCanefXrbNPYfZCNuRAwqVdA1jGVJlocQtpWkotCqHjP5nUqlFNMvwGPNGYt1MM4
         UnUCOVP95OE4Kw8KMqkZJldI74+tZ7EwklC4fR3ElWQD8D1luk5dWC0ePUgCvC5tpTf9
         5OocY1HLpKYZurAL1C1C4aqDxbJE+EjzA4EjbUEAWdKngm6NfoGMZWobolv8vXzqGzFA
         HEKQ==
X-Gm-Message-State: APjAAAVQcUrPx9scNzVEVI11EKGAIDpoge/H1LNEvgmLwqk1HChgOl4c
        s8hw9ovsQ7fX0nBF/35fJ4Q=
X-Google-Smtp-Source: APXvYqya9rPNIlGa09sLjQh0b8kmUVAffaz2MXC2ZpD6xEBdX5nLv/4ylB2afz92efaRHl1skzYcUA==
X-Received: by 2002:a05:6512:15a:: with SMTP id m26mr18011935lfo.71.1565557289724;
        Sun, 11 Aug 2019 14:01:29 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:29 -0700 (PDT)
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
Subject: [PATCH v10 03/15] memory: tegra20-emc: Adapt for clock driver changes
Date:   Mon, 12 Aug 2019 00:00:31 +0300
Message-Id: <20190811210043.20122-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
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

