Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE6FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478A022CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 21:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QHSaO6N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfH1Vqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 17:46:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33478 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfH1Vqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:46:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so639099pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 14:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMRVgNLfEWpj9ovY+tZTMFZ0giKQ7iTixMD9u9pTY5g=;
        b=QHSaO6N1MxmnkJMyGtKgOxaFY5l/j7VNF5hjzO5D6E4XZUPwlNRfJqVTohwXZeX4qB
         chCp93cIf1pb9alFldQg82rbRV08PjzibPT84disJENWbvr/Qil4fC2Fr9rLAfx2rX2C
         eQUVh6GYmMSJA9U9bQLhTKhsDrn0wwDyIKEGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VMRVgNLfEWpj9ovY+tZTMFZ0giKQ7iTixMD9u9pTY5g=;
        b=LQKGn93LpArNzg4flzm9UdQf9W1pSo2xK20Q3NXN/vo0n6g9R/fIMxA5BlJM9BMaxB
         NUSBbSu/SeAHgOYB4yvESnEdxC/XN5twPmy5zPrsvqdnG8L0zAnq2jHSiPXhry2Jw++0
         Zy4oir7YE9Ldi7eC3j+nBelhBWygV/MlydW3/uU56+u4E184OeUh7KPQA7K++9ycFDc2
         akcp1BfE4S8/Q4LOoUFzAepPmC6l7/TAnKtCSEqKc+h2qU7KS4zi7BMIUT4ccMTkeUWl
         Vdle5mnOudy/oKlqyufny/rogmcgPj2WVmiQJ7BG03Obc4XcZ5vbVfB6xm72qCniHJX/
         DsVQ==
X-Gm-Message-State: APjAAAVmuAJw/TNoizUmLesV9QNK2umCcNYh3LifHQKwsQA0HOcpPauI
        zC7inRAXrr8Bt98z56lfKiHMSc4hWcs=
X-Google-Smtp-Source: APXvYqxO+lvLRFTlHRNGooSNlV/N4475zrCkgNKWk9GVoYJXBdfQxRmh9ssT5WYDJEFzTTAl5fQ6OA==
X-Received: by 2002:a63:2b84:: with SMTP id r126mr5444915pgr.308.1567028789499;
        Wed, 28 Aug 2019 14:46:29 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id a4sm352975pfi.55.2019.08.28.14.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 14:46:29 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] mmc: sdio: Move code to get pending SDIO IRQs to a function
Date:   Wed, 28 Aug 2019 14:46:19 -0700
Message-Id: <20190828214620.66003-1-mka@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code to get pending SDIO interrupts from
process_sdio_pending_irqs() to a dedicated function.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/mmc/core/sdio_irq.c | 47 ++++++++++++++++++++++++-------------
 include/linux/mmc/host.h    |  1 +
 2 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 0bcc5e83bd1a..fedc49901efd 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -27,6 +27,35 @@
 #include "core.h"
 #include "card.h"
 
+int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
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
+EXPORT_SYMBOL_GPL(sdio_get_pending_irqs);
+
 static int process_sdio_pending_irqs(struct mmc_host *host)
 {
 	struct mmc_card *card = host->card;
@@ -49,23 +78,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
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
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4a351cb7f20f..7ce0e98e3dbd 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -502,6 +502,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
 }
 
 void sdio_signal_irq(struct mmc_host *host);
+int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending);
 
 #ifdef CONFIG_REGULATOR
 int mmc_regulator_set_ocr(struct mmc_host *mmc,
-- 
2.23.0.187.g17f5b7556c-goog

