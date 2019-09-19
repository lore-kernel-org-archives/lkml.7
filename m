Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042BC4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83690218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 05:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zhv8Kx6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbfISF7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 01:59:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40682 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbfISF7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 01:59:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id w10so1228499pgj.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=zhv8Kx6vvUW/d7G+xYSAYrOmmvnaIbwd5gC9xnntdZLFNYJheYP9yad0XegrdSLaYV
         FtKxwxRKzxKYC4cFofV9qglatWamCIw3rEpnNjS0uryaWYo45+5Rw+d5lJxVCkVLJ5Wc
         2wXinXW/OoaLp01TuCXoSq2LscxafvxxPk2bS9f0KBg7u1JsG8aMPP10DhprooMDraD/
         4YzvzVdEFJ+kNxQWJxHZ+k1MGbvj7v5FQlxHVrroq49RsqSNgQYEtpOi0P13IKDJUzd7
         4Etzw54ergkoDmwiYVi9WpizuooEBTikcZPYopkAMZEHYgzlieRUZaJRucZFYHLFU2YB
         LaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+JBkSI5LCUYcNi8/zrQxcvj8pwF/Tq3geiwHLKhqOig=;
        b=qFF/5DBVpZdFecr1XuQfmKktG39rbNHcYc9a1/j1JggS7Ua63hKoUKyhHnAtVDLkub
         ORLUri9TVAM0gYRR3h2xxCSJihOUAQOStRDEbqE/GM32MCqG4WaWsLY0KGoF1g1A1M2H
         Q37uyLryf3lx2mgkOWcqH8y7KPvpG/TGakM74K+0Ra1rwO+W+4iMv6LNm4EFk43XX7Q0
         QNEclLZQa0ZVFE0o0DenDxP+RvfMKTajc+AH0hKVWpteT2ZmE2FJNhUgsqQDOb1Hfu95
         l4yCapk/RNVYa5LRqE5ACZOzKmg40Dcz2y7hs5P7dGOdp3T7vcvHLMQJnex01u4b5RPW
         G/HQ==
X-Gm-Message-State: APjAAAX1CrrSU4CZ5PX8W8r6srhHJeZfeq1Ysaf6iBTSNThAJW0Q9Rw3
        gOqrQj2WWebR7vmryQERjPnRwQ==
X-Google-Smtp-Source: APXvYqxdLkUiH/diHMsr4vp4ZRs5ubOYFJhyRIGXzQnn3NjsJUKcnzmVMxnsRlXvrREIPR/ZYLBTog==
X-Received: by 2002:a17:90a:1b46:: with SMTP id q64mr1858748pjq.76.1568872753745;
        Wed, 18 Sep 2019 22:59:13 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c127sm9666027pfb.5.2019.09.18.22.59.09
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Sep 2019 22:59:13 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Thu, 19 Sep 2019 13:58:46 +0800
Message-Id: <ae58746cc2a8cd1810662b189c11a237539ba2a8.1568864713.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1568864712.git.baolin.wang@linaro.org>
References: <cover.1568864712.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1568864712.git.baolin.wang@linaro.org>
References: <cover.1568864712.git.baolin.wang@linaro.org>
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

