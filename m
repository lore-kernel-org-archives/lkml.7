Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B5AC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7CCB21872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfHZWHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:07:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59516 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfHZWHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:07:11 -0400
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8209680F7C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 22:07:10 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id r10so19000309qte.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=ycIZbVMTeFm3kLyX9uTzi+eSMUtl8bWnGni4U99zQvw=;
        b=Gk1yv8sbHls+JnnJUOde0Rx7v9TP0B1d43XvL76mOHZqA4ch+hNPMUps2UXBMci6jq
         gy94Lynztss6PJ8Ew7wJsWVYCe2MzZUwOQNFqlZ638GGB9onRPAzHMm3ElCRGjMQO+dK
         6IHvy8USyKWwgb/bULcdL0B30wjQ3K5FdDpssCj6inPOPhdQzH9XbdhZBAYhGkIbDVbz
         wtsWQ2VDaOtWUQvDEV109nxUJUxdn5cAyTf+Sjajk0fRGGAn7f2r6i5SsUDY1Owft3Xn
         Xts03jq02aUYnIK+xMjVJUh3AKJrAnn7Oq5a1GOY3KrSz5LOKq+4r8MVGAKNTT9/YNA3
         tQ6Q==
X-Gm-Message-State: APjAAAVnOtrjQ4rlT7puqeHzbbSp/nz69VSi7Ufzp8rHCa6pueGIsVTD
        BO78qPijjqPagPinEy2C39cTy2p8oIj6KzdJ17q/rTPyqbv/GUvA/OdY3cfoHfwSlOJ+RszsIs4
        50AofKTPjusn+0+kMmQrvoX0h
X-Received: by 2002:ac8:2544:: with SMTP id 4mr20245719qtn.319.1566857229798;
        Mon, 26 Aug 2019 15:07:09 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxIK7SBP5kse08y0zIHWURtOxx5pIrlkL5b6alNU0q+MABl9qFeINGvfFmyiLYo7SyvaUlHCA==
X-Received: by 2002:ac8:2544:: with SMTP id 4mr20245690qtn.319.1566857229562;
        Mon, 26 Aug 2019 15:07:09 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id o33sm7794230qtd.72.2019.08.26.15.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 15:07:09 -0700 (PDT)
Message-ID: <9512ed84594d6927b916d46d384241ab93d1f45a.camel@redhat.com>
Subject: Re: [PATCH 02/26] drm/dp_mst: Destroy mstbs from
 destroy_connector_work
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Aug 2019 18:07:07 -0400
In-Reply-To: <20190813130055.GS7444@phenom.ffwll.local>
References: <20190718014329.8107-1-lyude@redhat.com>
         <20190718014329.8107-3-lyude@redhat.com>
         <20190813130055.GS7444@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-13 at 15:00 +0200, Daniel Vetter wrote:
> On Wed, Jul 17, 2019 at 09:42:25PM -0400, Lyude Paul wrote:
> > Currently we remove MST branch devices from the in-memory topology
> > immediately when their topology refcount reaches 0. This works just fine
> > at the moment, but since we're about to add suspend/resume reprobing for
> > MST topologies we're going to need to be able to travel through the
> > topology and drop topology refs on branch devices while holding
> > mgr->mutex. Since we currently can't do this due to the circular locking
> > dependencies that would incur, move all of the actual work for
> > drm_dp_destroy_mst_branch_device() into drm_dp_destroy_connector_work()
> > so we can drop topology refs on MSTBs in any locking context.
> 
> Would be good to point at where exactly the problem is here, maybe also
> mentioned the exact future patch that causes the problem. I did go look
> around a bit, but didn't spot it.

Ah, I didn't do a great job of explaining whoops! Basically, the issue is that
when reprobing the state during suspend/resume, there's of course going to be
a chance that any MST ports in the topology could have had their PDT changed
while we were suspended. This in turn means that while we're iterating through
each mstb's ports in drm_dp_send_link_address() we want to be able to remove
MSTBs from while under &mgr->lock, something we can't do without handling MSTB
destruction in another thread. I'll mention this in the next version of this
patch

