Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE8FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332FB21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="CV/RkG/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392759AbfIYUDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:03:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33515 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732748AbfIYUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:03:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id i188so2543069ywf.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gNDpa6gJwz6+/gmM6XlycDMJYVpDkuYsHcCA8nLLghc=;
        b=CV/RkG/QeEmc3lrACMXzreW1kQ6ZJRF4DFyXRg3rVVgLM+z4am0pntR1KHPZ5jzydb
         aAiGL8cGzFhH1Yl8/VDOsKZlTfa6ftGn4Jfe02REa+Sn9OItqCN+cysicscRDFYMFoMt
         OuIaEn2YB8oZ+QpecF7z6IqWNkBAZVkXS7cxjIvOT9ouygI+qsePFqWHH0ijo0WGB7tU
         GWnH+JBY0YN2/3CZ//Qwd9jmN/OC+GQ8hrE2SfaVxmmcHn3VtcT9z90m+Ux2g1obw1RZ
         I4sPuhpasfsf49XVoIFEZ8Bty6CBvfTasQvEoqSwpZ+w+wTvPFmjLVEINe/y/eF/A5ip
         GPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gNDpa6gJwz6+/gmM6XlycDMJYVpDkuYsHcCA8nLLghc=;
        b=Y3KUr08qIYpiOMWPDBPqQtWkBviidw2MHrg4n1klNbEKNhtRJvrJGR4qcl58042Fvy
         WWjognp8igur+gZXxTjmnDYJdyUhkv15r3eWuBjY74j6v7P/o7SE2hX6/zIco15QceOw
         4e8mRSeDpTnoIrhCYLmvbQVKg+J3w3IZ/KsCYFZPDmDHjuuMi6ft88SjFf4I6uHku0p6
         NyWB1Ms/CHCAfzxiRELiGsejO9sNq6/qW4+xCyCFqF3CkR5d9UmEKIqO/FU851kxuaKQ
         RnheqG9e261v4Nks4F8QpTPLAX812XtAK4zDodrzgWIb2/iHn+LcI2pq5eulOtE7BCaj
         t+Pg==
X-Gm-Message-State: APjAAAX/HSnxU7jwBuycXY8VDlyR4BcS3nlwDf5Iaji3TmDiatKZmorf
        bxuBPAtClcydcGxs9Tmr7/gtMw==
X-Google-Smtp-Source: APXvYqybjE98I3XzxOFxhiamePgEVdQzYmAtObwGqV9JghEh9eyMk6WahEMb49DGzRgcWOd/SB1yfQ==
X-Received: by 2002:a0d:f7c3:: with SMTP id h186mr7205518ywf.274.1569441808731;
        Wed, 25 Sep 2019 13:03:28 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id w123sm1525538yww.22.2019.09.25.13.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 13:03:28 -0700 (PDT)
Date:   Wed, 25 Sep 2019 16:03:27 -0400
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
Subject: Re: [PATCH v2 21/27] drm/dp_mst: Don't forget to update port->input
 in drm_dp_mst_handle_conn_stat()
Message-ID: <20190925200327.GM218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-22-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-22-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:59PM -0400, Lyude Paul wrote:
> This probably hasn't caused any problems up until now since it's
> probably nearly impossible to encounter this in the wild, however if we
> were to receive a connection status notification from the MST hub after
> resume while we're in the middle of reprobing the link addresses for a
> topology then there's a much larger chance that a port could have
> changed from being an output port to input port (or vice versa). If we
> forget to update this bit of information, we'll potentially ignore a
> valid PDT change on a downstream port because we think it's an input
> port.
> 
> So, make sure we read the input_port field in connection status
> notifications in drm_dp_mst_handle_conn_stat() to prevent this from
> happening once we've implemented suspend/resume reprobing.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Nice catch! Same comment here re: port->mutex, but we can sort that out on the
other thread

Reviewed-by: Sean Paul <sean@poorly.run>


> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 51 +++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 259634c5d6dc..e407aba1fbd2 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2078,18 +2078,23 @@ static void
>  drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
>  			    struct drm_dp_connection_status_notify *conn_stat)
>  {
> -	struct drm_device *dev = mstb->mgr->dev;
> +	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> +	struct drm_device *dev = mgr->dev;
>  	struct drm_dp_mst_port *port;
> -	int old_ddps;
> -	bool dowork = false;
> +	struct drm_connector *connector_to_destroy = NULL;
> +	int old_ddps, ret;
> +	u8 new_pdt;
> +	bool dowork = false, create_connector = false;
>  
>  	port = drm_dp_get_port(mstb, conn_stat->port_number);
>  	if (!port)
>  		return;
>  
> +	mutex_lock(&port->lock);
>  	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
>  
>  	old_ddps = port->ddps;
> +	port->input = conn_stat->input_port;
>  	port->mcs = conn_stat->message_capability_status;
>  	port->ldps = conn_stat->legacy_device_plug_status;
>  	port->ddps = conn_stat->displayport_device_plug_status;
> @@ -2102,23 +2107,41 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
>  		}
>  	}
>  
> -	if (!port->input) {
> -		int ret = drm_dp_port_set_pdt(port,
> -					      conn_stat->peer_device_type);
> -		if (ret == 1) {
> -			dowork = true;
> -		} else if (ret < 0) {
> -			DRM_ERROR("Failed to change PDT for port %p: %d\n",
> -				  port, ret);
> -			dowork = false;
> -		}
> +	new_pdt = port->input ? DP_PEER_DEVICE_NONE : conn_stat->peer_device_type;
> +
> +	ret = drm_dp_port_set_pdt(port, new_pdt);
> +	if (ret == 1) {
> +		dowork = true;
> +	} else if (ret < 0) {
> +		DRM_ERROR("Failed to change PDT for port %p: %d\n",
> +			  port, ret);
> +		dowork = false;
> +	}
> +
> +	/*
> +	 * We unset port->connector before dropping connection_mutex so that
> +	 * there's no chance any of the atomic MST helpers can accidentally
> +	 * associate a to-be-destroyed connector with a port.
> +	 */
> +	if (port->connector && port->input) {
> +		connector_to_destroy = port->connector;
> +		port->connector = NULL;
> +	} else if (!port->connector && !port->input) {
> +		create_connector = true;
>  	}
>  
>  	drm_modeset_unlock(&dev->mode_config.connection_mutex);
> +
> +	if (connector_to_destroy)
> +		mgr->cbs->destroy_connector(mgr, connector_to_destroy);
> +	else if (create_connector)
> +		drm_dp_mst_port_add_connector(mstb, port);
> +
> +	mutex_unlock(&port->lock);
> +
>  	drm_dp_mst_topology_put_port(port);
>  	if (dowork)
>  		queue_work(system_long_wq, &mstb->mgr->work);
> -
>  }
>  
>  static struct drm_dp_mst_branch *drm_dp_get_mst_branch_device(struct drm_dp_mst_topology_mgr *mgr,
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
