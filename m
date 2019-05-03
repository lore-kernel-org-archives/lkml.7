Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D036AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977962075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 12:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="biaR7wdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfECMrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 08:47:41 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38785 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfECMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 08:47:40 -0400
Received: by mail-qt1-f195.google.com with SMTP id d13so6486485qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 05:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8TlcXELtypENazsB13YSYv7OtGIbSTIqtTm4iwHMX5A=;
        b=biaR7wduWyeXF4OGwan7e7zRzytOemD10xfmr0EIKMRBB5VbZnkHx5ZRXBmcHtPe6m
         fEz9oKAJZisJrOiBBJp/uSIFg4q5ThxmcKIKf4J08wfsKnF3lzoAPGUDI4UPFHa57a3g
         rOQ+ceTC8VviSkFCUvg7GZBd28Fkgyqoi2daFW/TRg4ZKA8yufUdgb+j/LwykxHleVRT
         gEUJ0usJ24p4OQlTM1IVzWC7mT+GdY36yXeQDNKWKSzvPNkE5muSu3Kaq1xROzW7c0Ew
         DkIFfxtvDmq0Qz+dpLzyxRQlrm0Cskyf/9t4dcOegE+ekkmIwB6EUBoxxQH/Lu5aYzno
         huVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=8TlcXELtypENazsB13YSYv7OtGIbSTIqtTm4iwHMX5A=;
        b=XfC5tPD+Pmhvw8xcWdfltFNKJh4JDlNTgig6sChxxng2/MCbbuvNhTI4s7sPQhGZO2
         hXqGtPDF0/QfjsN7uSze7tpuGYGmagXGo1mb/mtcZH4R/KGwg0Qir0H3ZhD8PpaLbmkG
         q5Bqs59Kq8z5ZwYQ/qcclI+AVbfTSHtY3TRyvw8J1aKbRhvGvO8bFfiI4Sx/cl0BiV/U
         EX6T4MBGqNWLwbnUzMdn/wBIqo8y5OLdSXHxnBnqoV8VVX4nAOLmRBfIrd+gs0kHJOm8
         4O6thELS5bvxbzYev0hqw9O948AaqGhMmVfdRbbMuPuy2q8hOe38LySYjAleZyRoT1UL
         T8mQ==
X-Gm-Message-State: APjAAAWzBZzallpYyXEwM0qi32c7SHrIAdj89LxyEHh5MleUK8Oandlo
        EKYZgSY83vsF1HgV1To9sQBXRw==
X-Google-Smtp-Source: APXvYqxMRkdCxOqN8mRJNsE2ZPHuCziRAhwQ9ESG5WQKPvcysGhadM80NJ4Bb5y22c9EEIf64U5UcA==
X-Received: by 2002:ac8:1831:: with SMTP id q46mr7601025qtj.99.1556887658382;
        Fri, 03 May 2019 05:47:38 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id e54sm1434782qtc.26.2019.05.03.05.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 May 2019 05:47:38 -0700 (PDT)
Date:   Fri, 3 May 2019 08:47:37 -0400
From:   Sean Paul <sean@poorly.run>
To:     Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        Sean Paul <seanpaul@chromium.org>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/10] drm: Add drm_atomic_crtc_state_for_encoder
 helper
Message-ID: <20190503124737.GH17077@art_vandelay>
References: <20190502194956.218441-1-sean@poorly.run>
 <20190502194956.218441-3-sean@poorly.run>
 <20190503081851.GI3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503081851.GI3271@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 10:18:51AM +0200, Daniel Vetter wrote:
> On Thu, May 02, 2019 at 03:49:44PM -0400, Sean Paul wrote:
> > From: Sean Paul <seanpaul@chromium.org>
> > 
> > This patch adds a helper to tease out the currently connected crtc for
> > an encoder, along with its state. This follows the same pattern as the
> > drm_atomic_crtc_*_for_* macros in the atomic helpers. Since the
> > relationship of crtc:encoder is 1:n, we don't need a loop since there is
> > only one crtc per encoder.
> 
> No idea which macros you mean, couldn't find them.

No longer relevant with the changes below, but for completeness, I was trying to
refer to drm_atomic_crtc_state_for_each_plane and friends. I see now that I
wasn't terribly clear :)


