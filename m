Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD85C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4283205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="a7DO3X1D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbfISOKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:10:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46558 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732274AbfISOKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:10:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id f21so3140325otl.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUHZ6skhWOFY3rNEMxex/mPZG8s6EHtinrCSJMSwzhw=;
        b=a7DO3X1D3qGDmJBSvrzYhEdmHsXfeQz8ERSO+dg2ScKV+hMCa8ts734NtNIc1iew3c
         MyG7xi4rdQbutdgYNLeNg2jl6MAIOytvNZMZmB/NgRmLgG4TbGcZqDZetjvo+elj6RHO
         YzUhvJgtqp2cDU/vl2xsWf3J4lV/+zBEEj8qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUHZ6skhWOFY3rNEMxex/mPZG8s6EHtinrCSJMSwzhw=;
        b=tGvon9cLaKGMdwCcf/36AZJy9joMaS89+ZFWYH+kt37Fyq7AedSCRxi7V/uh+wMrYA
         Of1blrck/MYReyrc4OeD9tesg3+QSgvxtsra19KqIWnVpXFPyRxKrcRH2r5yOprzy6FK
         OwCOQjrNmpoDarvbRVnbEogz6SHCh6jk1mbKFRSyaUgeOvPERo6LXK1cedvBSQ4BLKod
         2ifs8LyuRGbqITwB2V5JCtU/soZbjEG8xx7K3BVE/we3CvwuU/4o4r56aU+lRIYyKAyV
         ogQ7UKZ+8ufoK01HIB9DH1/Rr2+wDH3M3Q2gqhTtnNR6ZdBnkcVCVifwzH/bFKyUAEqm
         PdlA==
X-Gm-Message-State: APjAAAXVUf9eAwXg+bunUcjEJV90A7nllRAPm2959xvLySdnfmXVVtV1
        SZa5JcitdzWEu0LhuhKbvDSaUKnjgh1Z2daIaGdexg==
X-Google-Smtp-Source: APXvYqwsKOVIk+xBH1gPnu3e1W+c70kBpUSEBBK8RfXHm8s7wjE5WeBLH0IgyGZFY/w0+npPjztDiAsqF0chETEeT3Q=
X-Received: by 2002:a9d:7ace:: with SMTP id m14mr4051422otn.106.1568902254044;
 Thu, 19 Sep 2019 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190909134241.23297-1-ayan.halder@arm.com> <20190917125301.GQ3958@phenom.ffwll.local>
 <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com>
 <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
 <CAPj87rOc3MvkjrX1qHpGuVUaGLuZiC7QYBO9v3T2NS+dicLC1g@mail.gmail.com> <20190919140323.GA3456@arm.com>
In-Reply-To: <20190919140323.GA3456@arm.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 19 Sep 2019 16:10:42 +0200
Message-ID: <CAKMK7uHYy9pfmqV_qE948QMPOaxHsJ2sy3+J4kQqixanLP_SUQ@mail.gmail.com>
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

On Thu, Sep 19, 2019 at 4:03 PM Ayan Halder <Ayan.Halder@arm.com> wrote:
>
> On Wed, Sep 18, 2019 at 10:30:12PM +0100, Daniel Stone wrote:
>
> Hi All,
> Thanks for your suggestions.
>
> > Hi Liviu,
> >
> > On Wed, 18 Sep 2019 at 13:04, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > > On Wed, Sep 18, 2019 at 09:49:40AM +0100, Daniel Stone wrote:
> > > > I totally agree. Framebuffers aren't about the underlying memory they
> > > > point to, but about how to _interpret_ that memory: it decorates a
> > > > pointer with width, height, stride, format, etc, to allow you to make
> > > > sense of that memory. I see content protection as being the same as
> > > > physical contiguity, which is a property of the underlying memory
> > > > itself. Regardless of the width, height, or format, you just cannot
> > > > access that memory unless it's under the appropriate ('secure enough')
> > > > conditions.
> > > >
> > > > So I think a dmabuf attribute would be most appropriate, since that's
> > > > where you have to do all your MMU handling, and everything else you
> > > > need to do to allow access to that buffer, anyway.
> > >
> > > Isn't it how AMD currently implements protected buffers as well?
> >
> > No idea to be honest, I haven't seen anything upstream.
> >
> > > > There's a lot of complexity beyond just 'it's protected'; for
> > > > instance, some CP providers mandate that their content can only be
> > > > streamed over HDCP 2.2 Type-1 when going through an external
> > > > connection. One way you could do that is to use a secure world
> > > > (external controller like Intel's ME, or CPU-internal enclave like SGX
> > > > or TEE) to examine the display pipe configuration, and only then allow
> > > > access to the buffers and/or keys. Stuff like that is always going to
> > > > be out in the realm of vendor & product-policy-specific add-ons, but
> > > > it should be possible to agree on at least the basic mechanics and
> > > > expectations of a secure path without things like that.
> > >
> > > I also expect that going through the secure world will be pretty much transparent for
> > > the kernel driver, as the most likely hardware implementations would enable
> > > additional signaling that will get trapped and handled by the secure OS. I'm not
> > > trying to simplify things, just taking the stance that it is userspace that is
> > > coordinating all this, we're trying only to find a common ground on how to handle
> > > this in the kernel.
> >
> > Yeah, makes sense.
> >
> > As a strawman, how about a new flag to drmPrimeHandleToFD() which sets
> > the 'protected' flag on the resulting dmabuf?
>
> To be honest, during our internal discussion james.qian.wang@arm.com had a
> similar suggestion of adding a new flag to dma_buf but I decided
> against it.
>
> As per my understanding, adding custom dma buf flags (like
> AMDGPU_GEM_CREATE_XXX, etc) is possible if we(Arm) had our own allocator. We
> rely on the dumb allocator and ion allocator for framebuffer creation.
>
> I was looking at an allocator independent way of userspace
> communicating to the drm framework that the framebuffer is protected.
>
> Thus, it looked to me that framebuffer modifier is the best (or the least
> corrupt) way of going forth.
>
> We use ion and dumb allocator for framebuffer object creation. The way
> I see it is as follows :-
>
> 1. For ion allocator :-
> Userspace can specify that it wants the buffer from a secure heap or any other
> special region of heap. The ion driver will either fault into the secure os to
> create the buffers or it will do some other magic. Honestly, I have still not
> figured that out. But it will be agnostic to the drm core.

Allocating buffers from a special heap is what I expected the
interface to be. The issue is that if we specify the secure mode any
time later on, then it could be changed. E.g. with Daniel Stone's idea
of a handle2fd flag, you could export the buffer twice, once secure,
once non-secure. That sounds like a silly thing to me, and better to
prevent that - or is this actually possible/wanted, i.e. do we want to
change the secure mode for a buffer later on?

> The userspace gets a handle to the buffer and then it calls addFB2 with
> DRM_FORMAT_MOD_ARM_PROTECTED, so that the driver can configure the
> dpu's protection bits (to access the memory with special signals).

If we allocate a secure buffer there's no need for flags anymore I
think - it would be a property of the underlying buffer (like a
contiguous buffer). All we need are two things:
- make sure secure buffers can only be imported by secure-buffer aware drivers
- some way for such drivers to figure out whether they deal with a
secure buffer or not.

There's no need for any flags anywhere else with the ion/secure
dma-buf heap solution. E.g. for contig buffer we also dont pass around
a DRM_FORMAT_MOD_PHYSICALLY_CONTIG for addfb2.

> 2. For dumb allocator :-
> I am curious to know if we can add 'IS_PROTECTED' flag to
> drm_mode_create_dumb.flags. This can/might be used to set dma_buf
> flags. Let me know if this is an incorrect/forbidden path.

dumb is dumb, this definitely feels like the wrong interface to me.

> In a nutshell, my objective is to figure out if the userspace is able
> to communicate to the drm core about the 'protection' status of the
> buffer without introducing Arm specific buffer allocator.

Why does userspace need to communicate this again? What's the issue
with using an ARM specific allocator for this?
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
