Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D876C74A36
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03355208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un30DGda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfGJUvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:51:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39759 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfGJUvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:51:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id x74so1272105ywx.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtC5egLkr6FDak2iWiMiUha4yDwOlLCqb/iy6dvufbg=;
        b=un30DGdaaLTQqc9ulK9wePQZNwiEhBjveMWrvXlg8hVi2xvd+N8P2TXZEoi0WRxMdO
         llLXQjc8o0YK/GKoMM6Mks5D9YzdX5CrXqHUuepOEt99nRpwRW2rjT+WTCSeOQeeYhNY
         HkQJ/viI0xOIijcFCm8BT6F198ZZtsZfO85NmX7p8L3RZpoZF05hYiP5r80MbRionfnI
         KWsMsDligc3KwH/zocEMYeQo0LG5TkO/fPLkkVqoP7ez4YTr4+pklJjpeAOmu3yBa4NT
         XJlnM40YCOwVJubuwzLuIBGosoCyia3oKOEQxKKrSm5FRr2HoaOvlNKs3gNAdhg2r2WH
         x7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtC5egLkr6FDak2iWiMiUha4yDwOlLCqb/iy6dvufbg=;
        b=l/QTW3WNA6kcT3usiIyOagkqmTha9/Y7wDWK0OhT2QfFHH3AN05bDJmCVxA9ibRYxj
         pMxsZK0nuvy7yx7lDr71bQQy+XRBxfge3DUQX1MAQQsKODFTsvPxGnrsYuRYA6bBKEbf
         P8I1vK+As5RJhUBVo3p10JQLhwm1r9X4RN0PYwFSrG5TSyueguMlCG6sNfvyddkPBMfC
         AjxZWqFaA2zCw+QxKhEFtFDmcM2l/a5+n45sQcjAivJEYwoYHn8OXoDb3/c80JtCLDfS
         Z9wegMDglMxLWIjYB852sdAZ10da8UbA3xeZEOZ1mAN3pLzofRAHblo4HeHplDpkzdCE
         SArQ==
X-Gm-Message-State: APjAAAXDW06FzEHHp+uWLIFOYSGIlyU3+qyqXcrabRXnF/QTSh5jBqV8
        NSmS7+LjyFhF0+4HT5F1RTHv2Clz+nUCOPOrIVkTNA==
X-Google-Smtp-Source: APXvYqxrw4tF1qH2dtA3sf+vEsBsubI1n/tNaDi+JHo5Z4S27DzhSyZT3l5HStwbMbR0DBnVdtBXrRSGebZ3IdMezPk=
X-Received: by 2002:a0d:c345:: with SMTP id f66mr19381788ywd.10.1562791859824;
 Wed, 10 Jul 2019 13:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190708134808.e89f3bfadd9f6ffd7eff9ba9@gmail.com>
In-Reply-To: <20190708134808.e89f3bfadd9f6ffd7eff9ba9@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 10 Jul 2019 13:50:48 -0700
Message-ID: <CALvZod7Qfj+Jer1TK4P-HmoQ0now=w2JK7NNrfC6ae8R0cOLcA@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: don't try to use buddy slots after free
To:     Vitaly Wool <vitalywool@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Henry Burns <henryburns@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Adams <jwadams@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 4:48 AM Vitaly Wool <vitalywool@gmail.com> wrote:
>
> From fd87fdc38ea195e5a694102a57bd4d59fc177433 Mon Sep 17 00:00:00 2001
> From: Vitaly Wool <vitalywool@gmail.com>
> Date: Mon, 8 Jul 2019 13:41:02 +0200
> [PATCH] mm/z3fold: don't try to use buddy slots after free
>
> As reported by Henry Burns:
>
> Running z3fold stress testing with address sanitization
> showed zhdr->slots was being used after it was freed.
>
> z3fold_free(z3fold_pool, handle)
>   free_handle(handle)
>     kmem_cache_free(pool->c_handle, zhdr->slots)
>   release_z3fold_page_locked_list(kref)
>     __release_z3fold_page(zhdr, true)
>       zhdr_to_pool(zhdr)
>         slots_to_pool(zhdr->slots)  *BOOM*
>
> To fix this, add pointer to the pool back to z3fold_header and modify
> zhdr_to_pool to return zhdr->pool.
>
> Fixes: 7c2b8baa61fe  ("mm/z3fold.c: add structure for buddy handles")
>
> Reported-by: Henry Burns <henryburns@google.com>
> Signed-off-by: Vitaly Wool <vitalywool@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/z3fold.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 985732c8b025..e1686bf6d689 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -101,6 +101,7 @@ struct z3fold_buddy_slots {
>   * @refcount:          reference count for the z3fold page
>   * @work:              work_struct for page layout optimization
>   * @slots:             pointer to the structure holding buddy slots
> + * @pool:              pointer to the containing pool
>   * @cpu:               CPU which this page "belongs" to
>   * @first_chunks:      the size of the first buddy in chunks, 0 if free
>   * @middle_chunks:     the size of the middle buddy in chunks, 0 if free
> @@ -114,6 +115,7 @@ struct z3fold_header {
>         struct kref refcount;
>         struct work_struct work;
>         struct z3fold_buddy_slots *slots;
> +       struct z3fold_pool *pool;
>         short cpu;
>         unsigned short first_chunks;
>         unsigned short middle_chunks;
> @@ -320,6 +322,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
>         zhdr->start_middle = 0;
>         zhdr->cpu = -1;
>         zhdr->slots = slots;
> +       zhdr->pool = pool;
>         INIT_LIST_HEAD(&zhdr->buddy);
>         INIT_WORK(&zhdr->work, compact_page_work);
>         return zhdr;
> @@ -426,7 +429,7 @@ static enum buddy handle_to_buddy(unsigned long handle)
>
>  static inline struct z3fold_pool *zhdr_to_pool(struct z3fold_header *zhdr)
>  {
> -       return slots_to_pool(zhdr->slots);
> +       return zhdr->pool;
>  }
>
>  static void __release_z3fold_page(struct z3fold_header *zhdr, bool locked)
> --
> 2.17.1
