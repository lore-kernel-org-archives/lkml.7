Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59398C10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2832F217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9BbE0GO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfJBVOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:14:42 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44796 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729293AbfJBVOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:14:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so409812pll.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHYXT2MapQxKdVQ7MnzMSwJjofrDGs/mMoboG0lEVTY=;
        b=q9BbE0GObEk4vG/jJQ0YhLUz1bCBYIbTLNZetkjn6SHRgl3kt8KZJrGK1Tsh2z6ny3
         rvHM0yq5mK/VsmL5dflFyowjNdGsZLa3DqmZurfCRLnoFFe9PLQFznn2ekPcO1ZQ7h4/
         LT2HcpG8jJCe3Qz0l/FHM95jgQSltvUcOmtvBNFNJFU4E+e4Bzh/5pm7ylzLg8Wjl4H0
         f+qkN1H/r8SXX07bGvr+mIDfaUG7pZ62TyLGVWu7gva2uU8wXztk/EI4fmdyTi5jufU7
         xItUvO0XmbH9ob6UK2tvmz4vHwQ1KmB61cN//NqcoJgAFvtlE3ZHuok5RFNzlVOHEXNy
         2Iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHYXT2MapQxKdVQ7MnzMSwJjofrDGs/mMoboG0lEVTY=;
        b=WokvJqGOSuT/IEr0n05DIg4w1eYfdvUQZLEUYAfw+j5/xCIEApgqb4JdwU+/4Z5JSW
         84JzGiw4j3aysvlCJCXsJ4dl5SuBhlS5TFRBAkSXEIlaBqXK0W095mNifeiwycE4IsEd
         vKIsnyE7HFuwrZOTyFFlOekBkm/s87fQc4eJnUSW6SoQaQdFTGB768WVCLOsNBQTj7W5
         tFIIBhwGV4edIxyU5l4wiiXw4wXVwkZ74s0fWhYxRZy1SOMOEC34L5ueYDwFHq9IQ8Zs
         g+CosKdGMQkMQdnxjfj57GRPRiZ9meCe8NzwxMasXcMy9MuKXyOTjdtPcCcrBCEUHXPJ
         ysNQ==
X-Gm-Message-State: APjAAAVEFTenHNRUyjmjjVE/4Len3wzUClBjJEoBdm6637sWxull3wRY
        avX6kccG1DC4C/4CMqlcC4o+vPRSoCueVVCPA4917A==
X-Google-Smtp-Source: APXvYqxscMTSRx/XiSzosNRZGgs61rijzLWHJd6F0wCfXuLQb53BowxR8X4US85qSpRvMEwBdGgmXlVN1rxd4bJrnCY=
X-Received: by 2002:a17:902:7c08:: with SMTP id x8mr5677826pll.119.1570050880892;
 Wed, 02 Oct 2019 14:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
In-Reply-To: <20191002120136.1777161-5-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 2 Oct 2019 14:14:29 -0700
Message-ID: <CAKwvOdmjM80XP7VH83iLn=8mz6W1+SbXST2FChEnH0LSRRm4pA@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
To:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 2, 2019 at 5:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Just like all the other variants, this one passes invalid
> compile-time options with clang after the new code got
> merged:
>
> clang: error: unknown argument: '-mpreferred-stack-boundary=4'
> scripts/Makefile.build:265: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o' failed
>
> Use the same variant that we have for dcn20 to fix compilation.
>
> Fixes: eced51f9babb ("drm/amd/display: Add hubp block for Renoir (v2)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
(Though I think it's already been merged)

Alex, do you know why the AMDGPU driver uses a different stack
alignment (16B) than the rest of the x86 kernel?  (see
arch/x86/Makefile which uses 8B stack alignment).

> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> index 8cd9de8b1a7a..ef673bffc241 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> @@ -3,7 +3,17 @@
>
>  DCN21 = dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o
>
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +       cc_stack_align := -mpreferred-stack-boundary=4
> +else ifneq ($(call cc-option, -mstack-alignment=16),)
> +       cc_stack_align := -mstack-alignment=16
> +endif
> +
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
> +
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
> +endif
>
>  AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
>
> --
> 2.20.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191002120136.1777161-5-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers
