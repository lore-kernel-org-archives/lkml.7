Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B01ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A78820842
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:56:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbfJAO4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:56:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:45896 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfJAO4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:56:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 07:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="203254365"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga002.jf.intel.com with SMTP; 01 Oct 2019 07:55:57 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 01 Oct 2019 17:55:56 +0300
Date:   Tue, 1 Oct 2019 17:55:56 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sean Paul <seanpaul@chromium.org>, kernel@collabora.com
Subject: Re: [PATCH v3 5/5] RFC: drm/atomic-helper: Reapply color
 transformation after resume
Message-ID: <20191001145556.GP1208@intel.com>
References: <20190930222802.32088-1-ezequiel@collabora.com>
 <20190930222802.32088-6-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190930222802.32088-6-ezequiel@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 07:28:02PM -0300, Ezequiel Garcia wrote:
> Some platforms are not able to maintain the color transformation
> state after a system suspend/resume cycle.
> 
> Set the colog_mgmt_changed flag so that CMM on the CRTCs in
> the suspend state are reapplied after system resume.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> This is an RFC, and it's mostly based on Jacopo Mondi's work https://lkml.org/lkml/2019/9/6/498.
> 
> Changes from v2:
> * New patch.
> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index e41db0f202ca..518488125575 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3234,8 +3234,20 @@ int drm_atomic_helper_resume(struct drm_device *dev,
>  			     struct drm_atomic_state *state)
>  {
>  	struct drm_modeset_acquire_ctx ctx;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_crtc *crtc;
> +	unsigned int i;
>  	int err;
>  
> +	for_each_new_crtc_in_state(state, crtc, crtc_state, i) {
> +		/*
> +		 * Force re-enablement of CMM after system resume if any
> +		 * of the DRM color transformation properties was set in
> +		 * the state saved at system suspend time.
> +		 */
> +		if (crtc_state->gamma_lut)

You say "any" but you check the one?

> +			crtc_state->color_mgmt_changed = true;

But I'm not convinced this is the best way to go about it. 
I would generally expect that you repgrogram everything
when doing a full modeset since the state was possibly
lost while the crtc was disabled.

> +	}
>  	drm_mode_config_reset(dev);
>  
>  	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
> -- 
> 2.22.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
