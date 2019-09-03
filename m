Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2D4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B563E2341F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cELaEzNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfICOWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:22:42 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46714 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729589AbfICOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:22:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so582326lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jh5yAZhoAj5RycS/TnID5yrHbMp2QKGAFD93Hw0bAOI=;
        b=cELaEzNikSOlmreYq+cxGTxRpffSojGMN41csSVqIGCzJKNrr/a7hyJZ1SLbsRfp9q
         TpymGj9OO6h9wE5NxjGDLLSXxMZrciULGZE/Uq12zZkxx64h+9Zbixi/10lgQN8iEjjb
         cwl5rNwuq4hziY7vSlAgWzQ9STjxeVV+o56PhVA5S6KfApTp0LM1Nsy/5QbDRfhCeDnb
         a2GFjq3E0Da9kDGLDMKInpKxhyaTS+yTbe5Ja/BRBnp3bh9jqXqisysukIUCNUer0Gvm
         M65mWyyyc4/+2nuttKsZ2TjFCbhLcPbkGqr+nS9ANXQndoauAkU+K3MpcuABubjSWSyL
         2haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Jh5yAZhoAj5RycS/TnID5yrHbMp2QKGAFD93Hw0bAOI=;
        b=c/EFKd3MpvLMnX0mriIHJXApRsKBlAf3W0xp7xcFG1e8xBoT5GD0/UcTuUyw779w8C
         gA1JNVhr61AR/DQ9KCfcaqv4U6Ch5+i5eE8OvphDnu2OeEKmFkKFX9qPhtoD3Mzi0JjD
         mRZQB5f+tslXVkA4yt3afv1P8ojY7ypBwNN/NrnrYmTpzEgrI1qmyaYHFn59vjO4i4C9
         usCy9EUpro0hOQLvQ3zOpwXj82LkEZ4c465jYjFsl0HDDdiGM1ELlW4I9x4awqC8D9P/
         sUtisJVur9J+DXJWx1T4a7k/eRBo3i8oxe/E2Hg/yXRRmKhoPjCogUZTRveH3tojUgnC
         KYtA==
X-Gm-Message-State: APjAAAXzOoZMnUDsH8TBD/a6l3bRLGjar63y82Z+B8KO1s541iq1dLSK
        xgcfwxnMbGXxlkb+7D6XvSdjcQ==
X-Google-Smtp-Source: APXvYqx500m4vzr+UFCeYKz2c0FMSfasvwBbVgJxSTzvqlZDtcVpzL2mXRCD90OhISPXEiSC4VxOew==
X-Received: by 2002:a19:c3d3:: with SMTP id t202mr21404817lff.48.1567520558740;
        Tue, 03 Sep 2019 07:22:38 -0700 (PDT)
Received: from uffe-XPS-13-9360.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id v10sm2430862ljc.64.2019.09.03.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 07:22:38 -0700 (PDT)
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
Subject: [PATCH 04/11] mmc: core: Move code to get pending SDIO IRQs to a function
Date:   Tue,  3 Sep 2019 16:22:00 +0200
Message-Id: <20190903142207.5825-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190903142207.5825-1-ulf.hansson@linaro.org>
References: <20190903142207.5825-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Kaehlcke <mka@chromium.org>

To improve code quality, let's move the code that gets pending SDIO IRQs
from process_sdio_pending_irqs() into a dedicated function.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
[Ulf: Converted function into static]
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/sdio_irq.c | 46 ++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0bcc5e83bd1a..f75043266984 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,34 @@
 #include "core.h"
 #include "card.h"
 
+static int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
+{
+	struct mmc_card *card = host->card;
+	int ret;
+
+	WARN_ON(!host->claimed);
+
+	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
+	if (ret) {
+		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
+		       mmc_card_id(card), ret);
+		return ret;
+	}
+
+	if (*pending && mmc_card_broken_irq_polling(card) &&
+	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
+		unsigned char dummy;
+
+		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
+		 * register with a Marvell SD8797 card. A dummy CMD52 read to
+		 * function 0 register 0xff can avoid this.
+		 */
+		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
+	}
+
+	return 0;
+}
+
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -49,23 +77,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 		return 1;
 	}
 
-	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
-	if (ret) {
-		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
-		       mmc_card_id(card), ret);
+	ret = sdio_get_pending_irqs(host, &pending);
+	if (ret)
 		return ret;
-	}
-
-	if (pending && mmc_card_broken_irq_polling(card) &&
-	    !(host->caps & MMC_CAP_SDIO_IRQ)) {
-		unsigned char dummy;
-
-		/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
-		 * register with a Marvell SD8797 card. A dummy CMD52 read to
-		 * function 0 register 0xff can avoid this.
-		 */
-		mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
-	}
 
 	count = 0;
 	for (i = 1; i <= 7; i++) {
-- 
2.17.1

