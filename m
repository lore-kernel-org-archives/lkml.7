Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D136ECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54EA321925
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuCh3XES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503183AbfJQRiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:38:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41555 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436714AbfJQRit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:38:49 -0400
Received: by mail-qt1-f193.google.com with SMTP id c17so1777554qtn.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uOK2In+JS6+ijshXF5nAA99W1PMr9sBNxGluOxOXzi4=;
        b=uuCh3XEScaE3T62TSiu5ATyLc9RPyHX//i2RdT5uipINc2JME+kjezfxPT5qXOOT+T
         SqXru3niTSd0K4iWHeqOhBqSv2GEOEkr2tlphd5r6jFCIVCFU3LI0hjcP3rsUsJWXTjd
         kaxiaaOomOiX4tanoXZrdMuHIKLSZ9sn+JHGjuQWVqLvVrNCloAk7yEg7a2Dn0PEIfbH
         V387Hllfv6leTVpSNKRz3+ZiAN9f3aQSCd6/zEJH3vK1wG/nkY76+qAGZ7NmjQpdmppi
         VIHpvBkQSSYiytW3RpgdREPdMav0oGlqUJizkUW8ITYt/0SRYJZ9Jy0MYkPcjYDMsNSc
         wnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOK2In+JS6+ijshXF5nAA99W1PMr9sBNxGluOxOXzi4=;
        b=hcZBPGYKw1Wiy6ke5XLOGYUAyBAG0CH9Jc8Ghr40w1IXtW/VYvxVlgdmlgZCVOSWNK
         5yWijB40xRDgErVNFfKS7pnqOENo1noHQMXRv8NUhv8ac6BiRdCtgdhQg+9fSDotbyzX
         OanzFx3r4HUIG4/te06tCMHmDv5x5oOOoe5c4mt5gQPUy0vOoKC/8yie+aB/taCd04dJ
         v1u/3nHcQKhXdcClq1C2V8HCREzkJLKcfGira8FCZuNsUakt/0ya4iB+iwJMoKLvFYYI
         ByXUcCWbNfaciFpXvcNYOVT2lTnCCmnayBfAL0XZy2kK5RHDGttv9nkURN0HynOZxyhO
         l4uA==
X-Gm-Message-State: APjAAAXWdvZcKSWA8ytAWN1s8Zgs31t/P8sNfI6NXXztG7R7BYUHyIXK
        lod9/qTtRi6oAworR6w6Geg3prSjALh8C6PH7gY=
X-Google-Smtp-Source: APXvYqwrjvtHBSvL7dF5DK/8UEcy4NYLqcGwCPSuxjfJwjMt2yDlohIbB2Ydyq0qUv+ktsib6onmSislBcYribUrb6c=
X-Received: by 2002:ac8:6ede:: with SMTP id f30mr4967779qtv.205.1571333928188;
 Thu, 17 Oct 2019 10:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191017164223.2762148-1-songliubraving@fb.com> <20191017164223.2762148-3-songliubraving@fb.com>
In-Reply-To: <20191017164223.2762148-3-songliubraving@fb.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Oct 2019 10:38:37 -0700
Message-ID: <CAHbLzkq7XVfUqS7ajVcNhWPWYxg9HKcnveOzACAorZwY3uPQBA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm/thp: fix node page state in split_huge_page_to_list()
To:     Song Liu <songliubraving@fb.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        matthew.wilcox@oracle.com, kernel-team@fb.com,
        william.kucharski@oracle.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 9:42 AM Song Liu <songliubraving@fb.com> wrote:
>
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>
> Make sure split_huge_page_to_list() handle the state of shmem THP and
> file THP properly.
>
> Fixes: 60fbf0ab5da1 ("mm,thp: stats for file backed THP")
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>

Acked-by: Yang Shi <yang.shi@linux.alibaba.com>

> ---
>  mm/huge_memory.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c5cb6dcd6c69..13cc93785006 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2789,8 +2789,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>                         ds_queue->split_queue_len--;
>                         list_del(page_deferred_list(head));
>                 }
> -               if (mapping)
> -                       __dec_node_page_state(page, NR_SHMEM_THPS);
> +               if (mapping) {
> +                       if (PageSwapBacked(page))
> +                               __dec_node_page_state(page, NR_SHMEM_THPS);
> +                       else
> +                               __dec_node_page_state(page, NR_FILE_THPS);
> +               }
> +
>                 spin_unlock(&ds_queue->split_queue_lock);
>                 __split_huge_page(page, list, end, flags);
>                 if (PageSwapCache(head)) {
> --
> 2.17.1
>
>
