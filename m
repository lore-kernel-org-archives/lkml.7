Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A34C282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4832321903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="lNnN1uB+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbfDXPok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:44:40 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42143 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfDXPoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:44:39 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so20796596qtc.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=v4lmI9BpsOq8jxFcDyrVrojTZF/NRn/VtZwJvYEqNIE=;
        b=lNnN1uB+gvO37ELFzEH4Wcy4LelfMzGdo9LAqsBdIZmjuTYy/Nz3QzrXdOj0Foqh1G
         i65XUtVoBEWe4tpSLJJjgsdaOa8XTYn10JlrYYPskcQSQ3hnVnylPCEYAV1iLDI4Z1He
         cVaB7OLYXw7EryXSW7DfLZ5DE+ZA1X+Z80IUlC47pCRc1pB7raB05YNK73yXIcQzthlo
         ovvWjjO/JlKU3YMt1v9Qxg91RvlD1x5iRheGmH+27lj5LwY83zmDCDlj1zA0weyjfUes
         ax7bEii+egxsSLoUXg/72/cMjwJ3bC7IP9GqaHL1ijy9w66x1nsEycciFhCo5rGLbXRy
         SQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=v4lmI9BpsOq8jxFcDyrVrojTZF/NRn/VtZwJvYEqNIE=;
        b=qKhFGzHgMVpQwWdprlzwjcY/PvPxguyVf/moLMX9JzeizptHqc8Mh2GKAb+Hrf6hx4
         XwEfl6Jhlh/hgo18eiT8KFRsduIIsFXWkVs4WrfuMTLohBtqaKq9zKOOrAaZlOghA89g
         gOgrEwV8Flaowu6BL23T6qSnvBcJXPIJou5mZFYA/owSyxXisCS7JssLUEKtS/ukg+YS
         H8wLsCELquL9T99brEEPW/oKJ9KVMly5tHbnP8zmBA/lhxaCPTEPIyWXjhoS2e3PFwx3
         UqZaDKP/5fdLhS5tOyHbpYw0seICNsY9CsQ0jxzKg12c720AOD90jhgkRv3Gp3b2uy0T
         7pjA==
X-Gm-Message-State: APjAAAV+PxcAWOR7MBgeplovmvX+k2TT2IfjgPrOnLYGiFuWfrP9X7zt
        hY/hnbBxA7L0mGtyZsMk1FPhSw==
X-Google-Smtp-Source: APXvYqwipzN1Zgm0y2YGlXuau0XFcGrKSTGYGCxWaP11wC24L0xy3I+CPWQ83lgHBSXkooYLaJFuIA==
X-Received: by 2002:ac8:2f4f:: with SMTP id k15mr15586729qta.175.1556120677969;
        Wed, 24 Apr 2019 08:44:37 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id q5sm8178480qtb.44.2019.04.24.08.44.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 08:44:36 -0700 (PDT)
Message-ID: <9230d330e3b57af0643abc834bcf207095cc4bd7.camel@ndufresne.ca>
Subject: Re: Support for 2D engines/blitters in V4L2 and DRM
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
        Alexandre Courbot <acourbot@chromium.org>,
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
Date:   Wed, 24 Apr 2019 11:44:35 -0400
In-Reply-To: <CAKMK7uFewmCuc97Qp_2zzk9YvMPmK8zE=a6XGszsLq+SLy-vJA@mail.gmail.com>
References: <0df3d4b5178d8a37b67b275e0771741c6c268de3.camel@bootlin.com>
         <20190418081816.GO13337@phenom.ffwll.local>
         <8265f098722d0cd5aae606d7ee6d955f168ac8f3.camel@ndufresne.ca>
         <987372acff18f4c66191ee52fa69dc2917e4a605.camel@bootlin.com>
         <1d6fb659-0516-41db-257b-258e6116a4f2@daenzer.net>
         <7479b8df108c66b1711eb89efbfeb4a16480533d.camel@ndufresne.ca>
         <8e091392-2365-6c52-1fc2-84ebdc9e83fe@daenzer.net>
         <93c8e6834728b7e5979013df757017d309ee6a89.camel@bootlin.com>
         <CAKMK7uFewmCuc97Qp_2zzk9YvMPmK8zE=a6XGszsLq+SLy-vJA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-rswwm2M4CP88FFHBwCK/"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rswwm2M4CP88FFHBwCK/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 24 avril 2019 =C3=A0 17:06 +0200, Daniel Vetter a =C3=A9crit :
