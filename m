Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C6C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 23:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0310820651
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 23:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OITZP19F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727743AbfDTXFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 19:05:41 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57422 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDTXFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 19:05:41 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7BBB75F;
        Sun, 21 Apr 2019 01:05:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1555801538;
        bh=fKctR+w3M27wicw756d7Gy6T2oMXCpcSlojCaIGpFsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OITZP19Fm0zDB3WlrBcClJxvi34UwVFjyC86SQNoQ/K1xU4eqUL8u8t52XCf0MGbf
         eycJ+3kGW3fhnJf6oHr5qO6iJVeBGsujMHb1pfULtsPyl+hdyrhlRwgmRfTD71d6Ni
         a6+THT4iTeDiuPlUGcvtdIcIHgffYi8BubE0CKLc=
Date:   Sun, 21 Apr 2019 02:05:29 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
Message-ID: <20190420230529.GA4964@pendragon.ideasonboard.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local>
 <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea>
 <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
 <20190418120143.4x7bvhgkh23mgsup@flea>
 <CAKMK7uFRptrYGScX-Ogxhanw6=6Q9Mf22axpafwceMybfYjBKQ@mail.gmail.com>
 <20190418205630.6i7cvfmtoyq5uhvl@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190418205630.6i7cvfmtoyq5uhvl@flea>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Thu, Apr 18, 2019 at 10:56:30PM +0200, Maxime Ripard wrote:
> On Thu, Apr 18, 2019 at 02:32:14PM +0200, Daniel Vetter wrote:
> >>>>> Unifying the formats themselves, and all the associated metadata is
> >>>>> imo a no-go, and was a pretty conscious decision when we implemented
> >>>>> drm_fourcc a few years back.
> >>>>>
> >>>>>> If we want to keep the current library in DRM, we have two options
> >>>>>> then:
> >>>>>>
> >>>>>>   - Support all the v4l2 formats in the DRM library, which is
> >>>>>>     essentially what I'm doing in the last patches. However, that
> >>>>>>     would require to have the v4l2 developpers also reviewing stuff
> >>>>>>     there. And given how busy they are, I cannot really see how that
> >>>>>>     would work.
> >>>>>
> >>>>> Well, if we end up with a common library then yes we need cross
> >>>>> review. There's no way around that. Doesn't matter where exactly that
> >>>>> library is in the filesystem tree, and adding a special MAINTAINERS
> >>>>> entry for anything related to fourcc (both drm and v4l) to make sure
> >>>>> they get cross-posted is easy. No file renaming needed.
> >>>>
> >>>> That would create some governing issues as well. For example, if you
> >>>> ever have a patch from one fourcc addition (that might or might not be
> >>>> covered by v4l2), will you wait for any v4l2 developper to review it?
> >>>
> >>> None of this is fixed by code renaming or locations. Either way we
> >>> need to figure that out.
> >>>
> >>> And yes part of the reasons for not moving this out of drm is that I'm
> >>> not a fan of boutique trees for small stuff. If sharing means we need
> >>> to split the drm_fourcc code and library out of drm trees, I'm not
> >>> sure that's a good idea. We're already super liberal with merging
> >>> anything through driver trees with acks, and integrating them quickly
> >>> into drm-next. This would still be workable if v4l sends regular pull
> >>> requests to drm-next (every 1-2 weeks, like the other big gpu trees
> >>> do). If we can only sync up once per merge window with a shared
> >>> boutique tree for formats only, life is going to be painful.
> >>
> >> I don't get why we want to turn DRM into some kind of a black hole
> >> that would pull everything. We don't have to, really. And at the same
> >> time it carries the message that v4l2 is less important than DRM for
> >> some reason, which I'm really not comfortable with.
> >
> > Make another tree somewhere that pulls in trees more often than every
> > merge window, and I'm happy. It's the coordination effort of lots of
> > trees that creates the black hole, not the other way round. Yes topic
> > trees work, but if topic trees are persistent something with the
> > organization of trees is wrong and needs to change. This very much
> > looks like we'll end up with a perpetual topic branch for format stuff
> > between drm and v4l.
> 
> Well, if v4l2 sends a PR to DRM every 1 or 2 weeks, that definitely
> looks like a topic branch to me. And on a far more frequent basis than
> when we will merge a format description.
> 
> > The other shared stuff (like hdmi infoframes) seems to change a lot
> > less often, so the occasional patch hasn't been a pain. But drm_fourcc
> > related stuff sees a lot of work, both in adding new formats and in
> > refactoring the library to keep up with all the new use-cases.
> 
> When was the last time a refactoring that changed the API happened?
> 
> Most of the changes will be new format descriptions, and I guess that
> would only concern a single tree.
> 
> And really, we're doing this all the time, so I'm not sure what the
> big deal is here.
> 
> I feel like there's something that you don't really like about this,
> but you're not saying this out loud.
> 
> Sure, the exact process needs to be figured out, and everyone needs to
> agree upon that process. But that's pretty much it, and it's nothing
> out of the ordinary.
> 
> > And yes I think an overall gfx-like-stuff.git tree for drm and v4l and
> > the few other bits really makes tons of sense. Not as a tree where
> > people commit, but as the 2nd-level integration tree (like drm.git
> > right now for gpu stuff).
> >
> >> And I don't really get why you're against this in the first
> >> place. When you have some code in a single driver that would benefit
> >> more driver, you create a helper and move it into the core.
> >
> > It's a feature that drm doesn't share that much code with other parts
> > of the kernel, it makes backporting the gfx stack to lts kernels a lot
> > easier. Until someone fixes the upstream kernel release model to no
> > longer need large scale gpu driver backports, we need to keep that.
> >
> >> In this case, we have some code used by a framework that more
> >> framework could use, and we move it to a core-er place. How is that
> >> different?
> >
> > Imo core sharing for code sharing's sake is overrated. If we already
> > have drm and v4l tightly integrated as a community, then code sharing
> > becomes a lot easier, and a lot more reasonable to do.
> 
> At least Laurent, Boris, Ezequiel, Gustavo and I have been working on
> v4l2, so I'm not sure how not integrated we are.

