Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E508C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17B12089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Nh29jA6Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbfDXPHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:07:05 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:36695 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfDXPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:07:04 -0400
Received: by mail-io1-f42.google.com with SMTP id d19so11889577ioc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GJOJkE42wnXrTOZfnAC2+qprPq0Z54DZ3XvyURZAdQ8=;
        b=Nh29jA6YuT6toq51B95QUITttXUtue8XKuvNoWmttAB4ZOxK9URwuLCXbPr+Dyvcvz
         z7dMZzL38NT85yp4Ww1x5sdi1R/h/afyFcTQJ7t0hXygakB28lKkJ90u+Ne8+nTRC31P
         vVNiyYRlr7WOMULyU+QligUN3GXh2G2wDhWVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GJOJkE42wnXrTOZfnAC2+qprPq0Z54DZ3XvyURZAdQ8=;
        b=QhcoAZ92j0wmnkF/sPNerza+6k4+keNoK33jFCm9RI3OP7tJfSXt8orGIeHE6IjkQC
         QrNkUcjHf0+GWBvuVjVzce6Kmlpcc7YS5IK4obzmJvJQVz0F2nEXgk3NuemvpPxUqV1Y
         +UJ7OjPTzYPl+4/OoRSXijkZGvPV5QyjwQH+4eEHw6uijSx+qnbgp6xTz4o4Q0MD2NvV
         kur0v+KrRBoKNqdO34UeQpbnWPKXBSG0stSiq4EQ/TtHusEuvPVW2DkExxCv18QlpUxw
         mC3UMzRtACL5eAV6j+tTsSAXhDGhRfnzvBUnx2oD+6f6NL6PbRHY8YUKgZzJFrg5b8dH
         hHhA==
X-Gm-Message-State: APjAAAXBgDOro4KXcVY1Tiu7RmambtEmQSLH8QtaSS7/9RSrjLvOXAya
        vVVNcaBMhzdL3AdRlI6G44h+ywp+GmUL/QyPKfgiaQ==
X-Google-Smtp-Source: APXvYqymbfM454is8LLymxpblS9KfhU+kayJ21nJcJEnehavlyzO57A0uwxHFlBEw/Mali78OYBEYAdo58k+kRdlh/Y=
X-Received: by 2002:a6b:b24c:: with SMTP id b73mr10065589iof.34.1556118423614;
 Wed, 24 Apr 2019 08:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local> <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
 <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
 <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net> <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
 <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net> <93c8e6834728b7e5979013df757017d309ee6a89.camel@bootlin.com>
In-Reply-To: <93c8e6834728b7e5979013df757017d309ee6a89.camel@bootlin.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 24 Apr 2019 17:06:49 +0200
Message-ID: <CAKMK7uFewmCuc97Qp_2zzk9YvMPmK8zE=a6XGszsLq+SLy-vJA@mail.gmail.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Dave Airlie <airlied@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 4:41 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Hi,
>
> On Wed, 2019-04-24 at 16:39 +0200, Michel D=C3=A4nzer wrote:
> > On 2019-04-24 2:01 p.m., Nicolas Dufresne wrote:
> > > Le mercredi 24 avril 2019 =C3=A0 10:31 +0200, Michel D=C3=A4nzer a =
=C3=A9crit :
> > > > On 2019-04-19 10:38 a.m., Paul Kocialkowski wrote:
> > > > > On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
> > > > > > Le jeudi 18 avril 2019 =C3=A0 10:18 +0200, Daniel Vetter a =C3=
=A9crit :
> > > > > > In the first, we'd need a mechanism where we can schedule a ren=
der at a
> > > > > > specific time or vblank. We can of course already implement thi=
s in
> > > > > > software, but with fences, the scheduling would need to be done=
 in the
> > > > > > driver. Then if the fence is signalled earlier, the driver shou=
ld hold
> > > > > > on until the delay is met. If the fence got signalled late, we =
also
> > > > > > need to think of a workflow. As we can't schedule more then one=
 render
