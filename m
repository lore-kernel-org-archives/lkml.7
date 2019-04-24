Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E444C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61D621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="klFIFsvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404087AbfDXRnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:43:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45266 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392155AbfDXRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:43:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id b3so6396157qtc.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 10:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=zfbTRQsKbp3cPp0fyr7ol3SsNAelGq5MLvvnmsx3x/4=;
        b=klFIFsvw9qA9Xpyd/bVg6hoOZgM1GdIV4lVvwz/bO1bIcsHWp0S6Vpnw8WdxTSHW/q
         VRGcmbsCaWI1wRu91TkHm1lnv9qhOA2D8OieA/gndqqE9oO/+12h0bpiwFRuWWgbvTZQ
         SyeIPrFR4ojzYJeJHN5G1useaocfRGMvEwwqleqjCYe+r8+PUcfqeXzwHO5CWcHiuSrF
         W182N51EbDuzVi9N/mR3Uw5/I5yaD3iR4NHKW7G93Idz2Dew6tzex4LvCNKYLWLzmYLZ
         tvmGssu6qCowDrJBYyDLxKRwG1WiuB70sf11eLsGImqCc9pAO+oOK6oU4y5ODMjP9gfe
         rHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=zfbTRQsKbp3cPp0fyr7ol3SsNAelGq5MLvvnmsx3x/4=;
        b=n2U+QTjxP2Pp4BZrq6hZL97lKtt+CId82nlwCi6dH8NxJA6W9TnMOKXRSFHXO5czpe
         x1kISdFY2SXvIvvmOyaO2+d+m+8EO2ORpQ7xw4AZ/ZX68wEgg+6YMmC4ZCalUGivNS+L
         oFR2trWDgovHdshoooMqtutwu6Dr7/5FRImyHWAEqrUJfot4S/nwJyt8vu6NOYQGhlph
         k6ICRZsaZq+h+6eYa81XggbwlZKaGDMdLqniX9vIXHfCF+wXX3TM3b6Df5OgKJxg29JQ
         Qw+exribUDiPFfUf743v7KsNr8RJFZpLF9GcMklsO5aqI1tLAHT6huUuMsja+tIl215x
         erwQ==
X-Gm-Message-State: APjAAAVAbNO9j0+y4/qXZ08K0o7uk8F5yD+QsZLIsPZtbCuWCVd46cVy
        j7uRapSGoFvGn05YpzV86I9m6g==
X-Google-Smtp-Source: APXvYqxNNQa8vFMeQGoGdAeQEJmfpmtAZ0hBnEMzI4BONrrWBviYeXpRR6kJLlczZnbGSJsVO/fasw==
X-Received: by 2002:ac8:2b0d:: with SMTP id 13mr26928010qtu.354.1556127787001;
        Wed, 24 Apr 2019 10:43:07 -0700 (PDT)
Received: from tpx230-nicolas (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id m60sm10195256qte.81.2019.04.24.10.43.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 10:43:05 -0700 (PDT)
Message-ID: <e572f31653301f0a479fe1373b3dfd5ada8e49f3.camel@ndufresne.ca>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Alexandre Courbot <acourbot@chromium.org>,
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
Date:   Wed, 24 Apr 2019 13:43:03 -0400
In-Reply-To: <65a37cec-5040-e2f0-5cd5-c9c3111827ad@daenzer.net>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
         <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
         <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
         <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
         <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net>
         <93c8e6834728b7e5979013df757017d309ee6a89.camel@bootlin.com>
         <CAKMK7uFewmCuc97Qp_2zzk9YvMPmK8zE=a6XGszsLq+SLy-vJA@mail.gmail.com>
         <9230d330e3b57af0643abc834bcf207095cc4bd7.camel@ndufresne.ca>
         <65a37cec-5040-e2f0-5cd5-c9c3111827ad@daenzer.net>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-JnkdroWVrKfeW6KPNz+j"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JnkdroWVrKfeW6KPNz+j
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 24 avril 2019 =C3=A0 18:54 +0200, Michel D=C3=A4nzer a =C3=A9cr=
it :
> On 2019-04-24 5:44 p.m., Nicolas Dufresne wrote:
> > Le mercredi 24 avril 2019 =C3=A0 17:06 +0200, Daniel Vetter a =C3=A9cri=
t :
> > > On Wed, Apr 24, 2019 at 4:41 PM Paul Kocialkowski
> > > <paul.kocialkowski@bootlin.com> wrote:
> > > > On Wed, 2019-04-24 at 16:39 +0200, Michel D=C3=A4nzer wrote:
> > > > > On 2019-04-24 2:01 p.m., Nicolas Dufresne wrote:
> > > > > > Rendering a video stream is more complex then what you describe=
 here.
> > > > > > Whenever there is a unexpected delay (late delivery of a frame =
as an
> > > > > > example) you may endup in situation where one frame is ready af=
ter the
> > > > > > targeted vblank. If there is another frame that targets the fol=
lowing
> > > > > > vblank that gets ready on-time, the previous frame should be re=
placed
> > > > > > by the most recent one.
> > > > > >=20
> > > > > > With fences, what happens is that even if you received the next=
 frame
> > > > > > on time, naively replacing it is not possible, because we don't=
 know
> > > > > > when the fence for the next frame will be signalled. If you sim=
ply
> > > > > > always replace the current frame, you may endup skipping a lot =
more
> > > > > > vblank then what you expect, and that results in jumpy playback=
.
> > > > >=20
> > > > > So you want to be able to replace a queued flip with another one =
then.
> > > > > That doesn't necessarily require allowing more than one flip to b=
e
> > > > > queued ahead of time.
> > > >=20
> > > > There might be other ways to do it, but this one has plenty of
> > > > advantages.
> > >=20
> > > The point of kms (well one of the reasons) was to separate the
> > > implementation of modesetting for specific hw from policy decisions
> > > like which frames to drop and how to schedule them. Kernel gives
> > > tools, userspace implements the actual protocols.
> > >=20
> > > There's definitely a bit a gap around scheduling flips for a specific
> > > frame or allowing to cancel/overwrite an already scheduled flip, but
> > > no one yet has come up with a clear proposal for new uapi + example
> > > implementation + userspace implementation + big enough support from
> > > other compositors that this is what they want too.
>=20
> Actually, the ATOMIC_AMEND patches propose a way to replace a scheduled
> flip?
>=20
>=20
> > > > > Note that this can also be done in userspace with explicit fencin=
g (by
> > > > > only selecting a frame and submitting it to the kernel after all
> > > > > corresponding fences have signalled), at least to some degree, bu=
t the
> > > > > kernel should be able to do it up to a later point in time and mo=
re
> > > > > reliably, with less risk of missing a flip for a frame which beco=
mes
> > > > > ready just in time.
> > > >=20
> > > > Indeed, but it would be great if we could do that with implicit fen=
cing
> > > > as well.
> > >=20
> > > 1. extract implicit fences from dma-buf. This part is just an idea,
> > > but easy to implement once we have someone who actually wants this.
> > > All we need is a new ioctl on the dma-buf to export the fences from
> > > the reservation_object as a sync_file (either the exclusive or the
> > > shared ones, selected with a flag).
> > > 2. do the exact same frame scheduling as with explicit fencing
> > > 3. supply explicit fences in your atomic ioctl calls - these should
> > > overrule any implicit fences (assuming correct kernel drivers, but we
> > > have helpers so you can assume they all work correctly).
> > >=20
> > > By design this is possible, it's just that no one yet bothered enough
> > > to make it happen.
> > > -Daniel
> >=20
> > I'm not sure I understand the workflow of this one. I'm all in favour
> > leaving the hard work to userspace. Note that I have assumed explicit
> > fences from the start, I don't think implicit fence will ever exist in
> > v4l2, but I might be wrong. What I understood is that there was a
> > previous attempt in the past but it raised more issues then it actually
> > solved. So that being said, how do handle exactly the follow use cases:
> >=20
> >  - A frame was lost by capture driver, but it was schedule as being the
> > next buffer to render (normally previous frame should remain).
>=20
> Userspace just doesn't call into the kernel to flip to the lost frame,
> so the previous one remains.

We are stuck in a loop you a me. Considering v4l2 to drm, where fences
don't exist on v4l2, it makes very little sense to bring up fences if
we are to wait on the fence in userspace. Unless of course you have
other operations before end making a proper use of the fences.

>=20
> >  - The scheduled frame is late for the next vblank (didn't signal on-
> > time), a new one may be better for the next vlbank, but we will only
> > know when it's fence is signaled.
>=20
> Userspace only selects a frame and submits it to the kernel after all
> its fences have signalled.
>=20
> > Better in this context means the the presentation time of this frame is
> > closer to the next vblank time. Keep in mind that the idea is to
> > schedule the frames before they are signal, in order to make the usage
> > of the fence useful in lowering the latency.
>=20
> Fences are about signalling completion, not about low latency.

It can be used to remove a roundtrip with userspace at a very time
sensitive moment. If you pass a dmabuf with it's unsignalled fence to a
kernel driver, the driver can start the job on this dmabuf as soon as
the fence is signalled. If you always wait on a fence in userspace, you
have to wait for the userspace process to be scheduled, then userspace
will setup the drm atomic request or similar action, which may take
some time and may require another process in the kernel to have to be
schedule. This effectively adds some variable delay, a gap where
nothing is happening between two operations. This time is lost and
contributes to the overall operation latency.

The benefit of fences we are looking for is being able to setup before
the fence is signalled the operations on various compatible drivers.
This way, on the time critical moment a driver can be feed more jobs,
there is no userspace rountrip involved. It is also proposed to use it
to return the buffers into v4l2 queued when they are freed, which can
in some conditions avoid let's say a capture driver from skipping due
to random scheduling delays.

>=20
> With a display server, the client can send frames to the display server
> ahead of time, only the display server needs to wait for fences to
> signal before submitting frames to the kernel.
>=20
>=20
> > Of course as Michel said, we could just always wait on the fence and
> > just schedule. But if you do that, why would you care implementing the
> > fence in v4l2 to start with, DQBuf does just that already.
>=20
> A fence is more likely to work out of the box with non-V4L-related code
> than DQBuf?

If you use DQBuf, you are guarantied that the data has been produced. A
fence is not useful on a buffer that already contains the data you
would be waiting for. That's why the fence is provided in the RFC at
QBUf, basically when the  free buffer is given to the v4l2 driver. QBuf
can also be passed a fence in the RFC, so if the buffer is not yet
free, the driver would wait on the fence before using it.

>=20
>=20

--=-JnkdroWVrKfeW6KPNz+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXMCgJwAKCRBxUwItrAao
HAJZAJ9sU6RxIoHvjLuu4tuWKVaxkgCLwACfa4OY20ZlCH6p+DFFhBnzAAlst10=
=z/xV
-----END PGP SIGNATURE-----

--=-JnkdroWVrKfeW6KPNz+j--

