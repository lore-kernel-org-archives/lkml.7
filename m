Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10492C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EAE214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rGM6ZBGf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfH2Brk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:47:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43549 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbfH2Brj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:47:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so933285pfn.10;
        Wed, 28 Aug 2019 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+YooG/gsKARue5F8fzG4z9J/V6/qOmWpJ/qg5upQPNY=;
        b=rGM6ZBGf7AwZnk5UPwR+TBnQBE6gLM8LicPUp6R0WPMCA8ow5XKV/qfAqVpvGJqzoW
         RvGjaaUHRXI/TGLHQwsq8Q/UwRmQT9z9/Z9jx9KL1jtiT1HgFAjog9zz1WezWSDgeXuC
         uypfzLOitDum972jn5iprQTYNWRMB9z/onbXB32+2I5MMU9h2S3DwxHAd7QVc5hT7FrA
         A3J1C0+cbDIvg07iSYDJ9QSYhB6OZGZoiKu9ZE7doNxyuc2fKXFmkk0vWeF2ej2favaW
         Hrchu2Oo+feAm6LHnUL3KVbA07giWp7PGSm5h8Y6XPWsJkLEGr2L6FQgAjIIEvkHpiS7
         gQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+YooG/gsKARue5F8fzG4z9J/V6/qOmWpJ/qg5upQPNY=;
        b=DXFXrPY/bO0pl5J3G+HOWmw1WRQ2WbHJS9+omeR8nqBNznyLikU6Mv6L//BmLVyNY9
         gO6KRLjPMbXHv9EHMDTw9WPFduw65risIQQKIszSKWu1BXZsRGmEbZZLNf2bnbNldY5x
         dCgTzOo3OA/Ua2zd/d/2ibpzqfxEHmcXfKFt8zGWiKbCvfzUlk7HppJZCKZ+8d9rjuxN
         nc8wBXpi5mTiZm6YAtnXZQQUwsCvTCcYPfHUuYh23zjz5udGw7kWGtPwvixeFoBE6S7X
         jIZkZaC4mpJtP30gppUu6jl9AhS5iywEmxlyv4dyW1dLc/4etl4MJt49lbc6men89fWT
         lpyQ==
X-Gm-Message-State: APjAAAXJWlCA7L6teBuc6Yf8HPa9z++dSkQrgAS3oP4FKApJQ3w0BlI/
        P0FfIp7BAVK8udB8GWJT1nE=
X-Google-Smtp-Source: APXvYqww37NNUf1YQFta0iLgdg5TOPyxa4bK4Dk5DMSY7Z4rC6tU6owwNhWAmzypbTWu1mGlKeZnxg==
X-Received: by 2002:aa7:9533:: with SMTP id c19mr8186659pfp.153.1567043258491;
        Wed, 28 Aug 2019 18:47:38 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j10sm404548pjn.3.2019.08.28.18.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:47:37 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 5/5] mmc: sdhci-sprd: clear the UHS-I modes read from registers
Date:   Thu, 29 Aug 2019 09:46:45 +0800
Message-Id: <20190829014645.4479-6-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829014645.4479-1-zhang.lyra@gmail.com>
References: <20190829014645.4479-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller supports SDR50/SDR104/DDR50 though, the UHS-I
mode used by the specific card can be selected via devicetree only.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 1fecf055682c..d3c3e95676f0 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -509,7 +509,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
-		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
+		  SDHCI_QUIRK_MISSING_CAPS,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
@@ -614,6 +615,16 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 
 	sdhci_enable_v4_mode(host);
 
+	/*
+	 * Supply the existing CAPS, but clear the UHS-I modes. This
+	 * will allow these modes to be specified only by device
+	 * tree properties through mmc_of_parse().
+	 */
+	host->caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+	host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
+			 SDHCI_SUPPORT_DDR50);
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
-- 
2.20.1

