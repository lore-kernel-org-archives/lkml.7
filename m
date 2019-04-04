Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46251C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B5D20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:19:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Dwgt1Msw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfDDKTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:19:45 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49226 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbfDDKTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:19:45 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 65A3954B;
        Thu,  4 Apr 2019 12:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554373182;
        bh=IUDDASb58KdMz/fM/X5Q4M0oKymjbTQhEJl4K5mlLFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dwgt1MswSQtPfY7rq+jQvlWQH0NvGRokifFJe085M3qGJTaNtxYFsKB/GOsx0D8ZX
         u8KBj7zCOgNsomTTwe/PMgcAHr+aMINuB49HfEpnhZM9D7HbUS5DRoltiZGr6kX8If
         QbdiMNzB/bmrtNEyPKPXT51ie7dRU/Go/uNFSlQU=
Date:   Thu, 4 Apr 2019 13:19:23 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     VenkataRajesh.Kalakodima@in.bosch.com
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
Subject: Re: [PATCH 7/8] drm: rcar-du: update gamma and ctm properties in
 commit tail
Message-ID: <20190404101923.GG5800@pendragon.ideasonboard.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
 <1554297284-14009-8-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554297284-14009-8-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalakodima,

Thank you for the patch.

On Wed, Apr 03, 2019 at 06:44:43PM +0530, VenkataRajesh.Kalakodima@in.bosch.com wrote:
> From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> 
> Update gamma and ctm properties if there is a change.
> 
> Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
> 
>    - Fix compilation issues when for_each_crtc_in_state is not defined
>    - Resolved checkpatch errors
>    - Resolved merge conflicts according to latest version
> 
> Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_kms.c | 25 +++++++++++++++++++++++++
>  include/drm/drm_atomic.h              | 25 +++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.c b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> index f0bc7cc..4d9a19c 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.c
> @@ -246,6 +246,10 @@ static int rcar_du_atomic_check(struct drm_device *dev,
>  static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
>  {
>  	struct drm_device *dev = old_state->dev;
> +	struct drm_crtc *crtc;
> +	struct drm_crtc_state *crtc_state;
> +	struct rcar_du_crtc *rcrtc;
> +	int i;
>  
>  	/* Apply the atomic update. */
>  	drm_atomic_helper_commit_modeset_disables(dev, old_state);
> @@ -253,6 +257,27 @@ static void rcar_du_atomic_commit_tail(struct drm_atomic_state *old_state)
>  					DRM_PLANE_COMMIT_ACTIVE_ONLY);
>  	drm_atomic_helper_commit_modeset_enables(dev, old_state);
>  
> +	/* Update gamma and ctm properties for all crtc in present
> +	 * state. Update is done only if there is a change
> +	 */
> +	for_each_crtc_in_state(old_state, crtc, crtc_state, i) {
> +		rcrtc = to_rcar_crtc(crtc);
> +
> +		if (rcrtc->lut_handle) {
> +			rcar_du_cmm_update_lut_and_free
> +			  (rcrtc->lut_handle,
> +			   (struct drm_color_lut *)crtc->state->gamma_lut->data,
> +			   (crtc->state->gamma_lut->length /
> +			   sizeof(struct drm_color_lut)));
> +			rcrtc->lut_handle = NULL;
> +		}
> +		if (rcrtc->clu_handle) {
> +			rcar_du_cmm_update_clu_and_free
> +			  (rcrtc->clu_handle,
> +			   (struct drm_color_ctm *)crtc->state->ctm->data);
> +			rcrtc->clu_handle = NULL;
> +		}
> +	}
>  	drm_atomic_helper_commit_hw_done(old_state);
>  	drm_atomic_helper_wait_for_flip_done(dev, old_state);

We're in the process of reworking the commit tail handler, so I expect
major changes will be needed here.

>  
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 1e71315..d22ccd8 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -693,6 +693,31 @@ void drm_state_dump(struct drm_device *dev, struct drm_printer *p);
>  			     (new_connector_state) = (__state)->connectors[__i].new_state, 1))
>  
>  /**
> + * for_each_crtc_in_state - iterate over all connectors in an atomic update
> + * @__state: &struct drm_atomic_state pointer
> + * @crtc: &struct drm_crtc iteration cursor
> + * @crtc_state: &struct drm_crtc_state iteration cursor
> + * @__i: int iteration cursor, for macro-internal use
> + *
> + * This iterates over all CRTCs in an atomic update. Note that before the
> + * software state is committed (by calling drm_atomic_helper_swap_state(), this
> + * points to the new state, while afterwards it points to the old state. Due to
> + * this tricky confusion this macro is deprecated.
> + *
> + * FIXME:
> + *
> + * Replace all usage of this with one of the explicit iterators below and then
> + * remove this macro.

Then don't add it :-) In general you should look at the code you want to
upstream, this feels like it was a blind copy from a BSP without giving
it much consideration.

> + */
> +#define for_each_crtc_in_state(__state, crtc, crtc_state, __i)	\
> +	for ((__i) = 0;						\
> +	     ((__i) < ((__state)->dev->mode_config.num_crtc)) &&	\
> +	     ((crtc) = ((__state)->crtcs[__i].ptr),			\
> +	     (crtc_state) = ((__state)->crtcs[__i].state), 1);	\
> +	     (__i)++)						\
> +		for_each_if(crtc_state)
> +
> +/**
>   * for_each_oldnew_crtc_in_state - iterate over all CRTCs in an atomic update
>   * @__state: &struct drm_atomic_state pointer
>   * @crtc: &struct drm_crtc iteration cursor

-- 
Regards,

Laurent Pinchart
