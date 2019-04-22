Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238BCC282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D443420859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 04:03:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cVcB0bXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfDVEDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 00:03:03 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38541 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfDVEDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 00:03:03 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so8607072ote.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 21:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t7IPS9mfga4XNGjfZtUxnnI2pw5QR9nHoPHUpg3Byiw=;
        b=cVcB0bXih+SRU7mpeg+XFR3ke6XyQHcF9Ew6MKSYzgicJuW9pU1BPzjk6wNXjFFaF4
         eUqvGHMMLIhghvgalAzBsJLywLKeL/r2lBTD1FKnFnT8T/xqfJis9lTpr22ULSnczccj
         rfgM0Yw7ZasHvJFS2pOGXXBExRcr//x9bJ9vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t7IPS9mfga4XNGjfZtUxnnI2pw5QR9nHoPHUpg3Byiw=;
        b=d3ObbOioFKjWljgHR1zOzpkNhZL0SFO1tqZCqjrDAsRbwSxcIbs2RJsFHe0qrQWGXp
         O0oGJf0Gyv5RLO2Z0nOg5Dh1sj39vvGYZ/OALOekEOMACCSCFd/d5pjJWaFCCTWobI/2
         ajD4D4TkLPYZv9HevTcRrEz5iDdEJaMRpW/IEiHceqh9BzZBnlWM3Etg/rwLUjkt6uw3
         M4Qf44T6EUTDj8H2ZeYKx2FnxGllJfkDfkQK5Z0DySq5zRvwhpgQu6drjn1PvXNCHcwY
         rztcIwngyzR4hLdXuI0S54BGsMSJ2JgO/lLuCY3aUwuElYWoe5K5ZpkiA3+q7GOZQMKh
         5WOA==
X-Gm-Message-State: APjAAAUqelA5efK3vs33s0ZddQsKJKYX5T4ME2AyhCZjvdi+bZ+ekRGo
        1X4/mC4OJTnaITn48OqfedDgkO0X5xk=
X-Google-Smtp-Source: APXvYqwmbC3ShvPLNVA2epO9V8QQoVizNQBJqHV9Yn6G0sG97d9MaZ8Wu7F9AWWJTW2AWcrQGdwK9g==
X-Received: by 2002:a05:6830:1310:: with SMTP id p16mr10081325otq.110.1555905781498;
        Sun, 21 Apr 2019 21:03:01 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id b17sm5104146otq.26.2019.04.21.21.03.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 21:03:00 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id v10so7637658oib.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 21:03:00 -0700 (PDT)
X-Received: by 2002:aca:a894:: with SMTP id r142mr9084484oie.112.1555905779855;
 Sun, 21 Apr 2019 21:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
 <20190418081816.GO13337@phenom.ffwll.local> <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
 <CAAFQd5CojNuiJ09gXEjnOorfDnRP1Bk436yaffHFKmmsfoUiQQ@mail.gmail.com> <52e092f7009d57087c10b5e21ea597bcad506bfd.camel@ndufresne.ca>
In-Reply-To: <52e092f7009d57087c10b5e21ea597bcad506bfd.camel@ndufresne.ca>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 22 Apr 2019 13:02:48 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DZ+7roRx7OADRvs3KYuMsJep=+P6vu4ricHzhWqU=ohQ@mail.gmail.com>
Message-ID: <CAAFQd5DZ+7roRx7OADRvs3KYuMsJep=+P6vu4ricHzhWqU=ohQ@mail.gmail.com>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Eric Anholt <eric@anholt.net>, Rob Clark <robdclark@gmail.com>,
        Dave Airlie <airlied@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 12:31 AM Nicolas Dufresne <nicolas@ndufresne.ca> wr=
ote:
>
> Le vendredi 19 avril 2019 =C3=A0 13:27 +0900, Tomasz Figa a =C3=A9crit :
> > On Fri, Apr 19, 2019 at 9:30 AM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > > Le jeudi 18 avril 2019 =C3=A0 10:18 +0200, Daniel Vetter a =C3=A9crit=
 :
