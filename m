Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB73EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEAE62064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYy92tES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfGOKGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:06:39 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35469 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOKGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:06:39 -0400
Received: by mail-io1-f68.google.com with SMTP id m24so33182529ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 03:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=7BCsDJdR5KYaMX3UQplQ6QtuJPUxTxnY/Qc6vVf7TgQ=;
        b=GYy92tES6qIGd/FIHRU6kRF7gZ31p54OfCxRbJbYisMyC/+rU33OJmZIF2+efTUmQA
         GHp9oJGW0ZvI+rDBtptxV+fhyWMBj8rDCYHXlGOH5Q1i9ohJfLEs5Rxg+TNq8MR5fUqL
         Zm5Z03pX2eIT8pG0HmDf6gvujkAK7Z8YwCm9QsiXxmwsnps2gOc7KhM8VDvPnYQrvj9Z
         +DEDygP/VQtYtkycxkPHBjbDOjuK8DbUHf2Yy85pghaRqGvCzUOqzycLGo4Kgy+nu+tT
         aWOGUXSDvF3EVXr8kp407JlZhQzWOKoaG3Hm2Th2ThpVRed+QFUEAHvAKSgXvCvbI0Bq
         YMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=7BCsDJdR5KYaMX3UQplQ6QtuJPUxTxnY/Qc6vVf7TgQ=;
        b=HtK+dZXMNBgY4pivr/XAnaqJldaP/ao+sLiiD4B9RV3gx780l2JEf/RfXzSy9VChNr
         mcw56LT8CqhGKpuK23Adgrh8ou0EcziahyCin2C5uXSQtIaUiCgymvB6t0Bvyt9BhpMq
         +OCYsYRSi2sRM+HN0aOs/6Eiz+Oapt9BvR1m3aNcs/RmKtArXLLfkvMH86+B4muZjpQn
         FO3kEbHL17+JKCix3PKFlkwJY6wjFW6fiutb0rsLgeWUL+WQqyL8K2yJYMURgxy62m50
         ktu2HjQcnKegj0sX7xJphT8GjpTsO1MWvSqhEUUSHK1Lz1cxgK862n9EVNVNC8ljaeu0
         ThmQ==
X-Gm-Message-State: APjAAAXDFsi+HNno9ArSGMpbFiumUjecV/uyUiD3PTm1OpUl1xkQm/1j
        gjlrEyYzcsMO/18qD9ic2IQphoAktFvccwhdlw==
X-Google-Smtp-Source: APXvYqzLyQe68of5s4q1xFU+Vjpm9l+XKtN5xcapebvBPyqO7sHkGHN5DoefuGT/Cx93PuqqDhC13MKJ47cNQrcCHU8=
X-Received: by 2002:a5d:96cc:: with SMTP id r12mr13141421iol.99.1563185198579;
 Mon, 15 Jul 2019 03:06:38 -0700 (PDT)
MIME-Version: 1.0
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 15 Jul 2019 13:05:51 +0300
Message-ID: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com>
Subject: [PATCH] clocksource/drivers/npcm: fix GENMASK and timer operation
To:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPCM7XX_Tx_OPER GENMASK was wrong,
npcm7xx_timer_oneshot() did wrong calculation

Signed-off-by: Avi Fishman <avifishman70@gmail.com>
---
 drivers/clocksource/timer-npcm7xx.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/timer-npcm7xx.c
b/drivers/clocksource/timer-npcm7xx.c
index 8a30da7f083b..9780ffd8010e 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -32,7 +32,7 @@
 #define NPCM7XX_Tx_INTEN               BIT(29)
 #define NPCM7XX_Tx_COUNTEN             BIT(30)
 #define NPCM7XX_Tx_ONESHOT             0x0
-#define NPCM7XX_Tx_OPER                        GENMASK(27, 3)
+#define NPCM7XX_Tx_OPER                        GENMASK(28, 27)
 #define NPCM7XX_Tx_MIN_PRESCALE                0x1
 #define NPCM7XX_Tx_TDR_MASK_BITS       24
 #define NPCM7XX_Tx_MAX_CNT             0xFFFFFF
@@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct
clock_event_device *evt)

        val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
        val &= ~NPCM7XX_Tx_OPER;
-
-       val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
        val |= NPCM7XX_START_ONESHOT_Tx;
        writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);

@@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct
clock_event_device *evt)
        struct timer_of *to = to_timer_of(evt);
        u32 val;

+       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
+
        val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
        val &= ~NPCM7XX_Tx_OPER;
-
-       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
        val |= NPCM7XX_START_PERIODIC_Tx;
-
        writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);

        return 0;

-- 
2.18.0
