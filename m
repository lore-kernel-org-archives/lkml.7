Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B278C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C521206E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhM52LN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbfG2Qx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:53:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:37346 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfG2Qx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:53:29 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so1753863iog.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCFQqYIsIHUuEI1zjQL1qrOWxSUO9qXF3sIVxAvbwSY=;
        b=UhM52LN5XGqZ/4g08xPziW3KDRUTEYB3xh9AsB6YP6onaqTgFL+t8JnUilZJPBphTf
         VOiFZ1mKxTZzB+w9GRMUJCcDgmVAkmgzg/fqacrvgcKw1pxSZI/ASWGFKY+JsovGG5aZ
         anR/x+yLweATOEOOXXqqan6a12Bl7TQmZUv20cb9ngMA0dQbIAIuURSuG2XxXZO8Fpf0
         7EXQVrPRBNrHaujN/NOSoT7yQIgaBEGpHNOCKA0kDeAs5y+MQg0/dUjIinn0pXB5Z6yY
         4wmMGaK7Hw7p8HsangTL0+vFadK5zWNpK1K7zzT3lEgPTemNiHCajcKlPd5Ykb2EmzNo
         EVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCFQqYIsIHUuEI1zjQL1qrOWxSUO9qXF3sIVxAvbwSY=;
        b=kBNy+tVbRykKerKauJqlRLtmzyWO/e9dVR0IwGzdnmlZjsawPUfbuQPkoNO2HtdHw3
         YBeVb0uxA8+fGw1iga3bB6Olp8OOXgA6avS1sA6IYnqUDW+IuFVKM5lz6osFjzrY2oCS
         hz7moyBT4FQygNQPm09+rvtfRcZObDPHoPyvm4lvPm+XnpTaP8NxqoRvzKW9ALXYUKIH
         8r/A229iohBGi7M3TNzBWmgHBJOaUnX6pCM9w7n8XYG4A5oMaLD6JCHpokjYTXzxYQP2
         NiaVM9Zfz6LG2024vNf/G9uIQlEJ2BuCfu/RcjTtMnh9XmMgTi8wKr2wqoAK4AwyK0e8
         k+VQ==
X-Gm-Message-State: APjAAAXSTjh2sLGvGyiDlzUPyVfEvMJvC795vpGlH4Rgyf82oWZm0P+M
        BQwqHrFTH7Ae7V7kX5wR0WVlO0TV/h6CZvGoyA==
X-Google-Smtp-Source: APXvYqzZXOeuD12CYNHQ2l59sm2VPqnEtZIuLx75p0SpOLCZi3eb/xpaCQOIR5sti4CZP+hxeUxLHIx+meDoNv/SjSU=
X-Received: by 2002:a6b:f80e:: with SMTP id o14mr32870690ioh.1.1564419208818;
 Mon, 29 Jul 2019 09:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190729164307.200716-1-avifishman70@gmail.com> <CAKKbWA6=9rBhR7iTfH27FZXPtuin9FengQh77T6Qgb3XDuZaYA@mail.gmail.com>
In-Reply-To: <CAKKbWA6=9rBhR7iTfH27FZXPtuin9FengQh77T6Qgb3XDuZaYA@mail.gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Mon, 29 Jul 2019 19:52:39 +0300
Message-ID: <CAKKbWA6K4=qL7i5i2_jhB7KHBX3D+YsREP7yECdgD4j6VZFrLg@mail.gmail.com>
Subject: Re: [PATCH] [v4] clocksource/drivers/npcm: fix GENMASK and timer operation
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

Please discard this. my mail tool corruppted it again.

On Mon, Jul 29, 2019 at 7:50 PM Avi Fishman <avifishman70@gmail.com> wrote:
>
> NPCM7XX_Tx_OPER GENMASK bits where wrong,
> Since NPCM7XX_REG_TICR0 register reset value of those bits was 0,
> it did not cause an issue.
> in npcm7xx_timer_oneshot() the original NPCM7XX_REG_TCSR0 register was
> read again after masking it with ~NPCM7XX_Tx_OPER so the masking didn't
> take effect.
>
> npcm7xx_timer_periodic() was not wrong but it wrote to NPCM7XX_REG_TICR0
> in a middle of read modify write to NPCM7XX_REG_TCSR0 which is
> confusing.
> npcm7xx_timer_oneshot() did wrong calculation
>
> Signed-off-by: Avi Fishman <avifishman70@gmail.com>
> ---
>  drivers/clocksource/timer-npcm7xx.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clocksource/timer-npcm7xx.c
> b/drivers/clocksource/timer-npcm7xx.c
> index 8a30da7f083b..9780ffd8010e 100644
> --- a/drivers/clocksource/timer-npcm7xx.c
> +++ b/drivers/clocksource/timer-npcm7xx.c
> @@ -32,7 +32,7 @@
>  #define NPCM7XX_Tx_INTEN               BIT(29)
>  #define NPCM7XX_Tx_COUNTEN             BIT(30)
>  #define NPCM7XX_Tx_ONESHOT             0x0
> -#define NPCM7XX_Tx_OPER                        GENMASK(27, 3)
> +#define NPCM7XX_Tx_OPER                        GENMASK(28, 27)
>  #define NPCM7XX_Tx_MIN_PRESCALE                0x1
>  #define NPCM7XX_Tx_TDR_MASK_BITS       24
>  #define NPCM7XX_Tx_MAX_CNT             0xFFFFFF
> @@ -84,8 +84,6 @@ static int npcm7xx_timer_oneshot(struct
> clock_event_device *evt)
>
>         val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
>         val &= ~NPCM7XX_Tx_OPER;
> -
> -       val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
>         val |= NPCM7XX_START_ONESHOT_Tx;
>         writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
>
> @@ -97,12 +95,11 @@ static int npcm7xx_timer_periodic(struct
> clock_event_device *evt)
>         struct timer_of *to = to_timer_of(evt);
>         u32 val;
>
> +       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
> +
>         val = readl(timer_of_base(to) + NPCM7XX_REG_TCSR0);
>         val &= ~NPCM7XX_Tx_OPER;
> -
> -       writel(timer_of_period(to), timer_of_base(to) + NPCM7XX_REG_TICR0);
>         val |= NPCM7XX_START_PERIODIC_Tx;
> -
>         writel(val, timer_of_base(to) + NPCM7XX_REG_TCSR0);
>
>         return 0;
> --
> 2.18.0



-- 
Regards,
Avi
