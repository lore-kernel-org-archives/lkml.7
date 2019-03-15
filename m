Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE54C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0843521872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A71clicF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfCOL4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:56:11 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42452 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfCOL4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:56:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2FBu5oT036824;
        Fri, 15 Mar 2019 06:56:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552650965;
        bh=mPAANsWtO9Lj4tn9BGvyEKxCkxuxqEg2kIcIZXVylEM=;
        h=Date:From:To:Subject:References:In-Reply-To;
        b=A71clicF0/eSqKJfMsQmnsS2Dboa7v1WeCK316V749q0mJGLXxBK+RrdcrkVBnqak
         0KR0yG2RcZkApvwkMBzfsy6P2d3itYvB/5t27/BzRhVy+bMeYCgvkMA+NfeB6jQVuE
         GWRPrDiXfnlqwbG2GneLldaMx0FTj2qTIPuMByjs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2FBu5VU026278
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Mar 2019 06:56:05 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 15
 Mar 2019 06:56:04 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Fri, 15 Mar 2019 06:56:04 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with SMTP id x2FBu4ed005790;
        Fri, 15 Mar 2019 06:56:04 -0500
Date:   Fri, 15 Mar 2019 06:56:07 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch 1/1] drm/atomic: integrate private objects with
 suspend/resume helpers
Message-ID: <20190315115607.v4avbfbp3hyytsl6@ti.com>
References: <20190314134445.19260-1-bparrot@ti.com>
 <20190315105057.GU2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190315105057.GU2665@phenom.ffwll.local>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Vetter <daniel@ffwll.ch> wrote on Fri [2019-Mar-15 11:50:57 +0100]:
> On Thu, Mar 14, 2019 at 08:44:45AM -0500, Benoit Parrot wrote:
> > During a suspend cycle the atomic state is saved to be used during the
> > restore cycle.
> > 
> > However the current state duplication logic does not duplicate private
> > objects. This leads to state inconsistencies at resume time.
> > 
> > With private objects modeset lock now integrated, we can make sure that
> > private object state are properly saved and restored.
> > 
> > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> 
> Why do you need this? We're doing a full atomic_check, and your
> atomic_check should be pulling in any private state objects and
> recomputing their states. This smells like papering over a driver bug.

I have not seen any atomic_check called during the suspend duplicate
helper. And you are correct normally the private_object state in my case
would get pulled in during a plane atomic_check but that does not happen
here in this step.

Why wouldn't we save all the "state" artifacts so that the whole atomic
state is consistent?

Benoit

> 
> The duplicate helpers should only need to duplicate the uapi-relevant
> states, i.e. connector/crtc/planes.
> -Daniel
> 
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 540a77a2ade9..b108021cc092 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -3189,6 +3189,7 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
> >  	struct drm_connector_list_iter conn_iter;
> >  	struct drm_plane *plane;
> >  	struct drm_crtc *crtc;
> > +	struct drm_private_obj *privobj;
> >  	int err = 0;
> >  
> >  	state = drm_atomic_state_alloc(dev);
> > @@ -3218,6 +3219,16 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
> >  		}
> >  	}
> >  
> > +	drm_for_each_privobj(privobj, dev) {
> > +		struct drm_private_state *priv_state;
> > +
> > +		priv_state = drm_atomic_get_private_obj_state(state, privobj);
> > +		if (IS_ERR(priv_state)) {
> > +			err = PTR_ERR(priv_state);
> > +			goto free;
> > +		}
> > +	}
> > +
> >  	drm_connector_list_iter_begin(dev, &conn_iter);
> >  	drm_for_each_connector_iter(conn, &conn_iter) {
> >  		struct drm_connector_state *conn_state;
> > @@ -3325,12 +3336,17 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
> >  	struct drm_connector_state *new_conn_state;
> >  	struct drm_crtc *crtc;
> >  	struct drm_crtc_state *new_crtc_state;
> > +	struct drm_private_obj *privobj;
> > +	struct drm_private_state *new_priv_state;
> >  
> >  	state->acquire_ctx = ctx;
> >  
> >  	for_each_new_plane_in_state(state, plane, new_plane_state, i)
> >  		state->planes[i].old_state = plane->state;
> >  
> > +	for_each_new_private_obj_in_state(state, privobj, new_priv_state, i)
> > +		state->private_objs[i].old_state = privobj->state;
> > +
> >  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
> >  		state->crtcs[i].old_state = crtc->state;
> >  
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
