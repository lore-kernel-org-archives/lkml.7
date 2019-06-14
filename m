Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D261C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D850F205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 18:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UGaMm1iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFNSnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 14:43:49 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37455 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbfFNSnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 14:43:47 -0400
Received: by mail-io1-f65.google.com with SMTP id e5so7997915iok.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 11:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NcPWD2owkf1HweY/dIY4noKl+ZyW2mZPzhEBgvasKUc=;
        b=UGaMm1iUAB4mUuqs1e4dbPz6CJBwDUR4zGk0Trc7KQuRwM5qfZf+hbNVUaRLDcpAhD
         YU46h9lS/Cmp89w5WWliKp4LIbcMUkfPu8NPVQ1F5F3EYefUwpXXw7UNI6ZKwvx3R7qe
         +7nIBfSREak7YtyyZMhXZMY6VamTElAjZYUuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NcPWD2owkf1HweY/dIY4noKl+ZyW2mZPzhEBgvasKUc=;
        b=CqM9VZZzFV//ZsZK0rSNF8GlNbkeGdJCb0+YMRiIXY136PDsTNmpnfgzT49HkIXv4A
         p/ncIQjqMRYbJnDIktWcmCYVoyPr2s4zEw0NIvpua+QMe+noCLXJiMajZfWJyKDVUDNV
         pBLeIboLN4/FGD+z/IJ5CHN45CIPJ05Hjv3dorculZEY3poo3VPOy6qGROJGxDmUrdnr
         4gRHx/bO9tLkrXjycYxSXC0cX85szYRO2rJMlC/J0RcnHAyKrbcQcTvXnHSQZ454Chwn
         qDZMmrHCdrxG/p7aCCTDUkwoESvgc+ATZ6yfkvC02KVTHc2kfyavM1lpV7w1AnfsLedA
         hqdA==
X-Gm-Message-State: APjAAAUAA8P+ebqPEOjSlMP9f2d/Of1D+VXO47AXaQk6MVUlsyFSSsPv
        B5vgrcgisA+nFKKGXndS2lrdWx4Bds8LRQ==
X-Google-Smtp-Source: APXvYqw4wZRxVZfzLkQbgyI4z/eUWgC5CfHW5OZWk8351Qq9bwf6z8TFzFTJy5ngkjU/X1i9tWCmKg==
X-Received: by 2002:a02:bb05:: with SMTP id y5mr65333545jan.93.1560537826328;
        Fri, 14 Jun 2019 11:43:46 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id c2sm2446577iok.53.2019.06.14.11.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 11:43:45 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Zhang <benzh@chromium.org>, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org,
        Fletcher Woodruff <fletcherw@chromium.org>
Subject: [PATCH v6 4/4] ASoC: rt5677: handle concurrent interrupts
Date:   Fri, 14 Jun 2019 12:43:15 -0600
Message-Id: <20190614184315.252945-5-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190614184315.252945-1-fletcherw@chromium.org>
References: <20190614184315.252945-1-fletcherw@chromium.org>
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
 sound/soc/codecs/rt5677.c | 67 ++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index a136ed0d82e36b..44d51b350b8860 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5071,38 +5071,55 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 static irqreturn_t rt5677_irq(int unused, void *data)
 {
 	struct rt5677_priv *rt5677 = data;
-	int ret = 0, i, reg_irq, virq;
+	int ret = 0, loop, i, reg_irq, virq;
 	bool irq_fired = false;
 
 	mutex_lock(&rt5677->irq_lock);
-	/* Read interrupt status */
-	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
-	if (ret) {
-		pr_err("rt5677: failed reading IRQ status: %d\n", ret);
-		goto exit;
-	}
 
-	for (i = 0; i < RT5677_IRQ_NUM; i++) {
-		if (reg_irq & rt5677_irq_descs[i].status_mask) {
-			irq_fired = true;
-			virq = irq_find_mapping(rt5677->domain, i);
-			if (virq)
-				handle_nested_irq(virq);
-
-			/* Clear the interrupt by flipping the polarity of the
-			 * interrupt source line that fired
-			 */
-			reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+	/*
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
+	 */
+	for (loop = 0; loop < 20; loop++) {
+		/* Read interrupt status */
+		ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
+		if (ret) {
+			pr_err("rt5677: failed reading IRQ status: %d\n", ret);
+			goto exit;
 		}
-	}
 
-	if (!irq_fired)
-		goto exit;
+		irq_fired = false;
+		for (i = 0; i < RT5677_IRQ_NUM; i++) {
+			if (reg_irq & rt5677_irq_descs[i].status_mask) {
+				irq_fired = true;
+				virq = irq_find_mapping(rt5677->domain, i);
+				if (virq)
+					handle_nested_irq(virq);
+
+				/* Clear the interrupt by flipping the polarity
+				 * of the interrupt source line that fired
+				 */
+				reg_irq ^= rt5677_irq_descs[i].polarity_mask;
+			}
+		}
+		if (!irq_fired)
+			goto exit;
 
-	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
-	if (ret) {
-		pr_err("rt5677: failed updating IRQ status: %d\n", ret);
-		goto exit;
+		ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
+		if (ret) {
+			pr_err("rt5677: failed updating IRQ status: %d\n", ret);
+			goto exit;
+		}
 	}
 exit:
 	mutex_unlock(&rt5677->irq_lock);
-- 
2.22.0.410.gd8fdbe21b5-goog

