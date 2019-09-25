Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE6AC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E57207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="RuBZqIvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfIYRpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:45:02 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39059 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbfIYRpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:45:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id n11so2367852ywn.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OwXWZPnQzf3XInXWmq5k6gcPq0axL7VeZ/2pUkeIAO0=;
        b=RuBZqIvukahNvS2RWkJSSIoSGRWT90uYjmjps6VQ1ybNW3AYnanSdd4620DHDwc/yF
         N2132Z2o6rc0ScIkepSll+PIIr1lBpgU29MoUPbGETeSuqTivFQslAQAH3+AqGym/YQv
         n226t8zfFzSifU9oPn5hVQKYfolEPuSacs9PkqBS5iZD08BM2dPV1TC94ONamhSa5CGx
         mlRTN2p8fN432g8cr9uFNmhwLjYFWInOrA6u5wZ30Cv4BbNR1jZuP7+ShVrWs4RDvU6l
         Pji0dM4YDZn9YVYfraDmMuLmKvlrLRDMGMSb6X4tfcFD8bEEsPdl0MYISqAv1F0Lzjo3
         Q/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OwXWZPnQzf3XInXWmq5k6gcPq0axL7VeZ/2pUkeIAO0=;
        b=CYHOZNeen0mQVPGXXYz5CLtkivuxc+8W9ZliNtiei8C4SfXEMzXlrnBxRBb26JJyoH
         uEVs3JudySeA8g7LQ5SFWGmWfUnwIml9QfIwkvlSju4jsc2LrVvZDJfjna15YIAUaZcq
         WJN0yWJvQPZOiaOR06wPjj+yRqovr0r9S0cv/JTtpFXoeIK4U8eY6UE1TD1/jz/lQNen
         HdEagrcuhXDBvmn4+ywxh7FcY7OY9T0OCrbuJ5+hxQm2SOvvEeRJQmv6WH4X5PbLqsLB
         nmb/vpKVf8Y5UXbYTsalAnM2P/Bya9kgns14/2du8+R2oYBFg/hpRwgCzy2UKzteGpOm
         A+VA==
X-Gm-Message-State: APjAAAWg2Sh2vBorpaGk3tVEjlYtQMOg35kqZYHUyCs9i7H4l1mxqiTS
        51nxKD9PmKd4MCA9T49h/AmXUg==
X-Google-Smtp-Source: APXvYqxiTwnx/w47MoIffPeZy27M224makbmCx5nzSH8a736vVNBtE4G47Q7IhV/AMkoZsqLvj+jkQ==
X-Received: by 2002:a81:6589:: with SMTP id z131mr6316271ywb.262.1569433501520;
        Wed, 25 Sep 2019 10:45:01 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id 189sm1371215ywa.47.2019.09.25.10.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 10:45:00 -0700 (PDT)
Date:   Wed, 25 Sep 2019 13:45:00 -0400
From:   Sean Paul <sean@poorly.run>
To:     Lyude Paul <lyude@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/27] drm/dp_mst: Move link address dumping into a
 function
Message-ID: <20190925174500.GB218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-2-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:39PM -0400, Lyude Paul wrote:
> Makes things easier to read.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Reviewed-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 35 ++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 82add736e17d..36db66a0ddb1 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -2103,6 +2103,28 @@ static void drm_dp_queue_down_tx(struct drm_dp_mst_topology_mgr *mgr,
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
> @@ -2128,18 +2150,7 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
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
Sean Paul, Software Engineer, Google / Chromium OS
