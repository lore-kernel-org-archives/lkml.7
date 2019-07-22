Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D56BC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B33521901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fJ1SX2xR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfGVSYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:24:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36980 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGVSYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:24:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so7316560pgd.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tbsYAl6lEifnMbida92iAOzaQwo02qpPsm/r9kyfdRA=;
        b=fJ1SX2xRQ+m9MlCgPtJImagZL+JUJWHWzwXd06uCwCbYuwTUJ+lFT83AmDqNEyG1KS
         6i7OehgbNUQJV0DQiK528BtDnflwmfsAuvxK9/VXd5gPBl/mcvha4JTF0sHl6bn08Wu3
         6FexZ+LNc1n/xwKwySfZyTyLm5zjlY78dlveQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tbsYAl6lEifnMbida92iAOzaQwo02qpPsm/r9kyfdRA=;
        b=hYiVvVwjtalhx8skw2e2E+M1nA8d/kK3jKK4Sx4y/2lds+VLJ+6pDL32A7XRSIy4g7
         xoII91CQGQkUt0KzpOuM4U8hoOzl44muFp2WUBPV2kQKINXhl+V85bu8IFDe15tjpsrp
         czM0RvlHxrvBSMvEvpk8ie2ug7COUJcyz9skyESms4YzierOoVl/0C9nOKL0vE/lXepK
         6AxRqHdVVFF2XEDRiTOjQN08Gtfon7lx0r5sO4u/sCFB8tLDrJYYD7f2hDo6oKO7/ivQ
         csMcLOZDpnvEGbDnM9CcL6bjhExi/G0TdpkphZCR2fDddpeb7o0/dnaUepzSvPVYK1hW
         vVRA==
X-Gm-Message-State: APjAAAX3l1ZndXjZA2TcNqx8cXZ3dInznpBIddyVfSdqEumC/VpWw+dQ
        yweJznHsF55zx0zfJqy+VEdEKw==
X-Google-Smtp-Source: APXvYqwOqYkXB6MsiqicQMplBz9tEI/SBuN3tpmwoB/rD+fYBbHpvD2aXPJCyAlJVBa7oMwPObiyZw==
X-Received: by 2002:a63:ee0c:: with SMTP id e12mr73754197pgi.184.1563819848563;
        Mon, 22 Jul 2019 11:24:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o3sm74917711pje.1.2019.07.22.11.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jul 2019 11:24:07 -0700 (PDT)
