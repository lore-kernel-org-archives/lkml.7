Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9EBC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698A8227C1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qztMIXUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391536AbfGWSbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:31:19 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44557 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfGWSbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:31:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so44193448wrf.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgcKZmsghA7oPWetYCkkd5OFkpIDAUtXqxPwI5yL+Wg=;
        b=qztMIXUXEc7ugXHg+qskimr9KwnkptV6PHxHrzRGKmzLKNSohOo/is4ykh/78r1CeR
         XUefiNyGdV9CzkpG4IMjkzVLWClbbOp288d8sfE3DPEQgyAO/HCNNZxPKBqy+V66iBdR
         GLyky4Om5FWZAavqBKR8aFReAcNZM65dx0yBiXdItwyTFA+ckvQr2M6l1qhtzL6nx5lP
         N6LQKQdlbnNPr7V+hfzvf/XRylyjKhma+oSbw43oXteILlIrEZIGoQx3Al9AH1mHa1ak
         DGoNvbjrlTfRcJZoVbOJTxCNYouQvkz3HZasBId6edYTm5ciZWYuRWsOAtLJbHla89nS
         CR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgcKZmsghA7oPWetYCkkd5OFkpIDAUtXqxPwI5yL+Wg=;
        b=F4B5IhRSuL3EZk8Um3VDaNCOsTZvXyeU4tqKPYe03PWR5s1q/4mPmNLR46d0WYiJZL
         0QZYKQXWGupLMDaHYhTLnZjLpqS6dPZ8/ATVJPhtxPCR0eaPvUs5DDUbOtqLPpbaa5Wi
         wJ6b4+xSEG9M1Bi+BIkYAlRsZ4D3vNXecatm42dRmmcQDNhC0jyhnxp/Hzd1q3ctlRp2
         tUU7HN7Vyww2f62fPz4cFSRL3WQSvjYvAZMNgi/e+Ai3JsJcM066MP2NmUCrzfaTnypX
         UZ9IkL9z06zbUB5DN4dFCQaa7N58QZIKZ99Y21GDSb16JzS3u9q9Hq6URctVFIcKa8JJ
         spGw==
X-Gm-Message-State: APjAAAVbWoI/6dkXJnoVJa6L1nN4fiEUzMiXrpmX3HsKKYPjKePgRQiT
        zZtItJzg+oOZ16V77eGx8bSqccWGBiQGHHM8DZ0=
X-Google-Smtp-Source: APXvYqzcf7VVlisN4ApJwJuo1WLG159w70jMp/nn+JzNWNhFh18BmMNyNlHSd7DmXTIgO1Lgq/cP1jaqtzHIKpmOPsE=
X-Received: by 2002:a5d:6b11:: with SMTP id v17mr6395667wrw.323.1563906675402;
 Tue, 23 Jul 2019 11:31:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190722223112.199769-1-ndesaulniers@google.com>
In-Reply-To: <20190722223112.199769-1-ndesaulniers@google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 23 Jul 2019 14:31:03 -0400
Message-ID: <CADnq5_MA+oCYRWLyaJT+oQGwA2jDwfX554qNZoS6BtKmeSru1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: readd -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        clang-built-linux@googlegroups.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Matthias Kaehlcke <mka@google.com>, samitolvanen@google.com,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Charlene Liu <charlene.liu@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        James Y Knight <jyknight@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 3:16 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> on SSE2 to support emitting double precision floating point instructions
> rather than calls to non-existent (usually available from gcc_s or
> compiler_rt) floating point helper routines for Clang.
>
> This was originally landed in:
> commit 10117450735c ("drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")
> but reverted in:
> commit 193392ed9f69 ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> due to bugreports from GCC builds. Add guards to only do so for Clang.
>
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=109487
> Link: https://github.com/ClangBuiltLinux/linux/issues/327
>
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 4 ++++
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 4 ++++
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 4 ++++
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 4 ++++
>  4 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index 95f332ee3e7e..16614d73a5fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -32,6 +32,10 @@ endif
>
>  calcs_ccflags := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +calcs_ccflags += -msse2
> +endif
> +
>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
>  CFLAGS_dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> index e9721a906592..f57a3b281408 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> @@ -18,6 +18,10 @@ endif
>
>  CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_dcn20_resource.o += -msse2
> +endif
> +
>  AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
>
>  AMD_DISPLAY_FILES += $(AMD_DAL_DCN20)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 0bb7a20675c4..132ade1a234e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -32,6 +32,10 @@ endif
>
>  dml_ccflags := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +dml_ccflags += -msse2
> +endif
> +
>  CFLAGS_display_mode_lib.o := $(dml_ccflags)
>
>  ifdef CONFIG_DRM_AMD_DC_DCN2_0
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index e019cd9447e8..17db603f2d1f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -9,6 +9,10 @@ endif
>
>  dsc_ccflags := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +dsc_ccflags += -msse2
> +endif
> +
>  CFLAGS_rc_calc.o := $(dsc_ccflags)
>  CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
>  CFLAGS_codec_main_amd.o := $(dsc_ccflags)
> --
> 2.22.0.657.g960e92d24f-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
