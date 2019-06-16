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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42498C31E53
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0E92087F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 23:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZW0ndBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfFPXgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 19:36:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41122 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfFPXgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 19:36:09 -0400
Received: by mail-lf1-f66.google.com with SMTP id 136so5133136lfa.8;
        Sun, 16 Jun 2019 16:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/+aiQqK7SVIFUweiXHhwyrm7ecn7DTqzS0Aa+5uVOck=;
        b=WZW0ndBQDx6P5ZBShmiU8I11BRUnYe/3JfJgyRAXTX+lMOh4eZfkA4usFnw0N/8coV
         jk3EA/wkrjWjFhwVn3OfEWUrLA6WZ72b1MEaiuLkh4nKZ/CTaCt+oW0cCvjMnCZYj4pv
         bPGUKvacMewgNenWN++3N0WV7g90NF1Y7CokW2rUOomnO5Xg90yd5ysg0JCKvvBxRf0F
         pnsAHZbnEk6gQtX5niwCKpMrxLsgvQw56uMcYZIhtcj7WrOd89UOwVVY3WPkj6+dbNKo
         Nrj2qIZFKHU5bjRB0HHH96aco4Smyi5kIhh28JMGOZ5YAbkwamd5bbUkT8U+iQPJclJh
         /+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/+aiQqK7SVIFUweiXHhwyrm7ecn7DTqzS0Aa+5uVOck=;
        b=kS0TnXdn4g4S0Ay6oIwgBfcKgJofj5Aw+YX3ZK6+JcznHRF8/cZTvV/W/qvapWnjYh
         qpHJC8GSJZZMTarpKMHe7NyZ7vmyMZbGG0eS7cwUPDIUq5r2SS6Wm8yGh/GwYnwZLJNK
         TsH4He0f34k4ClxctwrHYtwWiybnYVsCdFvI337ixIfL6s9aNMuJmB8rCg+QzziEj3dP
         GDLzvm9OqwwTw3j9aOs6QMmu5y8t+EOqlICn1NKnBuWEwZlVor/xVWNAKcB1P1XeYZVP
         8CNQt50RzRav+wB/wFN+05qX4DpH2lsH7ljkVEq/2A3aJKO098qMejaA5vzFAuRYIdRf
         XMYQ==
X-Gm-Message-State: APjAAAXaMRqXLE9oCf1cmyh6s7e/T1sKUbt3FW8OJXSVfg1R15zkz8oe
        vITS4r/uB94hYy72cIuC/eY=
X-Google-Smtp-Source: APXvYqw5oqIN3kNbxen2N2WaJbgiUJVeoLB6oGTSGGKsYmWm10j7xnqRm6IXmnYRmJ/r7KvMacP/Yg==
X-Received: by 2002:a19:fc1d:: with SMTP id a29mr56713042lfi.35.1560728167128;
        Sun, 16 Jun 2019 16:36:07 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id q4sm2008377lje.99.2019.06.16.16.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 16:36:06 -0700 (PDT)
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
Subject: [PATCH v4 02/10] memory: tegra20-emc: Drop setting EMC rate to max on probe
Date:   Mon, 17 Jun 2019 02:35:43 +0300
Message-Id: <20190616233551.6838-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190616233551.6838-1-digetx@gmail.com>
References: <20190616233551.6838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The memory frequency scaling will be managed by tegra20-devfreq driver
and PM QoS once all the prerequisite patches will get upstreamed.
The parent clock is now managed by the clock driver and we also should
assume that PLLM rate can't be changed on some devices (Galaxy Tab 10.1
for example). Altogether there is no point in touching of clock's rate
from the EMC driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 45 ------------------------------
 1 file changed, 45 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 9ee5bef49e47..55ac3863a354 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -424,41 +424,6 @@ static int emc_setup_hw(struct tegra_emc *emc)
 	return 0;
 }
 
-static int emc_init(struct tegra_emc *emc, unsigned long rate)
-{
-	int err;
-
-	err = clk_set_parent(emc->emc_mux, emc->backup_clk);
-	if (err) {
-		dev_err(emc->dev,
-			"failed to reparent to backup source: %d\n", err);
-		return err;
-	}
-
-	err = clk_set_rate(emc->pll_m, rate);
-	if (err) {
-		dev_err(emc->dev,
-			"failed to change pll_m rate: %d\n", err);
-		return err;
-	}
-
-	err = clk_set_parent(emc->emc_mux, emc->pll_m);
-	if (err) {
-		dev_err(emc->dev,
-			"failed to reparent to pll_m: %d\n", err);
-		return err;
-	}
-
-	err = clk_set_rate(emc->clk, rate);
-	if (err) {
-		dev_err(emc->dev,
-			"failed to change emc rate: %d\n", err);
-		return err;
-	}
-
-	return 0;
-}
-
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -550,18 +515,8 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		goto put_backup;
 	}
 
-	/* set DRAM clock rate to maximum */
-	err = emc_init(emc, emc->timings[emc->num_timings - 1].rate);
-	if (err) {
-		dev_err(&pdev->dev, "failed to initialize EMC clock rate: %d\n",
-			err);
-		goto unreg_notifier;
-	}
-
 	return 0;
 
-unreg_notifier:
-	clk_notifier_unregister(emc->clk, &emc->clk_nb);
 put_backup:
 	clk_put(emc->backup_clk);
 put_pll_m:
-- 
2.22.0

