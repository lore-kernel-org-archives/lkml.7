Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B2C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353ED2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403985AbfIYLB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:01:59 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:43720 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfIYLB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:01:58 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.206])
        by regular1.263xmail.com (Postfix) with ESMTP id 724E839F;
        Wed, 25 Sep 2019 19:01:46 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.10.69] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P28189T140160207415040S1569409303280888_;
        Wed, 25 Sep 2019 19:01:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f6fb2099e410f931f416b4a03bb97f8e>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     heiko@sntech.de, Ayan.Halder@arm.com, linux-kernel@vger.kernel.org
References: <1569398801-92201-1-git-send-email-hjc@rock-chips.com>
 <1569398801-92201-2-git-send-email-hjc@rock-chips.com>
 <8cd915d3-9f61-abdc-7fd1-a9241777f29a@linux.intel.com>
 <e0c272ff-5ef9-f5db-4dad-477ecae2e6ca@rock-chips.com>
 <434dc7ec-5029-4609-f6f3-0766091315ec@linux.intel.com>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <406cb41b-1840-df9d-a893-8ab9da8d6f4f@rock-chips.com>
Date:   Wed, 25 Sep 2019 19:01:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <434dc7ec-5029-4609-f6f3-0766091315ec@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/9/25 下午5:23, Maarten Lankhorst 写道:
> Op 25-09-2019 om 10:32 schreef sandy.huang:
>> 在 2019/9/25 下午4:17, Maarten Lankhorst 写道:
>>> Op 25-09-2019 om 10:06 schreef Sandy Huang:
>>>> These new format is supported by some rockchip socs:
>>>>
>>>> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
>>>> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
>>>> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
>>>>
>>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>>>> ---
>>>>    drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>>>>    include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>>>>    2 files changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
>>>> index c630064..f25fa81 100644
>>>> --- a/drivers/gpu/drm/drm_fourcc.c
>>>> +++ b/drivers/gpu/drm/drm_fourcc.c
>>>> @@ -274,6 +274,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
>>>>            { .format = DRM_FORMAT_YUV420_10BIT,    .depth = 0,
>>>>              .num_planes = 1, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>>>>              .is_yuv = true },
>>>> +        { .format = DRM_FORMAT_NV12_10,        .depth = 0,
>>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>>>> +          .is_yuv = true },
>>>> +        { .format = DRM_FORMAT_NV21_10,        .depth = 0,
>>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>>>> +          .is_yuv = true },
>>>> +        { .format = DRM_FORMAT_NV16_10,        .depth = 0,
>>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
>>>> +          .is_yuv = true },
>>>> +        { .format = DRM_FORMAT_NV61_10,        .depth = 0,
>>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
>>>> +          .is_yuv = true },
>>>> +        { .format = DRM_FORMAT_NV24_10,        .depth = 0,
>>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
>>>> +          .is_yuv = true },
>>>> +        { .format = DRM_FORMAT_NV42_10,        .depth = 0,
>>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
>>>> +          .is_yuv = true },
>>>>        };
>>>>          unsigned int i;
>>>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>>>> index 3feeaa3..0479f47 100644
>>>> --- a/include/uapi/drm/drm_fourcc.h
>>>> +++ b/include/uapi/drm/drm_fourcc.h
>>>> @@ -238,6 +238,20 @@ extern "C" {
>>>>    #define DRM_FORMAT_NV42        fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>>>>      /*
>>>> + * 2 plane YCbCr 10bit
>>>> + * index 0 = Y plane, [9:0] Y
>>>> + * index 1 = Cr:Cb plane, [19:0]
>>>> + * or
>>>> + * index 1 = Cb:Cr plane, [19:0]
>>>> + */
>>>> +#define DRM_FORMAT_NV12_10    fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
>>>> +#define DRM_FORMAT_NV21_10    fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
>>>> +#define DRM_FORMAT_NV16_10    fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
>>>> +#define DRM_FORMAT_NV61_10    fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
>>>> +#define DRM_FORMAT_NV24_10    fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
>>>> +#define DRM_FORMAT_NV42_10    fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
>>>> +
>>>> +/*
>>>>     * 2 plane YCbCr MSB aligned
>>>>     * index 0 = Y plane, [15:0] Y:x [10:6] little endian
>>>>     * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
>>> What are the other bits, they are not mentioned?
>> It's compact layout
>>
>> Yplane:
>>
>>      Y0[9:0]Y1[9:0]Y2[9:0]Y3[9:0]...
>>
>> UVplane:
>>
>>      U0[9:0]V0[9:0]U1[9:0]V1[9:0]...
> This should be put in the comment then, for clarity. :) Probably needs 4 pixels to describe how it fits in 5 (or 10 for cbcr) bytes.
>
> Cheers,
>
> Maarten
OK, I will add this describe at next version.
>
>
>


