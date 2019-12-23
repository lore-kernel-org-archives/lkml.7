Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6C1C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52486206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 10:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLWKLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 05:11:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:43940 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfLWKLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 05:11:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 02:11:21 -0800
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="211511893"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 02:11:18 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     ville.syrjala@linux.intel.com, swati2.sharma@intel.com,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] drm/i915: Re-init lspcon after HPD if lspcon probe failed
In-Reply-To: <20191223095604.17453-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191223095604.17453-1-kai.heng.feng@canonical.com>
Date:   Mon, 23 Dec 2019 12:11:15 +0200
Message-ID: <87eewvwdvg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Dec 2019, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> On HP 800 G4 DM, if HDMI cable isn't plugged before boot, the HDMI port
> becomes useless and never responds to cable hotplugging:
> [    3.031904] [drm:lspcon_init [i915]] *ERROR* Failed to probe lspcon
> [    3.031945] [drm:intel_ddi_init [i915]] *ERROR* LSPCON init failed on port D
>
> Seems like the lspcon chip on the system in question only gets powered
> after the cable is plugged.
>
> So let's call lspcon_init() dynamically to properly initialize the
> lspcon chip and make HDMI port work.
>
> Closes: https://gitlab.freedesktop.org/drm/intel/issues/203
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/i915/display/intel_hotplug.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_hotplug.c b/drivers/gpu/drm/i915/display/intel_hotplug.c
> index fc29046d48ea..e2862e36d0bf 100644
> --- a/drivers/gpu/drm/i915/display/intel_hotplug.c
> +++ b/drivers/gpu/drm/i915/display/intel_hotplug.c
> @@ -28,6 +28,7 @@
>  #include "i915_drv.h"
>  #include "intel_display_types.h"
>  #include "intel_hotplug.h"
> +#include "intel_lspcon.h"
>  
>  /**
>   * DOC: Hotplug
> @@ -336,6 +337,8 @@ static void i915_digport_work_func(struct work_struct *work)
>  			continue;
>  
>  		dig_port = enc_to_dig_port(&encoder->base);
> +		if (HAS_LSPCON(dev_priv) && !dig_port->lspcon.active)
> +			lspcon_init(dig_port);

The whole digport work function is platform and encoder agnostic, this
call has no place in here.

One alternative is intel_dp_hpd_pulse().


BR,
Jani.


>  
>  		ret = dig_port->hpd_pulse(dig_port, long_hpd);
>  		if (ret == IRQ_NONE) {

-- 
Jani Nikula, Intel Open Source Graphics Center
