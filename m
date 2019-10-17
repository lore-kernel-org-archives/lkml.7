Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF3ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD27120820
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CY7kEgnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394338AbfJQRnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:43:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44471 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfJQRnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:43:51 -0400
Received: by mail-qk1-f193.google.com with SMTP id u22so2643858qkk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3x7NlEAC5EYOu09JqrgZJ296V2WMd3xAO3Y+EYxmHLs=;
        b=CY7kEgnqE1dSycu7e2cMUC4XFvL45b5+a0TCSRgf6WAQlH5mVU8Yb69lb8YQHZItg2
         bR32RuCpS4ZgGWUsQRTas585CHRgXWZrGHGI8MAMyhU8GWc9ItL9YCti0COms8+teyU/
         uJkea1oo1X3L5z9d4wKuiV3lUPV3cSebKudwLnZuPBPoeEJ/AkLcag79WYSfB36kE6WO
         tKIMv+ZkNpRHAqpJAVwTWUqiQH3pCzUNhL+yjlAG7z+18zSeVQK1nXdLQKteaNetHuYp
         ihZxvCaRws7ORZ2K2VBk4778SUOVg1P8h9RMUM9LHBIayJQUcTV6zgTbJbF+pGB/qRRn
         P1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3x7NlEAC5EYOu09JqrgZJ296V2WMd3xAO3Y+EYxmHLs=;
        b=PgQI1WAoCYld6+J+389oBXIMN+tR1FfMzmmcCStw9T5GJNyz+g+Ltodhohgoj6vj+R
         jvIHATPFxDFlCU7iRxRuXK2TTxTIsChB7W50yDQaWM//ktytM8nUWIp0LeoKFHyrqDXS
         uhXnXdJE2YhFRBe677PT85kw4vnBAiVFvHEDEOWjPubmjQVVKasNsUN0pfv1VhRwoSvr
         C3QOFShuxgCqkbgv1Y0sZ3XyV3p0Bg4BVqsaEGAICVpglrT19XM5Qjj2kH8SVNoz4qxc
         ALxo2cfHTI8uX4f6yd8qAsoQofYt0ShZMKQNhRnukmIBVapmEo7e6aR3QuB3jGGL6XVC
         g7vg==
X-Gm-Message-State: APjAAAWYbwNnf70QmLPDDY267FLr5fDy9YQJf1Ph1OHyydjS46kMcqRm
        virVmGWgo0IbVcp/WH8bOHCMYscQI1u+MYmNCFA=
X-Google-Smtp-Source: APXvYqwL8OY2KnqIbLso1VQDKZykK7fwLyzry2OS+LgT9ONf3XCgMt8I/2qFQ4XBJWwEAVXE8oAxEEYBcCUFpOXXc+I=
X-Received: by 2002:a37:4ac8:: with SMTP id x191mr4659628qka.85.1571334230217;
 Thu, 17 Oct 2019 10:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191017164223.2762148-1-songliubraving@fb.com> <20191017164223.2762148-4-songliubraving@fb.com>
In-Reply-To: <20191017164223.2762148-4-songliubraving@fb.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Oct 2019 10:43:39 -0700
Message-ID: <CAHbLzkrYPF8V9hCsQfT3DfdEAWZw2gCXjHgB-vmsWXhm3VVXtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mm: Support removing arbitrary sized pages from mapping
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        matthew.wilcox@oracle.com, kernel-team@fb.com,
        william.kucharski@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 9:42 AM Song Liu <songliubraving@fb.com> wrote:
>
> From: William Kucharski <william.kucharski@oracle.com>
>
> __remove_mapping() assumes that pages can only be either base pages
> or HPAGE_PMD_SIZE.  Ask the page what size it is.
>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

> ---
>  mm/vmscan.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c6659bb758a4..f870da1f4bb7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -932,10 +932,7 @@ static int __remove_mapping(struct address_space *mapping, struct page *page,
>          * Note that if SetPageDirty is always performed via set_page_dirty,
>          * and thus under the i_pages lock, then this ordering is not required.
>          */
> -       if (unlikely(PageTransHuge(page)) && PageSwapCache(page))
> -               refcount = 1 + HPAGE_PMD_NR;
> -       else
> -               refcount = 2;
> +       refcount = 1 + compound_nr(page);
>         if (!page_ref_freeze(page, refcount))
>                 goto cannot_free;
>         /* note: atomic_cmpxchg in page_ref_freeze provides the smp_rmb */
> --
> 2.17.1
>
>
