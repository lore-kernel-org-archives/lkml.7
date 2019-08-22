Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F752C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CBE22CE3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 00:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGJR3HzN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbfHVASi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 20:18:38 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42243 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbfHVASh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 20:18:37 -0400
Received: by mail-yw1-f66.google.com with SMTP id z63so1673390ywz.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJuGzxgYEJJmtKKSqq5f5g5uuFonx8YcgqfrLKyhRok=;
        b=OGJR3HzNBSkdxYQw12UylRSGalg3ZnUXc9khh8ugaTnSxiwGLyoqbvdJDRuiPVL5dq
         W+thHR2a+jBR5rpUNM8m6s3mT6WKRquEPTeG8xY99LdyfhLdKt3uCCaPg/rV7ckJXu5n
         OsNKtbYz2BYemMwWG5sDjuPUHFyCSF6QzmkxBYBC3d/oeOYwAa5vNHE1eHNq0786FWtF
         6ecG5zWqihf5X0jV20hIfWIVsnmitAHpClsGMHYPFPfvOhVG39dzoeHYqc/VYVBUp50E
         9ZUcG2Rk7y9l+AbK+XO0h2oFSucyA24vqWhTV8lv1UTfMUEa+I0syRiUsiMyaBpbl59Q
         R0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJuGzxgYEJJmtKKSqq5f5g5uuFonx8YcgqfrLKyhRok=;
        b=SuyiAhhsIWr03sjonl9OLFQk61IQuVEmkg+zC17RL8Jlbw2n18TKnUG0EoY7ZhSkyp
         nLAuFW6lK14ozvrc+x3W7a6u8aJX1IkQyJU14hNLsRXgmXB9Awx4AxHl4l59QSTyDwSA
         88z7qZpLB8s1ijT7pCYABwLI6XDcemWZkYY8K9WEf662/k9Cql70VamfMRVOmsONF1ra
         rOpzqLQpfSdFMvS3n8czCkFut6srhabGmzlRnc+Boivl9PqfY5rlq5UVRGcVt5A3jdBY
         gWWc+xz0n86yp9glTcwYHSedm7zuxkpVY6Bfzi6NivbYTsMaq4PQrxj7u5GJbSC2s6eH
         3zvA==
X-Gm-Message-State: APjAAAXED+Dhr8sWGctJm29t1gQSs2jzhdFyeksRhHP+zxGPiCbt/Ye0
        muhfyjUd4fxZd4wbjzB1MZzjpzO6C1AlH8YwDwAzpQ==
X-Google-Smtp-Source: APXvYqz/+KzvuSRCI+8UB3npquns8i4yJV3iPDKr0QXmZdcoTE4nWyBLXhfOM65gga62VJI5FjurjupIFIYWSHTGLk4=
X-Received: by 2002:a81:2e84:: with SMTP id u126mr25699468ywu.398.1566433116409;
 Wed, 21 Aug 2019 17:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190822000933.180870-1-khazhy@google.com> <20190822000933.180870-3-khazhy@google.com>
In-Reply-To: <20190822000933.180870-3-khazhy@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 21 Aug 2019 17:18:25 -0700
Message-ID: <CALvZod5d1iyJtfwzW0qtHLJ4cB5zQqAHuVBM_ay9cWD=TTSPSw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: pass gfp flags to fuse_request_alloc
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 5:10 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> Instead of having a helper per flag
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

I think it would be better to re-order the patch 2 and 3 of this
series. There will be less code churn.

