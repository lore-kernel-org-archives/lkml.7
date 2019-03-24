Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0970EC4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD112082C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HTd5HhKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbfCXWCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:02:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53287 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfCXWCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:02:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id q16so6947303wmj.3;
        Sun, 24 Mar 2019 15:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91HdSPyf9HFmjS95lK9wkN7VvhcgvAMdo9F31XsmQH8=;
        b=HTd5HhKiLz2vyrvOe2BVSJF/wUqAdo9KpqjyisggpqkoGmv6W2wRxcYjHUpOZGBBnR
         iSqONn6Xa/c7rwGKVSLXS21NnbPmMprM0DkTkf7PA9gDn3eKkDs1N/1yshxvLsx/WWJe
         RSHXe0JoVMmq+WsAAPXm/UYD04EzaLa1dfYN2M82mlzew9sm0uBVqreMzjWuYjIyQl0m
         jMjNKOl946qcnWL7ODiqPtHd04jKKX4j/N0WRgDtS0M+2tWMIn/TRGd8XRlj0MvxOVj4
         EwaFqBC/CusuBKTLRAoOtGjtO213VHYYSlbhB5q4CSLnsk/svcOf1tx6rBgxtCYgGS7X
         QFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91HdSPyf9HFmjS95lK9wkN7VvhcgvAMdo9F31XsmQH8=;
        b=L9HOnXvRWya6Iy3Nl2XzxViTnRT0RcG0RUL59iCadxJ+BH7w/PnkHzcHSDsVTA4tFA
         YJAMidr4F40gc5pp0IIkN5c/4OqIHQjfwOv9gagDwspe6Yjb0J+YE2W+pDZsmXT0Ykma
         x29esMkJn4NA3yFGVj2CZyO6cTRQVxy1/9JEcTTs+1JEPATmsTFsz8J9LuE4MRJ+vv77
         ZomD/WDbzF/TjwgzQii2xhsmcDeASB2bMPzxoJMwt6MV4mRh8DIASOBHa2ZlzUDf9qnA
         6I78Mes3vngHgDU47lA7CxDkfolZkrCHuumQswUYZ5t1jomAwY8qfWh+TysjluGndXUf
         X6Dg==
X-Gm-Message-State: APjAAAXEpA0sddG1LxGF7qItYCyNISezsUw2Gd5p20ggnU8UlUPdHq17
        Yo9zAnaypMw3ofLQyg2C50E=
X-Google-Smtp-Source: APXvYqwz0lpfo9Nvim+OlD497Z6RpuvSNAV/i6qOhXa7qv449Bb+sK/Ed7IgzYBvS+X/cvtUsUXGlw==
X-Received: by 2002:a1c:cc0a:: with SMTP id h10mr3249653wmb.20.1553464956265;
        Sun, 24 Mar 2019 15:02:36 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o13sm12743485wmc.20.2019.03.24.15.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 15:02:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     thierry.reding@gmail.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] pwm: meson: use the spin-lock only to protect register modifications
Date:   Sun, 24 Mar 2019 23:02:17 +0100
Message-Id: <20190324220217.15813-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
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
---
 drivers/pwm/pwm-meson.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index c1ed641b3e26..2b03938039b6 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -235,6 +235,7 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 {
 	u32 value, clk_shift, clk_enable, enable;
 	unsigned int offset;
+	unsigned long flags;
 
 	switch (id) {
 	case 0:
@@ -255,6 +256,8 @@ static void meson_pwm_enable(struct meson_pwm *meson,
 		return;
 	}
 
+	spin_lock_irqsave(&meson->lock, flags);
+
 	value = readl(meson->base + REG_MISC_AB);
 	value &= ~(MISC_CLK_DIV_MASK << clk_shift);
 	value |= channel->pre_div << clk_shift;
@@ -267,11 +270,14 @@ static void meson_pwm_enable(struct meson_pwm *meson,
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
@@ -286,9 +292,13 @@ static void meson_pwm_disable(struct meson_pwm *meson, unsigned int id)
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
@@ -296,19 +306,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -329,7 +336,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = meson_pwm_calc(meson, channel, pwm->hwpwm,
 				     state->duty_cycle, state->period);
 		if (err < 0)
-			goto unlock;
+			return err;
 
 		channel->state.polarity = state->polarity;
 		channel->state.period = state->period;
@@ -341,9 +348,7 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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

