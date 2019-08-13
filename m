Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9051BC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB9720840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y2DVy9bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfHMNBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:01:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44259 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbfHMNBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:01:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id a21so3997048edt.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jw7GBMJNYyFLID0p5XpWkfZoTmjEtuVkSfYWM++/WuI=;
        b=Y2DVy9bgxl3qr0tepAM0744yvZsjLyl6JZ7ja4E6hcgbHVaD21macVLLDp1FhpzuQk
         /bHjM8JUNPZwTp0dRnNGpBXTQnUOzZ6A9ERd1Fsi2U7RpVh5YHL/1jktLxgDQZCZTL5B
         B6XV1mxYaxcmgbWiewFYU9ZNJhA7/IzoyO3VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=jw7GBMJNYyFLID0p5XpWkfZoTmjEtuVkSfYWM++/WuI=;
        b=ALRDx8Iqp7cH4mJNQ3KNBcCzmiE8QlC/UIWJ9MYBzFKajGYOBtxWVglZmoXh77DSmN
         +l6WoPr8fg2S/EBDcdOdQ869ay9GJBW46V1HJBvpQsibQpJRel3HACnWs01Ay3hR/Hm6
         uJTab4m4rQoNCVY5c6op/uGWPPZQqnWQwkYIz0RgSe1qN8YZzbnkjbiLU+r+PVXaa3J4
         F0dvOiamoHcgRXkyII9jEggAuunXDhiiCes0YCt97bMPU87x4Za9e8LlhI49GD0dVRmz
         Bou3bszOFxDW7JdCWxpg+naI/7TRwapLuscr2BafRIktbXG8dtCnvLI10uhXEKllF997
         3P2Q==
X-Gm-Message-State: APjAAAVJU/jYEcwaf0ctuVa4zoqpTIoZTg2PjRYaEeIjEHF9OPCC6Yzw
        iH5ey0yqs5MewHt8hb56kb+IAw==
X-Google-Smtp-Source: APXvYqw4O18XMwypjF709hoyagj1Ar8BObPxYPF/G0+8do+OEeHR+HfazZ5Sges7vszfme1yHLYebA==
X-Received: by 2002:a50:cdd9:: with SMTP id h25mr13715067edj.231.1565701258942;
        Tue, 13 Aug 2019 06:00:58 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b15sm17954051ejp.7.2019.08.13.06.00.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 06:00:57 -0700 (PDT)
Date:   Tue, 13 Aug 2019 15:00:55 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/26] drm/dp_mst: Destroy mstbs from
 destroy_connector_work
Message-ID: <20190813130055.GS7444@phenom.ffwll.local>
Mail-Followup-To: Lyude Paul <lyude@redhat.com>,
        dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
References: <20190718014329.8107-1-lyude@redhat.com>
 <20190718014329.8107-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-3-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:25PM -0400, Lyude Paul wrote:
> Currently we remove MST branch devices from the in-memory topology
> immediately when their topology refcount reaches 0. This works just fine
> at the moment, but since we're about to add suspend/resume reprobing for
> MST topologies we're going to need to be able to travel through the
> topology and drop topology refs on branch devices while holding
> mgr->mutex. Since we currently can't do this due to the circular locking
> dependencies that would incur, move all of the actual work for
> drm_dp_destroy_mst_branch_device() into drm_dp_destroy_connector_work()
> so we can drop topology refs on MSTBs in any locking context.

Would be good to point at where exactly the problem is here, maybe also
mentioned the exact future patch that causes the problem. I did go look
around a bit, but didn't spot it.

> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 121 +++++++++++++++++---------
>  include/drm/drm_dp_mst_helper.h       |  10 +++
>  2 files changed, 90 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 998081b9b205..d7c3d9233834 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1108,34 +1108,17 @@ static void drm_dp_destroy_mst_branch_device(struct kref *kref)
>  	struct drm_dp_mst_branch *mstb =
>  		container_of(kref, struct drm_dp_mst_branch, topology_kref);
>  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> -	struct drm_dp_mst_port *port, *tmp;
> -	bool wake_tx = false;
> -
> -	mutex_lock(&mgr->lock);
> -	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> -		list_del(&port->next);
> -		drm_dp_mst_topology_put_port(port);
> -	}
> -	mutex_unlock(&mgr->lock);
> -
> -	/* drop any tx slots msg */
> -	mutex_lock(&mstb->mgr->qlock);
> -	if (mstb->tx_slots[0]) {
> -		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> -		mstb->tx_slots[0] = NULL;
> -		wake_tx = true;
> -	}
> -	if (mstb->tx_slots[1]) {
> -		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> -		mstb->tx_slots[1] = NULL;
> -		wake_tx = true;
> -	}
> -	mutex_unlock(&mstb->mgr->qlock);
>  
> -	if (wake_tx)
> -		wake_up_all(&mstb->mgr->tx_waitq);
> +	INIT_LIST_HEAD(&mstb->destroy_next);
>  
> -	drm_dp_mst_put_mstb_malloc(mstb);
> +	/*
> +	 * This can get called under mgr->mutex, so we need to perform the
> +	 * actual destruction of the mstb in another worker
> +	 */
> +	mutex_lock(&mgr->destroy_connector_lock);
> +	list_add(&mstb->destroy_next, &mgr->destroy_branch_device_list);
> +	mutex_unlock(&mgr->destroy_connector_lock);
> +	schedule_work(&mgr->destroy_connector_work);
>  }
>  
>  /**
> @@ -3618,10 +3601,56 @@ static void drm_dp_tx_work(struct work_struct *work)
>  	mutex_unlock(&mgr->qlock);
>  }
>  
> +static inline void
> +drm_dp_finish_destroy_port(struct drm_dp_mst_port *port)

Bikeshed: I'd call this _delayed_destroy, I think that makes a bit clearer
why there's 2 stages to destroying stuff.

> +{
> +	INIT_LIST_HEAD(&port->next);
> +
> +	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> +
> +	drm_dp_port_teardown_pdt(port, port->pdt);
> +	port->pdt = DP_PEER_DEVICE_NONE;
> +
> +	drm_dp_mst_put_port_malloc(port);
> +}
> +
> +static inline void
> +drm_dp_finish_destroy_mst_branch_device(struct drm_dp_mst_branch *mstb)
> +{
> +	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
> +	struct drm_dp_mst_port *port, *tmp;
> +	bool wake_tx = false;
> +
> +	mutex_lock(&mgr->lock);
> +	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> +		list_del(&port->next);
> +		drm_dp_mst_topology_put_port(port);
> +	}
> +	mutex_unlock(&mgr->lock);
> +
> +	/* drop any tx slots msg */
> +	mutex_lock(&mstb->mgr->qlock);
> +	if (mstb->tx_slots[0]) {
> +		mstb->tx_slots[0]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> +		mstb->tx_slots[0] = NULL;
> +		wake_tx = true;
> +	}
> +	if (mstb->tx_slots[1]) {
> +		mstb->tx_slots[1]->state = DRM_DP_SIDEBAND_TX_TIMEOUT;
> +		mstb->tx_slots[1] = NULL;
> +		wake_tx = true;
> +	}
> +	mutex_unlock(&mstb->mgr->qlock);
> +
> +	if (wake_tx)
> +		wake_up_all(&mstb->mgr->tx_waitq);
> +
> +	drm_dp_mst_put_mstb_malloc(mstb);
> +}
> +
>  static void drm_dp_destroy_connector_work(struct work_struct *work)
>  {
>  	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct drm_dp_mst_topology_mgr, destroy_connector_work);
> -	struct drm_dp_mst_port *port;
>  	bool send_hotplug = false;
>  	/*
>  	 * Not a regular list traverse as we have to drop the destroy
> @@ -3629,24 +3658,33 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
>  	 * ordering between this lock and the config mutex.
>  	 */
>  	for (;;) {
> +		struct drm_dp_mst_branch *mstb = NULL;
> +		struct drm_dp_mst_port *port = NULL;
> +
> +		/* Destroy any MSTBs first, and then their ports second */
>  		mutex_lock(&mgr->destroy_connector_lock);
> -		port = list_first_entry_or_null(&mgr->destroy_connector_list, struct drm_dp_mst_port, next);
> -		if (!port) {
> -			mutex_unlock(&mgr->destroy_connector_lock);
> -			break;
> +		mstb = list_first_entry_or_null(&mgr->destroy_branch_device_list,
> +						struct drm_dp_mst_branch,
> +						destroy_next);
> +		if (mstb) {
> +			list_del(&mstb->destroy_next);
> +		} else {
> +			port = list_first_entry_or_null(&mgr->destroy_connector_list,
> +							struct drm_dp_mst_port,
> +							next);
> +			if (port)
> +				list_del(&port->next);
>  		}

Control flow looks rather awkward here. I'd do either two loops, or if you
want to have just one, rename it to ->delayed_destroy_list and have a
->delayed_destry_cb next to it?

Cheers, Daniel


> -		list_del(&port->next);
>  		mutex_unlock(&mgr->destroy_connector_lock);
>  
> -		INIT_LIST_HEAD(&port->next);
> -
> -		mgr->cbs->destroy_connector(mgr, port->connector);
> -
> -		drm_dp_port_teardown_pdt(port, port->pdt);
> -		port->pdt = DP_PEER_DEVICE_NONE;
> -
> -		drm_dp_mst_put_port_malloc(port);
> -		send_hotplug = true;
> +		if (mstb) {
> +			drm_dp_finish_destroy_mst_branch_device(mstb);
> +		} else if (port) {
> +			drm_dp_finish_destroy_port(port);
> +			send_hotplug = true;
> +		} else {
> +			break;
> +		}
>  	}
>  	if (send_hotplug)
>  		drm_kms_helper_hotplug_event(mgr->dev);
> @@ -3840,6 +3878,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	mutex_init(&mgr->destroy_connector_lock);
>  	INIT_LIST_HEAD(&mgr->tx_msg_downq);
>  	INIT_LIST_HEAD(&mgr->destroy_connector_list);
> +	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
>  	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
>  	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
>  	INIT_WORK(&mgr->destroy_connector_work, drm_dp_destroy_connector_work);
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 8c97a5f92c47..c01f3ea72756 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -143,6 +143,12 @@ struct drm_dp_mst_branch {
>  	 */
>  	struct kref malloc_kref;
>  
> +	/**
> +	 * @destroy_next: linked-list entry used by
> +	 * drm_dp_destroy_connector_work()
> +	 */
> +	struct list_head destroy_next;
> +
>  	u8 rad[8];
>  	u8 lct;
>  	int num_ports;
> @@ -578,6 +584,10 @@ struct drm_dp_mst_topology_mgr {
>  	 * @destroy_connector_list: List of to be destroyed connectors.
>  	 */
>  	struct list_head destroy_connector_list;
> +	/**
> +	 * @destroy_branch_device_list: List of to be destroyed branch devices
> +	 */
> +	struct list_head destroy_branch_device_list;
>  	/**
>  	 * @destroy_connector_lock: Protects @connector_list.
>  	 */
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
