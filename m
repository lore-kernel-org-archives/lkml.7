Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF33C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8319720643
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbfDSS74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:59:56 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:37286 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbfDSS74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:59:56 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 14:59:55 EDT
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 957B53A9298;
        Fri, 19 Apr 2019 07:22:57 +0000 (UTC)
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C128624000A;
        Fri, 19 Apr 2019 07:22:52 +0000 (UTC)
Message-ID: <011ad65faa3517b2dd51be4a03ad52bf72c93557.camel@bootlin.com>
Subject: Re: [PATCH v3 1/2] media: v4l: Add definitions for the HEVC slice
 format and controls
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 19 Apr 2019 09:22:51 +0200
In-Reply-To: <32979080-a86f-01a4-a9e3-bcb970a85135@xs4all.nl>
References: <20190214095309.19594-1-paul.kocialkowski@bootlin.com>
         <20190214095309.19594-2-paul.kocialkowski@bootlin.com>
         <32979080-a86f-01a4-a9e3-bcb970a85135@xs4all.nl>
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

On Tue, 2019-04-02 at 13:51 +0200, Hans Verkuil wrote:
> On 2/14/19 10:53 AM, Paul Kocialkowski wrote:

[...]

> > +.. c:type:: v4l2_hevc_dpb_entry
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table:: struct v4l2_hevc_dpb_entry
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +    :widths:       1 1 2
> > +
> > +    * - __u32
> > +      - ``buffer_tag``
> > +      - The V4L2 buffer tag that matches the associated reference picture.
> 
> This struct documentation is out of date with the actual struct!

Woops, sorry about that. I'll make another pass on the structures vs
docs before submitting the next version.

> > +#define V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_BEFORE	0x01
> > +#define V4L2_HEVC_DPB_ENTRY_RPS_ST_CURR_AFTER	0x02
> > +#define V4L2_HEVC_DPB_ENTRY_RPS_LT_CURR		0x03
> > +
> > +#define V4L2_HEVC_DPB_ENTRIES_NUM_MAX		16
> > +
> > +struct v4l2_hevc_dpb_entry {
> > +	__u64	timestamp;
> 
> I would call this 'reference_ts' rather than plain 'timestamp'.
> Or at least some other name that reflects what the timestamp
> refers to.

Well, I think using "ts" instead of "timestamp" is much less explicit
(I'm really not a big fan of abbreviations...).

Also, this field is in the dpb entry structure and since a dpb entry
describes a reference, I find it quite straightforward already without
any added prefix. The prefix feels redundant with the name of the
structure that holds the element.

I think the same should apply for mpeg-2 and h.264.

> > +	__u8	rps;
> > +	__u8	field_pic;
> > +	__u16	pic_order_cnt[2];
> > +	__u8	padding[2];
> 
> padding fields here or elsewhere are not documented. Do you really
> need them? What if you changed rps and field_pic to __u16 instead?
> 
> Padding fields are painful to maintain in my experience.

I think we'll need to rework the controls to include flags and such in
the not-too-distant future. So there will be an occasion to change it
then (the same work also needs to be done for MPEG-2).

If you prefer that we make the change now and later update it along
with the controls, I can definitely do that too.

Cheers,

Paul

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

