Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4101C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC13020863
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 10:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQz6usR0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfIHKM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 06:12:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43282 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfIHKMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 06:12:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id d5so9880843lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pKTLA8BPyKLX9YHHuPwtPhpXH4h+0Jxv8uz/z0H2wn8=;
        b=IQz6usR0dVKguJznE5uwgQrDgBPq+1KDURHrwgj3B68bVWnvG2HpejbwXV9o6x03hg
         pyD2rFKEQDWaN6d7CyUM3W+CVs5ggKUaha1XE9GRYfAOzqxXfMBEVIZm8lk/DrYuUQnn
         K7l1WXgCWy6jJdGeZBSzs/1QfBLwMWj2atFZx/+W7lS9Xvdzrn5uMXDX9WHecRub2lvS
         ELZw9+sZ4PTrhnXh7MyZKGtpHyHieSHzeOS0SepU5vOln6djN8SVpBgfE7uFQUFvv2TD
         fr88VUn+pZjfn552rf6/wS00NR7kdexqpXWiL3uAZQcwUfAW5HmaY+1p0i6F2nBnxLPS
         RQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pKTLA8BPyKLX9YHHuPwtPhpXH4h+0Jxv8uz/z0H2wn8=;
        b=r8hjoB2xtnxOjdG9GG0oSGyMhSrWrA+YQz5szefDPCqzWikpq5hSdgmNh4qqgywNkq
         7WB9XytQNFnebpnirB8zWVNwO9kA6c6OrHGnA4u3e62IOgRsFllS+bTzzWp7NPH1jTsJ
         7A/CoinYIeUae2rFHKrk3jAT7puIThNJ7l+QcJeyIeNCwUQiYpW8LPL6Ow4QHMVCFykR
         ol+MaE5cDWMWN/GzMvpTegYx7pi6pXCYcdh9765IvPUC3j2WGiHVCIODecPzp9AIUCPF
         kf7J2UdgJ/HjlEIHbOI3rXFIlVakL+8HH1mjgye15spxUUxHErq81OL9/XKJ199zl2Ty
         pQWA==
X-Gm-Message-State: APjAAAVn9S5kEqXGZcmn+IzC3eTmxoNXJhwLi9M2KT2XXAsB/8PbXdtX
        BCXUxc4V+mtUksDSA2tJ+L+oQg==
X-Google-Smtp-Source: APXvYqzIBrVCzTFMAkkD8zaEddXTkXDJL2QuHMc/BkCaUp14332Xlp3p1Xir6bNKkkBPWLadqtU6RA==
X-Received: by 2002:a2e:958c:: with SMTP id w12mr11761091ljh.98.1567937568383;
        Sun, 08 Sep 2019 03:12:48 -0700 (PDT)
Received: from localhost.localdomain ([185.122.190.73])
        by smtp.gmail.com with ESMTPSA id h25sm2444849lfj.81.2019.09.08.03.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2019 03:12:47 -0700 (PDT)
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
Subject: [PATCH v2 05/11] mmc: core: Clarify sdio_irq_pending flag for MMC_CAP2_SDIO_IRQ_NOTHREAD
Date:   Sun,  8 Sep 2019 12:12:30 +0200
Message-Id: <20190908101236.2802-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190908101236.2802-1-ulf.hansson@linaro.org>
References: <20190908101236.2802-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdio_irq_pending flag is used to let host drivers indicate that it has
signaled an IRQ. If that is the case and we only have a single SDIO func
that have claimed an SDIO IRQ, our assumption is that we can avoid reading
the SDIO_CCCR_INTx register and just call the SDIO func irq handler
immediately. This makes sense, but the flag is set/cleared in a somewhat
messy order, let's fix that up according to below.

First, the flag is currently set in sdio_run_irqs(), which is executed as a
work that was scheduled from sdio_signal_irq(). To make it more implicit
that the host have signaled an IRQ, let's instead immediately set the flag
in sdio_signal_irq(). This also makes the behavior consistent with host
drivers that uses the legacy, mmc_signal_sdio_irq() API. This have no
functional impact, because we don't expect host drivers to call
sdio_signal_irq() until after the work (sdio_run_irqs()) have been executed
anyways.

Second, currently we never clears the flag when using the sdio_run_irqs()
work, but only when using the sdio_irq_thread(). Let make the behavior
consistent, by moving the flag to be cleared inside the common
process_sdio_pending_irqs() function. Additionally, tweak the behavior of
the flag slightly, by avoiding to clear it unless we processed the SDIO
IRQ. The purpose with this at this point, is to keep the information about
whether there have been an SDIO IRQ signaled by the host, so at system
resume we can decide to process it without reading the SDIO_CCCR_INTx
register.

Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Re-wrote changelog.

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

