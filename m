Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61048C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190982067B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="UK80wxYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbfITOFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:05:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41902 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfITOFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:05:35 -0400
Received: by mail-ot1-f67.google.com with SMTP id g13so6267198otp.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 07:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bt9s8iSgfxjO75odSd5FLVQOrczyANz18siYaB/70g=;
        b=UK80wxYR6MWXy40PM3TwPZP2pD2sFhPy52wQk21gNcGB/SCBHppKRl9zoGiY15jKZF
         22cUrSwEhvSHKPYQb4OKThSah8aa001ZFpGkjmLcbnrpu1P18oVpWG+zbZWu1rzq3nX7
         J7S6zrfOgI+ZcqbVZC83KYfBTUEufyIEQNw80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bt9s8iSgfxjO75odSd5FLVQOrczyANz18siYaB/70g=;
        b=akwcsLUDlrx/PgO3NEFsCr0S+H0iTKI/8B9hotdDN/Mflwk+T7xVqHSofiLz1Jn3PX
         vPrBCK4Q+pMEwh+mdTnNKqmSV/l24eLYXHzTgRLqrySF1F0L1yLq6BSt16ng2PCN6eCs
         kq3dhvTcsydrraLC13psaBjbE9MgR1b6XJhlIB3sXH+QYS1F2nba/gMdljm8e8SpQd4p
         4no6vvR8btF9ssWZ9EO6FcYCENqaicwdk2luTMKKzrkUTcm0AR6KNfMqZdprBhC31R5h
         zQGUwn8IbrONJkIClTBwGNzBmxBKJiz70MvWosOkXPs3IK6nlOLhWaIS1Vs/O4WqpyKI
         WO+w==
X-Gm-Message-State: APjAAAW7iPwp2C5iiFgv3gCuCrX+jdBB5ztdmgTBUg6bw1+4d/iIa7Zs
        4qlBBFIUwxkjB1IE6jlEoZbutSIiZsODSqsNMPFjvA==
X-Google-Smtp-Source: APXvYqxja27wgUREnk3jJsiTRzKjBztfyyo/LxEMyvahoTp+szdUihByVlLG/GL31LIK4bK1yKcwVsZANvkferfR89U=
X-Received: by 2002:a9d:7006:: with SMTP id k6mr11446512otj.303.1568988333826;
 Fri, 20 Sep 2019 07:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190909134241.23297-1-ayan.halder@arm.com> <20190917125301.GQ3958@phenom.ffwll.local>
 <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com>
 <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
 <CAPj87rOc3MvkjrX1qHpGuVUaGLuZiC7QYBO9v3T2NS+dicLC1g@mail.gmail.com>
 <20190919140323.GA3456@arm.com> <CAKMK7uHYy9pfmqV_qE948QMPOaxHsJ2sy3+J4kQqixanLP_SUQ@mail.gmail.com>
 <20190919151310.GA12236@arm.com>
