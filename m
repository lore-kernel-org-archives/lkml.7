Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51852C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB94217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 21:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfHZVva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 17:51:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33308 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfHZVv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 17:51:29 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB2243B71F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 21:51:28 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id z15so18898252qtq.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 14:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=7c4qKqMTWkLz+rdogljBCIaDURVz1u9UaTlZ6kcFhXI=;
        b=hiQcCE+q9Q5xkyuyZ+mIavRNyy/4Bqp4NEXkEOIdlYPqKO/u2GaqpI1K2a9uJMDKji
         5g2hGKHmTuK96JZFtqv12OMks17GPbCSmt0ySkT0T+68eldE/XrWmm3KWAc81GK3w8p3
         5XG9FgofKqrC2L60lA6+ygE9s9usnM+V3vCgnxDuSH8Drj+iVrgWRKmC5PrPffWbWVO7
         zvyyjH3mrQI2KcM61mdm+GK/0pe6wA82b3PzgXlEDsTF9TDJo3eqLBKemxX2pWVKxz26
         aTu6wuNNw91jtuJfsPSdJoaxPYABCOXHcG+W99AnEkpcrLHFtqdNY8VkvPhDOGm1XztB
         Cx+g==
X-Gm-Message-State: APjAAAUa1gMGYne7nGPc5pWpWMHOyH/TrDiSpot2XHAAWveab6DjA3hi
        smXzoFPONSFeFoel9IdIduReAadcIqyam6SEn7193wBp8p2Ao4nmOvhRE7Hbas0jctJlqsevkcP
        sbpgBHnuXrUcb3Z57kAkN5XxL
X-Received: by 2002:ac8:3435:: with SMTP id u50mr19481721qtb.310.1566856288258;
        Mon, 26 Aug 2019 14:51:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwBARvIoeY8BGIy+x1QgkncpM4AedhRZJ7eEuv8IqaZIxRiqXtf6O+p8vU4UbABKuVNDzD8ag==
X-Received: by 2002:ac8:3435:: with SMTP id u50mr19481700qtb.310.1566856287989;
        Mon, 26 Aug 2019 14:51:27 -0700 (PDT)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id w126sm7524273qkd.68.2019.08.26.14.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 14:51:27 -0700 (PDT)
Message-ID: <5d44346ecb6ab13d9f01142f33d4ff1029054067.camel@redhat.com>
Subject: Re: [PATCH 01/26] drm/dp_mst: Move link address dumping into a
 function
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
Date:   Mon, 26 Aug 2019 17:51:26 -0400
In-Reply-To: <20190808195318.GQ7444@phenom.ffwll.local>
References: <20190718014329.8107-1-lyude@redhat.com>
         <20190718014329.8107-2-lyude@redhat.com>
         <20190808195318.GQ7444@phenom.ffwll.local>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*sigh* finally have some time to go through these reviews

jfyi: I realized after looking over this patch that it's not actually needed -
I had been planning on using drm_dp_dump_link_address() for other things, but
ended up deciding to make the final plan to use something that dumps into a
format that's identical to the one we're using for dumping DOWN requests. IMHO
though, this patch does make things look nicer so I'll probably keep it.

Assuming I can still count your r-b as valid with a change to the commit
description?

On Thu, 2019-08-08 at 21:53 +0200, Daniel Vetter wrote:
> On Wed, Jul 17, 2019 at 09:42:24PM -0400, Lyude Paul wrote:
> > Since we're about to be calling this from multiple places. Also it makes
> > things easier to read!
> > 
> > Cc: Juston Li <juston.li@intel.com>
> > Cc: Imre Deak <imre.deak@intel.com>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Cc: Harry Wentland <hwentlan@amd.com>
> > Signed-off-by: Lyude Paul <lyude@redhat.com>
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 35 ++++++++++++++++++---------
> >  1 file changed, 23 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 0984b9a34d55..998081b9b205 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -2013,6 +2013,28 @@ static void drm_dp_queue_down_tx(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  	mutex_unlock(&mgr->qlock);
> >  }
> >  
> > +static void
> > +drm_dp_dump_link_address(struct drm_dp_link_address_ack_reply *reply)
> > +{
> > +	struct drm_dp_link_addr_reply_port *port_reply;
> > +	int i;
> > +
> > +	for (i = 0; i < reply->nports; i++) {
> > +		port_reply = &reply->ports[i];
> > +		DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev:
> > %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n",
> > +			      i,
> > +			      port_reply->input_port,
> > +			      port_reply->peer_device_type,
> > +			      port_reply->port_number,
> > +			      port_reply->dpcd_revision,
> > +			      port_reply->mcs,
> > +			      port_reply->ddps,
> > +			      port_reply->legacy_device_plug_status,
> > +			      port_reply->num_sdp_streams,
> > +			      port_reply->num_sdp_stream_sinks);
> > +	}
> > +}
> > +
> >  static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
> >  				     struct drm_dp_mst_branch *mstb)
> >  {
> > @@ -2038,18 +2060,7 @@ static void drm_dp_send_link_address(struct
> > drm_dp_mst_topology_mgr *mgr,
> >  			DRM_DEBUG_KMS("link address nak received\n");
> >  		} else {
> >  			DRM_DEBUG_KMS("link address reply: %d\n", txmsg-
> > >reply.u.link_addr.nports);
> > -			for (i = 0; i < txmsg->reply.u.link_addr.nports; i++)
> > {
> > -				DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn:
> > %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n", i,
> > -				       txmsg-
> > >reply.u.link_addr.ports[i].input_port,
> > -				       txmsg-
> > >reply.u.link_addr.ports[i].peer_device_type,
> > -				       txmsg-
> > >reply.u.link_addr.ports[i].port_number,
> > -				       txmsg-
> > >reply.u.link_addr.ports[i].dpcd_revision,
> > -				       txmsg->reply.u.link_addr.ports[i].mcs,
> > -				       txmsg->reply.u.link_addr.ports[i].ddps,
> > -				       txmsg-
> > >reply.u.link_addr.ports[i].legacy_device_plug_status,
> > -				       txmsg-
> > >reply.u.link_addr.ports[i].num_sdp_streams,
> > -				       txmsg-
> > >reply.u.link_addr.ports[i].num_sdp_stream_sinks);
> > -			}
> > +			drm_dp_dump_link_address(&txmsg->reply.u.link_addr);
> >  
> >  			drm_dp_check_mstb_guid(mstb, txmsg-
> > >reply.u.link_addr.guid);
> >  
> > -- 
> > 2.21.0
> > 
-- 
Cheers,
	Lyude Paul

