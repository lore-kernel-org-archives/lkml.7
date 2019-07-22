Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76FBC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA68121901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qub/iKrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbfGVTKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:10:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55888 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGVTKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:10:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so36231712wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aVYcCckX+JiVpMSlYoHq4KH9qszVNVB70AhdXAa1wJQ=;
        b=qub/iKrFGQDkwWhl+TYx1KEcXLO9fhwX0W3Mh/KuF+4I+fObmrUXyUTCnDVgRw7IxL
         9R1o69vAhHi+rIbwOWA/3FRnYQxL/H8nti83VcnlUQuU12z7t2VFgPiI9XbZbxP+VEnj
         o12Swo/OjV31OZho6aBoQHzug5tjcqwoKIMwNAFPZUyGJwzy0AbM9dTtk2bN3YZJB4oI
         NaA3tTFtJQv93nmLTl6RrbeGTsUV3A9x5NuYFLhViv2m1hAU1lzyA3Ix6kFU8YAEmEf5
         FB0aOnP9hEJobyKxxqnLyG/E/QtYCv6KhapPylSVoxaYv6edAddMdIpGq+XKT3cH6YbN
         htCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aVYcCckX+JiVpMSlYoHq4KH9qszVNVB70AhdXAa1wJQ=;
        b=m8gtvQPwJNQ3TN99jPevVjg/bmeBfcVL8+6K3JpPFY9yhX7YYsZFGUL4ybbe9iOCMV
         5VVhx047GK9MaRUU/Bk0XLvhu9MUQp1D6JvEY2PkrFYdpWYYRFUtvU7FaK57PACxvkLX
         CCH4hvd8rYMtYm/Pedagwgs1SWeUk27S+8EbPmtaJIW3vXGTfuYEhG37wp1Y8SJswdSp
         KWnDk/q9VXTPhTWpasV9caoVdUjDx2Cw99Vfb1G5CK903DgzHihktTvn4StwozGah+kC
         U0KeIzv8SvDvWxIKCklfBGkkTHjdeufXnlv0XCgxYOck0nRyzZjRNCS7gN0mdUV0zGg5
         Kj4g==
X-Gm-Message-State: APjAAAWFrDe50Bz9gpoJZrE9JkuRLHvTCAiLNsdGCxsYxV3heku3kzw+
        EnjIqfH8S6PcyYxC7mFrotY1YYTfTxOzhpv4tsk=
X-Google-Smtp-Source: APXvYqxOEcG0mMOrFl56XRrzHBF5u5axdSumScYcjEH9nwQRrxRPxxCVtT76ftWqC0vQG4IXEFFcHxbx9pdIOoye/Ak=
X-Received: by 2002:a1c:67c3:: with SMTP id b186mr61322784wmc.34.1563822632926;
 Mon, 22 Jul 2019 12:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190721214935.GA910@embeddedor>
In-Reply-To: <20190721214935.GA910@embeddedor>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 22 Jul 2019 15:10:20 -0400
Message-ID: <CADnq5_OTmx==m+1fJbf1PxPhPM0H0O8GRjq4eWeX6sw889YPrA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Philip Cox <Philip.Cox@amd.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 6:12 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Add missing break statement in order to prevent the code from falling
> through to case CHIP_NAVI10.
>
> This bug was found thanks to the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Fixes: 14328aa58ce5 ("drm/amdkfd: Add navi10 support to amdkfd. (v3)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> index 792371442195..4e3fc284f6ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> @@ -668,6 +668,7 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>         case CHIP_RAVEN:
>                 pcache_info = raven_cache_info;
>                 num_of_cache_types = ARRAY_SIZE(raven_cache_info);
> +               break;
>         case CHIP_NAVI10:
>                 pcache_info = navi10_cache_info;
>                 num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
> --
> 2.22.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
