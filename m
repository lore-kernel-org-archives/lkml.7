Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF72C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2C620675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 08:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfCGIQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 03:16:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:54224 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbfCGIQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 03:16:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2019 00:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,451,1544515200"; 
   d="scan'208";a="152825672"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.172])
  by fmsmga001.fm.intel.com with ESMTP; 07 Mar 2019 00:16:04 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
In-Reply-To: <20190306200618.17405-1-thomas.preston@codethink.co.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20190306200618.17405-1-thomas.preston@codethink.co.uk>
Date:   Thu, 07 Mar 2019 10:18:00 +0200
Message-ID: <874l8fm72f.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The subject should probably have "drm/i915/bios" or "drm/i915/vbt".

On Wed, 06 Mar 2019, Thomas Preston <thomas.preston@codethink.co.uk> wrote:
> We rely on VBT DDI port info for eDP detection on GEN9 platforms and
> above. This breaks GEN9 platforms which don't have VBT because port A
> eDP now defaults to false. Fix this by defaulting to true when VBT is
> missing.

Please include more details about the machine that doesn't have VBT. Why
don't you have VBT?

Personally I think it was a mistake originally to make guesses about the
outputs in absence of VBT on DDI platforms, because we can never get the
generic guesses right across all ports and all products. And for the
record, that was the result of an easy choice to enable developers way
back when, and forgotten.

Certainly eDP is more likely than something else on port A. But this
will break any outlier products without VBT that have a non-eDP output
on port A. I guess it's a risk we have to take, and handle the fallout
later.

Acked-by: Jani Nikula <jani.nikula@intel.com>

> Fixes: commit a98d9c1d7e9b ("drm/i915/ddi: Rely on VBT DDI port info for eDP detection")

The Fixes: format does *not* include "commit" text.

BR,
Jani.


> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
>  drivers/gpu/drm/i915/intel_bios.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/i915/intel_bios.c b/drivers/gpu/drm/i915/intel_bios.c
> index 1faa494e2bc9..efbbfb64b55f 100644
> --- a/drivers/gpu/drm/i915/intel_bios.c
> +++ b/drivers/gpu/drm/i915/intel_bios.c
> @@ -1629,6 +1629,7 @@ init_vbt_missing_defaults(struct drm_i915_private *dev_priv)
>  		info->supports_dvi = (port != PORT_A && port != PORT_E);
>  		info->supports_hdmi = info->supports_dvi;
>  		info->supports_dp = (port != PORT_E);
> +		info->supports_edp = (port == PORT_A);
>  	}
>  }

-- 
Jani Nikula, Intel Open Source Graphics Center
