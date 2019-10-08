Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84981C47404
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618A520867
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 02:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfJHCkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 22:40:40 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:49198 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJHCkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 22:40:40 -0400
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id D34F44C7;
        Tue,  8 Oct 2019 10:40:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.10.69] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P24810T140293581747968S1570502420990609_;
        Tue, 08 Oct 2019 10:40:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <caf3e72bb905e033806c9ef93bfde02d>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
 <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
 <20190930104849.GA1208@intel.com>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <2c46d532-f810-392d-b9c0-3b9aaccae7f4@rock-chips.com>
Date:   Tue, 8 Oct 2019 10:40:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930104849.GA1208@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ville syrjala,

在 2019/9/30 下午6:48, Ville Syrjälä 写道:
> On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
>> These new format is supported by some rockchip socs:
>>
>> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
>> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
>> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> ---
>>   drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>>   include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>>   2 files changed, 32 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
>> index c630064..ccd78a3 100644
>> --- a/drivers/gpu/drm/drm_fourcc.c
>> +++ b/drivers/gpu/drm/drm_fourcc.c
>> @@ -261,6 +261,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
>>   		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2,
>>   		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 },
>>   		  .hsub = 2, .vsub = 2, .is_yuv = true},
>> +		{ .format = DRM_FORMAT_NV12_10,		.depth = 0,  .num_planes = 2,
>> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
>> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
>> +		{ .format = DRM_FORMAT_NV21_10,		.depth = 0,  .num_planes = 2,
>> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
>> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
>> +		{ .format = DRM_FORMAT_NV16_10,		.depth = 0,  .num_planes = 2,
>> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
>> +		  .hsub = 2, .vsub = 1, .is_yuv = true},
>> +		{ .format = DRM_FORMAT_NV61_10,		.depth = 0,  .num_planes = 2,
>> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
>> +		  .hsub = 2, .vsub = 1, .is_yuv = true},
>> +		{ .format = DRM_FORMAT_NV24_10,		.depth = 0,  .num_planes = 2,
>> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
>> +		  .hsub = 1, .vsub = 1, .is_yuv = true},
>> +		{ .format = DRM_FORMAT_NV42_10,		.depth = 0,  .num_planes = 2,
>> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
>> +		  .hsub = 1, .vsub = 1, .is_yuv = true},
>>   		{ .format = DRM_FORMAT_P210,		.depth = 0,
>>   		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
>>   		  .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 2,
>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>> index 3feeaa3..08e2221 100644
>> --- a/include/uapi/drm/drm_fourcc.h
>> +++ b/include/uapi/drm/drm_fourcc.h
>> @@ -238,6 +238,20 @@ extern "C" {
>>   #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>>   
>>   /*
>> + * 2 plane YCbCr
>> + * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
>> + * index 1 = Cb:Cr plane, Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
>> + * or
>> + * index 1 = Cr:Cb plane, Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
> So now you're defining it as some kind of byte aligned block.
> With that specifying endianness would now make sense since
> otherwise this tells us absolutely nothing about the memory
> layout.
>
> So I'd either do that, or go back to not specifying anything and
> use some weasel words like "mamory layout is implementation defined"
> which of course means no one can use it for anything that involves
> any kind of cross vendor stuff.
/*
  * 2 plane YCbCr
  * index 0 = Y plane, [39: 0] Y3:Y2:Y1:Y0 10:10:10:10  little endian
  * index 1 = Cb:Cr plane, [79: 0] Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 
10:10:10:10:10:10:10:10  little endian
  * or
  * index 1 = Cr:Cb plane, [79: 0] Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 
10:10:10:10:10:10:10:10  little endian
  */

Is this description ok?

>> + */
>> +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
>> +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
>> +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
>> +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
>> +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
>> +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
>> +
>> +/*
>>    * 2 plane YCbCr MSB aligned
>>    * index 0 = Y plane, [15:0] Y:x [10:6] little endian
>>    * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
>> -- 
>> 2.7.4
>>
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


