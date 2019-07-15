Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62666C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3700620838
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 17:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCelnzTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbfGORWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 13:22:48 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45898 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730566AbfGORWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 13:22:48 -0400
Received: by mail-yb1-f196.google.com with SMTP id s41so3710068ybe.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 10:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UscG4WxjnjQLRRcfnLMqxRe1yzGwBuLWPpq8Fn0xt8Q=;
        b=dCelnzTW9yVty3d0zlRTYG3AJUta/BwdSagZLphy7SUDCPw0lYhayrZl5azIY8Po6K
         B6PcLuuOJVyIxwiflObjLQxgwM5LdzBm9j2APNC/1sPWiDeIVumlaaSR3cBownQl1gZ7
         cmNM24365G9Kw33r/XyMye07LnJCa0G4XuKu3nH+stcJAD3HS2uHdNOlq2NHdW329Kw2
         jEJCSCUJ5tFA21J/y5+gY4zuSpH9pE+SJy2MUjCxIUX/v4EZqtd+ycfE4D0VdA/uMj+1
         lQiPTa3FPre/OAiF6DLgOrahbWMjYOGi4K0cps9eFLAe/W937jrg8dyOuSOGvbo+fxxf
         TPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UscG4WxjnjQLRRcfnLMqxRe1yzGwBuLWPpq8Fn0xt8Q=;
        b=MMOJjvwL176Sza2zrmPUbEG5lFZ3BAX8mzbGf9K2VsRHQwlktpmZpg3SlwBUQCndMe
         qyBbjCAG4xpRQfLxMioWy0uMifyg2E+1qqGGmLiUxomsOgWV8iadKw06dy3yrOR/WgNQ
         NmED8TDQHXC8D8TDo5alWGRCi8ulWadZcTnRDMeQisu4YE2D6Ry7cpXD+q9IACpGEUKZ
         h4tYcgL4qE1/7nNGviyh/XAXClqtqPwk41QlrQj4sFnC1mBhFGge87AfrOBZrw8KCCea
         /hTlNZAx1y3KTCWOcUNpFzos5CHxZjrQKWIsDmzkZqirnxis4TZTyQxH9V5NSLsiaVn+
         rk2w==
X-Gm-Message-State: APjAAAVoCrIzwCdvpw+vzb8AjARbX4iivG0E5jQrTTjkycTh6pmyXZ0A
        6m7LoU4IwS0O+z02icpTScZdblva7Q4ERc568tskLA==
X-Google-Smtp-Source: APXvYqwD4/nxpkfvH9bQCh/AJuvk/pIr8m7HB8haGrUylB3B6/r9kLVpIkwVT3ZqE0R7QG11+C5RIC8Tuuc4Lid14w8=
X-Received: by 2002:a25:7c05:: with SMTP id x5mr16996019ybc.358.1563211367257;
 Mon, 15 Jul 2019 10:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190715164705.220693-1-henryburns@google.com>
In-Reply-To: <20190715164705.220693-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 15 Jul 2019 10:22:36 -0700
Message-ID: <CALvZod73xAMUT0-zEHZO+J5xRa7HLhKobaDzchpT-CxiPtKTRg@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Reinitialize zhdr structs after migration
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Wool <vitalywool@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Vul <vitaly.vul@sony.com>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 9:47 AM Henry Burns <henryburns@google.com> wrote:
>
> z3fold_page_migration() calls memcpy(new_zhdr, zhdr, PAGE_SIZE).
> However, zhdr contains fields that can't be directly coppied over (ex:
> list_head, a circular linked list). We only need to initialize the
> linked lists in new_zhdr, as z3fold_isolate_page() already ensures
> that these lists are empty.
>
> Additionally it is possible that zhdr->work has been placed in a
> workqueue. In this case we shouldn't migrate the page, as zhdr->work
> references zhdr as opposed to new_zhdr.
>
> Fixes: bba4c5f96ce4 ("mm/z3fold.c: support page migration")
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/z3fold.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 42ef9955117c..9da471bcab93 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -1352,12 +1352,22 @@ static int z3fold_page_migrate(struct address_space *mapping, struct page *newpa
>                 z3fold_page_unlock(zhdr);
>                 return -EBUSY;
>         }
> +       if (work_pending(&zhdr->work)) {
> +               z3fold_page_unlock(zhdr);
> +               return -EAGAIN;
> +       }
>         new_zhdr = page_address(newpage);
>         memcpy(new_zhdr, zhdr, PAGE_SIZE);
>         newpage->private = page->private;
>         page->private = 0;
>         z3fold_page_unlock(zhdr);
>         spin_lock_init(&new_zhdr->page_lock);
> +       INIT_WORK(&new_zhdr->work, compact_page_work);
> +       /*
> +        * z3fold_page_isolate() ensures that this list is empty, so we only
> +        * have to reinitialize it.
> +        */
> +       INIT_LIST_HEAD(&new_zhdr->buddy);
>         new_mapping = page_mapping(page);
>         __ClearPageMovable(page);
>         ClearPagePrivate(page);
> --
> 2.22.0.510.g264f2c817a-goog
>