Let's also mention that we'll need more code sharing as we move forward.
We already have chips that have two drivers, one in V4L2 and one in DRM
(I'm thinking about the adv7511 bridge driver for instance). I know SoC
vendors that are not happy about this state of things as they have IP
cores that can be used in both camera and display pipelines. It's a long
standing issue, it won't be solve today, but we'll need to get to it
eventually. Sharing a 4CC library would be a great step forward in my
opinion, in order to get the two subsystems to collaborate better.

> > Plus we can then just stuff code int drivers/gpu or drivers/video
> > (or merge these two because really it's all the same). But my
> > understanding is that integrating more tightly with the drm folks is
> > a very contreversial topic in v4l
> 
> So, I sent the RFC expecting that kind of feedback.
> 
> Hans replied mainly to that patch https://patchwork.freedesktop.org/patch/293043/
> 
> "
> If we are creating a common library then I think we should change that rule
> to: "unless they are in use by a DRM or V4L2 driver". And when new formats are
> added, and they exists already for DRM or V4L2, then we should use the same
> fourcc for the other subsystem.
> 
> I.e. if pixelformat V4L2_PIX_FMT_FOO was already defined, then add a:
> 
> #define DRM_FORMAT_FOO V4L2_PIX_FMT_FOO
> 
> rather than creating a new fourcc.

I would like to point out here that we have two different items we call
4CC, the macro name (FOO in your example here), and the numerical value.
If a numerical value already exists in DRM or V4L2 for a given pixel
format, it should be used, period. The macro name, however, could be
changed, as many of them carry historical mistakes.

> We could even start looking at redoing the whole scheme in a unified way, but
> that's something for the (far) future.
> 
> This is already a big step forward.
> "
> 
> So, not controversial at all.
> 
> > and until that's resolved I don't see a huge need or benefit in
> > sharing tons of code.
> 
> That's mostly tons of data though. The code is pretty small and
> trivial.
> 
> > And the format stuff is a lot more central to kms than e.g. the
> > infoframe helpers.
> >
> > Au contraire, I think forcing this has a lot of potential for
> > needless fights between drm and v4l.
> 
> We're all reasonable, so I'm not sure why we would need to fight here.
> 
> > Hence my suggestion to try a minimal format conversion library
> > between the drm format world and the v4l format wolrd, and see how
> > that goes. That contains a lot less risk than going all in right
> > from the start.
> 
> And it's really not about getting access to the DRM fourcc. It's about
> getting access to DRM's format description, so I'm not really sure
> what there is to convert, we just want a lookup.

-- 
Regards,

Laurent Pinchart
