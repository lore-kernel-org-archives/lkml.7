Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54179C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2029F21473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LO9+0mIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbfDCHWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:22:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37669 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:22:15 -0400
Received: by mail-ed1-f67.google.com with SMTP id v21so131432edq.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 00:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zonT63YgWKVIcQgjVqQN83lDjmhEgLXdo5gkBXtDGoc=;
        b=LO9+0mIRo6XD9pKea+Ac019ifHrKkisgu9rQbzObgcBzeFWzj76Ix6oLzr2NxFnXbx
         kOmy6m+VTgMOVLkF5pRi5Em8EhQeWDVWcVR/37oybmjIdU0uASqZ/pIAoBtqD8w8Tavp
         81eyYOuukuujl7TCyAgNfaIVjLDC/7Po0CTAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zonT63YgWKVIcQgjVqQN83lDjmhEgLXdo5gkBXtDGoc=;
        b=jI7vJSaM9awu690Mb2PRkf3UcwCF4J9h8aKdZOTS9hbg4q4K22J+io/auYCRp5FdXS
         YeewWOW+nxitd8IPnm6bswxOEOkI2tg7IM2bj70Q/0S4NiYOarQpnqrU/YEqoHlfli1Q
         qDHGiw+O5F4fr/5hP1dRafbIYTml863Udk0KeQ6Wbu1AT8hDw4N8YYMtQ2BtHz4r8Mfs
         UKDT10ccOHittv05DsWPTS0DwQQOA+ULpgMSI+4O70FlSSKvxQ7u/wtUW6tqpTPa3sHU
         QZb13ZiI9D/hr55CZ1pPQ1AFuq/OMNdajPhMp+/HN94zbwPRE3HqvlKsi/tuE5BJGXqv
         cwog==
X-Gm-Message-State: APjAAAXxdE5sXBU7mtJL6X4tnR1dRFhoG5ri7ViNzngYVDo3MzvTOwbI
        IW/N0QgyEE13tP0Igi0dS5yEww==
X-Google-Smtp-Source: APXvYqwRUNI4jHd35HSLabIGBMHJnlo3PLCLNK9+J4jx2Spj40+1ae3JsaCcKe9lZNCsDJcbNCcj1A==
X-Received: by 2002:a50:a4db:: with SMTP id x27mr29212169edb.120.1554276133669;
        Wed, 03 Apr 2019 00:22:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k5sm394006ejv.83.2019.04.03.00.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 00:22:12 -0700 (PDT)
Date:   Wed, 3 Apr 2019 09:22:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>, airlied@linux.ie,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux@armlinux.org.uk
Subject: Re: [PATCH 1/3] ipuv3-crtc: add remove action for devres data
Message-ID: <20190403072210.GP2665@phenom.ffwll.local>
Mail-Followup-To: Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>, airlied@linux.ie,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux@armlinux.org.uk
References: <0687f68004b28ed3a364b06a9eb64e2e@agner.ch>
 <20190402134904.588-1-m.grzeschik@pengutronix.de>
 <20190402134904.588-2-m.grzeschik@pengutronix.de>
 <1554220163.2338.2.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554220163.2338.2.camel@pengutronix.de>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 05:49:23PM +0200, Philipp Zabel wrote:
> Hi Michael,
> 
> On Tue, 2019-04-02 at 15:49 +0200, Michael Grzeschik wrote:
> > The destroy function in drm_mode_config_cleanup will remove the objects
> > in ipu-drm-core by calling its destroy functions if the bind function
> > fails. The drm_crtc is also part of the devres allocated ipu_crtc
> > object. The ipu_crtc object will already be cleaned up if the bind for
> > the crtc fails. This leads drm_crtc_cleanup try to clean already freed
> > memory.
> > 
> > We fix this issue by adding the devres action ipu_crtc_remove_head which
> > will remove its head from the objects in ipu-drm-core which then never
> > calls its destroy function anymore.
> > 
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> >  drivers/gpu/drm/imx/ipuv3-crtc.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/imx/ipuv3-crtc.c b/drivers/gpu/drm/imx/ipuv3-crtc.c
> > index ec3602ebbc1cd..fa1ee33a43d77 100644
> > --- a/drivers/gpu/drm/imx/ipuv3-crtc.c
> > +++ b/drivers/gpu/drm/imx/ipuv3-crtc.c
> > @@ -429,6 +429,14 @@ static int ipu_crtc_init(struct ipu_crtc *ipu_crtc,
> >  	return ret;
> >  }
> >  
> > +static void ipu_crtc_remove_head(void *data)
> > +{
> > +	struct ipu_crtc *ipu_crtc = data;
> > +	struct drm_crtc *crtc = &ipu_crtc->base;
> > +
> > +	list_del(&crtc->head);
> 
> I don't think reaching into drm_crtc internals like this is going to be
> robust. Currently, this is either missing the rest of drm_crtc_cleanup,
> or it will crash if drm_crtc_init_with_planes hasn't been called yet.
> 
> I think you could call devm_add_action with a function that calls
> drm_crtc_cleanup after drm_crtc_init_with_planes in ipu_crtc_init.
> 
> Alternatively, the ipu_crtc allocation could be changed to kzalloc. It
> would then have to freed manually in the drm_crtc_funcs->destroy
> callback.

Dirty secret of devm: You can't use it for any drm_ structure, because the
lifetimes of those do not match the lifetimes of the underlying device.
We'd need to tie the lifetimes of drm objects to drm_device. Noralf has
some patches to move that forward. We'd need something like
drm_dev_kzalloc which releases memory when drm_device is freed.

Agreed that digging even deeper into the devm deadend is not a good idea.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
