Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF93CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3539D2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 05:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jzHW8+vI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbfJVF7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 01:59:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32995 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731015AbfJVF7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 01:59:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id c184so427027pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 22:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Q+dD7SDiYlVD6Sc0bdXrYVpCbKQT7CpksShngsf10n4=;
        b=jzHW8+vI149qZcAXl1BLh2d+7rAiaEf9Xsk0ubikjui60VmrzoYYeviqFT9nGhoNBV
         DFcjnknB1Yr6EiMvXFKQBPJwDG78HAl2Hs2UL76QRE0O5Fn0sKnJKO8mFXX0BTu7X2sA
         2EGMVMi3OKTTut6Z3KKELGJ/UhSIXu5aZeWzf6/maX+4mWezfiVUvJYxZDkkFzajFiyh
         QHjgK1XJNzHDw1xKeHJ8QjvCL5Qmn3382s8jl7uTEcKunf04VAfqM130s0y2Un/VVfxZ
         iQDT6ORcSeMA+m1LKNJM1yqy9zg+kKcBqAjr77lOT6B4Q8NbXBVjd2gOEaeWYcFUQ738
         WPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Q+dD7SDiYlVD6Sc0bdXrYVpCbKQT7CpksShngsf10n4=;
        b=L0EoYCLbxSCK+7RLnAlHwtE7OJW31VLlz+XWlcQl5wuJI+yWJiTNH4xIDw/XU9E8Gk
         PjUV9fB3YUutuMVB1GuL4Vp4Auk4dP1f8mOhazmMIvx7UAkeczj29J8zemDwG2EfAKTW
         CoQI+gUBDH2g1paw996gQwWT6Te8wJqzWaZx3kWVSEFyeDdVW8Xej7QjsfmHfZCVyfOW
         zYlKYDseI7+GtB4SrlgFFirEAqZrpelzzvaRotm8awf20EnVJoBzhYVrU+Ekuf3kuQPr
         DEkEcVMYBFGUGUfPINcDK+nJZOGiTHncNkOuCDy6nD2lO/cbGQ0YMSgYX0kAITFgGpoP
         Iz9Q==
X-Gm-Message-State: APjAAAXUN1P7WDh+yOnlP2O46oZ4Pz2pW1xRcYQDp4T0zehVQKmXdosm
        Vz3dB4AEJ/6P0frmV4PZ9FjaJQ==
X-Google-Smtp-Source: APXvYqxWqMoE7Zc5hBZAsKL+4NXEKEeXcoJ7Y9lVhAztGr2igC+ApnyhnAGtASxMu7pCbmtK4WZ8NQ==
X-Received: by 2002:aa7:980c:: with SMTP id e12mr713579pfl.165.1571723985443;
        Mon, 21 Oct 2019 22:59:45 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g35sm16568061pgg.42.2019.10.21.22.59.41
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 22:59:44 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Tue, 22 Oct 2019 13:58:56 +0800
Message-Id: <487c2e45810c6dc6485638474136e375cb567807.1571722391.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1571722391.git.baolin.wang@linaro.org>
References: <cover.1571722391.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1571722391.git.baolin.wang@linaro.org>
References: <cover.1571722391.git.baolin.wang@linaro.org>
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
index b056400..850241f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2729,7 +2729,10 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (host->ops->request_done)
+		host->ops->request_done(host, mrq);
+	else
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3157,7 +3160,12 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
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
index 0ed3e0e..d89cdb9 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -644,6 +644,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*request_done)(struct sdhci_host *host,
+				struct mmc_request *mrq);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.7.9.5

