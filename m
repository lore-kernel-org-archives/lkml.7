Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CBCC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 593652075C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 03:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uxSBN916"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404485AbfIFDxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 23:53:04 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42022 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404470AbfIFDw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 23:52:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id w22so3388704pfi.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=+Qa6FN4bybUWpL4Kw6U5VKtqicdkV7LDgiUgYM+LUYg=;
        b=uxSBN916hJwbA+vDDyLagwrLfwSaXLXvaXvT7/GTQRAnzOsCH+WDXs7QncMqgzLmyF
         y27gY2CoyiyQUPwpQGgqGY7xxPWrlVRjXUHMiTVZIVaFCFgroupu/GPS5I9tho3uYkVu
         YZnGJ1zDf3f2JB4R8y5x3qpb5Ych0HA5/0wGnDtMqlHI2Zi/It8lL+pKtNubEnu5BMId
         NDZh9X9bJctDYxCIRQIFR9QDuLO+3outSSYq4rk0LROg2ALEJ/zbABXB6DRIxE2S07tx
         Z2Bntybcl/W7gKM4knG+5bCVyOZ8yt4pODOwEfBvb9y0MB+8LqFcucZ3iK1w+Vzhknt7
         v/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=+Qa6FN4bybUWpL4Kw6U5VKtqicdkV7LDgiUgYM+LUYg=;
        b=MkgLOnH+y5rFaMTUamdba13TJ+oCshkennfyLcbPqJ4899HkGwMi7jIPgiK/TOy5Yr
         qSYQ8vOv/FMtPmVjriFpxLB6EXALVMTXbzHs7cmOZqSNwo2tsbDvG5TQ5pjuB46CW23W
         Ouwh3w86shcPvNF3SKw7ND9bKQfpCJmaS+96RAwiOakO2HbzRw0y4CQBhHKM6St/epTw
         yLrF/oS0LivSU0H3lp5Yjvtc6gJL/fYf3vz0r+GXaJWXk9EwxSEEbQd57vmIJMF3X6u2
         eKnvFif4GxLx1iaSoe18VhdsXyL7NhoVhBN6wBtjMvOxFvKWZkDsdzn63VXV+8MEr9Sj
         eauQ==
X-Gm-Message-State: APjAAAXWmz/qSLkEdRDbZg2uzcGWjwRbU/FUfC2al1pO5cV2O+DdveEi
        yc/VWMVgYFDhJrGXrhBwatN0+Q==
X-Google-Smtp-Source: APXvYqyp3IrbhUseZOadAuJ9eNKifK2EkmY8dSVlptCa+kQ7p2PqkkuEr7vYQE2iIP+uLJv8tOCWUA==
X-Received: by 2002:a63:4522:: with SMTP id s34mr6154076pga.362.1567741977816;
        Thu, 05 Sep 2019 20:52:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j7sm4205770pfi.96.2019.09.05.20.52.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Sep 2019 20:52:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        riteshh@codeaurora.org, asutoshd@codeaurora.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, vincent.guittot@linaro.org,
        baolin.wang@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] mmc: host: sdhci: Add virtual command queue support
Date:   Fri,  6 Sep 2019 11:52:02 +0800
Message-Id: <fc8a0fe513d244375013546c3c03967510feea4a.1567740135.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1567740135.git.baolin.wang@linaro.org>
References: <cover.1567740135.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add cqhci_virt_finalize_request() to help to complete a request
from virtual command queue.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/mmc/host/sdhci.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4e9ebc8..fb5983e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -32,6 +32,7 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
+#include "cqhci.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -2710,7 +2711,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
 
 	spin_unlock_irqrestore(&host->lock, flags);
 
-	mmc_request_done(host->mmc, mrq);
+	if (!cqhci_virt_finalize_request(host->mmc, mrq))
+		mmc_request_done(host->mmc, mrq);
 
 	return false;
 }
@@ -3133,7 +3135,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	/* Process mrqs ready for immediate completion */
 	for (i = 0; i < SDHCI_MAX_MRQS; i++) {
-		if (mrqs_done[i])
+		if (mrqs_done[i] &&
+		    !cqhci_virt_finalize_request(host->mmc, mrqs_done[i]))
 			mmc_request_done(host->mmc, mrqs_done[i]);
 	}
 
-- 
1.7.9.5

