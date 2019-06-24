Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EBAC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDE7204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ahro5UIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730784AbfFXNOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:14:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51051 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfFXNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:14:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id c66so12777940wmf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgoJkj0j+DeXgOTwWsaQ9czRgkH7ct8k79BzMkAo21I=;
        b=ahro5UIyPK+V1/+XQ2wF7f8dq6Vslp14qbgOTRuMo9dats4tus9ss1qzOMDpHq7YZW
         JxRpH74WRxkquoVN9IdhpOk2FO+VJhm40EotHiWfXWXpk8ZQxqj1wfCZeamdcI36zIJB
         u/UxYzud+mnd2X/n2spcFq24O66oodb9QUTTxnLG3UQF/Df5C7V6zWiBe3n2s5ZBjn1y
         FcZCNiMXQHTZjty72LH/la2kkoabnM2vx/uRTIOIVaxHPG0QoXTktQiTMd5yHfoBOgJD
         fV0AMIoIZk3SINq02FJLkol+S8VW8JByvnWRU9LPAzM3b7oYBMj2t50d7JTVMW2Ohk8p
         XFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgoJkj0j+DeXgOTwWsaQ9czRgkH7ct8k79BzMkAo21I=;
        b=WEwLXtl3WGrq5XKfcALGzUJCGAd3JzvLIP3H3+Ht8Da1oIpoD/Og+fbxOt3eQMIstD
         C1vKm6HDaq60JzgrQxaAA8wDmtWFuev0mYsuwJaeIwMRcjPFH1oghSrWGV1bRwWZUvk+
         XJ0VsOzVAid0WfvKsNjwCnczOeBXtSoEVSQsjzbR7cYaElSmHmK06JnMRTQ2FkJBpQeZ
         Hj+HysrNS92N8EeLJoevMaX3venKG8k0dHJk7dAcfFxGQt9pJogBam+SRDI63d2wtsIJ
         YGERwEzfnrsqooqSnxdAuz/eOOBtYXHih83qnVp0hGLMV/mIa6hcDm5dWcJnqUj/6JlA
         KkMA==
X-Gm-Message-State: APjAAAXSZNo3nSIRH6j5lK3ztGdHDCo1NNyg7sO1FSpsoLNBdsKsIU90
        jmFbnSBMAbgh+jyzyMDxqlwk08NKl8Y=
X-Google-Smtp-Source: APXvYqwgIQca7idKo9ymapE3T5OO8x8pqigBLy9eB93kM1E6PWHv6ixEWkOsB241y9HTz4OBWoSVzA==
X-Received: by 2002:a1c:6a06:: with SMTP id f6mr15926580wmc.159.1561382042502;
        Mon, 24 Jun 2019 06:14:02 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id y2sm9535526wrl.4.2019.06.24.06.14.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:14:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 01/10] ARM: davinci: enable the clocksource driver for DT mode
Date:   Mon, 24 Jun 2019 15:13:42 +0200
Message-Id: <20190624131351.3732-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190624131351.3732-1-brgl@bgdev.pl>
References: <20190624131351.3732-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Switch all davinci boards supporting device tree to using the new
clocksource driver: remove the previous OF_TIMER_DECLARE() from
mach-davinci and select davinci-timer for ARCH_DAVINCI.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/Kconfig             |  1 +
 arch/arm/mach-davinci/time.c | 14 --------------
 2 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8869742a85df..9fa546ec6c1c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -588,6 +588,7 @@ config ARCH_DAVINCI
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select COMMON_CLK
 	select CPU_ARM926T
+	select DAVINCI_TIMER
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
diff --git a/arch/arm/mach-davinci/time.c b/arch/arm/mach-davinci/time.c
index 5a6de5368ab0..740410a3bb6a 100644
--- a/arch/arm/mach-davinci/time.c
+++ b/arch/arm/mach-davinci/time.c
@@ -398,17 +398,3 @@ void __init davinci_timer_init(struct clk *timer_clk)
 	for (i=0; i< ARRAY_SIZE(timers); i++)
 		timer32_config(&timers[i]);
 }
-
-static int __init of_davinci_timer_init(struct device_node *np)
-{
-	struct clk *clk;
-
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk))
-		return PTR_ERR(clk);
-
-	davinci_timer_init(clk);
-
-	return 0;
-}
-TIMER_OF_DECLARE(davinci_timer, "ti,da830-timer", of_davinci_timer_init);
-- 
2.21.0

