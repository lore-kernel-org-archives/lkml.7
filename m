Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B58C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1E22182B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 00:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnWMeilq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfEJAkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 20:40:10 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43201 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfEJAkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 20:40:10 -0400
Received: by mail-yw1-f65.google.com with SMTP id p19so3361057ywe.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 17:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kJIkcAZ6u5IJ9XmF7NOxVNNYB8HdaXRsalPuY1w3/z8=;
        b=BnWMeilq5CmV7xEOS7UTY0R8GZBvNiJUb5X8thIrkLC146CGJ28ux8O51ka94luUji
         ko51fW4KRyCWVOi/von/XCjTv5Bq+D0G0m8PuWDLMU8pmLoHkVAidAi/9MCw72ZNpUBN
         q7xTRHcayJCQmsiAPDShWGpwdLShGMWkoOMABic60GtN3IaFoPIX9eSVsFIkBfxpV7pe
         K1YZw/DNtI7wDyhVsKXKTR6evCj+wKBM/ZCKAVbXjVWRlyOHkScfk3FLQ4FnRkjbDi/x
         TcZbJlD57h5bUMnjLqNuuD1i4+gmaFje2JyxaP3cHRb97P+2aaN1Ctg2LNMnSUH9vTQS
         7NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kJIkcAZ6u5IJ9XmF7NOxVNNYB8HdaXRsalPuY1w3/z8=;
        b=XjOykYOugB4g4P25IVFy3WH4Z5a50QsfMmVjASHrW7ZhwAI9PI0dw2phM7cBW+ZRbQ
         ICGy7YdZqAseKKCC1ma6/0cS8iz6TccnJOp1nW/EfhzakF2mHudlHQa9BYB9UjdDgxq0
         xRmgHlUr2mgoCzYlKkMgov/xGJAl/yZxyZLTDJfyVEq6IKxwIi7GWyGXCc8bUEnybq2Q
         YfoTWsVHaLhLiZtPriQ4RgLDXuEIrimlOkdwVSSTZMM3z9Sfcxpj33dY//PhIh7A8D/L
         RDgiz0/tmRHAHmXsO7rQfPE8fgw9F7aDQm9ASNzWz4cQGbglrAzzzSwWxJj23RmyDofr
         rtSQ==
X-Gm-Message-State: APjAAAW/EQ68gXSJkrTUR8I6T2uyGuTMhp6Aq6Bc13GKPn1XmMxcjoxN
        qKaIyzPW596OKSOVh4XsCmmB3ESi0JO4S7BSI9plPA==
X-Google-Smtp-Source: APXvYqw2dVC2ET7GPFNXeSlt/NpFnxG8e1iXqGKojoN4LujAfzUVvhzsWFouCtyUPIv6d5hMLtOYG5Es5WGTXBS03mU=
X-Received: by 2002:a25:4147:: with SMTP id o68mr4131573yba.148.1557448809031;
 Thu, 09 May 2019 17:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1557447392-61607-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 9 May 2019 17:39:57 -0700
Message-ID: <CALvZod5LjCMxsPhbY68QRggFy4QjVsTDXh192PqSW6qsMCKknw@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: correct nr_reclaimed for THP
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Huang Ying <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Shi <yang.shi@linux.alibaba.com>
Date: Thu, May 9, 2019 at 5:16 PM
To: <ying.huang@intel.com>, <hannes@cmpxchg.org>, <mhocko@suse.com>,
<mgorman@techsingularity.net>, <kirill.shutemov@linux.intel.com>,
<hughd@google.com>, <akpm@linux-foundation.org>
Cc: <yang.shi@linux.alibaba.com>, <linux-mm@kvack.org>,
<linux-kernel@vger.kernel.org>

> Since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
> swapped out"), THP can be swapped out in a whole.  But, nr_reclaimed
> still gets inc'ed by one even though a whole THP (512 pages) gets
> swapped out.
>
> This doesn't make too much sense to memory reclaim.  For example, direct
> reclaim may just need reclaim SWAP_CLUSTER_MAX pages, reclaiming one THP
> could fulfill it.  But, if nr_reclaimed is not increased correctly,
> direct reclaim may just waste time to reclaim more pages,
> SWAP_CLUSTER_MAX * 512 pages in worst case.
>
> This change may result in more reclaimed pages than scanned pages showed
> by /proc/vmstat since scanning one head page would reclaim 512 base pages.
>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Nice find.

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
> I'm not quite sure if it was the intended behavior or just omission. I tried
> to dig into the review history, but didn't find any clue. I may miss some
> discussion.
>
>  mm/vmscan.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index fd9de50..7e026ec 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1446,7 +1446,11 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>
>                 unlock_page(page);
>  free_it:
> -               nr_reclaimed++;
> +               /*
> +                * THP may get swapped out in a whole, need account
> +                * all base pages.
> +                */
> +               nr_reclaimed += (1 << compound_order(page));
>
>                 /*
>                  * Is there need to periodically free_page_list? It would
> --
> 1.8.3.1
>
