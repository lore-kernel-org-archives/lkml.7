Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1C4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92768222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 08:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="T+inIGth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfJCIEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 04:04:34 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42585 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbfJCIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 04:04:34 -0400
Received: by mail-io1-f68.google.com with SMTP id n197so3368578iod.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RFLlzP5Js98BS8nkgSfEvrEZLCP/SMDrxOQITXNt3eI=;
        b=T+inIGthBvE2//4VZmd63eyRSLLLrR2dZV3XC6Gze72yu+iWc2TuhC9KAwqW1fcGZq
         V4qnPy9VgsX44Sy3xvd4Qo2blktM9gmPmA0CVDmErzDIOibLMHDVtUXsl8nOoesSbJ0/
         artzBJciGJ5N7rJi9zsfVOYKuofa7muPcE6pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFLlzP5Js98BS8nkgSfEvrEZLCP/SMDrxOQITXNt3eI=;
        b=I+TUqqVtjxl1fOWkE/jPS3VtZ//y3qb+clhMEYb7uLJnWBYRFtcC4Cxz4M3KVv4Lzz
         tmGk1gD7+w4TmjlLDIs6BjjifTpV+3lJ8uc5jQ10kbQhg9eW6XdkUARzUfMjAwxdDRtE
         OUPWAWMXeiO4UkXhgefWHWUoMHULnJPe59y55YVnfqtaO9my0/9gSf4K9W2lRJgNrPQy
         WwfQoSrN+msBU4MhTdmfDQ1cik8bpB0D/hq+4alLGnaHVUzzmPAstuPVYzcV8nCAuBys
         qAxFRzkFJ5tw/dlvxfVWCmdBIyX+n0xk7JTUMbTYBtrea1Vsu0LJoacfBI011U16N8iP
         gWCw==
X-Gm-Message-State: APjAAAXZpFL8Ioee7qvufioY/AXhrrlcH7v+wHEZmROr4kmIQJgEVKxG
        uwEJyJIlwnBhyeUEuT1hwGMHC5zi3mulVq81oBI4fg==
X-Google-Smtp-Source: APXvYqyTGtMe8CACMxLAYuzPIkQ43lyohUju5qo0yntIo1HDn9G2UOfThJbdazHDgBUxaisYEda00vQaldPsOCX9KfA=
X-Received: by 2002:a05:6e02:4d2:: with SMTP id f18mr8908437ils.174.1570089873408;
 Thu, 03 Oct 2019 01:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegv-EQhvJUB0AUhJ=Xx8moHHQvkDGe-yUXHENyWvboBU3A@mail.gmail.com>
 <1b09a159-bcec-63c9-df42-47d99f44d445@virtuozzo.com>
In-Reply-To: <1b09a159-bcec-63c9-df42-47d99f44d445@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 3 Oct 2019 10:04:22 +0200
Message-ID: <CAJfpegvcef_rJ5VHdE91LAU2_=XrorsTZu_7JCPsJFo0aGwZmw@mail.gmail.com>
Subject: Re: [PATCH] fuse: BUG_ON correction in fuse_dev_splice_write()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 8:53 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> commit 963545357202 ("fuse: reduce allocation size for splice_write")
> changed size of bufs array, so BUG_ON which checks the index of the array
> shold also be fixed.
>
> Fixes: 963545357202 ("fuse: reduce allocation size for splice_write")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  fs/fuse/dev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index ea8237513dfa..f4ef6e01642c 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2029,7 +2029,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>                                      struct file *out, loff_t *ppos,
>                                      size_t len, unsigned int flags)
>  {
> -       unsigned nbuf;
> +       unsigned nbuf, bsize;
>         unsigned idx;
>         struct pipe_buffer *bufs;
>         struct fuse_copy_state cs;
> @@ -2043,7 +2043,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>
>         pipe_lock(pipe);
>
> -       bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
> +       bsize = pipe->nrbufs;
> +       bufs = kvmalloc_array(bsize, sizeof(struct pipe_buffer),
>                               GFP_KERNEL);
>         if (!bufs) {
>                 pipe_unlock(pipe);
> @@ -2064,7 +2065,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>                 struct pipe_buffer *ibuf;
>                 struct pipe_buffer *obuf;
>
> -               BUG_ON(nbuf >= pipe->buffers);
> +               BUG_ON(nbuf >= bsize);
>                 BUG_ON(!pipe->nrbufs);

Better turn these into WARN_ON's..  Fixed and applied.

Thanks,
Miklos
