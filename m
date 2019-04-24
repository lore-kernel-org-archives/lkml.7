Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C76C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC882084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mSmraiUl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfDXPCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:02:54 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37644 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDXPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:02:53 -0400
Received: by mail-it1-f196.google.com with SMTP id u65so6732508itc.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZyvU6yfxfMmdoBsp+ARyAtBH3t7rGFLZFFfr9/y649E=;
        b=mSmraiUl8p5UjOaq2RLtDucSenUILQvaXSh3Gd/DAVeUCSWIBfp9TLCe6Kdp2pKkp6
         D+aTXw44q4B45WxKyfWbVTFJAATETPnh1jEJ5WtxLAHDUc+IoUZtpFEa7OhbJGnZiEFY
         5GD0AsWF0ps9zqSovb26OgRxnwMirUBijEKDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZyvU6yfxfMmdoBsp+ARyAtBH3t7rGFLZFFfr9/y649E=;
        b=QKn9xu5IqEx/UFwH74TYBRTlwyefaHOF/T90sc8m/1qrCU0Sq4V/QX9ZuSAudpxBPR
         ov3Vwj3siX2rzGQ939ibDHJa4vMlfEPHyRV67TjcB3bygs/eh2mSbGWqhTofKuTSnc56
         TAG5xxqTFFC4XTKqiUrYtJN7EGNXDhJWXrk0ICOIKJP9DkeHDxwEn3ZCCnbwPN6LoPoe
         OqGUGYu+TMvcewEhqOXtS/LZ94SoT6KkBXZ1X516qDI+ZuvNGIB3beXyl2gvhZVaqMcY
         MlTnbOuHqkSaSS6Ulnv1ar2Sia7pFO3b7v0DCz9H7/z3hIRtKc47kjm5W/HTu+7sGASV
         XFZA==
X-Gm-Message-State: APjAAAWE+MfhAioC3n+PDjywAmMHIpq95rJyvD1LaGozJYMtDUS/nTEk
        JSePiPXUNdemLBUme0kLhkU7YlcAjfydz5Mo2myM3Q==
X-Google-Smtp-Source: APXvYqzvFD8vEjr6dbYDwxvrWo2xzt92CL2M/9UI55x3WH3XQJt7RP7/vi13geKvhNZ2tI6ZJhBsIp4K5o0NmvXOfbk=
X-Received: by 2002:a02:1a89:: with SMTP id 131mr20815544jai.78.1556118173019;
 Wed, 24 Apr 2019 08:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1553680185.git.kirr@nexedi.com> <12f7d0d98555ee0d174d04bb47644f65c07f035a.1553680185.git.kirr@nexedi.com>
 <CAJfpegv0NvcsD9gh3aN+ngzsLqbNWUc73ZPN1qHox_14eN9Pqg@mail.gmail.com>
 <20190424115620.GA2723@deco.navytux.spb.ru> <CAJfpegsiWuykUsfg=sO8sKo5h86U65q10=e=wYKXTQEHW8DFkw@mail.gmail.com>
 <20190424123107.GA32024@deco.navytux.spb.ru> <CAJfpegupwNbVPenZdMX8F2Z3vKSJdfAsXuiF4YA+nbnj2Kp=sw@mail.gmail.com>
 <20190424142249.GA28070@deco.navytux.spb.ru>
In-Reply-To: <20190424142249.GA28070@deco.navytux.spb.ru>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 24 Apr 2019 17:02:42 +0200
Message-ID: <CAJfpegtX6p+j+kRuudZ=yVM9Tgj7x4mBaiGuDoDCrZoRvBOt9Q@mail.gmail.com>
Subject: Re: [RESEND4, PATCH 1/2] fuse: retrieve: cap requested size to
 negotiated max_write
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jakob Unterwurzacher <jakobunt@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:22 PM Kirill Smelkov <kirr@nexedi.com> wrote:
> - FUSE_PRECISE_INVAL_DATA:
>
>     --- b/include/uapi/linux/fuse.h
>     +++ b/include/uapi/linux/fuse.h
>     @@ -266,7 +266,7 @@
>       * FUSE_MAX_PAGES: init_out.max_pages contains the max number of req pages
>       * FUSE_CACHE_SYMLINKS: cache READLINK responses
>       * FUSE_NO_OPENDIR_SUPPORT: kernel supports zero-message opendir
>     - * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for data cache invalidation
>     + * FUSE_PRECISE_INVAL_DATA: filesystem is fully responsible for invalidation
>       */
>      #define FUSE_ASYNC_READ                (1 << 0)
>      #define FUSE_POSIX_LOCKS       (1 << 1)
>
> the "data cache" in "for data cache invalidation" has particular meaning
> and semantic: the filesystem promises to explicitly invalidate data of

Right; better name: FUSE_EXPLICIT_INVAL_DATA.  Will push fixed version.

> Your amendment for FOPEN_STREAM in uapi/linux/fuse.h (see above) also
> suggests that it is better to be more explicit in that file.
>
>     --- b/fs/fuse/inode.c
>     +++ b/fs/fuse/inode.c
>     @@ -913,13 +913,8 @@
>                                     fc->dont_mask = 1;
>                             if (arg->flags & FUSE_AUTO_INVAL_DATA)
>                                     fc->auto_inval_data = 1;
>     -                       if (arg->flags & FUSE_PRECISE_INVAL_DATA)
>     +                       else if (arg->flags & FUSE_PRECISE_INVAL_DATA)
>                                     fc->precise_inval_data = 1;
>     -                       if (fc->auto_inval_data && fc->precise_inval_data) {
>     -                               pr_warn("filesystem requested both auto and "
>     -                                       "precise cache control - using auto\n");
>     -                               fc->precise_inval_data = 0;
>     -                       }
>                             if (arg->flags & FUSE_DO_READDIRPLUS) {
>                                     fc->do_readdirplus = 1;
>                                     if (arg->flags & FUSE_READDIRPLUS_AUTO)
>
> Even though it is ok for me personally (I could be careful and use only
> FUSE_PRECISE_INVAL_DATA) I still think usage of both "auto" and "precise"
> invalidation modes deserves a warning. It is only at filesystem init time. What
> is the reason not to print it?

The warning makes no sense.  It should either be failure or silent override.

> - "fuse: retrieve: cap requested size to negotiated max_write"
>
>      Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
>      Cc: Han-Wen Nienhuys <hanwen@google.com>
>      Cc: Jakob Unterwurzacher <jakobunt@gmail.com>
>     -Cc: <stable@vger.kernel.org> # v2.6.36+
>
> what is the reason not to include this patch into stable series?

This doens't fix any bugs out there, but there is a slight chance of
regression (so it might possibly have to be reverted in the future) so
it absolutely makes no sense to backport it to stable.

Thanks,
Miklos
