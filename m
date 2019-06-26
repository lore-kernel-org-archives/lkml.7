Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF204C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F5E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="epc0pi3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfFZQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:27:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33673 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfFZQ16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:27:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so4196750edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bsUqs0n2JVX/ZHVQlVV/zYXIO+Z2K2kc9Ql7fOjOo7Y=;
        b=epc0pi3nmEwkTCiUljCqQQ7IQU6202q82Q75Ml2Iw+wDg98cP6TYWDl71HZ3y6wbsi
         NBUo/5QinUkrqDuMPM/XJ2KV2y1rCbfUyNUhIFBEoie2Qo4N7TarQZb+nLu8+zKqW5Db
         BREOCZt0tbzc7sR0r7yQxsjMK3y4thSosLLus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bsUqs0n2JVX/ZHVQlVV/zYXIO+Z2K2kc9Ql7fOjOo7Y=;
        b=oWEK8ppqyvhLDUNzyH6/b/Gv7WquJLMbB/2JAjv90kIJIbC2qbgJPmtdOAgRjb2L9j
         tjW0Fo952IA0b+gQdq69pYpOFAgQmB+noDdppPkh+2sZTBkXH2m9oc4QpsY3ZQtdBq2L
         +bFkEyqTWK1GmhHRTqfCaSXAvUQUuKTvcKWaV+iex29H4xbwSGXkk4NQ/z/O4lMA+Kr9
         ZvTjBhRL4kJDU/kIcdM8mwQ73cDuBNrUBAjzLs927Yo/ujA1L679K+e5LQ18dcmIRs1A
         pCSTxzWdNIK95fMilY+2x8yBRAZ4tTRTnGVSVHI8fZr/1gHuD2BI71FVjzNuID0mqfYs
         A58A==
X-Gm-Message-State: APjAAAUy8VWnMavj8yKC4ljNwq+IxElg7Vi9nHZNv/1KZS9UyCnz8mgs
        FaRJZI6/rbWwbicsCSofjXbJSg==
X-Google-Smtp-Source: APXvYqwBNfKf7SIdROKkPaUQx5tJA3Bjy6L4WN2tFsurahT7SnAhhQBCE8+s9kljhzSwiaPh2GC1QA==
X-Received: by 2002:a17:906:474a:: with SMTP id j10mr5068067ejs.104.1561566476982;
        Wed, 26 Jun 2019 09:27:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id k11sm5612880edq.54.2019.06.26.09.27.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:27:56 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:27:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        tzimmermann@suse.de, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] drm/vram: store dumb bo dimensions.
Message-ID: <20190626162754.GV12905@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        tzimmermann@suse.de, Sean Paul <sean@poorly.run>
References: <20190626065551.12956-1-kraxel@redhat.com>
 <20190626065551.12956-2-kraxel@redhat.com>
 <20190626144013.GB12510@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626144013.GB12510@ravnborg.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:40:13PM +0200, Sam Ravnborg wrote:
> Hi Gerd.
> 
> On Wed, Jun 26, 2019 at 08:55:50AM +0200, Gerd Hoffmann wrote:
> > Store width and height of the bo.  Needed in case userspace
> > sets up a framebuffer with fb->width != bo->width..
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  include/drm/drm_gem_vram_helper.h     | 1 +
> >  drivers/gpu/drm/drm_gem_vram_helper.c | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
> > index 1a0ea18e7a74..3692dba167df 100644
> > --- a/include/drm/drm_gem_vram_helper.h
> > +++ b/include/drm/drm_gem_vram_helper.h
> > @@ -39,6 +39,7 @@ struct drm_gem_vram_object {
> >  	struct drm_gem_object gem;
> >  	struct ttm_buffer_object bo;
> >  	struct ttm_bo_kmap_obj kmap;
> > +	unsigned int width, height;
> >  
> >  	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
> >  	struct ttm_placement placement;
> > diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> > index 4de782ca26b2..c02bf7694117 100644
> > --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > @@ -377,6 +377,8 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
> >  	gbo = drm_gem_vram_create(dev, bdev, size, pg_align, interruptible);
> >  	if (IS_ERR(gbo))
> >  		return PTR_ERR(gbo);
> > +	gbo->width = args->width;
> > +	gbo->height = args->height;
> >  
> >  	ret = drm_gem_handle_create(file, &gbo->gem, &handle);
> >  	if (ret)
> 
> Be warned, I may have missed something in the bigger picture.
> 
> Your patch will set width and height only for dumb bo's
> But we have several users of drm_gem_vram_create() that will
> not set the width and height.
> 
> So only in some cases can we rely on them being set.
> Should this be refactored so we always set width, height.
> Or maybe say in a small comment that width,height are only
> set for dumb bo's?

Also for dumb bo allocated buffers if userspace gets the dimensions wrong
between dumb_create and the addfb, something is wrong. Papering over that
by remembering the right dimensions doesn't look like a good solution.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
