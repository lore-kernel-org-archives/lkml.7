Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7059BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3681020879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LSvLerKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfCYJGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:06:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42011 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfCYJGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:06:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id x61so1124558edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LimTLnNCW4JMZi5iGNYNTntLTetuC7RZIGjcu5prQlQ=;
        b=LSvLerKUPTEctaHazqpIWucuinU7oQN33E3c5KBgNGLsXJUqMTaO+c7hveUcIUe0HU
         wYl/XBlQW6NbXM4ud5zauY9s6TFn2eBFarBqWEYlIv8HJbd/gsRhXUkH0cYhyYnnGkRz
         afVN7IQo9cTzZ7CYUcbNucypm6AHPRpMinbMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=LimTLnNCW4JMZi5iGNYNTntLTetuC7RZIGjcu5prQlQ=;
        b=ARWIIWpjUIlrOF4USWMoniMsUCwaBpYopxizk7tvq+m6R1BIg1UFyTb7C85z/wA6O3
         NtV96jZbtD+YHzCjl/3y/e6XV/vV0phh/AXkFNmonGlMg4R6X05LXlFbxNANOcj2i2HM
         BnwFLRPkM0z8t31D8jkC/hbS/iA/3WpcyLTdp31sYV0f8IuJ83nzyWdno7Rsuya8xuoX
         cfUwklgDixLp8d/2jUmKjnW2Ub1mdf7d2Nw96iSwjQ93FgsgPZFKozmIt9iPjvW6Oicn
         RCbI8ErXKe0g6enHcTp2DEEuvTpuxpyJ6lT7VHlQBoXeHx85U4yQNncC5aL2W+Sgmy7y
         PFUg==
X-Gm-Message-State: APjAAAXo2Q2B0P4pC7N54YVzxz4x8r8EgW9i91s6dD0bR+SGShhW2QTq
        7GZt0wD9btdwPA7yEqRiceR5ZUDPl5RU2w==
X-Google-Smtp-Source: APXvYqwB8VKy3DMnj62hcDL8n18TChUTKMTaV+96kmLKDYjbfyf+fe+5V/Tw8nM8dTgX89MUrDACOA==
X-Received: by 2002:a17:906:960a:: with SMTP id s10mr13196157ejx.141.1553504803825;
        Mon, 25 Mar 2019 02:06:43 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id x54sm1702836edd.35.2019.03.25.02.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 02:06:43 -0700 (PDT)
Date:   Mon, 25 Mar 2019 10:06:41 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>
Subject: Re: [Patch 1/1] drm/atomic: integrate private objects with
 suspend/resume helpers
Message-ID: <20190325090641.GF2665@phenom.ffwll.local>
Mail-Followup-To: Benoit Parrot <bparrot@ti.com>,
        Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>
References: <20190314134445.19260-1-bparrot@ti.com>
 <20190315105057.GU2665@phenom.ffwll.local>
 <20190315115607.v4avbfbp3hyytsl6@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315115607.v4avbfbp3hyytsl6@ti.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 06:56:07AM -0500, Benoit Parrot wrote:
> Daniel Vetter <daniel@ffwll.ch> wrote on Fri [2019-Mar-15 11:50:57 +0100]:
> > On Thu, Mar 14, 2019 at 08:44:45AM -0500, Benoit Parrot wrote:
> > > During a suspend cycle the atomic state is saved to be used during the
> > > restore cycle.
> > > 
> > > However the current state duplication logic does not duplicate private
> > > objects. This leads to state inconsistencies at resume time.
> > > 
> > > With private objects modeset lock now integrated, we can make sure that
> > > private object state are properly saved and restored.
> > > 
> > > Signed-off-by: Benoit Parrot <bparrot@ti.com>
> > 
> > Why do you need this? We're doing a full atomic_check, and your
> > atomic_check should be pulling in any private state objects and
> > recomputing their states. This smells like papering over a driver bug.
> 
> I have not seen any atomic_check called during the suspend duplicate
> helper. And you are correct normally the private_object state in my case
> would get pulled in during a plane atomic_check but that does not happen
> here in this step.

Yeah duplicating in suspend won't call atomic_check. Restoring the
duplicated state on resume will (or there's going to be lots of broken
drivers).

> Why wouldn't we save all the "state" artifacts so that the whole atomic
> state is consistent?

It's not needed, and might possible paper over driver bugs ...

> > The duplicate helpers should only need to duplicate the uapi-relevant
> > states, i.e. connector/crtc/planes.

... because of this reason. If your driver can't recompute the private
state from just the duplicated uapi-relevant states it's broken. Because
essentially the exact same thing might happen through the atomic ioctl
from userspace.

Hence my question: Why do you need this?
-Daniel

> > -Daniel
> > 
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > index 540a77a2ade9..b108021cc092 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -3189,6 +3189,7 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
> > >  	struct drm_connector_list_iter conn_iter;
> > >  	struct drm_plane *plane;
> > >  	struct drm_crtc *crtc;
> > > +	struct drm_private_obj *privobj;
> > >  	int err = 0;
> > >  
> > >  	state = drm_atomic_state_alloc(dev);
> > > @@ -3218,6 +3219,16 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
> > >  		}
> > >  	}
> > >  
> > > +	drm_for_each_privobj(privobj, dev) {
> > > +		struct drm_private_state *priv_state;
> > > +
> > > +		priv_state = drm_atomic_get_private_obj_state(state, privobj);
> > > +		if (IS_ERR(priv_state)) {
> > > +			err = PTR_ERR(priv_state);
> > > +			goto free;
> > > +		}
> > > +	}
> > > +
> > >  	drm_connector_list_iter_begin(dev, &conn_iter);
> > >  	drm_for_each_connector_iter(conn, &conn_iter) {
> > >  		struct drm_connector_state *conn_state;
> > > @@ -3325,12 +3336,17 @@ int drm_atomic_helper_commit_duplicated_state(struct drm_atomic_state *state,
> > >  	struct drm_connector_state *new_conn_state;
> > >  	struct drm_crtc *crtc;
> > >  	struct drm_crtc_state *new_crtc_state;
> > > +	struct drm_private_obj *privobj;
> > > +	struct drm_private_state *new_priv_state;
> > >  
> > >  	state->acquire_ctx = ctx;
> > >  
> > >  	for_each_new_plane_in_state(state, plane, new_plane_state, i)
> > >  		state->planes[i].old_state = plane->state;
> > >  
> > > +	for_each_new_private_obj_in_state(state, privobj, new_priv_state, i)
> > > +		state->private_objs[i].old_state = privobj->state;
> > > +
> > >  	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i)
> > >  		state->crtcs[i].old_state = crtc->state;
> > >  
> > > -- 
> > > 2.17.1
> > > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
