Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44005C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209CA2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 12:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfIRMEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 08:04:09 -0400
Received: from foss.arm.com ([217.140.110.172]:40240 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730241AbfIRMEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 08:04:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 564DA337;
        Wed, 18 Sep 2019 05:04:08 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18C053F575;
        Wed, 18 Sep 2019 05:04:08 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id CD0B96827F6; Wed, 18 Sep 2019 13:04:06 +0100 (BST)
Date:   Wed, 18 Sep 2019 13:04:06 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ayan Halder <Ayan.Halder@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>, nd <nd@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected'
 framebuffer
Message-ID: <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
References: <20190909134241.23297-1-ayan.halder@arm.com>
 <20190917125301.GQ3958@phenom.ffwll.local>
 <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 09:49:40AM +0100, Daniel Stone wrote:
> Hi all,

Hi,

> 
> On Tue, 17 Sep 2019 at 13:53, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, Sep 09, 2019 at 01:42:53PM +0000, Ayan Halder wrote:
> > > Let us ignore how the protected system memory is allocated and for the scope of
> > > this discussion, we want to figure out the best way possible for the userspace
> > > to communicate to the drm driver to turn the protected mode on (for accessing the
> > > framebuffer with the DRM content) or off.
> > >
> > > The possible ways by which the userspace could achieve this is via:-
> > >
> > > 1. Modifiers :- This looks to me the best way by which the userspace can
> > > communicate to the kernel to turn the protected mode on for the komeda driver
> > > as it is going to access one of the protected framebuffers. The only problem is
> > > that the current modifiers describe the tiling/compression format. However, it
> > > does not hurt to extend the meaning of modifiers to denote other attributes of
> > > the framebuffer as well.
> > >
> > > The other reason is that on Android, we get an info from Gralloc
> > > (GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protected. This can
> > > be used to set up the modifier/s (AddFB2) during framebuffer creation.
> >
> > How does this mesh with other modifiers, like AFBC? That's where I see the
> > issue here.
> 
> Yeah. On other SoCs, we certainly have usecases for protected content
> with different buffer layouts. The i.MX8M can protect particular
> memory areas and partition them to protect access from particular
> devices (e.g. display controller and video decoder only, not CPU or
> GPU). Those memory areas can contain linear buffers, or tiled buffers,
> or supertiled buffers, or ...
> 
> Stealing a modifier isn't appropriate.

I tend to agree with you here. Given that the modifiers were introduced mostly to
help vendors add their ideosyncratic bits, having a generic flag as a modifier is
not a good idea.

> 
> > 6. Just track this as part of buffer allocation, i.e. I think it does
> > matter how you allocate these protected buffers. We could add a "is
> > protected buffer" flag at the dma_buf level for this.
> 
> I totally agree. Framebuffers aren't about the underlying memory they
> point to, but about how to _interpret_ that memory: it decorates a
> pointer with width, height, stride, format, etc, to allow you to make
> sense of that memory. I see content protection as being the same as
> physical contiguity, which is a property of the underlying memory
> itself. Regardless of the width, height, or format, you just cannot
> access that memory unless it's under the appropriate ('secure enough')
> conditions.
> 
> So I think a dmabuf attribute would be most appropriate, since that's
> where you have to do all your MMU handling, and everything else you
> need to do to allow access to that buffer, anyway.

Isn't it how AMD currently implements protected buffers as well?

> 
> > So yeah for this stuff here I think we do want the full userspace side,
> > from allocator to rendering something into this protected buffers (no need
> > to also have the entire "decode a protected bitstream part" imo, since
> > that will freak people out). Unfortunately, in my experience, that kills
> > it for upstream :-/ But also in my experience of looking into this for
> > other gpu's, we really need to have the full picture here to make sure
> > we're not screwing this up.
> 
> Yeah. I know there are a few people looking at this at the moment, so
> hopefully we are able to get something up and out in the open as a
> strawman.
> 
> There's a lot of complexity beyond just 'it's protected'; for
> instance, some CP providers mandate that their content can only be
> streamed over HDCP 2.2 Type-1 when going through an external
> connection. One way you could do that is to use a secure world
> (external controller like Intel's ME, or CPU-internal enclave like SGX
> or TEE) to examine the display pipe configuration, and only then allow
> access to the buffers and/or keys. Stuff like that is always going to
> be out in the realm of vendor & product-policy-specific add-ons, but
> it should be possible to agree on at least the basic mechanics and
> expectations of a secure path without things like that.

I also expect that going through the secure world will be pretty much transparent for
the kernel driver, as the most likely hardware implementations would enable
additional signaling that will get trapped and handled by the secure OS. I'm not
trying to simplify things, just taking the stance that it is userspace that is
coordinating all this, we're trying only to find a common ground on how to handle
this in the kernel.

Best regards,
Liviu

> 
> Cheers,
> Daniel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
