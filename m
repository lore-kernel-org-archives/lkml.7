Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D2FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AA621920
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FGtqiS09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbfJVJTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:19:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52421 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbfJVJTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:19:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id r19so16344609wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 02:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=r4xbJW3grSnf4M8N0nCJmNaFSFrCKReYewNpwqEWw1I=;
        b=FGtqiS090+TGQJD//gAwTtX63ZcmUhqxCYUaSFDoCb3SG+hfsQ9BXYvIbAERWpV26E
         nvExslmfOp0xqb3UqiZUKTt6ZSazb5UOFbbRjLRGwF6wSP8CUZtMhsDdovh16u6N1Zqq
         tZH+AlYUfkMvQfCtL+XfwoYcRRTylo6Xi42JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=r4xbJW3grSnf4M8N0nCJmNaFSFrCKReYewNpwqEWw1I=;
        b=EoXzUzPKKXS3nroosGTUIuMEXVxsDqYgTB0lEqkh53FIKhaRvQc++bVfHBkYHDui3b
         9IbyqenPfkFQPO/yGTJmp9XWidL3XeTu4k3m9iWVgmu4tMDhfISYHvhYvyBzRb0exdDm
         6OOXgGRQwvofmu8wDaOYWqobcD73fSNGIgU906xP1YB4jf3z4aSKMx9tWViCUQpPJxLO
         O+pw+I0CUIkoJ0KrEpfOfBCwIkcpSykWLNmJ7bRBWtuqqOk/Ae0vnxnPU56ud9sf+V8/
         Chgo/mDXo/X1K5Abj5NLYYUTj+9KpwJhmP59swPZU2xuPq8kDM0WwWe7JaFreKJt7Rg+
         ABDg==
X-Gm-Message-State: APjAAAWrnaziv1sA4DkfOMdBPkfbW4thVURvnkRJxemqTnqIxgbkLo6Y
        h2A+87WKMzhMuYkyvQ+9Smx4FA==
X-Google-Smtp-Source: APXvYqz+BA4HFcNcao9aMxDu/3IGW/iUzAxv2dFWU7p6o7dSEVbaGXZxewrvEiq0K5iQ35jC0VObig==
X-Received: by 2002:a05:600c:214a:: with SMTP id v10mr1953407wml.69.1571735968600;
        Tue, 22 Oct 2019 02:19:28 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id a4sm17019422wmm.10.2019.10.22.02.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 02:19:27 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:19:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Wambui Karuga <wambui@karuga.xyz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        sean@poorly.run, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com,
        outreachy-kernel@googlegroups.com,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] drm: remove unnecessary return
 variable
Message-ID: <20191022091925.GD11828@phenom.ffwll.local>
Mail-Followup-To: Julia Lawall <julia.lawall@lip6.fr>,
        Wambui Karuga <wambui@karuga.xyz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, airlied@linux.ie, sean@poorly.run,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        outreachy-kernel@googlegroups.com,
        Wambui Karuga <wambui.karugax@gmail.com>
References: <20191019071840.16877-1-wambui@karuga.xyz>
 <alpine.DEB.2.21.1910192102410.5888@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910192102410.5888@hadrien>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2019 at 09:04:31PM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 19 Oct 2019, Wambui Karuga wrote:
> 
> > From: Wambui Karuga <wambui.karugax@gmail.com>
> >
> > Remove unnecessary variable `ret` in drm_dp_atomic_find_vcpi_slots()
> > only used to hold the function return value and have the function
> > return the value directly.
> 
> This patch applies for me, but with a huge offset.  What tree are you
> using?

For drm patches best practices is to base patches either on linux-next or
the drm-tip tree we have here:

https://cgit.freedesktop.org/drm-tip

drm moves quickly, so need to be on top of the latest version.

> Also, Greg won't apply this, because it's not targeting staging.  Is this
> for a specific outreachy project?

Yup it's for dri-devel, just applied it.

Thanks for the patch, nice cleanup!

Cheers, Daniel

> 
> julia
> 
> 
> > Issue found by coccinelle:
> > @@
> > local idexpression ret;
> > expression e;
> > @@
> >
> > -ret =
> > +return
> >      e;
> > -return ret;
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > ---
> >  drivers/gpu/drm/drm_dp_mst_topology.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> > index 9cccc5e63309..b854a422a523 100644
> > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > @@ -3540,7 +3540,7 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
> >  {
> >  	struct drm_dp_mst_topology_state *topology_state;
> >  	struct drm_dp_vcpi_allocation *pos, *vcpi = NULL;
> > -	int prev_slots, req_slots, ret;
> > +	int prev_slots, req_slots;
> >
> >  	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
> >  	if (IS_ERR(topology_state))
> > @@ -3587,8 +3587,7 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
> >  	}
> >  	vcpi->vcpi = req_slots;
> >
> > -	ret = req_slots;
> > -	return ret;
> > +	return req_slots;
> >  }
> >  EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
> >
> > --
> > 2.23.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191019071840.16877-1-wambui%40karuga.xyz.
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
