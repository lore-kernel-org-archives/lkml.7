Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EAEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AFD21850
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="gvSsVvnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbfDRMc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:32:28 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39404 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730682AbfDRMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:32:28 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so3015101ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 05:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zshW0dUbKjJ2zIxfJKOkO/9InjE9tXwJ9YRIbJrCh3Y=;
        b=gvSsVvnt1PKF/tgwP52MnSQqp8Ug3E+bZv/HZUAmBivGtMdczuRfCjnoO0D0l/kh2K
         yLOCHNbCt5a0ivW1gfpSvcVov8/ChGxPQlLcKLcHv51BTK7MexZIpdJipQTTMQbZB2cZ
         PwxjTfDUKSvLusKzwAQf7buCelYLKFe3uopcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zshW0dUbKjJ2zIxfJKOkO/9InjE9tXwJ9YRIbJrCh3Y=;
        b=jtdkfjIC3rnX7XAUKso3eW7qnkoLyU8rC/N38w024S+D+9CWk1cbKhNy0c3CgVfUdI
         zIJjwpqubVHgRIoGKOEYn4oQ/OAuTd7TpwF6rBrZJjubRUIgCby/le9H3axw45XMSJKV
         0lIS8ndOOUIdxHzggA0QyiCjjFFRXPcP/2u+88EMZ0fpHlyp7AMWEX9TsM+f29S6hL47
         b6wrl/VvY+5XeRFASNvl26HgXguqzeAeBAa88gyusq6Vs3YGHn6v9vWo3e9SzLqVSWJt
         l5aND7diRPHLk5t8EH3/YO7M2I0+tZv+wbTHdj0uRDk5GIljUpwFClGn2pXKytoOXEOp
         qCQA==
X-Gm-Message-State: APjAAAXFaYLYvRmkkHU0pS0PQpPcFxDFu+X+aFUevndKYIaer6fL+WCN
        0ORUwvdUx+DRIytnU+f2qk1yfWCy9sU15R8XPybaCg==
X-Google-Smtp-Source: APXvYqwQG0e72GfT8UTy/R5z87txhehsIwFGIy8AWQUiSDJ6p95RQiG2/GEqk9MXvBAm6LSEnIwy/fvLLgBIOhuCicg=
X-Received: by 2002:a02:c4cf:: with SMTP id h15mr1807374jaj.96.1555590746951;
 Thu, 18 Apr 2019 05:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local> <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea> <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
 <20190418120143.4x7bvhgkh23mgsup@flea>
In-Reply-To: <20190418120143.4x7bvhgkh23mgsup@flea>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 18 Apr 2019 14:32:14 +0200
Message-ID: <CAKMK7uFRptrYGScX-Ogxhanw6=6Q9Mf22axpafwceMybfYjBKQ@mail.gmail.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:01 PM Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
> On Thu, Apr 18, 2019 at 12:07:44PM +0200, Daniel Vetter wrote:
> > On Thu, Apr 18, 2019 at 11:02 AM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > > > On Thu, Apr 18, 2019 at 8:22 AM Maxime Ripard <maxime.ripard@bootli=
n.com> wrote:
> > > > > On Wed, Apr 17, 2019 at 05:41:21PM +0200, Daniel Vetter wrote:
> > > > > > On Wed, Apr 17, 2019 at 09:54:26AM +0200, Maxime Ripard wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > DRM comes with an extensive format support to retrieve the va=
rious
> > > > > > > parameters associated with a given format (such as the subsam=
pling, or the
> > > > > > > bits per pixel), as well as some helpers and utilities to eas=
e the driver
> > > > > > > development.
> > > > > > >
> > > > > > > v4l2, on the other side, doesn't provide such facilities, lea=
ving each
> > > > > > > driver reimplement a subset of the formats parameters for the=
 one supported
> > > > > > > by that particular driver. This leads to a lot of duplication=
 and
