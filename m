Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9198C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A605120657
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTi73R+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfCLLuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 07:50:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38907 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLLuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 07:50:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id s1so2102351qte.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 04:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FdWk95mnNz90mNbyQunPQIRfjCWGTE0UynpBtu3FQS4=;
        b=vTi73R+JxHhui8z72FVfrtS4+TZUHqrcU7CX67xXc0vD8sojupkG54bz7i6XHKpJR+
         ZerbeR+44IL5qx8CGapuZPLIcSqE8iBH69glRD45SnlFit7l9K0rWJpGhmZKjYIV9c0W
         G103BK7qjOVlSnnXIOyNaWRULBihiFRIOVNLx18g5lamxR+1PHLAmVCnEw22UIBli9E4
         L6/mkx8XApedaQEsCutHFvO+PdtkmDVOvM4su12sPsRFyiIrU9RyD3ZZc4Z3TQMEuEkW
         SYrT9dOBG4lHwzty0Ad0+cR2fJLDGHUvGqOkGtF3qvxWkSkxm0dyJ/06wT4FJAFoEMsV
         U88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FdWk95mnNz90mNbyQunPQIRfjCWGTE0UynpBtu3FQS4=;
        b=XqXmYlPnep/+fGHrjfk6WDIYWLKwiYXHIsVZOjfr1TBOCzjz1jFDAZaevd+Ccc4FP4
         k6H0Hdu5sar4gqqkY85ENpgOq073AivSH1GdbzrhJ5n4xopGqKy0LOQE9fkPjbhFK4u2
         nt6Jr57HXSsS2D8oxVzYE6PPJ/fgCf/d+qONwfpmFjgz7p3F8Ood6DGkftEQk56iQcZa
         wCCuP85B3oxYV4b7bSw7M6Z4+zDor/HRji7xw23PdGag51iQRf/8wsn3DjW4cMNGhQDZ
         1k2Uptk98IoW/4SHSa0K5VtELVBIQIafap1LUNQAoBa6y/AfYAyakylydUEQxLObxYz4
         IvNA==
X-Gm-Message-State: APjAAAWuKwlQfTRfMm+9mFMKh20rRtz+2/orBQgZbqJe7083HG5/fSGd
        A1jWfJYTzkKMdwayrMnx/2c=
X-Google-Smtp-Source: APXvYqz4ktxbUamWeFCFTli3yZWrU/PBKd3+XdlJqTQubKJakCa+YJ1UwFZWDowLO+qbgod1e+e64A==
X-Received: by 2002:a0c:ba9d:: with SMTP id x29mr29669872qvf.112.1552391412106;
        Tue, 12 Mar 2019 04:50:12 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o2sm3015601qkj.13.2019.03.12.04.50.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Mar 2019 04:50:10 -0700 (PDT)
Date:   Tue, 12 Mar 2019 08:50:07 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/atomic-helper: Validate pointer before dereference
Message-ID: <20190312115007.6k65cqwvfcs2tewk@smtp.gmail.com>
References: <20190311210120.fdixvenmqjoxuoqt@smtp.gmail.com>
 <20190312110044.GA2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312110044.GA2665@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First of all, thanks for the feedback.

I will fix all the problems pointed out in the review.

I just have two inline questions.

On 03/12, Daniel Vetter wrote:
> On Mon, Mar 11, 2019 at 06:01:20PM -0300, Rodrigo Siqueira wrote:
> > The function disable_outputs() and
> > drm_atomic_helper_commit_modeset_enables() tries to retrieve
> > helper_private from the target CRTC, for dereferencing some operations.
> > However, the current implementation does not check whether
> > helper_private is null and, if not, if it has a valid pointer to a dpms
> > and commit functions. This commit adds pointer validations before
> > trying to dereference the dpms and commit function.
> > 
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> 
> Please also adjust the kerneldoc for these functions. And I think the
> patch subject can be improved, e.g. "Make ->atomic_enable/disable crtc
> callbacks optional". Describe what you're trying to achieve in the
> summary, not how you achieve it.

Do I need to add information which says that both functions are
optional? I'm asking because the description related to the affected
functions and struct looks good for me [1,2,3].

1. Documentation for drm_crtc_helper_funcs:
https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html?highlight=drm_crtc_helper_funcs#c.drm_crtc_helper_funcs

2. Documentation for drm_atomic_helper_commit_modeset_enables():
https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html?highlight=drm_atomic_helper_commit_modeset_enables#c.drm_atomic_helper_commit_modeset_enables

3. Documentation for drm_atomic_helper_commit_modeset_disables():
https://dri.freedesktop.org/docs/drm/gpu/drm-kms-helpers.html?highlight=drm_atomic_helper_commit_modeset_disables#c.drm_atomic_helper_commit_modeset_disables

> > ---
> >  drivers/gpu/drm/drm_atomic_helper.c | 30 ++++++++++++++++-------------
> >  1 file changed, 17 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> > index 540a77a2ade9..fbeef7c461fc 100644
> > --- a/drivers/gpu/drm/drm_atomic_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_helper.c
> > @@ -1028,14 +1028,16 @@ disable_outputs(struct drm_device *dev, struct drm_atomic_state *old_state)
> >  
> >  
> >  		/* Right function depends upon target state. */
> > -		if (new_crtc_state->enable && funcs->prepare)
> > -			funcs->prepare(crtc);
> > -		else if (funcs->atomic_disable)
> > -			funcs->atomic_disable(crtc, old_crtc_state);
> > -		else if (funcs->disable)
> > -			funcs->disable(crtc);
> > -		else
> > -			funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
> > +		if (funcs) {
> 
> I don't think making funcs optional is a good idea. If you have a crtc
> with no functions implemented, it's not terribly useful.
> 
> Also making functions optional just here is not going to help if we still
> require it everywhere else.

Should I remove the other occurrence of "if (funcs)" inside
disable_outputs() and drm_atomic_helper_commit_modeset_enables()? Both
functions, already had this before.

Best Regards

> -Daniel
> 
> > +			if (new_crtc_state->enable && funcs->prepare)
> > +				funcs->prepare(crtc);
> > +			else if (funcs->atomic_disable)
> > +				funcs->atomic_disable(crtc, old_crtc_state);
> > +			else if (funcs->disable)
> > +				funcs->disable(crtc);
> > +			else if (funcs->dpms)
> > +				funcs->dpms(crtc, DRM_MODE_DPMS_OFF);
> > +		}
> >  
> >  		if (!(dev->irq_enabled && dev->num_crtcs))
> >  			continue;
> > @@ -1277,11 +1279,13 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
> >  		if (new_crtc_state->enable) {
> >  			DRM_DEBUG_ATOMIC("enabling [CRTC:%d:%s]\n",
> >  					 crtc->base.id, crtc->name);
> > -
> > -			if (funcs->atomic_enable)
> > -				funcs->atomic_enable(crtc, old_crtc_state);
> > -			else
> > -				funcs->commit(crtc);
> > +			if (funcs) {
> > +				if (funcs->atomic_enable)
> > +					funcs->atomic_enable(crtc,
> > +							     old_crtc_state);
> > +				else if (funcs->atomic_enable)
> > +					funcs->commit(crtc);
> > +			}
> >  		}
> >  	}
> >  
> > -- 
> > 2.21.0
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of São Paulo
