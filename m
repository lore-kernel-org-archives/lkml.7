Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83ADC04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B04B62087B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 05:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="C7XFLkG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfEPFJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 01:09:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38861 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfEPFJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 01:09:45 -0400
Received: by mail-pl1-f194.google.com with SMTP id f97so990038plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 22:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=agOsn/FsJEMc+Zf/iAfFT/NhIk1MJBZxFX9gyrs1azc=;
        b=C7XFLkG1+645K/z9YPQ8jDojz6KnEEmXqDTB1ykI6sc64RJeJDUZR5J5OoM9qn9Gcy
         5XnW4jrY9Q0qnFQ6klWH7yLSifNUGdW58uS+728vWOTcXgvHgjaQwkRtDStMrRA9xPd1
         B0VW4LH2mHoLkJ9WKwhZ52YvjhnEhWzy7MhWcCZLQ55JLD9yzPtUhA+7tZRiVaMGrI4g
         5R0bkfsGDJhpPNha5vbqaPEETH2Qy9xfd9r0Z7CHpnMBVzAi+Uk9sC6+bxFR8O/9i65q
         1hBPlEJR7AXr9G4F0EayyPMxMdgdA2cWm/mg8TeAtRgA0Ez4/ArhdUhl+36/zuvoweD8
         petw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=agOsn/FsJEMc+Zf/iAfFT/NhIk1MJBZxFX9gyrs1azc=;
        b=Uj5LZr84Rfo/sLb/HzjJwjRXYnNoUWJIH4pwGvsGjBqR+j5/c/l80EB2t1rHj8yxTv
         jICyvHVCwF7o/mixGjpsknav4LFYWEEz5So8WG5Euq934Z0cRPFCbJYaJDU6AdQtio4k
         inmL51Dog/jfFCSztXgqQiTYTMHrebGPj60mTaYHcb0joodiY1YhwETG7BDlql3sLqY5
         v8xbplgB8+sQZQzuKcrVHa3nka0vX7bTMNPbtEdrc2cFIu+NZ+3QB846MCXTeDBOAwrC
         N6pyY4BmJkBMFMS3mkfYKBIw/erqWk1tXh36t5NLfh3XfHaql1D4xHqtbKrjHGdQQqeu
         OXXA==
X-Gm-Message-State: APjAAAUxmXzKrelcforWEi1/6TQQCVzrBz4MRzj2OVmh2434ORRy3XPk
        16hSVgxyAgtN2l+yZKYH9XCqBg==
X-Google-Smtp-Source: APXvYqyOeGqGHbyS1GYeHd3FsJ1ZgTt6oYeWr0jHKsYiJtZNEzr0IKux09yyFHVwkYQTcv7TjxWQsQ==
X-Received: by 2002:a17:902:2d:: with SMTP id 42mr48829831pla.34.1557983384320;
        Wed, 15 May 2019 22:09:44 -0700 (PDT)
Received: from buildserver-90.open-silicon.com ([114.143.65.226])
        by smtp.googlemail.com with ESMTPSA id u6sm5929531pfa.1.2019.05.15.22.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 May 2019 22:09:43 -0700 (PDT)
From:   Sagar Shrikant Kadam <sagar.kadam@sifive.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peter@korsgaard.com,
        andrew@lunn.ch, palmer@sifive.com, paul.walmsley@sifive.com,
        sagar.kadam@sifive.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] i2c-ocores: sifive: add polling mode workaround for FU540-C000 SoC
Date:   Thu, 16 May 2019 10:38:40 +0530
Message-Id: <1557983320-14461-4-git-send-email-sagar.kadam@sifive.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1557983320-14461-1-git-send-email-sagar.kadam@sifive.com>
References: <1557983320-14461-1-git-send-email-sagar.kadam@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c-ocore driver already has a polling mode interface.But it needs
a workaround for FU540 Chipset on HiFive unleashed board (RevA00).
There is an erratum in FU540 chip that prevents interrupt driven i2c
transfers from working, and also the I2C controller's interrupt bit
cannot be cleared if set, due to this the existing i2c polling mode
interface added in mainline earlier doesn't work, and CPU stall's
infinitely, when-ever i2c transfer is initiated.

Ref:previous polling mode support in mainline

	commit 69c8c0c0efa8 ("i2c: ocores: add polling interface")

