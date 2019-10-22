Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B433CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C266206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="J2hDa3zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389164AbfJVQGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:06:12 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35158 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJVQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:06:12 -0400
Received: by mail-yb1-f194.google.com with SMTP id i6so5323812ybe.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bwgr+rqmf2GPcbT6DM6Ipa2S+dVQ2+5OQFLv1xu+H8U=;
        b=J2hDa3zoq63+rpZps81zIpf89gYmvt7v0Jw6BSzmzPST6dX8GstYfPC3JIc+vo2mlh
         UD05kRp2HplWTNPtiwSaMNEb25/vD5Dci+reJ/zKr2ubStsy/cxj2NKe/jwISrJSi7RV
         2TG7LgM/loO/sPbpwc783OwM7JQKnRalI/NRGsL9WqUaGy+Fy5Hovhxfqm9u5SObliv5
         azEX/Dx+BbUMLNxlYpGcl2wHK3e0VtHrwrhA+aOOWL9KuJtDPPzYhZb0Sydfe1PzfAG+
         /ZWc5gBt07Ccp7qRyR4MzeVKHBkB3CX+00b6+2e33H7MGukvKLO8BIJmz0l07gNfUFWJ
         AjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bwgr+rqmf2GPcbT6DM6Ipa2S+dVQ2+5OQFLv1xu+H8U=;
        b=UqZwLMoyz6IM7/BBlbJfkbIIaQZ2d3Yyzg7UrTp+kxQ0Dw4Y6r6FOMaxHJ5OrENPuM
         lgwJ1nJMphlE6Dvjyv59FzYGdyvyUpZyksEVU5CR2Ijd6JKOxe+lL4fEExXJwbvTpXLs
         9T3AdjPya8xZ0z/eZ37YiLsDMWpmxaPGWznqNQhPFnDqy7eM0dbaWTiUFWloN9L0mMrz
         9F0eovmTdS2Zek80Btca7xKiGg9gFjlVQKbdjkBPU7Gp0uNqLzZqwBLOQSkX5d8+481o
         lVKXC/iP36A3NeqpSyIjAdV0KBfBpGQqzzJI0jd2+Dd3pgo/Up97xBDw8nA8yFut+sIG
         5QEQ==
X-Gm-Message-State: APjAAAXMQRWvqj72aLAbmXVT0ZJvRbG0QjSVfBpTBVs4yTnQNdQ8+jkP
        SOG7Jl1okF32wiIdw16bTv3exQ==
X-Google-Smtp-Source: APXvYqwjracvyedWg9G1Yk3dJQzWi1eG+jHhwwmb2xEWgVKhe9d9sYRqBjKFbFZe50QcwreeeQZcfw==
X-Received: by 2002:a25:df47:: with SMTP id w68mr3201109ybg.476.1571760370837;
        Tue, 22 Oct 2019 09:06:10 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id u67sm4281780ywf.44.2019.10.22.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 09:06:10 -0700 (PDT)
Date:   Tue, 22 Oct 2019 12:06:09 -0400
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
Subject: Re: [PATCH v5 05/14] drm/dp_mst: Add probe_lock
Message-ID: <20191022160609.GE85762@art_vandelay>
References: <20191022023641.8026-1-lyude@redhat.com>
 <20191022023641.8026-6-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022023641.8026-6-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:36:00PM -0400, Lyude Paul wrote:
> Currently, MST lacks locking in a lot of places that really should have
> some sort of locking. Hotplugging and link address code paths are some
> of the offenders here, as there is actually nothing preventing us from
> running a link address probe while at the same time handling a
> connection status update request - something that's likely always been
> possible but never seen in the wild because hotplugging has been broken
> for ages now (with the exception of amdgpu, for reasons I don't think
> are worth digging into very far).
> 
> Note: I'm going to start using the term "in-memory topology layout" here
> to refer to drm_dp_mst_port->mstb and drm_dp_mst_branch->ports.
> 
> Locking in these places is a little tougher then it looks though.
> Generally we protect anything having to do with the in-memory topology
> layout under &mgr->lock. But this becomes nearly impossible to do from
> the context of link address probes due to the fact that &mgr->lock is
> usually grabbed under random various modesetting locks, meaning that
> there's no way we can just invert the &mgr->lock order and keep it
> locked throughout the whole process of updating the topology.
> 
> Luckily there are only two workers which can modify the in-memory
> topology layout: drm_dp_mst_up_req_work() and
> drm_dp_mst_link_probe_work(), meaning as long as we prevent these two
> workers from traveling the topology layout in parallel with the intent
> of updating it we don't need to worry about grabbing &mgr->lock in these
> workers for reads. We only need to grab &mgr->lock in these workers for
> writes, so that readers outside these two workers are still protected
> from the topology layout changing beneath them.
> 
> So, add the new &mgr->probe_lock and use it in both
> drm_dp_mst_link_probe_work() and drm_dp_mst_up_req_work(). Additionally,
> add some more detailed explanations for how this locking is intended to
> work to drm_dp_mst_port->mstb and drm_dp_mst_branch->ports.

