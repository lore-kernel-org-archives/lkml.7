Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B59C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066AD216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z/WAxnfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfG3ST2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:19:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35704 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387955AbfG3SQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id u14so30283134pfn.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fbpk2s7H2NhsXYcDbyxtUWPUnqNFaLAZ6hWGV/UMfYo=;
        b=Z/WAxnflzzx/cj17xtwKv/0N6sqdLbhFwDQCPDwTbjlaOpB2Fita1uV2lCe0VjjV4e
         irCWA0HUy+xNn7sc6WGsWi0Hnv04vRo7Tt8VxoiIiCIJVy43NjTr6M8sUa85NXvuKR3K
         cgYanSLKnCzel9owRco26ayIdUl8QfZjsrWzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fbpk2s7H2NhsXYcDbyxtUWPUnqNFaLAZ6hWGV/UMfYo=;
        b=CrgMuJ1if+uL/3z3wlpTI+C1csP9KemgnNuO8Kjeu2zmr34zQ28MmVo7coUaTnP747
         Z89Qy1VbF+p+XcNQjXyY6aOO6ssf2PvRG9OO/w7j2npakMyHNpcMBvlUc/qz4Iwl9hPt
         BBkgab3XhBXvr1tidePia9D4X9b2gKLzjlrD442UVylsAfGFl9uVZNcxTH6QuKh8QYIl
         qQnxGC7O9CB8HPEpLKt4PGdP3yFfQNefCq6NW3oSmEGjFcLiO4RjCGnWNfU+T1xEilaz
         46yvogBpstKE6IT/lVyEqyVNvvOXwXsxAGl0lFjqwDmVwAvGt3almCudx3zvatxNR9ww
         zMLw==
X-Gm-Message-State: APjAAAX3xDASWU7IvQgXGIBI2fhMi8LviLyOg8Ixop7+EsNBNeW0InNa
        G7iP78y7zRJ8JcXi3+Yt0TxwHOGUHy8=
X-Google-Smtp-Source: APXvYqx6URRmwTwPGv5S9Q07u+CrsRPqtvcQEQqoMedFI1c1+86mILA8ffO5+zoZ4r/lUtj0wHTVAQ==
X-Received: by 2002:a63:f048:: with SMTP id s8mr81275036pgj.26.1564510582907;
        Tue, 30 Jul 2019 11:16:22 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:22 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 29/57] mmc: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:29 -0700
Message-Id: <20190730181557.90391-30-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/mmc/host/bcm2835.c       | 1 -
 drivers/mmc/host/jz4740_mmc.c    | 1 -
 drivers/mmc/host/meson-gx-mmc.c  | 1 -
 drivers/mmc/host/mxcmmc.c        | 4 +---
 drivers/mmc/host/s3cmci.c        | 1 -
 drivers/mmc/host/sdhci-msm.c     | 2 --
 drivers/mmc/host/sdhci-pltfm.c   | 1 -
 drivers/mmc/host/sdhci-s3c.c     | 4 +---
 drivers/mmc/host/sdhci_f_sdh30.c | 4 +---
 drivers/mmc/host/uniphier-sd.c   | 4 +---
 10 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 7e0d3a49c06d..e1b7757c48fe 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1409,7 +1409,6 @@ static int bcm2835_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(dev, "get IRQ failed\n");
 		ret = -EINVAL;
 		goto err;
 	}
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index ffdbfaadd3f2..672708543a11 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -969,7 +969,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = host->irq;
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
 		goto err_free_host;
 	}
 
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 037311db3551..e712315c7e8d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1091,7 +1091,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto free_host;
 	}
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 750604f7fac9..011b59a3602e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1010,10 +1010,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
 	if (!mmc)
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index ccc5f095775f..bce9c33bc4b5 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1614,7 +1614,6 @@ static int s3cmci_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto probe_iounmap;
 	}
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9cf14b359c14..b75c82d8d6c1 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1917,8 +1917,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	/* Setup IRQ for handling power/voltage tasks with PMIC */
 	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
 	if (msm_host->pwr_irq < 0) {
-		dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
-			msm_host->pwr_irq);
 		ret = msm_host->pwr_irq;
 		goto clk_disable;
 	}
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index d268b3b8850a..caf0ad5de604 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -131,7 +131,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number\n");
 		ret = irq;
 		goto err;
 	}
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8e4a8ba33f05..3d7fa948b4c3 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -490,10 +490,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq specified\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
 	if (IS_ERR(host)) {
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index e369cbf1ff02..f8b939e63e02 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -119,10 +119,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	u32 reg = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "%s: no irq specified\n", __func__);
+	if (irq < 0)
 		return irq;
-	}
 
 	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 49aad9a79c18..e09336f9166d 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -557,10 +557,8 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number");
+	if (irq < 0)
 		return irq;
-	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
-- 
Sent by a computer through tubes