> > > > > > > boilerplate code in the v4l2 drivers.
> > > > > > >
> > > > > > > This series tries to address this by moving the DRM format AP=
I into lib and
> > > > > > > turning it into a more generic API. In order to do this, we'v=
e needed to do
> > > > > > > some preliminary changes on the DRM drivers, then moved the A=
PI and finally
> > > > > > > converted a v4l2 driver to give an example of how such librar=
y could be
> > > > > > > used.
> > > > > > >
> > > > > > > Let me know what you think,
> > > > > > > Maxime
> > > > > > >
> > > > > > > Changes from RFC:
> > > > > > >   - Rebased on next
> > > > > > >   - Fixed the various formats mapping
> > > > > > >   - Added tags
> > > > > > >   - Did most of the formats functions as inline functions
> > > > > > >   - Used a consistent prefix for all the utilities functions
> > > > > > >   - Fixed the compilation breakages, and did a run of allmodc=
onfig for arm,
> > > > > > >     arm64 and x86_64
> > > > > > >   - Fixed out of array bounds warnings in the image_format_in=
fo_block_*
> > > > > > >     functions
> > > > > > >   - Added License and copyright headers on missing files
> > > > > > >
> > > > > > > Maxime Ripard (20):
> > > > > > >   drm: Remove users of drm_format_num_planes
> > > > > > >   drm: Remove users of drm_format_(horz|vert)_chroma_subsampl=
ing
> > > > > > >   drm/fourcc: Pass the format_info pointer to drm_format_plan=
e_cpp
> > > > > > >   drm/fourcc: Pass the format_info pointer to drm_format_plan=
e_width/height
> > > > > > >   drm: Replace instances of drm_format_info by drm_get_format=
_info
> > > > > > >   lib: Add video format information library
> > > > > > >   drm/fb: Move from drm_format_info to image_format_info
> > > > > > >   drm/malidp: Convert to generic image format library
> > > > > > >   drm/client: Convert to generic image format library
> > > > > > >   drm/exynos: Convert to generic image format library
> > > > > > >   drm/i915: Convert to generic image format library
> > > > > > >   drm/ipuv3: Convert to generic image format library
> > > > > > >   drm/msm: Convert to generic image format library
> > > > > > >   drm/omap: Convert to generic image format library
> > > > > > >   drm/rockchip: Convert to generic image format library
> > > > > > >   drm/tegra: Convert to generic image format library
> > > > > > >   drm/fourcc: Remove old DRM format API
> > > > > > >   lib: image-formats: Add v4l2 formats support
> > > > > > >   lib: image-formats: Add more functions
> > > > > > >   media: sun6i: Convert to the image format API
> > > > > >
> > > > > > In the interest of making myself unpopular: Why move this out o=
f drm?
> > > > > >
> > > > > > We do have a bunch of other such shared helpers already (mostly=
 in
> > > > > > drivers/video) for dt videomode and hdmi infoframes, and I'm no=
t super
> > > > > > sure that's going better than keeping it maintained in drm.
> > > > > >
> > > > > > Plus the uapi is already that you include drm_fourcc.h to get a=
t these,
> > > > > > dropping the drm prefix isn't going to help I think.
> > > > > >
> > > > > > Of course we'd need to make it a separate drm_formats.ko (so th=
at v4l can
> > > > > > use it without dragging in all of drm), and we need to add some=
 fields for
