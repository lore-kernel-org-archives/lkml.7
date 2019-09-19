Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFAFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46F8208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybf0EBYz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391487AbfISPw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:52:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32998 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390134AbfISPwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:52:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so3686101wrs.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 08:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KCBONnzAj2P1FeBCjOa8T27bKR2GCZCpnRd6VXUiLow=;
        b=Ybf0EBYzh5yEpSNKV9dt6yVkCaWB+wjq0KiSILHPHS5UaXbWhL+u5SP9VcOZ9zu6YH
         E1JOWK41R/j3U48RznyEj1CWbHBwjPzeJHhQmo5ZD0PR9LJEA/6+9ABEeqZUMsDqDHYF
         eVgiiSFiPYa7hxi1tabcsjCYVi+BVlX/ig/1cd9avRyH4IPBdK8uHGK4yollQgGifGyj
         HBLiw3XZi1MICso9mS9qLsdSVDRqA5njBEkBBRHadYqd0qInlVCejqzPWOAOy4eft2Vh
         p40Xwh8IU6W7hY1i3efVorSw1WrZnFRdJpDnehrC3LoMctTwMYiUp5EXYv01oQQufxX1
         oOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KCBONnzAj2P1FeBCjOa8T27bKR2GCZCpnRd6VXUiLow=;
        b=IK9eco0F+As4wDR9EVWtYW5cg4ihwQfcKn2ELxoN+ZxAIeG5UwjkdT/GZ/L9FrLwrf
         7opF99XE7/6wdeqwxqGest9Aru02U4IShcYZSxSZ6nB8ynJdS2+g8QTgndN9EwU4375a
         PA3OgHUL3qZcHpSh7W1XCHqAP7HBK47aQ8mqX/AoANUEcKCZUQDQ5p1PoE9wkh8QVIRr
         ektwtg6tODI1ekV1BgmOO6LHRiTsG6eqchg+c95wddX+HKBLujoGqU1NlCmgA0lnK3A9
         aQurGVRPHwF1LlARqx3AjUdLHFzpewD2IsQUwAz7PNJr7ipw5L414iy7OhwNBUgn5l8R
         VGJQ==
X-Gm-Message-State: APjAAAVV5COzuxBCDoutKc2PpgItzrMog7nb+wDRLxNNOht6IZj7dNtb
        K0Gi/aNh5gqVZhlF4WJqwJpuPdtLBQ4oOSXIzAmvijUH
X-Google-Smtp-Source: APXvYqzRGfDf3Kn2UEF5Pb9pYpZfcshYZmYXZiVolqnsZPYfmDxI5+XLHR2QQLZUuDQAxauboToyV/58ZGb2Fc9GRZY=
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr7645742wrg.74.1568908341909;
 Thu, 19 Sep 2019 08:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190909134241.23297-1-ayan.halder@arm.com> <20190917125301.GQ3958@phenom.ffwll.local>
 <CAPj87rPKp1ogZhk_fMrsX885zkAh1PB4usNQUd4KxNFUv4vsFw@mail.gmail.com> <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
