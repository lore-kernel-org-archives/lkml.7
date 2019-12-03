Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C6C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377E120684
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 12:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfLCMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 07:41:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:50685 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725957AbfLCMlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 07:41:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:41:49 -0800
X-IronPort-AV: E=Sophos;i="5.69,273,1571727600"; 
   d="scan'208";a="200986464"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 04:41:46 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Lyude Paul <lyude@redhat.com>, intel-gfx@lists.freedesktop.org
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] drm/i915: Auto detect DPCD backlight support by default
In-Reply-To: <20191122231616.2574-5-lyude@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191122231616.2574-1-lyude@redhat.com> <20191122231616.2574-5-lyude@redhat.com>
Date:   Tue, 03 Dec 2019 14:41:44 +0200
Message-ID: <87o8wpinsn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019, Lyude Paul <lyude@redhat.com> wrote:
> Turns out we actually already have some companies, such as Lenovo,
> shipping machines with AMOLED screens that don't allow controlling the
> backlight through the usual PWM interface and only allow controlling it
> through the standard EDP DPCD interface. One example of one of these
> laptops is the X1 Extreme 2nd Generation.
>
> Since we've got systems that need this turned on by default now to have
> backlight controls working out of the box, let's start auto-detecting it
> for systems by default based on what the VBT tells us. We do this by
> changing the default value for the enable_dpcd_backlight module param
> from 0 to -1.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/i915_params.c | 2 +-
>  drivers/gpu/drm/i915/i915_params.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_params.c b/drivers/gpu/drm/i915/i915_params.c
> index 1dd1f3652795..31eed60c167e 100644
> --- a/drivers/gpu/drm/i915/i915_params.c
> +++ b/drivers/gpu/drm/i915/i915_params.c
> @@ -172,7 +172,7 @@ i915_param_named_unsafe(inject_probe_failure, uint, 0400,
>  
>  i915_param_named(enable_dpcd_backlight, int, 0600,
>  	"Enable support for DPCD backlight control"
> -	"(-1=use per-VBT LFP backlight type setting, 0=disabled [default], 1=enabled)");
> +	"(-1=use per-VBT LFP backlight type setting [default], 0=disabled, 1=enabled)");
>  
>  #if IS_ENABLED(CONFIG_DRM_I915_GVT)
>  i915_param_named(enable_gvt, bool, 0400,
> diff --git a/drivers/gpu/drm/i915/i915_params.h b/drivers/gpu/drm/i915/i915_params.h
> index 31b88f297fbc..a79d0867f77a 100644
> --- a/drivers/gpu/drm/i915/i915_params.h
> +++ b/drivers/gpu/drm/i915/i915_params.h
> @@ -64,7 +64,7 @@ struct drm_printer;
>  	param(int, reset, 3) \
>  	param(unsigned int, inject_probe_failure, 0) \
>  	param(int, fastboot, -1) \
> -	param(int, enable_dpcd_backlight, 0) \
> +	param(int, enable_dpcd_backlight, -1) \
>  	param(char *, force_probe, CONFIG_DRM_I915_FORCE_PROBE) \
>  	param(unsigned long, fake_lmem_start, 0) \
>  	/* leave bools at the end to not create holes */ \

-- 
Jani Nikula, Intel Open Source Graphics Center
