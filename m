Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73773C742D2
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E3220989
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 18:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PShQDYtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfGLStS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 14:49:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43451 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfGLStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 14:49:17 -0400
Received: by mail-pl1-f195.google.com with SMTP id cl9so5156491plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 11:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRVC5IMZoa5o9Lk6/1pZnpghBb7QNpMZIqJdxQxjH40=;
        b=PShQDYtfPEgQskYO6b88lcP+62BM211EGSGUonfZjCevTp6bMxwg8wiYIm73nchh4p
         1NhRTLriTnIWs5iTgUQ/JCZZ3yElVWunsKFQwXqdfCbyzDhdyoPqtOINHwE9cMrnlBVR
         vkrtq+g1VxQsdgQtI6/Ut/zOauwjdfhl1YOCQ270GqOWAjdnQdO+u4i0l4/Z6RNHWrKY
         UaJaqAbKqijc8Y2jQ5lsrum4KA46TAxTqA0x+d2vrSRelEtEIeCusL4gU+rVHZukUNtQ
         Qv7c/Mcy+lTG+97vgNxcGUzoPcHYfdPj3uSVzAilrB8ssmS+ylLiZAYzzMA8VMMBRMQV
         r0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MRVC5IMZoa5o9Lk6/1pZnpghBb7QNpMZIqJdxQxjH40=;
        b=EVwyN7fnJT8tP1w5I6HYZ3dplZ5/lK4wavrOQVgp7g73kbDxETdUmRqgaTO4FTw3FF
         4vwLj+GtDLyD1Rq5z4UGGHXWYtiH00rTXd15oJpsLEQBB1zUXOzoI1ymALAkh+uuGI7E
         Ihdvoky2zuW91x6UhPepZ6u8c33DbCkQrowKtXuQd2341VruBPaeIt2TtlIffS7YmzBc
         zcmsBz7W2teNq9k+i3K2xX14TCrgjTqjtbjvYvgQxQq/UL27BGDL/I24VCiGZc7oQdiM
         mt5fW62zYD1/xdyYWZ9TPwmWiLH81q2iPKDYLRkQdlfD7cyxGKGNOgGPYyNHmyV+eJ/j
         ffRw==
X-Gm-Message-State: APjAAAWNQXKjpLCuLEntZiy2U19J59jboRyomb/kaIbOZHGnI8rle3RV
        R0ADgS0q4l07u6YimA7JGTt/6x9ONzYSNzehBqxz/g==
X-Google-Smtp-Source: APXvYqxBLbwppsbzxjlJ9R2+QpWY9Uc7vDpVh0ziWCRQc3SKPvW+WWR0k4LO6QLqnD1Ja2x1b0JF77dK64H4hN7TBAw=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr13242312plq.223.1562957356404;
 Fri, 12 Jul 2019 11:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190712093720.1461418-1-arnd@arndb.de>
In-Reply-To: <20190712093720.1461418-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Jul 2019 11:49:05 -0700
Message-ID: <CAKwvOd=Xdp_=G3UU9ubayeTvkKCJ9hak0a-7yK90-RPUBQKrpw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Support clang option for stack alignment
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Duke Du <Duke.Du@amd.com>, Charlene Liu <charlene.liu@amd.com>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 2:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
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

Maybe time for a macro in Kbuild.include or some such, if we see this
pattern being repeated?

>
> Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
-- 
Thanks,
~Nick Desaulniers
