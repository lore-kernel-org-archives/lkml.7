Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC10FC282E5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9290520815
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 18:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="HOmH0HDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfEYSLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 14:11:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38909 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbfEYSLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 14:11:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id t5so12065079wmh.3;
        Sat, 25 May 2019 11:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+PNcF82aHvSsVWjJ6xxGU5P+zv9rDQAJYSA2FkuCyI=;
        b=HOmH0HDkOr7SXnhIcKjEbMv5hPMaXwl9juWT/B/W2aqGGjOVQIs7AHYGMWCPwm/t4e
         Y9sFFjPKvWUkZvJs9lBPO5VekrHnjKFfFYeVP/x87C9QTOtgKpc3iSgm0lbbQVFazFWh
         YTvBXhbKt3wpBTV6JUp+0QMqVAOTiQeHQh1DUiSASdV5iLuuDjO5x3IoBXRBowoZ1gm0
         Ab+rr6jnRMxNrVPd5gfDG9V9RrQTDjfUiUO8spS2+HSu+89X0Kr4sQGBnC8VsoZ5UI+2
         wNxBUUSFXZCqPQfH61jVjEN7AKzhyzw1XmvSIfkW2lnTwukcYpWUgZFex6esZi28j4Xy
         XERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+PNcF82aHvSsVWjJ6xxGU5P+zv9rDQAJYSA2FkuCyI=;
        b=W5FOlR1Sy/FLo2OOZxmbnsw2chLw2RiYEbcX1PiE3G/V+ho3ejYhQ/vGreuvApL2eq
         2Y2prSUXl/2rHckaQ7TKAlpymelzbTKiHz46oZ+HsSANTJZvo2A9FFee6SAf27zYB5aX
         d1ft4zJUwhi3wQJ3MD1cjmUR6Z6t8D0fbzrF+FYDKBO9Yhi6R1cbck7IDtpid459vyZZ
         ftPLbgcYmEaLXw5o5UTvXSr+MZRf2SzVM+xwMZTgLFh8Q0blj+MHhELVJFSabuwivaMC
         eRKe4HxQXNGLLGQyxoCeUYHHTCYPjX4YsSfVSe8X05JeUSAy+/5wwInCJQf1BCEo6hJ4
         Kp/A==
X-Gm-Message-State: APjAAAXprPih46kjDdOIzrlb+B8ITZAjOt3EVU5oyZ9Pmmu2LdIBdBKF
        1GsHs/WwcnwCqTWgxii2Z9g=
X-Google-Smtp-Source: APXvYqxoBz1yNBbK0nsIKKxkJ6BPRwZafE9Jtj2RJXjDTEjHPteUwQIKRJc58Tq/sxZidVq4F1k8eA==
X-Received: by 2002:a1c:cfc9:: with SMTP id f192mr7147926wmg.19.1558807907359;
        Sat, 25 May 2019 11:11:47 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:46 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 03/14] pwm: meson: use GENMASK and FIELD_PREP for the lo and hi values
Date:   Sat, 25 May 2019 20:11:22 +0200
Message-Id: <20190525181133.4875-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

meson_pwm_calc() ensures that "lo" is always less than 16 bits wide
(otherwise it would overflow into the "hi" part of the REG_PWM_{A,B}
register).
Use GENMASK and FIELD_PREP for the lo and hi values to make it easier to
spot how wide these are internally. Additionally this is a preparation
step for the .get_state() implementation where the GENMASK() for lo and
hi becomes handy because it can be used with FIELD_GET() to extract the
values from the register REG_PWM_{A,B} register.

No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 35b38c7201c3..c62a3ac924d0 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2014 Amlogic, Inc.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
@@ -20,7 +22,8 @@
 
 #define REG_PWM_A		0x0
 #define REG_PWM_B		0x4
-#define PWM_HIGH_SHIFT		16
+#define PWM_LOW_MASK		GENMASK(15, 0)
+#define PWM_HIGH_MASK		GENMASK(31, 16)
 
 #define REG_MISC_AB		0x8
 #define MISC_B_CLK_EN		BIT(23)
@@ -217,7 +220,8 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 	value |= clk_enable;
 	writel(value, meson->base + REG_MISC_AB);
 
-	value = (channel->hi << PWM_HIGH_SHIFT) | channel->lo;
+	value = FIELD_PREP(PWM_HIGH_MASK, channel->hi) |
+		FIELD_PREP(PWM_LOW_MASK, channel->lo);
 	writel(value, meson->base + offset);
 
 	value = readl(meson->base + REG_MISC_AB);
-- 
2.21.0

