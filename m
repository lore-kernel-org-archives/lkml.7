Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CF3C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D95A4208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfF1MNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:13:22 -0400
Received: from mga04.intel.com ([192.55.52.120]:32923 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbfF1MNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:13:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 05:13:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,427,1557212400"; 
   d="scan'208";a="189422313"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga002.fm.intel.com with SMTP; 28 Jun 2019 05:13:15 -0700
Received: by stinkbox (sSMTP sendmail emulation); Fri, 28 Jun 2019 15:13:15 +0300
Date:   Fri, 28 Jun 2019 15:13:15 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Robert Beckett <bob.beckett@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v4 2/2] Revert "drm/vblank: Do not update vblank count if
 interrupts are already disabled."
Message-ID: <20190628121315.GH5942@intel.com>
References: <cover.1561722822.git.bob.beckett@collabora.com>
 <fc4a6e587e4570227f67a82f2d0e9520934e717e.1561722822.git.bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc4a6e587e4570227f67a82f2d0e9520934e717e.1561722822.git.bob.beckett@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 01:05:32PM +0100, Robert Beckett wrote:
> If interrupts are already disabled, then the timestamp for the vblank
> does not get updated, causing a stale timestamp to be reported to
> userland while disabling crtcs.
> 
> This reverts commit 68036b08b91bc491ccc308f902616a570a49227c.

Please cc the people involved in that. And I'd drop the lkml cc.

> 
> Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> ---
>  drivers/gpu/drm/drm_vblank.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
> index 7dabb2bdb733..aeb9734d7799 100644
> --- a/drivers/gpu/drm/drm_vblank.c
> +++ b/drivers/gpu/drm/drm_vblank.c
> @@ -371,25 +371,23 @@ void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe)
>  	spin_lock_irqsave(&dev->vblank_time_lock, irqflags);
>  
>  	/*
> -	 * Update vblank count and disable vblank interrupts only if the
> -	 * interrupts were enabled. This avoids calling the ->disable_vblank()
> -	 * operation in atomic context with the hardware potentially runtime
> -	 * suspended.
> +	 * Only disable vblank interrupts if they're enabled. This avoids
> +	 * calling the ->disable_vblank() operation in atomic context with the
> +	 * hardware potentially runtime suspended.
>  	 */
> -	if (!vblank->enabled)
> -		goto out;
> +	if (vblank->enabled) {
> +		__disable_vblank(dev, pipe);
> +		vblank->enabled = false;
> +	}
>  
>  	/*
> -	 * Update the count and timestamp to maintain the
> +	 * Always update the count and timestamp to maintain the
>  	 * appearance that the counter has been ticking all along until
>  	 * this time. This makes the count account for the entire time
>  	 * between drm_crtc_vblank_on() and drm_crtc_vblank_off().
>  	 */
>  	drm_update_vblank_count(dev, pipe, false);
> -	__disable_vblank(dev, pipe);
> -	vblank->enabled = false;
>  
> -out:
>  	spin_unlock_irqrestore(&dev->vblank_time_lock, irqflags);
>  }
>  
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
