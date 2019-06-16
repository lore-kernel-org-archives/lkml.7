Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE5FC31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60202087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uea5VON9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbfFPXgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34444 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfFPXgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so7522475ljg.1;
        Sun, 16 Jun 2019 16:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kF/6KuHlrSd9mdDpIpUGMai+d4x/C7UdsSLRmP/R+bA=;
        b=uea5VON9Gs+alO7pNiQIvFw0pS9H8VOwBpklZDg7tCNVV5kA7VE96ZDe1LYsZwDeS5
         AywggMsyQin0B7dfMet6pJCKs/SLyY+WK27owLYe4bT9XB3P8HEnl/TYHpzmBtJYhlMk
         sFOgpb9mVZ011WxcC/XnjL2PPeGkz/KkHdF4vdyP59Ku5z/Mi1jwNP7r1cta5fBaXeEp
         atqed0ek6PsYZohKyMg9Dxvwy1DZ4W+/r++01IEKo4ucjV5RhuMajaXxlIsLfyAlqPcZ
         Sd0VJHwzttJWBlg8J8T/DJU0q1MTxSdZj6j48JGfoGqu8ksWTvNQ4HRNfe36+3fizw1b
         3YAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kF/6KuHlrSd9mdDpIpUGMai+d4x/C7UdsSLRmP/R+bA=;
        b=IJUyKQAU0eenu2/37UK3ug6kHNbuQ9jMnDDXQWbO9m9Ldsrm7CJzovN0MKaSwhSimb
         8EjFDmzO5qDwuuUyrzpuAfPY03ARxAH24utPeno7kpfkSj6hdBveo+pR1tuVcRHHbgv6
         gRdwt8AkIEnC44L3gxCmhd8F09J898q06ZEfHfbs+mb88emAinDGXI5ZooYpZ6OMIS+7
         UBhvsRt+akwlrEsz75nKWsQ36sgA3I6mCkS8XqCzZHgs9elR4sq2nY8M6zvQArV3Rl1g
         sIQ7xxJ1is0ZtxWzRSWdw/KFO0PIqUhKWhqeS9ebTYFqIlSzZDvca4X99TsegpKPTjd/
         Z9aw==
X-Gm-Message-State: APjAAAUc5djRcneCixpsmtlZTCaY89S85WDkT+l1LpWq5/z0WE5UBdrC
        Cuj2DQ1TiK2S02VgZYACRo4=
X-Google-Smtp-Source: APXvYqy/iwvDzxaPybFKJs9qpm4CTXXq8tUPoAxNaMLq4DPF3XaDXamStAraBhhbIsbS4LgrYsB/2g==
X-Received: by 2002:a2e:9209:: with SMTP id k9mr24406054ljg.96.1560728168157;
        Sun, 16 Jun 2019 16:36:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:07 -0700 (PDT)
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
Subject: [PATCH v4 03/10] memory: tegra20-emc: Adapt for clock driver changes
Date:   Mon, 17 Jun 2019 02:35:44 +0300
Message-Id: <20190616233551.6838-4-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
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
2.22.0

