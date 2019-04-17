Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A518AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E513206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 14:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbfDQODO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 10:03:14 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51849 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfDQODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 10:03:13 -0400
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id BCEC5FF814;
        Wed, 17 Apr 2019 14:03:08 +0000 (UTC)
Message-ID: <6b4d5c3bd1a6f58ce21bc79518e72ec00a1eed97.camel@bootlin.com>
Subject: Re: [PATCH 06/20] lib: Add video format information library
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Date:   Wed, 17 Apr 2019 16:03:08 +0200
In-Reply-To: <20190417124833.psdri6laune5y2ti@flea>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
         <c17a896150f0b793cfa8581d18969cd7b3e93bf2.1555487650.git-series.maxime.ripard@bootlin.com>
         <7dbdcb1b54a442e2d77a34bd449b52bbaf903157.camel@bootlin.com>
         <20190417124833.psdri6laune5y2ti@flea>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-04-17 at 14:48 +0200, Maxime Ripard wrote:
> Hi,
> 
> On Wed, Apr 17, 2019 at 02:34:54PM +0200, Paul Kocialkowski wrote:
> > > +struct image_format_info {
> > > +	union {
> > > +		/**
> > > +		 * @drm_fmt:
> > > +		 *
> > > +		 * DRM 4CC format identifier (DRM_FORMAT_*)
> > > +		 */
> > > +		u32 drm_fmt;
> > 
> > Could we call this one format_drm for consistency with the one below?
> 
> The deprecated "format" field will go away at some point, so I'm not
> sure the consistency is an argument there.

Fair enough then. My point was mostly about format vs fmt, so one
option could be to use "compat_fmt" or such, but do whatever you feel
is right, I don't care too much about it.

> > > +/**
> > > + * image_format_info_min_pitch - computes the minimum required pitch in bytes
> > > + * @info: pixel format info
> > > + * @plane: plane index
> > > + * @buffer_width: buffer width in pixels
> > > + *
> > > + * Returns:
> > > + * The minimum required pitch in bytes for a buffer by taking into consideration
> > > + * the pixel format information and the buffer width.
> > > + */
> > > +static inline
> > > +uint64_t image_format_info_min_pitch(const struct image_format_info *info,
> > > +				     int plane, unsigned int buffer_width)
> > > +{
> > > +	if (!info || plane < 0 || plane >= info->num_planes)
> > > +		return 0;
> > > +
> > > +	return DIV_ROUND_UP_ULL((u64)buffer_width * info->char_per_block[plane],
> > > +			    image_format_info_block_width(info, plane) *
> > > +			    image_format_info_block_height(info, plane));
> > 
> > I'm not sure I understand how this works: char_per_block is 0 for
> > almost all formats and this doesn't take in account the cpp. Am I
> > missing something here?
> 
> I guess it doesn't. That's the DRM function here, without any
> modification, but from a quick look at the current users of that
> function, there's nobody that uses the value directly.
> 
> So you might be right there.
>
> > Also, this might be a good occasion to discuss what meaning we want to
> > give "stride" and "pitch": should one be in bytes and the other in bit,
> > etc? I keep forgetting what each API expects.
> 
> pitch is documented as bytes, and the function computing the stride I
> added did too. I'll remove the stride one.

Okay, it seems that I was just confused for no particular reason and
stride, pitch, bytesperline and linesize are all just synonyms. So feel
free to pick whichever you see fit :) 

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

