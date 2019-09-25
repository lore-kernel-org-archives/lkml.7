Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA5C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C0821D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="dqP9Wlgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439945AbfIYTBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:01:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33816 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbfIYTBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:01:00 -0400
Received: by mail-yb1-f196.google.com with SMTP id p11so1453787ybc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f/jxq31Chxv3B7qohD7ZMPi0ff06Ouw1g9e6KDnszS4=;
        b=dqP9WlggW+YzUAoVttZW7SbwyfyXhXuvQ/pcf4gDYZUkEDO9fc6yg8+WBDvn/WnSvW
         35Nl8J+tlxvpTC/4O/q1YIn9TF/ZNJnSahvy7o+Iy6/OyrA41FQY4bu55o2OP6B62XcP
         9qmn70iZALGTGQ5d3m73y9qacyWfO5Oo1z6WNbnM+hH991JewFPFaKUFJ58DICRMmN8w
         ec+EXWP+WSEMn8g6a6qx+dB+mIms/bAsrPwDZNw2RIYWKmx1Ow8WVdejtzIS0KbABryg
         cHRJOTuOtfeM3M/aH521kcbThOT79EFrlzuuv7i15fuwr4B1JoJknvepLeApFe3477NB
         DqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f/jxq31Chxv3B7qohD7ZMPi0ff06Ouw1g9e6KDnszS4=;
        b=CRxbmeQQoP7EgE7m+zbzRsvQFJv42Ewmbl3HMBkfeGdshz9MX+I8bSPXHXBJZ/CmjL
         6FVIUoFzYVIHINW7hYg07PiniFGLzejhPd7dNRapISoHe7i4Z/Q/ktJwLWw9gWd1sPTM
         bVMVkHLdUooOEhvCDFXpccAPZwABwgvpVrAHKsdMo+e5xI9OG9R35N7yk9i6q9bqrlBV
         BR2dzkkNIw+EsRszRlZ7Y7LDUuzxJxmkgGqLKMFwIvXT1Ql5+Na7spccHA4qXQW0UccH
         9Tf5jiJAwVM+I6LiueyC/JXdudPz0FPEzh99VfC0nWmz/rjW+RrNBUUzk/wjyFOtHMWg
         ONFQ==
X-Gm-Message-State: APjAAAUVEG7eYLBqLUHRxMUdbwOyLGXKmH66PWiX/8Tk/CR3FK0MrR6P
        BwThGfhnYC/wOzIGmQc8qMpA1w==
X-Google-Smtp-Source: APXvYqzfKz4T8IkinJTWtRrtM1fBKmKHmnrN8NDTD4zU/RM5ipGhD03BlIVvS2tvJfGBLi13R2mjng==
X-Received: by 2002:a25:f509:: with SMTP id a9mr4048605ybe.85.1569438059472;
        Wed, 25 Sep 2019 12:00:59 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id i14sm1346933ywe.107.2019.09.25.12.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 12:00:58 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:00:58 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/27] drm/dp_mst: Remove PDT teardown in
 drm_dp_destroy_port() and refactor
Message-ID: <20190925190058.GF218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-9-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-9-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:46PM -0400, Lyude Paul wrote:
> This will allow us to add some locking for port->* members, in
> particular the PDT and ->connector, which can't be done from
> drm_dp_destroy_port() since we don't know what locks the caller might be
> holding.

Might be nice to mention that this is already done in the delayed destroy worker
so readers don't need to go looking for it. Perhaps update this when you apply
the patch.

> 
> Changes since v2:
> * Clarify commit message
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 40 +++++++++++----------------
>  1 file changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index f5f1d8b50fb6..af3189df28aa 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1511,31 +1511,22 @@ static void drm_dp_destroy_port(struct kref *kref)
>  		container_of(kref, struct drm_dp_mst_port, topology_kref);
>  	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
>  
> -	if (!port->input) {
> -		kfree(port->cached_edid);
> +	/* There's nothing that needs locking to destroy an input port yet */
> +	if (port->input) {
> +		drm_dp_mst_put_port_malloc(port);
> +		return;
> +	}
>  
> -		/*
> -		 * The only time we don't have a connector
> -		 * on an output port is if the connector init
> -		 * fails.
> -		 */
> -		if (port->connector) {
> -			/* we can't destroy the connector here, as
> -			 * we might be holding the mode_config.mutex
> -			 * from an EDID retrieval */
> +	kfree(port->cached_edid);
>  
> -			mutex_lock(&mgr->delayed_destroy_lock);
> -			list_add(&port->next, &mgr->destroy_port_list);
> -			mutex_unlock(&mgr->delayed_destroy_lock);
> -			schedule_work(&mgr->delayed_destroy_work);
> -			return;
> -		}
> -		/* no need to clean up vcpi
> -		 * as if we have no connector we never setup a vcpi */
> -		drm_dp_port_teardown_pdt(port, port->pdt);
> -		port->pdt = DP_PEER_DEVICE_NONE;
> -	}
> -	drm_dp_mst_put_port_malloc(port);
> +	/*
> +	 * we can't destroy the connector here, as we might be holding the
> +	 * mode_config.mutex from an EDID retrieval
> +	 */
> +	mutex_lock(&mgr->delayed_destroy_lock);
> +	list_add(&port->next, &mgr->destroy_port_list);
> +	mutex_unlock(&mgr->delayed_destroy_lock);
> +	schedule_work(&mgr->delayed_destroy_work);
>  }
>  
>  /**
> @@ -3998,7 +3989,8 @@ static void drm_dp_tx_work(struct work_struct *work)
>  static inline void
>  drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
>  {
> -	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> +	if (port->connector)
> +		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
>  
>  	drm_dp_port_teardown_pdt(port, port->pdt);
>  	port->pdt = DP_PEER_DEVICE_NONE;
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
