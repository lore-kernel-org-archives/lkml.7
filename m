Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1323EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC60020674
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koXjMgIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfH1CTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:19:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41249 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1CTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:19:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id 196so620896pfz.8;
        Tue, 27 Aug 2019 19:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvauiPhaQuil5a/lgq9pLJLj9H2fEEfofNEEE+qo/n0=;
        b=koXjMgInvNSLYhu8DMojZRn/pcmTb/dhEu+TDB0KhpeTfJfsNS3Q1E41JRpCevnxCl
         3rSFJurAJueQh1J100MBpdm5GMNR6nblL1Ku0PXDqBjd71zwymkTiCAwWbWrY9kzgbLG
         yekLjW4NPi+qkbDSAP7VZr+79fTZdZd08mu3R7SRqNmFyt0fpcmdHxNJDGRDxYcTaWDn
         8yTt/GBIlTYj9s5wJu9VwC34SBB4ctQd1qvy3PLfgic4S50jpccsE4v39CdyJgLMjgaY
         ej+4KLlaFqWluD5i1aiAWF0LZxRR78fstE6NN6itLwprWt/2KPZCgVlDSYhSvhSFdggI
         1rbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvauiPhaQuil5a/lgq9pLJLj9H2fEEfofNEEE+qo/n0=;
        b=G8CtylKoQ4Ybsn3bT8Q/QyWLrErxg+fImr0iWDOJONc5Uy6A8dm83VKpRAzKMWZ19H
         D7sfb6NnBrFISL4DTih5lGCDd+PG9/6HOXyfLohxqtl9xTvU7ofXP6XIV3Fu0F+j3jHc
         mTfa/sxYdALFzho6h8DehlfjgGfWFVNzLPKoU8Te8RFvNYlerMsUM7QYWwI3njrUxIsM
         q9tpA7I4OqGIK/CpxtODiQKOjnBvTit6+t44kYDTlP3nJ6xINfMK2qdVI1f7GJ/5zpCG
         VtJa0N1ovULraGz0+Lh3Z9hstyGK/w3HYEZyOhAQT71spjGBRZJ/OyTlBDVTPxfNd7V7
         LTfg==
X-Gm-Message-State: APjAAAXxRSvCrx9IOAz40oLSWnG52XS3kkU4rsjJ1Ypl9thebKjHADbT
        LV0giHmx9fbp6+eb6pJeOEo=
X-Google-Smtp-Source: APXvYqyUIZuY2adi+UX0KwURRHb7u3HTHQDPf4pG4evmK6H8BAtT4AbUohCnMumYaGg0YwtwzIm8JQ==
X-Received: by 2002:a62:ee0a:: with SMTP id e10mr1923562pfi.197.1566958761279;
        Tue, 27 Aug 2019 19:19:21 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b18sm673249pfi.160.2019.08.27.19.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 19:19:20 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 4/5] mms: sdhci-sprd: add SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date:   Wed, 28 Aug 2019 10:17:35 +0800
Message-Id: <20190828021736.22049-5-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828021736.22049-1-zhang.lyra@gmail.com>
References: <20190828021736.22049-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

sprd's sd host controller doesn't support detection to
card insert or remove.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 27d0b57f3f89..1fecf055682c 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -508,7 +508,8 @@ static void sdhci_sprd_phy_param_parse(struct sdhci_sprd_host *sprd_host,
 }
 
 static const struct sdhci_pltfm_data sdhci_sprd_pdata = {
-	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
+	.quirks = SDHCI_QUIRK_BROKEN_CARD_DETECTION |
+		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
 	.quirks2 = SDHCI_QUIRK2_BROKEN_HS200 |
 		   SDHCI_QUIRK2_USE_32BIT_BLK_CNT |
 		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-- 
2.20.1