> > > > > > in DRM at one time, I don't really see yet how to make that wor=
k.
> > > > >
> > > > > Indeed, that's also one of the main issues I've spotted. Before u=
sing
> > > > > an implicit fence, we basically have to make sure the frame is du=
e for
> > > > > display at the next vblank. Otherwise, we need to refrain from us=
ing
> > > > > the fence and schedule the flip later, which is kind of counter-
> > > > > productive.
> > > >
> > > > Fences are about signalling that the contents of a frame are "done"=
 and
> > > > ready to be presented. They're not about specifying which frame is =
to be
> > > > presented when.
> > > >
> > > >
> > > > > I feel like specifying a target vblank would be a good unit for t=
hat,
> > > >
> > > > The mechanism described above works for that.
> > > >
> > > > > since it's our native granularity after all (while a timestamp is=
 not).
> > > >
> > > > Note that variable refresh rate (Adaptive Sync / FreeSync / G-Sync)
> > > > changes things in this regard. It makes the vblank length variable,=
 and
> > > > if you wait for multiple vblanks between flips, you get the maximum
> > > > vblank length corresponding to the minimum refresh rate / timing
> > > > granularity. Thus, it would be useful to allow userspace to specify=
 a
> > > > timestamp corresponding to the earliest time when the flip is to
> > > > complete. The kernel could then try to hit that as closely as possi=
ble.
> > >
> > > Rendering a video stream is more complex then what you describe here.
> > > Whenever there is a unexpected delay (late delivery of a frame as an
> > > example) you may endup in situation where one frame is ready after th=
e
> > > targeted vblank. If there is another frame that targets the following
> > > vblank that gets ready on-time, the previous frame should be replaced
> > > by the most recent one.
> > >
> > > With fences, what happens is that even if you received the next frame
> > > on time, naively replacing it is not possible, because we don't know
> > > when the fence for the next frame will be signalled. If you simply
> > > always replace the current frame, you may endup skipping a lot more
> > > vblank then what you expect, and that results in jumpy playback.
> >
> > So you want to be able to replace a queued flip with another one then.
> > That doesn't necessarily require allowing more than one flip to be
> > queued ahead of time.
>
> There might be other ways to do it, but this one has plenty of
> advantages.

The point of kms (well one of the reasons) was to separate the
implementation of modesetting for specific hw from policy decisions
like which frames to drop and how to schedule them. Kernel gives
tools, userspace implements the actual protocols.

There's definitely a bit a gap around scheduling flips for a specific
frame or allowing to cancel/overwrite an already scheduled flip, but
no one yet has come up with a clear proposal for new uapi + example
implementation + userspace implementation + big enough support from
other compositors that this is what they want too.

And yes writing a really good compositor is really hard, and I think a
lot of people underestimate that and just create something useful for
their niche. If userspace can't come up with a shared library of
helpers, I don't think baking it in as kernel uapi with 10+ years
regression free api guarantees is going to make it any better.

> > Note that this can also be done in userspace with explicit fencing (by
> > only selecting a frame and submitting it to the kernel after all
> > corresponding fences have signalled), at least to some degree, but the
> > kernel should be able to do it up to a later point in time and more
> > reliably, with less risk of missing a flip for a frame which becomes
> > ready just in time.
>
> Indeed, but it would be great if we could do that with implicit fencing
> as well.

1. extract implicit fences from dma-buf. This part is just an idea,
but easy to implement once we have someone who actually wants this.
All we need is a new ioctl on the dma-buf to export the fences from
the reservation_object as a sync_file (either the exclusive or the
shared ones, selected with a flag).
2. do the exact same frame scheduling as with explicit fencing
3. supply explicit fences in your atomic ioctl calls - these should
overrule any implicit fences (assuming correct kernel drivers, but we
have helpers so you can assume they all work correctly).

By design this is possible, it's just that no one yet bothered enough
to make it happen.
-Daniel

> > > Render queues with timestamp are used to smooth rendering and handle
> > > rendering collision so that the latency is kept low (like when you ha=
ve
> > > a 100fps video over a 60Hz display). This is normally done in
> > > userspace, but with fences, you ask the kernel to render something in
> > > an unpredictable future, so we loose the ability to make the final
> > > decision.
> >
> > That's just not what fences are intended to be used for with the curren=
t
> > KMS UAPI.
>
> Yes, and I think we're discussing towards changing that in the future.
>
> Cheers,
>
> Paul
>
> --
> Paul Kocialkowski, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
