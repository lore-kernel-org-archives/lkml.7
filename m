Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0358AC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A03218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 12:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="p5InsUef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbfDXMBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 08:01:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40372 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728845AbfDXMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 08:01:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id y49so1152343qta.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 05:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=03rf8AKBlZ5h5mWz0thDPCfLgWMzgoNv8XVPYbEvK3A=;
        b=p5InsUefI3wayoh9XdXMnXKZNUBlmSSS9ZzyIUIbn/Wu7VtmN5NDPkcqSZxaqYO3P8
         0kWyCR/3eKGZ1n9a1ZCHhCFBKTkVPiyRMelCrDQroNCVepfQcXlM0ki52awsFP3gd2CS
         5kltw55r7ZSAK720RbTIrbo0oKft4J4qwIlkwWrAXZWle7HXCCMFl2c3+Ub8j5jcZwlU
         qakfwSeftM7sa+8WOFFVBeLUwGZ0kKDd7Pm8ZRVRS2VkQpt9hfzvakvCbUdofffz224p
         N9V01hWpziYXCwwUzcivby3G2+lvSoOmVO3mic8ocitCJWiZUTydV65iEMQ1y4o58ceC
         JyoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=03rf8AKBlZ5h5mWz0thDPCfLgWMzgoNv8XVPYbEvK3A=;
        b=oUHm4nifr8ZAYDEJyEQLyBXiHR9GAyr81aTKKUfKATD0Uz5z9nDofIAHP6nDWdZIvo
         OTkB9C7XXW79o5UZ9terjFYETRFiOxTVMBmRR9oShrUXlculV1Ug2FWc243PWCkrWXQq
         GqiYp/Tk8y7l/V9mxgDXW4X12LlR6XUyLAps6q3Xh+N0dOaYtNOZQPLo3/1HxjjplFf4
         UmjTsm0fp96S0Cc2m9Smv0X8uPGK30AyBeRKvqs8t8lhpkVktVqj2pxSB+5OKirBgiyr
         Rhe77RIJ8+8Qup8mbZqpoAaaDOZzb2TTw0oy5IziJHED9U6CI4SM3pXxnk5DL95tSuEP
         H2kg==
X-Gm-Message-State: APjAAAVA7noQ35wIXjrTSC3hcTS6Ffyt+f+OTsiMzmV2kP/ZTg3/BGJG
        vHHb3ugIsv+57I+ioezd5nNMsQ==
X-Google-Smtp-Source: APXvYqzaBnwLjfHOUgrj9toWyGIx7ttF9Q0m7YBjXOAVcQ0Vup7egsO9Haga5UpF7us5c9K29HMQvA==
X-Received: by 2002:ad4:5406:: with SMTP id f6mr9459416qvt.102.1556107294282;
        Wed, 24 Apr 2019 05:01:34 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id d34sm13098121qta.18.2019.04.24.05.01.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 05:01:32 -0700 (PDT)
Message-ID: <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Tomasz Figa <tfiga@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Dave Airlie <airlied@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Date:   Wed, 24 Apr 2019 08:01:30 -0400
In-Reply-To: <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
         <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
         <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 24 avril 2019 à 10:31 +0200, Michel Dänzer a écrit :