> ---
>  fs/fuse/dev.c    | 22 +++-------------------
>  fs/fuse/file.c   |  6 +++---
>  fs/fuse/fuse_i.h |  6 +-----
>  fs/fuse/inode.c  |  4 ++--
>  4 files changed, 9 insertions(+), 29 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index a0d166a6596f..c957620ce7ba 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -66,7 +66,7 @@ static struct page **fuse_req_pages_alloc(unsigned int npages, gfp_t flags,
>         return pages;
>  }
>
> -static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
> +struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags)
>  {
>         struct fuse_req *req = kmem_cache_zalloc(fuse_req_cachep, flags);
>         if (req) {
> @@ -90,24 +90,8 @@ static struct fuse_req *__fuse_request_alloc(unsigned npages, gfp_t flags)
>         }
>         return req;
>  }
> -
> -struct fuse_req *fuse_request_alloc(unsigned npages)
> -{
> -       return __fuse_request_alloc(npages, GFP_KERNEL);
> -}
>  EXPORT_SYMBOL_GPL(fuse_request_alloc);
>
> -struct fuse_req *fuse_request_alloc_account(unsigned int npages)
> -{
> -       return __fuse_request_alloc(npages, GFP_KERNEL_ACCOUNT);
> -}
> -EXPORT_SYMBOL_GPL(fuse_request_alloc_account);
> -
> -struct fuse_req *fuse_request_alloc_nofs(unsigned npages)
> -{
> -       return __fuse_request_alloc(npages, GFP_NOFS);
> -}
> -
>  static void fuse_req_pages_free(struct fuse_req *req)
>  {
>         if (req->pages != req->inline_pages)
> @@ -207,7 +191,7 @@ static struct fuse_req *__fuse_get_req(struct fuse_conn *fc, unsigned npages,
>         if (fc->conn_error)
>                 goto out;
>
> -       req = fuse_request_alloc(npages);
> +       req = fuse_request_alloc(npages, GFP_KERNEL);
>         err = -ENOMEM;
>         if (!req) {
>                 if (for_background)
> @@ -316,7 +300,7 @@ struct fuse_req *fuse_get_req_nofail_nopages(struct fuse_conn *fc,
>         wait_event(fc->blocked_waitq, fc->initialized);
>         /* Matches smp_wmb() in fuse_set_initialized() */
>         smp_rmb();
> -       req = fuse_request_alloc(0);
> +       req = fuse_request_alloc(0, GFP_KERNEL);
>         if (!req)
>                 req = get_reserved_req(fc, file);
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index c584ad7478b3..ae8c8016bb8e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -50,7 +50,7 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
>                 return NULL;
>
>         ff->fc = fc;
> -       ff->reserved_req = fuse_request_alloc_account(0);
> +       ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL_ACCOUNT);
>         if (unlikely(!ff->reserved_req)) {
>                 kfree(ff);
>                 return NULL;
> @@ -1703,7 +1703,7 @@ static int fuse_writepage_locked(struct page *page)
>
>         set_page_writeback(page);
>
> -       req = fuse_request_alloc_nofs(1);
> +       req = fuse_request_alloc(1, GFP_NOFS);
>         if (!req)
>                 goto err;
>
> @@ -1923,7 +1923,7 @@ static int fuse_writepages_fill(struct page *page,
>                 struct fuse_inode *fi = get_fuse_inode(inode);
>
>                 err = -ENOMEM;
> -               req = fuse_request_alloc_nofs(FUSE_REQ_INLINE_PAGES);
> +               req = fuse_request_alloc(FUSE_REQ_INLINE_PAGES, GFP_NOFS);
>                 if (!req) {
>                         __free_page(tmp_page);
>                         goto out_unlock;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 08161b2d9b08..8080a51096e9 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -902,11 +902,7 @@ void __exit fuse_ctl_cleanup(void);
>  /**
>   * Allocate a request
>   */
> -struct fuse_req *fuse_request_alloc(unsigned npages);
> -
> -struct fuse_req *fuse_request_alloc_account(unsigned int npages);
> -
> -struct fuse_req *fuse_request_alloc_nofs(unsigned npages);
> +struct fuse_req *fuse_request_alloc(unsigned int npages, gfp_t flags);
>
>  bool fuse_req_realloc_pages(struct fuse_conn *fc, struct fuse_req *req,
>                             gfp_t flags);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index eab44ddc68b9..ad92e93eaddd 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1178,13 +1178,13 @@ static int fuse_fill_super(struct super_block *sb, void *data, int silent)
>         /* Root dentry doesn't have .d_revalidate */
>         sb->s_d_op = &fuse_dentry_operations;
>
> -       init_req = fuse_request_alloc(0);
> +       init_req = fuse_request_alloc(0, GFP_KERNEL);
>         if (!init_req)
>                 goto err_put_root;
>         __set_bit(FR_BACKGROUND, &init_req->flags);
>
>         if (is_bdev) {
> -               fc->destroy_req = fuse_request_alloc(0);
> +               fc->destroy_req = fuse_request_alloc(0, GFP_KERNEL);
>                 if (!fc->destroy_req)
>                         goto err_free_init_req;
>         }
> --
> 2.23.0.187.g17f5b7556c-goog
>