In-Reply-To: <20190919151310.GA12236@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 20 Sep 2019 16:05:22 +0200
Message-ID: <CAKMK7uFJMmPT=-=OEEypxADhvcOwip+8RcnFnyPdt08EMLmZog@mail.gmail.com>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected' framebuffer
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Daniel Stone <daniel@fooishbar.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>, nd <nd@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 5:13 PM Ayan Halder <Ayan.Halder@arm.com> wrote:
>
> On Thu, Sep 19, 2019 at 04:10:42PM +0200, Daniel Vetter wrote:
> > On Thu, Sep 19, 2019 at 4:03 PM Ayan Halder <Ayan.Halder@arm.com> wrote:
> > >
> > > On Wed, Sep 18, 2019 at 10:30:12PM +0100, Daniel Stone wrote:
> > >
> > > Hi All,
> > > Thanks for your suggestions.
> > >
> > > > Hi Liviu,
> > > >
> > > > On Wed, 18 Sep 2019 at 13:04, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > > > On Wed, Sep 18, 2019 at 09:49:40AM +0100, Daniel Stone wrote:
> > > > > > I totally agree. Framebuffers aren't about the underlying memory they
> > > > > > point to, but about how to _interpret_ that memory: it decorates a
> > > > > > pointer with width, height, stride, format, etc, to allow you to make
> > > > > > sense of that memory. I see content protection as being the same as
> > > > > > physical contiguity, which is a property of the underlying memory
> > > > > > itself. Regardless of the width, height, or format, you just cannot
> > > > > > access that memory unless it's under the appropriate ('secure enough')
> > > > > > conditions.
> > > > > >
> > > > > > So I think a dmabuf attribute would be most appropriate, since that's
> > > > > > where you have to do all your MMU handling, and everything else you
> > > > > > need to do to allow access to that buffer, anyway.
> > > > >
> > > > > Isn't it how AMD currently implements protected buffers as well?
> > > >
> > > > No idea to be honest, I haven't seen anything upstream.
> > > >
> > > > > > There's a lot of complexity beyond just 'it's protected'; for
> > > > > > instance, some CP providers mandate that their content can only be
> > > > > > streamed over HDCP 2.2 Type-1 when going through an external
> > > > > > connection. One way you could do that is to use a secure world
> > > > > > (external controller like Intel's ME, or CPU-internal enclave like SGX
> > > > > > or TEE) to examine the display pipe configuration, and only then allow
> > > > > > access to the buffers and/or keys. Stuff like that is always going to
> > > > > > be out in the realm of vendor & product-policy-specific add-ons, but
> > > > > > it should be possible to agree on at least the basic mechanics and
> > > > > > expectations of a secure path without things like that.
> > > > >
> > > > > I also expect that going through the secure world will be pretty much transparent for
> > > > > the kernel driver, as the most likely hardware implementations would enable
> > > > > additional signaling that will get trapped and handled by the secure OS. I'm not
> > > > > trying to simplify things, just taking the stance that it is userspace that is
> > > > > coordinating all this, we're trying only to find a common ground on how to handle
> > > > > this in the kernel.
> > > >
> > > > Yeah, makes sense.
> > > >
> > > > As a strawman, how about a new flag to drmPrimeHandleToFD() which sets
> > > > the 'protected' flag on the resulting dmabuf?
> > >
> > > To be honest, during our internal discussion james.qian.wang@arm.com had a
> > > similar suggestion of adding a new flag to dma_buf but I decided
> > > against it.
> > >
> > > As per my understanding, adding custom dma buf flags (like
> > > AMDGPU_GEM_CREATE_XXX, etc) is possible if we(Arm) had our own allocator. We
> > > rely on the dumb allocator and ion allocator for framebuffer creation.
> > >
> > > I was looking at an allocator independent way of userspace
> > > communicating to the drm framework that the framebuffer is protected.
> > >
> > > Thus, it looked to me that framebuffer modifier is the best (or the least
> > > corrupt) way of going forth.
> > >
> > > We use ion and dumb allocator for framebuffer object creation. The way
> > > I see it is as follows :-
> > >
> > > 1. For ion allocator :-
> > > Userspace can specify that it wants the buffer from a secure heap or any other
> > > special region of heap. The ion driver will either fault into the secure os to
> > > create the buffers or it will do some other magic. Honestly, I have still not
> > > figured that out. But it will be agnostic to the drm core.
> >
> > Allocating buffers from a special heap is what I expected the
> > interface to be. The issue is that if we specify the secure mode any
> > time later on, then it could be changed. E.g. with Daniel Stone's idea
> > of a handle2fd flag, you could export the buffer twice, once secure,
> > once non-secure. That sounds like a silly thing to me, and better to
> > prevent that - or is this actually possible/wanted, i.e. do we want to
> > change the secure mode for a buffer later on?
> >
> > > The userspace gets a handle to the buffer and then it calls addFB2 with
> > > DRM_FORMAT_MOD_ARM_PROTECTED, so that the driver can configure the
> > > dpu's protection bits (to access the memory with special signals).
> >
> > If we allocate a secure buffer there's no need for flags anymore I
> > think - it would be a property of the underlying buffer (like a
> > contiguous buffer). All we need are two things:
> > - make sure secure buffers can only be imported by secure-buffer aware drivers
> > - some way for such drivers to figure out whether they deal with a
> > secure buffer or not.
>
> I am with you on this. Yes, we need to communicate the above two
> things.
>
> >
> > There's no need for any flags anywhere else with the ion/secure
> > dma-buf heap solution. E.g. for contig buffer we also dont pass around
> > a DRM_FORMAT_MOD_PHYSICALLY_CONTIG for addfb2.
>
> Sorry, I could not follow you here. For the driver to know if it is importing
> a secure buffer or using a secure buffer, it needs some flags, right?

It needs that information somehow. It doesn't necessarily need to be a
flag in the uapi, it could be simply a bit of information attached to
the dma-buf.

> Or on a second thought, are you suggesting that we should stick with
> a dma_buf flag (IS_PROTECTED) only ?

Not sure whether you mean some kind of uapi dma-buf flag or something
internal, so not clear whether I should say yes or no.

> > > 2. For dumb allocator :-
> > > I am curious to know if we can add 'IS_PROTECTED' flag to
> > > drm_mode_create_dumb.flags. This can/might be used to set dma_buf
> > > flags. Let me know if this is an incorrect/forbidden path.
> >
> > dumb is dumb, this definitely feels like the wrong interface to me.
> >
> > > In a nutshell, my objective is to figure out if the userspace is able
> > > to communicate to the drm core about the 'protection' status of the
> > > buffer without introducing Arm specific buffer allocator.
> >
> > Why does userspace need to communicate this again? What's the issue
> > with using an ARM specific allocator for this?
>
> We never felt the need to create an Arm specific allocator. Either
> Dumb or Ion allocator would always suffice our purpose.
>
> To upstream 'protected mode' feature of our komeda driver, if we need to
> write our own allocator, it will be a big overhead. :)

There has been patches floating around to add a secure buffer heap (to
ion, or as a new stand-alone allocator). I'm assuming that secure
buffer mode is something that's at least somewhat standardized in the
arm world (so that all the gfx ip can share such a buffer). Hence a
standalone allocator that all drivers which want to support these
secure buffers on arm platforms can interface with sounds like a good
idea to me.

> Also to answer your earlier question
>
> "But if it's a generic flag, how do you combine that with other
> modifiers? Like if you have a tiled buffer, but also encrypted? Or
> afbc compressed, or whatever else. I'd expect for your hw encryption
> is orthogonal to the buffer/tiling/compression format used?"
>
> Yes, hw encryption(protected mode) is orthogonal/independent to AFBC compression.
> Thus, any/all AFBC buffers can be supported with/without protected
> mode.

Ok, so definitely not a modifier then.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
