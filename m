Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B13C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ADD420872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 09:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbfIYJYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 05:24:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:23106 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfIYJXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 05:23:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2019 02:23:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,547,1559545200"; 
   d="scan'208";a="203575205"
Received: from timmpete-desk1.ger.corp.intel.com (HELO [10.252.55.52]) ([10.252.55.52])
  by fmsmga001.fm.intel.com with ESMTP; 25 Sep 2019 02:23:27 -0700
Subject: Re: [PATCH 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
To:     "sandy.huang" <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     heiko@sntech.de, Ayan.Halder@arm.com, linux-kernel@vger.kernel.org
References: <1569398801-92201-1-git-send-email-hjc@rock-chips.com>
 <1569398801-92201-2-git-send-email-hjc@rock-chips.com>
 <8cd915d3-9f61-abdc-7fd1-a9241777f29a@linux.intel.com>
 <e0c272ff-5ef9-f5db-4dad-477ecae2e6ca@rock-chips.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <434dc7ec-5029-4609-f6f3-0766091315ec@linux.intel.com>
Date:   Wed, 25 Sep 2019 11:23:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e0c272ff-5ef9-f5db-4dad-477ecae2e6ca@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 25-09-2019 om 10:32 schreef sandy.huang:
>
> 在 2019/9/25 下午4:17, Maarten Lankhorst 写道:
>> Op 25-09-2019 om 10:06 schreef Sandy Huang:
>>> These new format is supported by some rockchip socs:
>>>
>>> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
>>> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
>>> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
>>>
>>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>>> ---
>>>   drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>>>   include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>>>   2 files changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
>>> index c630064..f25fa81 100644
>>> --- a/drivers/gpu/drm/drm_fourcc.c
>>> +++ b/drivers/gpu/drm/drm_fourcc.c
>>> @@ -274,6 +274,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
>>>           { .format = DRM_FORMAT_YUV420_10BIT,    .depth = 0,
>>>             .num_planes = 1, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>>>             .is_yuv = true },
>>> +        { .format = DRM_FORMAT_NV12_10,        .depth = 0,
>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>>> +          .is_yuv = true },
>>> +        { .format = DRM_FORMAT_NV21_10,        .depth = 0,
>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 2,
>>> +          .is_yuv = true },
>>> +        { .format = DRM_FORMAT_NV16_10,        .depth = 0,
>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
>>> +          .is_yuv = true },
>>> +        { .format = DRM_FORMAT_NV61_10,        .depth = 0,
>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 2, .vsub = 1,
>>> +          .is_yuv = true },
>>> +        { .format = DRM_FORMAT_NV24_10,        .depth = 0,
>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
>>> +          .is_yuv = true },
>>> +        { .format = DRM_FORMAT_NV42_10,        .depth = 0,
>>> +          .num_planes = 2, .cpp = { 0, 0, 0 }, .hsub = 1, .vsub = 1,
>>> +          .is_yuv = true },
>>>       };
>>>         unsigned int i;
>>> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
>>> index 3feeaa3..0479f47 100644
>>> --- a/include/uapi/drm/drm_fourcc.h
>>> +++ b/include/uapi/drm/drm_fourcc.h
>>> @@ -238,6 +238,20 @@ extern "C" {
>>>   #define DRM_FORMAT_NV42        fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>>>     /*
>>> + * 2 plane YCbCr 10bit
>>> + * index 0 = Y plane, [9:0] Y
>>> + * index 1 = Cr:Cb plane, [19:0]
>>> + * or
>>> + * index 1 = Cb:Cr plane, [19:0]
>>> + */
>>> +#define DRM_FORMAT_NV12_10    fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
>>> +#define DRM_FORMAT_NV21_10    fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
>>> +#define DRM_FORMAT_NV16_10    fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
>>> +#define DRM_FORMAT_NV61_10    fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
>>> +#define DRM_FORMAT_NV24_10    fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
>>> +#define DRM_FORMAT_NV42_10    fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
>>> +
>>> +/*
>>>    * 2 plane YCbCr MSB aligned
>>>    * index 0 = Y plane, [15:0] Y:x [10:6] little endian
>>>    * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
>> What are the other bits, they are not mentioned?
>
> It's compact layout
>
> Yplane:
>
>     Y0[9:0]Y1[9:0]Y2[9:0]Y3[9:0]...
>
> UVplane:
>
>     U0[9:0]V0[9:0]U1[9:0]V1[9:0]... 

This should be put in the comment then, for clarity. :) Probably needs 4 pixels to describe how it fits in 5 (or 10 for cbcr) bytes.

Cheers,

Maarten

