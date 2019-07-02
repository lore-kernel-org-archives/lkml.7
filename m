Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F33C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F7C206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 01:04:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S0GY9y8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfGBBAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 21:00:44 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35863 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfGBBAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 21:00:43 -0400
Received: by mail-yb1-f196.google.com with SMTP id t10so741399ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLKaclKnF/wxygehnw0ZhA/GQEsmphWVTGozX4zGxLc=;
        b=S0GY9y8C/Fi0sdyS/zcdqZr9tVAkG5ce7/IOGJ3enKy5/OPj2sokEMJIsSjkOxTADB
         +PtoAyiTYcYXDCup7vpukfHspqp6SPItVVG7fCAF9A7iH/K7i3vvprAhA5I61pfwHIct
         o0ZHa1L67jnNDgQ7MUaWUBb2jJbsO1a1qzkko2H6PTDkLBNOFIUlXB1hdoYyLycvv5uN
         g7VyrmxhBLq94kxQgJ39x6KgRKFiBHeg9BQNXXjtYiTLC8ExSo86WvdKD6UrovqjrGFG
         VzdM3uYqXrjYPX/v6yBewSkqjx/4mfssMGnUzTKLgYPCc3fgIIBf3gUIRChLsfhcY2Yp
         Mutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLKaclKnF/wxygehnw0ZhA/GQEsmphWVTGozX4zGxLc=;
        b=FnRTh4aGd+hOwuIAYrJmfpbZOWIJq3i6aG/L9VgJklmYCPESMsYCQFHDk6XsEtm6Pj
         hIZU8KH5Y5bEInIZfdOrrrswZIpJyPIDw4jNWPT11g4YpMb3mYmOZiMlltMUyyZ+tUv8
         j7gnwbewSYsG9ZuQvG2lUs/p2MU/WfDBSIMzJWuO+WE0+t9cigMn8dIY4DHwUdET/J2q
         BTLuy39ROB32AnYR4APanv+d9qNACS3Lg8XhHwEsUKtKrVhpqEQJ9baKNszug2sKzAh1
         KvhhrmfLAj5oZajg2bdix2ify61VlCo4r1olGW/5FtjOQMGXpbPBmSd50x9V/C5lW5nh
         uGKg==
X-Gm-Message-State: APjAAAU+OKNLSZbwTD7PLKDDADEmWMh8cPYx5C60Lx0/3N5a0KcxZjYK
        H3XUY5+OjWcZ8uHB2XM6hv9YuNKHPpFZ0MED06+faA==
X-Google-Smtp-Source: APXvYqzOaefDFiVFWymQi9oWxw+On0j/dhwOjHPPdiSEDz5QwOyBU1Adr/aXtUeEIa5jaD4wiTcCCpEQKsZhQTgq9tw=
X-Received: by 2002:a25:7c05:: with SMTP id x5mr17362245ybc.358.1562029242861;
 Mon, 01 Jul 2019 18:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190702005122.41036-1-henryburns@google.com>
In-Reply-To: <20190702005122.41036-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 1 Jul 2019 18:00:31 -0700
Message-ID: <CALvZod5Fb+2mR_KjKq06AHeRYyykZatA4woNt_K5QZNETvw4nw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Lock z3fold page before __SetPageMovable()
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Xidong Wang <wangxidong_97@163.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 5:51 PM Henry Burns <henryburns@google.com> wrote:
>
> __SetPageMovable() expects it's page to be locked, but z3fold.c doesn't
> lock the page. Following zsmalloc.c's example we call trylock_page() and
> unlock_page(). Also makes z3fold_page_migrate() assert that newpage is
> passed in locked, as documentation.
>
> Signed-off-by: Henry Burns <henryburns@google.com>
> Suggested-by: Vitaly Wool <vitalywool@gmail.com>
> ---
>  Changelog since v1:
>  - Added an if statement around WARN_ON(trylock_page(page)) to avoid
>    unlocking a page locked by a someone else.
>
>  mm/z3fold.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index e174d1549734..6341435b9610 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -918,7 +918,10 @@ static int z3fold_alloc(struct z3fold_pool *pool, size_t size, gfp_t gfp,
>                 set_bit(PAGE_HEADLESS, &page->private);
>                 goto headless;
>         }
> -       __SetPageMovable(page, pool->inode->i_mapping);
> +       if (!WARN_ON(!trylock_page(page))) {
> +               __SetPageMovable(page, pool->inode->i_mapping);
> +               unlock_page(page);
> +       }

Can you please comment why lock_page() is not used here?

>         z3fold_page_lock(zhdr);
>
>  found:
> @@ -1325,6 +1328,7 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>
>         VM_BUG_ON_PAGE(!PageMovable(page), page);
>         VM_BUG_ON_PAGE(!PageIsolated(page), page);
> +       VM_BUG_ON_PAGE(!PageLocked(newpage), newpage);
>
>         zhdr = page_address(page);
>         pool = zhdr_to_pool(zhdr);
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
