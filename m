Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266B0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A0C20989
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cm6wvAFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfEGNQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:16:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45699 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEGNQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:16:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id n22so4279362lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 06:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MHPIqM7JCox7474Ql+xv/9Bn+cArjwrigJpmZBOlFYc=;
        b=Cm6wvAFwgAxp/8D3CkSsBcbPu7kiNDKTuOPOjj7VgZexU4R3MuQVhAtBWxto2J3mkD
         R5ilpzaX5NiHw5RM65X5ZS2DkJuQA7x+/Hp5Bj/Y3EJ5iS12D5vswADthPKpU8JlQtX/
         +evJAeTS11J4tIUcoXBhWnOD404ANf2KNSE50/ynuFzUReJkCdsj0p72urrf5GyApTod
         1p2j+DBuZtLzo0G3wpB9Dkn+us74hciQr/9q9l5MhPPR2rrRwHq9GwCHiN/OIhTB42lF
         ekO9nOGnT2bD3xS7Fw5XfrJwzz1km3w0uXrPLjHG4I5LqG9YqonzZlEzFrqkL70EWiIs
         Jacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MHPIqM7JCox7474Ql+xv/9Bn+cArjwrigJpmZBOlFYc=;
        b=HVPeJRg37klOqtxVXkacZipoPzft82rKy23i8lXTXC13aU/C7my8av+j3MvxI7B53H
         i0xxshV59IiB6/0FNF4fB3ayrivHa2161Rcua5vf4S+tqUHT26fQpeWuH+x6+zxy304d
         hM6YEr/6Q8rQ7WNoEZYSLv7bggj55N4LupBA0TwFIdxLb9a2/DjRRCoD2nk17QwqcIVt
         ZqVmzThs3rJEe4+XqH1H+Y2p328exNaR0XS1oLfK+Z6p3KTY6yjRY454MBO8YVHOIyv6
         C8HQYaYSa/Y8KagEZgoX6+AUNY7Upg/kz9rChcU9sAmOeUtiTt3zOxOl+UihujiBAjxT
         bLPA==
X-Gm-Message-State: APjAAAXbPzoCd54TginzYzlj6ekY52MUxYP68yJ/VOGAhpPqM/Zb98F/
        Exr7X1MqCQ6qeWXTQotQOidS1PfdqMZSM4iBPvI=
X-Google-Smtp-Source: APXvYqz8d9kZlmnP7W0YjChLPfOjnpt8Wn0ENZFruzEv4tpK/oiDqKaN1ndX881yL1autUWNqhijNjQCghEYOAXZjxQ=
X-Received: by 2002:ac2:5495:: with SMTP id t21mr16592698lfk.3.1557234966713;
 Tue, 07 May 2019 06:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190506232942.12623-1-rcampbell@nvidia.com> <20190506232942.12623-5-rcampbell@nvidia.com>
In-Reply-To: <20190506232942.12623-5-rcampbell@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 7 May 2019 18:45:54 +0530
Message-ID: <CAFqt6zbhLQuw2N5-=Nma-vHz1BkWjviOttRsPXmde8U1Oocz0Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call hmm_range_unregister()
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 5:00 AM <rcampbell@nvidia.com> wrote:
>
> From: Ralph Campbell <rcampbell@nvidia.com>
>
> The helper function hmm_vma_fault() calls hmm_range_register() but is
> missing a call to hmm_range_unregister() in one of the error paths.
> This leads to a reference count leak and ultimately a memory leak on
> struct hmm.
>
> Always call hmm_range_unregister() if hmm_range_register() succeeded.

How about * Call hmm_range_unregister() in error path if
hmm_range_register() succeeded* ?

>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/hmm.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 35a429621e1e..fa0671d67269 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>                 return (int)ret;
>
>         if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT)) {
> +               hmm_range_unregister(range);
>                 /*
>                  * The mmap_sem was taken by driver we release it here and
>                  * returns -EAGAIN which correspond to mmap_sem have been
> @@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
>
>         ret = hmm_range_fault(range, block);
>         if (ret <= 0) {
> +               hmm_range_unregister(range);

what is the reason to moved it up ?

>                 if (ret == -EBUSY || !ret) {
>                         /* Same as above, drop mmap_sem to match old API. */
>                         up_read(&range->vma->vm_mm->mmap_sem);
>                         ret = -EBUSY;
>                 } else if (ret == -EAGAIN)
>                         ret = -EBUSY;
> -               hmm_range_unregister(range);
>                 return ret;
>         }
>         return 0;
> --
> 2.20.1
>
