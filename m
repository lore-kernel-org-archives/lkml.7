Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F44C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB0423431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgIkoA6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbfICOXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:23:07 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38491 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfICOWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:44 -0400
Received: by mail-lf1-f68.google.com with SMTP id c12so13053280lfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNF5KDT4NEO2S6l4e9LzOtvZky1MgilMfLbdgvOUK14=;
        b=BgIkoA6S9HEs9gXOS1K2J8v1hct1nLo6iRbl+eWQRpwvWRAnL1gvf+6nlbSL6YQA3L
         YP0IzSVlJneAEtl8OLa9/CxAxpo1o1UsJgnOMYY2+Zi4BENlVOUxJ1C4U9RQXv43lRDA
         Mz84ak/0jeQjZANy0DnEaYTuPY760zFCzRlpLRpdw40SCH9Llqye34JP95vSzumbnnZS
         Zl2imszSl55QYmDXEmgLQ9Dg/rJzzHYX38Ck6g9OKS68zEeA4dAh3UGChi8gTj+nVrn9
         2zFV28zKr4MoIj3TQjSFs0sV4I1qy2pFogTq2GA7SqZOvrq66YCj9MZziPPTklnjOHlO
         Lb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bNF5KDT4NEO2S6l4e9LzOtvZky1MgilMfLbdgvOUK14=;
        b=PVFVxGGk6o3V7bJnv+9fz7dor9tDytukM3T7n+dlPho/tem45MnA1ge/D6nHHzD66h
         D4niqTJCXEO9nUS3lEsq1d9afKHF1hh6Bb9oY2w/UHPBJM2SgFbt5jsX6Cvynzfi2ug3
         qk1IZDUpsJpdgWIBW5thkB01iRAPb0t/uxjkpcj4HX6Y0dJVNSIZpLm9QOq8sJ8qaUxo
         JPzWE42UU8Fb2C4EbHjGfMRuEaQiL0IMIgFIkcZKmUPs7FNzxtTtlzNFoncFqjN01ujm
         RlBCEMMxGJv5SOSKuhRWIRli20RLH7e1M/c7bpPRUy1fTU+uDwc9d5pSFEDV3UADYFvR
         8Yvg==
X-Gm-Message-State: APjAAAWZfhKt+61pqcCX0I78XlX4nHGJZ5GCMCcyuN+8+yppWZ7QP2YV
        utj8DF8LGhWRXTCj80XE2Y5vsQ==
X-Google-Smtp-Source: APXvYqyEEebdpTgfyZ3xa8X0pagg//6S5aVso4T3Lot6sSeBRjWR2Wwn14JGYYaV9PjJ35e0VWgv9Q==
X-Received: by 2002:ac2:4c2f:: with SMTP id u15mr20191218lfq.174.1567520562816;
        Tue, 03 Sep 2019 07:22:42 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] mmc: core: WARN if SDIO IRQs are enabled for non-powered card in suspend
Date:   Tue,  3 Sep 2019 16:22:03 +0200
Message-Id: <20190903142207.5825-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make sure SDIO func drivers behaves correctly during system
suspend/resume, let add a WARN_ON in case the condition is a non-powered
SDIO card and there are some SDIO IRQs still being claimed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 8dd8fc32ecca..c557f1519b77 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -951,6 +951,8 @@ static int mmc_sdio_pre_suspend(struct mmc_host *host)
  */
 static int mmc_sdio_suspend(struct mmc_host *host)
 {
+	WARN_ON(host->sdio_irqs && !mmc_card_keep_power(host));
+
 	/* Prevent processing of SDIO IRQs in suspended state. */
 	mmc_card_set_suspended(host->card);
 	cancel_delayed_work_sync(&host->sdio_irq_work);
-- 
2.17.1

