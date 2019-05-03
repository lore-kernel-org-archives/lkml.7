Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DD0C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B1E2070B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="BkMRxbqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfECMez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:34:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44847 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfECMey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:34:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id a26so4088269qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HQCWkD02UuJ46Q1rwovoVdgm8/GrwcbowVGD21eRLW0=;
        b=BkMRxbqoB4Ni4opdWas0Co43y1fT7BzuU1+xfg8pUzVxtpn85ogmwVitP7RWC3sral
         wcgcG1nrQ5+jkyBhpLQEL/LWwn0T+F+eRFAPqBnmdhqrR6qHJlbVc1ELnlBktsLAd6cZ
         QI+yFqAVzi1JYFsln+VrXei9nD+uTQZ5s51jN/hMxw7Kq64G/r6dEsPu3IH0AL4+uyOF
         xn44NOzwF78cpfn4WXegAfSgMcET48jV1ljNKxaT5U0624nDK8hNzPyllntlrBOTqV9B
         J4kqdzmYh0sclpGwYrNMPASFh9z0k6q9VNax2WsjQab8aUjx4rC2Gff9BghBT0Fuk6fN
         taYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HQCWkD02UuJ46Q1rwovoVdgm8/GrwcbowVGD21eRLW0=;
        b=BZnevkkp+rojOTsPj+IV9h2Xe/BcGA2XwjhAFyEOcMVrLV+qsoTmsnuSYC6KRRSxwG
         8SMp7dJmaJ9vV/FqR3VAYZ8s8M5Au7targIpNnPUKMKmzpmbEgEhASyHC6ujtqLUe3+b
         YQUst45G7/yZdnp4jfA48YMrG0tNvDR7+76VRPK7y/rq9Uao5JCDep3H/RxyRjOULSY5
         9sMoI5xOUyPKts2W7wYp8BZUZFuaO5Ud2eoyrUfUipbVF4enAkpoB738Ns6rAzqR337+
         LeTAIsOZajJHupE3245JNa/feFlinQUqGM0dKylLPVA8oOvqbZXnhdNvMUYJB6z1eF0E
         6s+g==
X-Gm-Message-State: APjAAAXVBNvffqcv+CLAMY6sLBaqgfSqnoScPyEpTEdoqjSzolXs+VTt
        gqT/45Mgh3qhCexRlz0UA8RjzQ==
X-Google-Smtp-Source: APXvYqxuibzfNraW5GGjbWPqValD3EhNqGQ1P0nM2BXoikIUeg4+U7viNsyi5y989BN/Ql0nOIcTVA==
X-Received: by 2002:a0c:b758:: with SMTP id q24mr7595743qve.69.1556886893256;
        Fri, 03 May 2019 05:34:53 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id o10sm1039729qtg.5.2019.05.03.05.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 05:34:52 -0700 (PDT)
Date:   Fri, 3 May 2019 08:34:52 -0400
From:   Sean Paul <sean@poorly.run>
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Sean Paul <seanpaul@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] drm: Add atomic variants of enable/disable to
 encoder helper funcs
Message-ID: <20190503123452.GG17077@art_vandelay>
References: <20190502194956.218441-1-sean@poorly.run>
 <20190502194956.218441-2-sean@poorly.run>
 <20190503075130.GH3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503075130.GH3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 09:51:30AM +0200, Daniel Vetter wrote:
> On Thu, May 02, 2019 at 03:49:43PM -0400, Sean Paul wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> > 
> > This patch adds atomic_enable and atomic_disable callbacks to the
> > encoder helpers. This will allow encoders to make informed decisions in
> > their start-up/shutdown based on the committed state.
> > 
> > Aside from the new hooks, this patch also introduces the new signature
> > for .atomic_* functions going forward. Instead of passing object state
> > (well, encoders don't have atomic state, but let's ignore that), we pass
> > the entire atomic state so the driver can inspect more than what's
> > happening locally.
> > 
> > This is particularly important for the upcoming self refresh helpers.
> > 
> > Changes in v3:
> > - Added patch to the set
> > 
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c      |  6 +++-
> >  include/drm/drm_modeset_helper_vtables.h | 45 ++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+), 1 deletion(-)

/snip

> > diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> > index 8f3602811eb5..de57fb40cb6e 100644
> > --- a/include/drm/drm_modeset_helper_vtables.h
> > +++ b/include/drm/drm_modeset_helper_vtables.h
> > @@ -675,6 +675,51 @@ struct drm_encoder_helper_funcs {
> >  	enum drm_connector_status (*detect)(struct drm_encoder *encoder,
> >  					    struct drm_connector *connector);
> >  
> > +	/**
> > +	 * @atomic_disable:
> > +	 *
> > +	 * This callback should be used to disable the encoder. With the atomic
> > +	 * drivers it is called before this encoder's CRTC has been shut off
> > +	 * using their own &drm_crtc_helper_funcs.atomic_disable hook. If that
> > +	 * sequence is too simple drivers can just add their own driver private
> > +	 * encoder hooks and call them from CRTC's callback by looping over all
> > +	 * encoders connected to it using for_each_encoder_on_crtc().
> > +	 *
> > +	 * This callback is a variant of @disable that provides the atomic state
> > +	 * to the driver. It takes priority over @disable during atomic commits.
> > +	 *
> > +	 * This hook is used only by atomic helpers. Atomic drivers don't need
> > +	 * to implement it if there's no need to disable anything at the encoder
> > +	 * level. To ensure that runtime PM handling (using either DPMS or the
> > +	 * new "ACTIVE" property) works @atomic_disable must be the inverse of
> > +	 * @atomic_enable.
> > +	 */
> 
> I'd add something like "For atomic drivers also consider @atomic_disable"
> to the kerneldoc of @disable (before the NOTE: which is only relevant for
> pre-atomic). Same for the enable side.
> 
> > +	void (*atomic_disable)(struct drm_encoder *encoder,
> > +			       struct drm_atomic_state *state);
> > +
> > +	/**
> > +	 * @atomic_enable:
> > +	 *
> > +	 * This callback should be used to enable the encoder. It is called
> > +	 * after this encoder's CRTC has been enabled using their own
> > +	 * &drm_crtc_helper_funcs.atomic_enable hook. If that sequence is
> > +	 * too simple drivers can just add their own driver private encoder
> > +	 * hooks and call them from CRTC's callback by looping over all encoders
> > +	 * connected to it using for_each_encoder_on_crtc().
> > +	 *
> > +	 * This callback is a variant of @enable that provides the atomic state
> > +	 * to the driver. It is called in place of @enable during atomic
> > +	 * commits.
> 
> needs to be adjusted here for "takes priority".

Can you clarify this comment? I'm a little fuzzy on what it means.



> > +	 *
> > +	 * This hook is used only by atomic helpers, for symmetry with @disable.
> > +	 * Atomic drivers don't need to implement it if there's no need to
> > +	 * enable anything at the encoder level. To ensure that runtime PM
> > +	 * handling (using either DPMS or the new "ACTIVE" property) works
> > +	 * @enable must be the inverse of @disable for atomic drivers.
> > +	 */
> > +	void (*atomic_enable)(struct drm_encoder *encoder,
> > +			      struct drm_atomic_state *state);
> > +
> 
> With the nits:
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Thanks!

Sean

> 
> >  	/**
> >  	 * @disable:
> >  	 *
> > -- 
> > Sean Paul, Software Engineer, Google / Chromium OS
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Sean Paul, Software Engineer, Google / Chromium OS