Date:   Mon, 22 Jul 2019 11:24:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Mark expected switch fall-throughs
Message-ID: <201907221123.1B963BA9@keescook>
References: <20190722181244.GA2085@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722181244.GA2085@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 01:12:44PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch
> cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/gpu/drm/i915/gem/i915_gem_mman.c: In function ‘i915_gem_fault’:
> drivers/gpu/drm/i915/gem/i915_gem_mman.c:342:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (!i915_terminally_wedged(i915))
>       ^
> drivers/gpu/drm/i915/gem/i915_gem_mman.c:345:2: note: here
>   case -EAGAIN:
>   ^~~~
> 
> drivers/gpu/drm/i915/gem/i915_gem_pages.c: In function ‘i915_gem_object_map’:
> ./include/linux/compiler.h:78:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/bug.h:136:2: note: in expansion of macro ‘unlikely’
>   unlikely(__ret_warn_on);     \
>   ^~~~~~~~
> drivers/gpu/drm/i915/i915_utils.h:49:25: note: in expansion of macro ‘WARN’
>  #define MISSING_CASE(x) WARN(1, "Missing case (%s == %ld)\n", \
>                          ^~~~
> drivers/gpu/drm/i915/gem/i915_gem_pages.c:270:3: note: in expansion of macro ‘MISSING_CASE’
>    MISSING_CASE(type);
>    ^~~~~~~~~~~~
> drivers/gpu/drm/i915/gem/i915_gem_pages.c:272:2: note: here
>   case I915_MAP_WB:
>   ^~~~
> 
> drivers/gpu/drm/i915/i915_gpu_error.c: In function ‘error_record_engine_registers’:
> ./include/linux/compiler.h:78:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/bug.h:136:2: note: in expansion of macro ‘unlikely’
>   unlikely(__ret_warn_on);     \
>   ^~~~~~~~
> drivers/gpu/drm/i915/i915_utils.h:49:25: note: in expansion of macro ‘WARN’
>  #define MISSING_CASE(x) WARN(1, "Missing case (%s == %ld)\n", \
>                          ^~~~
> drivers/gpu/drm/i915/i915_gpu_error.c:1196:5: note: in expansion of macro ‘MISSING_CASE’
>      MISSING_CASE(engine->id);
>      ^~~~~~~~~~~~
> drivers/gpu/drm/i915/i915_gpu_error.c:1197:4: note: here
>     case RCS0:
>     ^~~~
> 
> drivers/gpu/drm/i915/display/intel_dp.c: In function ‘intel_dp_get_fia_supported_lane_count’:
> ./include/linux/compiler.h:78:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>  # define unlikely(x) __builtin_expect(!!(x), 0)
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/asm-generic/bug.h:136:2: note: in expansion of macro ‘unlikely’
>   unlikely(__ret_warn_on);     \
>   ^~~~~~~~
> drivers/gpu/drm/i915/i915_utils.h:49:25: note: in expansion of macro ‘WARN’
>  #define MISSING_CASE(x) WARN(1, "Missing case (%s == %ld)\n", \
>                          ^~~~
> drivers/gpu/drm/i915/display/intel_dp.c:233:3: note: in expansion of macro ‘MISSING_CASE’
>    MISSING_CASE(lane_info);
>    ^~~~~~~~~~~~
> drivers/gpu/drm/i915/display/intel_dp.c:234:2: note: here
>   case 1:
>   ^~~~
> 
> drivers/gpu/drm/i915/display/intel_display.c: In function ‘check_digital_port_conflicts’:
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/engine/disp/cursgv100.o
> drivers/gpu/drm/i915/display/intel_display.c:12043:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>     if (WARN_ON(!HAS_DDI(to_i915(dev))))
>        ^
> drivers/gpu/drm/i915/display/intel_display.c:12046:3: note: here
>    case INTEL_OUTPUT_DP:
>    ^~~~
> 
> Also, notice that the Makefile is modified in order to stop
> ignoring fall-through warnings. The -Wimplicit-fallthrough
> option will be enabled globally in v5.3.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Excellent; I think these are literally the last remaining cases in the
kernel. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  drivers/gpu/drm/i915/Makefile                | 1 -
>  drivers/gpu/drm/i915/display/intel_display.c | 2 +-
>  drivers/gpu/drm/i915/display/intel_dp.c      | 1 +
>  drivers/gpu/drm/i915/gem/i915_gem_mman.c     | 2 +-
>  drivers/gpu/drm/i915/gem/i915_gem_pages.c    | 2 +-
>  drivers/gpu/drm/i915/i915_gpu_error.c        | 1 +
>  6 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
> index 91355c2ea8a5..8cace65f50ce 100644
> --- a/drivers/gpu/drm/i915/Makefile
> +++ b/drivers/gpu/drm/i915/Makefile
> @@ -16,7 +16,6 @@ subdir-ccflags-y := -Wall -Wextra
>  subdir-ccflags-y += $(call cc-disable-warning, unused-parameter)
>  subdir-ccflags-y += $(call cc-disable-warning, type-limits)
>  subdir-ccflags-y += $(call cc-disable-warning, missing-field-initializers)
> -subdir-ccflags-y += $(call cc-disable-warning, implicit-fallthrough)
>  subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
>  # clang warnings
>  subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 8592a7d422de..30b97ded6fdd 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -12042,7 +12042,7 @@ static bool check_digital_port_conflicts(struct intel_atomic_state *state)
>  		case INTEL_OUTPUT_DDI:
>  			if (WARN_ON(!HAS_DDI(to_i915(dev))))
>  				break;
> -			/* else: fall through */
> +			/* else, fall through */
>  		case INTEL_OUTPUT_DP:
>  		case INTEL_OUTPUT_HDMI:
>  		case INTEL_OUTPUT_EDP:
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 4336df46fe78..d0fc34826771 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -231,6 +231,7 @@ static int intel_dp_get_fia_supported_lane_count(struct intel_dp *intel_dp)
>  	switch (lane_info) {
>  	default:
>  		MISSING_CASE(lane_info);
> +		/* fall through */
>  	case 1:
>  	case 2:
>  	case 4:
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> index 391621ee3cbb..39a661927d8e 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
> @@ -341,7 +341,7 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
>  		 */
>  		if (!i915_terminally_wedged(i915))
>  			return VM_FAULT_SIGBUS;
> -		/* else: fall through */
> +		/* else, fall through */
>  	case -EAGAIN:
>  		/*
>  		 * EAGAIN means the gpu is hung and we'll wait for the error
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> index b36ad269f4ea..65eb430cedba 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> @@ -268,7 +268,7 @@ static void *i915_gem_object_map(const struct drm_i915_gem_object *obj,
>  	switch (type) {
>  	default:
>  		MISSING_CASE(type);
> -		/* fallthrough to use PAGE_KERNEL anyway */
> +		/* fallthrough - to use PAGE_KERNEL anyway */
>  	case I915_MAP_WB:
>  		pgprot = PAGE_KERNEL;
>  		break;
> diff --git a/drivers/gpu/drm/i915/i915_gpu_error.c b/drivers/gpu/drm/i915/i915_gpu_error.c
> index b7e9fddef270..41a511d5267f 100644
> --- a/drivers/gpu/drm/i915/i915_gpu_error.c
> +++ b/drivers/gpu/drm/i915/i915_gpu_error.c
> @@ -1194,6 +1194,7 @@ static void error_record_engine_registers(struct i915_gpu_state *error,
>  			switch (engine->id) {
>  			default:
>  				MISSING_CASE(engine->id);
> +				/* fall through */
>  			case RCS0:
>  				mmio = RENDER_HWS_PGA_GEN7;
>  				break;
> -- 
> 2.22.0
> 

-- 
Kees Cook
