Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE786C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1C72073D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SUOcFbPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407123AbfHBKBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:01:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41269 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405130AbfHBJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:43:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so56358152oia.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 02:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+FPU/vGw66DQH6ItIezOEVqjuBIxZcPX9USWgAb1jM=;
        b=SUOcFbPy5rxss1N6dYEveiIIOMKAwymDOUtmfTGkpGgQ/Xpr3UWjMsAcCCDkBnqdup
         1eq2a1R6v6DN0QkaPATZN5n0kE4ue5wnZyoBJTKNOqWawLO3d/A97+DsCdyNlpGcjyQZ
         XE6laiEawO4BJz5p9iAOjzFnHPln42mGtcH2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+FPU/vGw66DQH6ItIezOEVqjuBIxZcPX9USWgAb1jM=;
        b=JfDDPrWi/wN4boRyRqx9Y0JlFuTlj1y5P5aVZGsS1Lu8WFNtqhCtwV0ATLwCWqHL9O
         2OywW4KvegL/7K/uTSZo9oTDM9KcA9rExdrdnbueAo7b+082m54jBlyhhBtdnhdsEfzz
         hfFA0AANzINHy02VweSa+9bmM/sk9Fh7HI6TTUPWMfwd6jTkI9tMR2k0os9nrHn8rq7D
         rRtMb2tl/ifvbl5qtz/LwsuQsc5EWkpl00dsjiHBUy6ofjPzWvRiNGGK9te/a4rf2Rtt
         +OYZzDR+eVql1Q0lWrSe9f2CWH4Ntwxf4olHhwhRmT/Ox1Q4IaIAwAeNvStE7gFGObf2
         UpNw==
X-Gm-Message-State: APjAAAUO5/Um9eE6P6/N7nG8zIajxWOJm3eBGpTcmQ1kaeW3SuBE2jWw
        NV7fEMOnsmJQv/nE4h+JFaJS24K1vDtHfazxqfOANg==
X-Google-Smtp-Source: APXvYqwrE1bn5ct0WaJ9P1S7sbbbgAxT5gZWv30BGTYJ1sG1vdgqFLWcTAJ+BcSNC7gWOTWkKRRExPmjXgf4HAnSNP0=
X-Received: by 2002:aca:b104:: with SMTP id a4mr2199449oif.14.1564739031061;
 Fri, 02 Aug 2019 02:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <1564571048-15029-1-git-send-email-lowry.li@arm.com>
 <1564571048-15029-3-git-send-email-lowry.li@arm.com> <20190731132002.dut5mdsqgh7b75iv@DESKTOP-E1NTVVP.localdomain>
 <20190802092920.4la5cwrltv2m6dke@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20190802092920.4la5cwrltv2m6dke@DESKTOP-E1NTVVP.localdomain>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 2 Aug 2019 11:43:39 +0200
Message-ID: <CAKMK7uEZaFEcs90+U3vzgH69+95BD58Dt=J=gT6=n6oah5Nbyg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm: Clear the fence pointer when writeback job signaled
To:     Brian Starkey <Brian.Starkey@arm.com>
Cc:     "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "seanpaul@chromium.org" <seanpaul@chromium.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "eric@anholt.net" <eric@anholt.net>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 2, 2019 at 11:29 AM Brian Starkey <Brian.Starkey@arm.com> wrote:
>
> Hi Lowry,
>
> On Thu, Aug 01, 2019 at 06:34:08AM +0000, Lowry Li (Arm Technology China) wrote:
> > Hi Brian,
> >
> > On Wed, Jul 31, 2019 at 09:20:04PM +0800, Brian Starkey wrote:
> > > Hi Lowry,
> > >
> > > Thanks for this cleanup.
> > >
> > > On Wed, Jul 31, 2019 at 11:04:45AM +0000, Lowry Li (Arm Technology China) wrote:
> > > > During it signals the completion of a writeback job, after releasing
> > > > the out_fence, we'd clear the pointer.
> > > >
> > > > Check if fence left over in drm_writeback_cleanup_job(), release it.
> > > >
> > > > Signed-off-by: Lowry Li (Arm Technology China) <lowry.li@arm.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_writeback.c | 23 +++++++++++++++--------
> > > >  1 file changed, 15 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
> > > > index ff138b6..43d9e3b 100644
> > > > --- a/drivers/gpu/drm/drm_writeback.c
> > > > +++ b/drivers/gpu/drm/drm_writeback.c
> > > > @@ -324,6 +324,9 @@ void drm_writeback_cleanup_job(struct drm_writeback_job *job)
> > > >   if (job->fb)
> > > >           drm_framebuffer_put(job->fb);
> > > >
> > > > + if (job->out_fence)
> > >
> > > I'm thinking it might be a good idea to signal the fence with an error
> > > here, if it's not already signaled. Otherwise, if there's someone
> > > waiting (which there shouldn't be), they're going to be waiting a very
> > > long time :-)
> > >
> > > Thanks,
> > > -Brian
> > >
> > Here it happened at atomic_check failed and test only commit. For both
> > cases, the commit has been dropped and it's only a clean up. So here better
> > not be treated as an error case:)
>
> If anyone else has a reference on the fence, then IMO it absolutely is
> an error to reach this point without the fence being signaled -
> because it means that the fence will never be signaled.
>
> I don't think the API gives you a way to check if this is the last
> reference, so it's safest to just make sure the fence is signalled
> before dropping the reference.
>
> It just feels wrong to me to have the possibility of a dangling fence
> which is never going to get signalled; and it's an easy defensive step
> to make sure it can never happen.
>
> I know it _shouldn't_ happen, but we often put in handling for cases
> which shouldn't happen, because they frequently do happen :-)

We're not as paranoid with the vblank fences either, so not sure why
we need to be this paranoid with writeback fences. If your driver
grabs anything from the atomic state in ->atomic_check it's buggy
anyway.

If you want to fix this properly I think we need to move the call to
prepare_signalling() in between atomic_check and atomic_commit. Then I
think it makes sense to also force-complete the fence on error ...
-Daniel

> > Since for userspace, it should have been failed or a test only case, so
> > writebace fence should not be signaled.
>
> It's not only userspace that can wait on fences (and in fact this
> fence will never even reach userspace if the commit fails), the driver
> may have taken a copy to use for "something".
>
> Cheers,
> -Brian
>
> >
> > Best regards,
> > Lowry
> > > > +         dma_fence_put(job->out_fence);
> > > > +
> > > >   kfree(job);
> > > >  }
> >
> > --
> > Regards,
> > Lowry



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
