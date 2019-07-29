Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E09C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F473206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMJBO7Cz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfG2QvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:51:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41067 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbfG2QvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:51:08 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so117392752ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rG5B+o2VjO9RrL+xsfmgF+x6faimyKuyYbtOh0syfs=;
        b=iMJBO7CzFDXrKhFARbuDHHMTaO9XVZ8Ne4nthG6sBNughIMiW/tIyaCEt/UWLV4snj
         c5Wz8IRuJq5/HBOtvn0tdicUlfabqLSnYTuauXbU0NHzKZxTplbqTcMojnU6W7MO+4Id
         RNB3zlnATDGznsQemONTue4F1yoPEjfvkANdUR246NFIFKZGUuEZ4uoB6BvRwcq0r6Wd
         uIy98cksW9s+alA+MGQ3XTuLQsdIaWUOTb5OFjJ7Gd8OnerwB4SXx2luTuhjyjMxdEnk
         AwmYFVWGDEaXkcW4D5MQ2cvV+IpMvDhwyREZt/uI72HEqxFHqN0RN/77lG8qQi9Pomyk
         zWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rG5B+o2VjO9RrL+xsfmgF+x6faimyKuyYbtOh0syfs=;
        b=hn57vTZIRvbkqJMq+NPeMKGKwwN49tYS3YvPuDHp5HTf8QD7MA5FAjZnbANN6w4Xrj
         lVApXEAFxDySbnq+HAkE3XSkO54sWgyOeKNmSjPeoPF7EgYNA+XT/YpitIqHieoNDlYr
         /ys2kvUYPhiDdRvHJqfxhsEERKLjw82iiOHXyK+aSA5CT+kEvd9cKANRvXqL58e1GtHs
         8OnCAOvBhQ8pmgJC9kS1i7sIa7I3PT1bhXgh2OcQ9OPwmCDd0AF5BHOnJyKVPSFxWQix
         pfgqlusy2s7PLM67Th7IhNqsz5z/k3ZAcZ1XLQunbT7nvDKvoF9UUamnwFmZKwhu2zSC
         mBIg==
X-Gm-Message-State: APjAAAUkNZxNk++fD1gZV4TTJ+lU7r3Z2LEk6ni6EBHU2ZtEzMQf5u3Z
        ubx1tLqi190qbALL83ysHMxexEz/dcwgCzPugxOZ
X-Google-Smtp-Source: APXvYqwrO2Cgbb8VcmJ9nnp34EygSZZ0Ch4eVbj7Lx9YeY3iqvmkcPh+cj+5AYR0nZXcZoPcJa+0ZG2wl+BIm/aXwjs=
X-Received: by 2002:a02:cd83:: with SMTP id l3mr78290994jap.66.1564419067206;
 Mon, 29 Jul 2019 09:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190729164307.200716-1-avifishman70@gmail.com>
In-Reply-To: <20190729164307.200716-1-avifishman70@gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 29 Jul 2019 19:50:17 +0300
Message-ID: <CAKKbWA6=9rBhR7iTfH27FZXPtuin9FengQh77T6Qgb3XDuZaYA@mail.gmail.com>
Subject: [PATCH] [v4] clocksource/drivers/npcm: fix GENMASK and timer operation
To:     Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Avi Fishman <avifishman70@gmail.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPCM7XX_Tx_OPER GENMASK bits where wrong,
Since NPCM7XX_REG_TICR0 register reset value of those bits was 0,
it did not cause an issue.
in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
take effect.

npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
confusing.
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
