Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76139C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472DB2085A
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSuXC+gg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfHKVBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 17:01:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36243 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbfHKVBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 17:01:31 -0400
Received: by mail-lj1-f195.google.com with SMTP id u15so1620517ljl.3;
        Sun, 11 Aug 2019 14:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZ3S4ko4rhzz11J2Xx7a4YmK+NWutFk+HFnNQWUEdvw=;
        b=ZSuXC+ggAGLm3qIRL6J8knol1yo+UQk8v+qMFTFD72y16yxoJ8NfJ5+7AU/R0uLhIP
         /nsxmsLnfTnV/cTjhDKrkuK16+oC70eZlgA2bsHWq1ket3ODZQoN9wVuhnZ32FFrYt7g
         NzfnHxI0wIO+EqIf4mDBjuOq7ImEebJYOQ42Iezcrg7UvP3KGENZVhLPyM60wM3wf+9v
         ErHbDvd7rcqjy0XBLuaeQpEx5fYEtm/j8KJWO3ZweIF3LXrIyS8+VAv6XjuE8qsuiW1f
         1/t7cCfxp4sWXUTg3sqArusgOHaRowPa1FHYItAnQa/XCVfizjX+mbTYP2S3BOFqt8Uq
         p4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ3S4ko4rhzz11J2Xx7a4YmK+NWutFk+HFnNQWUEdvw=;
        b=aSJ4NLgHaaKuHEw7Ulkw+sseGB71ntSnZK5R7FX+BmubCVMV7vgkLKRzHkTDOQQNyb
         bcQRnK3FStVldm9Ys95oRnZwVpDPhrPpQnyoXBOv+auSvMd0DGGcbTr42uIjgX5J8H8J
         9CCpGoQW3u7m7O7Vu844khrzQIOk0TZIcflIcDFd3BSDXBp5l2dutnDCh6eJDMmeutGY
         qvAWU0DUwPvMXh4TFKHSf/L4SIn2wq63hIetd+sFLIKWhkLeKRAZWag1291m10pUGHGD
         qvGCT23ulxs4x3TkPHZFX/OAQvk/gPWhQ8LGCgfGHIVhLqPH3uKQRPAo082rb9ERm4G0
         yxmg==
X-Gm-Message-State: APjAAAWyE4yp0APKF/jbnjFEqm4AI3jMx+H9Lu2wnx9B3PKJ7UfwbCgb
        kTuxyPsJjSpEpkFiN6sejiA=
X-Google-Smtp-Source: APXvYqwW3lJn0uoNnkDdyhdTnYEyWBH253wDY/5tkYrRr9rGI++mcJRxcGGVQepwdxoHGX260DeJuw==
X-Received: by 2002:a2e:96d0:: with SMTP id d16mr17528917ljj.14.1565557288640;
        Sun, 11 Aug 2019 14:01:28 -0700 (PDT)
Received: from localhost.localdomain ([94.29.34.218])
        by smtp.gmail.com with ESMTPSA id z25sm18708161lfi.51.2019.08.11.14.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 14:01:28 -0700 (PDT)
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
Subject: [PATCH v10 02/15] memory: tegra20-emc: Drop setting EMC rate to max on probe
Date:   Mon, 12 Aug 2019 00:00:30 +0300
Message-Id: <20190811210043.20122-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190811210043.20122-1-digetx@gmail.com>
References: <20190811210043.20122-1-digetx@gmail.com>
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

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20-emc.c | 78 +-----------------------------
 1 file changed, 1 insertion(+), 77 deletions(-)

diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 9ee5bef49e47..da8fa592b071 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -137,9 +137,6 @@ struct tegra_emc {
 	struct device *dev;
 	struct completion clk_handshake_complete;
 	struct notifier_block clk_nb;
-	struct clk *backup_clk;
-	struct clk *emc_mux;
-	struct clk *pll_m;
 	struct clk *clk;
 	void __iomem *regs;
 
@@ -424,41 +421,6 @@ static int emc_setup_hw(struct tegra_emc *emc)
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
@@ -522,52 +484,14 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	emc->pll_m = clk_get_sys(NULL, "pll_m");
-	if (IS_ERR(emc->pll_m)) {
-		err = PTR_ERR(emc->pll_m);
-		dev_err(&pdev->dev, "failed to get pll_m clock: %d\n", err);
-		return err;
-	}
-
-	emc->backup_clk = clk_get_sys(NULL, "pll_p");
-	if (IS_ERR(emc->backup_clk)) {
-		err = PTR_ERR(emc->backup_clk);
-		dev_err(&pdev->dev, "failed to get pll_p clock: %d\n", err);
-		goto put_pll_m;
-	}
-
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
 			err);
-		goto put_backup;
-	}
-
-	/* set DRAM clock rate to maximum */
-	err = emc_init(emc, emc->timings[emc->num_timings - 1].rate);
-	if (err) {
-		dev_err(&pdev->dev, "failed to initialize EMC clock rate: %d\n",
-			err);
-		goto unreg_notifier;
+		return err;
 	}
 
 	return 0;
-
-unreg_notifier:
-	clk_notifier_unregister(emc->clk, &emc->clk_nb);
-put_backup:
-	clk_put(emc->backup_clk);
-put_pll_m:
-	clk_put(emc->pll_m);
-
-	return err;
 }
 
 static const struct of_device_id tegra_emc_of_match[] = {
-- 
2.22.0

