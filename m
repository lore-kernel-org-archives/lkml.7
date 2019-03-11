Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06069C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C633720643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oPbZSo/v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfCKHzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:55:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfCKHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:55:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id l11so3408242pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ft2UN5cLlD5VuHU5OgpRG9HuzgvY/xGUcyXH1HE1OW4=;
        b=oPbZSo/viIJe8sbM72giRyXtRCSg5/jyuo3Kgt6UcDWFCmTlLcQSzeim1B0yGzWluY
         qt39B2EiL8HZgQFQF+0EjJHHz12LZrMLavOhEW4pThlK8K9HV9L1Pth02YYcvlAzaWgr
         tEO/Eq82wKrEHXKBSfIR+w/zg4TF+KuQJfZFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ft2UN5cLlD5VuHU5OgpRG9HuzgvY/xGUcyXH1HE1OW4=;
        b=g/CL8liElNopGd1VtPFjs6T2Sdp0YmRa/cHpeXQzSfU9n9h0w4JBbZzOFF5oaaNtoW
         qyTos0Vn16j1rkdIOOWTluaAwvIM6Xv/KM7nwYb90YlpQTfquE7y5CZqMR1DThNFJIwE
         C0q1/LvNUaFxf/JEiyP7PlCkZDJPdTXYs7y9NJCfPk8EtMBz2tWAJW6vRt6gdiJjgYzU
         BlD9htri3WjJB6EXswO9LrFKF5Tk4+dgM32En6opr/9KezPu3qNcrKK0trOCbsB3IgRC
         BA8f/TKL+8YqWJrIJ/uP1b5Rk0mch4vH5i8r3d9SsmP+F0UdyJyWasu1u0LummBFBtVV
         72ig==
X-Gm-Message-State: APjAAAXiakFcHmrsfPtDIz8VG7U6LU9cGOTNLCJW1EzJR6Z3coAwfn4Z
        1163JU5vgqVfyKv3qM5biC01hw==
X-Google-Smtp-Source: APXvYqxQRedsJtxDZw+mhEF4kaD/iko7UVJ4HMEN7+v9kKKoVQwgNfBFtMb1CeCxxwNzewrDL9B8+g==
X-Received: by 2002:a17:902:284b:: with SMTP id e69mr31738471plb.11.1552290951066;
        Mon, 11 Mar 2019 00:55:51 -0700 (PDT)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id y7sm6534145pgf.42.2019.03.11.00.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:55:50 -0700 (PDT)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek RTC
        DRIVER),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek RTC
        DRIVER),
        linux-rtc@vger.kernel.org (open list:REAL TIME CLOCK (RTC) SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mfd: mt6397: Don't call irq_dispose_mapping.
Date:   Mon, 11 Mar 2019 15:55:40 +0800
Message-Id: <20190311075540.26117-1-pihsun@chromium.org>
X-Mailer: git-send-email 2.21.0.360.g471c308f928-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ mapping was changed to not being created in the rtc-mt6397
driver, so the irq_dispose_mapping is no longer needed.
Also the dev_id passed to free_irq should be the same as the last
argument passed to request_threaded_irq.
This prevents a "Trying to free already-free IRQ 274" warning when
unbinding the driver.

Fixes: e695d3a0b3b3 ("mfd: mt6397: Create irq mappings in mfd core driver")
Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>

---
 drivers/rtc/rtc-mt6397.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index e9a25ec4d434..c06cf5202e02 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -343,7 +343,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ: %d: %d\n",
 			rtc->irq, ret);
-		goto out_dispose_irq;
+		return ret;
 	}
 
 	device_init_wakeup(&pdev->dev, 1);
@@ -359,9 +359,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	return 0;
 
 out_free_irq:
-	free_irq(rtc->irq, rtc->rtc_dev);
-out_dispose_irq:
-	irq_dispose_mapping(rtc->irq);
+	free_irq(rtc->irq, rtc);
 	return ret;
 }
 
@@ -369,8 +367,7 @@ static int mtk_rtc_remove(struct platform_device *pdev)
 {
 	struct mt6397_rtc *rtc = platform_get_drvdata(pdev);
 
-	free_irq(rtc->irq, rtc->rtc_dev);
-	irq_dispose_mapping(rtc->irq);
+	free_irq(rtc->irq, rtc);
 
 	return 0;
 }
-- 
2.21.0.360.g471c308f928-goog

