Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF8CC04AA8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D6821743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ApRLQsRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfD3V5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:57:50 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:41436 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfD3V5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:57:50 -0400
Received: by mail-vk1-f195.google.com with SMTP id q193so2188052vkf.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 14:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrmJg5mJkdOB4HxRtlUftJxszIDcsroWGgIpxMUexwY=;
        b=ApRLQsRWLYDRB1zjywf8XpfE+dW75Bh0LDN3wBrHZvQM/bXYOhCwOGGI+1zXg59ILI
         0gnOtO2l5+pHTLyDMucFKFf69zIPwLIGs+etrKYFG0DV7GFQX3Amh06repKBlVkPOxCo
         nTYhV1brRDRIvMaLpnT8uySSjAIWhQTwI1dTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrmJg5mJkdOB4HxRtlUftJxszIDcsroWGgIpxMUexwY=;
        b=sjx7U/h8Hnr164h0h+QAYPsYpN/RXtWkprH/+vmGA43fYhMVjPJ0UqfQZ9G5/XqW2C
         vEbNlfeSVBjaCk6/CzrqUOXG1sOLPJDK3HjiOU4H/SZsLgnxjEWcHKX/wQuX9cyPQwfm
         SuzK4rueVpAm06cXsi9PktfFBwBXYgpOw7WGbRb92P7bv7FB3ip0cjKoaqvyqvaigqt0
         Q9q0rgwd0EDnYA7+GpnGFUdzwSSFMWxPtX9GCs39GO/iTkVKRF8LHK0/g4j2kZE3/BPA
         oAPTtCu+qHT1rGAkzqadGEtjRfMb7kBnkU36Sv1ANBa6y/1zgdAeCND8ZpavcuC4sEyb
         Wi7Q==
X-Gm-Message-State: APjAAAViaD4fDv9Bm5LUHZqoH+l35jP6L0wZnKjMCRroED/BsndUZQRR
        gumihtXbZ+zmumZXEy2xBx6jMUWZ+sA=
X-Google-Smtp-Source: APXvYqx44LXy/3jlB94VlevSJiyYelBBSQP+NWhaSNA49orabirJZ9dNUxQOVPseBpe5Do8SGSbtNA==
X-Received: by 2002:a1f:a544:: with SMTP id o65mr38073041vke.86.1556661468798;
        Tue, 30 Apr 2019 14:57:48 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id b5sm8360510vsd.18.2019.04.30.14.57.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 14:57:47 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id o33so5304159uae.12
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 14:57:47 -0700 (PDT)
X-Received: by 2002:ab0:1646:: with SMTP id l6mr35938169uae.75.1556661467134;
 Tue, 30 Apr 2019 14:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190430214724.66699-1-samitolvanen@google.com>
In-Reply-To: <20190430214724.66699-1-samitolvanen@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 30 Apr 2019 14:57:35 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLfLsiKJurVL_+zr5t6D1B6OMw2hPo5WZSjUhv1-4AONg@mail.gmail.com>
Message-ID: <CAGXu5jLfLsiKJurVL_+zr5t6D1B6OMw2hPo5WZSjUhv1-4AONg@mail.gmail.com>
Subject: Re: [PATCH] mm: fix filler_t callback type mismatch with readpage
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 2:47 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Casting mapping->a_ops->readpage to filler_t causes an indirect call
> type mismatch with Control-Flow Integrity checking. This change fixes
> the mismatch in read_cache_page_gfp and read_mapping_page by adding a
> stub callback function with the correct type.
>
> As the kernel only has a couple of instances of read_cache_page(s)
> being called with a callback function that doesn't accept struct file*
> as the first parameter, Android kernels have previously fixed this by
> changing filler_t to int (*filler_t)(struct file *, struct page *):
>
>   https://android-review.googlesource.com/c/kernel/common/+/671260
>
> While this approach did fix most of the issues, the few remaining
> cases where unrelated private data are passed to the callback become
> rather awkward. Keeping filler_t unchanged and using a stub function
> for readpage instead solves this problem.
>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/linux/pagemap.h | 22 +++++++++++++++++++---
>  mm/filemap.c            |  7 +++++--
>  2 files changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index bcf909d0de5f8..e5652a5ba1584 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -383,11 +383,27 @@ extern struct page * read_cache_page_gfp(struct address_space *mapping,
>  extern int read_cache_pages(struct address_space *mapping,
>                 struct list_head *pages, filler_t *filler, void *data);
>
> +struct file_filler_data {
> +       int (*filler)(struct file *, struct page *);
> +       struct file *filp;
> +};
> +
> +static inline int __file_filler(void *data, struct page *page)
> +{
> +       struct file_filler_data *ffd = (struct file_filler_data *)data;
> +
> +       return ffd->filler(ffd->filp, page);
> +}
> +
>  static inline struct page *read_mapping_page(struct address_space *mapping,
> -                               pgoff_t index, void *data)
> +                               pgoff_t index, struct file *filp)
>  {
> -       filler_t *filler = (filler_t *)mapping->a_ops->readpage;
> -       return read_cache_page(mapping, index, filler, data);
> +       struct file_filler_data data = {
> +               .filler = mapping->a_ops->readpage,
> +               .filp   = filp
> +       };
> +
> +       return read_cache_page(mapping, index, __file_filler, &data);
>  }
>
>  /*
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d78f577baef2a..6cc41c25ca3bf 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2977,9 +2977,12 @@ struct page *read_cache_page_gfp(struct address_space *mapping,
>                                 pgoff_t index,
>                                 gfp_t gfp)
>  {
> -       filler_t *filler = (filler_t *)mapping->a_ops->readpage;
> +       struct file_filler_data data = {
> +               .filler = mapping->a_ops->readpage,
> +               .filp   = NULL
> +       };
>
> -       return do_read_cache_page(mapping, index, filler, NULL, gfp);
> +       return do_read_cache_page(mapping, index, __file_filler, &data, gfp);
>  }
>  EXPORT_SYMBOL(read_cache_page_gfp);
>
> --
> 2.21.0.593.g511ec345e18-goog
>


-- 
Kees Cook
