Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950FFC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E13218AF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="zxCefSD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfIRIuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:50:14 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39050 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbfIRIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:50:14 -0400
Received: by mail-lj1-f193.google.com with SMTP id s19so6359466lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6q7uCCZSSADwRlHxFu6ux7yC9JhkduYPvph1442CL4k=;
        b=zxCefSD7LjgBFTHgkZwTLZfMp1f8aw6Gke6EoeuB9TJejvfN6BL0LwiSpSWvQeXSDO
         iGv1mtMtbXJoY9x7H2wnmGf2/dqhj6pebZgGqngvuLsEhtxPj83UZL/gqi/2UkHFIpgV
         odvlb14rxvpcYEh6RdkV68mEVHBoDueR6ivcq9P/qP5WywIGOeQUA+V9hFfpzehNjt1g
         RUkpDz8kVEsPGTzvbI9YtMPGP4ZpMUIlFp40wS7BqYD/y7mjmruYIY3TYVg1ecaET7qj
         RJ78TEFkiXO5c+ASuB/8fjh2Xx/oEopaoHghNF7JZmB83TRst8KBcdFFRTHERzP4vAna
         ejcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6q7uCCZSSADwRlHxFu6ux7yC9JhkduYPvph1442CL4k=;
        b=n071+qsnPBK85TS2zHJT/9yB2n6GB9K1OPDeFowvpok8MAPRQAXRkrgDj81F1ngXA9
         o8770/KIG+ASiuYLr/PbUontpanR2ZSOYGSAGCl/olSvd16I/0yGYKczQ7dj8gfPLKyl
         9wI5+Jau+cceT9cJNklBBEkP1TIZ5l9mkCJv9yiZNLBMHESusPL3kzVeygNl0c8iA7UX
         Ynq4rvJz7FQY993bqTJlb65mwnXGr1wY4SHU/lNJVa89AWVJW6pMNe01BjoZc0wv1QR8
         F214kk5deko5LrhS4j0FrMbNToX87oMB0xn38uAPrJCCQOdLZ/VCwQDw/5E+M5Z6eHAf
         eMTw==
X-Gm-Message-State: APjAAAU1c/eJi1iELKWRKUbzpNxwP1dzA/xJxWSBCexLeLEdwvzy7rNq
        7JvSFiYJhl1CqWweF3yvFTDTCVRas1dMkdl6XznhPw==
X-Google-Smtp-Source: APXvYqwBmulXcdAzd3O6e/cMwT44uI1DFSHDnjcwscnJwRvt1GO+YRyfzpqjE4KnpK5xPtc2pXODv4CXsMKTSUnQOsY=
X-Received: by 2002:a2e:8052:: with SMTP id p18mr1474965ljg.198.1568796610579;
 Wed, 18 Sep 2019 01:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190909134241.23297-1-ayan.halder@arm.com> <20190917125301.GQ3958@phenom.ffwll.local>
In-Reply-To: <20190917125301.GQ3958@phenom.ffwll.local>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 18 Sep 2019 09:49:40 +0100
Message-ID: <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected' framebuffer
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Ayan Halder <Ayan.Halder@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>, nd <nd@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 17 Sep 2019 at 13:53, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Mon, Sep 09, 2019 at 01:42:53PM +0000, Ayan Halder wrote:
> > Let us ignore how the protected system memory is allocated and for the scope of
> > this discussion, we want to figure out the best way possible for the userspace
> > to communicate to the drm driver to turn the protected mode on (for accessing the
> > framebuffer with the DRM content) or off.
> >
> > The possible ways by which the userspace could achieve this is via:-
> >
> > 1. Modifiers :- This looks to me the best way by which the userspace can
> > communicate to the kernel to turn the protected mode on for the komeda driver
> > as it is going to access one of the protected framebuffers. The only problem is
> > that the current modifiers describe the tiling/compression format. However, it
> > does not hurt to extend the meaning of modifiers to denote other attributes of
> > the framebuffer as well.
> >
> > The other reason is that on Android, we get an info from Gralloc
> > (GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protected. This can
> > be used to set up the modifier/s (AddFB2) during framebuffer creation.
>
> How does this mesh with other modifiers, like AFBC? That's where I see the
> issue here.

Yeah. On other SoCs, we certainly have usecases for protected content
with different buffer layouts. The i.MX8M can protect particular
memory areas and partition them to protect access from particular
devices (e.g. display controller and video decoder only, not CPU or
GPU). Those memory areas can contain linear buffers, or tiled buffers,
or supertiled buffers, or ...

Stealing a modifier isn't appropriate.

> 6. Just track this as part of buffer allocation, i.e. I think it does
> matter how you allocate these protected buffers. We could add a "is
> protected buffer" flag at the dma_buf level for this.

I totally agree. Framebuffers aren't about the underlying memory they
point to, but about how to _interpret_ that memory: it decorates a
pointer with width, height, stride, format, etc, to allow you to make
sense of that memory. I see content protection as being the same as
physical contiguity, which is a property of the underlying memory
itself. Regardless of the width, height, or format, you just cannot
access that memory unless it's under the appropriate ('secure enough')
conditions.

So I think a dmabuf attribute would be most appropriate, since that's
where you have to do all your MMU handling, and everything else you
need to do to allow access to that buffer, anyway.

> So yeah for this stuff here I think we do want the full userspace side,
> from allocator to rendering something into this protected buffers (no need
> to also have the entire "decode a protected bitstream part" imo, since
> that will freak people out). Unfortunately, in my experience, that kills
> it for upstream :-/ But also in my experience of looking into this for
> other gpu's, we really need to have the full picture here to make sure
> we're not screwing this up.

Yeah. I know there are a few people looking at this at the moment, so
hopefully we are able to get something up and out in the open as a
strawman.

There's a lot of complexity beyond just 'it's protected'; for
instance, some CP providers mandate that their content can only be
streamed over HDCP 2.2 Type-1 when going through an external
connection. One way you could do that is to use a secure world
(external controller like Intel's ME, or CPU-internal enclave like SGX
or TEE) to examine the display pipe configuration, and only then allow
access to the buffers and/or keys. Stuff like that is always going to
be out in the realm of vendor & product-policy-specific add-ons, but
it should be possible to agree on at least the basic mechanics and
expectations of a secure path without things like that.

Cheers,
Daniel
