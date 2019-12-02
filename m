Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A13C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6981821774
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 08:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="lpXqgi6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfLBItl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 03:49:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55878 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLBItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 03:49:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id a131so16460259wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 00:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OTj1RBCZb2YMCeCoS+sNA0hsSD1PCx/KWXCN5P/k7WI=;
        b=lpXqgi6RxG7r8QtKa9tbrp1YCJngkhiNJXJ0eZoRoKbbZGYJNMc2FmmkfOnrrr+aIS
         K1uhIrJieHIHhZBmIuypHu8pQnp34Mat7kQLu7jS8EH2TNQt0FpWNQ7d4/1QPg8FQecZ
         n0Jj0Bz2KoQ0dcXy3jkwRHHXpzCWTivuBmcYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=OTj1RBCZb2YMCeCoS+sNA0hsSD1PCx/KWXCN5P/k7WI=;
        b=oBQfFdooWIA9J/FkbmN98gI749yfOhlV/30VgxtA+NYe6emB03NumGo9GQHYCTxpm0
         YnznIvpQ1u4vV7V7QevnaD56bATdrBmHxJjLKjz0tI1LxGdHOyxglMOP/aT0X1x3ZJlP
         4Krhoze+LwfE4tdlgfQLoVX/vEgMJRruYu1s7TyVYeXSLil9wo6UPMa9X3fkCniPMFPE
         tY7B5iJGHZ2HNliM0XQPaIn5Ozqz8f3AMEe4hOQMPAKs+ZViud5nGKPqoa8czgPlotJS
         2x00VT99cF10xcU1DziVPZUSpiuzG/Wc3RqO7bpRvF6cnGwE/fDsaq4oSKppUE2AP36W
         yhJg==
X-Gm-Message-State: APjAAAUj8jC/e0hiIarC1LhvJMF3VpQT3bRw+z83DhO570UWrfnjCrB2
        n8zBvUpmXxH+ZPaHD9Is53VW6w==
X-Google-Smtp-Source: APXvYqynfMmdc+cNc63cE3ghvW6E0uyOdcT96eJ8oRbrseMVckK734QiBG7ddSOHI9zfdzlNiX+ppA==
X-Received: by 2002:a1c:4e03:: with SMTP id g3mr12747171wmh.22.1575276578020;
        Mon, 02 Dec 2019 00:49:38 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id a64sm25598619wmc.18.2019.12.02.00.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 00:49:37 -0800 (PST)
Date:   Mon, 2 Dec 2019 09:49:35 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     Mihail Atanassov <Mihail.Atanassov@arm.com>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [01/30] drm: Introduce drm_bridge_init()
Message-ID: <20191202084935.GW624164@phenom.ffwll.local>
Mail-Followup-To: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        David Airlie <airlied@linux.ie>, nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20191126131541.47393-2-mihail.atanassov@arm.com>
 <20191202055459.GA25729@jamwan02-TSP300>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202055459.GA25729@jamwan02-TSP300>
X-Operating-System: Linux phenom 5.3.0-2-amd64 
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2019 at 05:55:06AM +0000, james qian wang (Arm Technology China) wrote:
> On Tue, Nov 26, 2019 at 01:15:59PM +0000, Mihail Atanassov wrote:
> > A simple convenience function to initialize the struct drm_bridge.
> > 
> > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> > ---
> >  drivers/gpu/drm/drm_bridge.c | 29 +++++++++++++++++++++++++++++
> >  include/drm/drm_bridge.h     |  4 ++++
> >  2 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> > index cba537c99e43..cbe680aa6eac 100644
> > --- a/drivers/gpu/drm/drm_bridge.c
> > +++ b/drivers/gpu/drm/drm_bridge.c
> > @@ -89,6 +89,35 @@ void drm_bridge_remove(struct drm_bridge *bridge)
> >  }
> >  EXPORT_SYMBOL(drm_bridge_remove);
> >  
> > +/**
> > + * drm_bridge_init - initialise a drm_bridge structure
> > + *
> > + * @bridge: bridge control structure
> > + * @funcs: control functions
> > + * @dev: device
> > + * @timings: timing specification for the bridge; optional (may be NULL)
> > + * @driver_private: pointer to the bridge driver internal context (may be NULL)
> > + */
> > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > +		     const struct drm_bridge_funcs *funcs,
> > +		     const struct drm_bridge_timings *timings,
> > +		     void *driver_private)
> > +{
> > +	WARN_ON(!funcs);
> > +
> > +	bridge->dev = NULL;
> > +	bridge->encoder = NULL;
> > +	bridge->next = NULL;
> > +
> > +#ifdef CONFIG_OF
> > +	bridge->of_node = dev->of_node;
> > +#endif
> > +	bridge->timings = timings;
> > +	bridge->funcs = funcs;
> > +	bridge->driver_private = driver_private;
> 
> Can we directly put drm_bridge_add() here. then
> - User always need to call bridge_init and add together.
> - Consistent with others like drm_plane/crtc_init which directly has
>   drm_mode_object_add() in it.

Uh no, the trouble here is that drm_bridge_add should actually be called
_register, because it publishes the bridge to the world. I think we even
have a todo item to rename _add to _register ... Once that's done the
bridge can't be changed anymore, all init code must have completed. So
often you need a bit of code between _init() and _register().

drm_mode_object_add is different since for mode objects it doesn't publish
it to the world, that's done with drm_dev_register and
drm_connector_register. drm_mode_object_add just does a bit of internal
house keeping.
-Daniel

> 
> James.
> > +}
> > +EXPORT_SYMBOL(drm_bridge_init);
> > +
> >  /**
> >   * drm_bridge_attach - attach the bridge to an encoder's chain
> >   *
> > diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> > index c0a2286a81e9..d6d9d5301551 100644
> > --- a/include/drm/drm_bridge.h
> > +++ b/include/drm/drm_bridge.h
> > @@ -402,6 +402,10 @@ struct drm_bridge {
> >  
> >  void drm_bridge_add(struct drm_bridge *bridge);
> >  void drm_bridge_remove(struct drm_bridge *bridge);
> > +void drm_bridge_init(struct drm_bridge *bridge, struct device *dev,
> > +		     const struct drm_bridge_funcs *funcs,
> > +		     const struct drm_bridge_timings *timings,
> > +		     void *driver_private);
> >  struct drm_bridge *of_drm_find_bridge(struct device_node *np);
> >  int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
> >  		      struct drm_bridge *previous);
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
