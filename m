Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2E3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F3321871
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AYyBhiQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfCOKvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:51:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33293 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbfCOKvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:51:02 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so557040edg.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 03:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RlLVX44gwXn7in5y8DN8YgrrFZZpsKDznLZnujeWWx4=;
        b=AYyBhiQhaFX8huoBDXwLtJZWEt60x72L8s0FgP84DH75gODKJWNt8g9RHel+i5E5WL
         B2hHYFn1eBG/7GUZnJwj44izAFNJHDG1lO2AcUWA4FluU35K5lJVPk0ED0Qeq5oXBStP
         7rHB4u5K0IqQynPBtlwUsJ+FUABCr5A3JiTo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=RlLVX44gwXn7in5y8DN8YgrrFZZpsKDznLZnujeWWx4=;
        b=m5CEjy/3Zt2jY9fJvwoJiQHi4HdH8waGwzINpbJS21IMXsyCY27azlA3KIsReOvHVu
         yw9pBsmohrYdOsyM6EYXRdPfSJD34a48AEu9aL1qLlgOsJhmG52/aTrAHhtZX71aG4Lk
         hAg2g1EFU10Ld8GF1RcVxjDGyI6BP2jv+UVLo1Q4SOS2FyGiTSoNDBZYSa04UjJ/Nx1B
         5DT4eHOShnaKqHaTY2vIsMOn1XIGMV712FxN6dXFzPAMzj0lB2L72OYqh8s/jPJZlIVP
         P3Yl/Z5yRObgHY8swycnWH7UA8njl/e3biHIdoH8cCm+KEFSZ3LYyw2BGc5C9UGa0yaV
         X1Qw==
X-Gm-Message-State: APjAAAXyNDlIEGnK1oON+eQJAefJs+Z5J+AhOC2vq7Ucry38vS0Zw21d
        Gsflw94/oLKcUUOF9zRHAcjFYw==
X-Google-Smtp-Source: APXvYqy/IF21L4v9D0A3uQD6kP0rhaf4p0+SwFK6y+ReX/7st2c3gYgZ9kY7OBPFhhFSdUpgJUQ8vw==
X-Received: by 2002:a05:6402:2c9:: with SMTP id b9mr2396543edx.8.1552647060601;
        Fri, 15 Mar 2019 03:51:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d3sm521874edv.76.2019.03.15.03.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 03:50:59 -0700 (PDT)
Date:   Fri, 15 Mar 2019 11:50:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch 1/1] drm/atomic: integrate private objects with
 suspend/resume helpers
Message-ID: <20190315105057.GU2665@phenom.ffwll.local>
Mail-Followup-To: Benoit Parrot <bparrot@ti.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>
References: <20190314134445.19260-1-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314134445.19260-1-bparrot@ti.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
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

Why do you need this? We're doing a full atomic_check, and your
atomic_check should be pulling in any private state objects and
recomputing their states. This smells like papering over a driver bug.

The duplicate helpers should only need to duplicate the uapi-relevant
states, i.e. connector/crtc/planes.
-Daniel

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
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
