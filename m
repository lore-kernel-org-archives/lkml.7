Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFFAC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59D32075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 07:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avMpbdpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbfKKHfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 02:35:20 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36037 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfKKHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 02:35:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id k13so8934566pgh.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2019 23:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ILB8a88XETD+WUMe0JJMqsMts/FAHmPFp1FBBYuuKZE=;
        b=avMpbdpTTxTcZgMNsmHJriqYfjzppWrWU4fDAsp8ZdHzgQeCtuy8ra7ZPMS668QTzR
         cWJbYzjfn6TIqK5gseB7rSCq7pWrcV3K3E28XL1UdekndfoR4ZtB0IFBnxgTfI7xZqNe
         UcXlNCSIcb0waslZC2IAkZG/qgGlbz+Vq5taKIWhn2Y+RmX5g7Q+OH/NolpLeLLmC2z4
         H7MYHVj0XUS6/LlHrHEkRMZW2fWj5gMEOVbSPkTx4yjpO2dHcYxd4YGThqaEg9MhnDUr
         7+gh/Qba7laBgtfDeB9IcyI2hFYOhpzGuYpgyo1FD7qAbh8QaWMSCqYf+qkx1szCBpUK
         o4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ILB8a88XETD+WUMe0JJMqsMts/FAHmPFp1FBBYuuKZE=;
        b=WmPKSfsModdrh/RnGOD9kOyTpDzVKmS/8HtN+IHmmRd/iU2M7QKW6cwQ3furLXCXHQ
         qPq7n5lQNBYSjU1a2Ml+ytErAp8FsrVAqLfC35+lQxYzg1wSvzGP8lPUG5JQv8HWE89R
         Y26cCazfFV94B6xCWzVtI2VPVGpNocMk4/VjqrdPezLPbPo2ukNIrQnqWGRcliL51tGQ
         vz1N3Ja6ohV5gOQzCdN+EqKE+kNIDvaEb2NgncP9HTk7ufowNtVxbSfD9lmv4Sjc5kcQ
         L7U2bxI1Qma/Tjq35wRloNUPGwEkqdm8uHoBLPqzi7QqMmYyFGEwXoBuIndwJ58GBO/Z
         LrnA==
X-Gm-Message-State: APjAAAUxUaTxqz0n+py/PJiYoiwYfyt2G8zq3ZKvL99A/oUF/7I5xj4h
        SxpKCZgS/c2rdIrHb3M3xlGPow==
X-Google-Smtp-Source: APXvYqxSBofl1j/YBCPfdnNfgVPQXhBWmOdl4oqeqAsaXpFxE2X26BjMnVZoi7+ahvwv+hMwANMclg==
X-Received: by 2002:a62:e316:: with SMTP id g22mr28062398pfh.19.1573457718675;
        Sun, 10 Nov 2019 23:35:18 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id c184sm17345285pfc.159.2019.11.10.23.35.15
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Nov 2019 23:35:17 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] mmc: host: sdhci: Add request_done ops for struct sdhci_ops
Date:   Mon, 11 Nov 2019 15:33:58 +0800
Message-Id: <94603120e6431f0ce35af78935bfe7dddda4850b.1573456284.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1573456283.git.baolin.wang@linaro.org>
References: <cover.1573456283.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add request_done ops for struct sdhci_ops as a preparation in case some
host controllers have different method to complete one request, such as
supporting request completion of MMC software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
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

