Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3AEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC29205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H31YN4ZN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393360AbfHVVn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:43:29 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40513 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393045AbfHVVn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:43:28 -0400
Received: by mail-yb1-f196.google.com with SMTP id g7so3129813ybd.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUm6yXYTlbTXopviUp4rylkFQbLJR/m96Sizb+UK2Sk=;
        b=H31YN4ZNsUnU299kwk54yLpzwRjkKDvY2XEOe7J+nAsMhciLQ8pxdS2tbnNaGjgiID
         A03OpSrudtbbeZUOHGHlPfuGOH8T4sflQ7jd9/Pmt7+CuIiUVLXEoDcp8t02bTzkXM88
         FTWlKUQgTADJV3eWyOD/cvwdi9xAyXZUN18OSIBFgAlSaNns4xeMN6ccXtANOpwknQUJ
         /I9yMuEBn7nIS0yu8302B4kf0H2NF1Q6F2CP4IfW/h30ysAAzaQZBqhIJ2PXtfCUBgUe
         NTnG2KYoiHG+ZDkXih1IaR5Lx3OTOodsRcIwis4Bd9Ec5I2Shs+IELs+aGbeQK/9owR0
         DkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUm6yXYTlbTXopviUp4rylkFQbLJR/m96Sizb+UK2Sk=;
        b=Mq5/04IMMfjtfT6RDNiN6INbkXlH7u8KKVjABbSHowRFyr7+olN8auDVGHOWALLNih
         9CqpD3XK3Lfp8vZPt9ZBB6FWRI8s0u6i1jWrTfFSIgp2u+wrxBcHsk4+sg3oBBvdcIH1
         kUnchlhKs4E8VH8bLDecF08U+3PCv9AcYoZ85099SqshBvOboLn3pxUZXZ06GIHcTQEu
         FbcE4LKGnvoFZwWMm10WJRe3ljxLq0DsOjSxwCqrePwFkW3yj8Gz1zvFqdJ4R87kcHvQ
         FsIRsGDOlkVALEdA//v5DrQd8dmXMlEmbjWiqDvUpDOM2CM4n1QXxtUAJvrNidoRY2al
         QEEA==
X-Gm-Message-State: APjAAAUGZ0a/uIVyqVuKgHI4uew4XptiQ0cXREZA4/rtWU+Ocn6ayZaA
        h4sKOCDbAHjeYYJGdRALBC9qzeNgozhIHIToinJs+g==
X-Google-Smtp-Source: APXvYqxIFPR6FxUBY8A2LZP4EkBf4qhKlZgJC9O/95dzHUIJ5rZshrEUMo/6nlfJN7uIyc5vW0YNUzbrYPJCT2g48H0=
X-Received: by 2002:a25:e6c9:: with SMTP id d192mr828435ybh.467.1566510207880;
 Thu, 22 Aug 2019 14:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190822200030.141272-1-khazhy@google.com> <20190822200030.141272-3-khazhy@google.com>
In-Reply-To: <20190822200030.141272-3-khazhy@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Aug 2019 14:43:17 -0700
Message-ID: <CALvZod4E7Cd08zUWQxKztUJWuCm=WyDRGGzyjvGFMTSPMqNK4Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: kmemcg account fs data
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     miklos@szeredi.hu, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 1:00 PM Khazhismel Kumykov <khazhy@google.com> wrote:
>
> account per-file, dentry, and inode data
>
> accounts the per-file reserved request, adding new
> fuse_request_alloc_account()
>
> blockdev/superblock and temporary per-request data was left alone, as
> this usually isn't accounted
>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  fs/fuse/dir.c   | 3 ++-
>  fs/fuse/file.c  | 4 ++--
>  fs/fuse/inode.c | 3 ++-
>  3 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index f9c59a296568..2013e1222de7 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -258,7 +258,8 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
>  #if BITS_PER_LONG < 64
>  static int fuse_dentry_init(struct dentry *dentry)
>  {
> -       dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry), GFP_KERNEL);
> +       dentry->d_fsdata = kzalloc(sizeof(union fuse_dentry),
> +                                  GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>
>         return dentry->d_fsdata ? 0 : -ENOMEM;
>  }
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 572d8347ebcb..ae8c8016bb8e 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -45,12 +45,12 @@ struct fuse_file *fuse_file_alloc(struct fuse_conn *fc)
>  {
>         struct fuse_file *ff;
>
> -       ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL);
> +       ff = kzalloc(sizeof(struct fuse_file), GFP_KERNEL_ACCOUNT);
>         if (unlikely(!ff))
>                 return NULL;
>
>         ff->fc = fc;
> -       ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL);
> +       ff->reserved_req = fuse_request_alloc(0, GFP_KERNEL_ACCOUNT);
>         if (unlikely(!ff->reserved_req)) {
>                 kfree(ff);
>                 return NULL;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 5afd1872b8b1..ad92e93eaddd 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -76,7 +76,8 @@ struct fuse_mount_data {
>
>  struct fuse_forget_link *fuse_alloc_forget(void)
>  {
> -       return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL);
> +       return kzalloc(sizeof(struct fuse_forget_link),
> +                      GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE);
>  }
>
>  static struct inode *fuse_alloc_inode(struct super_block *sb)
> --
> 2.23.0.187.g17f5b7556c-goog
>
