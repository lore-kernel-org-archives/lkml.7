Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A79C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E296218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 14:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNYsnnjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbfGVOhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:37:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35570 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfGVOhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 10:37:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id x25so37894299ljh.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SUH6arJbp14IVMjbkeZ0K94NO/z20TDutwCqOxsq4Fw=;
        b=cNYsnnjVLguyuhcKHqqxp7hSA5M3S1DZvaBoF80d1MZLvyCLSsdsxyzbqp+hAugfqB
         La4mTA+QaSN25eS7kR5jYbs5x37bIW38yuFEe9LoQUhA4BKZbg7G89i02FTdSaoa/LHD
         0/lmUGsZBZhSpFQ3CDG0yu7d0XOEvaaddpieq56zgY56JIdUSioPyWlIQN+Coy+AXBhh
         i8jmWmQqzLzSlVGdTV2hn84KzjVBQl4pbwsL+KCS9KIx6GA7hL+D2ZJUFh8ilWXmzYh/
         dAZFYOljbOddCkc8Zmh16FrOyiTux9Y7iKOyUucQi77FVxvyJCXpJp2vmP1KIUydFgVE
         61bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SUH6arJbp14IVMjbkeZ0K94NO/z20TDutwCqOxsq4Fw=;
        b=To6Z3sFQCxUEZ8swOxTQbUpFcHl6LqFbqPPNczypSCR6KyCYe+jW5cimXbBBPKIV30
         /iPPE9RNaCTd9UeE9Y/FbLVDL5XUfA1KQv02sq7L0t7NdsAn/Sd/9y3QLq8+G2O1nepz
         PaCsvausSPx6Jc7NeZcaFMd22iPXlix86FN2++E0MNCDgEcNaELCvHsLzukYAHPDrrGu
         OMFwB/VrRA3XIx1JcpRvXtKO4XioPvjCnJTPOuyn2JSvcw/nQ+1VWbvnxhVxZUUlHFAS
         1QK7zYY71EwGMKg/rWlqTwVFs56rJsyUKUXaCBeDmjiW+mJ/ZhgDexrAlOcpWGplknF2
         Kb/g==
X-Gm-Message-State: APjAAAUN4pkS4pEoSYuEjHu0ZbIXzKB8g7qj7cgmbflu5SRSuZhGWi8+
        sgjxI2uo/CO9L5A49TtjowytPZb9jjZ2nLET8U1Z8gsL
X-Google-Smtp-Source: APXvYqyUuyVhvpPVyaK0EtT6IHNJ3TNJikX6jVZCPNEmd7vcNDjv9sQO2bgfO2wFUz2CiCOMPgV4do0itfHJJ3iI0ko=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr25605680ljk.152.1563806265548;
 Mon, 22 Jul 2019 07:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190722094426.18563-1-hch@lst.de> <20190722094426.18563-2-hch@lst.de>
In-Reply-To: <20190722094426.18563-2-hch@lst.de>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 22 Jul 2019 20:07:33 +0530
Message-ID: <CAFqt6zY8zWAmc-VTrZ1KxQPBCdbTxmZy_tq2-OkUi3TVrfp7Og@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: always return EBUSY for invalid ranges in hmm_range_{fault,snapshot}
To:     Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Felix Kuehling <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 3:14 PM Christoph Hellwig <hch@lst.de> wrote:
>
> We should not have two different error codes for the same condition.  In
> addition this really complicates the code due to the special handling of
> EAGAIN that drops the mmap_sem due to the FAULT_FLAG_ALLOW_RETRY logic
> in the core vm.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  Documentation/vm/hmm.rst |  2 +-
>  mm/hmm.c                 | 10 ++++------
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
> index 7d90964abbb0..710ce1c701bf 100644
> --- a/Documentation/vm/hmm.rst
> +++ b/Documentation/vm/hmm.rst
> @@ -237,7 +237,7 @@ The usage pattern is::
>        ret = hmm_range_snapshot(&range);
>        if (ret) {
>            up_read(&mm->mmap_sem);
> -          if (ret == -EAGAIN) {
> +          if (ret == -EBUSY) {
>              /*
>               * No need to check hmm_range_wait_until_valid() return value
>               * on retry we will get proper error with hmm_range_snapshot()
> diff --git a/mm/hmm.c b/mm/hmm.c
> index e1eedef129cf..16b6731a34db 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -946,7 +946,7 @@ EXPORT_SYMBOL(hmm_range_unregister);
>   * @range: range
>   * Return: -EINVAL if invalid argument, -ENOMEM out of memory, -EPERM invalid
>   *          permission (for instance asking for write and range is read only),
> - *          -EAGAIN if you need to retry, -EFAULT invalid (ie either no valid
> + *          -EBUSY if you need to retry, -EFAULT invalid (ie either no valid
>   *          vma or it is illegal to access that range), number of valid pages
>   *          in range->pfns[] (from range start address).
>   *
> @@ -967,7 +967,7 @@ long hmm_range_snapshot(struct hmm_range *range)
>         do {
>                 /* If range is no longer valid force retry. */
>                 if (!range->valid)
> -                       return -EAGAIN;
> +                       return -EBUSY;
>
>                 vma = find_vma(hmm->mm, start);
>                 if (vma == NULL || (vma->vm_flags & device_vma))
> @@ -1062,10 +1062,8 @@ long hmm_range_fault(struct hmm_range *range, bool block)
>
>         do {
>                 /* If range is no longer valid force retry. */
> -               if (!range->valid) {
> -                       up_read(&hmm->mm->mmap_sem);
> -                       return -EAGAIN;
> -               }
> +               if (!range->valid)
> +                       return -EBUSY;

Is it fine to remove  up_read(&hmm->mm->mmap_sem) ?

>
>                 vma = find_vma(hmm->mm, start);
>                 if (vma == NULL || (vma->vm_flags & device_vma))
> --
> 2.20.1
>
