Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFDCC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A35F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 17:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+mrf2WO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbfEXRY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 13:24:26 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34289 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731947AbfEXRYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 13:24:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id v18so7726477lfi.1;
        Fri, 24 May 2019 10:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2LsHpHJ4eb3g/+SexxRplrB7uNX/fO1FmwX3j+AIkvA=;
        b=S+mrf2WOjRiT5AR89f4vqsnlyYx9hfdMYfVRZ3hse4ZatvPtHHW/lefL3IaUzrGZQ/
         vlsRx/p8A4wj0aLzk8tJRPkm12WMCep5My8glM+2dvowhqAvSTrPB98Ih4Q6G3EObWoL
         3Kl64JwmWScQho7t7/RDjrpPqgpe3w/5BMJyAxJRb0ojinlCrkCyocCNoeznNePR4CqG
         zSmELSgAuwh+5lc3yD1/CRbo5bP25ArC458TARCsvJ0+ZMIksl90Duxmm89ww9Qevzkj
         ZIwy1RDQOFTOp2rRJrJ0s01TYHjSlzgxH7KybKyigo8XgouGtSGY/DQVSwARjyWCJC48
         sVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2LsHpHJ4eb3g/+SexxRplrB7uNX/fO1FmwX3j+AIkvA=;
        b=lwvzEvUGtmz9Slif3rb2n9I9T0k7wVpS4OdjnEgme/Su5nETmyL+vnjYvLo2Dg4pcg
         sq2NOxHdEGtuPdUOmC3JMhON0x6trByGtawSN/X3RJQ7ly8zNY2xY4OXbV2jUUptRhOw
         D0vZPi+/GNdHZ9cHP3Ofi+hSerX2U2vHDWkfObqSW712pBPVi3S+BDkQp2yFr/nVkRrV
         8MaDxsYngWGOmDhx2Vs+2OoIOajR1bxqe5W3b7cDxM3ylrLp9HDYl2WYN2jt2fwjY7Sd
         9xJKKIOv6kkEYAG1P2lQ0mxCkQxr8+Y+dxa0Z21cwYCrw7QqT1DHvTFcnclKItRN/yQv
         lK2w==
X-Gm-Message-State: APjAAAVzPIHZBcCbZW9HWOmrgCqPsPjOjrxn5vBbTHoFOWtZnkOce6g/
        XBwmZD99PRbPM4Vc2lAgNSw=
X-Google-Smtp-Source: APXvYqyqTGTDT9dszaLTHt5Wcr4GDjwtMT6l66Bc4ZdjIKveWB8Q3eZtvQ/OqNB74/a0TzBapwWt8Q==
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr5847173lfp.53.1558718660741;
        Fri, 24 May 2019 10:24:20 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id d13sm196957lfm.27.2019.05.24.10.24.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 10:24:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] memory: tegra20-emc: Adapt for clock driver changes
Date:   Fri, 24 May 2019 20:23:48 +0300
Message-Id: <20190524172353.29087-4-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524172353.29087-1-digetx@gmail.com>
References: <20190524172353.29087-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The emc_mux clock is gone now and EMC driver should provide the clock
rounding functionality.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 55 ++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 55ac3863a354..d3e1f898d745 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/clk/tegra.h>
 #include <linux/completion.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
@@ -138,7 +139,6 @@ struct tegra_emc {
 	struct completion clk_handshake_complete;
 	struct notifier_block clk_nb;
 	struct clk *backup_clk;
-	struct clk *emc_mux;
 	struct clk *pll_m;
 	struct clk *clk;
 	void __iomem *regs;
@@ -424,6 +424,44 @@ static int emc_setup_hw(struct tegra_emc *emc)
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
@@ -480,18 +518,20 @@ static int tegra_emc_probe(struct platform_device *pdev)
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
 
 	emc->pll_m = clk_get_sys(NULL, "pll_m");
 	if (IS_ERR(emc->pll_m)) {
 		err = PTR_ERR(emc->pll_m);
 		dev_err(&pdev->dev, "failed to get pll_m clock: %d\n", err);
-		return err;
+		goto unset_cb;
 	}
 
 	emc->backup_clk = clk_get_sys(NULL, "pll_p");
@@ -501,13 +541,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		goto put_pll_m;
 	}
 
-	emc->emc_mux = clk_get_parent(emc->clk);
-	if (IS_ERR(emc->emc_mux)) {
-		err = PTR_ERR(emc->emc_mux);
-		dev_err(&pdev->dev, "failed to get emc_mux clock: %d\n", err);
-		goto put_backup;
-	}
-
 	err = clk_notifier_register(emc->clk, &emc->clk_nb);
 	if (err) {
 		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
@@ -521,6 +554,8 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	clk_put(emc->backup_clk);
 put_pll_m:
 	clk_put(emc->pll_m);
+unset_cb:
+	tegra20_clk_set_emc_round_callback(NULL, NULL);
 
 	return err;
 }
-- 
2.21.0

