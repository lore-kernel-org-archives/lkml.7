Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58085C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B36D2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uSRwaaQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbfHZUpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36480 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfHZUpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:08 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so794874wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJr/EagOWWWCEFoK6Cl8RHdd3bbJGdepYKWoaGBi1+8=;
        b=uSRwaaQTED8QF+2S4yqgVSoNPgjxT8uTgt9GhpJsDr+8CvcVzeUbCSE0ERTVchio4p
         QNRdt30i1fpggxajsFk7Voi6prWjddEOIdOxu/GaOqTH1NMqdBXyL9p9OsvjyHBGqz2n
         ZtmiU15CtLVF/qW8QfOji5RW101rf6lV2hH4P8NlLJAV2uMDR1rvyAsAeS2SV4p1eKD9
         ByX/kC7XiDxfjEXRYp4lV1pFvei3AOrAjRvNGOYS5+vNSRte8WFE3BWxQNgdYUSObzPd
         v08kN1XBFh7jYXDKXF1rRiLfgCLVJMRsBl1Gj22oaCtg0kP8zckgIqrdiYBqAj4kZfE3
         5SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJr/EagOWWWCEFoK6Cl8RHdd3bbJGdepYKWoaGBi1+8=;
        b=ada3sQz6Rn7mOpK5YyIU5l7RefuPGLDJ+RGrzQd16/XJ4rNNvUKYOm/QYUtBx9eq9O
         N+axadk6udbgEEYg5g6D0Sgu3HmEycHXqoXkFs2upWhwbfoi+g/TPunR8igVPXBjPO+5
         J8TW5aTG5Scu7YpHs7+Gl5A3YqYwEy+R4Chw1WpVUzd57+pydNyYivXgok5TzeR/XDaJ
         /qcb31e1WUE4KlyhyHPFZbA3IkJ6trpx/KH61NQ3vdILT4kaAaF8dO6CPcSWFXxlLH1o
         QZS5uJwsLz2R6heRfAFxjrZ3KopLKP/q44tiCXHp2L9GlphQQf3FSokY7FHAdmyyM8WG
         9p6g==
X-Gm-Message-State: APjAAAU3tL31kDiyXQ9BhZPjW/JRCDyaQ9q6gjFDwPI+Avnz7xd0LMKY
        VYy+qzGrhfQTwsOfkrkMw6Juzg==
X-Google-Smtp-Source: APXvYqwXwSxG80kgpFkYnO+Z1GwvdiIdcVmq6Bkgqse72Bk1nRrZrhz0H9bgN6nDwhLGTu2FJfkc7Q==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr24638471wmh.81.1566852306477;
        Mon, 26 Aug 2019 13:45:06 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:05 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        openbmc@lists.ozlabs.org (moderated list:ARM/NUVOTON NPCM ARCHITECTURE)
Subject: [PATCH 11/20] clocksource/drivers/npcm: Fix GENMASK and timer operation
Date:   Mon, 26 Aug 2019 22:43:58 +0200
Message-Id: <20190826204407.17759-11-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <avifishman70@gmail.com>

NPCM7XX_Tx_OPER GENMASK bits are wrong, fix them.

Hopefully the NPCM7XX_REG_TICR0 register reset value of those bits was 0,
so it did not cause an issue.

The function npcm7xx_timer_oneshot() reads the register
NPCM7XX_REG_TCSR0, modifies it and then reads it again overwriting the
previous changes. Remove the extra read which is pointless.

The function npcm7xx_timer_periodic() is correct but the code writes
to the NPCM7XX_REG_TICR0 register while it is dealing with the
NPCM7XX_REG_TCSR0 register, that is confusing. Separate the write to
the registers in the code for the sake of clarity.

Fixes: 1c00289ecd12 ("clocksource/drivers/npcm: Add NPCM7xx timer driver")
Signed-off-by: Avi Fishman <avifishman70@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-npcm7xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-npcm7xx.c
index 8a30da7f083b..9780ffd8010e 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN		BIT(29)
 #define NPCM7XX_Tx_COUNTEN		BIT(30)
 #define NPCM7XX_Tx_ONESHOT		0x0
-#define NPCM7XX_Tx_OPER			GENMASK(27, 3)
+#define NPCM7XX_Tx_OPER			GENMASK(28, 27)
 #define NPCM7XX_Tx_MIN_PRESCALE		0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS	24
 #define NPCM7XX_Tx_MAX_CNT		0xFFFFFF
@@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct clock_event_device *evt)
 
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val |= NPCM7XX_START_ONESHOT_Tx;
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
@@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct clock_event_device *evt)
 	struct timer_of *to = to_timer_of(evt);
 	u32 val;
 
+	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
+
 	val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
 	val &= ~NPCM7XX_Tx_OPER;
-
-	writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
 	val |= NPCM7XX_START_PERIODIC_Tx;
-
 	writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
 
 	return 0;
-- 
2.17.1

