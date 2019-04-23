Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B05C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08B820645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bgiEyt2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfDWPya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:54:30 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57322 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbfDWPya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:54:30 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 399A85F;
        Tue, 23 Apr 2019 17:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556034866;
        bh=VLogqiavWt0eWeZ1VHGhYx46H2MetkiwNadQvNvV4Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgiEyt2StbsUELaw6jIUsF0YNHKgbJkNY4gxKkZe59FEx2ReEpk2J5ZAc5f5iciIW
         fpMFuqkKiTzQ2cFSoTKhyTWcTYludANj+eKxns5Ge52orjoUs9NkyO+9tCAIIzSFT5
         6q/HLnEuB2PPsM6rPtTwOuKvKpMORD36dS2vj2Ec=
Date:   Tue, 23 Apr 2019 18:54:16 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
Message-ID: <20190423155416.GI16111@pendragon.ideasonboard.com>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local>
 <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea>
 <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
 <20190420225904.GZ4964@pendragon.ideasonboard.com>
 <20190423072554.GW13337@phenom.ffwll.local>
 <CAPj87rMWdjEvTJWRvdMLTZyw7pZpo5PpPr0FWcALNRe_D8cYqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPj87rMWdjEvTJWRvdMLTZyw7pZpo5PpPr0FWcALNRe_D8cYqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, Apr 23, 2019 at 09:59:37AM +0100, Daniel Stone wrote:
> On Tue, 23 Apr 2019 at 08:26, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Sun, Apr 21, 2019 at 01:59:04AM +0300, Laurent Pinchart wrote:
> >>>>> - drm fourcc code doesn't actually define the drm_format_info
> >>>>>   uniquely, drivers can override that (that's an explicit design
> >>>>>   intent of modifiers, to allow drivers to add another plane for
> >>>>>   e.g. compression information). You'd need to pull that driver
> >>>>>   knowledge into your format library.
> >>
> >> That's a mistake in my opinion. We tried that in V4L2 to store metadata
> >> in a separate plane, and had to go another route eventually as it
> >> created a very bad mess.
> >
> > Just quick clarification in the middle here: This is how the hw works.
> > It's not metadata that sw ever touches (in general, testcases to make sure
> > we display these correctly excepted).
> >
> > There has been some talking to add maybe a bit more mixed metadata, for
> > fast-clear colors (which isn't used by any display engine afaik yet). That
> > would generally be written by the cpu (in the gl stack), but again read by
> > the hw (loaded as indirect state packet most likely, or something like
> > that). So again hw specific layout, because the hw needs to read it.
> >
> > Pure metadata only of interest for the cpu/sw stack has been shot down
> > completely on the drm side too.
> 
> Totally. Let's take DRM_FORMAT_XRGB8888 + I915_FORMAT_MOD_Y_TILED as
> an example. Here, there is one colour plane which is laid out in a
> documented tiled format, containing normal XRGB8888 pixels once you do
> the maths to get the correct pixel location. So that's fine.
> 
> I915_FORMAT_MOD_Y_TILED_CCS has a base colour plane as above, but adds
> an auxiliary plane which has a few bits describing the state of every
> (differently-sized) tile. Before reading the tile from the colour
> plane, you look at the corresponding location in the auxiliary plane:
> if you read 0x55 from the auxiliary plane, then the entire cacheline
> is the value of the first pixel, i.e. a solid fill. Hardware takes
> advantage of this to only write out the first pixel: if you try to
> read the colour plane as Y_TILED then for solid-filled regions, only
> the first pixel of every tile will show correctly, and the rest will
> be garbage.
> 
> The auxiliary plane has its own layout and placement requirements, so
> we need to carry around an offset and a stride for the auxiliary data.
> We already have this for multiple planes; stuffing it into the base
> plane would require us to reinvent the same for auxiliary data within
> a single plane.

Looks like we have different kinds of metadata to consider. On the V4L2
side metadata usually refers to the context in which a frame was
captured, it doesn't tell how to interpret the contents of the pixels.
In the case you just described, the metadata is part of the frame
contents. I agree that this is a proper use case for storing such
metadata in a plane. What I wouldn't like to see being stored in a plane
is for instance gamma tables or similar data that configures the
processing pipeline in the display engine (I know we have an API for
gamma tables, this is just an example).

> I understand at least one of the Tegra colour-compression layouts (for
> Tegra 1xx?) is similar to this.
> 
> It would be good to understand what you had in mind when you said that
> using multiple planes created a mess. I haven't touched media
> encode/decode units at a low level for quite a while (hooray for
> gst-v4l2!), but I remember that they often used padding areas around
> the buffer for scratch space - maybe motion vectors or similar? That
> case is quite different to something like CCS, since the data is only
> meaningful to the media engine and must be ignored (but preserved) by
> everyone else. Using multiple planes in that case isn't appropriate,
> since it's very specific to how that hardware unit deals with that
> buffer, instead of something that every consumer needs to understand
> in order to use it.

With metadata unrelated to the pixel content, using a separate plane in
the same buffer resulted in an explosion of the number of combinations
that we would need to support, and ultimately led to a very ill-defined
API. We decided to convey metadata related to the frame capture context
(e.g. what exposure time was used for the frame) and processing pipeline
configuration data in different buffers than the frame itself.

-- 
Regards,

Laurent Pinchart
