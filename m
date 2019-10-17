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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57771FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAD421D80
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 21:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnvEXBtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406087AbfJQVqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 17:46:51 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37810 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391375AbfJQVqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 17:46:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id n17so5904001qtr.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 14:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYiaRkLtQItoIos1fVtgjwSS9oQGZv+h+gwxtHYxTCM=;
        b=ZnvEXBtOrauGSkkuh1uB2M6r7Rkkbyz5Z7V99dVYIFpdzwcZNszofTAPfvylBLoh//
         +3lfuuiDcxEeMmxJaxMXZ6cNd6KMFFd6O5GiUIZUBrVA22pWv/fgi+cDNj2CnqSR07Dt
         8vy39mepB3j76/q0HqwTxuwKeD+LwCRTBLJb0/gGSdApElL1FgDGQo868a1pGbDZxV+J
         IORT/HyAZ8dmuoV/9muquSRQwE3VCWhAlR86AimJ587AQpOenpFKny2ZLrdIwSFb8+YA
         jO0/fsXcqVsi+rSnBpDmJVAVSMjaAeFnotUKZxOBy3+8pYWaBqK4s/znm08DmdQHMOu6
         efyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYiaRkLtQItoIos1fVtgjwSS9oQGZv+h+gwxtHYxTCM=;
        b=rIJr5Ls2FTCAXQRAaETF5VTz0f1H5l3rwjpntp7I4JGSHJH/g82gVghycK6KX9LWvV
         4T30TySsFE7i8Ub9xXH6HSttilcYW3EPESwAB2vKNkjnMGIkvTxLOWKWBaxvFX37m2LF
         0xBHNLX9fuM3ka0ymOHwuipdWsVmFdWk6oazTfHebeqU1Ivri7xg2PCc/vs/6ZMmRK8G
         DfMBeKGgXfSPbaPGsyo468nc5QbZNRK+d6xlcWyElAeQpvbtb3o7Um4/dFtp3W7neJHv
         D3SZmpGyY2LKcb3i/CTaT5ulwmYj2MC8RlovT1JYxKxXw/+1MpWrdDDPkMpaE0zRxMgc
         HgrA==
X-Gm-Message-State: APjAAAUy9wzavVn6zPDqSCwPbYHk9lJo9fKW1AReaB4G50Vw+FODlpwd
        fhVJyluK/D3YgRukWrIJ+JsV/lzJG+KAXWA6re4=
X-Google-Smtp-Source: APXvYqzkLxxigjspY5yJqvTKCbf0VYEt88MXLeGG0TfSDxcnuQsqZzGuVZvPZ8NMD8tzzkw7WuR+8ykd+041U8fmNA0=
X-Received: by 2002:a0c:f788:: with SMTP id s8mr6306920qvn.92.1571348810353;
 Thu, 17 Oct 2019 14:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <20191017164223.2762148-1-songliubraving@fb.com> <20191017164223.2762148-5-songliubraving@fb.com>
In-Reply-To: <20191017164223.2762148-5-songliubraving@fb.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 17 Oct 2019 14:46:38 -0700
Message-ID: <CAHbLzkoTT4p9u__EdFgt7_47NHOV5r=nB8EmvBx+1TcyzX5RJg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] mm/thp: allow drop THP from page cache
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
> Once a THP is added to the page cache, it cannot be dropped via
> /proc/sys/vm/drop_caches. Fix this issue with proper handling in
> invalidate_mapping_pages().
>
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Tested-by: Song Liu <songliubraving@fb.com>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  mm/truncate.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 8563339041f6..dd9ebc1da356 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -592,6 +592,16 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
>                                         unlock_page(page);
>                                         continue;
>                                 }
> +
> +                               /* Take a pin outside pagevec */
> +                               get_page(page);
> +
> +                               /*
> +                                * Drop extra pins before trying to invalidate
> +                                * the huge page.
> +                                */
> +                               pagevec_remove_exceptionals(&pvec);
> +                               pagevec_release(&pvec);

Shall we skip the outer pagevec_remove_exceptions() if it has been done here?

>                         }
>
>                         ret = invalidate_inode_page(page);
> @@ -602,6 +612,8 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
>                          */
>                         if (!ret)
>                                 deactivate_file_page(page);
> +                       if (PageTransHuge(page))
> +                               put_page(page);
>                         count += ret;
>                 }
>                 pagevec_remove_exceptionals(&pvec);
> --
> 2.17.1
>
>
