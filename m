Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D4DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DC8217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="0CMRmUqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbfDQUom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:44:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41601 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbfDQUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:44:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so75149wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=85XK5dFLbNA8+J3uTS62n225ZxyTN5YNEbzJYjOQJYI=;
        b=0CMRmUqUZL8eSuaFv8AWE1G/Dp+AJmyE7FjzasQPPO9lvMFXPShi0mRIG1wXHdypkM
         2PHmFlVq9WLs4XzMlfrDM85jmBZN/ZcbQHpa0mVMeB288npUX7nVLUgOep3v84uu66r7
         l8gVwuFIrhHSszYeWTKEYpmJL7UiFALMeLRCJSsoNt3JCG7amlTJ2V5qlyfaOkh4KtZP
         hA2F48yKHTxOCLrQ1g6TJpMXV9QyYPSnHc82vsby+KO+MY8gNv3PjWAgwKNtRF9s+l3A
         udy9ymOe1se5x2gt5aG5gTK4D4oFUIlZ12a8im8LC/o7Jw2J/mKa2AVsgmnJlFyWicx6
         VP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=85XK5dFLbNA8+J3uTS62n225ZxyTN5YNEbzJYjOQJYI=;
        b=jIfpiSJOxji/+ZERaek5kwifVEH8B7beYkrt/5AOP84mU1VTpMo3KmsZxEDh4HXUEl
         sv2JK8jWBOHc59vVTnSzxnIF+Ld7cXcayFS0wHB/2+1aFeiV5lGGvvBGTNyQcU26BAAw
         UBycfdaOnMGD+MCZEDq3M0TRAasdFm3513uC9yoXWLCqmCGdclMksbNoLNIjCtvI+TVz
         QrwWurIJYnHAMX7yXENAhsOC86axGZr2l7iZ2akEpin8qJ2zLEyODkbSCtRxofZH8BFE
         TNBP2JSy6VmBEVMhESW7usQsKMqC56N8uTvEsjlO74dCnvUhSM3YRoe32Vp2cPjyRptB
         tWzA==
X-Gm-Message-State: APjAAAVoiNJsOph49yvsWdByB9zzUtXh4B+fb5WNCcBr6J7VuknKqEDY
        oQtM8awaU6hzfuiwECgDCJgZoP5xoac=
X-Google-Smtp-Source: APXvYqxcJ09qdX7h+qjEtcqrrRChogD9+j4GpR2dyrrqyeNgu1adXMaIhDaHeetTkTmJHa9deYTH8w==
X-Received: by 2002:adf:f102:: with SMTP id r2mr42879784wro.136.1555533847319;
        Wed, 17 Apr 2019 13:44:07 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id c20sm98716866wre.28.2019.04.17.13.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 13:44:06 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] mmc: meson-gx: remove open coded read with timeout
Date:   Wed, 17 Apr 2019 22:43:49 +0200
Message-Id: <20190417204355.469-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190417204355.469-1-jbrunet@baylibre.com>
References: <20190417204355.469-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is already a function available to poll a register until a
condition is met. Let's use it instead of open coding it.

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

