Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA687C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C39121D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 10:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgABKFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 05:05:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:1240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727987AbgABKFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 05:05:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 02:05:44 -0800
X-IronPort-AV: E=Sophos;i="5.69,386,1571727600"; 
   d="scan'208";a="214112239"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 02:05:40 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: remove boolean comparisons in conditionals.
In-Reply-To: <20200102094921.6274-1-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20200102094921.6274-1-wambui.karugax@gmail.com>
Date:   Thu, 02 Jan 2020 12:05:38 +0200
Message-ID: <87eewitbpp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Jan 2020, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> Remove unnecessary comparisons to true/false in if statements.
> Issues found by coccinelle.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Thanks for the patch.

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c  | 2 +-
>  drivers/gpu/drm/i915/display/intel_dp.c   | 2 +-
>  drivers/gpu/drm/i915/display/intel_sdvo.c | 4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index 9ba794cb9b4f..c065078b3be2 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -1812,7 +1812,7 @@ void intel_ddi_set_vc_payload_alloc(const struct intel_crtc_state *crtc_state,
>  	u32 temp;
>  
>  	temp = I915_READ(TRANS_DDI_FUNC_CTL(cpu_transcoder));
> -	if (state == true)
> +	if (state)
>  		temp |= TRANS_DDI_DP_VC_PAYLOAD_ALLOC;
>  	else
>  		temp &= ~TRANS_DDI_DP_VC_PAYLOAD_ALLOC;
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index aa515261cb9f..93140c75386a 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4958,7 +4958,7 @@ intel_dp_check_mst_status(struct intel_dp *intel_dp)
>  		WARN_ON_ONCE(intel_dp->active_mst_links < 0);
>  		bret = intel_dp_get_sink_irq_esi(intel_dp, esi);
>  go_again:
> -		if (bret == true) {
> +		if (bret) {
>  
>  			/* check link status - esi[10] = 0x200c */
>  			if (intel_dp->active_mst_links > 0 &&
> diff --git a/drivers/gpu/drm/i915/display/intel_sdvo.c b/drivers/gpu/drm/i915/display/intel_sdvo.c
> index 47f5d87a938a..cff254c52f5e 100644
> --- a/drivers/gpu/drm/i915/display/intel_sdvo.c
> +++ b/drivers/gpu/drm/i915/display/intel_sdvo.c
> @@ -3292,8 +3292,8 @@ bool intel_sdvo_init(struct drm_i915_private *dev_priv,
>  	if (!intel_sdvo_get_capabilities(intel_sdvo, &intel_sdvo->caps))
>  		goto err;
>  
> -	if (intel_sdvo_output_setup(intel_sdvo,
> -				    intel_sdvo->caps.output_flags) != true) {
> +	if (!intel_sdvo_output_setup(intel_sdvo,
> +				     intel_sdvo->caps.output_flags)) {
>  		DRM_DEBUG_KMS("SDVO output failed to setup on %s\n",
>  			      SDVO_NAME(intel_sdvo));
>  		/* Output_setup can leave behind connectors! */

-- 
Jani Nikula, Intel Open Source Graphics Center
