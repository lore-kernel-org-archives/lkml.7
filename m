Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3706C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C0B216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b46S21mT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390491AbfGHQAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:00:01 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39985 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732250AbfGHQAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:00:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so11394859wrl.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EfmsMBiD7ymdFFI6JkOA8q46/TMtliNwPPlkYR2dONs=;
        b=b46S21mTjINToSoVkmj+AcRN+LZjkQgqcpeDF3pmzNQbtPHSOuQFGiCZ1iZKgiR1VI
         5wUbKwy+k0sXzqpdeFD8VZkWg5mCpQio1phhXtkDz6AH3HgfTxiBMNzbuy/G1AWUbWH/
         7sKYHM7/uuVTPWUvmB9z6Vty+Npia5pVNSCUMpIq1lDnOLg2xBYJ3y3rH/su7tQPocbe
         1TAFvJZoecyq7m/JGFoH2nEttQIrdKi/FGO0VRZxRrdOBvUslKXAsh2Rrblplt8OsLgX
         iZcyiovKDWKth+W1kHXNA7aZyn+PQ6bx56jxOrifjOCUnKJTtATcLdRvqaxhxzYonvw1
         grFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EfmsMBiD7ymdFFI6JkOA8q46/TMtliNwPPlkYR2dONs=;
        b=FPZQuFjeBivbAA7lPOTPkVQS6Yk85vhqAQGLWx0yIeUT1qe6fkCiOYBlf3kdqm7+jA
         M+xwzFjk5/fqSm4k84Heb3jV+AujZ2iWgoOA4NcKHL6iIlB2ulSYllJZpPrxSkxQvAdx
         VLSUEykZsgOXFW/05FIvMV++YLF3lwS14FFZblUHn2Yjpquv4130I1qZJNulCh4S8f71
         c6ASrgusP2aiUeNzt+SaaVntu3eMNHvgzX9lAaLo+uFA4NmnJ457Y8EHIasN8aQP1zPI
         Y3K/8tkbj8Wie4fqQVpiJjcAZV0FeeLFTCQDdUaafD4BchskGiu3KTsx0o4bYKthb2gH
         IeSg==
X-Gm-Message-State: APjAAAUN27kpMQuFZ5VVyo5xx6YIXALgyPP60tdpxOWfmHtzuSP5pQmV
        meGEut5OR3kqM83qE/Q5ZGCVsGbu1VhQXWLdmU4=
X-Google-Smtp-Source: APXvYqytfkoPC+fjFM+XSffDXhGPJpmy59YbqycegztPzyhvYtqPhdSsol9PfYzWA/XbYSdkxpR1BLoMjpk4RuAW7NA=
X-Received: by 2002:adf:d847:: with SMTP id k7mr463991wrl.74.1562601598985;
 Mon, 08 Jul 2019 08:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190708135135.610355-1-arnd@arndb.de>
In-Reply-To: <20190708135135.610355-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 8 Jul 2019 11:59:47 -0400
Message-ID: <CADnq5_PAQ0_tJApqzCc8tRx-x7gY1HGaAG5zo-jc=zknaAdPow@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix building without CONFIG_HMM_MIRROR
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 8, 2019 at 9:51 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> 'struct hmm_mirror' is not defined without the Kconfig option set,
> so we cannot include it within another struct:
>
> In file included from drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:72:
> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_mn.h:69:20: error: field has incomplete type 'struct hmm_mirror'
>         struct hmm_mirror       mirror;
>                                 ^
> drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu_mn.h:69:9: note: forward declaration of 'struct hmm_mirror'
>         struct hmm_mirror       mirror;
>
> Add the #ifdef around it that is also used for all functions operating
> on it.
>
> Fixes: 7590f6d211ec ("drm/amdgpu: Prepare for hmm_range_register API change")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> index 281fd9fef662..b8ed68943625 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.h
> @@ -65,8 +65,10 @@ struct amdgpu_mn {
>         struct rw_semaphore     lock;
>         struct rb_root_cached   objects;
>
> +#ifdef CONFIG_HMM_MIRROR
>         /* HMM mirror */
>         struct hmm_mirror       mirror;
> +#endif
>  };
>
>  #if defined(CONFIG_HMM_MIRROR)
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
