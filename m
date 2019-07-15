Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21141205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4DV6iqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfGOPUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:20:43 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34402 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730548AbfGOPUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:20:41 -0400
Received: by mail-io1-f65.google.com with SMTP id k8so34762011iot.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 08:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDhyWC5m7v6jwYwWBJCZO8vmmCQJIMiVT+1lgsXb/hQ=;
        b=A4DV6iqs0VowpYFUQPzk7PIRlj/q0buwiqqVo5Tnn2W1bYwZH3LZjdymyVpEyNHb58
         ANeMlc1dL7qmCH+KPGrrtDM3c4VaZ3v98djrhl92Tr3wXo9b3nheYpu/PTxXo7M1IIGS
         BttFTY/OlGhHbhqsh3A5BUs/9QBZa0xTD5rhO355ySRzpmzoU6sn9bBF+E4Dr+uSKbt2
         lH/sq1QunSO29z5EuknVg6nZx7sqzSiIUeXHiDm+wFNqB01HXxLqzDs3YZ2gOR0rkBi4
         c/dpw0kqhkkwDH7emRIRSNvrD1YNfFAcsy5QjXERSpI/2Vvc3276b+ud4LPtojDdWAO1
         4UBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDhyWC5m7v6jwYwWBJCZO8vmmCQJIMiVT+1lgsXb/hQ=;
        b=WF8cICYJypdQZ6ZBXI26klahogch2ZwwgDmMV0Q0lc9JprFxrCPHkyCLbI5/PeSKg7
         0vqbzrbllPjIMkzSY/XxbdqL/cj96x1AuP4OnWIwuVwJNveeDjULf5BV1ZZK61H5QANu
         m1Qm6v8yem8qx0oIlVv36pzELKksjzukeyoVtu4QNINmrS39Ol0GhqEt+Pd79h3YuhFW
         sXGOBLMrTxD35hzk/ziGY1m9enxbsXUu/tqAHbxYbmUnaH987dyKDaKeok36vCihYGdZ
         NH9rpnsXgdQHEcEAGwV6qgSJAkXsaKxWw/uwEeoHH8fuBRUKLp3K11WnX9pHNNywu+cn
         uM/Q==
X-Gm-Message-State: APjAAAX55ElshSuGsP8LyFyEHWNfV3qqiiTQqHmHa/2rNGwbUOx4yRQq
        EzCjib4KOto7jaqAxUVsqLMoh/oZOPY86KCO7A==
X-Google-Smtp-Source: APXvYqzC8yGnKfFvwdN89UqQ62Tki+6ejCY+Deplht8t5Vgn2sTMJOv2JhaN1FzfdK/Soa13Xo1cL5BZNCYT1PloOH0=
X-Received: by 2002:a02:cd83:: with SMTP id l3mr28157334jap.66.1563204041005;
 Mon, 15 Jul 2019 08:20:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com>
In-Reply-To: <CAKKbWA6S7KotAFtLO=ow=XYnLL2Ny5Mz2kcgM1cs+j=5mHQNmw@mail.gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 15 Jul 2019 18:19:54 +0300
Message-ID: <CAKKbWA5nwsa5kcZ8GCuC3WKJptb6RtZ65izFphd=KaALqeg+BA@mail.gmail.com>
Subject: [PATCH] [v2] clocksource/drivers/npcm: fix GENMASK and timer operation
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

clocksource/drivers/npcm: fix GENMASK and timer operation

NPCM7XX_Tx_OPER GENMASK() changed from (27, 3) to (28, 27)

in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
take effect.

npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
confusing.

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
