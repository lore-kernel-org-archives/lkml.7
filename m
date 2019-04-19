Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEC9C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CA120693
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="Or5gTy1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbfDSTNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:13:47 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:39410 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfDSTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:13:45 -0400
Received: by mail-qk1-f178.google.com with SMTP id j10so3389899qkk.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=PpIUSk15nxWJsA3TYf0KsoPEdQ/S0Pil7IwighIbZlM=;
        b=Or5gTy1s8mZ8jH+2nJs7p+7aDshTv6eloiqek1aWHwG9X6NDicKcFd0R35m4MzXkkA
         +5EAvl/8OO+HWZoH1iMritgp1cknJ4c9ynffCiJodc8DqOZBeXIAVM1esCTecczPBENs
         yq53rEt85CvzQoif1JoWkzADPYtKfGuvCkjkyJsw48yRlipCNZW/eqDr/hsbYeAHW7oD
         VFjVl44AoiX3eb2yAI1pWc+cVyxU3+PU9RoalTFqdADnBdzsJXA7GGFQGPdmkCJTIuOy
         xjy292/UK7eL84CGlMAf/GSjWEvstKNDY0jnB2cUFA8GadiGBlBv+t3rOKoBgPl8SmFc
         s7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=PpIUSk15nxWJsA3TYf0KsoPEdQ/S0Pil7IwighIbZlM=;
        b=uiaGnbbYUlqKcCJBZ5EdXgI+eYbqz9kQkUwgMJyZpI/WGPJMmsrefEvOLq01+eLCzB
         RxTeN5C93wP3LY3XWl8c69n7hgdV4KnRn5iwXTYeZ2Zj8/X8pP3INPbNBLLurk7eLN/C
         I9XqjgKVeG7jgzU6mpJCgJyrl0ANGnSvhN8TRTUfwMmbcFhVHb+aqZ7Hn+uZkdYGY++4
         i1wP7DqOj3f6ugu6DxYVjBBQQ+GNBO9vLCH+WMR7EVfxDvTz6DrtUD7rnH6Y7oLomRyH
         JAj7xnTBcelq+JJ/mvONQEJkI5xlUXNQWTXYr0PFgyouxfVIpphP9YIz+o6snBk4MOH2
         x4Rg==
X-Gm-Message-State: APjAAAVdXYN2FlCOEKmHp1yVhUtugJpB0M0CD02n84mpFds+q/haPM5Y
        jsguUaq5ML37AoH16TNB82MEQg==
X-Google-Smtp-Source: APXvYqzelYVPsR93oFeLNbjJJp+IkeVpjtH/JE2L/XGVFalF7K7+3MPphDsIcsu9cy4rNc5b3QQoVA==
X-Received: by 2002:a05:620a:1372:: with SMTP id d18mr3396902qkl.310.1555687869833;
        Fri, 19 Apr 2019 08:31:09 -0700 (PDT)
Received: from skullcanyon ([2002:c0de:c115:0:481e:e17e:2f68:43f8])
        by smtp.gmail.com with ESMTPSA id z85sm1161988qka.18.2019.04.19.08.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 08:31:08 -0700 (PDT)
Message-ID: <52e092f7009d57087c10b5e21ea597bcad506bfd.camel@ndufresne.ca>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Tomasz Figa <tfiga@chromium.org>
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
Date:   Fri, 19 Apr 2019 11:31:06 -0400
In-Reply-To: <CAAFQd5CojNuiJ09gXEjnOorfDnRP1Bk436yaffHFKmmsfoUiQQ@mail.gmail.com>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
         <CAAFQd5CojNuiJ09gXEjnOorfDnRP1Bk436yaffHFKmmsfoUiQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 (3.32.0-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 19 avril 2019 à 13:27 +0900, Tomasz Figa a écrit :
> On Fri, Apr 19, 2019 at 9:30 AM Nicolas Dufresne <nicolas@ndufresne.ca> wrote:
> > Le jeudi 18 avril 2019 à 10:18 +0200, Daniel Vetter a écrit :
> > > > It would be cool if both could be used concurrently and not just return
> > > > -EBUSY when the device is used with the other subsystem.
> > > 
> > > We live in this world already :-) I think there's even patches (or merged
> > > already) to add fences to v4l, for Android.
> > 
> > This work is currently suspended. It will require some feature on DRM
> > display to really make this useful, but there is also a lot of
> > challanges in V4L2. In GFX space, most of the use case are about
> > rendering as soon as possible. Though, in multimedia we have two
> > problems, we need to synchronize the frame rendering with the audio,
> > and output buffers may comes out of order due to how video CODECs are
> > made.
> > 
> > In the first, we'd need a mechanism where we can schedule a render at a
> > specific time or vblank. We can of course already implement this in
> > software, but with fences, the scheduling would need to be done in the
> > driver. Then if the fence is signalled earlier, the driver should hold
> > on until the delay is met. If the fence got signalled late, we also
> > need to think of a workflow. As we can't schedule more then one render
> > in DRM at one time, I don't really see yet how to make that work.
> > 
> > For the second, it's complicated on V4L2 side. Currently we signal
> > buffers when they are ready in the display order. With fences, we
> > receive early pairs buffer and fence (in decoding order). There exist
> > cases where reordering is done by the driver (stateful CODEC). We
> > cannot schedule these immediately we would need a new mechanism to know
> > which one come next. If we just reuse current mechnism, it would void
> > the fence usage since the fence will always be signalled by the time it
> > reaches DRM or other v4l2 component.
> > 
> > There also other issues, for video capture pipeline, if you are not
> > rendering ASAP, you need the HW timestamp in order to schedule. Again,
> > we'd get the fence early, but the actual timestamp will be signalled at
> > the very last minutes, so we also risk of turning the fence into pure
> > overhead. Note that as we speak, I have colleagues who are
> > experimenting with frame timestamp prediction that slaves to the
> > effective timestamp (catching up over time). But we still have issues
> > when the capture driver skipped a frame (missed a capture window).
> 
> Note that a fence has a timestamp internally and it can be queried for
> it from the user space if exposed as a sync file:
> https://elixir.bootlin.com/linux/v5.1-rc5/source/drivers/dma-buf/sync_file.c#L386

Don't we need something the other way around ? This seems to be the
timestamp of when it was triggered (I'm not familiar with this though).

> 
> Fences in V4L2 would be also useful for stateless decoders and any
> mem-to-mem processors that operate in order, like the blitters
> mentioned here or actually camera ISPs, which can be often chained
> into relatively sophisticated pipelines.

I agree fence can be used to optimize specific corner cases. They are
not as critical in V4L2 since we have async queues. I think the use
case for fences in V4L2 is mostly to lower the latency. Not all use
cases requires such a low latency. There was argument around fences
that is simplify the the code, I haven't seen a compelling argument
demonstrating that this would be the case for V4L2 programming. The
only case is when doing V4L2 to DRM exchanges, and only in the context
where time synchronization does not matter. In fact, so far it is more
work since information starts flowing through separate events
(buffer/fence first, later timestamps and possibly critical metadata.
This might be induced by the design, but clearly there is a slight API
clash.

> 
> Best regards,
> Tomasz

