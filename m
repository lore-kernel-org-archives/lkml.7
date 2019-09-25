Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8BCC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5DF21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="cj6dBN+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392287AbfIYTaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:30:12 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43671 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfIYTaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:30:11 -0400
Received: by mail-yb1-f193.google.com with SMTP id y204so722426yby.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ivc5Ob9PVZJplSHL+R/D0C0HT53Yohnme4bjjvTUjS4=;
        b=cj6dBN+XZAqEN5fpheUDPARCVOb+gJLpNiyxUsf4DQRqLidgm5jPfRbpsGjgigMEli
         sKdO5aSG4Ju4tuB3UYgi0aATUqk5Bu67pbZKVqe9Ku/eUnzWiJHP3zqbhVaXcaKAZduk
         ElE1fpYM2ZC4glzLx2LMTD1SOI2ni89e/+j18VcfeQ4iNIjf0sxLJK1oGuaC+RXHJSF0
         jx8MGCSOuNNzWV1/n0h057nYEVhTyyraJ15FF61aeZxm7hDnN2q+4Ivj+pqu6XR+eG7R
         qx44BkWTDjS88F34WHOsnQ7OOSFNO9ZP2J8IDkDKcAF7+AYl3vfJGrLf3lmpXtkVljxa
         H7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ivc5Ob9PVZJplSHL+R/D0C0HT53Yohnme4bjjvTUjS4=;
        b=cELdQx7fO5PPXXp30kZhA5eSoohug7z6AMTcuyBUcVeV+26GjBaBkcl3hukAyEsHkp
         vsNtLkbeM4BlSOak4VGUv+y0XA+RnENzYc4UgDKVQunq9iPaoFvF5pjqsN+cNSItV58p
         Hgxi/PLbTJTc83xb1fT+UMmq2LQW9fOmolkI8oik0QqG6RAL8p/R6jK189bGgC0CMEsl
         FOH50L0WDdN+tGKQlylo+PYYcU3Vcyq+HK5SDckQ3em4IGA0ZNz/f3k7zxG6f1YYGT4e
         ziUTTW7D2e21alBALDlrHuM3mddLhiIMdEZYq5W+NKmNKkaTqLW1+Ut1ZslbRvYuY0Yr
         9rOg==
X-Gm-Message-State: APjAAAV1KrmLtLE09vKxui1lBs23KFxJC672LIJ6BpYhuWdA5FWbg5KB
        HFpN1hTKQjEZICQqVI4cP8QSXg==
X-Google-Smtp-Source: APXvYqxfifPqZv+UdJYFkxbD5nMkRDaBiqNMCGCRMwi6mlVj2WtuUyOtxRzyV2anpOAEVqc+3QH5YQ==
X-Received: by 2002:a25:70d6:: with SMTP id l205mr4296329ybc.374.1569439810639;
        Wed, 25 Sep 2019 12:30:10 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id l188sm1414583ywl.29.2019.09.25.12.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 12:30:10 -0700 (PDT)
Date:   Wed, 25 Sep 2019 15:30:09 -0400
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
Subject: Re: [PATCH v2 17/27] drm/dp_mst: Rename drm_dp_add_port and
 drm_dp_update_port
Message-ID: <20190925193009.GI218215@art_vandelay>
References: <20190903204645.25487-1-lyude@redhat.com>
 <20190903204645.25487-18-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190903204645.25487-18-lyude@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 04:45:55PM -0400, Lyude Paul wrote:
> The names for these functions are rather confusing. drm_dp_add_port()
> sounds like a function that would simply create a port and add it to a
> topology, and do nothing more. Similarly, drm_dp_update_port() would be
> assumed to be the function that should be used to update port
> information after initial creation.
> 
> While those assumptions are currently correct in how these functions are
> used, a quick glance at drm_dp_add_port() reveals that drm_dp_add_port()
> can also update the information on a port, and seems explicitly designed
> to do so. This can be explained pretty simply by the fact that there's
> more situations that would involve updating the port information based
> on a link address response as opposed to a connection status
> notification than the driver's initial topology probe. Case in point:
> reprobing link addresses after suspend/resume.
> 
> Since we're about to start using drm_dp_add_port() differently for
> suspend/resume reprobing, let's rename both functions to clarify what
> they actually do.
> 
> Cc: Juston Li <juston.li@intel.com>
> Cc: Imre Deak <imre.deak@intel.com>
> Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Sean Paul <sean@poorly.run>

> ---
>  drivers/gpu/drm/drm_dp_mst_topology.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 9944ef2ce885..cfaf9eb7ace9 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1900,9 +1900,10 @@ void drm_dp_mst_connector_early_unregister(struct drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_dp_mst_connector_early_unregister);
>  
> -static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
> -			    struct drm_device *dev,
> -			    struct drm_dp_link_addr_reply_port *port_msg)
> +static void
> +drm_dp_mst_handle_link_address_port(struct drm_dp_mst_branch *mstb,
> +				    struct drm_device *dev,
> +				    struct drm_dp_link_addr_reply_port *port_msg)
>  {
>  	struct drm_dp_mst_topology_mgr *mgr = mstb->mgr;
>  	struct drm_dp_mst_port *port;
> @@ -2011,8 +2012,9 @@ static void drm_dp_add_port(struct drm_dp_mst_branch *mstb,
>  	drm_dp_mst_topology_put_port(port);
>  }
>  
> -static void drm_dp_update_port(struct drm_dp_mst_branch *mstb,
> -			       struct drm_dp_connection_status_notify *conn_stat)
> +static void
> +drm_dp_mst_handle_conn_stat(struct drm_dp_mst_branch *mstb,
> +			    struct drm_dp_connection_status_notify *conn_stat)
>  {
>  	struct drm_dp_mst_port *port;
>  	int old_ddps;
> @@ -2464,7 +2466,8 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
>  	drm_dp_check_mstb_guid(mstb, reply->guid);
>  
>  	for (i = 0; i < reply->nports; i++)
> -		drm_dp_add_port(mstb, mgr->dev, &reply->ports[i]);
> +		drm_dp_mst_handle_link_address_port(mstb, mgr->dev,
> +						    &reply->ports[i]);
>  
>  	drm_kms_helper_hotplug_event(mgr->dev);
>  
> @@ -3324,7 +3327,7 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>  	}
>  
>  	if (msg.req_type == DP_CONNECTION_STATUS_NOTIFY) {
> -		drm_dp_update_port(mstb, &msg.u.conn_stat);
> +		drm_dp_mst_handle_conn_stat(mstb, &msg.u.conn_stat);
>  
>  		DRM_DEBUG_KMS("Got CSN: pn: %d ldps:%d ddps: %d mcs: %d ip: %d pdt: %d\n",
>  			      msg.u.conn_stat.port_number,
> -- 
> 2.21.0
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
