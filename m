Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56363C742DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E66B20850
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 08:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFMyJlnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbfGMIZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 04:25:37 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44397 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfGMIZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 04:25:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id k18so11489792ljc.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 01:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QTd4eX3sc1qUhKub9n3hlO3YZ/+QH5MhW+wPUN67nI=;
        b=VFMyJlnY+HNmqN+/0XkHTCcE4XUlcWBudV8DdALA0mOHLcnTYnfBhIgHqG2Xia3xSO
         U+C7VUV0ICM2Hmaomy7KZ2TG1eODRaAmDL0dWsWvdt5A53muSbUu9XZkAGgJC5+LwetN
         lW8zno8kHgmXJnpTg0QCSv1xy5GT766oLuiTEqraYE9aijU6bOKyd61VOecp57itocUb
         uEaW5eY3ol9CwZOfno3tKtv/y4qBybA/MtM2HH/XVQgHgkbTRq+up5pN6UQN/lTs0L5h
         O7QG8D7CX18kqSuOrowDeVuMJ+jtN/IJaXZHniI7gtVawa9IIz+TkAy60/rj4ho1Fs03
         ZWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QTd4eX3sc1qUhKub9n3hlO3YZ/+QH5MhW+wPUN67nI=;
        b=DO3RG9HQ4OeO4wSSV4WqfMoXSgNKsqNYBpmzlvS0U1ebia+nsNDFxqR8jhuTsEOst8
         xMeTvU3FkhtUKoi7a8n8IyxNJIdj+53t/umEm6xzKvWmEXXYHrGi+g5nK/j1jzDkyEtP
         YRm5FmAv5lKwNFnTarT2oEKa06ON+MpOyLCP7bIb1zXGevmLV5l4CDHUHjcVLaqWFFDK
         3H5ambObSGGVNdoeOynwUNKvZSJY+DFmPqslTEyCN1uCKED0MN1YgBNphvi1ywGOm7yr
         PkXOqkKFj2wqOz0imK8IqMhlP6txYmvk1Rp73ri/e/7c9uFkEdVPfum2zVJqt6DQZXN/
         /5nw==
X-Gm-Message-State: APjAAAWzG2TiGTVQTi/pNYo+pAxf/TSiypwoGhE6qFDsPCUfGXmR37aV
        1MbYW8rFy8R1H1SVu6FStPJ35NE7FJVWWblfnQM=
X-Google-Smtp-Source: APXvYqwp76JJ/0WJFWcpBXbQNkvry0BV51hxWYJa9soCGBmQZQIk3fJZkjhExYfCppqBMazsYp4R4aCwpUGHoXRwkOM=
X-Received: by 2002:a2e:8ed2:: with SMTP id e18mr8207102ljl.235.1563006335346;
 Sat, 13 Jul 2019 01:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190712222118.108192-1-henryburns@google.com>
In-Reply-To: <20190712222118.108192-1-henryburns@google.com>
From:   Vitaly Wool <vitalywool@gmail.com>
Date:   Sat, 13 Jul 2019 10:24:30 +0200
Message-ID: <CAMJBoFNvYP9J=LC2U1McMa2D4=C5szOStzebDd4e2MV6tbpBsw@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Allow __GFP_HIGHMEM in z3fold_alloc
To:     Henry Burns <henryburns@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jonathan Adams <jwadams@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Snild Dolkow <snild@sony.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 12:22 AM Henry Burns <henryburns@google.com> wrote:
>
> One of the gfp flags used to show that a page is movable is
> __GFP_HIGHMEM.  Currently z3fold_alloc() fails when __GFP_HIGHMEM is
> passed.  Now that z3fold pages are movable, we allow __GFP_HIGHMEM. We
> strip the movability related flags from the call to kmem_cache_alloc()
> for our slots since it is a kernel allocation.
>
> Signed-off-by: Henry Burns <henryburns@google.com>

Acked-by: Vitaly Wool <vitalywool@gmail.com>

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