> On 2019-04-19 10:38 a.m., Paul Kocialkowski wrote:
> > On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
> > > Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
> > > > > It would be cool if both could be used concurrently and not just return
> > > > > -EBUSY when the device is used with the other subsystem.
> > > > 
> > > > We live in this world already :-) I think there's even patches (or merged
> > > > already) to add fences to v4l, for Android.
> > > 
> > > This work is currently suspended. It will require some feature on DRM
> > > display to really make this useful, but there is also a lot of
> > > challanges in V4L2. In GFX space, most of the use case are about
> > > rendering as soon as possible. Though, in multimedia we have two
> > > problems, we need to synchronize the frame rendering with the audio,
> > > and output buffers may comes out of order due to how video CODECs are
> > > made.
> > 
> > Definitely, it feels like the DRM display side is currently a good fit
> > for render use cases, but not so much for precise display cases where
> > we want to try and display a buffer at a given vblank target instead of
> > "as soon as possible".
> > 
> > I have a userspace project where I've implemented a page flip queue,
> > which only schedules the next flip when relevant and keeps ready
> > buffers in the queue until then. This requires explicit vblank
> > syncronisation (which DRM offsers, but pretty much all other display
> > APIs, that are higher-level don't, so I'm just using a refresh-rate
> > timer for them) and flip done notification.
> > 
> > I haven't looked too much at how to flip with a target vblank with DRM
> > directly but maybe the atomic API already has the bits in for that (but
> > I haven't heard of such a thing as a buffer queue, so that makes me
> > doubt it).
> 
> Not directly. What's available is that if userspace waits for vblank n
> and then submits a flip, the flip will complete in vblank n+1 (or a
> later vblank, depending on when the flip is submitted and when the
> fences the flip depends on signal).
> 
> There is reluctance allowing more than one flip to be queued in the
> kernel, as it would considerably increase complexity in the kernel. It
> would probably only be considered if there was a compelling use-case
> which was outright impossible otherwise.
> 
> 
> > Well, I need to handle stuff like SDL in my userspace project, so I have
> > to have all that queuing stuff in software anyway, but it would be good
> > if each project didn't have to implement that. Worst case, it could be
> > in libdrm too.
> 
> Usually, this kind of queuing will be handled in a display server such
> as Xorg or a Wayland compositor, not by the application such as a video
> player itself, or any library in the latter's address space. I'm not
> sure there's much potential for sharing code between display servers for
> this.
> 
> 
> > > In the first, we'd need a mechanism where we can schedule a render at a
> > > specific time or vblank. We can of course already implement this in
> > > software, but with fences, the scheduling would need to be done in the
> > > driver. Then if the fence is signalled earlier, the driver should hold
> > > on until the delay is met. If the fence got signalled late, we also
> > > need to think of a workflow. As we can't schedule more then one render
> > > in DRM at one time, I don't really see yet how to make that work.
> > 
> > Indeed, that's also one of the main issues I've spotted. Before using
> > an implicit fence, we basically have to make sure the frame is due for
> > display at the next vblank. Otherwise, we need to refrain from using
> > the fence and schedule the flip later, which is kind of counter-
> > productive.
> 
> Fences are about signalling that the contents of a frame are "done" and
> ready to be presented. They're not about specifying which frame is to be
> presented when.
> 
> 
> > I feel like specifying a target vblank would be a good unit for that,
> 
> The mechanism described above works for that.
> 
> > since it's our native granularity after all (while a timestamp is not).
> 
> Note that variable refresh rate (Adaptive Sync / FreeSync / G-Sync)
> changes things in this regard. It makes the vblank length variable, and
> if you wait for multiple vblanks between flips, you get the maximum
> vblank length corresponding to the minimum refresh rate / timing
> granularity. Thus, it would be useful to allow userspace to specify a
> timestamp corresponding to the earliest time when the flip is to
> complete. The kernel could then try to hit that as closely as possible.

Rendering a video stream is more complex then what you describe here.
Whenever there is a unexpected delay (late delivery of a frame as an
example) you may endup in situation where one frame is ready after the
targeted vblank. If there is another frame that targets the following
vblank that gets ready on-time, the previous frame should be replaced
by the most recent one.

With fences, what happens is that even if you received the next frame
on time, naively replacing it is not possible, because we don't know
when the fence for the next frame will be signalled. If you simply
always replace the current frame, you may endup skipping a lot more
vblank then what you expect, and that results in jumpy playback.

Render queues with timestamp are used to smooth rendering and handle
rendering collision so that the latency is kept low (like when you have
a 100fps video over a 60Hz display). This is normally done in
userspace, but with fences, you ask the kernel to render something in
an unpredictable future, so we loose the ability to make the final
decision.

> 
> 

