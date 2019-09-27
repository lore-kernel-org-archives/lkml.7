Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5E6C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B04217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="KcPOWZUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfI0NwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 09:52:10 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34907 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfI0NwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 09:52:09 -0400
Received: by mail-yw1-f68.google.com with SMTP id r134so920948ywg.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 06:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=h29ZLPtTrnlEGihpamSr90EBV0Vyvg/2iUfpSQon3sI=;
        b=KcPOWZUZe+bFeRJI7lemgWYm+puSDTm22eyj1t9oXuEtpJPUfe3fTqDqjsZdedVdM6
         0IOdpJ+T03Lp/7ic51zf64xeEg9bHQ30Xv2+/PydX6YYPJ9Mx6oHPluA3QGEK5T8clCB
         YumtaHxm/XJlEUvwQcWK6evBQtOwO1ubaeVSYhoDkJ2gZ7xhVDES8cxT2kSr2dupwrHs
         JLfgVoGVsftzof2I33PpwTpqyjUudH71rd8/BQ+WBZNtBxDvyFadFKveIpIMfFs2hS6Z
         4446DoHMdbDMa95IlT0rA2G0bF5jOuU4Cfp5Y89U1ngw4f+sRPAHA1qD5Ef/ZVwhG2Yt
         H87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=h29ZLPtTrnlEGihpamSr90EBV0Vyvg/2iUfpSQon3sI=;
        b=MKCmb2axj+JxpkG5ZvueqbuHYfgj4YxNbbut/4SBpv+QEcKRGFcUj8e6VZ5/GIjOvw
         P//BoU8iONSwGYiqChX0dkLPRD1Ru9m103UP/DVJ6B3+mrjbPkQuI2k5o/fo8CUD7M+v
         zECrdRVvqfLZMe6Pec954taSlbORmG5LZFzJJN9FtGhb9GgGwzhHKJS3GuvSeRoyoroQ
         0M0MS8eGnL+GhkFOcoPfv0Ul7VctD1xQ7O+2c/jez5J050akklXO54ZwGjffv+ryldMh
         fF9vRiWUmHDEotI6HXV8+wv2drSCUxKfPEw+bnPpW2QNWLUXMafCHCX5/eFnNvDOpHoI
         2XOA==
X-Gm-Message-State: APjAAAVGq6mYPOwBjmbJOl7MmpyHVRPBe9SUYfd4dTpZpTRa39fe07u+
        KybPzuXL6E8ONpHyIYwjQj5JNw==
X-Google-Smtp-Source: APXvYqzfFjIsSg818gzHNW4C6ZqtEgTgN0+2eZ6FE8PL5ycB0Cem1R5QEIS4r8eBIwwW/cYg/tAWCw==
X-Received: by 2002:a0d:e194:: with SMTP id k142mr2828821ywe.202.1569592328615;
        Fri, 27 Sep 2019 06:52:08 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id r193sm607571ywg.38.2019.09.27.06.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 06:52:07 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:52:07 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        David Francis <David.Francis@amd.com>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Manasi Navare <manasi.d.navare@intel.com>,
        Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
        =?iso-8859-1?Q?Jos=E9?= Roberto de Souza 
        <jose.souza@intel.com>, Karol Herbst <karolherbst@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2 25/27] drm/dp_mst: Add basic topology reprobing when
 resuming
