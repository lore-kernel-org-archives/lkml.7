Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA76C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFF4206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fxB/5EyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbfDWMzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:55:32 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:53519 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfDWMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:55:31 -0400
Received: by mail-it1-f195.google.com with SMTP id y204so23217423itf.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 05:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMaqxlUnEk44LnM3PWYf6hB2VGv2xpvBrBkPQmZvQ1I=;
        b=fxB/5EyTsJW1blyTqtcFZ2352T56PYvfX9tTUiWnI9kWwTShToOotTg26/ZbI0eRtt
         /1U3CD42GQAfwW3Vixm5S1XEAhbTZVPdsnToKTlNbtoV1xRMTtyocVfzBaiWxjPkNkX+
         qBYDFJChLcXP3AvHL/uSczsqqnOIENatgQktI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMaqxlUnEk44LnM3PWYf6hB2VGv2xpvBrBkPQmZvQ1I=;
        b=Iksv2T67UjEs31kxqgZmJ5AxCGD6AjW6pXFvflLcVPftVzop8FNq3opgWYA9qcSNVy
         UPQ+ocmwlT2qp+Xh4zLuX6oOcd4mmy2L/IXAN8RUGWC/glRB6/vPiuNvtP8A/l79vyxz
         tnfZD8c21lx54PAlDAqiHETGVIkoAPVKAea7hH/3c1gXN4gp82QIl5ID1RyAcYH+eRaa
         bEqVn5D51UGW9lHcJg1VTjS85l3xgpJ8G2mSplBiVWJfyUt8XxOiffjO0soSJQWfkJbg
         EbKPRtb809DD1QpbaBJTe5yops9MApnTwolWYcSq5tvvUTaiyIqp+TInOOQsnyS+kmM2
         0uqA==
X-Gm-Message-State: APjAAAUljsVslplfVurmpniLor2kZTJHKBqeVka69GQOFYXhRLnHvFCt
        BHtkc5FlgbHXs/EQSwhEJ3y1RqustBK4/Pi4ZXUZfA==
X-Google-Smtp-Source: APXvYqxFfCTedi9HW0SvowO5zYgdja9Pzo54lfhfY7R/IwRsV3cfg+qea4Wp0bVOhg8nkVJOnq6uksFRpPo3pYGSLZU=
X-Received: by 2002:a24:1312:: with SMTP id 18mr1660003itz.121.1556024131137;
 Tue, 23 Apr 2019 05:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190301170831.23612-1-abbotti@mev.co.uk>
In-Reply-To: <20190301170831.23612-1-abbotti@mev.co.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 23 Apr 2019 14:55:19 +0200
Message-ID: <CAJfpegsQvUGz-YRQVrfkTWuSFe==Hg_Y=VpV0ZagKe0qGfxQ7g@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add ioctl flag for compat ioctl with 64-bit time_t
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 6:08 PM Ian Abbott <abbotti@mev.co.uk> wrote:
>
> Currently, a CUSE server running on a 64-bit kernel can tell when an
> ioctl request comes from a process running a 32-bit ABI, but cannot tell
> whether the requesting process is using legacy IA32 emulation or x32
> ABI, for example.  In particular, the server does not know the size of
> the client process's `time_t` type.
>
> For 64-bit kernels, the `FUSE_IOCTL_COMPAT` and `FUSE_IOCTL_32BIT` flags
> are currently set in the ioctl input request (`struct fuse_ioctl_in`
> member `flags`) for a 32-bit requesting process.  This patch defines a
> new flag `FUSE_IOCTL_COMPAT_64TIME` and sets it if the 32-bit requesting
> process (running on a 64-bit kernel) uses a 64-bit `time_t` type.

Hi,

Thanks for the patch.

I think it should rather use in_x32_syscall() helper and follow that
naming because there's apparently at least one example in xfs of a
non-time_t related ioctl that varies between the x32 vs ia32.

Thanks,
Miklos

>
> Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
> ---
>  fs/fuse/file.c            | 5 ++++-
>  include/uapi/linux/fuse.h | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 06096b60f1df..9777e7a19889 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -2576,8 +2576,11 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>  #if BITS_PER_LONG == 32
>         inarg.flags |= FUSE_IOCTL_32BIT;
>  #else
> -       if (flags & FUSE_IOCTL_COMPAT)
> +       if (flags & FUSE_IOCTL_COMPAT) {
>                 inarg.flags |= FUSE_IOCTL_32BIT;
> +               if (COMPAT_USE_64BIT_TIME)
> +                       inarg.flags |= FUSE_IOCTL_COMPAT_64TIME;
> +       }
>  #endif
>
>         /* assume all the iovs returned by client always fits in a page */
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 2ac598614a8f..1f4a71486601 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -335,6 +335,7 @@ struct fuse_file_lock {
>   * FUSE_IOCTL_RETRY: retry with new iovecs
>   * FUSE_IOCTL_32BIT: 32bit ioctl
>   * FUSE_IOCTL_DIR: is a directory
> + * FUSE_IOCTL_COMPAT_64TIME: 32bit compat ioctl with 64bit time_t
>   *
>   * FUSE_IOCTL_MAX_IOV: maximum of in_iovecs + out_iovecs
>   */
> @@ -343,6 +344,7 @@ struct fuse_file_lock {
>  #define FUSE_IOCTL_RETRY       (1 << 2)
>  #define FUSE_IOCTL_32BIT       (1 << 3)
>  #define FUSE_IOCTL_DIR         (1 << 4)
> +#define FUSE_IOCTL_COMPAT_64TIME (1 << 5)
>
>  #define FUSE_IOCTL_MAX_IOV     256
>
> --
> 2.20.1
>
