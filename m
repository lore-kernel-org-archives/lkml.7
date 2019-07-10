Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74432C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 492A9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ianG8POe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbfGJVkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 17:40:08 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34634 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:40:08 -0400
Received: by mail-yb1-f195.google.com with SMTP id x32so1304602ybh.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klmpTKMRhJk0PWQQA2dmLgLN6yYzHWA+paLC90wMAwo=;
        b=ianG8POesm7I23H2706WLKaOHcIeSM/jbJvK3rX1MbMAkRdwmns8fy1bKZC7i9oc3k
         ohbiQFPpzrqOOrzzv+XhRdRFx+/2IAbaOBKTcRklRc+xSnIjtv158DtXLkElnFJIEZQM
         TzWEnN+zO218EByyOBpYZTflZ2HqTf6TV6LFwmZjK1voTtyFxX18k/9gYaEuUuk3J4k+
         K2qKaAYPaowUKNlcmGN4ToMAGbqL6DJO3BYiRM2quEj3iw0xeLuCN0mw/mYqFS+c4/GU
         Zq2v67KPnQzfEEFsI1vt0c2DxD+a+avQP8g97zcsXYKmfHt8Zml5XHrtaheM02XN5BnG
         PdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klmpTKMRhJk0PWQQA2dmLgLN6yYzHWA+paLC90wMAwo=;
        b=UgHZJnBcEeZHw0BXUMpoo0boFVc3vgY+LBhdIu2JBv4ei3xtSiMCO4+x92V2R4x/CI
         2MQwsyh7lCaAOYJ7HYBFcG+YNrQ5KEx4Yiy5FNt4n6UEin98u39qWXuiHt5OIfLnpaWk
         P4lI0T3cBr8vFgOrQ+CQr3a/CoB+JrSsabVFZQxm4yAP0Ex3ZZc47rQqY3WbJi0IrKUd
         APcLIW/2z62w2LqWf5yFu6qNrx4RWzYDYx/R1iv4HRiT+2pnP8pJAQa3bl6ieYxCKMlp
         j0K8mnVKDDMmeiMohb+uwzyw4XvUyYwxeJVRE7MYlruMTiIsM4s8klfmF/cZq3qUAm9p
         peOQ==
X-Gm-Message-State: APjAAAXykgMo246Il3Ol6iwLVNogoegA0TDulIBmV1SbHHuNVTnWvfcP
        ZMDEKtswOTEtDHwZLHHYuECLXDWwQ89Mlq3890/bNA==
X-Google-Smtp-Source: APXvYqw4iXskw6yoB+U4UXJRAYJgfQB2zmNYQyo/PSJcnmTZ3tvplyN8EfCsh0Hao7Yc0XZMOxUHsuZHdRdZtD5D0sE=
X-Received: by 2002:a25:7c05:: with SMTP id x5mr20528ybc.358.1562794807061;
 Wed, 10 Jul 2019 14:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190710213238.91835-1-henryburns@google.com>
In-Reply-To: <20190710213238.91835-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Jul 2019 14:39:55 -0700
Message-ID: <CALvZod7kMX5Xika8nqywyXHuBKqTfSPP7uZ1-OU2M4kmHLiuUw@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: remove z3fold_migration trylock
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

On Wed, Jul 10, 2019 at 2:32 PM Henry Burns <henryburns@google.com> wrote:
>
> z3fold_page_migrate() will never succeed because it attempts to acquire a
> lock that has already been taken by migrate.c in __unmap_and_move().
>
> __unmap_and_move() migrate.c
>   trylock_page(oldpage)
>   move_to_new_page(oldpage_newpage)
>     a_ops->migrate_page(oldpage, newpage)
>       z3fold_page_migrate(oldpage, newpage)
>         trylock_page(oldpage)
>
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

Please add the Fixes tag as well.

> ---
>  mm/z3fold.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 985732c8b025..9fe9330ab8ae 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1335,16 +1335,11 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>         zhdr = page_address(page);
>         pool = zhdr_to_pool(zhdr);
>
> -       if (!trylock_page(page))
> -               return -EAGAIN;
> -
>         if (!z3fold_page_trylock(zhdr)) {
> -               unlock_page(page);
>                 return -EAGAIN;
>         }
>         if (zhdr->mapped_count != 0) {
>                 z3fold_page_unlock(zhdr);
> -               unlock_page(page);
>                 return -EBUSY;
>         }
>         new_zhdr = page_address(newpage);
> @@ -1376,7 +1371,6 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>         queue_work_on(new_zhdr->cpu, pool->compact_wq, &new_zhdr->work);
>
>         page_mapcount_reset(page);
> -       unlock_page(page);
>         put_page(page);
>         return 0;
>  }
> --
> 2.22.0.410.gd8fdbe21b5-goog
>
