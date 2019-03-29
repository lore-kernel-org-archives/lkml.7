Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51301C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BCFA2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 08:37:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Y579v6o/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfC2Ih5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 04:37:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39723 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbfC2Ih5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 04:37:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id p20so1296649eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldh1DeZZbyWaL0eQH1n+YhO96fj3m6Kxa4r5d6+/TFs=;
        b=Y579v6o/c4JS38ajfPIJdiBFGQmixI7n536PsM9HUzmbOxh4SWdqJ/nViLVGQ7W1GL
         YMV7T5+G6R6dFZNLYMcnFyrtm0ptKK99fStJWvKsg6VvQPxg4sht/C90j1H+RUulsTRS
         pRtYBRbLfoqDHfquO5DBuTesXSgYqBIZZi0PE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=ldh1DeZZbyWaL0eQH1n+YhO96fj3m6Kxa4r5d6+/TFs=;
        b=Q65vYg17852JiS2wr1g9V5W2NIslO7/8rs9/aOJ2E7Nxk8Ko51UJvT77o571tcY4AU
         fzpL/u4dPGvPM3fKOVbAieQYATLMuXnBGeSRPNDWWVanV2RmS4HnesdhIn1WavlVIBzV
         g60w1DBYURrp/c31+xux6IHnfPvSsLDpWTHEAggykz+ZgujQz2/8t0MlYureC5fzdwlV
         crqwBc0wzQV5xl0+ePVjWcm33OgIO9Wkovx0wYXCmfE+NDJWINRyZK41TahhWtkyiIbC
         28rp6Kmsj0uoTdaz9bu3cNZ5nTzb63lb5rHu6jjJKR/YOLzjWwgKBRbBT9oJoHgWK1D0
         5ASw==
X-Gm-Message-State: APjAAAUWIa3d34uyCwhu1kPX80QkGLzlMRQBlD3BPkzuCvaTjeIUWOfu
        bB17E/KeGRrOyB1ISaWxzLGhlw==
X-Google-Smtp-Source: APXvYqzg47d2yabHpbF7/lIkhopmC5UPgpCd1IuP1cwHaNy2Hi0GtsMp9K+UeEmkWnicUSH2pEbb8Q==
X-Received: by 2002:a17:906:1545:: with SMTP id c5mr17258358ejd.135.1553848675461;
        Fri, 29 Mar 2019 01:37:55 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j18sm479063edj.92.2019.03.29.01.37.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 01:37:54 -0700 (PDT)
Date:   Fri, 29 Mar 2019 09:37:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Eric Anholt <eric@anholt.net>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/2] drm/file: Rehabilitate the firstopen hook for
 non-legacy drivers
Message-ID: <20190329083752.GD2665@phenom.ffwll.local>
Mail-Followup-To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Eric Anholt <eric@anholt.net>, Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20190328161306.22757-1-paul.kocialkowski@bootlin.com>
 <20190328161306.22757-2-paul.kocialkowski@bootlin.com>
 <20190329083534.GC2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329083534.GC2665@phenom.ffwll.local>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:35:34AM +0100, Daniel Vetter wrote:
> On Thu, Mar 28, 2019 at 05:13:05PM +0100, Paul Kocialkowski wrote:
> > The firstopen DRM driver hook was initially used to perform hardware
> > initialization, which is now considered legacy. Only a single user of
> > firstopen remains at this point (savage).
> > 
> > In some specific cases, non-legacy drivers may also need to implement
> > these hooks. For instance on VC4, we need to allocate a 16 MiB buffer
> > for the GPU. Because it's not required for fbcon, it's a waste to
> > allocate it before userspace starts using the DRM device.
> > 
> > Using firstopen and lastclose for this allocation seems like the best
> > fit, so re-habilitate the hook to allow it to be called for non-legacy
> > drivers.
> > 
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > Reviewed-by: Eric Anholt <eric@anholt.net>
> > ---
> >  drivers/gpu/drm/drm_file.c | 3 +--
> >  include/drm/drm_drv.h      | 3 ---
> >  2 files changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> > index b1838a41ad43..c011b5cbfb6b 100644
> > --- a/drivers/gpu/drm/drm_file.c
> > +++ b/drivers/gpu/drm/drm_file.c
> > @@ -266,8 +266,7 @@ static int drm_setup(struct drm_device * dev)
> >  {
> >  	int ret;
> >  
> > -	if (dev->driver->firstopen &&
> > -	    drm_core_check_feature(dev, DRIVER_LEGACY)) {
> > +	if (dev->driver->firstopen) {
> 
> If you guys insist on this (still not a fan myself) pls pull it out of
> drm_setup - that's all just legacy hw setup in there. I still think
> tracking this a bit more accurately (if you want to bother with this)
> would be better.

Maybe another one: Firstopen is called after ->open, which might be
confusing. But we can't change that ever because legacy drivers surely
rely on that somewhere (like the backwards load/unload calling sequence).
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
