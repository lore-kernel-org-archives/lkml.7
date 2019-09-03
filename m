Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BDEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEE62341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gglFd6MH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbfICOWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:22:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40577 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbfICOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so6693317ljw.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qvTZyKCFJI1bAINVcXhrb9dRTTR+BybSa6+sJhzvtc8=;
        b=gglFd6MHuNK4Z6tmxlxiATJyByVg6zIKFequidBHSYMo1U/EyW4mJcQ/Qbc121DWUy
         JpJI3+si6yMcp3K513RPrh5JbCRsdrWZ8UlklF1Hi7UMHF5ESSuAp1KWjTmWC5M3kZfL
         WD3op0jEdXCooG55ZxloSu23l8WhaHqYUB0tN/VBCrnzeJ7WvDK7YPq6qF6zTxf3Mfni
         Thd1J08Oj6+NO/dzVY+iXrF/1SV1BNI31yKV7JbJ4KPT19vqSBZk52efD5Fg4YKIEejZ
         7s5IRhfCKixC8qvEOXYiiawbrGJiokx1J1BkYheBOPlkZedbdnC1b1MVPc2kK2hrmmUD
         HHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qvTZyKCFJI1bAINVcXhrb9dRTTR+BybSa6+sJhzvtc8=;
        b=GFGyLZlX5eFfrTUNLfyyWPAzA+JxEshNsFqECJwhXkOTW/B6LIOQ1bvJkPhvPuSexz
         u8YMFORT7OiunGhr9hDWMU1hEb9CH9GHt+5zVU/P1jrQVpFyBFW7bCh7VCVoYx1KR62N
         NAmhJEZxVwnfUAOHCwqzccKmZTJK7ahNtsKGqPzey0/9Il86+1/RCCWkx5wDEPkMfq5m
         WIH9INsA7REjLZIiAQs4MfIc1jA046GcjXVPG9vR7HYwkclLtdSrYfaPzx6MMnmIlIXw
         e4hsllvP/6L/LCo+Ct39ofO3btDUnAZZjEsbVWnxPoKNEk/sR/WOMRNhdM9UlJFdoOKE
         utfA==
X-Gm-Message-State: APjAAAX6PY/bdcUX5OPoMxi5G/so8pI2ItzCSQtSMOkaSYcWo8cWWkCt
        x7tyN8uChwTNf4RfZfzM+U+a9A==
X-Google-Smtp-Source: APXvYqyc877+x8lrzt/YfDR3SsN0Br740tfMZzmjB6HUviT0AGI0ES80ASlAy2rNE449uMd0H8oSjA==
X-Received: by 2002:a2e:6586:: with SMTP id e6mr13751574ljf.115.1567520560114;
        Tue, 03 Sep 2019 07:22:40 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:39 -0700 (PDT)
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
Subject: [PATCH 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
Date:   Tue,  3 Sep 2019 16:22:01 +0200
Message-Id: <20190903142207.5825-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the single SDIO IRQ handler case, the sdio_irq_pending flag is used to
avoid reading the SDIO_CCCR_INTx register and instead immediately call the
SDIO func's >irq_handler() callback.

To clarify the use behind the flag for the MMC_CAP2_SDIO_IRQ_NOTHREAD case,
let's set the flag from inside sdio_signal_irq(), rather from
sdio_run_irqs(). Moreover, let's also reset the flag when the SDIO IRQ have
been properly processed.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index f75043266984..0962a4357d54 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -59,6 +59,7 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
 	int i, ret, count;
+	bool sdio_irq_pending = host->sdio_irq_pending;
 	unsigned char pending;
 	struct sdio_func *func;
 
@@ -66,13 +67,16 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	if (mmc_card_suspended(card))
 		return 0;
 
+	/* Clear the flag to indicate that we have processed the IRQ. */
+	host->sdio_irq_pending = false;
+
 	/*
 	 * Optimization, if there is only 1 function interrupt registered
 	 * and we know an IRQ was signaled then call irq handler directly.
 	 * Otherwise do the full probe.
 	 */
 	func = card->sdio_single_irq;
-	if (func && host->sdio_irq_pending) {
+	if (func && sdio_irq_pending) {
 		func->irq_handler(func);
 		return 1;
 	}
@@ -110,7 +114,6 @@ static void sdio_run_irqs(struct mmc_host *host)
 {
 	mmc_claim_host(host);
 	if (host->sdio_irqs) {
-		host->sdio_irq_pending = true;
 		process_sdio_pending_irqs(host);
 		if (host->ops->ack_sdio_irq)
 			host->ops->ack_sdio_irq(host);
@@ -128,6 +131,7 @@ void sdio_irq_work(struct work_struct *work)
 
 void sdio_signal_irq(struct mmc_host *host)
 {
+	host->sdio_irq_pending = true;
 	queue_delayed_work(system_wq, &host->sdio_irq_work, 0);
 }
 EXPORT_SYMBOL_GPL(sdio_signal_irq);
@@ -173,7 +177,6 @@ static int sdio_irq_thread(void *_host)
 		if (ret)
 			break;
 		ret = process_sdio_pending_irqs(host);
-		host->sdio_irq_pending = false;
 		mmc_release_host(host);
 
 		/*
-- 
2.17.1

