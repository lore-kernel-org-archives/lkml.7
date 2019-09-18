Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E37C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A20721907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 21:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="vNFdVJ4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbfIRVaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 17:30:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34592 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727737AbfIRVap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 17:30:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id h2so1452569ljk.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 14:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DgXcHi6LumSKsXK0wFWEwwduH7TINsc4eJamWRt8yTs=;
        b=vNFdVJ4Cy7O0KvtSmfLAMZIlx2ACs+W2rohq5rc57FADo2r7TLRP84H/5yLIk1n/Oo
         CE0vwxDAWySlGwvp3ZH3lB7X7IhP1ItywFul3J7t1n0hC3aFEVhMziVOVXy5T2lxNYp4
         aUeIYCDF0Rl3JX/RHpOKkLexC2a1tk5adVMrwXwY1OEEDJ5m2+ueFrAWaRE0+ciFjNaJ
         m8E+XeqK4nA+wVkO7ZOI8PoQhq3lL4wA4nl7Ra5LQ+LTW4lkE8EYhhLACASslmWDs/e2
         Fhh0x6XH4xpO1dwZ/8OOwmNFDdND6qrL2s0hlSGUSSq5wGQFKc/nd3NYm3ch7OVcMTV4
         mwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DgXcHi6LumSKsXK0wFWEwwduH7TINsc4eJamWRt8yTs=;
        b=jSz0Ek3JDWhN2hvgo6M0ueo8PGra1t/uu/ADVMWVbJ8CmFgakAO2eGps5eIOQFBM58
         U40oMQ93Arqv4UQZ37iQyrfZFtIXimnCXBW9KR3amve/zXWuNiaks7Dd4oMmNUMpg5Ko
         E3HILXaXum97/mNogm0yPteRQEF+1bA6BaiZ2Sp+IxcUv5IrMxmtTZtPguTtUXTVCqDB
         aO9tSbHhqXXNu+ho0b+aqgwmqWiOfCSWp7xM64sgCWD4hGenZavem67/pvHB+ZSZvahA
         bty8fJDQbiE5WlYhxpDN3iAUTUDyQIdk5KmckwC6LHOwsTAvCXdqjLGd2NL3A/GAIqjL
         9RIA==
X-Gm-Message-State: APjAAAW9HsntTfoWSxTZOdV1qjWtgdkmbqgqQiOd1A1lqWF2IgMekDEU
        e6ielF8oGuEhrYyJj4/PuGxYNDZnPimiQrS2hrvVxskH
X-Google-Smtp-Source: APXvYqyePKGlRziWEiHqR1qCoWiek3z/Uuv9JUuFQfSQKcMTIWc0oHevPua7uJ+FXlrkyvhPX4Ql7ZnUm8YdPD30Qh8=
X-Received: by 2002:a2e:5b9a:: with SMTP id m26mr3392352lje.90.1568842243447;
 Wed, 18 Sep 2019 14:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190909134241.23297-1-ayan.halder@arm.com> <20190917125301.GQ3958@phenom.ffwll.local>
 <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com> <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Wed, 18 Sep 2019 22:30:12 +0100
Message-ID: <CAPj87rOc3MvkjrX1qHpGuVUaGLuZiC7QYBO9v3T2NS+dicLC1g@mail.gmail.com>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected' framebuffer
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Ayan Halder <Ayan.Halder@arm.com>,
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

Hi Liviu,

On Wed, 18 Sep 2019 at 13:04, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> On Wed, Sep 18, 2019 at 09:49:40AM +0100, Daniel Stone wrote:
> > I totally agree. Framebuffers aren't about the underlying memory they
> > point to, but about how to _interpret_ that memory: it decorates a
> > pointer with width, height, stride, format, etc, to allow you to make
> > sense of that memory. I see content protection as being the same as
> > physical contiguity, which is a property of the underlying memory
> > itself. Regardless of the width, height, or format, you just cannot
> > access that memory unless it's under the appropriate ('secure enough')
> > conditions.
> >
> > So I think a dmabuf attribute would be most appropriate, since that's
> > where you have to do all your MMU handling, and everything else you
> > need to do to allow access to that buffer, anyway.
>
> Isn't it how AMD currently implements protected buffers as well?

No idea to be honest, I haven't seen anything upstream.

> > There's a lot of complexity beyond just 'it's protected'; for
> > instance, some CP providers mandate that their content can only be
> > streamed over HDCP 2.2 Type-1 when going through an external
> > connection. One way you could do that is to use a secure world
> > (external controller like Intel's ME, or CPU-internal enclave like SGX
> > or TEE) to examine the display pipe configuration, and only then allow
> > access to the buffers and/or keys. Stuff like that is always going to
> > be out in the realm of vendor & product-policy-specific add-ons, but
> > it should be possible to agree on at least the basic mechanics and
> > expectations of a secure path without things like that.
>
> I also expect that going through the secure world will be pretty much transparent for
> the kernel driver, as the most likely hardware implementations would enable
> additional signaling that will get trapped and handled by the secure OS. I'm not
> trying to simplify things, just taking the stance that it is userspace that is
> coordinating all this, we're trying only to find a common ground on how to handle
> this in the kernel.

Yeah, makes sense.

As a strawman, how about a new flag to drmPrimeHandleToFD() which sets
the 'protected' flag on the resulting dmabuf?

Cheers,
Daniel