> 
> > Cc: Juston Li <juston.li@intel.com>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 121 +++++++++++++++++---------
> >  include/drm/drm_dp_mst_helper.h       |  10 +++
> >  2 files changed, 90 insertions(+), 41 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 998081b9b205..d7c3d9233834 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -1108,34 +1108,17 @@ static void
> > drm_dp_destroy_mst_branch_device(struct kref *kref)
> >  	struct drm_dp_mst_branch *mstb =
> >  		container_of(kref, struct drm_dp_mst_branch, topology_kref);
> >  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> > -	struct drm_dp_mst_port *port, *tmp;
> > -	bool wake_tx = false;
> > -
> > -	mutex_lock(&mgr->lock);
> > -	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> > -		list_del(&port->next);
> > -		drm_dp_mst_topology_put_port(port);
> > -	}
> > -	mutex_unlock(&mgr->lock);
> > -
> > -	/* drop any tx slots msg */
> > -	mutex_lock(&mstb->mgr->qlock);
> > -	if (mstb->tx_slots[0]) {
> > -		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > -		mstb->tx_slots[0] = NULL;
> > -		wake_tx = true;
> > -	}
> > -	if (mstb->tx_slots[1]) {
> > -		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > -		mstb->tx_slots[1] = NULL;
> > -		wake_tx = true;
> > -	}
> > -	mutex_unlock(&mstb->mgr->qlock);
> >  
> > -	if (wake_tx)
> > -		wake_up_all(&mstb->mgr->tx_waitq);
> > +	INIT_LIST_HEAD(&mstb->destroy_next);
> >  
> > -	drm_dp_mst_put_mstb_malloc(mstb);
> > +	/*
> > +	 * This can get called under mgr->mutex, so we need to perform the
> > +	 * actual destruction of the mstb in another worker
> > +	 */
> > +	mutex_lock(&mgr->destroy_connector_lock);
> > +	list_add(&mstb->destroy_next, &mgr->destroy_branch_device_list);
> > +	mutex_unlock(&mgr->destroy_connector_lock);
> > +	schedule_work(&mgr->destroy_connector_work);
> >  }
> >  
> >  /**
> > @@ -3618,10 +3601,56 @@ static void drm_dp_tx_work(struct work_struct
> > *work)
> >  	mutex_unlock(&mgr->qlock);
> >  }
> >  
> > +static inline void
> > +drm_dp_finish_destroy_port(struct drm_dp_mst_port *port)
> 
> Bikeshed: I'd call this _delayed_destroy, I think that makes a bit clearer
> why there's 2 stages to destroying stuff.
> 
> > +{
> > +	INIT_LIST_HEAD(&port->next);
> > +
> > +	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> > +
> > +	drm_dp_port_teardown_pdt(port, port->pdt);
> > +	port->pdt = DP_PEER_DEVICE_NONE;
> > +
> > +	drm_dp_mst_put_port_malloc(port);
> > +}
> > +
> > +static inline void
> > +drm_dp_finish_destroy_mst_branch_device(struct drm_dp_mst_branch *mstb)
> > +{
> > +	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> > +	struct drm_dp_mst_port *port, *tmp;
> > +	bool wake_tx = false;
> > +
> > +	mutex_lock(&mgr->lock);
> > +	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> > +		list_del(&port->next);
> > +		drm_dp_mst_topology_put_port(port);
> > +	}
> > +	mutex_unlock(&mgr->lock);
> > +
> > +	/* drop any tx slots msg */
> > +	mutex_lock(&mstb->mgr->qlock);
> > +	if (mstb->tx_slots[0]) {
> > +		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > +		mstb->tx_slots[0] = NULL;
> > +		wake_tx = true;
> > +	}
> > +	if (mstb->tx_slots[1]) {
> > +		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > +		mstb->tx_slots[1] = NULL;
> > +		wake_tx = true;
> > +	}
> > +	mutex_unlock(&mstb->mgr->qlock);
> > +
> > +	if (wake_tx)
> > +		wake_up_all(&mstb->mgr->tx_waitq);
> > +
> > +	drm_dp_mst_put_mstb_malloc(mstb);
> > +}
> > +
> >  static void drm_dp_destroy_connector_work(struct work_struct *work)
> >  {
> >  	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct
> > drm_dp_mst_topology_mgr, destroy_connector_work);
> > -	struct drm_dp_mst_port *port;
> >  	bool send_hotplug = false;
> >  	/*
> >  	 * Not a regular list traverse as we have to drop the destroy
> > @@ -3629,24 +3658,33 @@ static void drm_dp_destroy_connector_work(struct
> > work_struct *work)
> >  	 * ordering between this lock and the config mutex.
> >  	 */
> >  	for (;;) {
> > +		struct drm_dp_mst_branch *mstb = NULL;
> > +		struct drm_dp_mst_port *port = NULL;
> > +
> > +		/* Destroy any MSTBs first, and then their ports second */
> >  		mutex_lock(&mgr->destroy_connector_lock);
> > -		port = list_first_entry_or_null(&mgr->destroy_connector_list,
> > struct drm_dp_mst_port, next);
> > -		if (!port) {
> > -			mutex_unlock(&mgr->destroy_connector_lock);
> > -			break;
> > +		mstb = list_first_entry_or_null(&mgr-
> > >destroy_branch_device_list,
> > +						struct drm_dp_mst_branch,
> > +						destroy_next);
> > +		if (mstb) {
> > +			list_del(&mstb->destroy_next);
> > +		} else {
> > +			port = list_first_entry_or_null(&mgr-
> > >destroy_connector_list,
> > +							struct
> > drm_dp_mst_port,
> > +							next);
> > +			if (port)
> > +				list_del(&port->next);
> >  		}
> 
> Control flow looks rather awkward here. I'd do either two loops, or if you
> want to have just one, rename it to ->delayed_destroy_list and have a
> ->delayed_destry_cb next to it?
> 
> Cheers, Daniel
> 
> 
> > -		list_del(&port->next);
> >  		mutex_unlock(&mgr->destroy_connector_lock);
> >  
> > -		INIT_LIST_HEAD(&port->next);
> > -
> > -		mgr->cbs->destroy_connector(mgr, port->connector);
> > -
> > -		drm_dp_port_teardown_pdt(port, port->pdt);
> > -		port->pdt = DP_PEER_DEVICE_NONE;
> > -
> > -		drm_dp_mst_put_port_malloc(port);
> > -		send_hotplug = true;
> > +		if (mstb) {
> > +			drm_dp_finish_destroy_mst_branch_device(mstb);
> > +		} else if (port) {
> > +			drm_dp_finish_destroy_port(port);
> > +			send_hotplug = true;
> > +		} else {
> > +			break;
> > +		}
> >  	}
> >  	if (send_hotplug)
> >  		drm_kms_helper_hotplug_event(mgr->dev);
> > @@ -3840,6 +3878,7 @@ int drm_dp_mst_topology_mgr_init(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  	mutex_init(&mgr->destroy_connector_lock);
> >  	INIT_LIST_HEAD(&mgr->tx_msg_downq);
> >  	INIT_LIST_HEAD(&mgr->destroy_connector_list);
> > +	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
> >  	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
> >  	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
> >  	INIT_WORK(&mgr->destroy_connector_work,
> > drm_dp_destroy_connector_work);
> > diff --git a/include/drm/drm_dp_mst_helper.h
> > b/include/drm/drm_dp_mst_helper.h
> > index 8c97a5f92c47..c01f3ea72756 100644
> > --- a/include/drm/drm_dp_mst_helper.h
> > +++ b/include/drm/drm_dp_mst_helper.h
> > @@ -143,6 +143,12 @@ struct drm_dp_mst_branch {
> >  	 */
> >  	struct kref malloc_kref;
> >  
> > +	/**
> > +	 * @destroy_next: linked-list entry used by
> > +	 * drm_dp_destroy_connector_work()
> > +	 */
> > +	struct list_head destroy_next;
> > +
> >  	u8 rad[8];
> >  	u8 lct;
> >  	int num_ports;
> > @@ -578,6 +584,10 @@ struct drm_dp_mst_topology_mgr {
> >  	 * @destroy_connector_list: List of to be destroyed connectors.
> >  	 */
> >  	struct list_head destroy_connector_list;
> > +	/**
> > +	 * @destroy_branch_device_list: List of to be destroyed branch devices
> > +	 */
> > +	struct list_head destroy_branch_device_list;
> >  	/**
> >  	 * @destroy_connector_lock: Protects @connector_list.
> >  	 */
> > -- 
> > 2.21.0
> > 
-- 
Cheers,
	Lyude Paul