In-Reply-To: <20190918120406.2ylkxx2rqsbhn2te@e110455-lin.cambridge.arm.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 19 Sep 2019 11:52:09 -0400
Message-ID: <CADnq5_Ot5dMjxAkyxpjtJJy3=cmA0FDzYQPrJmxkfd0wsggi7A@mail.gmail.com>
Subject: Re: [RFC PATCH] drm:- Add a modifier to denote 'protected' framebuffer
To:     Liviu Dudau <Liviu.Dudau@arm.com>
Cc:     Daniel Stone <daniel@fooishbar.org>, nd <nd@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "sean@poorly.run" <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 8:04 AM Liviu Dudau <Liviu.Dudau@arm.com> wrote:
>
> On Wed, Sep 18, 2019 at 09:49:40AM +0100, Daniel Stone wrote:
> > Hi all,
>
> Hi,
>
> >
> > On Tue, 17 Sep 2019 at 13:53, Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Mon, Sep 09, 2019 at 01:42:53PM +0000, Ayan Halder wrote:
> > > > Let us ignore how the protected system memory is allocated and for =
the scope of
> > > > this discussion, we want to figure out the best way possible for th=
e userspace
> > > > to communicate to the drm driver to turn the protected mode on (for=
 accessing the
> > > > framebuffer with the DRM content) or off.
> > > >
> > > > The possible ways by which the userspace could achieve this is via:=
-
> > > >
> > > > 1. Modifiers :- This looks to me the best way by which the userspac=
e can
> > > > communicate to the kernel to turn the protected mode on for the kom=
eda driver
> > > > as it is going to access one of the protected framebuffers. The onl=
y problem is
> > > > that the current modifiers describe the tiling/compression format. =
However, it
> > > > does not hurt to extend the meaning of modifiers to denote other at=
tributes of
> > > > the framebuffer as well.
> > > >
> > > > The other reason is that on Android, we get an info from Gralloc
> > > > (GRALLOC_USAGE_PROTECTED) which tells us that the buffer is protect=
ed. This can
> > > > be used to set up the modifier/s (AddFB2) during framebuffer creati=
on.
> > >
> > > How does this mesh with other modifiers, like AFBC? That's where I se=
e the
> > > issue here.
> >
> > Yeah. On other SoCs, we certainly have usecases for protected content
> > with different buffer layouts. The i.MX8M can protect particular
> > memory areas and partition them to protect access from particular
> > devices (e.g. display controller and video decoder only, not CPU or
> > GPU). Those memory areas can contain linear buffers, or tiled buffers,
> > or supertiled buffers, or ...
> >
> > Stealing a modifier isn't appropriate.
>
> I tend to agree with you here. Given that the modifiers were introduced m=
ostly to
> help vendors add their ideosyncratic bits, having a generic flag as a mod=
ifier is
> not a good idea.
>
> >
> > > 6. Just track this as part of buffer allocation, i.e. I think it does
> > > matter how you allocate these protected buffers. We could add a "is
> > > protected buffer" flag at the dma_buf level for this.
> >
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

Our buffer security is implemented as part of our GPU's virtual memory
interface.  Our current proposed API is the set a "secure" flag when
memory is allocated and then when a process maps the buffer into its
GPU virtual address space, we set the appropriate flags in the PTEs.
See this series for more info:
https://patchwork.freedesktop.org/series/66531/
You can have the buffers in whatever tiled or linear format makes
sense.  The encryption happens on top of that.  In order for the
various blocks on the GPU to be able to access the encrypted memory,
they need to be switched into "secure" mode.  So for example, if you
submit work to the GPU that included secure memory, you need to flag
that work as secure.  I don't think our solution is really shareable
outside of our asics so in our case, we don't really have to worry
about passing secure buffers between drivers.

Alex

>
> >
> > > So yeah for this stuff here I think we do want the full userspace sid=
e,
> > > from allocator to rendering something into this protected buffers (no=
 need
> > > to also have the entire "decode a protected bitstream part" imo, sinc=
e
> > > that will freak people out). Unfortunately, in my experience, that ki=
lls
> > > it for upstream :-/ But also in my experience of looking into this fo=
r
> > > other gpu's, we really need to have the full picture here to make sur=
e
> > > we're not screwing this up.
> >
> > Yeah. I know there are a few people looking at this at the moment, so
> > hopefully we are able to get something up and out in the open as a
> > strawman.
> >
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
> I also expect that going through the secure world will be pretty much tra=
nsparent for
> the kernel driver, as the most likely hardware implementations would enab=
le
> additional signaling that will get trapped and handled by the secure OS. =
I'm not
> trying to simplify things, just taking the stance that it is userspace th=
at is
> coordinating all this, we're trying only to find a common ground on how t=
o handle
> this in the kernel.
>
> Best regards,
> Liviu
>
> >
> > Cheers,
> > Daniel
>
> --
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     =C2=AF\_(=E3=83=84)_/=C2=AF
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