> On Wed, Apr 24, 2019 at 4:41 PM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > Hi,
> >=20
> > On Wed, 2019-04-24 at 16:39 +0200, Michel D=C3=A4nzer wrote:
> > > On 2019-04-24 2:01 p.m., Nicolas Dufresne wrote:
> > > > Le mercredi 24 avril 2019 =C3=A0 10:31 +0200, Michel D=C3=A4nzer a =
=C3=A9crit :
> > > > > On 2019-04-19 10:38 a.m., Paul Kocialkowski wrote:
> > > > > > On Thu, 2019-04-18 at 20:30 -0400, Nicolas Dufresne wrote:
> > > > > > > Le jeudi 18 avril 2019 =C3=A0 10:18 +0200, Daniel Vetter a =
=C3=A9crit :
> > > > > > > In the first, we'd need a mechanism where we can schedule a r=
ender at a
> > > > > > > specific time or vblank. We can of course already implement t=
his in
> > > > > > > software, but with fences, the scheduling would need to be do=
ne in the
> > > > > > > driver. Then if the fence is signalled earlier, the driver sh=
ould hold
> > > > > > > on until the delay is met. If the fence got signalled late, w=
e also
> > > > > > > need to think of a workflow. As we can't schedule more then o=
ne render
> > > > > > > in DRM at one time, I don't really see yet how to make that w=
ork.
> > > > > >=20
> > > > > > Indeed, that's also one of the main issues I've spotted. Before=
 using
> > > > > > an implicit fence, we basically have to make sure the frame is =
due for
> > > > > > display at the next vblank. Otherwise, we need to refrain from =
using
> > > > > > the fence and schedule the flip later, which is kind of counter=
-
> > > > > > productive.
> > > > >=20
> > > > > Fences are about signalling that the contents of a frame are "don=
e" and
> > > > > ready to be presented. They're not about specifying which frame i=
s to be
> > > > > presented when.
> > > > >=20
> > > > >=20
> > > > > > I feel like specifying a target vblank would be a good unit for=
 that,
