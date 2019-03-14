Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C6BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D840721872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IXODJ79V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfCNPy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 11:54:59 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:55134 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbfCNPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 11:54:54 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2EFskie116047;
        Thu, 14 Mar 2019 10:54:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552578886;
        bh=JuRJZcsL7dV1ONwDJpjUxO8QNMOl3XY3FrYYaCJUQiI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IXODJ79VZ6HaVXvBnTEDKsEVYyW/dpRkhbZKNz6X6wS4G/ZX4i/u7DWFAEgv1le0s
         yp46hVVapc/PyZGYF7QFP16kH0Jq1UWQTbos6RMJRZHkvYqbUzTjo9JKZWi7kKfrxC
         GwDeCGfEQUbg3MNODGXdTZsPAoI751N5SnNttWjU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2EFskk1120281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Mar 2019 10:54:46 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Mar 2019 10:54:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Mar 2019 10:54:46 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2EFsjKs004984;
        Thu, 14 Mar 2019 10:54:45 -0500
Date:   Thu, 14 Mar 2019 10:54:48 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
CC:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [Patch 1/1] drm/atomic: integrate private objects with
 suspend/resume helpers
Message-ID: <20190314155448.ea5wgfexnaeymdrm@ti.com>
References: <20190314134445.19260-1-bparrot@ti.com>
 <20190314153129.GS3888@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190314153129.GS3888@intel.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Syrjälä <ville.syrjala@linux.intel.com> wrote on Thu [2019-Mar-14 17:31:29 +0200]:
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
> 
> Random order between crtc vs. plane vs. connector vs. priv is tickling
> my ocd nerve a bit.

These loops are independent from each other.
And even without this patch the order is different between
drm_atomic_helper_duplicate_state() and
drm_atomic_helper_commit_duplicated_state(). :)

Benoit

> 
> Otherwise looks sensible to me.
> Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> >  
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel
