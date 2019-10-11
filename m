Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E32C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A462064A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 07:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfJKHcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 03:32:35 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:49130 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbfJKHcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 03:32:35 -0400
Received: from localhost (unknown [192.168.167.209])
        by regular1.263xmail.com (Postfix) with ESMTP id 8824530C;
        Fri, 11 Oct 2019 15:32:18 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.10.69] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P14769T139950089561856S1570779137272325_;
        Fri, 11 Oct 2019 15:32:18 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <bd7df4ab069192ff49b16ce12821afe7>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: nd@arm.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        nd <nd@arm.com>
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
 <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
 <20190930104849.GA1208@intel.com>
 <2c46d532-f810-392d-b9c0-3b9aaccae7f4@rock-chips.com>
 <20191008113338.GP1208@intel.com>
 <a5fa3d8e-9e8e-8aa8-8abb-f00e8357acb5@rock-chips.com>
 <eafa5b37-e132-ad37-3876-384ac5ec9584@rock-chips.com>
 <20191011064433.GA18503@jamwan02-TSP300>
 <5c932cb6-fdfb-88db-3757-4c1b602d4778@rock-chips.com>
 <20191011072250.GA20592@jamwan02-TSP300>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <f4828cab-da7e-1658-51e7-0d123cfdbdf9@rock-chips.com>