> > > > >=20
> > > > > The mechanism described above works for that.
> > > > >=20
> > > > > > since it's our native granularity after all (while a timestamp =
is not).
> > > > >=20
> > > > > Note that variable refresh rate (Adaptive Sync / FreeSync / G-Syn=
c)
> > > > > changes things in this regard. It makes the vblank length variabl=
e, and
> > > > > if you wait for multiple vblanks between flips, you get the maxim=
um
> > > > > vblank length corresponding to the minimum refresh rate / timing
> > > > > granularity. Thus, it would be useful to allow userspace to speci=
fy a
> > > > > timestamp corresponding to the earliest time when the flip is to
> > > > > complete. The kernel could then try to hit that as closely as pos=
sible.
> > > >=20
> > > > Rendering a video stream is more complex then what you describe her=
e.
> > > > Whenever there is a unexpected delay (late delivery of a frame as a=
n
> > > > example) you may endup in situation where one frame is ready after =
the
> > > > targeted vblank. If there is another frame that targets the followi=
ng
> > > > vblank that gets ready on-time, the previous frame should be replac=
ed
> > > > by the most recent one.
> > > >=20
> > > > With fences, what happens is that even if you received the next fra=
me
> > > > on time, naively replacing it is not possible, because we don't kno=
w
> > > > when the fence for the next frame will be signalled. If you simply
> > > > always replace the current frame, you may endup skipping a lot more
> > > > vblank then what you expect, and that results in jumpy playback.
> > >=20
> > > So you want to be able to replace a queued flip with another one then=
.
> > > That doesn't necessarily require allowing more than one flip to be
> > > queued ahead of time.
> >=20
> > There might be other ways to do it, but this one has plenty of
> > advantages.
>=20
> The point of kms (well one of the reasons) was to separate the
> implementation of modesetting for specific hw from policy decisions
> like which frames to drop and how to schedule them. Kernel gives
> tools, userspace implements the actual protocols.
>=20
> There's definitely a bit a gap around scheduling flips for a specific
> frame or allowing to cancel/overwrite an already scheduled flip, but
> no one yet has come up with a clear proposal for new uapi + example
> implementation + userspace implementation + big enough support from
> other compositors that this is what they want too.
>=20
> And yes writing a really good compositor is really hard, and I think a
> lot of people underestimate that and just create something useful for
> their niche. If userspace can't come up with a shared library of
> helpers, I don't think baking it in as kernel uapi with 10+ years
> regression free api guarantees is going to make it any better.
>=20
> > > Note that this can also be done in userspace with explicit fencing (b=
y
> > > only selecting a frame and submitting it to the kernel after all
> > > corresponding fences have signalled), at least to some degree, but th=
e
> > > kernel should be able to do it up to a later point in time and more
> > > reliably, with less risk of missing a flip for a frame which becomes
> > > ready just in time.
> >=20
> > Indeed, but it would be great if we could do that with implicit fencing
> > as well.
>=20
> 1. extract implicit fences from dma-buf. This part is just an idea,
> but easy to implement once we have someone who actually wants this.
> All we need is a new ioctl on the dma-buf to export the fences from
> the reservation_object as a sync_file (either the exclusive or the
> shared ones, selected with a flag).
> 2. do the exact same frame scheduling as with explicit fencing
> 3. supply explicit fences in your atomic ioctl calls - these should
> overrule any implicit fences (assuming correct kernel drivers, but we
> have helpers so you can assume they all work correctly).
>=20
> By design this is possible, it's just that no one yet bothered enough
> to make it happen.
> -Daniel

I'm not sure I understand the workflow of this one. I'm all in favour
leaving the hard work to userspace. Note that I have assumed explicit
fences from the start, I don't think implicit fence will ever exist in
v4l2, but I might be wrong. What I understood is that there was a
previous attempt in the past but it raised more issues then it actually
solved. So that being said, how do handle exactly the follow use cases:

 - A frame was lost by capture driver, but it was schedule as being the
next buffer to render (normally previous frame should remain).
 - The scheduled frame is late for the next vblank (didn't signal on-
time), a new one may be better for the next vlbank, but we will only
know when it's fence is signaled.

Better in this context means the the presentation time of this frame is
closer to the next vblank time. Keep in mind that the idea is to
schedule the frames before they are signal, in order to make the usage
of the fence useful in lowering the latency. Of course as Michel said,
we could just always wait on the fence and just schedule. But if you do
that, why would you care implementing the fence in v4l2 to start with,
DQBuf does just that already.

Note that this has nothing to do with the valid use case where you
would want to apply various transformations (m2m or gpu) on the capture
buffer. You still gain from the fence in the context, even if you wait
in userspace on the fence before display. This alone is likely enough
to justify using fences.

>=20
> > > > Render queues with timestamp are used to smooth rendering and handl=
e
> > > > rendering collision so that the latency is kept low (like when you =
have
> > > > a 100fps video over a 60Hz display). This is normally done in
> > > > userspace, but with fences, you ask the kernel to render something =
in
> > > > an unpredictable future, so we loose the ability to make the final
> > > > decision.
> > >=20
> > > That's just not what fences are intended to be used for with the curr=
ent
> > > KMS UAPI.
> >=20
> > Yes, and I think we're discussing towards changing that in the future.
> >=20
> > Cheers,
> >=20
> > Paul
> >=20
> > --
> > Paul Kocialkowski, Bootlin
> > Embedded Linux and kernel engineering
> > https://bootlin.com
> >=20
>=20
>=20

--=-rswwm2M4CP88FFHBwCK/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXMCEYwAKCRBxUwItrAao
HOgFAKC7ITSvXoTnFJA/5lSINBPZIw+szwCghDSkaZbuPzg10c0uJIRKIreIxnQ=
=rq/c
-----END PGP SIGNATURE-----

--=-rswwm2M4CP88FFHBwCK/--