Message-ID: <20190927135207.GR218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-26-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-26-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:46:03PM -0400, Lyude Paul wrote:
> Finally! For a very long time, our MST helpers have had one very
> annoying issue: They don't know how to reprobe the topology state when
> coming out of suspend. This means that if a user has a machine connected
> to an MST topology and decides to suspend their machine, we lose all
> topology changes that happened during that period. That can be a big
> problem if the machine was connected to a different topology on the same
> port before resuming, as we won't bother reprobing any of the ports and
> likely cause the user's monitors not to come back up as expected.
> 
> So, we start fixing this by teaching our MST helpers how to reprobe the
> link addresses of each connected topology when resuming. As it turns
> out, the behavior that we want here is identical to the behavior we want
> when initially probing a newly connected MST topology, with a couple of
> important differences:
> 
> - We need to be more careful about handling the potential races between
>   events from the MST hub that could change the topology state as we're
>   performing the link address reprobe
> - We need to be more careful about handling unlikely state changes on
>   ports - such as an input port turning into an output port, something
>   that would be far more likely to happen in situations like the MST hub
>   we're connected to being changed while we're suspend
> 
> Both of which have been solved by previous commits. That leaves one
> requirement:
> 
> - We need to prune any MST ports in our in-memory topology state that
>   were present when suspending, but have not appeared in the post-resume
>   link address response from their parent branch device
> 
> Which we can now handle in this commit by modifying
> drm_dp_send_link_address(). We then introduce suspend/resume reprobing
> by introducing drm_dp_mst_topology_mgr_invalidate_mstb(), which we call
> in drm_dp_mst_topology_mgr_suspend() to traverse the in-memory topology
> state to indicate that each mstb needs it's link address resent and PBN
> resources reprobed.
> 
> On resume, we start back up &mgr->work and have it reprobe the topology
> in the same way we would on a hotplug, removing any leftover ports that
> no longer appear in the topology state.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
>  drivers/gpu/drm/drm_dp_mst_topology.c         | 138 +++++++++++++-----
>  drivers/gpu/drm/i915/display/intel_dp.c       |   3 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c       |   6 +-
>  include/drm/drm_dp_mst_helper.h               |   3 +-
>  5 files changed, 112 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 4d3c8bff77da..27ee3e045b86 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -973,7 +973,7 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
>  		if (suspend) {
>  			drm_dp_mst_topology_mgr_suspend(mgr);
>  		} else {
> -			ret = drm_dp_mst_topology_mgr_resume(mgr);
> +			ret = drm_dp_mst_topology_mgr_resume(mgr, true);
>  			if (ret < 0) {
>  				drm_dp_mst_topology_mgr_set_mst(mgr, false);
>  				need_hotplug = true;
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index e407aba1fbd2..2fe24e366925 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2020,6 +2020,14 @@ drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
>  		goto fail_unlock;
>  	}
>  
> +	/*
> +	 * If this port wasn't just created, then we're reprobing because
> +	 * we're coming out of suspend. In this case, always resend the link
> +	 * address if there's an MSTB on this port
> +	 */
> +	if (!created && port->pdt == DP_PEER_DEVICE_MST_BRANCHING)
> +		send_link_addr = true;
> +
>  	if (send_link_addr) {
>  		mutex_lock(&mgr->lock);
>  		if (port->mstb) {
> @@ -2530,7 +2538,8 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_link_address_ack_reply *reply;
> -	int i, len, ret;
> +	struct drm_dp_mst_port *port, *tmp;
> +	int i, len, ret, port_mask = 0;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>  	if (!txmsg)
> @@ -2560,9 +2569,28 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  
>  	drm_dp_check_mstb_guid(mstb, reply->guid);
>  
> -	for (i = 0; i < reply->nports; i++)
> +	for (i = 0; i < reply->nports; i++) {
> +		port_mask |= BIT(reply->ports[i].port_number);
>  		drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
>  						    &reply->ports[i]);
> +	}
> +
> +	/* Prune any ports that are currently a part of mstb in our in-memory
> +	 * topology, but were not seen in this link address. Usually this
> +	 * means that they were removed while the topology was out of sync,
> +	 * e.g. during suspend/resume
> +	 */
> +	mutex_lock(&mgr->lock);
> +	list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
> +		if (port_mask & BIT(port->port_num))
> +			continue;
> +
> +		DRM_DEBUG_KMS("port %d was not in link address, removing\n",
> +			      port->port_num);
> +		list_del(&port->next);
> +		drm_dp_mst_topology_put_port(port);
> +	}
> +	mutex_unlock(&mgr->lock);
>  
>  	drm_kms_helper_hotplug_event(mgr->dev);
>  
> @@ -3191,6 +3219,23 @@ int drm_dp_mst_topology_mgr_set_mst(struct drm_dp_mst_topology_mgr *mgr, bool ms
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_set_mst);
>  
> +static void
> +drm_dp_mst_topology_mgr_invalidate_mstb(struct drm_dp_mst_branch *mstb)
> +{
> +	struct drm_dp_mst_port *port;
> +
> +	/* The link address will need to be re-sent on resume */
> +	mstb->link_address_sent = false;
> +
> +	list_for_each_entry(port, &mstb->ports, next) {
> +		/* The PBN for each port will also need to be re-probed */
> +		port->available_pbn = 0;
> +
> +		if (port->mstb)
> +			drm_dp_mst_topology_mgr_invalidate_mstb(port->mstb);
> +	}
> +}
> +
>  /**
>   * drm_dp_mst_topology_mgr_suspend() - suspend the MST manager
>   * @mgr: manager to suspend
> @@ -3207,60 +3252,85 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr)
>  	flush_work(&mgr->up_req_work);
>  	flush_work(&mgr->work);
>  	flush_work(&mgr->delayed_destroy_work);
> +
> +	mutex_lock(&mgr->lock);
> +	if (mgr->mst_state && mgr->mst_primary)
> +		drm_dp_mst_topology_mgr_invalidate_mstb(mgr->mst_primary);
> +	mutex_unlock(&mgr->lock);
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
>  
>  /**
>   * drm_dp_mst_topology_mgr_resume() - resume the MST manager
>   * @mgr: manager to resume
> + * @sync: whether or not to perform topology reprobing synchronously
>   *
>   * This will fetch DPCD and see if the device is still there,
>   * if it is, it will rewrite the MSTM control bits, and return.
>   *
> - * if the device fails this returns -1, and the driver should do
> + * If the device fails this returns -1, and the driver should do
>   * a full MST reprobe, in case we were undocked.

nit: I don't think this sentence applies any longer since we're doing the reprobe.

> + *
> + * During system resume (where it is assumed that the driver will be calling
> + * drm_atomic_helper_resume()) this function should be called beforehand with
> + * @sync set to true. In contexts like runtime resume where the driver is not
> + * expected to be calling drm_atomic_helper_resume(), this function should be
> + * called with @sync set to false in order to avoid deadlocking.
> + *
> + * Returns: -1 if the MST topology was removed while we were suspended, 0
> + * otherwise.
>   */
> -int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
> +int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
> +				   bool sync)
>  {
> -	int ret = 0;
> +	int ret;
> +	u8 guid[16];
>  
>  	mutex_lock(&mgr->lock);
> +	if (!mgr->mst_primary)
> +		goto out_fail;
>  
> -	if (mgr->mst_primary) {
> -		int sret;
> -		u8 guid[16];
> +	ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
> +			       DP_RECEIVER_CAP_SIZE);
> +	if (ret != DP_RECEIVER_CAP_SIZE) {
> +		DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
> +		goto out_fail;
> +	}
>  
> -		sret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEIVER_CAP_SIZE);
> -		if (sret != DP_RECEIVER_CAP_SIZE) {
> -			DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
> -			ret = -1;
> -			goto out_unlock;
> -		}
> +	ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
> +				 DP_MST_EN |
> +				 DP_UP_REQ_EN |
> +				 DP_UPSTREAM_IS_SRC);
> +	if (ret < 0) {
> +		DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
> +		goto out_fail;
> +	}
>  
> -		ret = drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
> -					 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
> -		if (ret < 0) {
> -			DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
> -			ret = -1;
> -			goto out_unlock;
> -		}
> +	/* Some hubs forget their guids after they resume */
> +	ret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
> +	if (ret != 16) {
> +		DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
> +		goto out_fail;
> +	}
> +	drm_dp_check_mstb_guid(mgr->mst_primary, guid);
>  
> -		/* Some hubs forget their guids after they resume */
> -		sret = drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
> -		if (sret != 16) {
> -			DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
> -			ret = -1;
> -			goto out_unlock;
> -		}
> -		drm_dp_check_mstb_guid(mgr->mst_primary, guid);
> +	/* For the final step of resuming the topology, we need to bring the
> +	 * state of our in-memory topology back into sync with reality. So,
> +	 * restart the probing process as if we're probing a new hub
> +	 */
> +	queue_work(system_long_wq, &mgr->work);
> +	mutex_unlock(&mgr->lock);
>  
> -		ret = 0;
> -	} else
> -		ret = -1;
> +	if (sync) {
> +		DRM_DEBUG_KMS("Waiting for link probe work to finish re-syncing topology...\n");
> +		flush_work(&mgr->work);
> +	}