This seems like a good solution to me, thanks for working this through!

Any chance we could add a WARN_ON(!mutex_is_locked(&mgr->probe_lock)); somewhere
centrally called by all paths modifying the in-memory topology layout?
drm_dp_add_port perhaps? That way we have a fallback in case something else
starts mucking with the topology.

Other than that,

Reviewed-by: Sean Paul <sean@poorly.run>


> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Sean Paul <sean@poorly.run>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 28 ++++++++++++++---------
>  include/drm/drm_dp_mst_helper.h       | 32 +++++++++++++++++++++++----
>  2 files changed, 46 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 08c316a727df..11d842f0bff5 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2147,37 +2147,40 @@ static void drm_dp_check_and_send_link_address(struct drm_dp_mst_topology_mgr *m
>  					       struct drm_dp_mst_branch *mstb)
>  {
>  	struct drm_dp_mst_port *port;
> -	struct drm_dp_mst_branch *mstb_child;
> +
>  	if (!mstb->link_address_sent)
>  		drm_dp_send_link_address(mgr, mstb);
>  
>  	list_for_each_entry(port, &mstb->ports, next) {
> -		if (port->input)
> -			continue;
> +		struct drm_dp_mst_branch *mstb_child = NULL;
>  
> -		if (!port->ddps)
> +		if (port->input || !port->ddps)
>  			continue;
>  
>  		if (!port->available_pbn)
>  			drm_dp_send_enum_path_resources(mgr, mstb, port);
>  
> -		if (port->mstb) {
> +		if (port->mstb)
>  			mstb_child = drm_dp_mst_topology_get_mstb_validated(
>  			    mgr, port->mstb);
> -			if (mstb_child) {
> -				drm_dp_check_and_send_link_address(mgr, mstb_child);
> -				drm_dp_mst_topology_put_mstb(mstb_child);
> -			}
> +
> +		if (mstb_child) {
> +			drm_dp_check_and_send_link_address(mgr, mstb_child);
> +			drm_dp_mst_topology_put_mstb(mstb_child);
>  		}
>  	}
>  }
>  
>  static void drm_dp_mst_link_probe_work(struct work_struct *work)
>  {
> -	struct drm_dp_mst_topology_mgr *mgr = container_of(work, struct drm_dp_mst_topology_mgr, work);
> +	struct drm_dp_mst_topology_mgr *mgr =
> +		container_of(work, struct drm_dp_mst_topology_mgr, work);
> +	struct drm_device *dev = mgr->dev;
>  	struct drm_dp_mst_branch *mstb;
>  	int ret;
>  
> +	mutex_lock(&mgr->probe_lock);
> +
>  	mutex_lock(&mgr->lock);
>  	mstb = mgr->mst_primary;
>  	if (mstb) {
> @@ -2190,6 +2193,7 @@ static void drm_dp_mst_link_probe_work(struct work_struct *work)
>  		drm_dp_check_and_send_link_address(mgr, mstb);
>  		drm_dp_mst_topology_put_mstb(mstb);
>  	}
> +	mutex_unlock(&mgr->probe_lock);
>  }
>  
>  static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
> @@ -3313,6 +3317,7 @@ static void drm_dp_mst_up_req_work(struct work_struct *work)
>  			     up_req_work);
>  	struct drm_dp_pending_up_req *up_req;
>  
> +	mutex_lock(&mgr->probe_lock);
>  	while (true) {
>  		mutex_lock(&mgr->up_req_lock);
>  		up_req = list_first_entry_or_null(&mgr->up_req_list,
> @@ -3328,6 +3333,7 @@ static void drm_dp_mst_up_req_work(struct work_struct *work)
>  		drm_dp_mst_process_up_req(mgr, up_req);
>  		kfree(up_req);
>  	}
> +	mutex_unlock(&mgr->probe_lock);
>  }
>  
>  static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
> @@ -4349,6 +4355,7 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
>  	mutex_init(&mgr->payload_lock);
>  	mutex_init(&mgr->delayed_destroy_lock);
>  	mutex_init(&mgr->up_req_lock);
> +	mutex_init(&mgr->probe_lock);
>  	INIT_LIST_HEAD(&mgr->tx_msg_downq);
>  	INIT_LIST_HEAD(&mgr->destroy_port_list);
>  	INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
> @@ -4414,6 +4421,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_mst_topology_mgr *mgr)
>  	mutex_destroy(&mgr->qlock);
>  	mutex_destroy(&mgr->lock);
>  	mutex_destroy(&mgr->up_req_lock);
> +	mutex_destroy(&mgr->probe_lock);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_destroy);
>  
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 7d80c38ee00e..bccb5514e0ef 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -55,8 +55,6 @@ struct drm_dp_vcpi {
>   * @num_sdp_stream_sinks: Number of stream sinks
>   * @available_pbn: Available bandwidth for this port.
>   * @next: link to next port on this branch device
> - * @mstb: branch device on this port, protected by
> - * &drm_dp_mst_topology_mgr.lock
>   * @aux: i2c aux transport to talk to device connected to this port, protected
>   * by &drm_dp_mst_topology_mgr.lock
>   * @parent: branch device parent of this port
> @@ -92,7 +90,17 @@ struct drm_dp_mst_port {
>  	u8 num_sdp_stream_sinks;
>  	uint16_t available_pbn;
>  	struct list_head next;
> -	struct drm_dp_mst_branch *mstb; /* pointer to an mstb if this port has one */
> +	/**
> +	 * @mstb: the branch device connected to this port, if there is one.
> +	 * This should be considered protected for reading by
> +	 * &drm_dp_mst_topology_mgr.lock. There are two exceptions to this:
> +	 * &drm_dp_mst_topology_mgr.up_req_work and
> +	 * &drm_dp_mst_topology_mgr.work, which do not grab
> +	 * &drm_dp_mst_topology_mgr.lock during reads but are the only
> +	 * updaters of this list and are protected from writing concurrently
> +	 * by &drm_dp_mst_topology_mgr.probe_lock.
> +	 */
> +	struct drm_dp_mst_branch *mstb;
>  	struct drm_dp_aux aux; /* i2c bus for this port? */
>  	struct drm_dp_mst_branch *parent;
>  
> @@ -118,7 +126,6 @@ struct drm_dp_mst_port {
>   * @lct: Link count total to talk to this branch device.
>   * @num_ports: number of ports on the branch.
>   * @msg_slots: one bit per transmitted msg slot.
> - * @ports: linked list of ports on this branch.
>   * @port_parent: pointer to the port parent, NULL if toplevel.
>   * @mgr: topology manager for this branch device.
>   * @tx_slots: transmission slots for this device.
> @@ -156,6 +163,16 @@ struct drm_dp_mst_branch {
>  	int num_ports;
>  
>  	int msg_slots;
> +	/**
> +	 * @ports: the list of ports on this branch device. This should be
> +	 * considered protected for reading by &drm_dp_mst_topology_mgr.lock.
> +	 * There are two exceptions to this:
> +	 * &drm_dp_mst_topology_mgr.up_req_work and
> +	 * &drm_dp_mst_topology_mgr.work, which do not grab
> +	 * &drm_dp_mst_topology_mgr.lock during reads but are the only
> +	 * updaters of this list and are protected from updating the list
> +	 * concurrently by @drm_dp_mst_topology_mgr.probe_lock
> +	 */
>  	struct list_head ports;
>  
>  	/* list of tx ops queue for this port */
> @@ -502,6 +519,13 @@ struct drm_dp_mst_topology_mgr {
>  	 */
>  	struct mutex lock;
>  
> +	/**
> +	 * @probe_lock: Prevents @work and @up_req_work, the only writers of
> +	 * &drm_dp_mst_port.mstb and &drm_dp_mst_branch.ports, from racing
> +	 * while they update the topology.
> +	 */
> +	struct mutex probe_lock;
> +
>  	/**
>  	 * @mst_state: If this manager is enabled for an MST capable port. False
>  	 * if no MST sink/branch devices is connected.
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
