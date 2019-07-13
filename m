Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89C1C71142
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 16:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B4720830
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 16:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke7ejz/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfGMQFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 12:05:40 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40960 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfGMQFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 12:05:40 -0400
Received: by mail-yw1-f66.google.com with SMTP id i138so6026627ywg.8
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 09:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7mk75n+FUSNUhfgNLft7JljlbXBUa7UOYFFMLEx7Ozk=;
        b=Ke7ejz/mT3GEgJN7v5rXdKwDCBjN3gI3AqIh2t3dAPhMi1tnB4DK9+xAh2bGEj87DO
         rxxRS3AJMRuw4LR41VnOligTxXk/T19Ijnvu09+BkEHY1n5xCxJvKJfzDH0BgVXcNZ6T
         mzcNez1i5WrwxW/9eeJgRRwyin8scGj1bIXKiZKcWXCKnld5Tqu37+Fs7ygYRKgHCoBf
         WZXUTvuYWLyojeuWyB4UpfZHfYEEiy7m2bFzcJh8VYB5MRdRpBhWqJcZqI8mvEwo4F2A
         ajjjKT58t0Mcrl6hEkZiWAnhtZoCuwscYs4FkPqbHOhSgFEB3O4Tyv6TlNA+7ewxGb0f
         RzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7mk75n+FUSNUhfgNLft7JljlbXBUa7UOYFFMLEx7Ozk=;
        b=dWP2BTjnaqvvu8FNQEwu0eFE0JDuqDLEtT79DhE2XB4t3829Fu15e+Nx43Rmc+2tR6
         i1aRq30WE8+uIYPnqROvyB4tryXSmOu8XwrvBpMfJQNPLaJhpSMefh9N3MC8+/p7kjO/
         4vfePy/RXXaf4zogjy//Z+WPmQyaQ5laEZ6fzJqncLfbhCFIq+ugYown6Os+LL2XkB/7
         rbC1xx215k/tWYI6xFs0XXwxdqF5HfF+W6Jf/dg9WUV9KJOzav8jliv3F8mQrfPs/1aV
         T5bfjM4WSZmXvuvNGFUUS6i4KcO5jatqW9nIAF2DCd7g0Hiyzi8OY24dC5yA8tl+1Huy
         hkzw==
X-Gm-Message-State: APjAAAXq9/SlJoQgn5tYTLqFeGy0FnsR7P+vguN9gPUNGYG352IGCYCj
        /+QAYCwcHSMPjWS2Spe9JcAxVgzhf3ctzqDm2FYHzA==
X-Google-Smtp-Source: APXvYqxMlQFJR0h8Qeriyc5l0gq+QA9nZ7IroV8xzvAcGnoKo6g6GsAEfb1wbrBSXDFB1s2MHWcP5eHRiALUf/y1g14=
X-Received: by 2002:a0d:c345:: with SMTP id f66mr9597066ywd.10.1563033938757;
 Sat, 13 Jul 2019 09:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190712222118.108192-1-henryburns@google.com>
In-Reply-To: <20190712222118.108192-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 13 Jul 2019 09:05:27 -0700
Message-ID: <CALvZod68Ktd3m7p4MFgLdpqku3UucwEGrTVHdMPgi4cOpUOk6A@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Allow __GFP_HIGHMEM in z3fold_alloc
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Jonathan Adams <jwadams@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Snild Dolkow <snild@sony.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 3:22 PM Henry Burns <henryburns@google.com> wrote:
>
> One of the gfp flags used to show that a page is movable is
> __GFP_HIGHMEM.  Currently z3fold_alloc() fails when __GFP_HIGHMEM is
> passed.  Now that z3fold pages are movable, we allow __GFP_HIGHMEM. We
> strip the movability related flags from the call to kmem_cache_alloc()
> for our slots since it is a kernel allocation.
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/z3fold.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index e78f95284d7c..cb567ddf051c 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -193,7 +193,8 @@ static inline struct z3fold_buddy_slots *alloc_slots(struct z3fold_pool *pool,
>                                                         gfp_t gfp)
>  {
>         struct z3fold_buddy_slots *slots = kmem_cache_alloc(pool->c_handle,
> -                                                           gfp);
> +                                                           (gfp & ~(__GFP_HIGHMEM
> +                                                                  | __GFP_MOVABLE)));
>
>         if (slots) {
>                 memset(slots->slot, 0, sizeof(slots->slot));
> @@ -844,7 +845,7 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>         enum buddy bud;
>         bool can_sleep = gfpflags_allow_blocking(gfp);
>
> -       if (!size || (gfp & __GFP_HIGHMEM))
> +       if (!size)
>                 return -EINVAL;
>
>         if (size > PAGE_SIZE)
> --
> 2.22.0.510.g264f2c817a-goog
>
