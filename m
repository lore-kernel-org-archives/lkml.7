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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E2DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36C20674
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 02:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vGjpTBI9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfH1CTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 22:19:15 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38656 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfH1CTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 22:19:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id w11so458533plp.5;
        Tue, 27 Aug 2019 19:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ag2oeSq7LlUabUjjwsXIHv9EeRugJjpLVjP7xd4IfII=;
        b=vGjpTBI99+vFH/CweJjGTgiqLm7dbQZcUO2JhnFP4XpB0RtSSqInnioOASo6bAHEvU
         tnTKzGRb0gMinkE4yQunzmwf/iJldQD94fYkCRb0V1oNTkXG9SdxHrLEjbLPTJYGQ2OQ
         zz+W4cbJlg/VujLdGLoMCnTiDqH94y8wGt0xmIzFvbDn6vZ2FTKzj84I2hR6v6eRcm42
         sWuN9xj85+cYRn7L+6jUdUYxe2L/xI5/MmQnRUFGZa0ag1k1mcHRN607yix3BcCm0AEu
         Pub2GAlZAghxq1s5y0sabzgxxxQTTNvgZ8Yy8A6n2kgdakN5oxbEMQu2Nj6E2N3NU0aB
         YXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ag2oeSq7LlUabUjjwsXIHv9EeRugJjpLVjP7xd4IfII=;
        b=PJUkzDvRSKPrCu7lm5jqlE9C249HdZO3usi6+kGzGhZj5tboeKzzTBnNfo9ueHTv5q
         TCVf1f8pSb/iSoXeNPDVsqHc+I6ZIUO6q7jf5Lod3Vv7O3PXiAqO+gBKEt7GR0rqznmD
         AnP9URr6MGRAcKkWHU0D+V5VSV7wdHBxNWdLNLrLxIqz7zlc6He4mocgBdFGaHpuLRWF
         06wG9PR0JKs1pa1bRCldYsRv9AjAsNfJcwm64LYb/EDcbgn0YeW1+CZYTVh8QtP/kYjE
         7w1I+fZj3glSu+hlwFAca0j3GGho00HaIDe4dA2cVtVkp1JX0tCJaZIKMMfLvGvTDcNo
         Lzag==
X-Gm-Message-State: APjAAAW+k+MdiCKCbiFG3ZFyVTBFP71F2LzkaJtkSroZgx0cUhMzUmWu
        iQjqm8ayvHg8MNztnmNYoUM=
X-Google-Smtp-Source: APXvYqxiRym4HP7N+/l+KtGvDJMkIgCbCuj3JQJthlbSDeCZd2OIrSduZ9e/JEK7bQlLNG95fVu4ow==
X-Received: by 2002:a17:902:e83:: with SMTP id 3mr1850096plx.319.1566958754723;
        Tue, 27 Aug 2019 19:19:14 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id b18sm673249pfi.160.2019.08.27.19.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 19:19:14 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 2/5] mmc: sdhci-sprd: add get_ro hook function
Date:   Wed, 28 Aug 2019 10:17:33 +0800
Message-Id: <20190828021736.22049-3-zhang.lyra@gmail.com>
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

sprd's sd host controller doesn't support write protect to sd card.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host
controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index d5871865a1e9..90cb2af91159 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -374,6 +374,11 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
 	return 1 << 31;
 }
 
+static unsigned int sdhci_sprd_get_ro(struct sdhci_host *host)
+{
+	return 0;
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
@@ -386,6 +391,7 @@ static struct sdhci_ops sdhci_sprd_ops = {
 	.set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
 	.hw_reset = sdhci_sprd_hw_reset,
 	.get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
+	.get_ro = sdhci_sprd_get_ro,
 };
 
 static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
-- 
2.20.1

