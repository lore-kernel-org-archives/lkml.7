Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0D4C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C309E2146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Yyt03/qo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfI0NbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:31:09 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33435 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0NbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:31:09 -0400
Received: by mail-yw1-f68.google.com with SMTP id i188so905139ywf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qYB5dsI6pw1AaiAQgGLORr8jZcoFuXEt35OZRnEbQJE=;
        b=Yyt03/qoCfrtPDoth18a8czanIbv2L3Ll5m0IzUPyqx0JJ8qu+A0NSh+iZbMJPkTjJ
         laNHMv43J25MMZ74oFbXbS4XoO1qcbo+Ncw5IpELdoDnptMoFyJl0AlakhnyavsxFsH3
         6X64Fwj78gGMIIBdr1CbektKHuzIDH3lFCoyvRjT3VcoNq1KFAs0KCJP9wJ5pmtI39mB
         onszTycFbbm0mPmap/EWN3HF58VC3WLB0n4RQnloCYG7EBnA9Uxsb9tCD48BTPkcJ8R7
         JV+LnYvy2oiNLx1yfWNG/qa8We7aPAxZWCBKc0CNB9zOymeEB/Jnd2Z4B7Jf93kZdimV
         GkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qYB5dsI6pw1AaiAQgGLORr8jZcoFuXEt35OZRnEbQJE=;
        b=kDUrAWFf1Qr7JXrbM8Nxx0tQgCTFkc9M5+WTi4pRxHb/ADhIeOSuZR1of7ksXvYY1c
         NKAis8T6aPgZOyJck7tGZ9+RKXUJlNqHzocz4dCThuCd26SI7Am4XAAbvfqHMK3tSoQl
         zmnnb7Pgc09eynCc2RBVaLsPr1bX0t5EReSCbA+BQgB/+dUQZtrThl/AAEejOIObJ7ys
         C9IrCbNVvc9oEqSm9AlO6WlN6sgwfBGjZZNET58nBl+Nr5oxFHrGmu3HpZJv8/xdhYz0
         K/aT97d3JORrBtmaK8K/wHmm8AD9NeyDuSzDemg9npicAAY9XmTerpN2mI2RTRARH4uG
         +PlA==
X-Gm-Message-State: APjAAAUg4zopI9QSgZySV04zLXtXWNh3gCJukot8Ihsult/d41iNnKK6
        nhJSJqWX85NyjbG9rFTWqOB0KA==
X-Google-Smtp-Source: APXvYqw3UKtWx/8c/EBfd5V9ouBNMey7S0YbJ4vTvGTIpB37MvicbXYHHJf33/MDE3Ugyqe73rcYXg==
X-Received: by 2002:a81:b619:: with SMTP id u25mr2536514ywh.407.1569591068361;
        Fri, 27 Sep 2019 06:31:08 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id q128sm588863ywg.108.2019.09.27.06.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:31:07 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:31:07 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/27] drm/dp_mst: Destroy MSTBs asynchronously
Message-ID: <20190927133107.GQ218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-4-lyude@redhat.com>
 <20190925181644.GD218215@art_vandelay>
 <e9a2638663549d86779002e3616fc2e89f9c7028.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9a2638663549d86779002e3616fc2e89f9c7028.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 04:08:22PM -0400, Lyude Paul wrote:
> On Wed, 2019-09-25 at 14:16 -0400, Sean Paul wrote:
> > On Tue, Sep 03, 2019 at 04:45:41PM -0400, Lyude Paul wrote:
> > > When reprobing an MST topology during resume, we have to account for the
> > > fact that while we were suspended it's possible that mstbs may have been
> > > removed from any ports in the topology. Since iterating downwards in the
> > > topology requires that we hold &mgr->lock, destroying MSTBs from this
> > > context would result in attempting to lock &mgr->lock a second time and
> > > deadlocking.
> > > 
> > > So, fix this by first moving destruction of MSTBs into
> > > destroy_connector_work, then rename destroy_connector_work and friends
> > > to reflect that they now destroy both ports and mstbs.
> > > 
> > > Changes since v1:
> > > * s/destroy_connector_list/destroy_port_list/
> > >   s/connector_destroy_lock/delayed_destroy_lock/
> > >   s/connector_destroy_work/delayed_destroy_work/
> > >   s/drm_dp_finish_destroy_branch_device/drm_dp_delayed_destroy_mstb/
> > >   s/drm_dp_finish_destroy_port/drm_dp_delayed_destroy_port/
> > >   - danvet
> > > * Use two loops in drm_dp_delayed_destroy_work() - danvet
> > > * Better explain why we need to do this - danvet
> > > * Use cancel_work_sync() instead of flush_work() - flush_work() doesn't
> > >   account for work requeing
> > > 
> > > Cc: Juston Li <juston.li@intel.com>
> > > Cc: Imre Deak <imre.deak@intel.com>
> > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Cc: Harry Wentland <hwentlan@amd.com>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > 
> > Took me a while to grok this, and I'm still not 100% confident my mental
> > model
> > is correct, so please bear with me while I ask silly questions :)
> > 
> > Now that the destroy is delayed, and the port remains in the topology, is it
> > possible we will underflow the topology kref by calling put_mstb multiple
> > times?
> > It looks like that would result in a WARN from refcount.c, and wouldn't call
> > the
> > destroy function multiple times, so that's nice :)
> > 
> > Similarly, is there any defense against calling get_mstb() between destroy()
> > and
> > the delayed destroy worker running?
> > 
> Good question! There's only one instance where we unconditionally grab an MSTB
> ref, drm_dp_mst_topology_mgr_set_mst(), and in that location we're guaranteed
> to be the only one with access to that mstb until we drop &mgr->lock.
> Everywhere else we use drm_dp_mst_topology_try_get_mstb(), which uses
> kref_get_unless_zero() to protect against that kind of situation (and forces
> the caller to check with __must_check)

