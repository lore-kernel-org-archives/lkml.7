Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE76C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0202089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JgZUOg8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbfG3STj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:19:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39174 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387657AbfG3SQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so26270148pfn.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sg4wSU/8+rFLjdOqagbmm9mBaQ6tPvbKk7HlconAyHo=;
        b=JgZUOg8qYcvYbTDYVkPR4sFOR+yrj18F5PUUihOWCPiewawroltAzZRVUxcSBA0glt
         KJNfJp0BBzeLL0QGNyDdK99B7h6NKKqJ19B2u4y6HmrVgjUlCuzx8HSt6ymFU8ko66Sa
         vO9XF6igf56bDY+K6ALfh9LYum5Qq+ZfjxVBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sg4wSU/8+rFLjdOqagbmm9mBaQ6tPvbKk7HlconAyHo=;
        b=O8Gu1L2X9yT3e47CJE3YaPXQR10xN71cimHT0QXtnilb63B+KfPTayrVd64IvIy0B9
         7lhX/pD7FBamzAfKaZGFrqLtdaUZvsXBm7IUe6RuGa5UZbTbqg10Yh6qNl+jwfg4er48
         qDt229Jm5xvABIL3t6tekhxVTDtJvWTtQy7tBtvKGfLglK7sbfwHoo9hm5lLuxB2gtze
         lG0I3owMlpzw3Ltyyz0hxJOhe0favUM/d02H0uS8KvDJUtzydCUVbnfQNiROaNhzix3N
         AxRk744dOFH9NAwTl8zvvzBmc7jeNTMY6RsrWpCqRNvPRFGxZcrKlbR0LrGycVFWr6ey
         ERBg==
X-Gm-Message-State: APjAAAXxWXRRc2COaWJhH4vT9Etq4wJtoPdm8RR5/JGcZQN6ccOouXXD
        1gPJF0cVYLTF5BD9oKaXBLIWXUZkEFY=
X-Google-Smtp-Source: APXvYqxwEU3/QrAPiqqLR8DEAL0upD1U9vqo0dtUUf81rKgMdbMrNKaZJGEtOGICMQWxEab1aTOoZw==
X-Received: by 2002:a17:90a:db52:: with SMTP id u18mr119323219pjx.107.1564510578978;
        Tue, 30 Jul 2019 11:16:18 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.16.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:16:18 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 24/57] mailbox: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 30 Jul 2019 11:15:24 -0700
Message-Id: <20190730181557.90391-25-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730181557.90391-1-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Please apply directly to subsystem trees

 drivers/mailbox/armada-37xx-rwtm-mailbox.c | 4 +---
 drivers/mailbox/platform_mhu.c             | 4 +---
 drivers/mailbox/stm32-ipcc.c               | 5 -----
 drivers/mailbox/zynqmp-ipi-mailbox.c       | 4 +---
 4 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/mailbox/armada-37xx-rwtm-mailbox.c b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
index 97f90e97a83c..b52eb09a7c7e 100644
--- a/drivers/mailbox/armada-37xx-rwtm-mailbox.c
+++ b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
@@ -165,10 +165,8 @@ static int armada_37xx_mbox_probe(struct platform_device *pdev)
 	}
 
 	mbox->irq = platform_get_irq(pdev, 0);
-	if (mbox->irq < 0) {
-		dev_err(&pdev->dev, "Cannot get irq\n");
+	if (mbox->irq < 0)
 		return mbox->irq;
-	}
 
 	mbox->dev = &pdev->dev;
 
diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index b6e34952246b..c3bb07d66b53 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -137,10 +137,8 @@ static int platform_mhu_probe(struct platform_device *pdev)
 	for (i = 0; i < MHU_CHANS; i++) {
 		mhu->chan[i].con_priv = &mhu->mlink[i];
 		mhu->mlink[i].irq = platform_get_irq(pdev, i);
-		if (mhu->mlink[i].irq < 0) {
-			dev_err(dev, "failed to get irq%d\n", i);
+		if (mhu->mlink[i].irq < 0)
 			return mhu->mlink[i].irq;
-		}
 		mhu->mlink[i].rx_reg = mhu->base + platform_mhu_reg[i];
 		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
 	}
diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 5c2d1e1f988b..43c27909d181 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -258,9 +258,6 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	for (i = 0; i < IPCC_IRQ_NUM; i++) {
 		ipcc->irqs[i] = platform_get_irq_byname(pdev, irq_name[i]);
 		if (ipcc->irqs[i] < 0) {
-			if (ipcc->irqs[i] != -EPROBE_DEFER)
-				dev_err(dev, "no IRQ specified %s\n",
-					irq_name[i]);
 			ret = ipcc->irqs[i];
 			goto err_clk;
 		}
@@ -284,8 +281,6 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "wakeup-source")) {
 		ipcc->wkp = platform_get_irq_byname(pdev, "wakeup");
 		if (ipcc->wkp < 0) {
-			if (ipcc->wkp != -EPROBE_DEFER)
-				dev_err(dev, "could not get wakeup IRQ\n");
 			ret = ipcc->wkp;
 			goto err_clk;
 		}
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 86887c9a349a..bb15f62bb72c 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -668,10 +668,8 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 
 	/* IPI IRQ */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "unable to find IPI IRQ.\n");
+	if (ret < 0)
 		goto free_mbox_dev;
-	}
 	pdata->irq = ret;
 	ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
 			       IRQF_SHARED, dev_name(dev), pdata);
-- 
Sent by a computer through tubes

