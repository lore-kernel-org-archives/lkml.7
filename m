Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F43020663
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZzlc6ST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388965AbfJXT0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:26:42 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42468 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfJXT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:26:41 -0400
Received: by mail-qk1-f194.google.com with SMTP id m4so7583900qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 12:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+CzAtbw8jtnXuNwdGiXIAgWX3ZpOEqfrbMNOOMcZeA=;
        b=HZzlc6STA7Inz7B4IqH/Phjkj29ALzhIseK/7OdIc5B6QuDilMBW0dzSe8/kf2J9lb
         1JoD0GIEvGoICGWTsHH4MH+xsyFb93LsAFmlSqr853s1sEyQKtF1j67jxXzepYlPG3m1
         NitbB5EoyOgX+d7d70b6mzaXVeWAH2ir6yVtpqiiREkq/aEgqwbrASSBgp1x7ti/HCAV
         lHmvLrTVayekjd7PdCkrmUxcPuIvahJDPZwRdF6N8w5mGMtgUNsr9nqtYX+YiQiLjeFa
         ovJNtdJ1xcIQYMjiB+L+n8HUeTk+2huOOgqBC0sRFpK1KW3uYGK9P0b4iHpH/n8HPRtT
         00Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+CzAtbw8jtnXuNwdGiXIAgWX3ZpOEqfrbMNOOMcZeA=;
        b=l8921puY9lJzZSHm1vD/W5E/AZlP31U7UsSu2rXgRqTz8qH7bRYcZfzt1waDW4KUJ5
         /WSx/xvujHDFTtHO/6o9++LEfwZZ9Tx3PuHc3X6CDPrIFV1gTMFkRJjUQBloIm5hdjWl
         o3M50oqV+DYReAbw53dX/FI0grFr+WGV+c+ku77DK10/U5aEGCf647O3BWqwQ3Wh79qE
         u3KxBQCgYtKVFR3V4+GiQM6KT6wgkmZtUouEJtZPTkHYtoCUJCwszscBu2gXh0ZD5xwI
         sV04W0pVH95xDKAQpGEOLjJyItEEHyoDGF+i/nWZu8nD399ibKFnVxpBL0b8gCiO1ZEg
         Ltxg==
X-Gm-Message-State: APjAAAUgYegbrWV42OBqciLl1yNDkPMHX4NxNaGBjXMRRARIfhvuDVxC
        P7uZh2HF9a7yaNV7zEP9UpPi2jRZKYeyv811vSM=
X-Google-Smtp-Source: APXvYqx+0y4wH+73RucQWwC1E1dyvBkv470jOt4TQuya1MH+R3kIBaQ++6ZVNm5n21pRzWUioLgEmx6yPO9r+v+KLrM=
X-Received: by 2002:a37:4f88:: with SMTP id d130mr15747600qkb.168.1571945200852;
 Thu, 24 Oct 2019 12:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
In-Reply-To: <1571938066-29031-1-git-send-email-yang.shi@linux.alibaba.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Thu, 24 Oct 2019 12:26:29 -0700
Message-ID: <CAPhsuW4XK0UFd4Gv6jgJkr8aKo8yXNV-=HXn+4DzKw1J09sLJQ@mail.gmail.com>
Subject: Re: [PATCH] mm: thp: clear PageDoubleMap flag when the last PMD map gone
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Hugh Dickins <hughd@google.com>, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 10:28 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
> File THP sets PageDoubleMap flag when the first it gets PTE mapped, but
> the flag is never cleared until the THP is freed.  This result in
> unbalanced state although it is not a big deal.
>
> Clear the flag when the last compound_mapcount is gone.  It should be
> cleared when all the PTE maps are gone (become PMD mapped only) as well,
> but this needs check all subpage's _mapcount every time any subpage's
> rmap is removed, the overhead may be not worth.  The anonymous THP also
> just clears PageDoubleMap flag when the last PMD map is gone.
>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Looks good to me. Thanks!

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> Hugh thought it is unnecessary to fix it completely due to the overhead
> (https://lkml.org/lkml/2019/10/22/1011), but it sounds simple to achieve
> the similar balance as anonymous THP.
>
>  mm/rmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 0c7b2a9..d17cbf3 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1236,6 +1236,9 @@ static void page_remove_file_rmap(struct page *page, bool compound)
>                         __dec_node_page_state(page, NR_SHMEM_PMDMAPPED);
>                 else
>                         __dec_node_page_state(page, NR_FILE_PMDMAPPED);
> +
> +               /* The last PMD map is gone */
> +               ClearPageDoubleMap(compound_head(page));
>         } else {
>                 if (!atomic_add_negative(-1, &page->_mapcount))
>                         goto out;
> --
> 1.8.3.1
>
>
