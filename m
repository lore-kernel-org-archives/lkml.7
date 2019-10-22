Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CBCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F016F21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 20:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Vpzqcwbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbfJVUOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 16:14:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35720 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387999AbfJVUOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 16:14:37 -0400
Received: by mail-yb1-f194.google.com with SMTP id i6so5583720ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=uWT/91UjYG+pRZcitLYG0hQ77Zt8GLqkiDgF5fsNM4I=;
        b=Vpzqcwbm24NKQ2QXaeqLT9/Ve60BsfofS5RLmhJdZTxTjUvjY/jAw5mWfeiskCTnoh
         GxSWZWW+83K3fdZoJxz7bgcBm/RjZYUsmcj998XrFrep4sOc0W3cKMPkmvlf5AMYSk9i
         sx+x7Ot9QNU1Flr+6zsZw34aXN7XCMDADD2F2W+uTtkHcL/YCL2hZ914FWAfRO7+yVeM
         VJZjXoTgNXB1OY4bo1PQDjjSGMJc7mMEDaZqRsRq9BYer+yArpitWdgE3bypKHWKYk22
         X7h3nDHBpb51BFX9pWuieF/3BfcHQhp4bu7QF54TrhC13zI9Gev1Rq94OVslw0lAOd2o
         n5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=uWT/91UjYG+pRZcitLYG0hQ77Zt8GLqkiDgF5fsNM4I=;
        b=HFALkd6JPFXQ8pWziO29ZfQfW0Ibkg4B8cuIhGSP4FPhzQ3aEQmpCeAP9oCb2M5O05
         osJA+7PghcoDFR9jaucLzY9Y5ZLiIIaOu5hpKjGCTrcd1TRGLLaKp5TBDcAoKi26YxdQ
         bd5oxlmKSo5516qynQ3sFWmXFKiaEp1xqYIxY347WIfb8/tKfe+LXE9rTqXnrXDfURX+
         cVAd4qNmwm0nSDjI4jUn9C517ke3FXKvFwCdDp8EyDtTRotn94IcD64JxI/RpeWyUdT/
         fca6vJnYTt3YKkSSRu9+LQqPt/BcvDb5Z2hYDHD2qo3iu28p173zbZDkx8Ry4sSZAowL
         VXkQ==
X-Gm-Message-State: APjAAAUY3rijMRdkdn07caobIMI8FbNBLB0OUV5M7E9jBldK7YmVyZZe
        YClQ531ekXs1+kWX0tZeXKda3Q==
X-Google-Smtp-Source: APXvYqy06XHilaVYrRwLLXfjBU+UN5aAupBO2I09ze4erbjNF8BXYcvlr5hw8S/sn5n/QlrJtYmJ+A==
X-Received: by 2002:a25:77ce:: with SMTP id s197mr3799322ybc.228.1571775276083;
        Tue, 22 Oct 2019 13:14:36 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id d191sm210244ywd.71.2019.10.22.13.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 13:14:35 -0700 (PDT)
Date:   Tue, 22 Oct 2019 16:14:35 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/14] drm/dp_mst: Don't forget to update port->input
 in drm_dp_mst_handle_conn_stat()
Message-ID: <20191022201435.GD212858@art_vandelay>
References: <20191022023641.8026-1-lyude@redhat.com>
 <20191022023641.8026-8-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022023641.8026-8-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:36:02PM -0400, Lyude Paul wrote:
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
> Reviewed-by: Sean Paul <sean@poorly.run>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 52 +++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 7bf4db91ff90..c8e218b902ae 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2079,18 +2079,40 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
>  {
>  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
>  	struct drm_dp_mst_port *port;
> -	int old_ddps;
> -	bool dowork = false;
> +	int old_ddps, ret;
> +	u8 new_pdt;
> +	bool dowork = false, create_connector = false;
>  
>  	port = drm_dp_get_port(mstb, conn_stat->port_number);
>  	if (!port)
>  		return;
>  
> -	/* Locking is only needed if the port's exposed to userspace */
> -	if (port->connector)
> +	if (port->connector) {
> +		if (!port->input && conn_stat->input_port) {
> +			/*
> +			 * We can't remove a connector from an already exposed
> +			 * port, so just throw the port out and make sure we
> +			 * reprobe the link address of it's parent MSTB
> +			 */
> +			drm_dp_mst_topology_unlink_port(mgr, port);
> +			mstb->link_address_sent = false;
> +			dowork = true;
> +			goto out;
> +		}
> +
> +		/*
> +		 * Locking is only needed if the port's exposed to userspace
> +		 */

optional nit: this will still fit on one line

>  		drm_modeset_lock(&mgr->base.lock, NULL);
> +	} else if (port->input && !conn_stat->input_port) {
> +		create_connector = true;
> +		/* Reprobe link address so we get num_sdp_streams */
> +		mstb->link_address_sent = false;
> +		dowork = true;
> +	}
>  
>  	old_ddps = port->ddps;
> +	port->input = conn_stat->input_port;
>  	port->mcs = conn_stat->message_capability_status;
>  	port->ldps = conn_stat->legacy_device_plug_status;
>  	port->ddps = conn_stat->displayport_device_plug_status;
> @@ -2103,21 +2125,23 @@ drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
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
>  	}
>  
>  	if (port->connector)
>  		drm_modeset_unlock(&mgr->base.lock);
> +	else if (create_connector)
> +		drm_dp_mst_port_add_connector(mstb, port);
>  
> +out:
>  	drm_dp_mst_topology_put_port(port);
>  	if (dowork)
>  		queue_work(system_long_wq, &mstb->mgr->work);
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
