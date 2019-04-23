Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94098C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54734218B0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 19:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="YNTNPh72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfDWTGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:06:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46701 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDWTGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 15:06:42 -0400
Received: by mail-io1-f65.google.com with SMTP id p23so13520003iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Z2y+uYEhqN22M1voM0BlEILZBoDj6UOl5pk9ehdpfw=;
        b=YNTNPh72HFnOfKxN/Tmbd/N/Gyo4M/7ncCJiR98fzsAGCyfMwsrqYz7cdaFfVyZPV2
         lAXhohg4AH/yycokPhyak5jBlLRQW6xyp1DA8E2iIweKk68Lk+rV8A+KS9ALe4QfVogN
         QlmxPRGIOzDPWrLZcdEH9RqhKu0IbTLn9bImM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Z2y+uYEhqN22M1voM0BlEILZBoDj6UOl5pk9ehdpfw=;
        b=GPX5QQSgmHRZc79k+AvYfZtFte71CA2oWKzf8mj7+ag0l7D6mjyihRmbIWvoruOC+H
         TOsO62CxnIR2+QDk6qq1nORlyu78+vPRaLiEig2VYPRBLPwzpd5HoBmz66Lm7JgXhqbZ
         YDlBEICmhU+VvEI6obUbwQaJWf3A0a5zsXBtyVgki6N0Wekln1HTpwA7Rn8/mmx5aHso
         3kR2aWvR9nfxWBvjT8ZP25OzOm4SGSqhr3EYz5xQGR7Hng5BkVC+qr7+uFjt3pFfJapm
         Mw9cRy0FC/AWxsBLtjpuJ4ndwOA8FLyfwpRM0kmYZLToLKu9tyJZLVkIfjeZHlUWJfSZ
         BFkA==
X-Gm-Message-State: APjAAAU5nkeoxYD9ZOga6wVfGRaFFgORYXwQocBzUDWfZlO7v1lwY9Ty
        5TkQ1SBcHFAXb+iNPBlwmOIxP/igvN9T14OH9GUgRg==
X-Google-Smtp-Source: APXvYqzgTaD5qUTyk697HnDfCYdr0sJ8aR3gNVm81hvsuuHBtbSah8kUxG44zIgpF+ewTz2c+U9p/jHbRqZfv2LiJoY=
X-Received: by 2002:a5d:818f:: with SMTP id u15mr8138048ion.291.1556046401292;
 Tue, 23 Apr 2019 12:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local> <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea> <6578c22ddf5420d4dead69d29f451bc6a91f6c4a.camel@bootlin.com>
 <20190420224045.GY4964@pendragon.ideasonboard.com> <20190423073026.GX13337@phenom.ffwll.local>
 <f288e1d29277fcd79b251d99f84fb9b165364fac.camel@bootlin.com>
 <e29914080f1db7b331e6e1b12dc9c7c48d5d7185.camel@ndufresne.ca>
 <CAKMK7uG=Mgn11nvNZWEBHhW3wQa57Vup+tjXE4Umyb8CHSTr2g@mail.gmail.com> <f3e58f3b48c90b83143888c95acf8a886298da8c.camel@ndufresne.ca>
In-Reply-To: <f3e58f3b48c90b83143888c95acf8a886298da8c.camel@ndufresne.ca>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 23 Apr 2019 21:06:28 +0200
Message-ID: <CAKMK7uHiZAiHKgnuQieRuc7KcZqCchd9AqNRde7CHvaty+_T9g@mail.gmail.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 7:17 PM Nicolas Dufresne <nicolas@ndufresne.ca> wro=
te:
>
> Le mardi 23 avril 2019 =C3=A0 17:09 +0200, Daniel Vetter a =C3=A9crit :
> > On Tue, Apr 23, 2019 at 4:28 PM Nicolas Dufresne <nicolas@ndufresne.ca>=
 wrote:
> > > Le mardi 23 avril 2019 =C3=A0 14:33 +0200, Paul Kocialkowski a =C3=A9=
crit :
> > > > Hi,
> > > >
> > > > On Tue, 2019-04-23 at 09:30 +0200, Daniel Vetter wrote:
> > > > > On Sun, Apr 21, 2019 at 01:40:45AM +0300, Laurent Pinchart wrote:
> > > > > > Hi Paul,
> > > > > >
> > > > > > On Thu, Apr 18, 2019 at 01:49:54PM +0200, Paul Kocialkowski wro=
te:
> > > > > > > On Thu, 2019-04-18 at 11:02 +0200, Maxime Ripard wrote:
> > > > > > > > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wro=
te:
> > > > > > > > > And a lot of people pushed for the "fourcc is a standard"=
, when
> > > > > > > > > really it's totally not.
> > > > > > > >
> > > > > > > > Even if it's not a standard, having consistency would be a =
good thing.
> > > > > > > >
> > > > > > > > And you said yourself that DRM fourcc is now pretty much an=
 authority
