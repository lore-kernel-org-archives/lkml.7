Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7CCCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25B320679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:50:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="B9HyTM0I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbfJVIuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:50:54 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36429 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387479AbfJVIuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:50:54 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so2713284otm.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpIbPyLJiW0xJnouuCwRPkxpgK7OWPXN5Ymgu9JHiHA=;
        b=B9HyTM0I+eVfwtkstGxQ65uPJqKWJnfhdWV6v/uQS3In3pRhIaSrkdc0974dc+lXJu
         q0YrPIWPoEyrc9O1XRZLVzd3yzM0Nwj+1YL9EhIJFEYi9nvpQSggzF6igw+51j66rOFk
         XixeX/xqAaPga96jY9SQyZJuHJ9izAYIOajzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpIbPyLJiW0xJnouuCwRPkxpgK7OWPXN5Ymgu9JHiHA=;
        b=aR+lP1UH0mXbYqzBSxC6jv5CH/aY1lmDgl56FcxfkdxzzoeKE9v39fgYAV+K8Gl6bB
         /6l8H0k9yOTw6IChgiiiS+uqBYu6DuKjV0l287rOXLuXebx5DJPYYGbt7QjOsthYyIzf
         M2rBdVQvVvKWtGaqHDAehXn1d7tC+J5NEhKT16X04rAO5O4amMqMXoWWMwg8Cnp4vivE
         COyQlEP6axu4P4w8Z4KoWzO/4QZ7oGIfdJwrbBzhCbRPynYcPZHPkMAb5lQxpUM7owFu
         xYOpjI4y/1keEL+RMPvp7fJDMCxRpdc/I5TgfABV+q8t0CVI40NZKohqOq3/pZGQ1sUB
         5oRw==
X-Gm-Message-State: APjAAAWJbSQepPQZHsJvoiiij3e70vqeVI7aqjKK9d3Q5zsa7ZLqQOmk
        dJcdHtbc33ikzhPXmhf4odJeYFeVfewJ2tgSI5MPHTISWjI=
X-Google-Smtp-Source: APXvYqzfOO7kyEdELBPyn8unY9U2wUNIdnFmPqhP+Ugyi+Fc8SWIBaqjX7c3BRfx99tAYAvJQeiMCmh7oj2Kly5k95U=
X-Received: by 2002:a9d:6343:: with SMTP id y3mr1701963otk.106.1571734253134;
 Tue, 22 Oct 2019 01:50:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191004143418.53039-4-mihail.atanassov@arm.com>
 <20191009055407.GA3082@jamwan02-TSP300> <5390495.Gzyn2rW8Nj@e123338-lin>
 <20191016162206.u2yo37rtqwou4oep@DESKTOP-E1NTVVP.localdomain>
 <20191017030752.GA3109@jamwan02-TSP300> <20191017082043.bpiuvfr3r4jngxtu@DESKTOP-E1NTVVP.localdomain>
 <20191017102055.GA8308@jamwan02-TSP300> <20191017104812.6qpuzoh5bx5i2y3m@DESKTOP-E1NTVVP.localdomain>
 <20191017114137.GC25745@shell.armlinux.org.uk> <20191022084210.GX11828@phenom.ffwll.local>
 <20191022084826.GP25745@shell.armlinux.org.uk>
In-Reply-To: <20191022084826.GP25745@shell.armlinux.org.uk>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 22 Oct 2019 10:50:42 +0200
Message-ID: <CAKMK7uHZ1Lw03LhZVH=oAa92WxZXucqooH1w6SG8HG20+g0Rbg@mail.gmail.com>
Subject: Re: [RFC,3/3] drm/komeda: Allow non-component drm_bridge only endpoints
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>,
        David Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:48 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 22, 2019 at 10:42:10AM +0200, Daniel Vetter wrote:
> > On Thu, Oct 17, 2019 at 12:41:37PM +0100, Russell King - ARM Linux admin wrote:
> > > On Thu, Oct 17, 2019 at 10:48:12AM +0000, Brian Starkey wrote:
> > > > On Thu, Oct 17, 2019 at 10:21:03AM +0000, james qian wang (Arm Technology China) wrote:
> > > > > On Thu, Oct 17, 2019 at 08:20:56AM +0000, Brian Starkey wrote:
> > > > > > On Thu, Oct 17, 2019 at 03:07:59AM +0000, james qian wang (Arm Technology China) wrote:
> > > > > > > On Wed, Oct 16, 2019 at 04:22:07PM +0000, Brian Starkey wrote:
> > > > > > > >
> > > > > > > > If James is strongly against merging this, maybe we just swap
> > > > > > > > wholesale to bridge? But for me, the pragmatic approach would be this
> > > > > > > > stop-gap.
> > > > > > > >
> > > > > > >
> > > > > > > This is a good idea, and I vote +ULONG_MAX :)
> > > > > > >
> > > > > > > and I also checked tda998x driver, it supports bridge. so swap the
> > > > > > > wholesale to brige is perfect. :)
> > > > > > >
> > > > > >
> > > > > > Well, as Mihail wrote, it's definitely not perfect.
> > > > > >
> > > > > > Today, if you rmmod tda998x with the DPU driver still loaded,
> > > > > > everything will be unbound gracefully.
> > > > > >
> > > > > > If we swap to bridge, then rmmod'ing tda998x (or any other bridge
> > > > > > driver the DPU is using) with the DPU driver still loaded will result
> > > > > > in a crash.
> > > > >
> > > > > I haven't read the bridge code, but seems this is a bug of drm_bridge,
> > > > > since if the bridge is still in using by others, the rmmod should fail
> > > > >
> > > >
> > > > Correct, but there's no fix for that today. You can also take a look
> > > > at the thread linked from Mihail's cover letter.
> > > >
> > > > > And personally opinion, if the bridge doesn't handle the dependence.
> > > > > for us:
> > > > >
> > > > > - add such support to bridge
> > > >
> > > > That would certainly be helpful. I don't know if there's consensus on
> > > > how to do that.
> > > >
> > > > >   or
> > > > > - just do the insmod/rmmod in correct order.
> > > > >
> > > > > > So, there really are proper benefits to sticking with the component
> > > > > > code for tda998x, which is why I'd like to understand why you're so
> > > > > > against this patch?
> > > > > >
> > > > >
> > > > > This change handles two different connectors in komeda internally, compare
> > > > > with one interface, it increases the complexity, more risk of bug and more
> > > > > cost of maintainance.
> > > > >
> > > >
> > > > Well, it's only about how to bind the drivers - two different methods
> > > > of binding, not two different connectors. I would argue that carrying
> > > > our out-of-tree patches to support both platforms is a larger
> > > > maintenance burden.
> > > >
> > > > Honestly this looks like a win-win to me. We get the superior approach
> > > > when its supported, and still get to support bridges which are more
> > > > common.
> > > >
> > > > As/when improvements are made to the bridge code we can remove the
> > > > component bits and not lose anything.
> > >
> > > There was an idea a while back about using the device links code to
> > > solve the bridge issue - but at the time the device links code wasn't
> > > up to the job.  I think that's been resolved now, but I haven't been
> > > able to confirm it.  I did propose some patches for bridge at the
> > > time but they probably need updating.
> >
> > I think the only patches that existed where for panel, and we only
> > discussed the bridge case. At least I can only find patches for panel,not
> > bridge, but might be missing something.
>
> I had a patches, which is why I raised the problem with the core:
>
> 6961edfee26d bridge hacks using device links
>
> but it never went further than an experiment at the time because of the
> problems in the core.  As it was a hack, it never got posted.  Seems
> that kernel tree (for the cubox) is still 5.2 based, so has a lot of
> patches and might need updating to a more recent base before anything
> can be tested.


For reference, the panel patch:

https://patchwork.kernel.org/patch/10364873/

And the huge discussion around bridges, that resulted in Rafael
Wyzocki fixing all the core issues:

https://www.spinics.net/lists/dri-devel/msg201927.html

James, do you want to look into this for bridges?

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
