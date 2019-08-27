Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F382BC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A307321881
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eb9Lr5VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbfH0QQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:16:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43846 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbfH0QQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:16:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id h13so32041369edq.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/4vkB4jsz3HMn/y1OvFa0QtMWaVVKUXYtk7xoXQcR1Q=;
        b=eb9Lr5VWWi7xb+OTFQHRxQ6sGLIQJtep/LHzUK62vSCqq5y5DlKsE/gbuGBgVjzT/U
         N1FTZm7i8hATAp9oRTsWbh8zPj3ZFe3QCVfH+yumMMw+fBu9uFSUFoyW0VxYaYa/g+cY
         VXheIz2v1+pW9d7Zm5weWQvsypsXnZLd6DbhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=/4vkB4jsz3HMn/y1OvFa0QtMWaVVKUXYtk7xoXQcR1Q=;
        b=kUh7iJq5YfWpNPr6bwd1PjA2Cd6ZA1yVVS18SDrZXF5scjd0UVJq/kELi7eYOQn1sh
         +Drto/ecYi0p/qRwXzn65Q3J4Hf6oOJXn08KI4sgmIGe0XVZJInBR28ZjkuOmUxDUHDg
         KapB1PnH7+cxLVOhHyJOosrUGpx9SN4dDR/rSjFTPWHICQ4VB1d1yUBN/K4uNDqCB8AW
         lCYE0ExWMIz/A6rvqz10nl+7d22LhZOsWbJXomi9HkJ4HOcyqgrsVfQ40Rpyux3E47fx
         R6cLvUtS9JMFzPyffyV9O24i8SPj6pMOSXzpFKVZ3Bn3ym58MtJs4vmZtFcdBqDRby42
         LPWQ==
X-Gm-Message-State: APjAAAV44hkD9T2z3cXXsPY+KlbieAYbZLlHQLs5fFfX08onRDcBSGyP
        kcjoRPam3DOPiyyMOyvjoyOahg==
X-Google-Smtp-Source: APXvYqy35QyWP0tugDh45Pcrj95ojvkirbBJRhnC4o+YTHQ+nHmoDWdP74SYgYSAtZoBVAidYWl6YA==
X-Received: by 2002:a17:906:b29a:: with SMTP id q26mr22076728ejz.144.1566922601045;
        Tue, 27 Aug 2019 09:16:41 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id l26sm3559267ejg.70.2019.08.27.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 09:16:40 -0700 (PDT)
Date:   Tue, 27 Aug 2019 18:16:38 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        Juston Li <juston.li@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/26] drm/dp_mst: Move link address dumping into a
 function
Message-ID: <20190827161637.GB2112@phenom.ffwll.local>
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
 <20190808195318.GQ7444@phenom.ffwll.local>
 <5d44346ecb6ab13d9f01142f33d4ff1029054067.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d44346ecb6ab13d9f01142f33d4ff1029054067.camel@redhat.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 05:51:26PM -0400, Lyude Paul wrote:
> *sigh* finally have some time to go through these reviews

Hey it took me longer to start even reviewing this, and not even through
:-( than it took you to reply here. So no worries!

> jfyi: I realized after looking over this patch that it's not actually needed -
> I had been planning on using drm_dp_dump_link_address() for other things, but
> ended up deciding to make the final plan to use something that dumps into a
> format that's identical to the one we're using for dumping DOWN requests. IMHO
> though, this patch does make things look nicer so I'll probably keep it.
> 
> Assuming I can still count your r-b as valid with a change to the commit
> description?

Sure.

Cheers, Daniel

> 
> On Thu, 2019-08-08 at 21:53 +0200, Daniel Vetter wrote:
> > On Wed, Jul 17, 2019 at 09:42:24PM -0400, Lyude Paul wrote:
> > > Since we're about to be calling this from multiple places. Also it makes
> > > things easier to read!
> > > 
> > > Cc: Juston Li <juston.li@intel.com>
> > > Cc: Imre Deak <imre.deak@intel.com>
> > > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > Cc: Harry Wentland <hwentlan@amd.com>
> > > Signed-off-by: Lyude Paul <lyude@redhat.com>
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > > ---
> > >  drivers/gpu/drm/drm_dp_mst_topology.c | 35 ++++++++++++++++++---------
> > >  1 file changed, 23 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > index 0984b9a34d55..998081b9b205 100644
> > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > @@ -2013,6 +2013,28 @@ static void drm_dp_queue_down_tx(struct
> > > drm_dp_mst_topology_mgr *mgr,
> > >  	mutex_unlock(&mgr->qlock);
> > >  }
> > >  
> > > +static void
> > > +drm_dp_dump_link_address(struct drm_dp_link_address_ack_reply *reply)
> > > +{
> > > +	struct drm_dp_link_addr_reply_port *port_reply;
> > > +	int i;
> > > +
> > > +	for (i = 0; i < reply->nports; i++) {
> > > +		port_reply = &reply->ports[i];
> > > +		DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn: %d, dpcd_rev:
> > > %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n",
> > > +			      i,
> > > +			      port_reply->input_port,
> > > +			      port_reply->peer_device_type,
> > > +			      port_reply->port_number,
> > > +			      port_reply->dpcd_revision,
> > > +			      port_reply->mcs,
> > > +			      port_reply->ddps,
> > > +			      port_reply->legacy_device_plug_status,
> > > +			      port_reply->num_sdp_streams,
> > > +			      port_reply->num_sdp_stream_sinks);
> > > +	}
> > > +}
> > > +
> > >  static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
> > >  				     struct drm_dp_mst_branch *mstb)
> > >  {
> > > @@ -2038,18 +2060,7 @@ static void drm_dp_send_link_address(struct
> > > drm_dp_mst_topology_mgr *mgr,
> > >  			DRM_DEBUG_KMS("link address nak received\n");
> > >  		} else {
> > >  			DRM_DEBUG_KMS("link address reply: %d\n", txmsg-
> > > >reply.u.link_addr.nports);
> > > -			for (i = 0; i < txmsg->reply.u.link_addr.nports; i++)
> > > {
> > > -				DRM_DEBUG_KMS("port %d: input %d, pdt: %d, pn:
> > > %d, dpcd_rev: %02x, mcs: %d, ddps: %d, ldps %d, sdp %d/%d\n", i,
> > > -				       txmsg-
> > > >reply.u.link_addr.ports[i].input_port,
> > > -				       txmsg-
> > > >reply.u.link_addr.ports[i].peer_device_type,
> > > -				       txmsg-
> > > >reply.u.link_addr.ports[i].port_number,
> > > -				       txmsg-
> > > >reply.u.link_addr.ports[i].dpcd_revision,
> > > -				       txmsg->reply.u.link_addr.ports[i].mcs,
> > > -				       txmsg->reply.u.link_addr.ports[i].ddps,
> > > -				       txmsg-
> > > >reply.u.link_addr.ports[i].legacy_device_plug_status,
> > > -				       txmsg-
> > > >reply.u.link_addr.ports[i].num_sdp_streams,
> > > -				       txmsg-
> > > >reply.u.link_addr.ports[i].num_sdp_stream_sinks);
> > > -			}
> > > +			drm_dp_dump_link_address(&txmsg->reply.u.link_addr);
> > >  
> > >  			drm_dp_check_mstb_guid(mstb, txmsg-
> > > >reply.u.link_addr.guid);
> > >  
> > > -- 
> > > 2.21.0
> > > 
> -- 
> Cheers,
> 	Lyude Paul
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