> > > > > > > > for the fourcc, so it definitely looks like a standard to m=
e.
> > > > > > >
> > > > > > > I think trying to make the V4L2 and DRM fourccs converge is a=
 lost
> > > > > > > cause, as it has already significantly diverged. Even if we c=
oordinate
> > > > > > > an effort to introduce new formats with the same fourcc on bo=
th sides,
> > > > > > > I don't see what good that would be since the formats we have=
 now are
> > > > > > > still plagued by the inconsistency.
> > > > > > >
> > > > > > > I think we always need an explicit translation step from eith=
er v4l2 or
> > > > > > > drm to the internal representation and back, without ever ass=
uming that
> > > > > > > formats might be compatible because they share the same fourc=
c.
> > > > > >
> > > > > > I don't agree. APIs evolve, and while we can't switch from one =
set of
> > > > > > 4CCs to another in existing APIs, we could in new APIs. Boris i=
s working
> > > > > > on new ioctls to handle formats in V4L2, and while 4CC unificat=
ion could
> > > > > > be impopular from a userspace developers point of view there, I=
 don't
> > > > > > think we have ruled it out completely. The move to the request =
API is
> > > > > > also an area where a common set of 4CCs could be used, as it wi=
ll depart
> > > > > > from the existing V4L2 ioctls. To summarize my opinion, we're n=
ot there
> > > > > > yet, but I wouldn't rule it out completely for the future.
> > > > > >
> > > > > > > It looks like so far, V4L2 pixel formats describe a DRM pixel=
 format +
> > > > > > > modifier.
> > > > > >
> > > > > > DRM modifiers are mostly about tiling and compression, and we h=
ardly
> > > > > > support these in V4L2. What are the modifiers you think are har=
dcoded in
> > > > > > 4CCs in V4L2 ?
> > > > >
> > > > > Hm maybe it was a drm one that didn't come from v4l or anywhere e=
lse
> > > > > really, but the NV12MT one is nv12 + some tiling. I think we mana=
ged to
> > > > > uapi-bend that one into shape in at least drm.
> > > >
> > > > The one I had in mind is V4L2_PIX_FMT_SUNXI_TILED_NV12 which transl=
ates
> > > > to DRM_FORMAT_NV12 + DRM_FORMAT_MOD_ALLWINNER_TILED. Seems to be a
> > > > pretty similar case to the Mediatek one indeed.
> > > >
> > > > In our cause, that's because the video decoding engine produces its
> > > > destination buffers in a specific tiled format, that the display en=
gine
> > > > can take in directly.
> > >
> > > We also have the Samsung tiling (Z pattern) as mentioned here, but al=
so
> > > linear 16x16 tile placement (also from Samsung ?) and I believe Amlog=
ic
> > > CODEC patches is bringing another tiling (unavoidable on older Meson8=
,
> > > with 64bytes swaps). All these should be expressed as NV12 + mod in D=
RM
> > > space.
> > >
> > > What is very often not enabled, but affect the performance on mainlin=
e
> > > media drivers is the ARM frame buffer compression. I know that RK chi=
ps
> > > have support for this, and that you can't achieve the maximum
> > > throughput without that. This one is not documented anywhere, but I
> > > understand that there is multiple variants that HW vendor licence.
> > > Though, in general, each SoC are likely running a single variant, so =
a
> > > single mod would make sense.
> >
> > We have AFBC modifiers now in drm_fourcc.h, jointly developed by
> > display engineers from ARM and mali gpu reverse engineer people doing
> > the panfrost driver. So should be covered.
> >
> > > So all this to say that V4L2 equally needs supports for these. What I
> > > understood through DRM API is that a buffer allocated for let's say
> > > NV12 + mod, is compatible with linear NV12. That could be used to
> > > simplify some code, but at the same time, a common API that deals wit=
h
> > > the padding and alignment of each format + mod independently would do
> > > that same as long as this is not variable depending on which target H=
W
> > > uses that same format.
> >
> > Not sure why you mean with NV12 + mod is compatible with linear NV12.
> > In general fourcc + modifier !=3D fourcc =3D linear modifier, size, num=
ber
> > of planes, alignment constraints and everything else can be changed by
> > a modifier (and there's examples for all of these, maybe not yet in
> > all cases for NV12, but I think NV12 + AFBC modifiers gives some
> > pretty interesting results). In generally you need to think of the
> > (drm fourcc, modifier) as the pair identified the pixel format, each
> > part individually is fairly meanigless. We have lots of modifiers
> > where the exact tiling mode/layout changes depending upon the fourcc
> > code.
>
> I only meant that the NV12 + mod have the same number of planes, and
> should be large enough to store a linear NV12 equivalent. Not that it
> would render correctly (even though I found it useful to be able to
> render them when I needed to reverse it).

It might be this assumption still holds for nv12, but we've definitely
broken it for other fourcc. You can't rely on this at least being
universally true.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