The workaround / fix under OCORES_FLAG_BROKEN_IRQ is particularly for
FU540-COOO SoC.

Signed-off-by: Sagar Shrikant Kadam <sagar.kadam@sifive.com>
---
 drivers/i2c/busses/i2c-ocores.c | 34 ++++++++++++++++++++++++++++------
 1 file changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index aee1d86..00ee45c 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -27,6 +27,7 @@
 #include <linux/jiffies.h>
 
 #define OCORES_FLAG_POLL BIT(0)
+#define OCORES_FLAG_BROKEN_IRQ BIT(2) /* Broken IRQ in HiFive Unleashed */
 
 /*
  * 'process_lock' exists because ocores_process() and ocores_process_timeout()
@@ -239,9 +240,13 @@ static irqreturn_t ocores_isr(int irq, void *dev_id)
 	struct ocores_i2c *i2c = dev_id;
 	u8 stat = oc_getreg(i2c, OCI2C_STATUS);
 
-	if (!(stat & OCI2C_STAT_IF))
+	if (i2c->flags & OCORES_FLAG_BROKEN_IRQ) {
+		if (stat & OCI2C_STAT_IF)
+			if (!(stat & OCI2C_STAT_BUSY))
+				return IRQ_NONE;
+	} else if (!(stat & OCI2C_STAT_IF)) {
 		return IRQ_NONE;
-
+	}
 	ocores_process(i2c, stat);
 
 	return IRQ_HANDLED;
@@ -356,6 +361,11 @@ static void ocores_process_polling(struct ocores_i2c *i2c)
 		ret = ocores_isr(-1, i2c);
 		if (ret == IRQ_NONE)
 			break; /* all messages have been transferred */
+		else {
+			if (i2c->flags & OCORES_FLAG_BROKEN_IRQ)
+				if (i2c->state == STATE_DONE)
+					break;
+		}
 	}
 }
 
@@ -406,7 +416,7 @@ static int ocores_xfer(struct i2c_adapter *adap,
 {
 	struct ocores_i2c *i2c = i2c_get_adapdata(adap);
 
-	if (i2c->flags & OCORES_FLAG_POLL)
+	if ((i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ)))
 		return ocores_xfer_polling(adap, msgs, num);
 	return ocores_xfer_core(i2c, msgs, num, false);
 }
@@ -471,7 +481,7 @@ static u32 ocores_func(struct i2c_adapter *adap)
 	},
 	{
 		.compatible = "sifive,fu540-c000-i2c",
-		.data = (void *)TYPE_SIFIVE_REV0,
+		.data = (void *)(TYPE_SIFIVE_REV0 | OCORES_FLAG_BROKEN_IRQ),
 	},
 	{
 		.compatible = "sifive,i2c0",
@@ -601,6 +611,7 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 {
 	struct ocores_i2c *i2c;
 	struct ocores_i2c_platform_data *pdata;
+	const struct of_device_id *match;
 	struct resource *res;
 	int irq;
 	int ret;
@@ -682,13 +693,24 @@ static int ocores_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq == -ENXIO) {
-		i2c->flags |= OCORES_FLAG_POLL;
+		/*
+		 * Set a OCORES_FLAG_BROKEN_IRQ to enable workaround for
+		 * FU540-C000 SoC in polling mode interface of i2c-ocore driver.
+		 * Else enable default polling mode interface for SIFIVE/OCORE
+		 * device types.
+		 */
+		match = of_match_node(ocores_i2c_match, pdev->dev.of_node);
+		if (match && (long)match->data ==
+				(TYPE_SIFIVE_REV0 | OCORES_FLAG_BROKEN_IRQ))
+			i2c->flags |= OCORES_FLAG_BROKEN_IRQ;
+		else
+			i2c->flags |= OCORES_FLAG_POLL;
 	} else {
 		if (irq < 0)
 			return irq;
 	}
 
-	if (!(i2c->flags & OCORES_FLAG_POLL)) {
+	if (!(i2c->flags & (OCORES_FLAG_POLL | OCORES_FLAG_BROKEN_IRQ))) {
 		ret = devm_request_irq(&pdev->dev, irq, ocores_isr, 0,
 				       pdev->name, i2c);
 		if (ret) {
-- 
1.9.1