Awesome, thanks for the breakdown!


Reviewed-by: Sean Paul <sean@poorly.run>


> 
> > Sean
> > 
> > > ---
> > >  drivers/gpu/drm/drm_dp_mst_topology.c | 162 +++++++++++++++++---------
> > >  include/drm/drm_dp_mst_helper.h       |  26 +++--
> > >  2 files changed, 127 insertions(+), 61 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > index 3054ec622506..738f260d4b15 100644
> > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > @@ -1113,34 +1113,17 @@ static void
> > > drm_dp_destroy_mst_branch_device(struct kref *kref)
> > >  	struct drm_dp_mst_branch *mstb =
> > >  		container_of(kref, struct drm_dp_mst_branch, topology_kref);
> > >  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> > > -	struct drm_dp_mst_port *port, *tmp;
> > > -	bool wake_tx = false;
> > >  
> > > -	mutex_lock(&mgr->lock);
> > > -	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> > > -		list_del(&port->next);
> > > -		drm_dp_mst_topology_put_port(port);
> > > -	}
> > > -	mutex_unlock(&mgr->lock);
> > > -
> > > -	/* drop any tx slots msg */
> > > -	mutex_lock(&mstb->mgr->qlock);
> > > -	if (mstb->tx_slots[0]) {
> > > -		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > > -		mstb->tx_slots[0] = NULL;
> > > -		wake_tx = true;
> > > -	}
> > > -	if (mstb->tx_slots[1]) {
> > > -		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > > -		mstb->tx_slots[1] = NULL;
> > > -		wake_tx = true;
> > > -	}
> > > -	mutex_unlock(&mstb->mgr->qlock);
> > > +	INIT_LIST_HEAD(&mstb->destroy_next);
> > >  
> > > -	if (wake_tx)
> > > -		wake_up_all(&mstb->mgr->tx_waitq);
> > > -
> > > -	drm_dp_mst_put_mstb_malloc(mstb);
> > > +	/*
> > > +	 * This can get called under mgr->mutex, so we need to perform the
> > > +	 * actual destruction of the mstb in another worker
> > > +	 */
> > > +	mutex_lock(&mgr->delayed_destroy_lock);
> > > +	list_add(&mstb->destroy_next, &mgr->destroy_branch_device_list);
> > > +	mutex_unlock(&mgr->delayed_destroy_lock);
> > > +	schedule_work(&mgr->delayed_destroy_work);
> > >  }
> > >  
> > >  /**
> > > @@ -1255,10 +1238,10 @@ static void drm_dp_destroy_port(struct kref *kref)
> > >  			 * we might be holding the mode_config.mutex
> > >  			 * from an EDID retrieval */
> > >  
> > > -			mutex_lock(&mgr->destroy_connector_lock);
> > > -			list_add(&port->next, &mgr->destroy_connector_list);
> > > -			mutex_unlock(&mgr->destroy_connector_lock);
> > > -			schedule_work(&mgr->destroy_connector_work);
> > > +			mutex_lock(&mgr->delayed_destroy_lock);
> > > +			list_add(&port->next, &mgr->destroy_port_list);
> > > +			mutex_unlock(&mgr->delayed_destroy_lock);
> > > +			schedule_work(&mgr->delayed_destroy_work);
> > >  			return;
> > >  		}
> > >  		/* no need to clean up vcpi
> > > @@ -2792,7 +2775,7 @@ void drm_dp_mst_topology_mgr_suspend(struct
> > > drm_dp_mst_topology_mgr *mgr)
> > >  			   DP_MST_EN | DP_UPSTREAM_IS_SRC);
> > >  	mutex_unlock(&mgr->lock);
> > >  	flush_work(&mgr->work);
> > > -	flush_work(&mgr->destroy_connector_work);
> > > +	flush_work(&mgr->delayed_destroy_work);
> > >  }
> > >  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
> > >  
> > > @@ -3740,34 +3723,104 @@ static void drm_dp_tx_work(struct work_struct
> > > *work)
> > >  	mutex_unlock(&mgr->qlock);
> > >  }
> > >  
> > > -static void drm_dp_destroy_connector_work(struct work_struct *work)
> > > +static inline void
> > > +drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
> > >  {
> > > -	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct
> > > drm_dp_mst_topology_mgr, destroy_connector_work);
> > > -	struct drm_dp_mst_port *port;
> > > -	bool send_hotplug = false;
> > > +	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> > > +
> > > +	drm_dp_port_teardown_pdt(port, port->pdt);
> > > +	port->pdt = DP_PEER_DEVICE_NONE;
> > > +
> > > +	drm_dp_mst_put_port_malloc(port);
> > > +}
> > > +
> > > +static inline void
> > > +drm_dp_delayed_destroy_mstb(struct drm_dp_mst_branch *mstb)
> > > +{
> > > +	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> > > +	struct drm_dp_mst_port *port, *tmp;
> > > +	bool wake_tx = false;
> > > +
> > > +	mutex_lock(&mgr->lock);
> > > +	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> > > +		list_del(&port->next);
> > > +		drm_dp_mst_topology_put_port(port);
> > > +	}
> > > +	mutex_unlock(&mgr->lock);
> > > +
> > > +	/* drop any tx slots msg */
> > > +	mutex_lock(&mstb->mgr->qlock);
> > > +	if (mstb->tx_slots[0]) {
> > > +		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > > +		mstb->tx_slots[0] = NULL;
> > > +		wake_tx = true;
> > > +	}
> > > +	if (mstb->tx_slots[1]) {
> > > +		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> > > +		mstb->tx_slots[1] = NULL;
> > > +		wake_tx = true;
> > > +	}
> > > +	mutex_unlock(&mstb->mgr->qlock);
> > > +
> > > +	if (wake_tx)
> > > +		wake_up_all(&mstb->mgr->tx_waitq);
> > > +
> > > +	drm_dp_mst_put_mstb_malloc(mstb);
> > > +}
> > > +
> > > +static void drm_dp_delayed_destroy_work(struct work_struct *work)
> > > +{
> > > +	struct drm_dp_mst_topology_mgr *mgr =
> > > +		container_of(work, struct drm_dp_mst_topology_mgr,
> > > +			     delayed_destroy_work);
> > > +	bool send_hotplug = false, go_again;
> > > +
> > >  	/*
> > >  	 * Not a regular list traverse as we have to drop the destroy
> > > -	 * connector lock before destroying the connector, to avoid AB->BA
> > > +	 * connector lock before destroying the mstb/port, to avoid AB->BA
> > >  	 * ordering between this lock and the config mutex.
> > >  	 */
> > > -	for (;;) {
> > > -		mutex_lock(&mgr->destroy_connector_lock);
> > > -		port = list_first_entry_or_null(&mgr->destroy_connector_list,
> > > struct drm_dp_mst_port, next);
> > > -		if (!port) {
> > > -			mutex_unlock(&mgr->destroy_connector_lock);
> > > -			break;
> > > +	do {
> > > +		go_again = false;
> > > +
> > > +		for (;;) {
> > > +			struct drm_dp_mst_branch *mstb;
> > > +
> > > +			mutex_lock(&mgr->delayed_destroy_lock);
> > > +			mstb = list_first_entry_or_null(&mgr-
> > > >destroy_branch_device_list,
> > > +							struct
> > > drm_dp_mst_branch,
> > > +							destroy_next);
> > > +			if (mstb)
> > > +				list_del(&mstb->destroy_next);
> > > +			mutex_unlock(&mgr->delayed_destroy_lock);
> > > +
> > > +			if (!mstb)
> > > +				break;
> > > +
> > > +			drm_dp_delayed_destroy_mstb(mstb);
> > > +			go_again = true;
> > >  		}
> > > -		list_del(&port->next);
> > > -		mutex_unlock(&mgr->destroy_connector_lock);
> > >  
> > > -		mgr->cbs->destroy_connector(mgr, port->connector);
> > > +		for (;;) {
> > > +			struct drm_dp_mst_port *port;
> > >  
> > > -		drm_dp_port_teardown_pdt(port, port->pdt);
> > > -		port->pdt = DP_PEER_DEVICE_NONE;
> > > +			mutex_lock(&mgr->delayed_destroy_lock);
> > > +			port = list_first_entry_or_null(&mgr-
> > > >destroy_port_list,
> > > +							struct
> > > drm_dp_mst_port,
> > > +							next);
> > > +			if (port)
> > > +				list_del(&port->next);
> > > +			mutex_unlock(&mgr->delayed_destroy_lock);
> > > +
> > > +			if (!port)
> > > +				break;
> > > +
> > > +			drm_dp_delayed_destroy_port(port);
> > > +			send_hotplug = true;
> > > +			go_again = true;
> > > +		}
> > > +	} while (go_again);
> > >  
> > > -		drm_dp_mst_put_port_malloc(port);
> > > -		send_hotplug = true;
> > > -	}
> > >  	if (send_hotplug)
> > >  		drm_kms_helper_hotplug_event(mgr->dev);
> > >  }
> > > @@ -3957,12 +4010,13 @@ int drm_dp_mst_topology_mgr_init(struct
> > > drm_dp_mst_topology_mgr *mgr,
> > >  	mutex_init(&mgr->lock);
> > >  	mutex_init(&mgr->qlock);
> > >  	mutex_init(&mgr->payload_lock);
> > > -	mutex_init(&mgr->destroy_connector_lock);
> > > +	mutex_init(&mgr->delayed_destroy_lock);
> > >  	INIT_LIST_HEAD(&mgr->tx_msg_downq);
> > > -	INIT_LIST_HEAD(&mgr->destroy_connector_list);
> > > +	INIT_LIST_HEAD(&mgr->destroy_port_list);
> > > +	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
> > >  	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
> > >  	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
> > > -	INIT_WORK(&mgr->destroy_connector_work,
> > > drm_dp_destroy_connector_work);
> > > +	INIT_WORK(&mgr->delayed_destroy_work, drm_dp_delayed_destroy_work);
> > >  	init_waitqueue_head(&mgr->tx_waitq);
> > >  	mgr->dev = dev;
> > >  	mgr->aux = aux;
> > > @@ -4005,7 +4059,7 @@ void drm_dp_mst_topology_mgr_destroy(struct
> > > drm_dp_mst_topology_mgr *mgr)
> > >  {
> > >  	drm_dp_mst_topology_mgr_set_mst(mgr, false);
> > >  	flush_work(&mgr->work);
> > > -	flush_work(&mgr->destroy_connector_work);
> > > +	cancel_work_sync(&mgr->delayed_destroy_work);
> > >  	mutex_lock(&mgr->payload_lock);
> > >  	kfree(mgr->payloads);
> > >  	mgr->payloads = NULL;
> > > diff --git a/include/drm/drm_dp_mst_helper.h
> > > b/include/drm/drm_dp_mst_helper.h
> > > index fc349204a71b..4a4507fe928d 100644
> > > --- a/include/drm/drm_dp_mst_helper.h
> > > +++ b/include/drm/drm_dp_mst_helper.h
> > > @@ -143,6 +143,12 @@ struct drm_dp_mst_branch {
> > >  	 */
> > >  	struct kref malloc_kref;
> > >  
> > > +	/**
> > > +	 * @destroy_next: linked-list entry used by
> > > +	 * drm_dp_delayed_destroy_work()
> > > +	 */
> > > +	struct list_head destroy_next;
> > > +
> > >  	u8 rad[8];
> > >  	u8 lct;
> > >  	int num_ports;
> > > @@ -575,18 +581,24 @@ struct drm_dp_mst_topology_mgr {
> > >  	struct work_struct tx_work;
> > >  
> > >  	/**
> > > -	 * @destroy_connector_list: List of to be destroyed connectors.
> > > +	 * @destroy_port_list: List of to be destroyed connectors.
> > > +	 */
> > > +	struct list_head destroy_port_list;
> > > +	/**
> > > +	 * @destroy_branch_device_list: List of to be destroyed branch
> > > +	 * devices.
> > >  	 */
> > > -	struct list_head destroy_connector_list;
> > > +	struct list_head destroy_branch_device_list;
> > >  	/**
> > > -	 * @destroy_connector_lock: Protects @connector_list.
> > > +	 * @delayed_destroy_lock: Protects @destroy_port_list and
> > > +	 * @destroy_branch_device_list.
> > >  	 */
> > > -	struct mutex destroy_connector_lock;
> > > +	struct mutex delayed_destroy_lock;
> > >  	/**
> > > -	 * @destroy_connector_work: Work item to destroy connectors. Needed to
> > > -	 * avoid locking inversion.
> > > +	 * @delayed_destroy_work: Work item to destroy MST port and branch
> > > +	 * devices, needed to avoid locking inversion.
> > >  	 */
> > > -	struct work_struct destroy_connector_work;
> > > +	struct work_struct delayed_destroy_work;
> > >  };
> > >  
> > >  int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
> > > -- 
> > > 2.21.0
> > > 
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
