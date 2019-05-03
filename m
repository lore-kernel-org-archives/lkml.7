Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767B6C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F142070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 23:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVNL4Rmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfECXI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 19:08:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55512 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbfECXI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 19:08:57 -0400
Received: by mail-it1-f196.google.com with SMTP id i131so11849341itf.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QeqabEEfnsVRAyqmyFyxoztJysc7TPg8bfbEZ78oTxA=;
        b=lVNL4RmfJZKLi0sXHoWB0HDeIU36Hun92ZTm1gaIv3a/hn8yUHNeb1anjJRs2WzX61
         RI8ZHB4Xj7/RWdy1KbtUgUl+cVa34QX19rvLdzwwp/B5YZ6yreXDo9o0JPlXHuuNGWSR
         CvrdLxy/ihclyFNmgP8Wno5zTDStKOFS5En78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QeqabEEfnsVRAyqmyFyxoztJysc7TPg8bfbEZ78oTxA=;
        b=pG5jAvaUfTT3/h/Mstaq8IBuJFdeFA7e/kbMOPqOx4ZqyJRcQJKD2rDUX4aoiFvPM6
         8ReeqykJATgjvZLHVNwMXv/zysYXIUtBTIy93BhD0ZiqpLBWZhwNBwqAFBi7XY1xxzWg
         fGhTr8kBf3NtnxG8iK3ZTM0Nw4Gr4pGlzgM80aWhboWGP09wiqLKB+thb2pVM2PF/2FR
         lCNXy3h6mlsNbYU6Rw7aHoRhc+g7soU0O5slxBwm1x8eH30lS0C/NZuIiR3hZK66IdQo
         k1ZhFY8CLcHSxI/ynf5/UFyPIMouLPatGzosrQxHsOxNOLBZugaFUWUF9BoxXQAuYa6S
         pr3A==
X-Gm-Message-State: APjAAAUf17kyh1y9psiE88TPUVSCP4u0zJHRn4g38Ex5i+/Tp3cDWgy7
        bBLZEkKIG7pxuywcv2xHc9sslYiS2Q0=
X-Google-Smtp-Source: APXvYqzfUS+c1Bpwi5YFNFDWGqQkReh77+gkt/bSuMVLyQGdKgtMKk04HAKFwT5TF/+CRrfY+QG9jA==
X-Received: by 2002:a02:c4c6:: with SMTP id h6mr9366013jaj.33.1556924936011;
        Fri, 03 May 2019 16:08:56 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:33ce:f5cf:f863:d3a6])
        by smtp.gmail.com with ESMTPSA id z4sm494975iop.8.2019.05.03.16.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 16:08:55 -0700 (PDT)
From:   Fletcher Woodruff <fletcherw@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Fletcher Woodruff <fletcherw@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Ben Zhang <benzh@chromium.org>
Subject: [PATCH v4 2/3] ASoC: rt5677: handle concurrent interrupts
Date:   Fri,  3 May 2019 17:07:50 -0600
Message-Id: <20190503230751.168403-3-fletcherw@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190503230751.168403-1-fletcherw@chromium.org>
References: <20190503230751.168403-1-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 899e07e30228a1..da27cbfaec2b74 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -5069,47 +5069,63 @@ static const struct rt5677_irq_desc rt5677_irq_descs[] = {
 static irqreturn_t rt5677_irq(int unused, void *data)
 {
 	struct rt5677_priv *rt5677 = data;
-	int ret = 0, i, reg_irq, virq;
+	int ret = 0, loop, i, reg_irq, virq;
 	bool irq_fired;
 
 	mutex_lock(&rt5677->irq_lock);
-	/* Read interrupt status */
-	ret = regmap_read(rt5677->regmap, RT5677_IRQ_CTRL1, &reg_irq);
-	if (ret) {
-		dev_err(rt5677->component->dev,
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
+			dev_err(rt5677->component->dev,
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
+			dev_err(rt5677->component->dev,
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
-		dev_err(rt5677->component->dev,
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
2.21.0.1020.gf2820cf01a-goog

