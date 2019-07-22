Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3C2C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689AC21955
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 18:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Vk0ki42H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbfGVSWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 14:22:25 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42119 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGVSWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 14:22:24 -0400
Received: by mail-yb1-f195.google.com with SMTP id f195so15287258ybg.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nChDLJOZPg7dPTNM27Gi/1xsGavkYn+CO9mE5CxGd8w=;
        b=Vk0ki42HNnol9MsZVJosQk17CkKb6y36mdKMVgVZAn2LD6+9qeDwF4ob45XpGyYdLg
         p17NL9kJ0JMQGeO6qoaEOwfDtQetW9UoiFxjlSC6wgBXha+g+AY57eDWvRTKiV/03OGU
         u54O4ff4XDkRGhYb7gG2emESK74nvP5F/kUyT6CAIpj3B54NvkovkSku55PrwuVTkckT
         KnV7pSjg57YUvmmzFufiU3B43Oplk8wkzgentsMSbQNZ5lG8G+14hmrb5+07fm3NQnu0
         AYyRduf5r7vrW3pgIBnEox0Hte4GItyMPvn6COmqz+hyyK60U0ys9Dc6cliaaLVcxX1F
         euGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nChDLJOZPg7dPTNM27Gi/1xsGavkYn+CO9mE5CxGd8w=;
        b=WPH4haJMFnwomwmDxJDc6AUvY0NJmXfd/TlensoHErafsdrv3mT0fBs65Vr7t+4Kkf
         FmpRyE0WgbV5Cn+2pHBaD5KxEyWZjRFJJ5Fc+7zmU7RRJDBQrkIP9bRnMUVYtuwPTtNB
         BYaZZN5AByPSilAkg3G+jcayHtLA3PueQPioa7rF3UDKcI+I3EO0vebnP5HpM3RHP9XZ
         NaD8J4Ei8h+rE4oanr1ELmqFhuPvjfwZsplilHCX6ixqMYyif2BlQ4zghTI1yxe/T8b0
         VRoVTqN6/sxhgylJ2WUZrP/EDbhiwj3ZohxoiEJhQ4enyIgIw9r03sErPjn8+J0buhjN
         U2rA==
X-Gm-Message-State: APjAAAWPeJShSFHcpKf/xD2FD4aqGm4xNNrYvND+kZ4+L1AwkPFpgux1
        yukrt3vGrvsP4NWXTQkwX/ezCg==
X-Google-Smtp-Source: APXvYqyNe4/QXZs1k+6KJuGPYrieeEeXhzyaOjBwKUya6lRtwyXSjnlyvXe7M/SBsJJaQgWqVE3edw==
X-Received: by 2002:a25:7c05:: with SMTP id x5mr43951829ybc.358.1563819743691;
        Mon, 22 Jul 2019 11:22:23 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id u123sm9932475ywu.75.2019.07.22.11.22.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 11:22:23 -0700 (PDT)
Date:   Mon, 22 Jul 2019 14:22:22 -0400
From:   Sean Paul <sean@poorly.run>
To:     Rob Clark <robdclark@gmail.com>
Cc:     Brian Masney <masneyb@onstation.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        "Kristian H. Kristensen" <hoegsberg@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        freedreno <freedreno@lists.freedesktop.org>
Subject: Re: [Freedreno] [PATCH] drm/msm: correct NULL pointer dereference in
 context_init
Message-ID: <20190722182222.GG104440@art_vandelay>
References: <20190627020515.5660-1-masneyb@onstation.org>
 <CAF6AEGvFE46aKCBP5de_Bx_hFcTyF0Vc9B1PebBZjGZmw9zh2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF6AEGvFE46aKCBP5de_Bx_hFcTyF0Vc9B1PebBZjGZmw9zh2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 05:57:26AM -0700, Rob Clark wrote:
> On Wed, Jun 26, 2019 at 7:05 PM Brian Masney <masneyb@onstation.org> wrote:
> >
> > Correct attempted NULL pointer dereference in context_init() when
> > running without an IOMMU.
> >
> > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > Fixes: 295b22ae596c ("drm/msm: Pass the MMU domain index in struct msm_file_private")
> > ---
> > The no IOMMU case seems like functionality that we may want to keep
> > based on this comment:
> > https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/msm/adreno/a3xx_gpu.c#L523
> > Once I get the msm8974 interconnect driver done, I'm going to look into
> > what needs to be done to get the IOMMU working on the Nexus 5.
> >
> > Alternatively, for development purposes, maybe we could have a NOOP
> > IOMMU driver that would allow us to remove these NULL checks that are
> > sprinkled throughout the code. I haven't looked into this in detail.
> > Thoughts?
> 
> yeah, we probably want to keep !iommu support, it is at least useful
> for bringup of new (or old) devices.  But tends to bitrot a since it
> isn't a case that gets tested much once iommu is in place.  Perhaps
> there is a way to have a null iommu/aspace, although I'm not quite
> sure how that would work..
> 
> Anyways,
> 
> Reviewed-by: Rob Clark <robdclark@gmail.com>
> 
> (I guess this can go in via drm-misc-fixes unless we get some more
> fixes to justify sending msm-fixes MR..)

Applied to drm-misc-fixes for 5.3

Sean

> 
> >
> >  drivers/gpu/drm/msm/msm_drv.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> > index 451bd4508793..83047cb2c735 100644
> > --- a/drivers/gpu/drm/msm/msm_drv.c
> > +++ b/drivers/gpu/drm/msm/msm_drv.c
> > @@ -619,7 +619,7 @@ static int context_init(struct drm_device *dev, struct drm_file *file)
> >
> >         msm_submitqueue_init(dev, ctx);
> >
> > -       ctx->aspace = priv->gpu->aspace;
> > +       ctx->aspace = priv->gpu ? priv->gpu->aspace : NULL;
> >         file->driver_priv = ctx;
> >
> >         return 0;
> > --
> > 2.20.1
> >
> > _______________________________________________
> > Freedreno mailing list
> > Freedreno@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/freedreno

-- 
Sean Paul, Software Engineer, Google / Chromium OS
