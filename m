Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B67C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E9D2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfCNPbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:31:35 -0400
Received: from mga18.intel.com ([134.134.136.126]:20352 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbfCNPbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:31:34 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Mar 2019 08:31:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,478,1544515200"; 
   d="scan'208";a="155037962"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga001.fm.intel.com with SMTP; 14 Mar 2019 08:31:29 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 14 Mar 2019 17:31:29 +0200
Date:   Thu, 14 Mar 2019 17:31:29 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jyri Sarha <jsarha@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [Patch 1/1] drm/atomic: integrate private objects with
 suspend/resume helpers
Message-ID: <20190314153129.GS3888@intel.com>
References: <20190314134445.19260-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190314134445.19260-1-bparrot@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Random order between crtc vs. plane vs. connector vs. priv is tickling
my ocd nerve a bit.

Otherwise looks sensible to me.
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
