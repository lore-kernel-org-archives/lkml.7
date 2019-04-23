Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D96C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724A920674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="yp0mZZex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfDWJAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:00:02 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44788 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfDWJAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:00:01 -0400
Received: by mail-lj1-f196.google.com with SMTP id h16so210323ljg.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 01:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=CvaomlbaXxtymqxQxD6W+RuKqP8z/iCKy231aTStM20=;
        b=yp0mZZexkGrefH8+REJLrImRVaBKobtKjI66dAbPm9codU5dvr9ycLh+2PjGePKAAY
         2akW89FogqEa497Wax5Fe1yLvijWjQZz088xyEqdwtC2SNoASN7ud9+mfQrt7+rSHvxu
         tKcFXh+HbQZamfdwvjGv+RiNY7Du4eONPl/bdapBbvd4/P2jFaFEQfVYvblHb26KfXIp
         XF04bWFGpd3yOIEozNb5M3jwShfd7EhR5P19nFzSwCZbDY3y0aeLtEwsS0r5sXMSjd/f
         Oplb7Lg3t/rgZhuQwKXh2YGaIrQBqeEt2EB9YKHiSttV8faNwvy5/Ay4qOyvcVPGiDch
         jpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=CvaomlbaXxtymqxQxD6W+RuKqP8z/iCKy231aTStM20=;
        b=AuUJtxberd7eg2uQrNIPWYw60vvyzauualQFcwciKRCInYOQUxhOGj4ChADueRgdY3
         702dbrExMrhDAWNrKWYbSdDY6V0DDckiQwksbBBKn1IUcymMiMzOd9kAwRxDt35WmTvd
         v4vZ2Vw/lgT/Kar5lGM4oayLNj6Qu6qRNcapfoJDEvbpkQ+W76ABTzGd7zK5CZKWvGOp
         VuFAA8/2pWxWzBH5UMlAGiHqX9X7GZBLUoiLpczpwmBK9dKjGhpdKaDCBDW92j6Flcth
         xdjw7FuF/LWm1J6xPGog1c6ssArUE8BjbhI/k2pPy8kQHgP3LfhAe+8xQzy2YXyIJLVM
         EPcQ==
X-Gm-Message-State: APjAAAVeqi1HwnQG6WRb4782WP049G5jpCx19w0Vqtnj0W0KAf4qm1MC
        h9eNJ1l+LEpePbEkhvBc3gwaXggwtOklFinSqcKbdA==
X-Google-Smtp-Source: APXvYqy9cU6GL/iq4/0pK6YvHXQbyi2BmRCdxgFf2pNhk3mst69GcT16J8QBOXIi3EvNOlWrX5v6rXN0keJV1s+MPOc=
X-Received: by 2002:a2e:390c:: with SMTP id g12mr13958184lja.174.1556009998594;
 Tue, 23 Apr 2019 01:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <20190417154121.GJ13337@phenom.ffwll.local> <20190418062229.eyog4i62eg4pr6uf@flea>
 <CAKMK7uHwSjqXwWGt+wQ6oMFWoPqmBxYHL7r+vTOXdYt9KMCYLQ@mail.gmail.com>
 <20190418090221.e57dogn4yx5nwdni@flea> <CAKMK7uHN6QfYyzx4DjRT+7VLRi6N9DorQtw2GoDiNGTgie=DXA@mail.gmail.com>
 <20190420225904.GZ4964@pendragon.ideasonboard.com> <20190423072554.GW13337@phenom.ffwll.local>
In-Reply-To: <20190423072554.GW13337@phenom.ffwll.local>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Tue, 23 Apr 2019 09:59:37 +0100
Message-ID: <CAPj87rMWdjEvTJWRvdMLTZyw7pZpo5PpPr0FWcALNRe_D8cYqw@mail.gmail.com>
Subject: Re: [PATCH 00/20] drm: Split out the formats API and move it to a
 common place
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 Apr 2019 at 08:26, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Sun, Apr 21, 2019 at 01:59:04AM +0300, Laurent Pinchart wrote:
> > > > > - drm fourcc code doesn't actually define the drm_format_info
> > > > >   uniquely, drivers can override that (that's an explicit design
> > > > >   intent of modifiers, to allow drivers to add another plane for
> > > > >   e.g. compression information). You'd need to pull that driver
> > > > >   knowledge into your format library.
> >
> > That's a mistake in my opinion. We tried that in V4L2 to store metadata
> > in a separate plane, and had to go another route eventually as it
> > created a very bad mess.
>
> Just quick clarification in the middle here: This is how the hw works.
> It's not metadata that sw ever touches (in general, testcases to make sure
> we display these correctly excepted).
>
> There has been some talking to add maybe a bit more mixed metadata, for
> fast-clear colors (which isn't used by any display engine afaik yet). That
> would generally be written by the cpu (in the gl stack), but again read by
> the hw (loaded as indirect state packet most likely, or something like
> that). So again hw specific layout, because the hw needs to read it.
>
> Pure metadata only of interest for the cpu/sw stack has been shot down
> completely on the drm side too.

Totally. Let's take DRM_FORMAT_XRGB8888 + I915_FORMAT_MOD_Y_TILED as
an example. Here, there is one colour plane which is laid out in a
documented tiled format, containing normal XRGB8888 pixels once you do
the maths to get the correct pixel location. So that's fine.

I915_FORMAT_MOD_Y_TILED_CCS has a base colour plane as above, but adds
an auxiliary plane which has a few bits describing the state of every
(differently-sized) tile. Before reading the tile from the colour
plane, you look at the corresponding location in the auxiliary plane:
if you read 0x55 from the auxiliary plane, then the entire cacheline
is the value of the first pixel, i.e. a solid fill. Hardware takes
advantage of this to only write out the first pixel: if you try to
read the colour plane as Y_TILED then for solid-filled regions, only
the first pixel of every tile will show correctly, and the rest will
be garbage.

The auxiliary plane has its own layout and placement requirements, so
we need to carry around an offset and a stride for the auxiliary data.
We already have this for multiple planes; stuffing it into the base
plane would require us to reinvent the same for auxiliary data within
a single plane.

I understand at least one of the Tegra colour-compression layouts (for
Tegra 1xx?) is similar to this.

It would be good to understand what you had in mind when you said that
using multiple planes created a mess. I haven't touched media
encode/decode units at a low level for quite a while (hooray for
gst-v4l2!), but I remember that they often used padding areas around
the buffer for scratch space - maybe motion vectors or similar? That
case is quite different to something like CCS, since the data is only
meaningful to the media engine and must be ignored (but preserved) by
everyone else. Using multiple planes in that case isn't appropriate,
since it's very specific to how that hardware unit deals with that
buffer, instead of something that every consumer needs to understand
in order to use it.

Cheers,
Daniel
