Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE9C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC89620844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="L08sAdPz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbfHMO40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:56:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38966 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbfHMO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:56:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id e16so13932574edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6wLnnK/l8H+MAZNrHDyoquiU2XSQhj8zFU+j5+WzSvQ=;
        b=L08sAdPzzFznlmk4G+Dh6cPYVhdA6h8RbEyUzysstNPVcKewLg+5JHxR1bvJEsfcid
         /Y8yrFbCBWBtGwRP1FJwpb5zJMD6AuOTIYuierBhQu+v+uVNesLNJySsrKZOXyT/+HdE
         UVVFLKm3a8SO7flfnP/D50I+i0mLLOxRwD468=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=6wLnnK/l8H+MAZNrHDyoquiU2XSQhj8zFU+j5+WzSvQ=;
        b=cyYTFPmVmVt+xb5Xk1vMRZYMr0YZjfjoOaBqZmCpWoMON5ZBHNLNdYWHAJyxObEYwu
         95vqFzERxWYq3YRecdqaXzTaCaMa7CPK0phvuAZToLOdC+5UQjTexsev3YV0xCySrM17
         O5khMFQwoxqrXz9UycW3aBrTTt0RilppghX/8/7NL3Msa5gwjhjbrCJFYHWKCQp3Y9tH
         lQjfXr9cFp6C2PHZHGyaAEYK6hrgbzV4gpwOqbTcngxohP/sBqMVyMxLJMKYw6HDS3FX
         toG4p1AogB+RXuWWpNmubonn814UgPrL3LWO6CVyjtYQFIBsi4hl6aTTqEo+abA1cczl
         DxQw==
X-Gm-Message-State: APjAAAXmT/eqjuA+cEVeCmmQlJMXXBtgK0EgfAnlhYTECVtcPOC+TVPn
        RMsWMCCHM/YCZrouwCEXrUHvtA==
X-Google-Smtp-Source: APXvYqzs/SYXJlJ4o2bDLUPt+KPeT44hq3JG2zY8+DfiBLzjKjj073E34pb6qI6Bo8DLofGUVqp97Q==
X-Received: by 2002:a17:906:2551:: with SMTP id j17mr11334783ejb.36.1565708183663;
        Tue, 13 Aug 2019 07:56:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d20sm1567405ejb.75.2019.08.13.07.56.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:56:22 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:56:20 +0200
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
Subject: Re: [PATCH 09/26] drm/dp_mst: Remove huge conditional in
 drm_dp_mst_handle_up_req()
Message-ID: <20190813145620.GY7444@phenom.ffwll.local>
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
 <20190718014329.8107-10-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-10-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:32PM -0400, Lyude Paul wrote:
> Which reduces indentation and makes this function more legible.

Indeed, nice one.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>


> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 90 +++++++++++++--------------
>  1 file changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 57c9c605ee17..b867a2e8f779 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -3126,7 +3126,9 @@ static int drm_dp_mst_handle_down_rep(struct drm_dp_mst_topology_mgr *mgr)
>  
>  static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>  {
> -	int ret = 0;
> +	struct drm_dp_sideband_msg_req_body msg;
> +	struct drm_dp_mst_branch *mstb = NULL;
> +	bool seqno;
>  
>  	if (!drm_dp_get_one_sb_msg(mgr, true)) {
>  		memset(&mgr->up_req_recv, 0,
> @@ -3134,62 +3136,60 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>  		return 0;
>  	}
>  
> -	if (mgr->up_req_recv.have_eomt) {
> -		struct drm_dp_sideband_msg_req_body msg;
> -		struct drm_dp_mst_branch *mstb = NULL;
> -		bool seqno;
> -
> -		if (!mgr->up_req_recv.initial_hdr.broadcast) {
> -			mstb = drm_dp_get_mst_branch_device(mgr,
> -							    mgr->up_req_recv.initial_hdr.lct,
> -							    mgr->up_req_recv.initial_hdr.rad);
> -			if (!mstb) {
> -				DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
> -				memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> -				return 0;
> -			}
> -		}
> +	if (!mgr->up_req_recv.have_eomt)
> +		return 0;
>  
> -		seqno = mgr->up_req_recv.initial_hdr.seqno;
> -		drm_dp_sideband_parse_req(&mgr->up_req_recv, &msg);
> +	if (!mgr->up_req_recv.initial_hdr.broadcast) {
> +		mstb = drm_dp_get_mst_branch_device(mgr,
> +						    mgr->up_req_recv.initial_hdr.lct,
> +						    mgr->up_req_recv.initial_hdr.rad);
> +		if (!mstb) {
> +			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
> +			memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> +			return 0;
> +		}
> +	}
>  
> -		if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
> -			drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno, false);
> +	seqno = mgr->up_req_recv.initial_hdr.seqno;
> +	drm_dp_sideband_parse_req(&mgr->up_req_recv, &msg);
>  
> -			if (!mstb)
> -				mstb = drm_dp_get_mst_branch_device_by_guid(mgr, msg.u.conn_stat.guid);
> +	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
> +		drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno, false);
>  
> -			if (!mstb) {
> -				DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
> -				memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> -				return 0;
> -			}
> +		if (!mstb)
> +			mstb = drm_dp_get_mst_branch_device_by_guid(mgr, msg.u.conn_stat.guid);
>  
> -			drm_dp_update_port(mstb, &msg.u.conn_stat);
> +		if (!mstb) {
> +			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
> +			memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> +			return 0;
> +		}
>  
> -			DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n", msg.u.conn_stat.port_number, msg.u.conn_stat.legacy_device_plug_status, msg.u.conn_stat.displayport_device_plug_status, msg.u.conn_stat.message_capability_status, msg.u.conn_stat.input_port, msg.u.conn_stat.peer_device_type);
> -			drm_kms_helper_hotplug_event(mgr->dev);
> +		drm_dp_update_port(mstb, &msg.u.conn_stat);
>  
> -		} else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
> -			drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno, false);
> -			if (!mstb)
> -				mstb = drm_dp_get_mst_branch_device_by_guid(mgr, msg.u.resource_stat.guid);
> +		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n", msg.u.conn_stat.port_number, msg.u.conn_stat.legacy_device_plug_status, msg.u.conn_stat.displayport_device_plug_status, msg.u.conn_stat.message_capability_status, msg.u.conn_stat.input_port, msg.u.conn_stat.peer_device_type);
> +		drm_kms_helper_hotplug_event(mgr->dev);
>  
> -			if (!mstb) {
> -				DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
> -				memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> -				return 0;
> -			}
> +	} else if (msg.req_type == DP_RESOURCE_STATUS_NOTIFY) {
> +		drm_dp_send_up_ack_reply(mgr, mgr->mst_primary, msg.req_type, seqno, false);
> +		if (!mstb)
> +			mstb = drm_dp_get_mst_branch_device_by_guid(mgr, msg.u.resource_stat.guid);
>  
> -			DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n", msg.u.resource_stat.port_number, msg.u.resource_stat.available_pbn);
> +		if (!mstb) {
> +			DRM_DEBUG_KMS("Got MST reply from unknown device %d\n", mgr->up_req_recv.initial_hdr.lct);
> +			memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> +			return 0;
>  		}
>  
> -		if (mstb)
> -			drm_dp_mst_topology_put_mstb(mstb);
> -
> -		memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> +		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n", msg.u.resource_stat.port_number, msg.u.resource_stat.available_pbn);
>  	}
> -	return ret;
> +
> +	if (mstb)
> +		drm_dp_mst_topology_put_mstb(mstb);
> +
> +	memset(&mgr->up_req_recv, 0, sizeof(struct drm_dp_sideband_msg_rx));
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
