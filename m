Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21B6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E62520843
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xbMqCO6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfDWJCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:02:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39192 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfDWJCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:02:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id a9so1578396wrp.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VS6sWtIBcpW++wv0mYIjcVLqIR7LghrNYUg8/Ta7WWE=;
        b=xbMqCO6zj/632iEPHiWSPhZGMBKBsDiZrQeirlU04yPkWiApOm24k7zLVyG5N1k4ZS
         fRf30jGYSKoSdVluBAAxFRnrxdV1uMkUIBU9ZIlhwO2NPoKtjJOBE3/L2tp34JpdjWTu
         uCQaT5k/IM10+QaOAd/NEVTX+lTW9dI8CMNXUPv6AecORRQres0ZqV6wz7G4tdiU8N8X
         M+FxI87l3FQXlJdI8UvEkd3dSwBOCoPsKBLbbqZmobuUT8Qqn2SHZEjYsV9HXy49HzGq
         1i4rmkfEokMShkmMUvIf4jkscOg9xyIImE3i+kurOVotZf3Qwu5sPLb907IzKSLd5JDt
         RBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VS6sWtIBcpW++wv0mYIjcVLqIR7LghrNYUg8/Ta7WWE=;
        b=NNsTUIjsPwphr0CzQN0KkZbjklzuqMofYNR2omovvaaOWDvty8PXdVCVK6R/5lmw2n
         1TfRWXjWshKWYqFq1IiRbEpZkq4rydnrUI/fOE3uCeft5PuK7u5oT7xGUJ5oUxS/Lv9n
         P7aSl9lE24rB4m17fejIghPf7nikdy5TWDqxyKnZPjVuXW+FlDYBKaK2p3WLkvESdoyX
         Og+y1WN374O0nZskUWwPP/1s+Zi4AxINekqCvsH0QMomIei3FEJRAYum8EN44jW0D2CO
         SdoZCVn9lcTiMkvLvWK7/Mjaq4/aMwAqwT7oh6NmaAGUXsnirOLfgldyjODVbf/vG2vp
         0qVA==
X-Gm-Message-State: APjAAAVnZmuddhycYIGQyHr13hhKWJfGRtaX9T+NAAhv6YqD7EWaKBqQ
        fJHkUWKJyZfsv3qpCutAc1mFuQ==
X-Google-Smtp-Source: APXvYqx291aocUxzzWbLRxtrvn///4nfCCUgX6RRRyBi0FRPwZ0/0Vn+i4JlIb15XtkLkI2qr76qUw==
X-Received: by 2002:a5d:6604:: with SMTP id n4mr13301965wru.42.1556010165874;
        Tue, 23 Apr 2019 02:02:45 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z23sm12361894wma.0.2019.04.23.02.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 02:02:45 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/7] mmc: meson-gx: remove open coded read with timeout
Date:   Tue, 23 Apr 2019 11:02:29 +0200
Message-Id: <20190423090235.17244-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423090235.17244-1-jbrunet@baylibre.com>
References: <20190423090235.17244-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a function available to poll a register until a
condition is met. Let's use it instead of open coding it.

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2eba507790e4..2deeacc051b1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -23,6 +23,7 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/iopoll.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ioport.h>
@@ -1100,7 +1101,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 static int meson_mmc_wait_desc_stop(struct meson_host *host)
 {
-	int loop;
 	u32 status;
 
 	/*
@@ -1110,20 +1110,10 @@ static int meson_mmc_wait_desc_stop(struct meson_host *host)
 	 * If we don't confirm the descriptor is stopped, it might raise new
 	 * IRQs after we have called mmc_request_done() which is bad.
 	 */
-	for (loop = 50; loop; loop--) {
-		status = readl(host->regs + SD_EMMC_STATUS);
-		if (status & (STATUS_BUSY | STATUS_DESC_BUSY))
-			udelay(100);
-		else
-			break;
-	}
 
-	if (status & (STATUS_BUSY | STATUS_DESC_BUSY)) {
-		dev_err(host->dev, "Timed out waiting for host to stop\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
+	return readl_poll_timeout(host->regs + SD_EMMC_STATUS, status,
+				  !(status & (STATUS_BUSY | STATUS_DESC_BUSY)),
+				  100, 5000);
 }
 
 static irqreturn_t meson_mmc_irq_thread(int irq, void *dev_id)
-- 
2.20.1