Date:   Fri, 11 Oct 2019 15:32:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191011072250.GA20592@jamwan02-TSP300>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/10/11 下午3:22, james qian wang (Arm Technology China) 写道:
> On Fri, Oct 11, 2019 at 03:07:22PM +0800, sandy.huang wrote:
>> 在 2019/10/11 下午2:44, james qian wang (Arm Technology China) 写道:
>>> On Fri, Oct 11, 2019 at 11:35:53AM +0800, sandy.huang wrote:
>>>> Hi james.qian.wang,
>>>>
>>>>       Thank for you remind, fou some unknow reason, i miss the the mail from
>>>> you:(, i get this message from https://patchwork.kernel.org/patch/11161937/
>>>>
>>>> sorry about that.
>>>>
>>>>       About the format block describe, I also found some unreasonable,  this
>>>> format need 2 line aligned, so the block_h need to sed as 2, and the
>>>> char_per_block need set as w * h * 10 for y plane, and w * h * 2 * 10 for uv
>>>> plane, so the following describe maybe more correct, thanks.
>>>>
>>>>           { .format = DRM_FORMAT_NV12_10,        .depth = 0, .num_planes = 2,
>>>>             .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
>>>> = { 2, 2, 0 },
>>>>             .hsub = 2, .vsub = 2, .is_yuv = true},
>>> Hi Sandy:
>>> I think for such NV12 YUV-422 (hsub = 2, vsub = 2) 2x2 subsampled format
>>> the block size can be:
>>>
>>> the Y plane:  2x2;
>>> The UV plane: 1x2; (H direction sample 1 Cb and 1Cr, V direction 2 lines got 2)
>>>
>>> Then:
>>>
>>> .char_per_block = {5, 5, 0} block_w = {2, 1, 0}. block_h = {2, 2, 0};
>>>
>>> Thanks
>>> James
>> Hi James,
>>
>> If the block_w is 2 pixel, one line size at block is 2*10 bit %8 != 0,
> Hi Sandy:
> you got a mistake here, the bpp of UV plane is 20, 10bit Cb + 10 bit Cr.
here is for y plane.
>> although we use block to describe this format, but actually the data is
>> still stored one line by one line, still need 4 pixel aligned. so i think
>> here need use 4pixel*2line for per block
> I think this is your hardware specific requirement.
>
> Thanks
> James

yes, this is a new format first used at rockchip platform.


Thanks,

sandy.huang

>> Thanks,
>>
>> sandy.huang.
>>
>>>>             .hsub = 2, .vsub = 2, .is_yuv = true},
>>>>           { .format = DRM_FORMAT_NV21_10,        .depth = 0, .num_planes = 2,
>>>>             .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
>>>> = { 2, 2, 0 },
>>>>             .hsub = 2, .vsub = 2, .is_yuv = true},
>>>>           { .format = DRM_FORMAT_NV16_10,        .depth = 0, .num_planes = 2,
>>>>             .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
>>>> = { 2, 2, 0 },
>>>>             .hsub = 2, .vsub = 1, .is_yuv = true},
>>>>           { .format = DRM_FORMAT_NV61_10,        .depth = 0, .num_planes = 2,
>>>>             .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
>>>> = { 2, 2, 0 },
>>>>             .hsub = 2, .vsub = 1, .is_yuv = true},
>>>>           { .format = DRM_FORMAT_NV24_10,        .depth = 0, .num_planes = 2,
>>>>             .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
>>>> = { 2, 2, 0 },
>>>>             .hsub = 1, .vsub = 1, .is_yuv = true},
>>>>           { .format = DRM_FORMAT_NV42_10,        .depth = 0, .num_planes = 2,
>>>>             .char_per_block = { 10, 10, 0 }, .block_w = { 4, 2, 0 }, .block_h
>>>> = { 2, 2, 0 },
>>>>             .hsub = 1, .vsub = 1, .is_yuv = true},
>>>>
>>>>
>>>>>>             { .format = DRM_FORMAT_P016,        .depth = 0,  .num_planes =
>>>> 2,
>>>>>>               .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 },
>>>> .block_h = { 1, 0, 0 },
>>>>>>               .hsub = 2, .vsub = 2, .is_yuv = true},
>>>>>> +        { .format = DRM_FORMAT_NV12_10,        .depth = 0,  .num_planes
>>>> = 2,
>>>>>> +          .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 },
>>>> .block_h = { 4, 4, 0 },
>>>>
>>>>> Hi Sandy:
>>>>> Their is a problem here for char_per_block size of plane[0]:
>>>>> Since: 5 * 8 != 4 * 4 * 10;
>>>>> Seems you mis-set the block_w/h, per your block size the block is 2x2, and
>>>> it should be:
>>>>>     .char_per_block = { 5, 10, 0 }, .block_w = { 2, 2, 0 }, .block_h = { 2,
>>>> 2, 0 },
>>>>
>>>>> Best Regards:
>>>>> James
>>>>
>>>>
>>>>
>>>>
>>>> 在 2019/10/8 下午7:49, sandy.huang 写道:
>>>>> 在 2019/10/8 下午7:33, Ville Syrjälä 写道:
>>>>>> On Tue, Oct 08, 2019 at 10:40:20AM +0800, sandy.huang wrote:
>>>>>>> Hi ville syrjala,
>>>>>>>
>>>>>>> 在 2019/9/30 下午6:48, Ville Syrjälä 写道:
>>>>>>>> On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
>>>>>>>>> These new format is supported by some rockchip socs:
>>>>>>>>>
>>>>>>>>> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
>>>>>>>>> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
>>>>>>>>> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
>>>>>>>>>
>>>>>>>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>>>>>>>>>      include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>>>>>>>>>      2 files changed, 32 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/drm_fourcc.c
>>>>>>>>> b/drivers/gpu/drm/drm_fourcc.c
>>>>>>>>> index c630064..ccd78a3 100644
>>>>>>>>> --- a/drivers/gpu/drm/drm_fourcc.c
>>>>>>>>> +++ b/drivers/gpu/drm/drm_fourcc.c
>>>>>>>>> @@ -261,6 +261,24 @@ const struct drm_format_info
>>>>>>>>> *__drm_format_info(u32 format)
>>>>>>>>>              { .format = DRM_FORMAT_P016,        .depth =
>>>>>>>>> 0,  .num_planes = 2,
>>>>>>>>>                .char_per_block = { 2, 4, 0 }, .block_w = {
>>>>>>>>> 1, 0, 0 }, .block_h = { 1, 0, 0 },
>>>>>>>>>                .hsub = 2, .vsub = 2, .is_yuv = true},
>>>>>>>>> +        { .format = DRM_FORMAT_NV12_10,        .depth =
>>>>>>>>> 0,  .num_planes = 2,
>>>>>>>>> +          .char_per_block = { 5, 10, 0 }, .block_w = {
>>>>>>>>> 4, 4, 0 }, .block_h = { 4, 4, 0 },
>>>>>>>>> +          .hsub = 2, .vsub = 2, .is_yuv = true},
>>>>>>>>> +        { .format = DRM_FORMAT_NV21_10,        .depth =
>>>>>>>>> 0,  .num_planes = 2,
>>>>>>>>> +          .char_per_block = { 5, 10, 0 }, .block_w = {
>>>>>>>>> 4, 4, 0 }, .block_h = { 4, 4, 0 },
>>>>>>>>> +          .hsub = 2, .vsub = 2, .is_yuv = true},
>>>>>>>>> +        { .format = DRM_FORMAT_NV16_10,        .depth =
>>>>>>>>> 0,  .num_planes = 2,
>>>>>>>>> +          .char_per_block = { 5, 10, 0 }, .block_w = {
>>>>>>>>> 4, 4, 0 }, .block_h = { 4, 4, 0 },
>>>>>>>>> +          .hsub = 2, .vsub = 1, .is_yuv = true},
>>>>>>>>> +        { .format = DRM_FORMAT_NV61_10,        .depth =
>>>>>>>>> 0,  .num_planes = 2,
>>>>>>>>> +          .char_per_block = { 5, 10, 0 }, .block_w = {
>>>>>>>>> 4, 4, 0 }, .block_h = { 4, 4, 0 },
>>>>>>>>> +          .hsub = 2, .vsub = 1, .is_yuv = true},
>>>>>>>>> +        { .format = DRM_FORMAT_NV24_10,        .depth =
>>>>>>>>> 0,  .num_planes = 2,
>>>>>>>>> +          .char_per_block = { 5, 10, 0 }, .block_w = {
>>>>>>>>> 4, 4, 0 }, .block_h = { 4, 4, 0 },
>>>>>>>>> +          .hsub = 1, .vsub = 1, .is_yuv = true},
>>>>>>>>> +        { .format = DRM_FORMAT_NV42_10,        .depth =
>>>>>>>>> 0,  .num_planes = 2,
>>>>>>>>> +          .char_per_block = { 5, 10, 0 }, .block_w = {
>>>>>>>>> 4, 4, 0 }, .block_h = { 4, 4, 0 },
>>>>>>>>> +          .hsub = 1, .vsub = 1, .is_yuv = true},
>>>>>>>>>              { .format = DRM_FORMAT_P210,        .depth = 0,
>>>>>>>>>                .num_planes = 2, .char_per_block = { 2, 4, 0 },
>>>>>>>>>                .block_w = { 1, 0, 0 }, .block_h = { 1, 0,
>>>>>>>>> 0 }, .hsub = 2,
>>>>>>>>> diff --git a/include/uapi/drm/drm_fourcc.h
>>>>>>>>> b/include/uapi/drm/drm_fourcc.h
>>>>>>>>> index 3feeaa3..08e2221 100644
>>>>>>>>> --- a/include/uapi/drm/drm_fourcc.h
>>>>>>>>> +++ b/include/uapi/drm/drm_fourcc.h
>>>>>>>>> @@ -238,6 +238,20 @@ extern "C" {
>>>>>>>>>      #define DRM_FORMAT_NV42        fourcc_code('N', 'V',
>>>>>>>>> '4', '2') /* non-subsampled Cb:Cr plane */
>>>>>>>>>         /*
>>>>>>>>> + * 2 plane YCbCr
>>>>>>>>> + * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
>>>>>>>>> + * index 1 = Cb:Cr plane,
>>>>>>>>> Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
>>>>>>>>> + * or
>>>>>>>>> + * index 1 = Cr:Cb plane,
>>>>>>>>> Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
>>>>>>>> So now you're defining it as some kind of byte aligned block.
>>>>>>>> With that specifying endianness would now make sense since
>>>>>>>> otherwise this tells us absolutely nothing about the memory
>>>>>>>> layout.
>>>>>>>>
>>>>>>>> So I'd either do that, or go back to not specifying anything and
>>>>>>>> use some weasel words like "mamory layout is implementation defined"
>>>>>>>> which of course means no one can use it for anything that involves
>>>>>>>> any kind of cross vendor stuff.
>>>>>>> /*
>>>>>>>      * 2 plane YCbCr
>>>>>>>      * index 0 = Y plane, [39: 0] Y3:Y2:Y1:Y0 10:10:10:10 little endian
>>>>>>>      * index 1 = Cb:Cr plane, [79: 0] Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0
>>>>>>> 10:10:10:10:10:10:10:10  little endian
>>>>>>>      * or
>>>>>>>      * index 1 = Cr:Cb plane, [79: 0] Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0
>>>>>>> 10:10:10:10:10:10:10:10  little endian
>>>>>>>      */
>>>>>>>
>>>>>>> Is this description ok?
>>>>>> Seems OK to me, if it actually describes the format correctly.
>>>>>>
>>>>>> Though I'm not sure why the CbCr is defines as an 80bit block
>>>>>> and Y has a 40bit block. 40bits should be enough for CbCr as well.
>>>>>>
>>>>> well, this is taken into account yuv444,  4 y point corresponding with 4
>>>>> uv point.
>>>>>
>>>>> if only describes the layout memory, here can change to 40bit block.
>>>>>
>>>>> thanks.
>>>>>
>>>>>>>>> + */
>>>>>>>>> +#define DRM_FORMAT_NV12_10    fourcc_code('N', 'A',
>>>>>>>>> '1', '2') /* 2x2 subsampled Cr:Cb plane */
>>>>>>>>> +#define DRM_FORMAT_NV21_10    fourcc_code('N', 'A',
>>>>>>>>> '2', '1') /* 2x2 subsampled Cb:Cr plane */
>>>>>>>>> +#define DRM_FORMAT_NV16_10    fourcc_code('N', 'A',
>>>>>>>>> '1', '6') /* 2x1 subsampled Cr:Cb plane */
>>>>>>>>> +#define DRM_FORMAT_NV61_10    fourcc_code('N', 'A',
>>>>>>>>> '6', '1') /* 2x1 subsampled Cb:Cr plane */
>>>>>>>>> +#define DRM_FORMAT_NV24_10    fourcc_code('N', 'A',
>>>>>>>>> '2', '4') /* non-subsampled Cr:Cb plane */
>>>>>>>>> +#define DRM_FORMAT_NV42_10    fourcc_code('N', 'A',
>>>>>>>>> '4', '2') /* non-subsampled Cb:Cr plane */
>>>>>>>>> +
>>>>>>>>> +/*
>>>>>>>>>       * 2 plane YCbCr MSB aligned
>>>>>>>>>       * index 0 = Y plane, [15:0] Y:x [10:6] little endian
>>>>>>>>>       * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x
>>>>>>>>> [10:6:10:6] little endian
>>>>>>>>> -- 
>>>>>>>>> 2.7.4
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> _______________________________________________
>>>>>>>>> dri-devel mailing list
>>>>>>>>> dri-devel@lists.freedesktop.org
>>>>>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>>>> _______________________________________________
>>>>> dri-devel mailing list
>>>>> dri-devel@lists.freedesktop.org
>>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


