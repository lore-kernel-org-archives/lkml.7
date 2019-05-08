Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A904C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6619216C4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 16:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Ri7VOMAb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfEHQde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 12:33:34 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38160 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfEHQdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 12:33:33 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so22663507edl.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZcsMiLErKaFVa4DPIlZBROc/Wds0ecbUxqe0YDds6g8=;
        b=Ri7VOMAbcFRETs5rGEuiiLrWpZr3CbXRfFtdy/PJHMThA+QrxS/zV5fVLToaJDA6hn
         8eX166Fk/huwRPsPN9yiWFpWFBVjJSOnJnHqrukYX752ET7xTtuHMq4lqc8Zw5ijMcY8
         lXLHCYnC+ndvBgpy0hq4WUZEIA54L+owc2UUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ZcsMiLErKaFVa4DPIlZBROc/Wds0ecbUxqe0YDds6g8=;
        b=hDGDWtB2tvkfcPEr4ehBeEGrMvoWGmKEfeeyXuAUIIq3/czbVM1cUl+uvUbv36I6Ra
         lwOdyHraJBoR+/YfuTRUU8mT4lr1RO2l+sxaBVxQlXQQzEJV+T6uv5+7+D3dD8UydSN/
         9Ytc7jMoq69bGSMjNUNT2GhwJiup8ptByePQn06aTh7ukI97qSk9f6OVjUrCb8l3T3V3
         7DP9ZywTwRdySTVq2XUnXOUfaMcJ182YQBr7pExhxNfWqV0/t5hXkAU0GPxSjn3v3Pb5
         ZNpOzg7l6ovgRshel/5cRWAnTJmuTV674Fx8OAweIo/e3cXi1Kghui1fDfinwJlGFYVP
         dpXg==
X-Gm-Message-State: APjAAAXxrV6jRFbdfzUd3sdpBhScW3HWt69Vg9TLHfoHAxxr+xgAfhd3
        N51ncTXHs9u6AAqLEl+8yJebQA==
X-Google-Smtp-Source: APXvYqzInFyxKdOVxAKBeuqv0AqML3lDquvEq1Sqlsip3vAyBuCJ4K9iW94Wf+0c0l5MhxdsVgnY+w==
X-Received: by 2002:a50:b835:: with SMTP id j50mr40247358ede.63.1557333211517;
        Wed, 08 May 2019 09:33:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id h17sm2792222ejc.34.2019.05.08.09.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 09:33:30 -0700 (PDT)
Date:   Wed, 8 May 2019 18:33:27 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/11] drm: Add
 drm_atomic_get_(old|new-_connector_for_encoder() helpers
Message-ID: <20190508163327.GZ17751@phenom.ffwll.local>
Mail-Followup-To: Sean Paul <sean@poorly.run>,
        dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
References: <20190508160920.144739-1-sean@poorly.run>
 <20190508160920.144739-3-sean@poorly.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190508160920.144739-3-sean@poorly.run>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 12:09:07PM -0400, Sean Paul wrote:
> From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Add functions to the atomic core to retrieve the old and new connectors
> associated with an encoder in a drm_atomic_state. This is useful for
> encoders and bridges that need to access the connector, for instance for
> the drm_display_info.
> 
> The CRTC associated with the encoder can also be retrieved through the
> connector state, and from it, the old and new CRTC states.
> 
> Changed in v4:
> - Added to the set
> 
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> [seanpaul removed WARNs from helpers and added docs to explain why
> returning NULL might be valid]
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---
>  drivers/gpu/drm/drm_atomic.c | 70 ++++++++++++++++++++++++++++++++++++
>  include/drm/drm_atomic.h     |  7 ++++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index 5eb40130fafb..936002495523 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -797,6 +797,76 @@ drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
>  }
>  EXPORT_SYMBOL(drm_atomic_get_private_obj_state);
>  
> +/**
> + * drm_atomic_get_old_connector_for_encoder - Get old connector for an encoder
> + * @state: Atomic state
> + * @encoder: The encoder to fetch the connector state for
> + *
> + * This function finds and returns the connector that was connected to @encoder
> + * as specified by the @state.
> + *
> + * If there is no connector in @state which previously had @encoder connected to
> + * it, this function will return NULL. While this may seem like an invalid use
> + * case, it is sometimes a useful to differentiate commits which had no prior
> + * connectors attached to @encoder vs ones that did (and to inspect their
> + * @state). This is especially true in enable hooks because the pipeline has
> + * changed/will change.

s/has changed// ... I meant you'll pick the right ver tense :-)

> + *
> + * Returns: The old connector connected to @encoder, or NULL if the encoder is
> + * not connected.
> + */
> +struct drm_connector *
> +drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
> +					 struct drm_encoder *encoder)
> +{
> +	struct drm_connector_state *conn_state;
> +	struct drm_connector *connector;
> +	unsigned int i;
> +
> +	for_each_old_connector_in_state(state, connector, conn_state, i) {
> +		if (conn_state->best_encoder == encoder)
> +			return connector;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(drm_atomic_get_old_connector_for_encoder);
> +
> +/**
> + * drm_atomic_get_new_connector_for_encoder - Get new connector for an encoder
> + * @state: Atomic state
> + * @encoder: The encoder to fetch the connector state for
> + *
> + * This function finds and returns the connector that will be connected to
> + * @encoder as specified by the @state.
> + *
> + * If there is no connector in @state which will have @encoder connected to it,
> + * this function will return NULL. While this may seem like an invalid use case,
> + * it is sometimes a useful to differentiate commits which have no connectors
> + * attached to @encoder vs ones that do (and to inspect their state). This is
> + * especially true in disable hooks because the pipeline has changed/will
> + * change.

s/will change//

> + *
> + * Returns: The new connector connected to @encoder, or NULL if the encoder is
> + * not connected.
> + */
> +struct drm_connector *
> +drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
> +					 struct drm_encoder *encoder)
> +{
> +	struct drm_connector_state *conn_state;
> +	struct drm_connector *connector;
> +	unsigned int i;
> +
> +	for_each_new_connector_in_state(state, connector, conn_state, i) {
> +		if (conn_state->best_encoder == encoder)
> +			return connector;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(drm_atomic_get_new_connector_for_encoder);

Maybe also add a "See also drm_atomic_get_old_connector_for_encoder() and
drm_atomic_get_new_connector_for_encoder()." to the kerneldoc of
drm_connector_state.best_encoder.

With these doc nits:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +
>  /**
>   * drm_atomic_get_connector_state - get connector state
>   * @state: global atomic state object
> diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
> index 824a5ed4e216..d6b3acd34e1c 100644
> --- a/include/drm/drm_atomic.h
> +++ b/include/drm/drm_atomic.h
> @@ -453,6 +453,13 @@ struct drm_private_state * __must_check
>  drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
>  				 struct drm_private_obj *obj);
>  
> +struct drm_connector *
> +drm_atomic_get_old_connector_for_encoder(struct drm_atomic_state *state,
> +					 struct drm_encoder *encoder);
> +struct drm_connector *
> +drm_atomic_get_new_connector_for_encoder(struct drm_atomic_state *state,
> +					 struct drm_encoder *encoder);
> +
>  /**
>   * drm_atomic_get_existing_crtc_state - get crtc state, if it exists
>   * @state: global atomic state object
> -- 
> Sean Paul, Software Engineer, Google / Chromium OS
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
