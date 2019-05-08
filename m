Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA4AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC46621019
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="gaikjg5P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfEHSSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:18:05 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35239 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbfEHSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:18:05 -0400
Received: by mail-qt1-f193.google.com with SMTP id d20so6784336qto.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kbAhrbAD1+9aEWfsTS7QE2zb4dTStOFnf7mafivs+FA=;
        b=gaikjg5PPqIrxRrfn6rKpqudx87JmN/ZdE1x9g5e0xESCSRlRaH2iobUjBHFMcMYZv
         70VCdLXLZQ+pVPjnAhNVAk18Qf6qV35wza7iXRc06trK2DkMtFUPYHlwOYg4DBcov6v5
         AwPLJu9uIviNGGmFsAP3p2KfPzBLSC0pAzXfuhAXl6LfimnpDDyX9yyjnULQ3+gHLLOa
         vftNQvFI0wi7q8hC4dSJ1THLLsjB58oglADtrtcCRhGUiG4quma6FpwR9q/IVaCkNK8C
         mEeBxWBkqLzwTVd6/E3v5aIsYluVDcZraYlvjNL+054thDIqgnFypNPyuspluHFkIGgc
         w7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kbAhrbAD1+9aEWfsTS7QE2zb4dTStOFnf7mafivs+FA=;
        b=eGWJol5yA06oIalq+/BM+UhXkaeqMwl1HR046ePzDk5hbec+ufT/OAYlwSRTDbcREs
         l3MgYxDuQ5YcPBeukcdOUGMHYa04/55JnAtmQfu93ON4/STHwA7f5M0GU6oBhc0JdXof
         9+HoYdfpdbsfXOCel5dpovX8amKPb6NKzDDpVNM0YYLMQRftjW99AHeejI8VbJUEYhCb
         NydRAIyijUIdaUsEpO980V6/6rtIXiPLuW3YO5p/tMZPGZo7Zb68fIErfeG4uVZtE+H4
         eTElW4KI6SmkYVAf8ILMPaaLEHTBq9a1nGO++vR/US45oL9kQ1BSYl9mSaYwsOvUJcVq
         b1Hw==
X-Gm-Message-State: APjAAAUBWPNQn1+pe/dgogjJVwTHbVsvvwS1NQpjFYK5A94vyIlHrgR4
        ChcdwzHkiBtq/l8m5joot+kQag==
X-Google-Smtp-Source: APXvYqxj60v9FyhiZmndUyfvm0NF5iwXNRgIDzuhl+NXARgPGUR7R/7YL1CLAT5G4yWSTSzw5pX5fQ==
X-Received: by 2002:a0c:b5ef:: with SMTP id o47mr14137466qvf.142.1557339484159;
        Wed, 08 May 2019 11:18:04 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id i9sm8449950qkl.12.2019.05.08.11.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 08 May 2019 11:18:03 -0700 (PDT)
Date:   Wed, 8 May 2019 14:18:02 -0400
From:   Sean Paul <sean@poorly.run>
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Sean Paul <seanpaul@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 01/11] drm: Add atomic variants of enable/disable to
 encoder helper funcs
Message-ID: <20190508181802.GK17077@art_vandelay>
References: <20190508160920.144739-1-sean@poorly.run>
 <20190508160920.144739-2-sean@poorly.run>
 <20190508163124.GY17751@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190508163124.GY17751@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2019 at 06:31:24PM +0200, Daniel Vetter wrote:
> On Wed, May 08, 2019 at 12:09:06PM -0400, Sean Paul wrote:
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
> > Changes in v4:
> > - Move atomic_disable above prepare (Daniel)
> > - Add breadcrumb to .enable() docbook (Daniel)
> 
> Why no r-b: me or did you not apply all my suggestions? Too lazy to read
> it all again :-)

Sorry, I was being a bit conservative slapping your R-b on the patches I
changed. I've incorporated all of your suggestions AFAICT, so I've applied R-b
on patches 01/03/04/05 (conveniently the same patch numbers between v3 & v4).
Unless there's other review feedback I'll probably not send those out. I will
send out an update to Laurent's patch with your suggestions and R-b after a bit
of soak time on the list.

Sean


> -Daniel
> 
> > 
> > Link to v3: https://patchwork.freedesktop.org/patch/msgid/20190502194956.218441-2-sean@poorly.run
> > 
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c      |  8 +++-
> >  include/drm/drm_modeset_helper_vtables.h | 48 ++++++++++++++++++++++++
> >  2 files changed, 54 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 553415fe8ede..ccf01831f265 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -999,7 +999,9 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> >  
> >  		/* Right function depends upon target state. */
> >  		if (funcs) {
> > -			if (new_conn_state->crtc && funcs->prepare)
> > +			if (funcs->atomic_disable)
> > +				funcs->atomic_disable(encoder, old_state);
> > +			else if (new_conn_state->crtc && funcs->prepare)
> >  				funcs->prepare(encoder);
> >  			else if (funcs->disable)
> >  				funcs->disable(encoder);
> > @@ -1309,7 +1311,9 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> >  		drm_bridge_pre_enable(encoder->bridge);
> >  
> >  		if (funcs) {
> > -			if (funcs->enable)
> > +			if (funcs->atomic_enable)
> > +				funcs->atomic_enable(encoder, old_state);
> > +			else if (funcs->enable)
> >  				funcs->enable(encoder);
> >  			else if (funcs->commit)
> >  				funcs->commit(encoder);
> > diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> > index 8f3602811eb5..aa509c107083 100644
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
> >  	/**
> >  	 * @disable:
> >  	 *
> > @@ -691,6 +736,9 @@ struct drm_encoder_helper_funcs {
> >  	 * handling (using either DPMS or the new "ACTIVE" property) works
> >  	 * @disable must be the inverse of @enable for atomic drivers.
> >  	 *
> > +	 * For atomic drivers also consider @atomic_disable and save yourself
> > +	 * from having to read the NOTE below!
> > +	 *
> >  	 * NOTE:
> >  	 *
> >  	 * With legacy CRTC helpers there's a big semantic difference between
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
