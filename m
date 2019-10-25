Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DEFCA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FD921D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 19:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SlrAb0Vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfJYTkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 15:40:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36837 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbfJYTkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 15:40:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so3646211wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 12:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Gj222psC+ydWsaF5gMlny1BmmWIVdou0S6Ni7ju44k=;
        b=SlrAb0VpRC2LidQiFdSzxi13PPngSwAVFMlhwTS3HufxE9huKhmIAgqmIR//798lPx
         bOQ2RR/GU0hW0KqsOP8l98Ar1lQDKXoQA/L6z9fLQxb/D/WZFmMR+SdgcBbZtxTMxGLx
         RFNjhh0n5RhjmOQPhAXid/4PH1covWIixTMlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=2Gj222psC+ydWsaF5gMlny1BmmWIVdou0S6Ni7ju44k=;
        b=K+agSMN1L9iFnD6swBRh5oGPA0PQ5LkjQ4l0SL31x4cQ5S18LscPL1pYy0DUmE48+3
         dlSknep1yNYsWVXvfQNG0zwDY9kxQTncKqShyc8zikU76WKf7nYGHK3N135JSxAArOxk
         qct21q1AtjT+ONVOhWTbgf2NJUHFchTfzczLpZalHZVxztoYfpo8kLGEdqRwBgAaanDo
         hoYqyoGnuXdJwpKgtex2ZK1n20fDfIZVIgL2S1zuWmf1zJdaAs5HZJg0UPgaSSlqfztE
         ZGd5g7IibhHWgBH4l94fVvd4NC6n2ngYKAqgx6Mmm/2e6uGlCpaQJ4Y2T3mvORAGaABR
         kdhA==
X-Gm-Message-State: APjAAAUrc96e4ixiVeP2aCzJ+O9Li2NQyz8ETjjRpkYYkgUHRKn0QckZ
        rYtde4ho6j8vkhshPPq9CdnmOg==
X-Google-Smtp-Source: APXvYqxxJig4xVfD7GpZ084avKsgHqDpYcderhQdMAjUkkO5TbzG8sIK5Jy5u4TdOHceXtEdNV6Mvw==
X-Received: by 2002:a05:6000:351:: with SMTP id e17mr4260765wre.96.1572032432883;
        Fri, 25 Oct 2019 12:40:32 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id r65sm3210045wmr.9.2019.10.25.12.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 12:40:31 -0700 (PDT)
Date:   Fri, 25 Oct 2019 21:40:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [Outreachy][PATCH] drm: use DIV_ROUND_UP
 helper macro for calculations
Message-ID: <20191025194029.GU11828@phenom.ffwll.local>
Mail-Followup-To: Julia Lawall <julia.lawall@lip6.fr>,
        Wambui Karuga <wambui.karugax@gmail.com>,
        dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
References: <20191025094907.3582-1-wambui.karugax@gmail.com>
 <alpine.DEB.2.21.1910251212070.3307@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1910251212070.3307@hadrien>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 12:12:23PM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 25 Oct 2019, Wambui Karuga wrote:
> 
> > Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> > macro for better readability.
> > Issue found using coccinelle:
> > @@
> > expression n,d;
> > @@
> > (
> > - ((n + d - 1) / d)
> > + DIV_ROUND_UP(n,d)
> > |
> > - ((n + (d - 1)) / d)
> > + DIV_ROUND_UP(n,d)
> > )
> >
> > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> 
> 
> > ---
> >  drivers/gpu/drm/drm_agpsupport.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_agpsupport.c b/drivers/gpu/drm/drm_agpsupport.c
> > index 6e09f27fd9d6..4c7ad46fdd21 100644
> > --- a/drivers/gpu/drm/drm_agpsupport.c
> > +++ b/drivers/gpu/drm/drm_agpsupport.c
> > @@ -212,7 +212,7 @@ int drm_agp_alloc(struct drm_device *dev, struct drm_agp_buffer *request)
> >  	if (!entry)
> >  		return -ENOMEM;
> >
> > -	pages = (request->size + PAGE_SIZE - 1) / PAGE_SIZE;
> > +	pages = DIV_ROUND_UP(request->size, PAGE_SIZE);
> >  	type = (u32) request->type;
> >  	memory = agp_allocate_memory(dev->agp->bridge, pages, type);
> >  	if (!memory) {
> > @@ -325,7 +325,7 @@ int drm_agp_bind(struct drm_device *dev, struct drm_agp_binding *request)
> >  	entry = drm_agp_lookup_entry(dev, request->handle);
> >  	if (!entry || entry->bound)
> >  		return -EINVAL;
> > -	page = (request->offset + PAGE_SIZE - 1) / PAGE_SIZE;
> > +	page = DIV_ROUND_UP(request->offset, PAGE_SIZE);
> >  	retcode = drm_bind_agp(entry->memory, page);
> >  	if (retcode)
> >  		return retcode;
> > --
> > 2.23.0
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191025094907.3582-1-wambui.karugax%40gmail.com.
> >

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
