Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BTC_ID,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05573C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2FC2206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 08:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLCICb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:02:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:23908 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727491AbfLCICa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 03:02:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 00:02:30 -0800
X-IronPort-AV: E=Sophos;i="5.69,272,1571727600"; 
   d="scan'208";a="200908546"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2019 00:02:27 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     allen.chen@ite.com.tw
Cc:     Jau-Chih.Tseng@ite.com.tw, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, pihsun@chromium.org, sean@poorly.run
Subject: RE: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking timings logic
In-Reply-To: <e2486891920843798e9af97209464833@ite.com.tw>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1574761572-26585-1-git-send-email-allen.chen@ite.com.tw> <87pnhdobns.fsf@intel.com> <e2486891920843798e9af97209464833@ite.com.tw>
Date:   Tue, 03 Dec 2019 10:02:25 +0200
Message-ID: <87muc9kfam.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Dec 2019, <allen.chen@ite.com.tw> wrote:
> Hi Jani Nikula
>
>
>
> Thanks for your suggestion and I have replied two comments below.

Please read my question again.

BR,
Jani.

>
>
>
> -----Original Message-----
> From: Jani Nikula [mailto:jani.nikula@linux.intel.com]
> Sent: Wednesday, November 27, 2019 6:29 PM
> To: Allen Chen (陳柏宇)
> Cc: Jau-Chih Tseng (曾昭智); Maxime Ripard; Allen Chen (陳柏宇); open list; open list:DRM DRIVERS; David Airlie; Pi-Hsun Shih; Sean Paul
> Subject: Re: [PATCH] drm/edid: fixup EDID 1.3 and 1.4 judge reduced-blanking timings logic
>
>
>
> On Tue, 26 Nov 2019, allen <allen.chen@ite.com.tw> wrote:
>
>> According to VESA ENHANCED EXTENDED DISPLAY IDENTIFICATION DATA STANDARD
>
>> (Defines EDID Structure Version 1, Revision 4) page: 39
>
>> How to determine whether the monitor support RB timing or not?
>
>> EDID 1.4
>
>> First:  read detailed timing descriptor and make sure byte 0 = 0x00,
>
>>     byte 1 = 0x00, byte 2 = 0x00 and byte 3 = 0xFD
>
>> Second: read EDID bit 0 in feature support byte at address 18h = 1
>
>>     and detailed timing descriptor byte 10 = 0x04
>
>> Third:  if EDID bit 0 in feature support byte = 1 &&
>
>>     detailed timing descriptor byte 10 = 0x04
>
>>     then we can check byte 15, if bit 4 in byte 15 = 1 is support RB
>
>>         if EDID bit 0 in feature support byte != 1 ||
>
>>     detailed timing descriptor byte 10 != 0x04,
>
>>     then byte 15 can not be used
>
>>
>
>> The linux code is_rb function not follow the VESA's rule
>
>>
>
>> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
>
>> Reported-by: kbuild test robot <lkp@intel.com>
>
>> ---
>
>>  drivers/gpu/drm/drm_edid.c | 36 ++++++++++++++++++++++++++++++------
>
>>  1 file changed, 30 insertions(+), 6 deletions(-)
>
>>
>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>
>> index f5926bf..e11e585 100644
>
>> --- a/drivers/gpu/drm/drm_edid.c
>
>> +++ b/drivers/gpu/drm/drm_edid.c
>
>> @@ -93,6 +93,12 @@ struct detailed_mode_closure {
>
>>    int modes;
>
>>  };
>
>>
>
>> +struct edid_support_rb_closure {
>
>> +   struct edid *edid;
>
>> +   bool valid_support_rb;
>
>> +   bool support_rb;
>
>> +};
>
>> +
>
>>  #define LEVEL_DMT 0
>
>>  #define LEVEL_GTF   1
>
>>  #define LEVEL_GTF2 2
>
>> @@ -2017,23 +2023,41 @@ struct drm_display_mode *drm_mode_find_dmt(struct drm_device *dev,
>
>>    }
>
>>  }
>
>>
>
>> +static bool
>
>> +is_display_descriptor(const u8 *r, u8 tag)
>
>> +{
>
>> +   return (!r[0] && !r[1] && !r[2] && r[3] == tag) ? true : false;
>
>> +}
>
>> +
>
>>  static void
>
>>  is_rb(struct detailed_timing *t, void *data)
>
>>  {
>
>>    u8 *r = (u8 *)t;
>
>> -    if (r[3] == EDID_DETAIL_MONITOR_RANGE)
>
>> -            if (r[15] & 0x10)
>
>> -                    *(bool *)data = true;
>
>> +   struct edid_support_rb_closure *closure = data;
>
>> +   struct edid *edid = closure->edid;
>
>> +
>
>> +   if (is_display_descriptor(r, EDID_DETAIL_MONITOR_RANGE)) {
>
>> +           if (edid->features & BIT(0) && r[10] == BIT(2)) {
>
>> +                   closure->valid_support_rb = true;
>
>> +                   closure->support_rb = (r[15] & 0x10) ? true : false;
>
>> +           }
>
>> +   }
>
>>  }
>
>>
>
>>  /* EDID 1.4 defines this explicitly.  For EDID 1.3, we guess, badly. */
>
>>  static bool
>
>>  drm_monitor_supports_rb(struct edid *edid)
>
>>  {
>
>> +   struct edid_support_rb_closure closure = {
>
>> +           .edid = edid,
>
>> +           .valid_support_rb = false,
>
>> +           .support_rb = false,
>
>> +   };
>
>> +
>
>>    if (edid->revision >= 4) {
>
>> -            bool ret = false;
>
>> -            drm_for_each_detailed_block((u8 *)edid, is_rb, &ret);
>
>> -            return ret;
>
>> +           drm_for_each_detailed_block((u8 *)edid, is_rb, &closure);
>
>> +           if (closure.valid_support_rb)
>
>> +                   return closure.support_rb;
>
>
>
> Are you planning on extending the closure use somehow?
>
>
>
> I did not look up the spec,
>
>
>
> ==> iTE: as the picture below, from VESA E-EDID standard
>
> [cid:image003.jpg@01D5A9EA.9B7364D0]
>
>
>
> [cid:image005.jpg@01D5A9EA.9B7364D0]
>
>
>
> if EDID bit 0 in feature support byte = 1 && detailed timing descriptor byte 10 = 0x04 then the CVT timing supported.
>
>
>
> [cid:image009.jpg@01D5A9EA.9B7364D0]
>
>
>
> If CVT timing supported then we can check byte 15 bit 4 to determine whether the reduced-blanking timings suported or not.
>
> If CVT timing not supported then we can not use byte 15 to judge.
>
> but purely on the code changes alone, you
>
> could just move the edid->features bit check at this level, and not pass
>
> it down, and nothing would change. I.e. don't iterate the EDID at all if
>
> the bit is not set.
>
>
>
> ð  iTE: We still have to check whether detailed timing descriptor byte 10 = 0x04 or not, so it is hard to check at this level
>
> You also don't actually use the distinction between valid_support_rb
>
> vs. support_rb for anything, so the closure just adds code.
>
>
>
> BR,
>
> Jani.
>
>
>
>
>
>>    }
>
>>
>
>>    return ((edid->input & DRM_EDID_INPUT_DIGITAL) != 0);
>
>
>
> --
>
> Jani Nikula, Intel Open Source Graphics Center

-- 
Jani Nikula, Intel Open Source Graphics Center
