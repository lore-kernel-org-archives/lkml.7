Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12656C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B953E21D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="O5GajiOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392426AbfIYTqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:46:30 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41628 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392320AbfIYTqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:46:30 -0400
Received: by mail-yw1-f68.google.com with SMTP id 129so2509893ywb.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pbuUV2hx7Rik9Lm7SNX8XB2T5YzP6vA1VmFbIs8M8O8=;
        b=O5GajiOZUHA/3RuTCOczZNVNzXfJ3vBjc0g6Z/6CmCheA8hsMEi1JkGzw3ZFQ8j0uK
         J57S+74SuFEgjJRgaBKkSYdVKfy8ecuXE3ZYrYACwUroekgHdjd9vX/FYpXv/gdUNGD5
         EX7djDmJAQwr4PK/6rPhJGrs9iPETJqXMLAypjqLjoXS9LMtiPmMzJ7HdiS9AcDnaEyK
         x26GVyvrxHwjDmj9cyI3uGnBlmIBuYhVq6ubYhJ4fsOOnS8FnXwYjqK9uXfKlGI+W62B
         OjK1ctNZ/MsxS/oIMdSrDE/kHJCq6tJ9R4g/+UWaq7WbNkY92OwwawPm+d3Mzn0Wpt3c
         3RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pbuUV2hx7Rik9Lm7SNX8XB2T5YzP6vA1VmFbIs8M8O8=;
        b=mCvFhmzHrO+R2Amd/LGZDwJ7dP4ffJFxEp2ljp2Vy4D3U+k4MZy50Ql5GEmE8VnJdW
         hTjLPj1rVOlmL1440Js0WBwcQz/u9kUOujWb6g946wkKufQoJRDAla5Vqjbr/3y7Q3sT
         2cpPqdkSTTGnPn3Id6ufHgXPDR7TiO/oXqGpFv9/VOzi1b406q7YKLr/tysmM73LFKMh
         9/IHOqaL9DIqqgSy8Xw0jBVb4N72x/l187DLreQ3sOcgnUPzHTQ40wTsnQp1BRm4rT0G
         eSmWKwK/ilQwR7Bbhjxrjq15gGg8LSLjQx14/lltgoXNYbAYQWefLLBa6guK3cCG0vAb
         jYyA==
X-Gm-Message-State: APjAAAXz6QEjXibGCfol1hjNg0tOYuMMPsx/gelCHv8luZWbwx1E6zLY
        S4HtrsJRsLIrA8fZsxqIJ8f7yw==
X-Google-Smtp-Source: APXvYqx8RoT5D6JxeJHqqW3Ducfrt5RkkJpOQimRtdsRUAxVEL+n+QF7VSizrM2Edfc3dtSSw7HbwA==
X-Received: by 2002:a81:6ec5:: with SMTP id j188mr6887217ywc.365.1569440787628;
        Wed, 25 Sep 2019 12:46:27 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id l188sm1423718ywl.29.2019.09.25.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 12:46:27 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:46:26 -0400
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
Subject: Re: [PATCH v2 19/27] drm/dp_mst: Handle UP requests asynchronously
Message-ID: <20190925194626.GK218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-20-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-20-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:57PM -0400, Lyude Paul wrote:
> Once upon a time, hotplugging devices on MST branches actually worked in
> DRM. Now, it only works in amdgpu (likely because of how it's hotplug
> handlers are implemented). On both i915 and nouveau, hotplug
> notifications from MST branches are noticed - but trying to respond to
> them causes messaging timeouts and causes the whole topology state to go
> out of sync with reality, usually resulting in the user needing to
> replug the entire topology in hopes that it actually fixes things.
> 
> The reason for this is because the way we currently handle UP requests
> in MST is completely bogus. drm_dp_mst_handle_up_req() is called from
> drm_dp_mst_hpd_irq(), which is usually called from the driver's hotplug
> handler. Because we handle sending the hotplug event from this function,
> we actually cause the driver's hotplug handler (and in turn, all
> sideband transactions) to block on
> drm_device->mode_config.connection_mutex. This makes it impossible to
> send any sideband messages from the driver's connector probing
> functions, resulting in the aforementioned sideband message timeout.
> 
> There's even more problems with this beyond breaking hotplugging on MST
> branch devices. It also makes it almost impossible to protect
> drm_dp_mst_port struct members under a lock because we then have to
> worry about dealing with all of the lock dependency issues that ensue.
> 
> So, let's finally actually fix this issue by handling the processing of
> up requests asyncronously. This way we can send sideband messages from
> most contexts without having to deal with getting blocked if we hold
> connection_mutex. This also fixes MST branch device hotplugging on i915,
> finally!
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Looks really good!

