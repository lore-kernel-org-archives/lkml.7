Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D5C74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A7D20645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VE9DvZ7t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfGJP02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:26:28 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32992 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfGJP02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:26:28 -0400
Received: by mail-ed1-f65.google.com with SMTP id i11so2594036edq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 08:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HvP9tTAwaaYJMZBGKOx/DXOnWdBe7zTCNsTQBUNN9UU=;
        b=VE9DvZ7tmj0h7eXR7nx6Y/YBeM0ouoY0jSH+AKwdDxRg1jMJ3ZAe6qYjsPHKrfNvCp
         IB4k743Buiu9MvGx1Fap8pBYM3ufk2ygUOnCSObcdgLRSwMnWLLbTKLXz1FpegaaCLcU
         cpc5lSpvwthHG5nAS4DFOKnVLt4PXeuVxW1sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=HvP9tTAwaaYJMZBGKOx/DXOnWdBe7zTCNsTQBUNN9UU=;
        b=pInQk5rZaLvWQCLm2pbIFU/BhhPuS8v0EYLMAsQtuGPgOud2goGGXkWWQ1YqEPDpBP
         Ezs3LeIooe10olUUMXcBmIGRnIwIYcakZ6p20540p5YVOSTEeGA88bXz1faEJCRiosm9
         q3/8VMwczLAxmZTQ5YzfQQkYOzzcMbY3ZVSmnruC5DKejiuwjIErH/76WgXIlxtEmMYY
         KiogyLcD/XnYCt1nH/Oi5lOTaY4Or8665V/8Ou1rG6vw+80x9R9PSLoiUe+OAPnDde9w
         J4mLzNWLN2Xx8rjvJ3jiPvabCod7tes9xijT3mn9qe9eZcJXFkZAmIeSYaUAEAmsHjAw
         G/GQ==
X-Gm-Message-State: APjAAAXS+TExYz7yXfYwz6nOqQUI9sM9n+N47v5xVZ72IjXNT26zz6IM
        wLKnYL8Iv0W0G7BD98HtssUBbQ==
X-Google-Smtp-Source: APXvYqwZSKTcqghlbKyxkHf0tDpdI8vigua52BxvTNHkEi7ce7m7sGHenyW6atReTQ2tdo2izE3LaQ==
X-Received: by 2002:a50:ad01:: with SMTP id y1mr31465279edc.180.1562772385633;
        Wed, 10 Jul 2019 08:26:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o22sm817784edc.37.2019.07.10.08.26.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 10 Jul 2019 08:26:24 -0700 (PDT)
Date:   Wed, 10 Jul 2019 17:26:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>, tzimmermann@suse.de,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH 1/2] drm/vram: store dumb bo dimensions.
Message-ID: <20190710152622.GQ15868@phenom.ffwll.local>
Mail-Followup-To: Pekka Paalanen <ppaalanen@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>, tzimmermann@suse.de,
        Sean Paul <sean@poorly.run>
References: <20190626065551.12956-1-kraxel@redhat.com>
 <20190626065551.12956-2-kraxel@redhat.com>
 <20190626144013.GB12510@ravnborg.org>
 <20190626162754.GV12905@phenom.ffwll.local>
 <20190708163945.1d3757b3@eldfell.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708163945.1d3757b3@eldfell.localdomain>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:39:45PM +0300, Pekka Paalanen wrote:
> On Wed, 26 Jun 2019 18:27:54 +0200
> Daniel Vetter <daniel@ffwll.ch> wrote:
> 
> > On Wed, Jun 26, 2019 at 04:40:13PM +0200, Sam Ravnborg wrote:
> > > Hi Gerd.
> > > 
> > > On Wed, Jun 26, 2019 at 08:55:50AM +0200, Gerd Hoffmann wrote:  
> > > > Store width and height of the bo.  Needed in case userspace
> > > > sets up a framebuffer with fb->width != bo->width..
> > > > 
> > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > ---
> > > >  include/drm/drm_gem_vram_helper.h     | 1 +
> > > >  drivers/gpu/drm/drm_gem_vram_helper.c | 2 ++
> > > >  2 files changed, 3 insertions(+)
> > > > 
> > > > diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
> > > > index 1a0ea18e7a74..3692dba167df 100644
> > > > --- a/include/drm/drm_gem_vram_helper.h
> > > > +++ b/include/drm/drm_gem_vram_helper.h
> > > > @@ -39,6 +39,7 @@ struct drm_gem_vram_object {
> > > >  	struct drm_gem_object gem;
> > > >  	struct ttm_buffer_object bo;
> > > >  	struct ttm_bo_kmap_obj kmap;
> > > > +	unsigned int width, height;
> > > >  
> > > >  	/* Supported placements are %TTM_PL_VRAM and %TTM_PL_SYSTEM */
> > > >  	struct ttm_placement placement;
> > > > diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
> > > > index 4de782ca26b2..c02bf7694117 100644
> > > > --- a/drivers/gpu/drm/drm_gem_vram_helper.c
> > > > +++ b/drivers/gpu/drm/drm_gem_vram_helper.c
> > > > @@ -377,6 +377,8 @@ int drm_gem_vram_fill_create_dumb(struct drm_file *file,
> > > >  	gbo = drm_gem_vram_create(dev, bdev, size, pg_align, interruptible);
> > > >  	if (IS_ERR(gbo))
> > > >  		return PTR_ERR(gbo);
> > > > +	gbo->width = args->width;
> > > > +	gbo->height = args->height;
> > > >  
> > > >  	ret = drm_gem_handle_create(file, &gbo->gem, &handle);
> > > >  	if (ret)  
> > > 
> > > Be warned, I may have missed something in the bigger picture.
> > > 
> > > Your patch will set width and height only for dumb bo's
> > > But we have several users of drm_gem_vram_create() that will
> > > not set the width and height.
> > > 
> > > So only in some cases can we rely on them being set.
> > > Should this be refactored so we always set width, height.
> > > Or maybe say in a small comment that width,height are only
> > > set for dumb bo's?  
> > 
> > Also for dumb bo allocated buffers if userspace gets the dimensions wrong
> > between dumb_create and the addfb, something is wrong. Papering over that
> > by remembering the right dimensions doesn't look like a good solution.
> 
> Hi,
> 
> just a note irrelevant to this particular driver:
> 
> I have deliberately allocated a too high dumb buffer in userspace and
> created multiple smaller DRM FBs out of it with different offsets
> (i * 128 * stride). This has been a very useful hack to see that a
> GPU-less driver actually honours fences correctly, because if it
> doesn't, the whole image will be off by the offset delta, which is
> epileptically easy to see.
> 
> So I'm not getting the height wrong, I am deliberately overallocating
> and aliasing.

Yeah that's the other reason for why this patch is wrong: It would break
things like this trickery here :-) The separation between backing storage
and drm_fb is intentional, multiple fb in one overall fb is explicitly ok.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
