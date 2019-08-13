Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C11EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A7D20844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 14:52:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="IcBJ7hke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfHMOwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 10:52:47 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36553 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbfHMOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 10:52:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id p28so1655092edi.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 07:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RQ1QVx5o9SJIET1BWjWYbWKrgeBi7qgViw8kkVMCTvs=;
        b=IcBJ7hkeGZvJTKoDJTcKpgH6kedD5Ys+UinOd9BoHC2xm6KrEn66kehAaodc2VXiBG
         YsTebKuxTPKezkiq/+7mL3flXJfHL7kp2/L2BsHul3ZKwyuLOaV4o+fT9kWwHkE6lHvo
         Is+KJZUcK0obXKg8OA6opSR4n1FFR9aR8OgRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RQ1QVx5o9SJIET1BWjWYbWKrgeBi7qgViw8kkVMCTvs=;
        b=g1G3eo2krXc/vJMF0Ek/2o2VaIshk142hy2ciwvGZDbHLY0R04Iz+zffTJ7u672RlT
         x6wOpXaSyv4CVuZ5m2OQecBqAL7WM3boBTtodoUs6qUyjkRK6ub8WKFhofO5aC8v27l1
         HbWx6WINpKeZGOymb29NPSC+l77kidB4pZa7NZZMEZRcgFRaV1ntwbAkuh1pWDhOeN4T
         bQHhnPOA38q1S+Msh8cHFVKsheqeDdu3L5CK229USH4eHvljkARtLOpPYAgDS6IsnQpF
         KkC2cswloLiMuOJj4tKxKQxBZu2khZKRgXNPss3hyrmKBXK4qpULGBnQqCsj/F9PVyr6
         0Rmw==
X-Gm-Message-State: APjAAAWi5o+ox3VABymu79YYdS30Znkvl+asjV/9aFs0ytgK4TaX3nC9
        aKZxBCjqyxE/GIalYkNOhZCQZw==
X-Google-Smtp-Source: APXvYqzSFlhkSEYUKazTLMB6IcJ+/zeWaPQ1in9/DSpiokVlOE33cDm3eLAeQimuIReaivkPmW6ZFg==
X-Received: by 2002:a50:9f81:: with SMTP id c1mr25767200edf.100.1565707965205;
        Tue, 13 Aug 2019 07:52:45 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id c15sm17906654ejs.17.2019.08.13.07.52.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 07:52:44 -0700 (PDT)
Date:   Tue, 13 Aug 2019 16:52:42 +0200
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
Subject: Re: [PATCH 06/26] drm/dp_mst: Move PDT teardown for ports into
 destroy_connector_work
Message-ID: <20190813145242.GW7444@phenom.ffwll.local>
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
 <20190718014329.8107-7-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190718014329.8107-7-lyude@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 09:42:29PM -0400, Lyude Paul wrote:
> This will allow us to add some locking for port PDTs, which can't be
> done from drm_dp_destroy_port() since we don't know what locks the
> caller might be holding. Also, this gets rid of a good bit of unneeded
> code.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 42 +++++++++++----------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index defc5e09fb9a..0295e007c836 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1509,31 +1509,22 @@ static void drm_dp_destroy_port(struct kref *kref)
>  		container_of(kref, struct drm_dp_mst_port, topology_kref);
>  	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
>  
> -	if (!port->input) {
> -		kfree(port->cached_edid);
> -
> -		/*
> -		 * The only time we don't have a connector
> -		 * on an output port is if the connector init
> -		 * fails.
> -		 */
> -		if (port->connector) {
> -			/* we can't destroy the connector here, as
> -			 * we might be holding the mode_config.mutex
> -			 * from an EDID retrieval */
> -
> -			mutex_lock(&mgr->destroy_connector_lock);
> -			list_add(&port->next, &mgr->destroy_connector_list);
> -			mutex_unlock(&mgr->destroy_connector_lock);
> -			schedule_work(&mgr->destroy_connector_work);
> -			return;
> -		}
> -		/* no need to clean up vcpi
> -		 * as if we have no connector we never setup a vcpi */
> -		drm_dp_port_teardown_pdt(port, port->pdt);
> -		port->pdt = DP_PEER_DEVICE_NONE;
> +	/* There's nothing that needs locking to destroy an input port yet */
> +	if (port->input) {
> +		drm_dp_mst_put_port_malloc(port);
> +		return;
>  	}
> -	drm_dp_mst_put_port_malloc(port);
> +
> +	kfree(port->cached_edid);
> +
> +	/*
> +	 * we can't destroy the connector here, as we might be holding the
> +	 * mode_config.mutex from an EDID retrieval
> +	 */
> +	mutex_lock(&mgr->destroy_connector_lock);
> +	list_add(&port->next, &mgr->destroy_connector_list);
> +	mutex_unlock(&mgr->destroy_connector_lock);
> +	schedule_work(&mgr->destroy_connector_work);

So if I'm not completely blind this just flattens the above code flow (by
inverting the if (port->input)).

>  }
>  
>  /**
> @@ -3881,7 +3872,8 @@ drm_dp_finish_destroy_port(struct drm_dp_mst_port *port)
>  {
>  	INIT_LIST_HEAD(&port->next);
>  
> -	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> +	if (port->connector)

And this here I can't connect with the commit message. I'm confused, did
something go wrong with some rebase here, and this patch should have a
different title/summary?
-Daniel

> +		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
>  
>  	drm_dp_port_teardown_pdt(port, port->pdt);
>  	port->pdt = DP_PEER_DEVICE_NONE;
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
