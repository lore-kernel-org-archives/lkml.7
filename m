Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBFFC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B3C206BA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QawFVsyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDEUo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:44:28 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52544 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEUo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:44:28 -0400
Received: by mail-it1-f194.google.com with SMTP id x132so1332182itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dFa/9ivc6HEwS7NtOOcCuyDA7RF6EsHuQ/nOlCBBV4=;
        b=QawFVsyfgU9Gkppe5q5iwa/Qeczf6OJ5+jzBypifbopEYUtGhkt/OJhhjG7p1dHIgH
         xbDZjQ4d/yVyy+J4rsL7/AFp6lt7XoXbWseLF7cGAoxz+KDXEdHPGEZ53KqY1aPEkR4D
         Odo9lWFQS3+eL5nrHIBLhENtjuLIv0rA5gI1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dFa/9ivc6HEwS7NtOOcCuyDA7RF6EsHuQ/nOlCBBV4=;
        b=YJ0/6Ob2R9TpMd3fiWqLcL8cy9Ajx8PyfK9vZNigWFrAXFlb0gGV+Arit49g6jsLMb
         Eb8JV8khBQGW1ht45GAw4/I9sx4FfCzxt1gVZjkW+vQBCo9+vrJ8fUtjGLiUOiX/wmVx
         eHKagBnMc9m5EPDhlOj/hwAWT4AfB0jc+6tCCS0GDLD9vEcII4pK2InNWkwRClLoO+a4
         Jq2szuuAIY1Gvwl5jVrHJFnvHBD0Av/o3fp+GfqssT0ltabynRm5/ipxY6Zenfhy2TiD
         9iKfdSJhaw9kwvXe5C9vhaO7OdliZLQ76h+huj6OwoxOmz+yECJqOl/FwzmK6jpE+kJC
         P9FA==
X-Gm-Message-State: APjAAAXiR8qJ5VvigKudyMGjKIZyi0bsfJqtwa1OS2u5sgWyBvkHQy7i
        6An31epmC38UwkHT7OrQEGXyRZSRx3TY5Q==
X-Google-Smtp-Source: APXvYqwoTgOaLFfML6+EvH5EyrBBoinunPVnK6f5EW5rF+72qHLiEkEXtGSD3Qllkts4ZCLpH0/71Q==
X-Received: by 2002:a24:791:: with SMTP id f139mr10801627itf.73.1554497066677;
        Fri, 05 Apr 2019 13:44:26 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:70a8:812a:cdeb:6e0])
        by smtp.gmail.com with ESMTPSA id t2sm1604109itb.37.2019.04.05.13.44.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 13:44:25 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@google.com>, alsa-devel@alsa-project.org,
        Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v2 2/3] ASoC: rt5677: handle concurrent interrupts
Date:   Fri,  5 Apr 2019 14:42:56 -0600
Message-Id: <20190405204257.87095-3-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190405204257.87095-1-fletcherw@chromium.org>
References: <20190401205519.34023-2-fletcherw@chromium.org>
 <20190405204257.87095-1-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Zhang <benzh@chromium.org>

The rt5677 driver writes to the IRQ control register within the IRQ
handler in order to flip the polarity of the interrupts that have been
signalled.  If an interrupt fires in the interval between the
regmap_read and the regmap_write, it will not trigger a new call to
rt5677_irq.

Add a bounded loop to rt5677_irq that keeps checking interrupts until
none are seen, so that any interrupts that are signalled in that
interval are correctly handled.

Signed-off-by: Ben Zhang <benzh@chromium.org>
Signed-off-by: Fletcher Woodruff <fletcherw@chromium.org>
---
 sound/soc/codecs/rt5677.c | 84 +++++++++++++++++++++++----------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index ef50314ac61eb5..6bff0df53c6c6b 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5070,47 +5070,63 @@ static irqreturn_t rt5677_irq(int unused, void *data)
 {
 	struct i2c_client *i2c = data;
 	struct rt5677_priv *rt5677 = i2c_get_clientdata(i2c);
-	int ret = 0, i, reg_irq, virq;
+	int ret = 0, loop, i, reg_irq, virq;
 	bool irq_fired;
 
 	mutex_lock(&rt5677->irq_lock);
-	/* Read interrupt status */
-	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
-	if (ret) {
-		dev_err(&i2c->dev,
-			"Failed to read IRQ status: %d\n",
-			ret);
-		goto exit;
-	}
 	/*
-	 * Clear the interrupt by flipping the polarity of the
-	 * interrupt source lines that just fired
+	 * Loop to handle interrupts until the last i2c read shows no pending
+	 * irqs. The interrupt line is shared by multiple interrupt sources.
+	 * After the regmap_read() below, a new interrupt source line may
+	 * become high before the regmap_write() finishes, so there isn't a
+	 * rising edge on the shared interrupt line for the new interrupt. Thus,
+	 * the loop is needed to avoid missing irqs.
+	 *
+	 * A safeguard of 20 loops is used to avoid hanging in the irq handler
+	 * if there is something wrong with the interrupt status update. The
+	 * interrupt sources here are audio jack plug/unplug events which
+	 * shouldn't happen at a high frequency for a long period of time.
+	 * Empirically, more than 3 loops have never been seen.
 	 */
-	irq_fired = false;
-	for (i = 0; i < RT5677_IRQ_NUM; i++) {
-		if (reg_irq & rt5677_irq_descs[i].status_mask) {
-			reg_irq ^= rt5677_irq_descs[i].polarity_mask;
-			irq_fired = true;
+	for (loop = 0; loop < 20; loop++) {
+		/* Read interrupt status */
+		ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to read IRQ status: %d\n",
+				ret);
+			goto exit;
+		}
+		/*
+		 * Clear the interrupt by flipping the polarity of the
+		 * interrupt source lines that just fired
+		 */
+		irq_fired = false;
+		for (i = 0; i < RT5677_IRQ_NUM; i++) {
+			if (reg_irq & rt5677_irq_descs[i].status_mask) {
+				reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+				irq_fired = true;
+			}
+		}
+		if (!irq_fired)
+			goto exit;
+
+		ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"Failed to update IRQ status: %d\n",
+				ret);
+			goto exit;
 		}
-	}
-	if (!irq_fired)
-		goto exit;
-
-	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
-	if (ret) {
-		dev_err(&i2c->dev,
-			"Failed to update IRQ status: %d\n",
-			ret);
-		goto exit;
-	}
 
-	/* Process interrupts */
-	for (i = 0; i < RT5677_IRQ_NUM; i++) {
-		if ((reg_irq & rt5677_irq_descs[i].enable_mask) &&
-		    (reg_irq & rt5677_irq_descs[i].status_mask)) {
-			virq = irq_find_mapping(rt5677->domain, i);
-			if (virq)
-				handle_nested_irq(virq);
+		/* Process interrupts */
+		for (i = 0; i < RT5677_IRQ_NUM; i++) {
+			if ((reg_irq & rt5677_irq_descs[i].enable_mask) &&
+			    (reg_irq & rt5677_irq_descs[i].status_mask)) {
+				virq = irq_find_mapping(rt5677->domain, i);
+				if (virq)
+					handle_nested_irq(virq);
+			}
 		}
 	}
 exit:
-- 
2.21.0.392.gf8f6787159e-goog

