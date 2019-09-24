Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250A4C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F2F214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 06:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394455AbfIXGrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 02:47:41 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:49760 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390247AbfIXGrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 02:47:40 -0400
Received: from hjc?rock-chips.com (unknown [192.168.167.138])
        by regular1.263xmail.com (Postfix) with ESMTP id 2CF5E407;
        Tue, 24 Sep 2019 14:47:36 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from [172.16.10.69] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P3195T140584704931584S1569307653531084_;
        Tue, 24 Sep 2019 14:47:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <19d5ccf720f8c557e124fe8852f8d744>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Subject: Re: [PATCH 01/36] drm/fourcc: Add 2 plane YCbCr 10bit format support
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
References: <1569242365-182133-1-git-send-email-hjc@rock-chips.com>
 <1569242365-182133-2-git-send-email-hjc@rock-chips.com>
 <20190923125314.GJ1208@intel.com>
 <82664d48-36de-15fd-3b30-a12907e5bfcd@rock-chips.com>
 <20190923183049.GR1208@intel.com>
From:   "sandy.huang" <hjc@rock-chips.com>
Message-ID: <134414ba-536b-ad8c-8b79-4822bd311ae8@rock-chips.com>
Date:   Tue, 24 Sep 2019 14:47:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923183049.GR1208@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/9/24 上午2:30, Ville Syrjälä 写道:
> On Mon, Sep 23, 2019 at 06:05:22AM -0700, sandy.huang wrote:
>> 在 2019/9/23 上午5:53, Ville Syrjälä 写道:
>>> On Mon, Sep 23, 2019 at 08:38:50PM +0800, Sandy Huang wrote:
>>>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>>>> index 3feeaa3..5fe89e9 100644
>>>> --- a/include/uapi/drm/drm_fourcc.h
>>>> +++ b/include/uapi/drm/drm_fourcc.h
>>>> @@ -266,6 +266,21 @@ extern "C" {
>>>>    #define DRM_FORMAT_P016		fourcc_code('P', '0', '1', '6') /* 2x2 subsampled Cr:Cb plane 16 bits per channel */
>>>>    
>>>>    /*
>>>> + * 2 plane YCbCr 10bit
>>>> + * index 0 = Y plane, [9:0] Y
>>>> + * index 1 = Cr:Cb plane, [19:0] Cr:Cb little endian
>>>> + * or
>>>> + * index 1 = Cb:Cr plane, [19:0] Cb:Cr little endian
>>> What does "little endian" even mean for these?
>> It's Inherited from the following define, the difference is 8bit and 10bit.
>> /*
>>    * 2 plane YCbCr
>>    * index 0 = Y plane, [7:0] Y
>>    * index 1 = Cr:Cb plane, [15:0] Cr:Cb little endian
>>    * or
>>    * index 1 = Cb:Cr plane, [15:0] Cb:Cr little endian
>>    */
>> #define DRM_FORMAT_NV12        fourcc_code('N', 'V', '1', '2') /* 2x2
>> subsampled Cr:Cb plane */
>> #define DRM_FORMAT_NV21        fourcc_code('N', 'V', '2', '1') /* 2x2
>> subsampled Cb:Cr plane */
>> #define DRM_FORMAT_NV16        fourcc_code('N', 'V', '1', '6') /* 2x1
>> subsampled Cr:Cb plane */
>> #define DRM_FORMAT_NV61        fourcc_code('N', 'V', '6', '1') /* 2x1
>> subsampled Cb:Cr plane */
>> #define DRM_FORMAT_NV24        fourcc_code('N', 'V', '2', '4') /*
>> non-subsampled Cr:Cb plane */
>> #define DRM_FORMAT_NV42        fourcc_code('N', 'V', '4',
> Something not aligned to bytes can't have its endianness defined the
> same way as these. Just doesn't make sense.


Get it ,thanks.

>>
>>
>>>> + */
>>>> +
>>>> +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
>>>> +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
>>>> +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
>>>> +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
>>>> +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
>>>> +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
>>>> +
>>>> +/*
>>>>     * 3 plane YCbCr
>>>>     * index 0: Y plane, [7:0] Y
>>>>     * index 1: Cb plane, [7:0] Cb
>>>> -- 
>>>> 2.7.4
>>>>
>>>>
>>>>
>>>> _______________________________________________
>>>> dri-devel mailing list
>>>> dri-devel@lists.freedesktop.org
>>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel


