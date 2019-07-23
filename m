Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753B7C76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5E32239F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 03:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA6sX1V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbfGWDOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 23:14:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41332 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729008AbfGWDOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 23:14:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so23337878lfa.8;
        Mon, 22 Jul 2019 20:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZ3S4ko4rhzz11J2Xx7a4YmK+NWutFk+HFnNQWUEdvw=;
        b=nA6sX1V8wJhvhoT0Zw6MYnqcXxb2JfKhrmhS47TPyj5nUrm36QfLeclbBsT0S4vSF5
         Skua+ogyxeLzntwaJrzFf1l5PJAhLIgtChQvp5gWITzMjp6QOjE7s4MRrrnYt9I/D43s
         BIkE/H1ED0V9/dZvvD5Kjvp+N4UXxWgs36Cpk9unLjAywy7nvJ/QmfHmg/1kOIrqS8UY
         MAdwNTMBRdBRl3OFvdsIuzYrKYdVFH/IYKHv7I0bAAWM4UX0H0gknWsTTj834spq8ryB
         E9JedidLPfxcuLPp/YEM7MMSIijawe1FJG3tviPJ/rlIchqYQsfIc7FlR5GmycOGrnkv
         7DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ3S4ko4rhzz11J2Xx7a4YmK+NWutFk+HFnNQWUEdvw=;
        b=kypaFaYf7NfaIBaRt768i8ZE/Q/pCM3SsJSR/pjvg/otB0zakfApuc9jFB+H81HJ3h
         iGnils+5gP6fRvF1pWxzs19b/73ilm+K5ExwN3v1JA7ctMhwBgj+JIYW9B+yLVkVno1M
         hGP9zzCT3CFK9srtR0nacWI2kPbeybS8mZJ7TehKX53b1wZ4+rAVeVNf8ZINoggnWW5A
         iYB3hZWrek2iNREK/q+irfDQHNMENJYGnOosUXcREi7WchQ+O467lRxpUAkn0BeCAyYi
         Hue6saKcgpIrhCgR5Af7mfIBn877ysd73UIvcvK82vn/IaJ6I/pgPeW1/ZfuWHeR15cV
         0uHQ==
X-Gm-Message-State: APjAAAVuyL0pu28U+lav87HMosSkNwCtoTAQjxT1VNs80bTtgfo23XeD
        NT1WDR7liU0/8y9yW7UWQvM=
X-Google-Smtp-Source: APXvYqy+iNTceUM9N8ilFt1ufgQl+3BVSIleVPyJ9h/p5kttQPuA2sr1ybD4QgoLxVv6/71rqmWw8A==
X-Received: by 2002:a19:8c08:: with SMTP id o8mr33403243lfd.57.1563851648890;
        Mon, 22 Jul 2019 20:14:08 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id u18sm6217184lfe.65.2019.07.22.20.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 20:14:08 -0700 (PDT)
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
Subject: [PATCH v8 02/15] memory: tegra20-emc: Drop setting EMC rate to max on probe
Date:   Tue, 23 Jul 2019 06:12:34 +0300
Message-Id: <20190723031247.31932-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723031247.31932-1-digetx@gmail.com>
References: <20190723031247.31932-1-digetx@gmail.com>
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

