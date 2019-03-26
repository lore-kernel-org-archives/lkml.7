Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C1CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6413C20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="W2q1OdpA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbfCZHuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:50:09 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34252 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731119AbfCZHuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:50:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id x14so7200896eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HlQL5khkiDc7oMB1owvWU5umlRaAjqlftY/ZU/SvCuc=;
        b=W2q1OdpAWaZFK+NljSbNTZ3Hef8esZvXzMI4MKtEGSmEooQ7bDKih+yIzxX6e5oUTz
         8n/eMN1ZTqdXQVubwO5ZNlUVxv2Y9uWt0lkt920dr2JqfSRK0c8eyb7jAWWBOEwuO4xV
         PaIy+VY95bBbmILrkbso0di1Gk1FKjSbiqhnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HlQL5khkiDc7oMB1owvWU5umlRaAjqlftY/ZU/SvCuc=;
        b=qOob2QpFfpFqQEk6t5MUFtdE147yzl48HPBKAGOZoR/gIQ+Rd22e61q3FcnmKvP5F2
         zqi/1zVssTi9Mm6yULV16/rQn9dNQoQgh8EY3CRtejIkUVxgNaLi4qW1pJvuW+hPLp9d
         midbkpwW6QsWVjC7jGAWanICXxnNk2h4HEQ1TzuEIXPBa5S5Zi5IvcRednKAgduxUwwW
         5e8DwRFaCbOncdUbfduAboZ2CPCrjDh2kbFSnofMSiSuxoAErZfPErrxkNmnL+/3J7Tx
         wi7vpYOXg5UsN0whmzulsAQg4QXtK5q6mOCAKJ1ub1+HrhtJQVdtJnYEHouOa8m8EjJZ
         22cA==
X-Gm-Message-State: APjAAAVz4qsdxiu7ZwYEzbup8KMfqT+4tjOe9/2Qjzr3C+Vb+rp3/8q5
        wVjeXVPi0v8lSdGwkHbR+nFMtA==
X-Google-Smtp-Source: APXvYqzz3jOLd1WipXS5NfnrspG8KUYEI8BZPoyn31ojf0YnQHid/Ckq5Y8wM3hfLXuBZyFXk0ElmA==
X-Received: by 2002:a17:906:b291:: with SMTP id q17mr16844208ejz.56.1553586606273;
        Tue, 26 Mar 2019 00:50:06 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id w9sm6643191edw.41.2019.03.26.00.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 00:50:05 -0700 (PDT)
Date:   Tue, 26 Mar 2019 08:50:03 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] drm/atomic-helper: Make atomic_enable/disable crtc
 callbacks optional
Message-ID: <20190326075003.GH2665@phenom.ffwll.local>
Mail-Followup-To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20190314184845.gjmvkamobj4dilyp@smtp.gmail.com>
 <20190315110031.GY2665@phenom.ffwll.local>
 <20190325112906.p4zfgom3by3f2zu4@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190325112906.p4zfgom3by3f2zu4@smtp.gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 08:29:06AM -0300, Rodrigo Siqueira wrote:
> On 03/15, Daniel Vetter wrote:
> > On Thu, Mar 14, 2019 at 03:48:45PM -0300, Rodrigo Siqueira wrote:
> > > Allow atomic_enable and atomic_disable operations from
> > > drm_crtc_helper_funcs struct optional. With this, the target display
> > > drivers don't need to define a dummy function if they don't need one.
> > > 
> > > Changes since v2:
> > > * Don't make funcs optional
> > > * Update kerneldoc for atomic_enable/disable
> > > * Replace "if (funcs->atomic_enable)" by "if (funcs->commit)"
> > > * Improve commit message
> > > 
> > > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Hi,
> Is it ok if I apply this patch?

Sure.
-Daniel

>  
> > > ---
> > >  drivers/gpu/drm/drm_atomic_helper.c      | 5 ++---
> > >  include/drm/drm_modeset_helper_vtables.h | 4 ++++
> > >  2 files changed, 6 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > > index 540a77a2ade9..d506e13c2945 100644
> > > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > > @@ -1034,7 +1034,7 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> > >  			funcs->atomic_disable(crtc, old_crtc_state);
> > >  		else if (funcs->disable)
> > >  			funcs->disable(crtc);
> > > -		else
> > > +		else if (funcs->dpms)
> > >  			funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
> > >  
> > >  		if (!(dev->irq_enabled && dev->num_crtcs))
> > > @@ -1277,10 +1277,9 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> > >  		if (new_crtc_state->enable) {
> > >  			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
> > >  					 crtc->base.id, crtc->name);
> > > -
> > >  			if (funcs->atomic_enable)
> > >  				funcs->atomic_enable(crtc, old_crtc_state);
> > > -			else
> > > +			else if (funcs->commit)
> > >  				funcs->commit(crtc);
> > >  		}
> > >  	}
> > > diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> > > index cfb7be40bed7..ce4de6b1e444 100644
> > > --- a/include/drm/drm_modeset_helper_vtables.h
> > > +++ b/include/drm/drm_modeset_helper_vtables.h
> > > @@ -418,6 +418,8 @@ struct drm_crtc_helper_funcs {
> > >  	 * Drivers can use the @old_crtc_state input parameter if the operations
> > >  	 * needed to enable the CRTC don't depend solely on the new state but
> > >  	 * also on the transition between the old state and the new state.
> > > +	 *
> > > +	 * This function is optional.
> > >  	 */
> > >  	void (*atomic_enable)(struct drm_crtc *crtc,
> > >  			      struct drm_crtc_state *old_crtc_state);
> > > @@ -441,6 +443,8 @@ struct drm_crtc_helper_funcs {
> > >  	 * parameter @old_crtc_state which could be used to access the old
> > >  	 * state. Atomic drivers should consider to use this one instead
> > >  	 * of @disable.
> > > +	 *
> > > +	 * This function is optional.
> > >  	 */
> > >  	void (*atomic_disable)(struct drm_crtc *crtc,
> > >  			       struct drm_crtc_state *old_crtc_state);
> > > -- 
> > > 2.21.0
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
> 
> -- 
> Rodrigo Siqueira
> https://siqueira.tech
> Graduate Student
> Department of Computer Science
> University of São Paulo



> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