> > > > > It would be cool if both could be used concurrently and not just =
return
> > > > > -EBUSY when the device is used with the other subsystem.
> > > >
> > > > We live in this world already :-) I think there's even patches (or =
merged
> > > > already) to add fences to v4l, for Android.
> > >
> > > This work is currently suspended. It will require some feature on DRM
> > > display to really make this useful, but there is also a lot of
> > > challanges in V4L2. In GFX space, most of the use case are about
> > > rendering as soon as possible. Though, in multimedia we have two
> > > problems, we need to synchronize the frame rendering with the audio,
> > > and output buffers may comes out of order due to how video CODECs are
> > > made.
> > >
> > > In the first, we'd need a mechanism where we can schedule a render at=
 a
> > > specific time or vblank. We can of course already implement this in
> > > software, but with fences, the scheduling would need to be done in th=
e
> > > driver. Then if the fence is signalled earlier, the driver should hol=
d
> > > on until the delay is met. If the fence got signalled late, we also
> > > need to think of a workflow. As we can't schedule more then one rende=
r
> > > in DRM at one time, I don't really see yet how to make that work.
> > >
> > > For the second, it's complicated on V4L2 side. Currently we signal
> > > buffers when they are ready in the display order. With fences, we
> > > receive early pairs buffer and fence (in decoding order). There exist
> > > cases where reordering is done by the driver (stateful CODEC). We
> > > cannot schedule these immediately we would need a new mechanism to kn=
ow
> > > which one come next. If we just reuse current mechnism, it would void
> > > the fence usage since the fence will always be signalled by the time =
it
> > > reaches DRM or other v4l2 component.
> > >
> > > There also other issues, for video capture pipeline, if you are not
> > > rendering ASAP, you need the HW timestamp in order to schedule. Again=
,
> > > we'd get the fence early, but the actual timestamp will be signalled =
at
> > > the very last minutes, so we also risk of turning the fence into pure
> > > overhead. Note that as we speak, I have colleagues who are
> > > experimenting with frame timestamp prediction that slaves to the
> > > effective timestamp (catching up over time). But we still have issues
> > > when the capture driver skipped a frame (missed a capture window).
> >
> > Note that a fence has a timestamp internally and it can be queried for
> > it from the user space if exposed as a sync file:
> > https://elixir.bootlin.com/linux/v5.1-rc5/source/drivers/dma-buf/sync_f=
ile.c#L386
>
> Don't we need something the other way around ? This seems to be the
> timestamp of when it was triggered (I'm not familiar with this though).
>

Honestly, I'm not fully sure what this timestamp is expected to be.

For video capture pipeline the fence would signal once the whole frame
is captured, so I think it could be a reasonable value to consider
later in the pipeline?

> >
> > Fences in V4L2 would be also useful for stateless decoders and any
> > mem-to-mem processors that operate in order, like the blitters
> > mentioned here or actually camera ISPs, which can be often chained
> > into relatively sophisticated pipelines.
>
> I agree fence can be used to optimize specific corner cases. They are
> not as critical in V4L2 since we have async queues.

I wouldn't call those corner cases. A stateful decoder is actually one
of the opposite extremes, because one would normally just decode and
show the frame, so not much complexity needed to handle it and async
queues actually work quite well.

I don't think async queues are very helpful for any more complicated
use cases. The userspace still needs to wake up and push the buffers
through the pipeline. If you have some depth across the whole
pipeline, with queues always having some buffers waiting to be
processed, fences indeed wouldn't change too much (+/- the CPU
time/power wasted on context switches). However, with real time use
cases, such as anything involving streaming from cameras, image
processing stages and encoding into a stream to be passed to a
latency-sensitive application, such as WebRTC, the latency imposed by
the lack of fences would be significant. Especially if the image
processing in between consists of several inter-dependent stages.

> I think the use
> case for fences in V4L2 is mostly to lower the latency. Not all use
> cases requires such a low latency.

Indeed, not all, but I think it doesn't make fences less important,
given that there are use cases that require such a low latency.

> There was argument around fences
> that is simplify the the code, I haven't seen a compelling argument
> demonstrating that this would be the case for V4L2 programming. The
> only case is when doing V4L2 to DRM exchanges, and only in the context
> where time synchronization does not matter.

Another huge use case would be Android. The lack of fences is a
significant show stopper for V4L2 adoption there.

Also, V4L2 to GPU (GLES, Vulkan) exchange should not be forgotten too.

> In fact, so far it is more
> work since information starts flowing through separate events
> (buffer/fence first, later timestamps and possibly critical metadata.
> This might be induced by the design, but clearly there is a slight API
> clash.

Well, nothing is perfect from the start. (In fact, probably nothing is
perfect in general. ;))

Best regards,
Tomasz
