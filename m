Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC37C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DF52084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfK0K3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:29:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:65447 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfK0K3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:29:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 02:29:17 -0800
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="199142767"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 02:29:13 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Allen Chen <allen.chen@ite.com.tw>,
        open list <linux-kernel@vger.kernel.org>,
        "open list\:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Pi-Hsun Shih <pihsun@chromium.org>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking timings logic
In-Reply-To: <1574761572-26585-1-git-send-email-allen.chen@ite.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1574761572-26585-1-git-send-email-allen.chen@ite.com.tw>
Date:   Wed, 27 Nov 2019 12:29:11 +0200
Message-ID: <87pnhdobns.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019, allen <allen.chen@ite.com.tw> wrote:
> According to VESA ENHANCED EXTENDED DISPLAY IDENTIFICATION DATA STANDARD
> (Defines EDID Structure Version 1, Revision 4) page: 39
> How to determine whether the monitor support RB timing or not?
> EDID 1.4
> First:  read detailed timing descriptor and make sure byte 0 = 0x00,
> 	byte 1 = 0x00, byte 2 = 0x00 and byte 3 = 0xFD
> Second: read EDID bit 0 in feature support byte at address 18h = 1
> 	and detailed timing descriptor byte 10 = 0x04
> Third:  if EDID bit 0 in feature support byte = 1 &&
> 	detailed timing descriptor byte 10 = 0x04
> 	then we can check byte 15, if bit 4 in byte 15 = 1 is support RB
>         if EDID bit 0 in feature support byte != 1 ||
> 	detailed timing descriptor byte 10 != 0x04,
> 	then byte 15 can not be used
>
> The linux code is_rb function not follow the VESA's rule
>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index f5926bf..e11e585 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -93,6 +93,12 @@ struct detailed_mode_closure {
>  	int modes;
>  };
>  
> +struct edid_support_rb_closure {
> +	struct edid *edid;
> +	bool valid_support_rb;
> +	bool support_rb;
> +};
> +
>  #define LEVEL_DMT	0
>  #define LEVEL_GTF	1
>  #define LEVEL_GTF2	2
> @@ -2017,23 +2023,41 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
>  	}
>  }
>  
> +static bool
> +is_display_descriptor(const u8 *r, u8 tag)
> +{
> +	return (!r[0] && !r[1] && !r[2] && r[3] == tag) ? true : false;
> +}
> +
>  static void
>  is_rb(struct detailed_timing *t, void *data)
>  {
>  	u8 *r = (u8 *)t;
> -	if (r[3] == EDID_DETAIL_MONITOR_RANGE)
> -		if (r[15] & 0x10)
> -			*(bool *)data = true;
> +	struct edid_support_rb_closure *closure = data;
> +	struct edid *edid = closure->edid;
> +
> +	if (is_display_descriptor(r, EDID_DETAIL_MONITOR_RANGE)) {
> +		if (edid->features & BIT(0) && r[10] == BIT(2)) {
> +			closure->valid_support_rb = true;
> +			closure->support_rb = (r[15] & 0x10) ? true : false;
> +		}
> +	}
>  }
>  
>  /* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
>  static bool
>  drm_monitor_supports_rb(struct edid *edid)
>  {
> +	struct edid_support_rb_closure closure = {
> +		.edid = edid,
> +		.valid_support_rb = false,
> +		.support_rb = false,
> +	};
> +
>  	if (edid->revision >= 4) {
> -		bool ret = false;
> -		drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
> -		return ret;
> +		drm_for_each_detailed_block((u8 *)edid, is_rb, &closure);
> +		if (closure.valid_support_rb)
> +			return closure.support_rb;

Are you planning on extending the closure use somehow?

I did not look up the spec, but purely on the code changes alone, you
could just move the edid->features bit check at this level, and not pass
it down, and nothing would change. I.e. don't iterate the EDID at all if
the bit is not set.

You also don't actually use the distinction between valid_support_rb
vs. support_rb for anything, so the closure just adds code.

BR,
Jani.


>  	}
>  
>  	return ((edid->input & DRM_EDID_INPUT_DIGITAL) != 0);

-- 
Jani Nikula, Intel Open Source Graphics Center