Reviewed-by: Sean Paul <sean@poorly.run>


> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 146 +++++++++++++++++++-------
>  include/drm/drm_dp_mst_helper.h       |  16 +++
>  2 files changed, 122 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index cfaf9eb7ace9..5101eeab4485 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -46,6 +46,12 @@
>   * protocol. The helpers contain a topology manager and bandwidth manager.
>   * The helpers encapsulate the sending and received of sideband msgs.
>   */
> +struct drm_dp_pending_up_req {
> +	struct drm_dp_sideband_msg_hdr hdr;
> +	struct drm_dp_sideband_msg_req_body msg;
> +	struct list_head next;
> +};
> +
>  static bool dump_dp_payload_table(struct drm_dp_mst_topology_mgr *mgr,
>  				  char *buf);
>  
> @@ -3109,6 +3115,7 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr)
>  	drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
>  			   DP_MST_EN | DP_UPSTREAM_IS_SRC);
>  	mutex_unlock(&mgr->lock);
> +	flush_work(&mgr->up_req_work);
>  	flush_work(&mgr->work);
>  	flush_work(&mgr->delayed_destroy_work);
>  }
> @@ -3281,12 +3288,70 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
>  	return 0;
>  }
>  
> +static inline void
> +drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
> +			  struct drm_dp_pending_up_req *up_req)
> +{
> +	struct drm_dp_mst_branch *mstb = NULL;
> +	struct drm_dp_sideband_msg_req_body *msg = &up_req->msg;
> +	struct drm_dp_sideband_msg_hdr *hdr = &up_req->hdr;
> +
> +	if (hdr->broadcast) {
> +		const u8 *guid = NULL;
> +
> +		if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY)
> +			guid = msg->u.conn_stat.guid;
> +		else if (msg->req_type == DP_RESOURCE_STATUS_NOTIFY)
> +			guid = msg->u.resource_stat.guid;
> +
> +		mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
> +	} else {
> +		mstb = drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
> +	}
> +
> +	if (!mstb) {
> +		DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
> +			      hdr->lct);
> +		return;
> +	}
> +
> +	/* TODO: Add missing handler for DP_RESOURCE_STATUS_NOTIFY events */
> +	if (msg->req_type == DP_CONNECTION_STATUS_NOTIFY) {
> +		drm_dp_mst_handle_conn_stat(mstb, &msg->u.conn_stat);
> +		drm_kms_helper_hotplug_event(mgr->dev);
> +	}
> +
> +	drm_dp_mst_topology_put_mstb(mstb);
> +}
> +
> +static void drm_dp_mst_up_req_work(struct work_struct *work)
> +{
> +	struct drm_dp_mst_topology_mgr *mgr =
> +		container_of(work, struct drm_dp_mst_topology_mgr,
> +			     up_req_work);
> +	struct drm_dp_pending_up_req *up_req;
> +
> +	while (true) {
> +		mutex_lock(&mgr->up_req_lock);
> +		up_req = list_first_entry_or_null(&mgr->up_req_list,
> +						  struct drm_dp_pending_up_req,
> +						  next);
> +		if (up_req)
> +			list_del(&up_req->next);
> +		mutex_unlock(&mgr->up_req_lock);
> +
> +		if (!up_req)
> +			break;
> +
> +		drm_dp_mst_process_up_req(mgr, up_req);
> +		kfree(up_req);
> +	}
> +}
> +
>  static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>  {
> -	struct drm_dp_sideband_msg_req_body msg;
>  	struct drm_dp_sideband_msg_hdr *hdr = &mgr->up_req_recv.initial_hdr;
> -	struct drm_dp_mst_branch *mstb = NULL;
> -	const u8 *guid;
> +	struct drm_dp_pending_up_req *up_req;
>  	bool seqno;
>  
>  	if (!drm_dp_get_one_sb_msg(mgr, true))
> @@ -3295,56 +3360,53 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>  	if (!mgr->up_req_recv.have_eomt)
>  		return 0;
>  
> -	if (!hdr->broadcast) {
> -		mstb = drm_dp_get_mst_branch_device(mgr, hdr->lct, hdr->rad);
> -		if (!mstb) {
> -			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
> -				      hdr->lct);
> -			goto out;
> -		}
> +	up_req = kzalloc(sizeof(*up_req), GFP_KERNEL);
> +	if (!up_req) {
> +		DRM_ERROR("Not enough memory to process MST up req\n");
> +		return -ENOMEM;
>  	}
> +	INIT_LIST_HEAD(&up_req->next);
>  
>  	seqno = hdr->seqno;
> -	drm_dp_sideband_parse_req(&mgr->up_req_recv, &msg);
> +	drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
>  
> -	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY)
> -		guid = msg.u.conn_stat.guid;
> -	else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY)
> -		guid = msg.u.resource_stat.guid;
> -	else
> +	if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
> +	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
> +		DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
> +			      up_req->msg.req_type);
> +		kfree(up_req);
>  		goto out;
> -
> -	drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno,
> -				 false);
> -
> -	if (!mstb) {
> -		mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
> -		if (!mstb) {
> -			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n",
> -				      hdr->lct);
> -			goto out;
> -		}
>  	}
>  
> -	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
> -		drm_dp_mst_handle_conn_stat(mstb, &msg.u.conn_stat);
> +	drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, up_req->msg.req_type,
> +				 seqno, false);
> +
> +	if (up_req->msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
> +		const struct drm_dp_connection_status_notify *conn_stat =
> +			&up_req->msg.u.conn_stat;
>  
>  		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
> -			      msg.u.conn_stat.port_number,
> -			      msg.u.conn_stat.legacy_device_plug_status,
> -			      msg.u.conn_stat.displayport_device_plug_status,
> -			      msg.u.conn_stat.message_capability_status,
> -			      msg.u.conn_stat.input_port,
> -			      msg.u.conn_stat.peer_device_type);
> +			      conn_stat->port_number,
> +			      conn_stat->legacy_device_plug_status,
> +			      conn_stat->displayport_device_plug_status,
> +			      conn_stat->message_capability_status,
> +			      conn_stat->input_port,
> +			      conn_stat->peer_device_type);
> +	} else if (up_req->msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
> +		const struct drm_dp_resource_status_notify *res_stat =
> +			&up_req->msg.u.resource_stat;
>  
> -		drm_kms_helper_hotplug_event(mgr->dev);
> -	} else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
>  		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
> -			      msg.u.resource_stat.port_number,
> -			      msg.u.resource_stat.available_pbn);
> +			      res_stat->port_number,
> +			      res_stat->available_pbn);
>  	}
>  
> -	drm_dp_mst_topology_put_mstb(mstb);
> +	up_req->hdr = *hdr;
> +	mutex_lock(&mgr->up_req_lock);
> +	list_add_tail(&up_req->next, &mgr->up_req_list);
> +	mutex_unlock(&mgr->up_req_lock);
> +	queue_work(system_long_wq, &mgr->up_req_work);
> +
>  out:
>  	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
>  	return 0;
> @@ -4320,12 +4382,15 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	mutex_init(&mgr->qlock);
>  	mutex_init(&mgr->payload_lock);
>  	mutex_init(&mgr->delayed_destroy_lock);
> +	mutex_init(&mgr->up_req_lock);
>  	INIT_LIST_HEAD(&mgr->tx_msg_downq);
>  	INIT_LIST_HEAD(&mgr->destroy_port_list);
>  	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
> +	INIT_LIST_HEAD(&mgr->up_req_list);
>  	INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
>  	INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
>  	INIT_WORK(&mgr->delayed_destroy_work, drm_dp_delayed_destroy_work);
> +	INIT_WORK(&mgr->up_req_work, drm_dp_mst_up_req_work);
>  	init_waitqueue_head(&mgr->tx_waitq);
>  	mgr->dev = dev;
>  	mgr->aux = aux;
> @@ -4382,6 +4447,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
>  	mutex_destroy(&mgr->payload_lock);
>  	mutex_destroy(&mgr->qlock);
>  	mutex_destroy(&mgr->lock);
> +	mutex_destroy(&mgr->up_req_lock);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
>  
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 8ba2a01324bb..7d80c38ee00e 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -597,6 +597,22 @@ struct drm_dp_mst_topology_mgr {
>  	 * devices, needed to avoid locking inversion.
>  	 */
>  	struct work_struct delayed_destroy_work;
> +
> +	/**
> +	 * @up_req_list: List of pending up requests from the topology that
> +	 * need to be processed, in chronological order.
> +	 */
> +	struct list_head up_req_list;
> +	/**
> +	 * @up_req_lock: Protects @up_req_list
> +	 */
> +	struct mutex up_req_lock;
> +	/**
> +	 * @up_req_work: Work item to process up requests received from the
> +	 * topology. Needed to avoid blocking hotplug handling and sideband
> +	 * transmissions.
> +	 */
> +	struct work_struct up_req_work;
>  };
>  
>  int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
