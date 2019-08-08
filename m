Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF06C32754
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC98C21900
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfHHHre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:47:34 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42133 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHHre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:47:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id l15so114994952otn.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 00:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zKiQP1NT5LwdgEB+F3OCY+sBDu+hIIMmqieRxanCzeM=;
        b=MADGOhJPinHqSLeQpqzOAHoKetGuSXB/pH/8j4kb9uuJxQSNDhGvmW9qaBxp5WuMJg
         SiaxzjvIC4YVF55LZpxatLvK6S22CuWV8DKLkkYDXajvZR5YA0kE/kz4THFY8k/0KLP5
         oUJeZ1cIng2NkQOfE1+VKah4z2P1O2xEo5X2vY3vkCyyAn8QLl3LOVkNdbGAP6hr+GlS
         aN8zpCukpVa4YZwsG1wxiiK2daes0tf5QZJdyn/E/LssMYPYynabt5WOLM0p4Y1lXNLK
         JSk4Ay7wuttyJlkNP+gfLIFw3Djt9m8v2Tj298fawZxshI023FqWr20WZYH1/s+8Pg98
         Rl7w==
X-Gm-Message-State: APjAAAUgck6Ukl9x7X3JQojqPkjlWgtXO52tf13A8zg2uxBCrVEfbm7c
        q276Q4J32VsFix+0K9g3bXgbcp5zkpYavMH2l0Y=
X-Google-Smtp-Source: APXvYqynapUc/AzMIgCaD/ru7vTmRlm/B2LVUwQrcUJx4lBrFRK8ZLFgrrOoAq4rLIrYh7sU+dLUO8EnLqdBvmvSVyU=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr12146948otc.250.1565250453132;
 Thu, 08 Aug 2019 00:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-5-swboyd@chromium.org>
In-Reply-To: <20190730181557.90391-5-swboyd@chromium.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 8 Aug 2019 09:47:21 +0200
Message-ID: <CAMuHMdXuVUQQF6opOE-BEvpukZRhxx1wU_4TQ2MTuRXM9gfaMA@mail.gmail.com>
Subject: Re: [PATCH v6 04/57] clocksource: Remove dev_err() usage after platform_get_irq()
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 8:23 PM Stephen Boyd <swboyd@chromium.org> wrote:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
