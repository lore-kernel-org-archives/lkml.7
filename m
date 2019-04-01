Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D05C2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pNusP/cK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731559AbfDAR6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:58:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39204 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfDAR6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:58:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so382354wmk.4;
        Mon, 01 Apr 2019 10:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pPeKlSug6FmM3MV9fECsotZs7maoQ1cummrLUWibeCY=;
        b=pNusP/cKIaeO5Q/DtT644uMd+FpsNyGf/fm0rpTltdyxvSieh5878fQ9dYOBUQHAE8
         Q7QZ3jFd0DLuCpmv0T9x3j7ie+JqoV74QwERzySM6SazHHu8etV7fdTNmOqBsGDoWNoG
         WXj/9ol9eTsbyMFJr4Usy913VQzbuxUSqT7kaYE7Qr3yz+CuDDjczOltqvpXfBAvFSr2
         Xh4wl/ayUnFK7EA0fpHqEiKcQUtSNPSt5aB/lQGpQlxpqNaIqDlK0Iak0I6rSvS4goOA
         r8rOgrTEwjqHUPHDfu7PV8ZLw0Xw1qWyY91k/rHfyAnd/cZ+Q1WYsZFzpLkqHmOOeof+
         KRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pPeKlSug6FmM3MV9fECsotZs7maoQ1cummrLUWibeCY=;
        b=F9rpJSkLCEyUs0Go/XpEPP8+87qPSlab/tYmXscrvXKJbjOQbVvZFAe28zmHYOEGLl
         a7e3mxqDHK6ZcWoDS4Ci/RXutdNCQJJHzHDZSxlVdL/JUEPHF9MH99l2ra2RCVHnEFJN
         5bvhdNEF5FEw6zXx//lTVTRV5yxtPJDM9VZaGgmMSHCkmWNlj5g7zO+zNEyaxJc4msBs
         cbH0KNPpzKhy18oYrbzCmFlEAZvf1lIVm5QY0U/KVrxBrROEr+fiTarAcenoYOZ+Dsyf
         AdxB7l6cq0T+ZZydat/+KxRCqZK76lGgYgVSvGo98tQkRqWdjfSs8N7Ji3zPqSyFAUEj
         E9qQ==
X-Gm-Message-State: APjAAAXFkVg4j5ABpUGznQzA2UYe0ubybQTsk6duZDQJQEq7HUrWhyz5
        16SQdpNAOkWT6ZXxXNp5uyo=
X-Google-Smtp-Source: APXvYqwLD5cDnTfGVwaZOk5rR/snoJXyBwTXzaf8duMpIx+mp+J4/KQTC0IfGkqsNurwSL6B747Klw==
X-Received: by 2002:a7b:cb58:: with SMTP id v24mr563202wmj.121.1554141493613;
        Mon, 01 Apr 2019 10:58:13 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73A0800C9C8A7BE25478D36.dip0.t-ipconnect.de. [2003:dc:d73a:800:c9c8:a7be:2547:8d36])
        by smtp.googlemail.com with ESMTPSA id s189sm16655340wmf.45.2019.04.01.10.58.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 10:58:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/1] pwm: meson: use the spin-lock only to protect register modifications
Date:   Mon,  1 Apr 2019 19:57:48 +0200
Message-Id: <20190401175748.5376-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401175748.5376-1-martin.blumenstingl@googlemail.com>
References: <20190401175748.5376-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holding the spin-lock for all of the code in meson_pwm_apply() can
result in a "BUG: scheduling while atomic". This can happen because
clk_get_rate() (which is called from meson_pwm_calc()) may sleep.
Only hold the spin-lock when modifying registers to solve this.

The reason why we need a spin-lock in the driver is because the
REG_MISC_AB register is shared between the two channels provided by one
PWM controller. The only functions where REG_MISC_AB is modified are
meson_pwm_enable() and meson_pwm_disable() so the register reads/writes
in there need to be protected by the spin-lock.

The original code also used the spin-lock to protect the values in
struct meson_pwm_channel. This could be necessary if two consumers can
use the same PWM channel. However, PWM core doesn't allow this so we
don't need to protect the values in struct meson_pwm_channel with a
lock.

Fixes: 211ed630753d2f ("pwm: Add support for Meson PWM Controller")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c1ed641b3e26..f6e738ad7bd9 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -111,6 +111,10 @@ struct meson_pwm {
 	const struct meson_pwm_data *data;
 	void __iomem *base;
 	u8 inverter_mask;
+	/*
+	 * Protects register (write) access to the REG_MISC_AB register
+	 * that is shared between the two PWMs.
+	 */
 	spinlock_t lock;
 };
 
@@ -235,6 +239,7 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 {
 	u32 value, clk_shift, clk_enable, enable;
 	unsigned int offset;
+	unsigned long flags;
 
 	switch (id) {
 	case 0:
@@ -255,6 +260,8 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 		return;
 	}
 
+	spin_lock_irqsave(&meson->lock, flags);
+
 	value = readl(meson->base + REG_MISC_AB);
 	value &= ~(MISC_CLK_DIV_MASK << clk_shift);
 	value |= channel->pre_div << clk_shift;
@@ -267,11 +274,14 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 	value = readl(meson->base + REG_MISC_AB);
 	value |= enable;
 	writel(value, meson->base + REG_MISC_AB);
+
+	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
 static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
 {
 	u32 value, enable;
+	unsigned long flags;
 
 	switch (id) {
 	case 0:
@@ -286,9 +296,13 @@ static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
 		return;
 	}
 
+	spin_lock_irqsave(&meson->lock, flags);
+
 	value = readl(meson->base + REG_MISC_AB);
 	value &= ~enable;
 	writel(value, meson->base + REG_MISC_AB);
+
+	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -296,19 +310,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
-	unsigned long flags;
 	int err = 0;
 
 	if (!state)
 		return -EINVAL;
 
-	spin_lock_irqsave(&meson->lock, flags);
-
 	if (!state->enabled) {
 		meson_pwm_disable(meson, pwm->hwpwm);
 		channel->state.enabled = false;
 
-		goto unlock;
+		return 0;
 	}
 
 	if (state->period != channel->state.period ||
@@ -329,7 +340,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
 				     state->duty_cycle, state->period);
 		if (err < 0)
-			goto unlock;
+			return err;
 
 		channel->state.polarity = state->polarity;
 		channel->state.period = state->period;
@@ -341,9 +352,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		channel->state.enabled = true;
 	}
 
-unlock:
-	spin_unlock_irqrestore(&meson->lock, flags);
-	return err;
+	return 0;
 }
 
 static void meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.21.0

