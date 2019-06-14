Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE04C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1499021841
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 19:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IcGT9d46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfFNTtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 15:49:12 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34472 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfFNTtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 15:49:10 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so8438949iot.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2019 12:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XggeDQFBfdb+3YPzkLYpmWXYVa5T1jw4aJqqW4WiNOA=;
        b=IcGT9d468pa+P0C/mZsnm+76M4esye5WR1AG3Fs9hpOA1WazPNvMyCaPZ3GV5rPiya
         2KtHsM/4gjym/ah4xhtbpliypu1e+PnUiCZaokJrszASKUXSrgbr/PvxzanFGEsmifBY
         s5ANW07qb8ca6ORspZf9tviVpZiVXhdNV5GMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XggeDQFBfdb+3YPzkLYpmWXYVa5T1jw4aJqqW4WiNOA=;
        b=M6Xb864SNm5zaq5rX9EvUqru9rlYUbyAvOP4HmnhBmVBDVxSG0I+rDjNMDOhXP/9SI
         qQUhQPnAXhAMb/T96qzkDM7dFDReYsxGx76KZfG92UPHO5EgdHnT14Ai4fPIS1mJT7gw
         4CMHPDUyIWcfSEIvtEvstZIFvIbqjImIXCSAylNS+kh6CaC4utSVa5dZ6XPUpd5448Wn
         LEJCk/vO3YrAZ5tQOtq6uYAVlEEmpn4NjqDNb9ItVwwrNdUJrYcHvm2i/U+dIQXnnmKp
         Cp0Dm1fzBoqhQa7z9Bqr5XBNZNNkTmRREYXh/aRouigCe76ayJrZ4VjcOCciL74iK48n
         ClyQ==
X-Gm-Message-State: APjAAAUqUSuIUCdYD3kyq4IKc9C5+dHD5g+WPqS9kyPchQhCFyxtdBnB
        RYEd0S5hohzevROOE+p8UgITNMl6t0Y0+A==
X-Google-Smtp-Source: APXvYqyE7eru/RE1iSZF7KO0qV8mLZ2lVU1qwdUdCbJMgemExUEXY/hklfZPRXfgsLUdwHut7+rSFw==
X-Received: by 2002:a02:a90a:: with SMTP id n10mr54237065jam.61.1560541748599;
        Fri, 14 Jun 2019 12:49:08 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id n17sm3128185iog.63.2019.06.14.12.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 12:49:08 -0700 (PDT)
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
Subject: [PATCH v7 4/4] ASoC: rt5677: handle concurrent interrupts
Date:   Fri, 14 Jun 2019 13:48:54 -0600
Message-Id: <20190614194854.208436-5-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190614194854.208436-1-fletcherw@chromium.org>
References: <20190614194854.208436-1-fletcherw@chromium.org>
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
index 87466ee222ee59..e88766e34ddb1d 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5072,38 +5072,55 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
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

