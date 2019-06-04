Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CCEC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BE22461E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+2GCVHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfFDIPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:15:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43596 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfFDIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:15:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so2929706plb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=FdrxifC9VKJDfmhJlZCtT+SJXQU8nyEdMzYOjCE23wE=;
        b=O+2GCVHo8+jdVe0br2gCJmuVnoyN4ac5Q7dhggvalzYPiUr+vQUkbbNC7rkfnG/DMc
         Po9EnLA2txYJNYbCrgFTev4bagodznF/DhZ9ndevRxjnCflMa2CwWoR1iVBRqmrNGZhr
         6ajDgOfmCMYdyDcsNoyNSHvDeqsSB9N7tBPXRUpbID/7kXrqXOAlXM6/ujiDUcHeJ1Na
         Cl2K8MyOB4vbDBYM0Cg/SoLMUchkU1OA+KdEsjrCfciLpldwdMyZVr/j/L9QG5gSdY64
         bnykp/4rdv3o9rQoqFm+Y7Mzq++0RgDOJOy74UVZSB378K3GAr+Sh03UEiXRAIYzVGUE
         iGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=FdrxifC9VKJDfmhJlZCtT+SJXQU8nyEdMzYOjCE23wE=;
        b=IcJtSdOnnBQbGAqMVj3gkT3VU79FOiINrL36mnKXwON8iFsKs8v8zwnfXoKEwP1OkC
         kYpy/X0GQQtM0CAQZWaaq9f8jMrTVWkZQeViLGfyaXJOVBPZaSREr775ZUjF5tZP656L
         6RrK4wgi9hgk9K+1n84bPw3K0pDrmrRij3eGVOGu9k51auc+RJ0TrbtAR5WYla1BOtd0
         mGGAOh+yCcTwktM9TfP/Zt/nwjkctj9bw4rPtlinP1dCCjHTO+TskP/56ckJ9YI+mgjw
         aOQQ+QBS+VDrNYYZYesQKcFInZnxnuEl0m4GbddLtYaRaFyWUlMhqplP4KNQOBX0QKf2
         aYAg==
X-Gm-Message-State: APjAAAWHlg/wYpb/2WHK97cb2egnQxEE6sst1VeOFjvqIwoej5r7Ph3s
        YfPumqsPHKK+h6YBxOR5H6AtHg==
X-Google-Smtp-Source: APXvYqz2jjWsddPWnn+pjc0wk/Ss7eehLdPZxkHhdASSNlIhF2ImTI/Mu4NCkGO5CgDpbsuTkVMbEQ==
X-Received: by 2002:a17:902:7e0e:: with SMTP id b14mr9660980plm.257.1559636102504;
        Tue, 04 Jun 2019 01:15:02 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j4sm14818804pgc.56.2019.06.04.01.14.58
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Jun 2019 01:15:02 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        zhang.lyra@gmail.com, orsonzhai@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, olof@lixom.net
Cc:     baolin.wang@linaro.org, vincent.guittot@linaro.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/9] mmc: sdhci-sprd: Add optional gate clock support
Date:   Tue,  4 Jun 2019 16:14:23 +0800
Message-Id: <3bd7f5b0d4c78b75f8c4067a34f79396b4fd0a5c.1559635435.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1559635435.git.baolin.wang@linaro.org>
References: <cover.1559635435.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the Spreadtrum SC9860 platform, we should enable another gate clock
'2x_enable' to make the SD host controller work well.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-sprd.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index e741491..31ba7d6 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -60,6 +60,7 @@ struct sdhci_sprd_host {
 	u32 version;
 	struct clk *clk_sdio;
 	struct clk *clk_enable;
+	struct clk *clk_2x_enable;
 	u32 base_rate;
 	int flags; /* backup of host attribute */
 };
@@ -364,6 +365,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	}
 	sprd_host->clk_enable = clk;
 
+	clk = devm_clk_get(&pdev->dev, "2x_enable");
+	if (!IS_ERR(clk))
+		sprd_host->clk_2x_enable = clk;
+
 	ret = clk_prepare_enable(sprd_host->clk_sdio);
 	if (ret)
 		goto pltfm_free;
@@ -372,6 +377,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	if (ret)
 		goto clk_disable;
 
+	ret = clk_prepare_enable(sprd_host->clk_2x_enable);
+	if (ret)
+		goto clk_disable2;
+
 	sdhci_sprd_init_config(host);
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	sprd_host->version = ((host->version & SDHCI_VENDOR_VER_MASK) >>
@@ -408,6 +417,9 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 
+	clk_disable_unprepare(sprd_host->clk_2x_enable);
+
+clk_disable2:
 	clk_disable_unprepare(sprd_host->clk_enable);
 
 clk_disable:
@@ -427,6 +439,7 @@ static int sdhci_sprd_remove(struct platform_device *pdev)
 	mmc_remove_host(mmc);
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
+	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
 	mmc_free_host(mmc);
 
@@ -449,6 +462,7 @@ static int sdhci_sprd_runtime_suspend(struct device *dev)
 
 	clk_disable_unprepare(sprd_host->clk_sdio);
 	clk_disable_unprepare(sprd_host->clk_enable);
+	clk_disable_unprepare(sprd_host->clk_2x_enable);
 
 	return 0;
 }
@@ -459,19 +473,28 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	int ret;
 
-	ret = clk_prepare_enable(sprd_host->clk_enable);
+	ret = clk_prepare_enable(sprd_host->clk_2x_enable);
 	if (ret)
 		return ret;
 
+	ret = clk_prepare_enable(sprd_host->clk_enable);
+	if (ret)
+		goto clk_2x_disable;
+
 	ret = clk_prepare_enable(sprd_host->clk_sdio);
-	if (ret) {
-		clk_disable_unprepare(sprd_host->clk_enable);
-		return ret;
-	}
+	if (ret)
+		goto clk_disable;
 
 	sdhci_runtime_resume_host(host);
-
 	return 0;
+
+clk_disable:
+	clk_disable_unprepare(sprd_host->clk_enable);
+
+clk_2x_disable:
+	clk_disable_unprepare(sprd_host->clk_2x_enable);
+
+	return ret;
 }
 #endif
 
-- 
1.7.9.5

