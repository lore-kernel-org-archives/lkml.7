Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B0EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D56206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKKNzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:55:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:58271 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbfKKNzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:55:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 05:55:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="207119211"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 11 Nov 2019 05:54:57 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 11 Nov 2019 15:54:56 +0200
Date:   Mon, 11 Nov 2019 15:54:56 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     allen.chen@ite.com.tw
Cc:     Jau-Chih.Tseng@ite.com.tw, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, pihsun@chromium.org, sean@poorly.run
Subject: Re: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking
 timings logic
Message-ID: <20191111135456.GL1208@intel.com>
References: <1572856969-12115-1-git-send-email-allen.chen@ite.com.tw>
 <20191107154209.GC1208@intel.com>
 <d942db3a0b3242c6910c3ec3a524d04a@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d942db3a0b3242c6910c3ec3a524d04a@ite.com.tw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 01:43:52AM +0000, allen.chen@ite.com.tw wrote:
> Hi Ville Syrjälä
> 
> Thanks for your suggestion and I have replied two comments below.
> 
> From: Ville Syrjälä [mailto:ville.syrjala@linux.intel.com] 
> Sent: Thursday, November 07, 2019 11:42 PM
> To: Allen Chen (陳柏宇)
> Cc: Jau-Chih Tseng (曾昭智); Maxime Ripard; open list; open list:DRM DRIVERS; David Airlie; Pi-Hsun Shih; Sean Paul
> Subject: Re: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking timings logic
> 
> On Mon, Nov 04, 2019 at 04:42:49PM +0800, allen wrote:
> > According to VESA ENHANCED EXTENDED DISPLAY IDENTIFICATION DATA STANDARD
> > (Defines EDID Structure Version 1, Revision 4) page: 39
> > How to determine whether the monitor support RB timing or not?
> > EDID 1.4
> > First:  read detailed timing descriptor and make sure byte0 = 0,
> > 	byte1 = 0, byte2 = 0 and byte3 = 0xFD
> 
> That should probably be some new function:
> bool is_display_descriptor(const u8 *desc, u8 tag);
> is_display_descriptor(EDID_DETAIL_MONITOR_RANGE)
> or something along those lines
> 
> We don't seem to check that in most places so should be rolled out all
> over. The usage of struct detailed_timing all over also makes everything
> rather confusing.
> 
> > Second: read detailed timing descriptor byte10 = 0x04 and
> > 	EDID byte18h bit0 = 1
> 
> Indicates CVT support. Should give these things real names so
> one wouldn't have to decode by hand.
> 
> > Third:  if EDID byte18h bit0 == 1 && byte10 == 0x04,
> > 	then we can check byte15, if byte15 bit4 =1 is support RB
> >         if EDID byte18h bit0 != 1 || byte10 != 0x04,
> > 	then byte15 can not be used
> > 
> > The linux code is_rb function not follow the VESA's rule
> > 
> > EDID 1.3
> > LCD flat panels do not require long blanking intervals as a retrace
> > period so default support reduced-blanking timings.
> > 
> > Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> > Reported-by: kbuild test robot <lkp@intel.com>
> > ---
> >  drivers/gpu/drm/drm_edid.c | 28 +++++++++++++++++++++-------
> >  1 file changed, 21 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> > index e5e7e65..9b67b80 100644
> > --- a/drivers/gpu/drm/drm_edid.c
> > +++ b/drivers/gpu/drm/drm_edid.c
> > @@ -93,6 +93,11 @@ struct detailed_mode_closure {
> >  	int modes;
> >  };
> >  
> > +struct edid_support_rb_closure {
> > +	struct edid *edid;
> > +	s8 support_rb;
> 
> bool
> 
> ==> ITE:  If use bool, we could not return EDID1.3 when EDID1.4 logic can not be applied

Hmm. Could use two bools then.

> > +};
> > +
> >  #define LEVEL_DMT	0
> >  #define LEVEL_GTF	1
> >  #define LEVEL_GTF2	2
> > @@ -2018,22 +2023,31 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
> >  is_rb(struct detailed_timing *t, void *data)
> >  {
> >  	u8 *r = (u8 *)t;
> > -	if (r[3] == EDID_DETAIL_MONITOR_RANGE)
> > -		if (r[15] & 0x10)
> > -			*(bool *)data = true;
> > +	struct edid_support_rb_closure *closure = data;
> > +	struct edid *edid = closure->edid;
> > +
> > +	if (!r[0] && !r[1] && !r[2] && r[3] == EDID_DETAIL_MONITOR_RANGE) {
> > +		if (edid->features & BIT(0) && r[10] == BIT(2))
> > +			closure->support_rb = (r[15] & 0x10) ? 1 : 0;
> 
> With the bool the ternary operator is not needed. Also should maybe 
> be |= in case we have multiple range descriptors? Not sure that is
> legal.
> 
> > +	}
> >  }
> >  
> >  /* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
> >  static bool
> >  drm_monitor_supports_rb(struct edid *edid)
> >  {
> > +	struct edid_support_rb_closure closure = {
> > +		.edid = edid,
> > +		.support_rb = -1,
> > +	};
> > +
> >  	if (edid->revision >= 4) {
> > -		bool ret = false;
> > -		drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
> > -		return ret;
> > +		drm_for_each_detailed_block((u8 *)edid, is_rb, &closure);
> > +		if (closure.support_rb >= 0)
> > +			return closure.support_rb;
> >  	}
> >  
> > -	return ((edid->input & DRM_EDID_INPUT_DIGITAL) != 0);
> > +	return true;
> 
> Why are we now assuming rb for all pre 1.4 EDIDs?
> 
> ==> ITE: Today, most of the monitor are LCD and LCD monitor do not require long blanking intervals as a retrace period so default support reduced-blanking timings.

You can't assume such things. Someone out there is surely still using
something that doesn't do reduced blanking.

> 
> >  }
> >  
> >  static void
> > -- 
> > 1.9.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrjälä
> Intel

-- 
Ville Syrjälä
Intel
