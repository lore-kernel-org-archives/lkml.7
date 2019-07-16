Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D312C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7655E21743
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzkioEkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388588AbfGPVUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:20:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41004 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfGPVUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:20:41 -0400
Received: by mail-yw1-f68.google.com with SMTP id i138so9557191ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JJ9YJBDa6TAoDZnqGKrJ33E8HHSw9cbft8xMZfhrH5o=;
        b=mzkioEkQusJ5+fSK27pN+Vp0ac4Y/hSwdtz9EBb/CGG+fQfnQpfNVJ4Nrn//Qzq2Sm
         ylEq8N1PhAUCbcJRX7iDYz/lqELXX2RiXjjyA9ljx3qmwq0sONvfWl06a0Mn5ntJGU6S
         HM8qXNVmfSIdYce6w4BJPgEs8i9O3VairrVzwHC66pvik4T4SSVAO2jeohAOuANIq7P5
         cOsnhIMLJ526MbaDy6UjqAUEBr5hfXPe3Pucn/DrRLtbgSOnYK2+TE+ycQrWwf/kwoyM
         viQZLFx2ns8ebYgjZTz5eJCXtIgbh8+iMOJJfoPte0qOVJWIBE8ftoyCOtoXBRrl1p2k
         qiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JJ9YJBDa6TAoDZnqGKrJ33E8HHSw9cbft8xMZfhrH5o=;
        b=EGbiUvbHjot4SJFNrPaACxQNLgau2n9+bW3VPoUq7lnqt8daO0kb6fTcqsPHNHpJZ1
         Rth9609go2JtqhfehgEsCMge7aQgxkiXlRI+B/LridN0EtAy75eJZxZ3EzerOR/b8q7J
         vka1VeLlvn0zIMeyTP6dusoo2boAzuav9Yj8dxJxMxf83yhTc4YRnangKcGLc4pCqA/I
         FgMGddXDj57zdiq47TdLDfDgrViQLC/AkPNBGpkLTNTq1/5I5Bkc729lPHmg8BE5/d1Y
         ALSJcjJj+U2Zns9Mrz2nvt7II7ep57NNvoR+HIgCC3p1cr6LLJAAUXCNPRpTHweIj5cn
         BAvA==
X-Gm-Message-State: APjAAAWdyVpeJwTKPejV1eyo7g2FXTLC9xrJurOtpHGaXZ+leXVXZ/QO
        UKlPn+5vm8juTXHL10b7wC3pDg9U8hg7SXoe2l6u+g==
X-Google-Smtp-Source: APXvYqxIk0Kusbyfed606KNi4eGPzY+cdM8lYWMrMR8rMZ/4PdfezbgsydDu8UR4zXJIqhguZ5+jeBmCzF6RdAVtQ7s=
X-Received: by 2002:a0d:cb42:: with SMTP id n63mr21966936ywd.205.1563312039498;
 Tue, 16 Jul 2019 14:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190716000520.230595-1-henryburns@google.com>
In-Reply-To: <20190716000520.230595-1-henryburns@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jul 2019 14:20:28 -0700
Message-ID: <CALvZod46LCSyCJEuBr_0yLjAbg_fJc+qr9-NNU5mbio8mqM1ag@mail.gmail.com>
Subject: Re: [PATCH v2] mm/z3fold.c: Reinitialize zhdr structs after migration
To:     Henry Burns <henryburns@google.com>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Adams <jwadams@google.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 5:05 PM Henry Burns <henryburns@google.com> wrote:
>
> z3fold_page_migration() calls memcpy(new_zhdr, zhdr, PAGE_SIZE).
> However, zhdr contains fields that can't be directly coppied over (ex:
> list_head, a circular linked list). We only need to initialize the
> linked lists in new_zhdr, as z3fold_isolate_page() already ensures
> that these lists are empty
>
> Additionally it is possible that zhdr->work has been placed in a
> workqueue. In this case we shouldn't migrate the page, as zhdr->work
> references zhdr as opposed to new_zhdr.
>
> Fixes: bba4c5f96ce4 ("mm/z3fold.c: support page migration")
> Signed-off-by: Henry Burns <henryburns@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  Changelog since v1:
>  - Made comments explicityly refer to new_zhdr->buddy.
>
>  mm/z3fold.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 42ef9955117c..f4b2283b19a3 100644
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
> +        * z3fold_page_isolate() ensures that new_zhdr->buddy is empty,
> +        * so we only have to reinitialize it.
> +        */
> +       INIT_LIST_HEAD(&new_zhdr->buddy);
>         new_mapping = page_mapping(page);
>         __ClearPageMovable(page);
>         ClearPagePrivate(page);
> --
> 2.22.0.510.g264f2c817a-goog
>
