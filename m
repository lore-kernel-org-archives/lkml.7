Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B8EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0441220693
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:19:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Px31lZWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCNSTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:19:18 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54074 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfCNSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:19:18 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 541AF22;
        Thu, 14 Mar 2019 19:19:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1552587555;
        bh=ALkOQOssFINVAOq+EHckrzoP4CN0MQMzGZUb89sVNrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Px31lZWX0feJtULxBzZlgKqSciRhE5k7+prJFCNOhQG7Jo8m4JOkVnpa0N9odvqnc
         zWmM4f+XZLfl3rNZBqQqEvoKIdzAfyNKaLizHngidJMasCN/0L2m2PoWiL2eQqB/8L
         5occlGR65W8lYid47hfKcJ4LaXwgEVXyUmi5Hx2Y=
Date:   Thu, 14 Mar 2019 20:19:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch 1/1] drm/atomic: integrate private objects with
 suspend/resume helpers
Message-ID: <20190314181907.GH5455@pendragon.ideasonboard.com>
References: <20190314134445.19260-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190314134445.19260-1-bparrot@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benoit,

Thank you for the patch.

On Thu, Mar 14, 2019 at 08:44:45AM -0500, Benoit Parrot wrote:
> During a suspend cycle the atomic state is saved to be used during the
> restore cycle.
> 
> However the current state duplication logic does not duplicate private
> objects. This leads to state inconsistencies at resume time.
> 
> With private objects modeset lock now integrated, we can make sure that
> private object state are properly saved and restored.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>

This looks good to me. I was actually wondering if private object state
was properly handled by the suspend/resume helpers no later than
yesterday. Seems you read my mind :-)

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 540a77a2ade9..b108021cc092 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3189,6 +3189,7 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>  	struct drm_connector_list_iter conn_iter;
>  	struct drm_plane *plane;
>  	struct drm_crtc *crtc;
> +	struct drm_private_obj *privobj;
>  	int err = 0;
>  
>  	state = drm_atomic_state_alloc(dev);
> @@ -3218,6 +3219,16 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>  		}
>  	}
>  
> +	drm_for_each_privobj(privobj, dev) {
> +		struct drm_private_state *priv_state;
> +
> +		priv_state = drm_atomic_get_private_obj_state(state, privobj);
> +		if (IS_ERR(priv_state)) {
> +			err = PTR_ERR(priv_state);
> +			goto free;
> +		}
> +	}
> +
>  	drm_connector_list_iter_begin(dev, &conn_iter);
>  	drm_for_each_connector_iter(conn, &conn_iter) {
>  		struct drm_connector_state *conn_state;
> @@ -3325,12 +3336,17 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
>  	struct drm_connector_state *new_conn_state;
>  	struct drm_crtc *crtc;
>  	struct drm_crtc_state *new_crtc_state;
> +	struct drm_private_obj *privobj;
> +	struct drm_private_state *new_priv_state;
>  
>  	state->acquire_ctx = ctx;
>  
>  	for_each_new_plane_in_state(state, plane, new_plane_state, i)
>  		state->planes[i].old_state = plane->state;
>  
> +	for_each_new_private_obj_in_state(state, privobj, new_priv_state, i)
> +		state->private_objs[i].old_state = privobj->state;
> +
>  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
>  		state->crtcs[i].old_state = crtc->state;
>  

-- 
Regards,

Laurent Pinchart
