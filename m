Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FDBC3A59E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DE72339E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 02:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSJhBF3O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbfHVCnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 22:43:46 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51478 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbfHVCnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 22:43:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so4072912wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 19:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+2V9HhKKnOxcZwgG+smQxeIpzg5MY2WFsMF9dUz2ZWM=;
        b=DSJhBF3Om5/KnpK+0LWyWxE8iGn6amDhoaCrc6WmWx+9OLDLwggvxVU9fYFk8iGW+C
         r2LEowif2v/CyzooTyOh4UIyUjrXmBBMCR9llt2CoCGz+65AneozS1eJzxFdnB1jxqPt
         UAO79ce9gqDDb7O511X3mihMdNPdeAV+dwUfNE1fp+5Lo2bFg09Ef8xSL4Ey7e/1dW7w
         /vs3AKg7Jc4HkmrGxwWoGpYeKp0CcDrtUKvGbRckIjAmLrSbII/qGqgh3svbsDW1i6cb
         o3q7PZDN9XyxJhTnhho44E5EptnAZ3rwRvPxdpPceedQ+PPVOsTzQEBrP97XeanaHMpC
         aprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+2V9HhKKnOxcZwgG+smQxeIpzg5MY2WFsMF9dUz2ZWM=;
        b=A7QbTE3SLo00roEbUfnA5Mi7uIClqmIf/O/sqbJJgWvqxdPGByX1+ocZwDWkaA5Urp
         S/kJ/o0cTLI/dn1ZM7EE8S1dAEsyCVC5u2anq9JX4UrGPY9VIqe7X7Y4okEEe9tvHw5M
         jXWNhSwWozT8MZqdKnRKhvEud3ICUwikMHgTHojnRAF8gVe8LGmQdo+IgmsVssu4Ze9G
         63UI5VSaOJIJKdQn573C6dKz3PuXQLv92qyK5thQkp3JPsnX//Zbwu3/RBN/vE9Y/0qQ
         at74bH0igtGvJP2R1GfjI3iRJetMFHJLdYZ/AFzpu+xBZ6LD1IKLD9wFK/I6iw2DJH4I
         zkKA==
X-Gm-Message-State: APjAAAU2XwW3TCwTI3Ef6JWPSnZe1nuuHEYwchuhcJ5eaxr3C2wCuaNy
        h0JMdUFyTJb8zpFQo8dcxmWa3/zoK3tFkg8wW80=
X-Google-Smtp-Source: APXvYqxD/E+UHdGoXQKABwQgWR8efld2lFuHM9IPgAUnitZqsTlwwXt9fBIBFdnmKBvWb0d4kUCa1hVLcgbbn7ZuZFo=
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr3041326wmd.34.1566441823801;
 Wed, 21 Aug 2019 19:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190726140054.31388-1-yuehaibing@huawei.com>
In-Reply-To: <20190726140054.31388-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 21 Aug 2019 22:43:31 -0400
Message-ID: <CADnq5_PcbKZDsqmoL2wK061sL=KfCedmEafn_hpbFZ9tNGrNdA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: remove set but not used variable 'pdd'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  thanks!

Alex

On Fri, Jul 26, 2019 at 11:58 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c: In function restore_process_worker:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:949:29: warning:
>  variable pdd set but not used [-Wunused-but-set-variable]
>
> It is not used since
> commit 5b87245faf57 ("drm/amdkfd: Simplify kfd2kgd interface")
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 8f1076c..240bf68 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1042,7 +1042,6 @@ static void restore_process_worker(struct work_struct *work)
>  {
>         struct delayed_work *dwork;
>         struct kfd_process *p;
> -       struct kfd_process_device *pdd;
>         int ret = 0;
>
>         dwork = to_delayed_work(work);
> @@ -1051,16 +1050,6 @@ static void restore_process_worker(struct work_struct *work)
>          * lifetime of this thread, kfd_process p will be valid
>          */
>         p = container_of(dwork, struct kfd_process, restore_work);
> -
> -       /* Call restore_process_bos on the first KGD device. This function
> -        * takes care of restoring the whole process including other devices.
> -        * Restore can fail if enough memory is not available. If so,
> -        * reschedule again.
> -        */
> -       pdd = list_first_entry(&p->per_device_data,
> -                              struct kfd_process_device,
> -                              per_device_list);
> -
>         pr_debug("Started restoring pasid %d\n", p->pasid);
>
>         /* Setting last_restore_timestamp before successful restoration.
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