It took me longer than I'd like to admit to realize that most of the diff in
this function is just removing the indent. Would you mind splitting that out
into a separate patch so the reprobe change is more obvious?

With these nits fixed,

Reviewed-by: Sean Paul <sean@poorly.run>


>  
> -out_unlock:
> +	return 0;
> +
> +out_fail:
>  	mutex_unlock(&mgr->lock);
> -	return ret;
> +	return -1;
>  }
>  EXPORT_SYMBOL(drm_dp_mst_topology_mgr_resume);
>  
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 5673ed75e428..b78364dcdef9 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -7400,7 +7400,8 @@ void intel_dp_mst_resume(struct drm_i915_private *dev_priv)
>  		if (!intel_dp->can_mst)
>  			continue;
>  
> -		ret = drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr);
> +		ret = drm_dp_mst_topology_mgr_resume(&intel_dp->mst_mgr,
> +						     true);
>  		if (ret) {
>  			intel_dp->is_mst = false;
>  			drm_dp_mst_topology_mgr_set_mst(&intel_dp->mst_mgr,
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> index 307584107d77..e459e2a79d78 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1309,14 +1309,14 @@ nv50_mstm_fini(struct nv50_mstm *mstm)
>  }
>  
>  static void
> -nv50_mstm_init(struct nv50_mstm *mstm)
> +nv50_mstm_init(struct nv50_mstm *mstm, bool runtime)
>  {
>  	int ret;
>  
>  	if (!mstm || !mstm->mgr.mst_state)
>  		return;
>  
> -	ret = drm_dp_mst_topology_mgr_resume(&mstm->mgr);
> +	ret = drm_dp_mst_topology_mgr_resume(&mstm->mgr, !runtime);
>  	if (ret == -1) {
>  		drm_dp_mst_topology_mgr_set_mst(&mstm->mgr, false);
>  		drm_kms_helper_hotplug_event(mstm->mgr.dev);
> @@ -2262,7 +2262,7 @@ nv50_display_init(struct drm_device *dev, bool resume, bool runtime)
>  		if (encoder->encoder_type != DRM_MODE_ENCODER_DPMST) {
>  			struct nouveau_encoder *nv_encoder =
>  				nouveau_encoder(encoder);
> -			nv50_mstm_init(nv_encoder->dp.mstm);
> +			nv50_mstm_init(nv_encoder->dp.mstm, runtime);
>  		}
>  	}
>  
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 1efbb086f7ac..1bdee5ee6dcd 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -685,7 +685,8 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>  
>  void drm_dp_mst_topology_mgr_suspend(struct drm_dp_mst_topology_mgr *mgr);
>  int __must_check
> -drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr);
> +drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr,
> +			       bool sync);
>  
>  ssize_t drm_dp_mst_dpcd_read(struct drm_dp_aux *aux,
>  			     unsigned int offset, void *buffer, size_t size);
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
