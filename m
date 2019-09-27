Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE1EC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BE4206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="PJ/lz00q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfI0NaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:30:15 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41705 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0NaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:30:15 -0400
Received: by mail-yw1-f67.google.com with SMTP id 129so884698ywb.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=hhaOA35aksrllBwVEVKU+X3E6wwjQjTWsM2RflZ/t40=;
        b=PJ/lz00qRN9N+2/54/FM6u9G4s2lbHbVFn1VR0FhpJL3kPY3lOIkAzlhMug3ea9WYB
         UkoWO6UjC5N7SWJh7ooTk21s5xMlsUYFAY60MlUbf+40jQNgmsGE35YgGOxPUpeysF+n
         7eaJpty5wZcB6JgDRZd9Pu4kzcp/s3TiimENipXOCKPe8H8LteIE9DwIBX4Jkr+rzy2K
         ceZfE2AIuZGkJbz98ZQ/B6pVKE3c6WI1hdGWu8seGD5nzpp8oR6J46wAe3D/Bwa9i0LP
         lyh7lVGfaHHDZksPomEHSF9Be1Mx/Qs4Spxnur7BtFq6niI6RQ00fCeUdlbJ4Z7qk5Iq
         OPtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=hhaOA35aksrllBwVEVKU+X3E6wwjQjTWsM2RflZ/t40=;
        b=KJLBEZo3X5g6d+WqiF06Qu3x7ohEYwlsgH7pTh40PhKoG3GVx9m/wtjgX5CtPE1vq1
         tCdl+5uWKqiOHsaRc2ktydAaG/Divule76Lh3i0nslUK0SHwdSGStydRa8dm/ujd2TyA
         RidW+r9Yxz5/wzSupOZPRrtK5L99D7ser8es1F3TAUE8ntEEegigLerp2hh/Oawb8rFz
         Y3ux0KVslLoL8lRUOVoSRlMr77ipxBChgq1lRIa0BIcx7QwHOaD1N5MIVwx42/6mU/jp
         ubSHjAbEpvNO4GM56At5Z/mMlhQRonb3mYWEQwBGa/5fIbDPWDC3lYviW4FUUP9lGi/Z
         7ilw==
X-Gm-Message-State: APjAAAWnCjAVk6hKUcFX2BTJ8K6CQv+7sEmE1eEC+oNmlA260DG81ROy
        H/yjmZwHwi0n6NQNYu4bChFLbA==
X-Google-Smtp-Source: APXvYqxmvKQo4gMLQL97D+Fl2OfhONdeyjwXGGcZeg0We7Htghg35MF90vz65Iulvvh81bUB6a9bkg==
X-Received: by 2002:a81:6743:: with SMTP id b64mr2828589ywc.302.1569591013892;
        Fri, 27 Sep 2019 06:30:13 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id o135sm611489ywo.75.2019.09.27.06.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:30:12 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:30:11 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 16/27] drm/dp_mst: Refactor pdt setup/teardown, add
 more locking
Message-ID: <20190927133011.GP218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-17-lyude@redhat.com>
 <20190925192750.GH218215@art_vandelay>
 <581dc77ab09314ac8d7c4cd7dc3efee5d4663a97.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <581dc77ab09314ac8d7c4cd7dc3efee5d4663a97.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 05:00:00PM -0400, Lyude Paul wrote:
> On Wed, 2019-09-25 at 15:27 -0400, Sean Paul wrote:
> > On Tue, Sep 03, 2019 at 04:45:54PM -0400, Lyude Paul wrote:
> > > Since we're going to be implementing suspend/resume reprobing very soon,
> > > we need to make sure we are extra careful to ensure that our locking
> > > actually protects the topology state where we expect it to. Turns out
> > > this isn't the case with drm_dp_port_setup_pdt() and
> > > drm_dp_port_teardown_pdt(), both of which change port->mstb without
> > > grabbing &mgr->lock.
> > > 
> > > Additionally, since most callers of these functions are just using it to
> > > teardown the port's previous PDT and setup a new one we can simplify
> > > things a bit and combine drm_dp_port_setup_pdt() and
> > > drm_dp_port_teardown_pdt() into a single function:
> > > drm_dp_port_set_pdt(). This function also handles actually ensuring that
> > > we grab the correct locks when we need to modify port->mstb.
> > > 
> > > Cc: Juston Li <juston.li@intel.com>
> > > Cc: Imre Deak <imre.deak@intel.com>
> > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Cc: Harry Wentland <hwentlan@amd.com>
> > > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > > ---
> > >  drivers/gpu/drm/drm_dp_mst_topology.c | 181 +++++++++++++++-----------
> > >  include/drm/drm_dp_mst_helper.h       |   6 +-
> > >  2 files changed, 110 insertions(+), 77 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > index d1610434a0cb..9944ef2ce885 100644
> > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > @@ -1487,24 +1487,6 @@ drm_dp_mst_topology_put_mstb(struct
> > > drm_dp_mst_branch *mstb)
> > >  	kref_put(&mstb->topology_kref, drm_dp_destroy_mst_branch_device);
> > >  }
> > >  
> > > -static void drm_dp_port_teardown_pdt(struct drm_dp_mst_port *port, int
> > > old_pdt)
> > > -{
> > > -	struct drm_dp_mst_branch *mstb;
> > > -
> > > -	switch (old_pdt) {
> > > -	case DP_PEER_DEVICE_DP_LEGACY_CONV:
> > > -	case DP_PEER_DEVICE_SST_SINK:
> > > -		/* remove i2c over sideband */
> > > -		drm_dp_mst_unregister_i2c_bus(&port->aux);
> > > -		break;
> > > -	case DP_PEER_DEVICE_MST_BRANCHING:
> > > -		mstb = port->mstb;
> > > -		port->mstb = NULL;
> > > -		drm_dp_mst_topology_put_mstb(mstb);
> > > -		break;
> > > -	}
> > > -}
> > > -
> > >  static void drm_dp_destroy_port(struct kref *kref)
> > >  {
> > >  	struct drm_dp_mst_port *port =
> > > @@ -1714,38 +1696,79 @@ static u8 drm_dp_calculate_rad(struct
> > > drm_dp_mst_port *port,
> > >  	return parent_lct + 1;
> > >  }
> > >  
> > > -/*
> > > - * return sends link address for new mstb
> > > - */
> > > -static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
> > > +static int drm_dp_port_set_pdt(struct drm_dp_mst_port *port, u8 new_pdt)
> > >  {
> > > -	int ret;
> > > -	u8 rad[6], lct;
> > > -	bool send_link = false;
> > > +	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
> > > +	struct drm_dp_mst_branch *mstb;
> > > +	u8 rad[8], lct;
> > > +	int ret = 0;
> > > +
> > > +	if (port->pdt == new_pdt)
> > 
> > Shouldn't we also ensure that access to port->pdt is also locked?
> > 
> 
> It's specifically port->mstb that needs to be protected under lock. We don't
> use port->pdt for traversing the topology at all, so keeping it under
> connection_mutex is sufficient.
> 

I hadn't gotten to the connection_mutex patch yet when I made that comment :)

Reviewed-by: Sean Paul <sean@poorly.run>


> > Sean
> > 
> > > +		return 0;
> > > +
> > > +	/* Teardown the old pdt, if there is one */
> > > +	switch (port->pdt) {
> > > +	case DP_PEER_DEVICE_DP_LEGACY_CONV:
> > > +	case DP_PEER_DEVICE_SST_SINK:
> > > +		/*
> > > +		 * If the new PDT would also have an i2c bus, don't bother
> > > +		 * with reregistering it
> > > +		 */
> > > +		if (new_pdt == DP_PEER_DEVICE_DP_LEGACY_CONV ||
> > > +		    new_pdt == DP_PEER_DEVICE_SST_SINK) {
> > > +			port->pdt = new_pdt;
> > > +			return 0;
> > > +		}
> > > +
> > > +		/* remove i2c over sideband */
> > > +		drm_dp_mst_unregister_i2c_bus(&port->aux);
> > > +		break;
> > > +	case DP_PEER_DEVICE_MST_BRANCHING:
> > > +		mutex_lock(&mgr->lock);
> > > +		drm_dp_mst_topology_put_mstb(port->mstb);
> > > +		port->mstb = NULL;
> > > +		mutex_unlock(&mgr->lock);
> > > +		break;
> > > +	}
> > > +
> > > +	port->pdt = new_pdt;
> > >  	switch (port->pdt) {
> > >  	case DP_PEER_DEVICE_DP_LEGACY_CONV:
> > >  	case DP_PEER_DEVICE_SST_SINK:
> > >  		/* add i2c over sideband */
> > >  		ret = drm_dp_mst_register_i2c_bus(&port->aux);
> > >  		break;
> > > +
> > >  	case DP_PEER_DEVICE_MST_BRANCHING:
> > >  		lct = drm_dp_calculate_rad(port, rad);
> > > +		mstb = drm_dp_add_mst_branch_device(lct, rad);
> > > +		if (!mstb) {
> > > +			ret = -ENOMEM;
> > > +			DRM_ERROR("Failed to create MSTB for port %p", port);
> > > +			goto out;
> > > +		}
> > >  
> > > -		port->mstb = drm_dp_add_mst_branch_device(lct, rad);
> > > -		if (port->mstb) {
> > > -			port->mstb->mgr = port->mgr;
> > > -			port->mstb->port_parent = port;
> > > -			/*
> > > -			 * Make sure this port's memory allocation stays
> > > -			 * around until its child MSTB releases it
> > > -			 */
> > > -			drm_dp_mst_get_port_malloc(port);
> > > +		mutex_lock(&mgr->lock);
> > > +		port->mstb = mstb;
> > > +		mstb->mgr = port->mgr;
> > > +		mstb->port_parent = port;
> > >  
> > > -			send_link = true;
> > > -		}
> > > +		/*
> > > +		 * Make sure this port's memory allocation stays
> > > +		 * around until its child MSTB releases it
> > > +		 */
> > > +		drm_dp_mst_get_port_malloc(port);
> > > +		mutex_unlock(&mgr->lock);
> > > +
> > > +		/* And make sure we send a link address for this */
> > > +		ret = 1;
> > >  		break;
> > >  	}
> > > -	return send_link;
> > > +
> > > +out:
> > > +	if (ret < 0)
> > > +		port->pdt = DP_PEER_DEVICE_NONE;
> > > +	return ret;
> > >  }
> > >  
> > >  /**
> > > @@ -1881,10 +1904,9 @@ static void drm_dp_add_port(struct
> > > drm_dp_mst_branch *mstb,
> > >  			    struct drm_device *dev,
> > >  			    struct drm_dp_link_addr_reply_port *port_msg)
> > >  {
> > > +	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> > >  	struct drm_dp_mst_port *port;
> > > -	bool ret;
> > >  	bool created = false;
> > > -	int old_pdt = 0;
> > >  	int old_ddps = 0;
> > >  
> > >  	port = drm_dp_get_port(mstb, port_msg->port_number);
> > > @@ -1896,7 +1918,7 @@ static void drm_dp_add_port(struct drm_dp_mst_branch
> > > *mstb,
> > >  		kref_init(&port->malloc_kref);
> > >  		port->parent = mstb;
> > >  		port->port_num = port_msg->port_number;
> > > -		port->mgr = mstb->mgr;
> > > +		port->mgr = mgr;
> > >  		port->aux.name = "DPMST";
> > >  		port->aux.dev = dev->dev;
> > >  		port->aux.is_remote = true;
> > > @@ -1909,11 +1931,9 @@ static void drm_dp_add_port(struct
> > > drm_dp_mst_branch *mstb,
> > >  
> > >  		created = true;
> > >  	} else {
> > > -		old_pdt = port->pdt;
> > >  		old_ddps = port->ddps;
> > >  	}
> > >  
> > > -	port->pdt = port_msg->peer_device_type;
> > >  	port->input = port_msg->input_port;
> > >  	port->mcs = port_msg->mcs;
> > >  	port->ddps = port_msg->ddps;
> > > @@ -1925,29 +1945,33 @@ static void drm_dp_add_port(struct
> > > drm_dp_mst_branch *mstb,
> > >  	/* manage mstb port lists with mgr lock - take a reference
> > >  	   for this list */
> > >  	if (created) {
> > > -		mutex_lock(&mstb->mgr->lock);
> > > +		mutex_lock(&mgr->lock);
> > >  		drm_dp_mst_topology_get_port(port);
> > >  		list_add(&port->next, &mstb->ports);
> > > -		mutex_unlock(&mstb->mgr->lock);
> > > +		mutex_unlock(&mgr->lock);
> > >  	}
> > >  
> > >  	if (old_ddps != port->ddps) {
> > >  		if (port->ddps) {
> > >  			if (!port->input) {
> > > -				drm_dp_send_enum_path_resources(mstb->mgr,
> > > -								mstb, port);
> > > +				drm_dp_send_enum_path_resources(mgr, mstb,
> > > +								port);
> > >  			}
> > >  		} else {
> > >  			port->available_pbn = 0;
> > >  		}
> > >  	}
> > >  
> > > -	if (old_pdt != port->pdt && !port->input) {
> > > -		drm_dp_port_teardown_pdt(port, old_pdt);
> > > -
> > > -		ret = drm_dp_port_setup_pdt(port);
> > > -		if (ret == true)
> > > -			drm_dp_send_link_address(mstb->mgr, port->mstb);
> > > +	if (!port->input) {
> > > +		int ret = drm_dp_port_set_pdt(port,
> > > +					      port_msg->peer_device_type);
> > > +		if (ret == 1) {
> > > +			drm_dp_send_link_address(mgr, port->mstb);
> > > +		} else if (ret < 0) {
> > > +			DRM_ERROR("Failed to change PDT on port %p: %d\n",
> > > +				  port, ret);
> > > +			goto fail;
> > > +		}
> > >  	}
> > >  
> > >  	if (created && !port->input) {
> > > @@ -1955,18 +1979,11 @@ static void drm_dp_add_port(struct
> > > drm_dp_mst_branch *mstb,
> > >  
> > >  		build_mst_prop_path(mstb, port->port_num, proppath,
> > >  				    sizeof(proppath));
> > > -		port->connector = (*mstb->mgr->cbs->add_connector)(mstb->mgr,
> > > -								   port,
> > > -								   proppath);
> > > -		if (!port->connector) {
> > > -			/* remove it from the port list */
> > > -			mutex_lock(&mstb->mgr->lock);
> > > -			list_del(&port->next);
> > > -			mutex_unlock(&mstb->mgr->lock);
> > > -			/* drop port list reference */
> > > -			drm_dp_mst_topology_put_port(port);
> > > -			goto out;
> > > -		}
> > > +		port->connector = (*mgr->cbs->add_connector)(mgr, port,
> > > +							     proppath);
> > > +		if (!port->connector)
> > > +			goto fail;
> > > +
> > >  		if ((port->pdt == DP_PEER_DEVICE_DP_LEGACY_CONV ||
> > >  		     port->pdt == DP_PEER_DEVICE_SST_SINK) &&
> > >  		    port->port_num >= DP_MST_LOGICAL_PORT_0) {
> > > @@ -1974,28 +1991,38 @@ static void drm_dp_add_port(struct
> > > drm_dp_mst_branch *mstb,
> > >  							 &port->aux.ddc);
> > >  			drm_connector_set_tile_property(port->connector);
> > >  		}
> > > -		(*mstb->mgr->cbs->register_connector)(port->connector);
> > > +
> > > +		(*mgr->cbs->register_connector)(port->connector);
> > >  	}
> > >  
> > > -out:
> > >  	/* put reference to this port */
> > >  	drm_dp_mst_topology_put_port(port);
> > > +	return;
> > > +
> > > +fail:
> > > +	/* Remove it from the port list */
> > > +	mutex_lock(&mgr->lock);
> > > +	list_del(&port->next);
> > > +	mutex_unlock(&mgr->lock);
> > > +
> > > +	/* Drop the port list reference */
> > > +	drm_dp_mst_topology_put_port(port);
> > > +	/* And now drop our reference */
> > > +	drm_dp_mst_topology_put_port(port);
> > >  }
> > >  
> > >  static void drm_dp_update_port(struct drm_dp_mst_branch *mstb,
> > >  			       struct drm_dp_connection_status_notify
> > > *conn_stat)
> > >  {
> > >  	struct drm_dp_mst_port *port;
> > > -	int old_pdt;
> > >  	int old_ddps;
> > >  	bool dowork = false;
> > > +
> > >  	port = drm_dp_get_port(mstb, conn_stat->port_number);
> > >  	if (!port)
> > >  		return;
> > >  
> > >  	old_ddps = port->ddps;
> > > -	old_pdt = port->pdt;
> > > -	port->pdt = conn_stat->peer_device_type;
> > >  	port->mcs = conn_stat->message_capability_status;
> > >  	port->ldps = conn_stat->legacy_device_plug_status;
> > >  	port->ddps = conn_stat->displayport_device_plug_status;
> > > @@ -2007,11 +2034,17 @@ static void drm_dp_update_port(struct
> > > drm_dp_mst_branch *mstb,
> > >  			port->available_pbn = 0;
> > >  		}
> > >  	}
> > > -	if (old_pdt != port->pdt && !port->input) {
> > > -		drm_dp_port_teardown_pdt(port, old_pdt);
> > >  
> > > -		if (drm_dp_port_setup_pdt(port))
> > > +	if (!port->input) {
> > > +		int ret = drm_dp_port_set_pdt(port,
> > > +					      conn_stat->peer_device_type);
> > > +		if (ret == 1) {
> > >  			dowork = true;
> > > +		} else if (ret < 0) {
> > > +			DRM_ERROR("Failed to change PDT for port %p: %d\n",
> > > +				  port, ret);
> > > +			dowork = false;
> > > +		}
> > >  	}
> > >  
> > >  	drm_dp_mst_topology_put_port(port);
> > > @@ -4003,9 +4036,7 @@ drm_dp_delayed_destroy_port(struct drm_dp_mst_port
> > > *port)
> > >  	if (port->connector)
> > >  		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> > >  
> > > -	drm_dp_port_teardown_pdt(port, port->pdt);
> > > -	port->pdt = DP_PEER_DEVICE_NONE;
> > > -
> > > +	drm_dp_port_set_pdt(port, DP_PEER_DEVICE_NONE);
> > >  	drm_dp_mst_put_port_malloc(port);
> > >  }
> > >  
> > > diff --git a/include/drm/drm_dp_mst_helper.h
> > > b/include/drm/drm_dp_mst_helper.h
> > > index 5423a8adda78..f253ee43e9d9 100644
> > > --- a/include/drm/drm_dp_mst_helper.h
> > > +++ b/include/drm/drm_dp_mst_helper.h
> > > @@ -55,8 +55,10 @@ struct drm_dp_vcpi {
> > >   * @num_sdp_stream_sinks: Number of stream sinks
> > >   * @available_pbn: Available bandwidth for this port.
> > >   * @next: link to next port on this branch device
> > > - * @mstb: branch device attach below this port
> > > - * @aux: i2c aux transport to talk to device connected to this port.
> > > + * @mstb: branch device on this port, protected by
> > > + * &drm_dp_mst_topology_mgr.lock
> > > + * @aux: i2c aux transport to talk to device connected to this port,
> > > protected
> > > + * by &drm_dp_mst_topology_mgr.lock
> > >   * @parent: branch device parent of this port
> > >   * @vcpi: Virtual Channel Payload info for this port.
> > >   * @connector: DRM connector this port is connected to.
> > > -- 
> > > 2.21.0
> > > 
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
