Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C8EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB862171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgRsZjif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfG3Q6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:58:15 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37447 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729490AbfG3Q6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:58:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so41488435wrr.4;
        Tue, 30 Jul 2019 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZZ3S4ko4rhzz11J2Xx7a4YmK+NWutFk+HFnNQWUEdvw=;
        b=RgRsZjifU+AtDp/WJqa2V9f3XX1BarEG+p2u/YDdf3MxDSZeZjp3Jl2n0BJqD4ToP+
         S880wNbLxJ3xKdRvTo2chq4vp2y/+ySj760Xtb+DIaLN2fTIwhbts9GjERs3zkdEV+fU
         DNjB0uCsDAZSJpDNASMv1D/IgW2L9R/3dcBjK5OrO8z9TLveUUSGBJuztHnj+j2Xyynm
         Yi5NIc27kB6N7f20DyRJZzUH0f7xs0f/449kS0jkqTBy6p5InU5VZMvzxcJhtpLAevmK
         S03M/5ojdBM3fdjl7uFsM0Ow8EPJmH9dFmc2IJ7UNwqlPQyKRvE8kQz+y3ixodR+NCD4
         Cnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZZ3S4ko4rhzz11J2Xx7a4YmK+NWutFk+HFnNQWUEdvw=;
        b=Pw5QKo8SZX6bHm1LCIoOyqrfeYkFjlHu8pjE5Ba12c85W+appEuuG8K0G+2rsCSZDy
         wNCdxBXidbhAunyM/BsfZUZ1rdND5HUMMBPGJ6LCCG4etdLUzsqNI6mbX+d8gAr5ff0p
         jfStuOjRhLZ8eQd0cvxIXXaEdf6fiZhypHzj9peuD5DFNfXAXRnTmkluQd+BEXqeR3TC
         aU2BcJF/q37A3vZsv/lykw/31hgkzV73K+0RO6SijW2rGjp+ZY5Xu2bI0uYxpC57S4EQ
         +YBjp6DekYwSHlKPs/+oEZr1Q0dDZ5bi7hZUnjAkLqoqPBBYmrtDG9DdqhTnyuP7qV4V
         5a+A==
X-Gm-Message-State: APjAAAWsywSW3k1M+3/rMmRv9YDWne8m43D/hl2rDs4lQLDzBtf7DzZi
        CH7Ou5GeXncjsDw06wz57hg=
X-Google-Smtp-Source: APXvYqxNA8YBJVeRScG5oJsuu2ZxTbOA9u94Olu8OH6WgDTGn3Yj1sU6075zduG9SGE+OXFJOMAF9g==
X-Received: by 2002:a5d:6144:: with SMTP id y4mr131080157wrt.84.1564505890839;
        Tue, 30 Jul 2019 09:58:10 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-220-99.pppoe.mtu-net.ru. [91.78.220.99])
        by smtp.gmail.com with ESMTPSA id r5sm70845040wmh.35.2019.07.30.09.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:58:10 -0700 (PDT)
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
Subject: [PATCH v9 02/15] memory: tegra20-emc: Drop setting EMC rate to max on probe
Date:   Tue, 30 Jul 2019 19:56:05 +0300
Message-Id: <20190730165618.10122-3-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730165618.10122-1-digetx@gmail.com>
References: <20190730165618.10122-1-digetx@gmail.com>
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

