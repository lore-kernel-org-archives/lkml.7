Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59D3C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F87B2178F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 22:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZvxQabNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfKFWDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:03:12 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37297 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfKFWDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 17:03:12 -0500
Received: by mail-io1-f66.google.com with SMTP id 1so11393iou.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzOSEwwxlZUn+RZ80uzKZcPZx0SHIWxdqxRKaOr72PQ=;
        b=ZvxQabNfRd7utzX5GnZ5Ohq0RX5n5e/BnldYMHQTtRr5eA7bYfiVztyd7qSS/I8T7b
         Pkz2QCsHupVJxBYzzpLlI2tPOdtQX+WGgeSIlUmUXS507QqeB2/zSuEuRBRZ+6SjIztd
         c86Pe6BCIzzzR3vQPjkgGhLri8II0y++T1TLwL2Zha0Sed+Fn0nu51IpT7ZkAEQfkbe3
         +9MSrewLmo9y8yG1k1UdxgilmEF1qoaGLXq/DuFxLRXLyUE0+dRb0gaEFO0uZlLsc/G1
         ccvg5y3LxZkcf1Y5uCbk0uKCFlSacJ1ws5gjwhKZNi6JuTAUxx4UFarPAKp5XFOFC2Lk
         EriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzOSEwwxlZUn+RZ80uzKZcPZx0SHIWxdqxRKaOr72PQ=;
        b=qQ9jiJbcWX50Ikkk0mUUxbntdAEFE97uOsmhWy9BWz/PVh/HmtDb3AKUvFgIc+1zxJ
         V7ihb1kHB5JeIoJ2gXd0KJRcQJjzT1KXSj35jX4htSzpu3+4y8VCzF63GHK0C31t61cs
         bFpH+lYYhXTUji8qGZV0xi9qw0EGa0Zz1oQvETN/0474JOxV0P59s7esFSwmWfItjBWW
         BR48nUWyzrQtFZ9o49fWl3/RA8h6PCirj9BdXo/tf3V37Q6OZ+N27bYxveXgraAoSoiL
         L68WksMJgypL/mcsZM2E2NYkDdU1tYtM10l8aYwIUwX1QBPnUwAensm2lRrl6f1zVjxo
         MUYA==
X-Gm-Message-State: APjAAAWr5We7R3Sy/UC3xGboWwrm5IjuJ4tboSwldkIrhKg4EFrerK+2
        /4Q2cK5ul/QZaw9Kjrlie+oVozEpBbmr+SUgLVqS36JhBMo=
X-Google-Smtp-Source: APXvYqySmoxWwT6r5prJenB+QFGMiPAykmqD29iMpdYhZ8RMRbdy7um+kUa5w8Q1HhLGjL/PHFTjuw+S+RlOcBFXidc=
X-Received: by 2002:a02:7158:: with SMTP id n24mr345719jaf.127.1573077789213;
 Wed, 06 Nov 2019 14:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20191106174804.74723-1-edumazet@google.com> <157307438959.29376.9644507314555163943.tip-bot2@tip-bot2>
In-Reply-To: <157307438959.29376.9644507314555163943.tip-bot2@tip-bot2>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 6 Nov 2019 14:02:55 -0800
Message-ID: <CANn89iKBaEdCzgF-MT1wrxBZtBD2Ktr9qeThTG_XKOy742XcmQ@mail.gmail.com>
Subject: Re: [tip: timers/core] hrtimer: Annotate lockless access to timer->state
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 1:06 PM tip-bot2 for Eric Dumazet
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the timers/core branch of tip:
>
> Commit-ID:     de4db39b9f0e682e59caa828a277632510901560
> Gitweb:        https://git.kernel.org/tip/de4db39b9f0e682e59caa828a277632510901560
> Author:        Eric Dumazet <edumazet@google.com>
> AuthorDate:    Wed, 06 Nov 2019 09:48:04 -08:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Wed, 06 Nov 2019 21:59:56 +01:00
>
> hrtimer: Annotate lockless access to timer->state

...

> -/*
> - * Helper function to check, whether the timer is on one of the queues
> +/**
> + * hrtimer_is_queued = check, whether the timer is on one of the queues
> + * @timer:     Timer to check
> + *
> + * Returns: True if the timer is queued, false otherwise
> + *
> + * The function can be used lockless, but it gives only a current snapshot.
>   */
> -static inline int hrtimer_is_queued(struct hrtimer *timer)
> +static inline bool hrtimer_is_queued(struct hrtimer *timer)
>  {
> -       return timer->state & HRTIMER_STATE_ENQUEUED;
> +       /* The READ_ONCE pairs with the update functions of timer->state */
> +       return !!READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED;

You probably meant :

return !!(READ_ONCE(timer->state) & HRTIMER_STATE_ENQUEUED);

Sorry for not spotting this earlier.
