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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D9FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979B322CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 01:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMfbYmXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfH2BrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 21:47:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45879 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfH2BrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 21:47:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id w26so927217pfq.12;
        Wed, 28 Aug 2019 18:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7wOWVtdgYba6/53ys0NFahWK28JeB5ybGeALkzArW8=;
        b=HMfbYmXrGhQlZrN+Dirv92vf0BKDbMHhEQvLcy6xcrHiI5GYD3Nd3ocunD6XJWO4tD
         WtoD4XgJrzo/FPZhZbWfR4zZjz41sx/HPX+dxRSKQbbeki5IRRFxYIYQL+UDn9/Oco1U
         zZ3H4FV9zGczGk//AKCnk0DuBw36LJO7t0CgDMoaWLH8wmZmLxOSut3qnrUevQP2ARmn
         iU22F8iK6bibUnJ4YddJ9/YHZU8TFb7QbLCrluZTTa/bIjjNxzpkD3EVN8SA/GSj9t3o
         v8fB3v5mSU+aT669LKNhtc4U80cnhcnoqd/Wf7PnURVycLRNF16Nexq1lAvkB1I43a0v
         JPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7wOWVtdgYba6/53ys0NFahWK28JeB5ybGeALkzArW8=;
        b=pKM+IsAQUb6b0rhZQyBeu06+IZPT4wOuwYGxvq/m3cZ1EeUm7pO21hn3EPQFWODLVl
         aXlfTQExfkxCnsB3uOtBoxbN4pZvjh+6FKKPbP75JqM/qerMd4mZgLT8eiYctNipT0t7
         pSaS41YK8zmMW+xm52RR5v3s7wqU1avmA+hJSErqTJW995VWOJKOvlndV33nnnZvMyMO
         t6y3e2uTzR9SylURoDDNka9Y4JmM5WNaoZcrlNeUsUM62bIwL17F5LRYopuIBm0NJ/eK
         yVsHZjnfGTEp/IHaC2no1wxsBlaPJMoGQ+irY/Ui/LAN8Fu/5AvbACHgzZaFdj9kURiP
         MpwA==
X-Gm-Message-State: APjAAAVCIgPbx3LH3Tre3AVuAb6rNdVWqdyYuNJBFiGnIKuXudOKC1gx
        VZFBEd6a2qT8FA9RxH0DMpE=
X-Google-Smtp-Source: APXvYqxJipM17YPzMwW+3SNGpQyE5L/9TRGBeccWoC20It9zh4vlAA7Pfqe6KQDBAt+MgBe2zhZYGA==
X-Received: by 2002:a65:504c:: with SMTP id k12mr6128625pgo.252.1567043233298;
        Wed, 28 Aug 2019 18:47:13 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j10sm404548pjn.3.2019.08.28.18.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 18:47:12 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [RESEND PATCH v2 1/5] mmc: sdhci-sprd: fixed incorrect clock divider
Date:   Thu, 29 Aug 2019 09:46:41 +0800
Message-Id: <20190829014645.4479-2-zhang.lyra@gmail.com>
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

The register SDHCI_CLOCK_CONTROL should be cleared before config clock
divider, otherwise the frequency configured maybe lower than we
expected.

Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>
Tested-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci-sprd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 6ee340a3fb3a..d5871865a1e9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -217,10 +217,11 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
 	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
 	u32 div, val, mask;
 
-	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
 
-	clk |= ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
-	sdhci_enable_clk(host, clk);
+	div = sdhci_sprd_calc_div(sprd_host->base_rate, clk);
+	div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
+	sdhci_enable_clk(host, div);
 
 	/* enable auto gate sdhc_enable_auto_gate */
 	val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
-- 
2.20.1

