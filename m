Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCE5C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B4621738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfDWQyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:54:54 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48793 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfDWQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:54:54 -0400
X-Originating-IP: 93.29.109.196
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7CC3BC000B;
        Tue, 23 Apr 2019 16:54:49 +0000 (UTC)
Message-ID: <06f3722e96df32c02421105cab1280f2fbe52e2b.camel@bootlin.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
Date:   Tue, 23 Apr 2019 18:54:49 +0200
In-Reply-To: <20190420224045.GY4964@pendragon.ideasonboard.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <20190417154121.GJ13337@phenom.ffwll.local>
         <20190418062229.eyog4i62eg4pr6uf@flea>
         <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
         <20190418090221.e57dogn4yx5nwdni@flea>
         <6578c22ddf5420d4dead69d29f451bc6a91f6c4a.camel@bootlin.com>
         <20190420224045.GY4964@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dimanche 21 avril 2019 à 01:40 +0300, Laurent Pinchart a écrit :
> Hi Paul,
> 
> On Thu, Apr 18, 2019 at 01:49:54PM +0200, Paul Kocialkowski wrote:
> > On Thu, 2019-04-18 at 11:02 +0200, Maxime Ripard wrote:
> > > On Thu, Apr 18, 2019 at 09:52:10AM +0200, Daniel Vetter wrote:
> > > > And a lot of people pushed for the "fourcc is a standard", when
> > > > really it's totally not.
> > > 
> > > Even if it's not a standard, having consistency would be a good thing.
> > > 
> > > And you said yourself that DRM fourcc is now pretty much an authority
> > > for the fourcc, so it definitely looks like a standard to me.
> > 
> > I think trying to make the V4L2 and DRM fourccs converge is a lost
> > cause, as it has already significantly diverged. Even if we coordinate
> > an effort to introduce new formats with the same fourcc on both sides,
> > I don't see what good that would be since the formats we have now are
> > still plagued by the inconsistency.
> > 
> > I think we always need an explicit translation step from either v4l2 or
> > drm to the internal representation and back, without ever assuming that
> > formats might be compatible because they share the same fourcc.
> 
> I don't agree. APIs evolve, and while we can't switch from one set of
> 4CCs to another in existing APIs, we could in new APIs. Boris is working
> on new ioctls to handle formats in V4L2, and while 4CC unification could
> be impopular from a userspace developers point of view there, I don't
> think we have ruled it out completely. The move to the request API is
> also an area where a common set of 4CCs could be used, as it will depart
> from the existing V4L2 ioctls. To summarize my opinion, we're not there
> yet, but I wouldn't rule it out completely for the future.

Well, I don't see how we could maintain backward compatibility with
some DRM and V4L2 fourccs that are compatible and some that aren't.
Since both descriptions have diverged already, one would need explicit
checking of whether the format at hand is a compatible one or not
before passing-it along as-is to the other subsystem or going through a
format conversion step (in userspace, duplicating the information).
So it feels like it kind of defeats the purpose.

If we're going to use a unified 4CC representation in the future, I
think we should do it by using the new formats that this proposal is
introducing instead of subsystem-specific formats. At which point I
believe we will need an internal conversion step between that format
and what the subsystem uses internally. Or do it the other way round
and use the unified format all around the subsystem, with a legacy
layer for the previous subsystem-specific format.

Cheers,

Paul

