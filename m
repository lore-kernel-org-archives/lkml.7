Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C2FC742D6
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7760E204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 17:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDMX9IIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfGLRvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 13:51:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35789 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfGLRvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 13:51:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id y4so10839442wrm.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fYa05UH7mYYSqEPDopwNxAMSVNVWoZBhWk4yJQZslm8=;
        b=nDMX9IINQd40UuthTZ+AmI54a9XV2VKnSmT2iOJ76YzakV3CCrBZn6HHV/Iy+6D1Q2
         yV7+Gqc8jWCNxrJffxHVlnHbYfm0+u0PG4+TqxJFlurXYJ2kUoQ3OhSVNf8EgJH/rZDj
         yw2t/Z9Yy3mBhGp3urERGvBhMmnUX0z96s6JX/V0wyyOtf/gEL9qdtuq4/NK3jhHssmt
         Ch0i+abC6cTcE/uyDHf8yc7WRGouGfIUzpedzlQoiJN4R2kOY4k5Ap4YYqeImWQCmJZI
         F5Ntn4NNH4QZB3cR28U3yALBzpblBiMd3bUGbFAO5pjNEdfaL+TLvrOts+YLAh8T2ccC
         Fixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fYa05UH7mYYSqEPDopwNxAMSVNVWoZBhWk4yJQZslm8=;
        b=mIjmKi3BzSm9mw8DTsJcc4SMoNOHSF7cmqcE3ZbcBFGb6P4BCAPNSjDW369bqHaryU
         uJImFiUV4vROIl+uoXn7cRc1cucFU3WS9XrkaaRtx5SD6tEwIxR504T67/GMxaJ5tFFE
         nItWvMQF2+GxTROtgCJCqez9Rwlad5+Cktv2ZVbX4w6arJpmu/n7AkzNOHnNKID1+uOl
         Dn4ACCbx/dsTAODBQlW07wynLf04St/nwULbqkJiHcBtnhcZW2ZmCmGIQJeUDh2H0C8G
         jNp2cx1uVODXqmAF6Kc54HurTOJ+7Ef5l8tew84hfAH+EjIqJQkzoDSyYeF/f4vXuUpn
         XxCg==
X-Gm-Message-State: APjAAAUrOrxEAw7hMVQm7DoE7GJEcbukeVZJ8CjCTD/HYt9k9PIgaKYA
        LnrPyWDIxwEWCKUyNuYA8prPJglShA3pE+Z433U=
X-Google-Smtp-Source: APXvYqxzKqSnB6g+6t1T4eeuBWsXb+aYieIdJBcbsr58GeWc1PwO1xAStg2YUGXX0pq2k45hxpR19iL74Le3Dm4+RLM=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr12482439wrw.323.1562953881684;
 Fri, 12 Jul 2019 10:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190712093720.1461418-1-arnd@arndb.de>
In-Reply-To: <20190712093720.1461418-1-arnd@arndb.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 12 Jul 2019 13:51:09 -0400
Message-ID: <CADnq5_Mm=Fj4AkFtuo+W_295q8r6DY3Sumo7gTG-McUYY=CeVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Support clang option for stack alignment
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Charlene Liu <charlene.liu@amd.com>, Duke Du <Duke.Du@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux@googlegroups.com,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 5:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As previously fixed for dml in commit 4769278e5c7f ("amdgpu/dc/dml:
> Support clang option for stack alignment") and calcs in commit
> cc32ad8f559c ("amdgpu/dc/calcs: Support clang option for stack
> alignment"), dcn20 uses an option that is not available with clang:
>
> clang: error: unknown argument: '-mpreferred-stack-boundary=4'
> scripts/Makefile.build:281: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o' failed
>
> Use the same trick that we have in the other two files.
>
> Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  8 +++++++-
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 16 ++++++++++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> index 1b68de27ba74..e9721a906592 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> @@ -10,7 +10,13 @@ ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
>  DCN20 += dcn20_dsc.o
>  endif
>
> -CFLAGS_dcn20_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +       cc_stack_align := -mpreferred-stack-boundary=4
> +else ifneq ($(call cc-option, -mstack-alignment=16),)
> +       cc_stack_align := -mstack-alignment=16
> +endif
> +
> +CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
>
>  AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index c5d5b94e2604..e019cd9447e8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -1,10 +1,18 @@
>  #
>  # Makefile for the 'dsc' sub-component of DAL.
>
> -CFLAGS_rc_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_rc_calc_dpi.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_codec_main_amd.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_dc_dsc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +       cc_stack_align := -mpreferred-stack-boundary=4
> +else ifneq ($(call cc-option, -mstack-alignment=16),)
> +       cc_stack_align := -mstack-alignment=16
> +endif
> +
> +dsc_ccflags := -mhard-float -msse $(cc_stack_align)
> +
> +CFLAGS_rc_calc.o := $(dsc_ccflags)
> +CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
> +CFLAGS_codec_main_amd.o := $(dsc_ccflags)
> +CFLAGS_dc_dsc.o := $(dsc_ccflags)
>
>  DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
