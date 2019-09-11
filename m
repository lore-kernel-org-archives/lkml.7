Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4691C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973CC2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oOzx4iKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfIKNPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:15:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44881 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbfIKNPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:15:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so11489366pgl.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=oOzx4iKT8AsUYK46/eoTaeYiT1jKbTwBB3LS2rh+omq4KknlrU4boetTyKuqTe47Ng
         ZPC/cisMt6KXFjGBcEoB1CTYqWQgVbuIvRjjOAlr5bl67oH4qgVXAUdC5gr7KCji77jT
         FHX7s5pY2hRKvzUpmt517zPlFGsBxAJ6qSM3ctXCvqE8ACPgD815DrbbPV5v3DMVrizQ
         CVRuB0HlWCzGKCFXrs5ijPj5Lad2R1jJtcXW/RS1hvt6NfLprx02d8hSMwONiFF6N8pR
         nXUvjQzs6VqZZpFuhOiu9h42svKfP4fhMFInUfJp4TvjDqRvGr83IubmszUW4y7Rb2sl
         ns+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=BuDVAtuqiRG1ej2ru1OIn7J6ErZbF6AGbcI9YHnfT4/3ylJ8B6RIWdpOI7j8n+dJV9
         8pHvCW5mpZmAZs/fO3TS1vDagbXsxV0PM+KRVhWG4TCE/Uy3qo+SK6TdY2Wikubv2naM
         wRypw4HprhasosoJztgZaJ4/abZtjk/m7caSMKIZitckZ8507ea03hsufV30cDDhK9rL
         eyFxXAB8m2kZvU/YoQkhdjKIblaPBHYUfv9b3hIDc8l7zOfIh7PAcPiz1cnpILXlNqP9
         LBrEc4xksTCf5zmRtWeNZNJMFsSBTsJU2oWx23e5mSmLOJKBQqmK5IHKDYODgMCl55r7
         DX3w==
X-Gm-Message-State: APjAAAWpajo35ML9a50NjwoxYQGv7bE7baF2ghXtwjrTuspI3ZraAe9u
        BDGPVbBR6aBfFONuud4IvgCPiQ==
X-Google-Smtp-Source: APXvYqyz0f/JCciYHanh62R64szRSCDQjL2XiMkuzjgbIN/GVa48zSSdr2B/2dKutLtYsDeX8RodwQ==
X-Received: by 2002:a17:90a:aa0a:: with SMTP id k10mr5496801pjq.18.1568207716409;
        Wed, 11 Sep 2019 06:15:16 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id e21sm6420120pgr.43.2019.09.11.06.15.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 06:15:15 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Wed, 11 Sep 2019 21:14:42 +0800
Message-Id: <b1407f39cd8c73bca9d4e0eff05d5f5e18a78d27.1568206300.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568206300.git.baolin.wang@linaro.org>
References: <cover.1568206300.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add request_done ops for struct sdhci_ops as a preparation in case some
host controllers have different method to complete one request, such as
supporting request completion of MMC software queue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |   12 ++++++++++--
 drivers/mmc/host/sdhci.h |    2 ++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a5dc5aa..b2c8695 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2710,7 +2710,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3133,7 +3136,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	/* Process mrqs ready for immediate completion */
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
-		if (mrqs_done[i])
+		if (!mrqs_done[i])
+			continue;
+
+		if (host->ops->request_done)
+			host->ops->request_done(host, mrqs_done[i]);
+		else
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 902f855..e9a476f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -643,6 +643,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*request_done)(struct sdhci_host *host,
+				struct mmc_request *mrq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.9.5

