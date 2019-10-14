Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA07C47404
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 04:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843EB2184C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 04:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gw4/KBjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbfJNEKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 00:10:41 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:33922 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfJNEKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 00:10:41 -0400
Received: by mail-yw1-f65.google.com with SMTP id d192so5679817ywa.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 21:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L3BMUwPSJ/HjM9WytH1tdamwbktegXbEoq7zL16k21c=;
        b=gw4/KBjGGradjyOMFOw+MHrp/GOC/fsz3tUtYDaZ+Jwzr/gJKYaYDXyIIG4Q1jIoL8
         rM499wQWo3ET3U84sJ0ZcwDRB/Zb4XsGMjaYSZx8eBFT07L6o1Aj+HljridfLhx78nXT
         Ey5a8SPaZ3fjm68WQ9K5FQDJrxuVS60zB+evIDXnFzOvMyT4ge3EZP+clO2HMehmM4M+
         gCfg4xTFb8QwTeDrsEqZ0rFsjt0hJG+riG0Flp6doP1cKtsWoUUByGZoGI5MoA7GcyJU
         wxZRN3n6NuuMKnbwjLKb9oIp/DShbbIaTzbh+Auy7ZDV8IdJBfhtVyGqwySzgNMUrtMj
         plgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L3BMUwPSJ/HjM9WytH1tdamwbktegXbEoq7zL16k21c=;
        b=O1j5UOld1/+4+W/ngC+4Czs89Np7RI9+Y171kqiH88S4NC5Sl3p9UYjRTkQ5teZUqv
         l3LYFBLBApnjGrurCb1tA1s5nTyAnWDz9QzfRdQ5A2YQxslYq8bT/1j92c7m5UjYz50g
         ozNc+4AcEijeqxDnUsUur94jHCY8qojFwE43jtFUHxPjrh5TYeyBznUlFktjmDBMD/6v
         VKfW/6Ng1XCfNowbXBHoo7+J8s0V60NCsKwxXZjsRnVZb6rcFMQDMNnDZccnGQcqaUuz
         Ij7NrFEFnzp5i/Th11pp02EZBD4IxGk3/HEEE4JCRAPPdKz/yspDrMUjuE8uf82fL+v8
         73/A==
X-Gm-Message-State: APjAAAXpUaUZEIZl8gjaa5xH098T1iLz7t/D4B6wM2h+wE+h5YUjIhob
        gmXTqJod904kUwjE7BFv+dIGdmFmdNMeSb9JSEbEkA==
X-Google-Smtp-Source: APXvYqxYv761it0eUCxcDUBFQzOY27J3PYMN1nQliQgXNS3HdPhT2a/pfGc+FAD9CYDXGdy0F5QmWL+vQRe/nR4iO0w=
X-Received: by 2002:a81:748a:: with SMTP id p132mr11298492ywc.174.1571026239951;
 Sun, 13 Oct 2019 21:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20191008173204.180879-1-edumazet@google.com>
In-Reply-To: <20191008173204.180879-1-edumazet@google.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 13 Oct 2019 21:10:28 -0700
Message-ID: <CANn89iKoPVWxd5RVFAmnOvGu=eWLrVTCTby=22+-5x5c+fy0Lg@mail.gmail.com>
Subject: Re: [PATCH] hrtimer: annotate lockless access to timer->base
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Julien Grall <julien.grall@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 8, 2019 at 10:32 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Followup to commit dd2261ed45aa ("hrtimer: Protect lockless access
> to timer->base")
>
> lock_hrtimer_base() fetches timer->base without lock exclusion.
>
> Compiler is allowed to read timer->base twice (even if considered dumb)
> and we could end up trying to lock migration_base and
> return &migration_base.
>
>   base = timer->base;
>   if (likely(base != &migration_base)) {
>
>        /* compiler reads timer->base again, and now (base == &migration_base)
>
>        raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
>        if (likely(base == timer->base))
>             return base; /* == &migration_base ! */
>
> Similarly the write sides should use WRITE_ONCE() to avoid
> store tearing.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Julien Grall <julien.grall@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/hrtimer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
> index 0d4dc241c0fb498036c91a571e65cb00f5d19ba6..65605530ee349c9682690c4fccb43aa9284d4287 100644
> --- a/kernel/time/hrtimer.c
> +++ b/kernel/time/hrtimer.c
> @@ -164,7 +164,7 @@ struct hrtimer_clock_base *lock_hrtimer_base(const struct hrtimer *timer,
>         struct hrtimer_clock_base *base;
>
>         for (;;) {
> -               base = timer->base;
> +               base = READ_ONCE(timer->base);
>                 if (likely(base != &migration_base)) {
>                         raw_spin_lock_irqsave(&base->cpu_base->lock, *flags);
>                         if (likely(base == timer->base))
> @@ -244,7 +244,7 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
>                         return base;
>
>                 /* See the comment in lock_hrtimer_base() */
> -               timer->base = &migration_base;
> +               WRITE_ONCE(timer->base, &migration_base);
>                 raw_spin_unlock(&base->cpu_base->lock);
>                 raw_spin_lock(&new_base->cpu_base->lock);
>
> @@ -253,10 +253,10 @@ switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
>                         raw_spin_unlock(&new_base->cpu_base->lock);
>                         raw_spin_lock(&base->cpu_base->lock);
>                         new_cpu_base = this_cpu_base;
> -                       timer->base = base;
> +                       WRITE_ONCE(timer->base, base);
>                         goto again;
>                 }
> -               timer->base = new_base;
> +               WRITE_ONCE(timer->base, new_base);
>         } else {
>                 if (new_cpu_base != this_cpu_base &&
>                     hrtimer_check_target(timer, new_base)) {
> --
> 2.23.0.581.g78d2f28ef7-goog
>

Any news on this patch ?

If more information is needed, let me know.

Maybe I need to point to :

commit b831275a3553c32091222ac619cfddd73a5553fb timers: Plug locking
race vs. timer migration

Thanks
