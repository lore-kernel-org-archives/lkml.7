Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D42ACA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1BB20873
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 05:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8xCDqqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732208AbfJ2Foa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 01:44:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43777 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731877AbfJ2Fo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 01:44:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id 3so8714854pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=83cwCYPV9/yZeBbO6OKSaXzRco+5H2vE0myUuYv1K0w=;
        b=i8xCDqqFLqESmBlE8SMdB2SxgTpUiuigZdOv0dF6UhQTdT6DMVdtGscyfJylUALb7W
         7Zglap20Z8e2SmfrgB1wZd9azPS9aS8aBUBMQgynNmALQJXJt9W5INUkJqb9e4eSTV6p
         6fvxAv+stC2iqsbGAkPd/UF0U5dLDEvZg8Z6SQpSmjv4cdE08Lu1wm+9XYhImDV05vRC
         8dTOovwOTr11L8O+L05/HFmwtCnH8qactHO4IAAZO+qqTmXg0vMqFoldW1WA5uwmwbDG
         yKNDBvCPKO+GcALdGc/IOmyoB1yDDWuB7jPWsJAv7vTM6y7RTMiDlWHFe9uu7imtI5Yw
         P4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=83cwCYPV9/yZeBbO6OKSaXzRco+5H2vE0myUuYv1K0w=;
        b=aFG4i4DwwL89QLHXJcNGJGB1WMnQU9c0ATynTB8+Zymj3iXrluJryDSGbxE4yLQ9d6
         pZLQviTvlJuV/44RlSIQV508YtpLD9givDicZr5wHqC40UBlbhXamvbcONrZoIFEjPVj
         SXVRlZk4cSyCFLbH9ITXoR10K51bv00kzhgBNQEfy6DDFfYSXhJK5F42UAeU2VE3LdUa
         rsXW5zlaxxMXCS28SRnTRF4oicwYg4nzz43r06wm9YiU/TTzLTwc19WSKrjohLPS257L
         bHfs6WIOkFUj2Zki/56l17BBVNfO3zxuD2p8QTGMi/R8uQ0VE7Pq4bAJbuQnV3OjW27n
         xaeg==
X-Gm-Message-State: APjAAAXionrZ3qreL0N//kAsfWLuBVoa3nY/9ob8rrv/NqBtzZYZ35uN
        gj+U6mAwcYBMY40iOzprBoT+GA==
X-Google-Smtp-Source: APXvYqzlVTtjMkZYH884apun00NdfUZQrmTCJsGS4o8nNnHmnNLJAZrYIxHbcnoD93W1IKCzNLqzCA==
X-Received: by 2002:a63:1a46:: with SMTP id a6mr24146910pgm.3.1572327868852;
        Mon, 28 Oct 2019 22:44:28 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j25sm12026231pfi.113.2019.10.28.22.44.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 28 Oct 2019 22:44:28 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, baolin.wang7@gmail.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] mmc: host: sdhci: Add a variable to defer to complete data requests if needed
Date:   Tue, 29 Oct 2019 13:43:22 +0800
Message-Id: <19910a2f34b9be81f64637a5a5fc8d07bd5f4885.1572326519.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1572326519.git.baolin.wang@linaro.org>
References: <cover.1572326519.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the host software queue, it will trigger the next request in
irq handler without a context switch. But the sdhci_request() can not be
called in interrupt context when using host software queue for some host
drivers, due to the get_cd() ops can be sleepable.

But for some host drivers, such as Spreadtrum host driver, the card is
nonremovable, so the get_cd() ops is not sleepable, which means we can
complete the data request and trigger the next request in irq handler
to remove the context switch for the Spreadtrum host driver.

Thus we still need introduce a variable in struct sdhci_host to indicate
that we will always to defer to complete data requests if the sdhci_request()
can not be called in interrupt context for some host drivers, when using
the host software queue.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    2 +-
 drivers/mmc/host/sdhci.h |    1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 850241f..9cf2130 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3035,7 +3035,7 @@ static inline bool sdhci_defer_done(struct sdhci_host *host,
 {
 	struct mmc_data *data = mrq->data;
 
-	return host->pending_reset ||
+	return host->pending_reset || (host->always_defer_done && data) ||
 	       ((host->flags & SDHCI_REQ_USE_DMA) && data &&
 		data->host_cookie == COOKIE_MAPPED);
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d89cdb9..38fbd18 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -533,6 +533,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool always_defer_done;	/* Always defer to complete data requests */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
-- 
1.7.9.5

