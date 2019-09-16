Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B02AC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA72214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 17:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itokVSgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbfIPRWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 13:22:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38412 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732010AbfIPRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 13:22:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so772583qta.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 10:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDB8uHDkgWN7+yrcA0FfYLtoe+OjSqFeu+VWqQjDn9I=;
        b=itokVSglbnepYieFIOvlt/0B3BXlO2wgztzBJWDXit/kUzBppinOuLRUPbgVctrnlE
         Xs+7vvbrQmv5LYTPN8Wi3loVrc108cIzN/YQvdjW58ZaCN1lxKsfH755TlliYEDnabFH
         A6WLXRApELiiGrDYIhNaJmFqjk1rRQj8JGsvkRpjxxt/+4wIR/RL6IlQ+xsmQcufDL7o
         ZDPk0v3tELCnCOKzUeZ18e+1iUzx5Em5giLoGWX8xcf5XUa0y/2VtVvSwBdNKuksYWWv
         7whgoxnQEbZaqzK6mw2wouJQuGpYXPtqo/fSx/BrIsKjoa1325vMHR+2yfKQL6/nV+WS
         FIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDB8uHDkgWN7+yrcA0FfYLtoe+OjSqFeu+VWqQjDn9I=;
        b=gRb6gBMSD58iPknYJwYgfmgIAY1S+XrEyc540Dq6iMCxfKHNruw7bsLMV422dcuMgo
         isAoXaaqM8VHALydaNgDCyi2kJngsSe9JwG5lABqZJrs/SgDFuoZsxPlIXSeXkfgTk7S
         ug/Yx7vZB0Q5rueqo4fo52gSLpAE3oyW972H+cvkMSsntALubIIIQXrPr8ad+iJQYUm5
         2T+ybF9pFCX5AuxW0z9dQucICUbjaSIc+CGjDjvXYU0W+XW+XLj4K4aeu3hKAWS323vJ
         BeGXX0sK4KOTnnFrp/WIbPgjLIc+ec0V8GM15KvmnqLPhAsbd/AgJygwRP9ev8zTKhsI
         8qdg==
X-Gm-Message-State: APjAAAUQO+dF3YdrLLCmsVYlmY8xGtMIAmSbwe4kscdeh0NIECgnYbGn
        ceFpXeouc/jelldIVlNVzgdBRz20jINd9rzL05Q=
X-Google-Smtp-Source: APXvYqyNxf9P5+HIEk2snNUL/kA+YguGWoN9sH1Euy3GdsF7mtVDOmDSkV7CR8UtRX+Q28d8U1CmoEHgealLu8qcH9g=
X-Received: by 2002:ac8:f33:: with SMTP id e48mr720765qtk.123.1568654555208;
 Mon, 16 Sep 2019 10:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190913091849.11151-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190913091849.11151-1-kirill.shutemov@linux.intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 16 Sep 2019 10:22:18 -0700
Message-ID: <CAHbLzkq7JT=KE9R_W6YfXmBJBeESgXZvdReS30sH8no63YQE0Q@mail.gmail.com>
Subject: Re: [PATCH] mm, thp: Do not queue fully unmapped pages for deferred split
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 2:18 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Adding fully unmapped pages into deferred split queue is not productive:
> these pages are about to be freed or they are pinned and cannot be split
> anyway.

This change looks good to me. Reviewed-by: Yang Shi <yang.shi@linux.alibaba.com>

>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  mm/rmap.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 003377e24232..45388f1bf317 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1271,12 +1271,20 @@ static void page_remove_anon_compound_rmap(struct page *page)
>         if (TestClearPageDoubleMap(page)) {
>                 /*
>                  * Subpages can be mapped with PTEs too. Check how many of
> -                * themi are still mapped.
> +                * them are still mapped.
>                  */
>                 for (i = 0, nr = 0; i < HPAGE_PMD_NR; i++) {
>                         if (atomic_add_negative(-1, &page[i]._mapcount))
>                                 nr++;
>                 }
> +
> +               /*
> +                * Queue the page for deferred split if at least one small
> +                * page of the compound page is unmapped, but at least one
> +                * small page is still mapped.
> +                */
> +               if (nr && nr < HPAGE_PMD_NR)
> +                       deferred_split_huge_page(page);
>         } else {
>                 nr = HPAGE_PMD_NR;
>         }
> @@ -1284,10 +1292,8 @@ static void page_remove_anon_compound_rmap(struct page *page)
>         if (unlikely(PageMlocked(page)))
>                 clear_page_mlock(page);
>
> -       if (nr) {
> +       if (nr)
>                 __mod_node_page_state(page_pgdat(page), NR_ANON_MAPPED, -nr);
> -               deferred_split_huge_page(page);
> -       }
>  }
>
>  /**
> --
> 2.21.0
>
>
