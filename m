Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD633C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B710F20B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDHJVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:21:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:16576 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfDHJVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:21:41 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 02:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,324,1549958400"; 
   d="scan'208";a="159681678"
Received: from troebing-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.249.45.170])
  by fmsmga004.fm.intel.com with ESMTP; 08 Apr 2019 02:21:36 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 3C3D821E50; Mon,  8 Apr 2019 12:21:27 +0300 (EEST)
Date:   Mon, 8 Apr 2019 12:21:27 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mickael GUENE <mickael.guene@st.com>
Cc:     "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Hugues FRUCHET <hugues.fruchet@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ben Kao <ben.kao@intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Ricardo Ribalda Delgado <ricardo@ribalda.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Subject: Re: [PATCH v3 2/2] media:st-mipid02: MIPID02 CSI-2 to PARALLEL
 bridge driver
Message-ID: <20190408092126.xgqhmyos5hkvmisv@kekkonen.localdomain>
References: <1552373045-134493-1-git-send-email-mickael.guene@st.com>
 <1553594620-88280-1-git-send-email-mickael.guene@st.com>
 <1553594620-88280-3-git-send-email-mickael.guene@st.com>
 <20190326113308.mp5hqdw3ktbpcawu@paasikivi.fi.intel.com>
 <fb8bf371-6158-a9b8-0822-65bc5d6db536@st.com>
 <20190406110135.7l2m6hkmvwr33d7s@kekkonen.localdomain>
 <1c7e0b8a-7441-57eb-38c0-e951917637c6@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c7e0b8a-7441-57eb-38c0-e951917637c6@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 06:17:18AM +0000, Mickael GUENE wrote:
> Hi Sakari,
> 
> On 4/6/19 13:01, Sakari Ailus wrote:
> > On Tue, Mar 26, 2019 at 02:36:41PM +0000, Mickael GUENE wrote:
> >> Sakari,
> >>
> >>>> +static int bpp_from_code(__u32 code)
> >>>> +{
> >>>> +	switch (code) {
> >>>> +	case MEDIA_BUS_FMT_SBGGR8_1X8:
> >>>> +	case MEDIA_BUS_FMT_SGBRG8_1X8:
> >>>> +	case MEDIA_BUS_FMT_SGRBG8_1X8:
> >>>> +	case MEDIA_BUS_FMT_SRGGB8_1X8:
> >>>> +		return 8;
> >>>> +	case MEDIA_BUS_FMT_SBGGR10_1X10:
> >>>> +	case MEDIA_BUS_FMT_SGBRG10_1X10:
> >>>> +	case MEDIA_BUS_FMT_SGRBG10_1X10:
> >>>> +	case MEDIA_BUS_FMT_SRGGB10_1X10:
> >>>> +		return 10;
> >>>> +	case MEDIA_BUS_FMT_SBGGR12_1X12:
> >>>> +	case MEDIA_BUS_FMT_SGBRG12_1X12:
> >>>> +	case MEDIA_BUS_FMT_SGRBG12_1X12:
> >>>> +	case MEDIA_BUS_FMT_SRGGB12_1X12:
> >>>> +		return 12;
> >>>> +	case MEDIA_BUS_FMT_UYVY8_2X8:
> >>>
> >>> This is good for the parallel bus, but on CSI-2 side you should have
> >>> MEDIA_BUS_FMT_UYVY8_1X16 instead. This isn't technically correct for a
> >>> serial bus, but the custom is to use the one sample / pixel formats on the
> >>> serial busses.
> >>>
> >>  Should MEDIA_BUS_FMT_BGR888_1X24 be something like
> >> MEDIA_BUS_FMT_BGR888_3X8 for parallel output bus ?
> > 
> > Good point. Yes.
> > 
> > Could you add that format to
> > Documentation/media/uapi/v4l/subdev-formats.rst, please, in a separate
> > patch?
> > 
>  I also need to add it to include/uapi/linux/media-bus-format.h I
> suppose ?

Yes, that's correct.

>  I was also wondering if I should add MEDIA_BUS_FMT_BGR888_3X8_BE and
> MEDIA_BUS_FMT_BGR888_3X8_LE instead ?

If it's either, then "BE" but in this case I think it's better be without
the explicit endianness as the endianness change results in pixel order
change --- the format itself remains valid.

I wonder what others think, too. Hans, any opinion?

> 
>  So if you are ok with the above I will add MEDIA_BUS_FMT_BGR888_3X8 to
> subdev-formats.rs and media-bus-format.h as a first parch of my serie.

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
