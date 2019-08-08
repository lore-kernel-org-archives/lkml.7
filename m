Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F227C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4300521874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="iYR9wSCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbfHHTx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:53:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43027 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404517AbfHHTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:53:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so92195903edr.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 12:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Hx4zFgtlrFg6qa3OGmZWiKmbcXh1MHkynmASC975EfY=;
        b=iYR9wSCg65JI+uwVkvAiRQJUZALaPs/HlAH+vjKa0SMd0potj9JYU7FbPaB7nYiAmF
         NU+5kx6mC1PW6k9TygrOuq5eSQWSugpe7Ge24Py8+EyyNaBeBH8MIw5rmXnIpFiLX1pb
         3fWc+y+802/I7qnlMADscQ57kFFJWQylDP8fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Hx4zFgtlrFg6qa3OGmZWiKmbcXh1MHkynmASC975EfY=;
        b=syFXq3NjD6FJLuZfEP3G4R98yuNcD5n/ZQJs6UB7uMcTGqttBJaYN4S6p49RhqePS3
         sSyGScYxgz390qO91VtzUJDNE4f3i+Ay54O3/jJBn17vfZ8KN5cx/fOYs5sJI2iPm1yI
         U6md0GoAKHW22xbYvk3HsXOAf3xX5kEwYSdtB5ja9jw0pak7FEHHlNDLFERVjeSyaNBs
         RowCQ39LxhezET1p8mNHsn/oNak+7p5hPrgjuhBvmCFoNxuSfN0riW9I+QqC9tim+Yq1
         JJmqTyH0RsqFBtawho9wm0N6wItTTAKwFxvrUhpnNSMlKlDTeF3QruDQROfI4rMmSy+3
         plBg==
X-Gm-Message-State: APjAAAX+bMrbJWa7W9qlTWAJPortE7sVNBJB2gp880X36Rz4n/r4/5Xr
        7toIL8hTx9+KZsNXxkWz3Py2NY6iWy1yXA==
X-Google-Smtp-Source: APXvYqy9QZDaIPMY+YwMctNImyD9+BfYQxSi2RrV91xgPr938CL3tw0iNxbTcYIiU2UFL2gp/bBVLA==
X-Received: by 2002:a17:906:e2c2:: with SMTP id gr2mr15180216ejb.284.1565294002360;
        Thu, 08 Aug 2019 12:53:22 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id u9sm22123540edm.71.2019.08.08.12.53.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 12:53:21 -0700 (PDT)
Date:   Thu, 8 Aug 2019 21:53:18 +0200
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
Subject: Re: [PATCH 01/26] drm/dp_mst: Move link address dumping into a
 function
Message-ID: <20190808195318.GQ7444@phenom.ffwll.local>
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
 <20190718014329.8107-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-2-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:24PM -0400, Lyude Paul wrote:
> Since we're about to be calling this from multiple places. Also it makes
> things easier to read!
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 35 ++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 0984b9a34d55..998081b9b205 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2013,6 +2013,28 @@ static void drm_dp_queue_down_tx(struct drm_dp_mst_topology_mgr *mgr,
>  	mutex_unlock(&mgr->qlock);
>  }
>  
> +static void
> +drm_dp_dump_link_address(struct drm_dp_link_address_ack_reply *reply)
> +{
> +	struct drm_dp_link_addr_reply_port *port_reply;
> +	int i;
> +
> +	for (i = 0; i < reply->nports; i++) {
> +		port_reply = &reply->ports[i];
> +		DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n",
> +			      i,
> +			      port_reply->input_port,
> +			      port_reply->peer_device_type,
> +			      port_reply->port_number,
> +			      port_reply->dpcd_revision,
> +			      port_reply->mcs,
> +			      port_reply->ddps,
> +			      port_reply->legacy_device_plug_status,
> +			      port_reply->num_sdp_streams,
> +			      port_reply->num_sdp_stream_sinks);
> +	}
> +}
> +
>  static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  				     struct drm_dp_mst_branch *mstb)
>  {
> @@ -2038,18 +2060,7 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  			DRM_DEBUG_KMS("link address nak received\n");
>  		} else {
>  			DRM_DEBUG_KMS("link address reply: %d\n", txmsg->reply.u.link_addr.nports);
> -			for (i = 0; i < txmsg->reply.u.link_addr.nports; i++) {
> -				DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n", i,
> -				       txmsg->reply.u.link_addr.ports[i].input_port,
> -				       txmsg->reply.u.link_addr.ports[i].peer_device_type,
> -				       txmsg->reply.u.link_addr.ports[i].port_number,
> -				       txmsg->reply.u.link_addr.ports[i].dpcd_revision,
> -				       txmsg->reply.u.link_addr.ports[i].mcs,
> -				       txmsg->reply.u.link_addr.ports[i].ddps,
> -				       txmsg->reply.u.link_addr.ports[i].legacy_device_plug_status,
> -				       txmsg->reply.u.link_addr.ports[i].num_sdp_streams,
> -				       txmsg->reply.u.link_addr.ports[i].num_sdp_stream_sinks);
> -			}
> +			drm_dp_dump_link_address(&txmsg->reply.u.link_addr);
>  
>  			drm_dp_check_mstb_guid(mstb, txmsg->reply.u.link_addr.guid);
>  
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
