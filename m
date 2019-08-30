Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAE1C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE24C23431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 23:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbfH3XqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:46:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3XqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 19:46:08 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B71E47EBAE
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 23:46:07 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id y67so9037170qkc.14
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 16:46:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=NHk/ZFhPJDgajux374nDmDxY+4wQktEQCQJTnLiSENg=;
        b=jBl3UdXh3QiPxAViMRbU3+Jhw4heNKjCl+U6EFdeUxotZWcnsc3EvmcdOwtXCdtI7z
         iHwYrL9yfnxMvzgcYqAnFlfsswuQk96WEiDCP5Ax3O2zEFnK0uC09b25/8hN9kT0Ntiy
         PUrppwLSAZjrHIL7mR3m9CUaM27CKU7b2uKOGdulyBDDW/i+9eUeyqTI2dUof3lroGRn
         AZQj81ZEGWY1n7Qor48nBxcBGjsD8MAw9XBlBki+NOYrcLlZEwdFHVek9cWt/1Pxx3rz
         tbSraTNB+364sHHZhnzm4otDQd9H9lrjCjSAk9ZGFGnQFhQTqMTQzPZJsJ3R1fiKIzDK
         Nq0g==
X-Gm-Message-State: APjAAAX95Pei76d/cldSLR0aCQCXeLqjrqIOG24AJc35FcrnAO1UMgyO
        kV+fCZXeqA2/HVmuYxiDxB+S7oX7gWSsDGXksN85ZLZwHsIqcwhbEYngcMkBnqynw+uyK0olxSL
        F1wx5iuW0nbqldJ6DHLF4XvwB
X-Received: by 2002:ac8:60c3:: with SMTP id i3mr16757297qtm.212.1567208767067;
        Fri, 30 Aug 2019 16:46:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzoviyvC+xR2agZKeaymSJkq36ljKHHlDBuQ6nbSW+EmzFczkgSSM52mnQjK+maQ0wJrzLFcw==
X-Received: by 2002:ac8:60c3:: with SMTP id i3mr16757283qtm.212.1567208766775;
        Fri, 30 Aug 2019 16:46:06 -0700 (PDT)
Received: from dhcp-10-20-1-34.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id c15sm3141459qkm.32.2019.08.30.16.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 16:46:05 -0700 (PDT)
Message-ID: <2e29ba5490815f2098d9aa50bb84470aac7ba08b.camel@redhat.com>
Subject: Re: [PATCH 06/26] drm/dp_mst: Move PDT teardown for ports into
 destroy_connector_work
From:   Lyude Paul <lyude@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Aug 2019 19:46:03 -0400
In-Reply-To: <20190813145242.GW7444@phenom.ffwll.local>
References: <20190718014329.8107-1-lyude@redhat.com>
         <20190718014329.8107-7-lyude@redhat.com>
         <20190813145242.GW7444@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-08-13 at 16:52 +0200, Daniel Vetter wrote:
> On Wed, Jul 17, 2019 at 09:42:29PM -0400, Lyude Paul wrote:
> > This will allow us to add some locking for port PDTs, which can't be
> > done from drm_dp_destroy_port() since we don't know what locks the
> > caller might be holding. Also, this gets rid of a good bit of unneeded
> > code.
> > 
> > Cc: Juston Li <juston.li@intel.com>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 42 +++++++++++----------------
> >  1 file changed, 17 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index defc5e09fb9a..0295e007c836 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -1509,31 +1509,22 @@ static void drm_dp_destroy_port(struct kref *kref)
> >  		container_of(kref, struct drm_dp_mst_port, topology_kref);
> >  	struct drm_dp_mst_topology_mgr *mgr = port->mgr;
> >  
> > -	if (!port->input) {
> > -		kfree(port->cached_edid);
> > -
> > -		/*
> > -		 * The only time we don't have a connector
> > -		 * on an output port is if the connector init
> > -		 * fails.
> > -		 */
> > -		if (port->connector) {
> > -			/* we can't destroy the connector here, as
> > -			 * we might be holding the mode_config.mutex
> > -			 * from an EDID retrieval */
> > -
> > -			mutex_lock(&mgr->destroy_connector_lock);
> > -			list_add(&port->next, &mgr->destroy_connector_list);
> > -			mutex_unlock(&mgr->destroy_connector_lock);
> > -			schedule_work(&mgr->destroy_connector_work);
> > -			return;
> > -		}
> > -		/* no need to clean up vcpi
> > -		 * as if we have no connector we never setup a vcpi */
> > -		drm_dp_port_teardown_pdt(port, port->pdt);
> > -		port->pdt = DP_PEER_DEVICE_NONE;
> > +	/* There's nothing that needs locking to destroy an input port yet */
> > +	if (port->input) {
> > +		drm_dp_mst_put_port_malloc(port);
> > +		return;
> >  	}
> > -	drm_dp_mst_put_port_malloc(port);
> > +
> > +	kfree(port->cached_edid);
> > +
> > +	/*
> > +	 * we can't destroy the connector here, as we might be holding the
> > +	 * mode_config.mutex from an EDID retrieval
> > +	 */
> > +	mutex_lock(&mgr->destroy_connector_lock);
> > +	list_add(&port->next, &mgr->destroy_connector_list);
> > +	mutex_unlock(&mgr->destroy_connector_lock);
> > +	schedule_work(&mgr->destroy_connector_work);
> 
> So if I'm not completely blind this just flattens the above code flow (by
> inverting the if (port->input)).

Now I'm really remembering why I refactored this. The control flow on the
previous version of this is pretty misleading. To summarize so it's a bit more
obvious:

if (port->input) {
	drm_dp_mst_put_port_malloc(port);
	return;
} else if (port->connector) {
	add_connector_to_destroy_list();
	return;
	/* ^ now, this is where PDT teardown happens */
} else {
	drm_dp_port_teardown_pdt(port, port->pdt);
}
/* free edid etc etc */

So, I suppose the title of this patch would be more accurate if it was
"drm/dp_mst: Remove PDT teardown in destroy_port() and refactor"
I'll go ahead and change that

> 
> >  }
> >  
> >  /**
> > @@ -3881,7 +3872,8 @@ drm_dp_finish_destroy_port(struct drm_dp_mst_port
> > *port)
> >  {
> >  	INIT_LIST_HEAD(&port->next);
> >  
> > -	port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> > +	if (port->connector)
> 
> And this here I can't connect with the commit message. I'm confused, did
> something go wrong with some rebase here, and this patch should have a
> different title/summary?
> -Daniel

No, this is correct. In the previous drm_dp_destroy_port() function we only
added a port to the delayed destroy work if it had a connector on it. Now that
we add ports unconditionally, we have to check port->connector before trying
to call port->mgr->cbs->destroy_connector() since port->connector is no longer
guaranteed to be != NULL.

> 
> > +		port->mgr->cbs->destroy_connector(port->mgr, port->connector);
> >  
> >  	drm_dp_port_teardown_pdt(port, port->pdt);
> >  	port->pdt = DP_PEER_DEVICE_NONE;
> > -- 
> > 2.21.0
> > 
-- 
Cheers,
	Lyude Paul

