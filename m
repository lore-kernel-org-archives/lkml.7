Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BB5C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A56218BE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbfGWAAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:00:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:50651 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbfGWAAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 20:00:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 17:00:09 -0700
X-IronPort-AV: E=Sophos;i="5.64,296,1559545200"; 
   d="scan'208";a="160027458"
Received: from rdvivi-losangeles.jf.intel.com (HELO intel.com) ([10.7.196.65])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 17:00:09 -0700
Date:   Mon, 22 Jul 2019 17:00:44 -0700
From:   Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Mark expected switch fall-throughs
Message-ID: <20190723000044.GA29820@intel.com>
References: <20190722181244.GA2085@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190722181244.GA2085@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

could you please rebase on top of drm-tip and resend it please?

Thanks,
Rodrigo.

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
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
