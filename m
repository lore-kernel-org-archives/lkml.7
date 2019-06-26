Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841A4C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A872147A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 13:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfFZN1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 09:27:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:59673 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZN1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 09:27:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 06:27:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="170066599"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by FMSMGA003.fm.intel.com with SMTP; 26 Jun 2019 06:27:33 -0700
Received: by stinkbox (sSMTP sendmail emulation); Wed, 26 Jun 2019 16:27:32 +0300
Date:   Wed, 26 Jun 2019 16:27:32 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Robert Beckett <bob.beckett@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Paul <sean@poorly.run>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/4] drm/vblank: estimate vblank while disabling
 vblank if interrupt disabled
Message-ID: <20190626132732.GP5942@intel.com>
References: <cover.1561483965.git.bob.beckett@collabora.com>
 <b96132cef4b63118df1026a99b3c345692e3de26.1561483965.git.bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b96132cef4b63118df1026a99b3c345692e3de26.1561483965.git.bob.beckett@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 06:59:14PM +0100, Robert Beckett wrote:
> If interrupts are disabled (e.g. via vblank_disable_fn) and we come to
> disable vblank, update the vblank count to best guess as to what it
> would be had the interrupts remained enabled, and update the timesamp to
> now.
> 
> This avoids a stale vblank event being sent while disabling crtcs during
> atomic modeset.
> 
> Fixes: 68036b08b91bc ("drm/vblank: Do not update vblank count if interrupts
> are already disabled.")

I don't understand that commit. drm_vblank_off() should be called
when the power is still present, so it looks to me like that
commit is actually wrong. So I think we may want to just revert
it and figure out what the actual bug was.

> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 7dabb2bdb733..db68b8cbf797 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -375,9 +375,23 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe)
>  	 * interrupts were enabled. This avoids calling the ->disable_vblank()
>  	 * operation in atomic context with the hardware potentially runtime
>  	 * suspended.
> +	 * If interrupts are disabled (e.g. via blank_disable_fn) then make
> +	 * best guess as to what it would be now and make sure we have an up
> +	 * to date timestamp.
>  	 */
> -	if (!vblank->enabled)
> +	if (!vblank->enabled) {
> +		ktime_t now = ktime_get();
> +		u32 diff = 0;
> +		if (vblank->framedur_ns) {
> +			u64 diff_ns = ktime_to_ns(ktime_sub(now, vblank->time));
> +			diff = DIV_ROUND_CLOSEST_ULL(diff_ns,
> +						     vblank->framedur_ns);
> +		}
> +
> +		store_vblank(dev, pipe, diff, now, vblank->count);
> +
>  		goto out;
> +	}
>  
>  	/*
>  	 * Update the count and timestamp to maintain the
> -- 
> 2.18.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
