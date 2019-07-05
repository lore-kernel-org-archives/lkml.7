Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2D3C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73297218A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 12:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfGEMmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 08:42:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:5662 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbfGEMmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 08:42:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 05:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="169667533"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 05 Jul 2019 05:42:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 05 Jul 2019 15:42:04 +0300
Date:   Fri, 5 Jul 2019 15:42:04 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        lucas.demarchi@intel.com, imre.deak@intel.com,
        jose.souza@intel.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] drm/i915: Remove set but not used variable
 'intel_dig_port'
Message-ID: <20190705124204.GO5942@intel.com>
References: <20190705113138.65880-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190705113138.65880-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 11:31:38AM +0000, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/i915/display/intel_ddi.c: In function 'intel_ddi_get_config':
> drivers/gpu/drm/i915/display/intel_ddi.c:3774:29: warning:
>  variable 'intel_dig_port' set but not used [-Wunused-but-set-variable]
>   struct intel_digital_port *intel_dig_port;
> 
> It is never used, so can be removed.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied to drm-intel-next-queued. Thanks for the patch.

> ---
>  drivers/gpu/drm/i915/display/intel_ddi.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
> index a4172595c8d8..30e48609db1d 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
> @@ -3771,7 +3771,6 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
>  	struct drm_i915_private *dev_priv = to_i915(encoder->base.dev);
>  	struct intel_crtc *intel_crtc = to_intel_crtc(pipe_config->base.crtc);
>  	enum transcoder cpu_transcoder = pipe_config->cpu_transcoder;
> -	struct intel_digital_port *intel_dig_port;
>  	u32 temp, flags = 0;
>  
>  	/* XXX: DSI transcoder paranoia */
> @@ -3810,7 +3809,6 @@ void intel_ddi_get_config(struct intel_encoder *encoder,
>  	switch (temp & TRANS_DDI_MODE_SELECT_MASK) {
>  	case TRANS_DDI_MODE_SELECT_HDMI:
>  		pipe_config->has_hdmi_sink = true;
> -		intel_dig_port = enc_to_dig_port(&encoder->base);
>  
>  		pipe_config->infoframes.enable |=
>  			intel_hdmi_infoframes_enabled(encoder, pipe_config);
> 
> 

-- 
Ville Syrjälä
Intel
