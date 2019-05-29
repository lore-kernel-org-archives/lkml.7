Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14CAD23B5C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 15:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfE2PB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 11:01:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:23070 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfE2PB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 11:01:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 08:01:26 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 29 May 2019 08:01:23 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stuart Summers <stuart.summers@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Subject: Re: [PATCH][next] drm/i915: fix uninitialized variable 'subslice_mask'
In-Reply-To: <20190529144325.17235-1-colin.king@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190529144325.17235-1-colin.king@canonical.com>
Date:   Wed, 29 May 2019 18:04:35 +0300
Message-ID: <87lfyp47zw.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently subslice_mask is not initialized and so data is being
> bit-wise or'd into a garbage value. Fix this by inintializing
> subslice_mask to zero.
>
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: 1ac159e23c2c ("drm/i915: Expand subslice mask")

This was already reverted for other reasons. Need to be fixed on the
next round. For future reference, please Cc: author and reviewers of the
referenced commit.

BR,
Jani.


> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/i915/intel_device_info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/intel_device_info.c b/drivers/gpu/drm/i915/intel_device_info.c
> index 3625f777f3a3..d395a09b994f 100644
> --- a/drivers/gpu/drm/i915/intel_device_info.c
> +++ b/drivers/gpu/drm/i915/intel_device_info.c
> @@ -298,7 +298,7 @@ static void cherryview_sseu_info_init(struct drm_i915_private *dev_priv)
>  {
>  	struct sseu_dev_info *sseu = &RUNTIME_INFO(dev_priv)->sseu;
>  	u32 fuse;
> -	u8 subslice_mask;
> +	u8 subslice_mask = 0;
>  
>  	fuse = I915_READ(CHV_FUSE_GT);

-- 
Jani Nikula, Intel Open Source Graphics Center