> > > > > > converting to v4l fourcc codes (which are different). But that =
should be
> > > > > > all possible. And I don't think the drm_ prefix in v4l code is =
a problem,
> > > > > > it's actually a feature: It makes it really clear that these ar=
e the drm
> > > > > > fourcc codes, as allocated in drm_fourcc.h, plus their modifier=
s, and all
> > > > > > that. That allocation authority is also already baked into vari=
ous khr/ext
> > > > > > standards, too.
> > > > >
> > > > > The way I see it, there's a fundamental difference between the UA=
PI
> > > > > and the kernel. I don't suggest we change anything about the UAPI=
: the
> > > > > drm formats should keep their prefix, drm_fourcc.h can remain tha=
t
> > > > > authority, it's all fine.
> > > > >
> > > > > Internally however, the long term goal is to share the fourcc's
> > > > > between DRM and V4L2 for the same formats. It basically means tha=
t of
> > > > > course v4l2 should be using the DRM fourcc when a format exists i=
n DRM
> > > > > and not v4l2, but also that DRM should use v4l2 fourcc when the f=
ormat
> > > > > exists in v4l2 but not DRM, and that is far more likely, given th=
e
> > > > > already extensive v4l2 formats support.
> > > >
> > > > Uh no. We did look at v4l fourcc extensively when deciding upon a d=
rm
> > > > format identifier space.
> > >
> > > No to what exactly?
> > >
> > > > And a lot of people pushed for the "fourcc is a standard", when
> > > > really it's totally not.
> > >
> > > Even if it's not a standard, having consistency would be a good thing=
.
> > >
> > > And you said yourself that DRM fourcc is now pretty much an authority
> > > for the fourcc, so it definitely looks like a standard to me.
> >
> > drm fourcc is the authority for drm fourcc codes. Not for any of the
> > others (and there's lots of them). Now it's used in a bunch of other
> > places (khr standards, dri protocols in wayland/X11), but they're
> > still only drm fourcc. There is no overall fourcc standard.
>
> Sounds like a de-facto standard to me =C2=AF\_(=E3=83=84)_/=C2=AF
>
> But even then, whether we decide to converge the fourcc or not, that's
> still the long term goal. Short term, that series doesn't do any of
> it, it just makes it easier if we ever want to go down that road.
>
> > > > v4l tends to conflate pixel format with stuff that we tend to encod=
e
> > > > in modifiers a lot more.
> > >
> > > Boris is working on adding the modifiers concept to v4l2, so we're
> > > converging here, and we can totally have a layer in v4l2 to convert
> > > between old v4l2 "format+modifiers" formats, and DRM style formats.
> > >
> > > > There's a bunch of reasons we can't just use v4l, and they're as
> > > > valid as ever:
> > > >
> > > > - We overlap badly in some areas, so even if fourcc codes match, we
> > > >   can't use them and need a duplicated DRM_FOURCC code.
> > >
> > > Do yo have an example of one of those areas?
> >
> > I think the rgb stuff was one of the big reasons to not reuse any
> > existing fourcc standard (whether v4l, or another one from e.g. video
> > container formats). We had initial patches to reuse the fourcc that
> > existed, but the end result was really inconsistent, so we ditch that
> > and rolled out a new set of entirely drm specific fourcc codes for
> > rgba.
>
> Ok, so let's ditch that plan and focus on the rest
>
> > > > > And given how the current state is a mess in this regard, I'm not=
 too
> > > > > optimistic about keeping the formats in their relevant frameworks=
.
> > > > >
> > > > > Having a shared library, governed by both, will make this far eas=
ier,
> > > > > since it will be easy to discover the formats that are already
> > > > > supported by the other subsystem.
> > > >
> > > > I think a compat library that (tries to, best effort) convert betwe=
en
> > > > v4l and drm fourcc would make sense. Somewhere in drivers/video, ne=
xt
> > > > to the conversion functions for videomode <-> drm_display_mode
> > > > perhaps. That should be useful for drivers.
> > >
> > > That's not really what this series is about though. That series is
> > > about sharing the (image|pixels) formats database across everyone so
> > > that everyone can benefit from it.
> >
> > Yeah I know. I still think leaving the drm fourcc with the drm prefix
> > would be good, since there's really no standard here.
> >
> > > > Unifying the formats themselves, and all the associated metadata is
> > > > imo a no-go, and was a pretty conscious decision when we implemente=
d
> > > > drm_fourcc a few years back.
> > > >
> > > > > If we want to keep the current library in DRM, we have two option=
s
> > > > > then:
> > > > >
> > > > >   - Support all the v4l2 formats in the DRM library, which is
> > > > >     essentially what I'm doing in the last patches. However, that
> > > > >     would require to have the v4l2 developpers also reviewing stu=
ff
> > > > >     there. And given how busy they are, I cannot really see how t=
hat
> > > > >     would work.
> > > >
> > > > Well, if we end up with a common library then yes we need cross
> > > > review. There's no way around that. Doesn't matter where exactly th=
at
> > > > library is in the filesystem tree, and adding a special MAINTAINERS
> > > > entry for anything related to fourcc (both drm and v4l) to make sur=
e
> > > > they get cross-posted is easy. No file renaming needed.
> > >
> > > That would create some governing issues as well. For example, if you
> > > ever have a patch from one fourcc addition (that might or might not b=
e
> > > covered by v4l2), will you wait for any v4l2 developper to review it?
> >
> > None of this is fixed by code renaming or locations. Either way we
> > need to figure that out.
> >
> > And yes part of the reasons for not moving this out of drm is that I'm
> > not a fan of boutique trees for small stuff. If sharing means we need
> > to split the drm_fourcc code and library out of drm trees, I'm not
> > sure that's a good idea. We're already super liberal with merging
> > anything through driver trees with acks, and integrating them quickly
> > into drm-next. This would still be workable if v4l sends regular pull
> > requests to drm-next (every 1-2 weeks, like the other big gpu trees
> > do). If we can only sync up once per merge window with a shared
> > boutique tree for formats only, life is going to be painful.
>
> I don't get why we want to turn DRM into some kind of a black hole
> that would pull everything. We don't have to, really. And at the same
> time it carries the message that v4l2 is less important than DRM for
> some reason, which I'm really not comfortable with.

Make another tree somewhere that pulls in trees more often than every
merge window, and I'm happy. It's the coordination effort of lots of
trees that creates the black hole, not the other way round. Yes topic
trees work, but if topic trees are persistent something with the
organization of trees is wrong and needs to change. This very much
looks like we'll end up with a perpetual topic branch for format stuff
between drm and v4l.

The other shared stuff (like hdmi infoframes) seems to change a lot
less often, so the occasional patch hasn't been a pain. But drm_fourcc
related stuff sees a lot of work, both in adding new formats and in
refactoring the library to keep up with all the new use-cases.

And yes I think an overall gfx-like-stuff.git tree for drm and v4l and
the few other bits really makes tons of sense. Not as a tree where
people commit, but as the 2nd-level integration tree (like drm.git
right now for gpu stuff).

> And I don't really get why you're against this in the first
> place. When you have some code in a single driver that would benefit
> more driver, you create a helper and move it into the core.

It's a feature that drm doesn't share that much code with other parts
of the kernel, it makes backporting the gfx stack to lts kernels a lot
easier. Until someone fixes the upstream kernel release model to no
longer need large scale gpu driver backports, we need to keep that.

> In this case, we have some code used by a framework that more
> framework could use, and we move it to a core-er place. How is that
> different?

Imo core sharing for code sharing's sake is overrated. If we already
have drm and v4l tightly integrated as a community, then code sharing
becomes a lot easier, and a lot more reasonable to do. Plus we can
then just stuff code int drivers/gpu or drivers/video (or merge these
two because really it's all the same). But my understanding is that
integrating more tightly with the drm folks is a very contreversial
topic in v4l, and until that's resolved I don't see a huge need or
benefit in sharing tons of code. And the format stuff is a lot more
central to kms than e.g. the infoframe helpers.

Au contraire, I think forcing this has a lot of potential for needless
fights between drm and v4l. Hence my suggestion to try a minimal
format conversion library between the drm format world and the v4l
format wolrd, and see how that goes. That contains a lot less risk
than going all in right from the start.
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
