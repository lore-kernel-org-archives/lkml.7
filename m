Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC211C4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC43720863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWwSgVO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbfIHKND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:13:03 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44100 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbfIHKM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id u14so9858648ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5zrGMk6c5cb0M1x8zsNcOkvdniWaOPlcPy4iCtlrTl4=;
        b=vWwSgVO5bQmVjTg9XGVOg1JwKfaGOeU5DoEK42mODEMxLoCclaYnnwIseOTMWWHbBh
         F3E4KzUNzR61+PXOwEw3flA+Ba9KM+Ar9b8d3f4yVvBGDDAcwTswppvM58oyvZ7YCW0+
         sapWoQ4VfTRnxTy4UlDX6vFaMZVB6CKJEBlbwurWDpM//fCXRUYZR20x1dAWfSw9S8il
         QAYYHXScDT82khZgpuDsorpbZJpiyHh8gI1vJk/HkVPEhj80wK1Y0w+xYR1peDezLF4/
         dAgMIj0+4xC3qZ0Sl93vDZ02RidwOj0tXOjC6NqKJ7ldmpoixvZ6UQcc/GYX6LILGu0X
         yXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5zrGMk6c5cb0M1x8zsNcOkvdniWaOPlcPy4iCtlrTl4=;
        b=T+3TvTt0tAe78J9P7B25pfr4RmVItONEzwWDabAbAoleBdMW+haVjMDonCyzhgdi95
         /y+88LfSNXbATYRosVZWxPNtEnb46Pu/pzNR4PPOir1SDgXh6r5ww6RRY03I96d+2p/0
         gy885w8+2Qz8dkCNECGcEg0v+1oGYPjZxcrcT8NNa58wrvrOP8NWuH89dYVdWLszUaQc
         7ogH+V4PA3LOYxVNT4lo3DXfJjDCgv96wntJUEzf0g9nqfJIoAiUY6u/UYQjg2LoFYki
         39Erw+P7ozKuJLGz0YGeu3C0zLO5uxYSuXNFMVpy3BNpqh37JbQSlYE/i7CYxVhF3KrS
         GTnQ==
X-Gm-Message-State: APjAAAVp+yTPGOaLM9CpGkgW8AuFAjNgQFUb2TBIe/3WH+n6Hw0X3UMK
        e/7P7ASl2cug7Xk7x8lE8evsmQ==
X-Google-Smtp-Source: APXvYqyFTCo8tbr+nsWc1VNOXSwNzLmkbiROCceBH4C65Lg3RihNh1XyaLzQ+MfTrmzCbU3uuFshKw==
X-Received: by 2002:a2e:874a:: with SMTP id q10mr11554083ljj.187.1567937575164;
        Sun, 08 Sep 2019 03:12:55 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] mmc: sdhci: Drop redundant code for SDIO IRQs
Date:   Sun,  8 Sep 2019 12:12:35 +0200
Message-Id: <20190908101236.2802-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nowadays sdhci prevents runtime suspend when SDIO IRQs are enabled.

However, some variants such as sdhci-esdhc-imx's, tries to allow runtime
suspend while having the SDIO IRQs enabled, but without supporting remote
wakeups. This support is a bit questionable, especially if the host device
have a PM domain attached that can be power gated, but more importantly,
the code have also become redundant (which was not the case when it was
introduced).

Rather than keeping the redundant code around, let's drop it and leave this
to be revisited later on.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 34 +++++++++++++-----------------
 drivers/mmc/host/sdhci.c           |  2 +-
 drivers/mmc/host/sdhci.h           |  5 -----
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 776a94216248..1c988d6a2433 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1666,12 +1666,10 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	if (!sdhci_sdio_irq_enabled(host)) {
-		imx_data->actual_clock = host->mmc->actual_clock;
-		esdhc_pltfm_set_clock(host, 0);
-		clk_disable_unprepare(imx_data->clk_per);
-		clk_disable_unprepare(imx_data->clk_ipg);
-	}
+	imx_data->actual_clock = host->mmc->actual_clock;
+	esdhc_pltfm_set_clock(host, 0);
+	clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_ipg);
 	clk_disable_unprepare(imx_data->clk_ahb);
 
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
@@ -1695,15 +1693,15 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	if (err)
 		goto remove_pm_qos_request;
 
-	if (!sdhci_sdio_irq_enabled(host)) {
-		err = clk_prepare_enable(imx_data->clk_per);
-		if (err)
-			goto disable_ahb_clk;
-		err = clk_prepare_enable(imx_data->clk_ipg);
-		if (err)
-			goto disable_per_clk;
-		esdhc_pltfm_set_clock(host, imx_data->actual_clock);
-	}
+	err = clk_prepare_enable(imx_data->clk_per);
+	if (err)
+		goto disable_ahb_clk;
+
+	err = clk_prepare_enable(imx_data->clk_ipg);
+	if (err)
+		goto disable_per_clk;
+
+	esdhc_pltfm_set_clock(host, imx_data->actual_clock);
 
 	err = sdhci_runtime_resume_host(host, 0);
 	if (err)
@@ -1715,11 +1713,9 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	return err;
 
 disable_ipg_clk:
-	if (!sdhci_sdio_irq_enabled(host))
-		clk_disable_unprepare(imx_data->clk_ipg);
+	clk_disable_unprepare(imx_data->clk_ipg);
 disable_per_clk:
-	if (!sdhci_sdio_irq_enabled(host))
-		clk_disable_unprepare(imx_data->clk_per);
+	clk_disable_unprepare(imx_data->clk_per);
 disable_ahb_clk:
 	clk_disable_unprepare(imx_data->clk_ahb);
 remove_pm_qos_request:
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index efa6cda8c991..4c4285387b47 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3048,7 +3048,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	spin_lock(&host->lock);
 
-	if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
+	if (host->runtime_suspended) {
 		spin_unlock(&host->lock);
 		return IRQ_NONE;
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index cf3d1ed91909..8effaac61c3a 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -753,11 +753,6 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
-static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
-{
-	return !!(host->flags & SDHCI_SDIO_IRQ_ENABLED);
-}
-
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
-- 
2.17.1

