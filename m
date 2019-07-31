Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6164AC32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E912067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 08:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KFDb09Lm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfGaIaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 04:30:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38202 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGaIaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 04:30:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so30111498edo.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 01:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JgH28VsQCEs5lBFCl/HW+iDF5pqXhCpcPtH4d3l7Gss=;
        b=KFDb09LmsH2sr+kaB10au1eADIFAwq8Vg+D3qKetvDq2VLWvZC+TP/bYUGtI4gPtnK
         BKMxmD7pvuYLfDfn6OAMr1ALMSX/O50sYdkvNOupDyDCM97kTtO2cWK2d89cW+SvHvYS
         ParjeXDY6tFOQrwOQHShj0y5savr4LX6MOEZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JgH28VsQCEs5lBFCl/HW+iDF5pqXhCpcPtH4d3l7Gss=;
        b=DCgGn0hyN8rtx/Q49+zLaFdz6Mityxrdc6DROOrSgHg7skXjgTMcSXgdEvCcnuj9kH
         Qo/eJnPcEFKInhlgsdPGxwm6EbqQTYXrcTh/a2FYwKHEht0NpCEyUyi3CSnEoWB41fIt
         FYm+WqRCFIu3LNfokjQvExp58Wzt4yvSPcxRTzYzyaDFbRy9PEEHl948720IW8FIHAFA
         z6Oeo45+UJ6StmfT8YyqNkgZQQZD9nNFDyhnuQ36854rm/CMSd3uij/E2TJ16u83hQ0l
         E+0KE2waWV6Er4puSaGBMAM8YGoc18MNCMlppZdheqWbVZrL2497ZYBu1bUVnXdkGEs5
         r7pw==
X-Gm-Message-State: APjAAAWXlLSWbbcASnI5I8OcJCIGeBd8DQq8KToghxh9a55hi2WPHyON
        BVYLs+h3UN1R6ABr2H3qpJY=
X-Google-Smtp-Source: APXvYqxUClg+hymug+sReej1HKnbrHTTTd2GdXPeZrCCrjmOEOPFJ4pJWRRSeHBF9HGci08JOLY5mg==
X-Received: by 2002:a17:907:2101:: with SMTP id qn1mr94859635ejb.3.1564561807715;
        Wed, 31 Jul 2019 01:30:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id br13sm12348127ejb.92.2019.07.31.01.30.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 01:30:07 -0700 (PDT)
Date:   Wed, 31 Jul 2019 10:30:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Joe Perches <joe@perches.com>
Cc:     Fuqian Huang <huangfq.daxian@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: use trace_printk rather than printk in drm_dbg.
Message-ID: <20190731083005.GF7444@phenom.ffwll.local>
Mail-Followup-To: Joe Perches <joe@perches.com>,
        Fuqian Huang <huangfq.daxian@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190731062416.26238-1-huangfq.daxian@gmail.com>
 <29b3741ca8a9e94d64dba213059abb2296c30936.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29b3741ca8a9e94d64dba213059abb2296c30936.camel@perches.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 11:26:32PM -0700, Joe Perches wrote:
> On Wed, 2019-07-31 at 14:24 +0800, Fuqian Huang wrote:
> > In drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c,
> > amdgpu_ih_process calls DRM_DEBUG which calls drm_dbg and
> > finally calls printk.
> > As amdgpu_ih_process is called from an interrupt handler,
> > and interrupt handler should be short as possible.
> > 
> > As printk may lead to bogging down the system or can even
> > create a live lock. printk should not be used in IRQ context.
> > Instead, trace_printk is recommended in IRQ context.
> > Link: https://lwn.net/Articles/365835
> > 
> > Reviewed-by: Joe Perches <joe@perches.com> 
> 
> I made a suggestion.  I did not review this.
> 
> Please do not add signatures like this if
> not specifically given by someone.

+1

> > Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> > ---
> > Changes in v2:
> >   - Only make the interrupt uses the trace_printk to avoid
> >     all 4000+ drm_dbg/DRM_DEBUG uses emitting a trace_printk.
> > 
> >  drivers/gpu/drm/drm_print.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> > index a17c8a14dba4..747835d16fa6 100644
> > --- a/drivers/gpu/drm/drm_print.c
> > +++ b/drivers/gpu/drm/drm_print.c
> > @@ -236,9 +236,13 @@ void drm_dbg(unsigned int category, const char *format, ...)

Right above here is a check for drm_debug, which defaults to off, so in
production this all has 0 impact. But changing all the debug output from
dmesg to tracing is sure to break everyone's CI and test setups.

I'm all for cleaning up the drm logging stuff (it's a real mess), but it's
a very delicate house of cards and with thousands of users, not easy to
change. Unfortunately I don't really have a solid recommendation for what
the ideal drm logging should look like. Plus we already have a pile of
competing approaches ...
-Daniel

> >  	vaf.fmt = format;
> >  	vaf.va = &args;
> >  
> > -	printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> > -	       __builtin_return_address(0), &vaf);
> > -
> > +	if (in_interrupt()) {
> > +		trace_printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> > +		       __builtin_return_address(0), &vaf);
> > +	} else {
> > +		printk(KERN_DEBUG "[" DRM_NAME ":%ps] %pV",
> > +		       __builtin_return_address(0), &vaf);
> > +	}
> >  	va_end(args);
> >  }
> >  EXPORT_SYMBOL(drm_dbg);
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
