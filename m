Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D30C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89902173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwXCd/VQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391167AbfHBO6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:58:12 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:35209 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfHBO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:58:12 -0400
Received: by mail-yw1-f65.google.com with SMTP id g19so26707559ywe.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2t7kh32IlRdOx8sjdsjf2HQN2zHlz2OSPNUjrRGAcBA=;
        b=WwXCd/VQmyFg2yNmEMZgERJNaq7Y0Jobb+bFuDYPe2UfvjZBD9TSI62E4neWS7QEZT
         uHq9yMdYv3Z46RbWESTbN/WX90CrDR2Z5UpoDui5TtKW3MpOXr6BtwNKRVyV4OYPaMSR
         F8CDJ4IAWxZL9IDpZfdjsR2BexcPo3ebtA1e3dBhwimbwjtA5Buf0lmpFvIZb9QiglrY
         qMP2bv7tUizrHHhoJtnoXHnVxyd+j7ET7QCuCSv5fJv/LRzQc8LZto4amVBv5yiVfEAw
         Y3Vutaofi3fQpY79BtKP+tCuu6oFNAZ6Ewww+xwheDvMI+VfBoFlv6KYUZ178XFqRlCC
         YctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2t7kh32IlRdOx8sjdsjf2HQN2zHlz2OSPNUjrRGAcBA=;
        b=kmyxXCX5CFLVxs4sCjuBHz2vzNQsa+ltYsdQ+x92vbafgPUUeoJAireHjB0EMHF6TX
         HzgRYpiq8EcYzIMnO74qw9IQ70QovdN06E6PvVNpF650yFogNmmC3NhlcuxiNH+NyB6I
         vbVWPBU68uCYDeI/7c3bNQK7ye6LG1qQYdj+fCS0gI3Q5f38XHa94CXL0YeiVHeTrQvG
         DxTm2QJy0SJvwj3FE2zxwytf3eDZaFpqtPsyP+lSnZkxfqvUFsbsTffJyJydrhhgIElZ
         Mr3ltGWXaWsPlBdwhyUOfFgsmpb3m+2S9R9y//4ypkUGniVa5CNdo8kmw0jws1F/vJ7a
         dLfg==
X-Gm-Message-State: APjAAAW4UZEM29cpJJvzS2y7/av1snejm/2QkOCCJOL8aT/NETkKC0+J
        2jrZ8dbGY4xTW9L5+hvMwEXGYouWGA1Zndt7vKqF+A==
X-Google-Smtp-Source: APXvYqziJBGMCJKD3omPwQE75QPtI6KDdt2k628cv9E1FLN7w8SIXTvJSwkub5MihjDofyGVsiLOfAZqkBTnN49l58U=
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr86597121ywh.308.1564757891251;
 Fri, 02 Aug 2019 07:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190802015332.229322-1-henryburns@google.com>
In-Reply-To: <20190802015332.229322-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 2 Aug 2019 07:58:00 -0700
Message-ID: <CALvZod414sVwwKg0KAsHC2vhqdkrzLeQ+nV3wiAKvOoFyu8NAQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/zsmalloc.c: Migration can leave pages in ZS_EMPTY indefinitely
To:     Henry Burns <henryburns@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 1, 2019 at 6:53 PM Henry Burns <henryburns@google.com> wrote:
>
> In zs_page_migrate() we call putback_zspage() after we have finished
> migrating all pages in this zspage. However, the return value is ignored.
> If a zs_free() races in between zs_page_isolate() and zs_page_migrate(),
> freeing the last object in the zspage, putback_zspage() will leave the page
> in ZS_EMPTY for potentially an unbounded amount of time.
>
> To fix this, we need to do the same thing as zs_page_putback() does:
> schedule free_work to occur.  To avoid duplicated code, move the
> sequence to a new putback_zspage_deferred() function which both
> zs_page_migrate() and zs_page_putback() call.
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/zsmalloc.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 1cda3fe0c2d9..efa660a87787 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1901,6 +1901,22 @@ static void dec_zspage_isolation(struct zspage *zspage)
>         zspage->isolated--;
>  }
>
> +static void putback_zspage_deferred(struct zs_pool *pool,
> +                                   struct size_class *class,
> +                                   struct zspage *zspage)
> +{
> +       enum fullness_group fg;
> +
> +       fg = putback_zspage(class, zspage);
> +       /*
> +        * Due to page_lock, we cannot free zspage immediately
> +        * so let's defer.
> +        */
> +       if (fg == ZS_EMPTY)
> +               schedule_work(&pool->free_work);
> +
> +}
> +
>  static void replace_sub_page(struct size_class *class, struct zspage *zspage,
>                                 struct page *newpage, struct page *oldpage)
>  {
> @@ -2070,7 +2086,7 @@ static int zs_page_migrate(struct address_space *mapping, struct page *newpage,
>          * the list if @page is final isolated subpage in the zspage.
>          */
>         if (!is_zspage_isolated(zspage))
> -               putback_zspage(class, zspage);
> +               putback_zspage_deferred(pool, class, zspage);
>
>         reset_page(page);
>         put_page(page);
> @@ -2115,15 +2131,9 @@ static void zs_page_putback(struct page *page)
>
>         spin_lock(&class->lock);
>         dec_zspage_isolation(zspage);
> -       if (!is_zspage_isolated(zspage)) {
> -               fg = putback_zspage(class, zspage);
> -               /*
> -                * Due to page_lock, we cannot free zspage immediately
> -                * so let's defer.
> -                */
> -               if (fg == ZS_EMPTY)
> -                       schedule_work(&pool->free_work);
> -       }
> +       if (!is_zspage_isolated(zspage))
> +               putback_zspage_deferred(pool, class, zspage);
> +
>         spin_unlock(&class->lock);
>  }
>
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
