Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF18C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215902085A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 23:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4vvo+qD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfFRXqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 19:46:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39646 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfFRXqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 19:46:18 -0400
Received: by mail-io1-f66.google.com with SMTP id r185so27971575iod.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 16:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKEwL46yWPL513Bk6jjrSqur9SqEusEP9oaTL7362No=;
        b=f4vvo+qD8x2fS17YJXotuuQ0yNTjhcMiOueIOJlRYlw9HiFm8vCalF8qWjIgF2lNUG
         UhESAqKI6Pj6stOt+JtZBAH96G1I5lNF5SUl031KNK4CEoJWb0Z5MUWMnNSQQGMES91v
         z7IRyyr4MVfZJAOoyKDFyHlp/E5VNmZ5on+zk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKEwL46yWPL513Bk6jjrSqur9SqEusEP9oaTL7362No=;
        b=XN2VrBG/IUOjSaXfKrFUkGNJXNBiOAO/n7frBAPAbEbx8sUic5iYQIFl1QWhdKWJC/
         6oYfNorrr+RSXnJphaX6/k3lRvNoPfUcFDMwoE3s24U+hawwUkVLfEGSIg12mKalwhMf
         pRCQdzxMc39EdeLnYbMRZQvbAyBXk4VT/L27VPs1YpfWoXfX2+klxAD/hk36pnhu5wLt
         FLONkCrRWoBrrlBWtK2Gj4CJxKy9YT6vcJpaQdX6fk1HcuSmNiAv55s3iyUECHU5qTOV
         zVYcQIQRUFInTt6AEkP60iulBP2k7uAjehj4uc9d7XDc7LdFOXBlgU6fJ59IqJPFF/Sb
         9rfA==
X-Gm-Message-State: APjAAAVzTvm8H9NLsN0TnmQt7IBedguVXNOmmhsjUvvDX4aZqTmo47Dc
        /aHfYtKFS+TO/x73KQSuIlwLS4aITeDs6A==
X-Google-Smtp-Source: APXvYqx13C9/hn7Fy5h31GkaUYoCBYYER9eMuX2NvDi4V9J3XhxW+7gEdEMM35Z68BongnROuN5Ohw==
X-Received: by 2002:a02:16c5:: with SMTP id a188mr93076208jaa.86.1560901577294;
        Tue, 18 Jun 2019 16:46:17 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id p63sm19696117iof.45.2019.06.18.16.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 16:46:16 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ben Zhang <benzh@chromium.org>,
        Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@chromium.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH v8 2/2] ASoC: rt5677: handle concurrent interrupts
Date:   Tue, 18 Jun 2019 17:45:55 -0600
Message-Id: <20190618234555.188955-3-fletcherw@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190618234555.188955-1-fletcherw@chromium.org>
References: <20190618234555.188955-1-fletcherw@chromium.org>
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
 sound/soc/codecs/rt5677.c | 71 +++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index b5ae61ff87af13..202af7135f07a4 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5072,38 +5072,57 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
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
-		dev_err(rt5677->dev, "failed reading IRQ status: %d\n", ret);
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
+			dev_err(rt5677->dev, "failed reading IRQ status: %d\n",
+				ret);
+			goto exit;
 		}
-	}
 
-	if (!irq_fired)
-		goto exit;
-
-	ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
-	if (ret) {
-		dev_err(rt5677->dev, "failed updating IRQ status: %d\n", ret);
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
+
+		ret = regmap_write(rt5677->regmap, RT5677_IRQ_CTRL1, reg_irq);
+		if (ret) {
+			dev_err(rt5677->dev, "failed updating IRQ status: %d\n",
+				ret);
+			goto exit;
+		}
 	}
 exit:
 	mutex_unlock(&rt5677->irq_lock);
-- 
2.22.0.410.gd8fdbe21b5-goog