> > 
> > Instead of splitting this into 3 functions which all do the same thing,
> > this is presented as one function. Perhaps that's too ugly and it should
> > be split to:
> > struct drm_crtc *drm_atomic_crtc_for_encoder(state, encoder);
> > struct drm_crtc_state *drm_atomic_new_crtc_state_for_encoder(state, encoder);
> > struct drm_crtc_state *drm_atomic_old_crtc_state_for_encoder(state, encoder);
> > 
> > Suggestions welcome.
> > 
> > Changes in v3:
> > - Added to the set
> > 
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > Signed-off-by: Sean Paul <seanpaul@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 48 +++++++++++++++++++++++++++++
> >  include/drm/drm_atomic_helper.h     |  6 ++++
> >  2 files changed, 54 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 71cc7d6b0644..1f81ca8daad7 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -3591,3 +3591,51 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(drm_atomic_helper_legacy_gamma_set);
> > +
> > +/**
> > + * drm_atomic_crtc_state_for_encoder - Get crtc and new/old state for an encoder
> > + * @state: Atomic state
> > + * @encoder: The encoder to fetch the crtc information for
> > + * @crtc: If not NULL, receives the currently connected crtc
> > + * @old_crtc_state: If not NULL, receives the crtc's old state
> > + * @new_crtc_state: If not NULL, receives the crtc's new state
> > + *
> > + * This function finds the crtc which is currently connected to @encoder and
> > + * returns it as well as its old and new state. If there is no crtc currently
> > + * connected, the function will clear @crtc, @old_crtc_state, @new_crtc_state.
> > + *
> > + * All of @crtc, @old_crtc_state, and @new_crtc_state are optional.
> > + */
> > +void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *state,
> > +				       struct drm_encoder *encoder,
> > +				       struct drm_crtc **crtc,
> > +				       struct drm_crtc_state **old_crtc_state,
> > +				       struct drm_crtc_state **new_crtc_state)
> > +{
> > +	struct drm_crtc *tmp_crtc;
> > +	struct drm_crtc_state *tmp_new_crtc_state, *tmp_old_crtc_state;
> > +	u32 enc_mask = drm_encoder_mask(encoder);
> > +	int i;
> > +
> > +	for_each_oldnew_crtc_in_state(state, tmp_crtc, tmp_old_crtc_state,
> > +				      tmp_new_crtc_state, i) {
> 
> So there's two ways to do this:
> 
> - Using encoder_mask, which is a helper thing. In that case I'd rename
>   this to drm_atomic_helper_crtc_for_encoder.
> 
> - By looping over the connectors, and looking at ->best_encoder and
>   ->crtc, see drm_encoder_get_crtc in drm_encoder.c. That's the core way
>   of doing things. In that case call it drm_atomic_crtc_for_encoder, and
>   put it into drm_atomic.c.
> 
> There's two ways of doing the 2nd one: looping over connectors in a
> drm_atomic_state, or the connector list overall. First requires that the
> encoder is already in drm_atomic_state (which I think makes sense).

Yeah, I wasn't particularly interested in encoders not in state. I had
considered going the connector route, but since you can have multiple connectors
per encoder, going through crtc seemed a bit more direct. 

> 
> Even more complications on old/new_crtc_state: Is that the old state for
> the old crtc, or the old state for the new crtc (that can switch too).
> Same for the new crtc state ...
> 
> tldr; I'd create 2 functions:
> 
> drm_crtc *drm_atomic_encoder_get_new_crtc(drm_atomic_state *state, encoder)
> drm_crtc *drm_atomic_encoder_get_old_crtc(drm_atomic_state *state, encoder)
> 
> With the requirement that they'll return NULL if the encder isn't in in
> @state, and implemented using looping over connectors in @state.

It seems like we could just tweak this function a bit to get the new or old crtc
for an encoder. Any particular reason for going through connector instead? Is it
to avoid the encoder_mask which is a helper thing? In that case, perhaps this
should use connector links and live in drm_atomic.c?

Thanks for the review!

Sean

> 
> tldr; this is a lot more tricky than it looks like ...
> -Daniel
> 
> 
> > +		if (!(tmp_new_crtc_state->encoder_mask & enc_mask))
> > +			continue;
> > +
> > +		if (new_crtc_state)
> > +			*new_crtc_state = tmp_new_crtc_state;
> > +		if (old_crtc_state)
> > +			*old_crtc_state = tmp_old_crtc_state;
> > +		if (crtc)
> > +			*crtc = tmp_crtc;
> > +		return;
> > +	}
> > +
> > +	if (new_crtc_state)
> > +		*new_crtc_state = NULL;
> > +	if (old_crtc_state)
> > +		*old_crtc_state = NULL;
> > +	if (crtc)
> > +		*crtc = NULL;
> > +}
> > +EXPORT_SYMBOL(drm_atomic_crtc_state_for_encoder);
> > diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
> > index 58214be3bf3d..2383550a0cc8 100644
> > --- a/include/drm/drm_atomic_helper.h
> > +++ b/include/drm/drm_atomic_helper.h
> > @@ -153,6 +153,12 @@ int drm_atomic_helper_legacy_gamma_set(struct drm_crtc *crtc,
> >  				       uint32_t size,
> >  				       struct drm_modeset_acquire_ctx *ctx);
> >  
> > +void drm_atomic_crtc_state_for_encoder(struct drm_atomic_state *state,
> > +				       struct drm_encoder *encoder,
> > +				       struct drm_crtc **crtc,
> > +				       struct drm_crtc_state **old_crtc_state,
> > +				       struct drm_crtc_state **new_crtc_state);
> > +
> >  /**
> >   * drm_atomic_crtc_for_each_plane - iterate over planes currently attached to CRTC
> >   * @plane: the loop cursor
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
