Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC17C32750
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E11B20665
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 02:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="R7jCaTzb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AkOAm0lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGaCBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 22:01:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45575 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727193AbfGaCBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 22:01:34 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 90E80210DB;
        Tue, 30 Jul 2019 22:01:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 22:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        subject:to:references:from:cc:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=e
        YscAWkB/qrgQzoBMXcJcwLMudz5jhXM+fiNx2V3qP4=; b=R7jCaTzba5AnhfSL7
        DEzY8YJtypcdjyYbp3a+tFWB4x0w7H98vQo/v2WvSFSipQCNEfKyOl568/QTid2S
        jDuoDkzn40YVfKZ8qg92GJ429OlImv6PrIoptOBouuir2xiZnywDbNoaSQ+6metO
        s0HgvVo3YoIgmaXXI+KFJKc2eYijktjULlree7GOmFk5gY3qVF0ccfPyNfLFYhLZ
        /iexTq4kNZ97/v33uffVLfbAkH1SBItq1g5tLizNuduq8TB4ORQvkS6q1v1wzwTj
        IuZOZRz6dy0CI9pkLGdccd6/DFvlop0tGyTz4uOQbNOE187agStfWVLFkV43j8TH
        xUhoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=eYscAWkB/qrgQzoBMXcJcwLMudz5jhXM+fiNx2V3q
        P4=; b=AkOAm0lLfS7AWDtXYeuTkyOwMFkOZYELU79P59r/tQex73mHoOnZM8q3N
        ntkQlD3nw4dVptN3kDuZpN+afgP1ji8hFyhqxnUXOA9zs24pdFTN6d+RjNP5lqFz
        Rtb61+l/q8hLdBh+O8mu9nQAKfiGd1HAunpFp6agwaDee5uS1uKJZEYF4jaYM5TJ
        Jk3UwG49Ar2gBTDxMp2bemSHaJt2kj2uFTmqGOw9CKlwdY/SmAUMY5AQc74XXalY
        oUHcQ8mowmKOQ4wyYR/Gk3kiJ4k7dVw9CvLJJ+b83+dyAUvKBtCwbqeWvqL6V0hk
        1BivNvujQy/9LOVg22KcnWEPMUMQg==
X-ME-Sender: <xms:e_ZAXWY6f_BFeXSc8DhFanKCdivfQy-ifMvdQWfSLUTCfgeCtl6qqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeflrghnpgfu
    vggsrghsthhirghnpgfinphtthgvuceolhhinhhugiesjhgrshgvghdrnhgvtheqnecuff
    homhgrihhnpehgihhthhhusgdrtghomhdphihouhhtuhgsvgdrtghomhenucfkphepiedt
    rdejuddrieefrdejheenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugiesjhgrsh
    gvghdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:e_ZAXe6gSknMk5vcH2f6J20lZjFFcfyCgLYZCZBzd2GVf4Wuup0oUA>
    <xmx:e_ZAXZTw3mK0iri-wMF1QT4CkMP_Hs_TknrkIvvYEGwHWX0cwHVdjQ>
    <xmx:e_ZAXWsmOCHVMRsiw6Nc996DYW5IWyWefOAadDipJL5qQ0cAhMw-_g>
    <xmx:fPZAXYlTdChQ5zID2zrGiCzw-RQ_nNwoahx_9YJ1vKxl0FLaJAD04g>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F00E8005A;
        Tue, 30 Jul 2019 22:01:30 -0400 (EDT)
Subject: Re: [PATCH 5/6] drm: uapi: add gdepaper uapi header
To:     Emil Velikov <emil.l.velikov@gmail.com>
References: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
 <0e22c86a-3998-c2fd-cb14-203df547eb5c@jaseg.net>
 <20190730140852.GB12424@arch-x1c3>
 <52212fa4-e396-29c4-e5d2-07fbb371c302@jaseg.net>
 <20190730164926.GD14551@arch-x1c3>
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <fa70f88e-6c18-26fb-83c0-18528acb12ce@jaseg.net>
Date:   Wed, 31 Jul 2019 11:01:27 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190730164926.GD14551@arch-x1c3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/19 1:49 AM, Emil Velikov wrote:
> On 2019/07/31, Jan Sebastian Götte wrote:
>> Hi Emil,
>>
>> thank you for your comments.
>>
>> On 7/30/19 11:08 PM, Emil Velikov wrote:
>>> On 2019/07/30, Jan Sebastian Götte wrote:
>>>> Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
>>>> ---
>>>>  include/uapi/drm/gdepaper_drm.h | 62 +++++++++++++++++++++++++++++++++
>>>>  1 file changed, 62 insertions(+)
>>>>  create mode 100644 include/uapi/drm/gdepaper_drm.h
>>>>
>>>> diff --git a/include/uapi/drm/gdepaper_drm.h b/include/uapi/drm/gdepaper_drm.h
>>>> new file mode 100644
>>>> index 000000000000..84ff6429bef5
>>>> --- /dev/null
>>>> +++ b/include/uapi/drm/gdepaper_drm.h
>>>> @@ -0,0 +1,62 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>>>> +/* gdepaper_drm.h
>>>> + *
>>>> + * Copyright (c) 2019 Jan Sebastian Götte
>>>> + */
>>>> +
>>> I'm glad to see more devices using upstream KMS interface. Usually
>>> custom UAPI should not be needed for such devices.
>>>
>>> Can you elaborate why this is required? Is there an open-source
>>> userspace that uses these?
>>
>> Not yet. I added this API because I couldn't figure out a way to do that in KMS. What I need is some way for userspace to tell the driver parameters for the display refresh (driving waveforms, refresh speed etc.) on a frame-by-frame basis. These parameters depend on ambient temperature and the displayed content. One has to trade off speed, ghosting and the number of possible partial refreshes until next full one.
>>
>> Usually, epaper display refresh all pixels at once like an LCD would. This takes about 15s of flickering for b/w/red displays. Since they're bistable, they can also only physically refresh part of the area though. The reason for not having that on-by-default is that epaper partial refresh is really tricky. If you refresh the same area partially a few times, charge builds up, image quality degrades and the picture starts bleeding. If you refresh the same area partially all the time and don't do enough full refresh cycles to balance charges again, eventually the display is going to get permanent burn-in. I think partial refresh should be supported by a driver like this since it's a good tool to alleviate the enormous full refresh times.
>>
>> For partial hardware refresh you have to customize all these values and the waveform LUTs depending on the displayed content. For example you might want a LUT specifying more inversion cycles for text display to reduce ghosting, or one with less cycles but higher voltages for some spinning loading animation to reduce flickering. If you are displaying a loading bar you might be able to get away with a high drive strength since you know it's going to be done in a few frames, but if you display e.g. a text console you might want to reduce drive strength to do as many partial updates as possible before the next full refresh, to reduce flicker. 
>>
>> I think what one would like to do from userspace here is along the lines of:
>> * set voltages depending on content
>> * set waveforms depending on content
>> * write framebuffer
>> * (optional) trigger partial refresh of affected areas
>>
>> You can get the display up and running with some default values and the factory-programmed OTP LUTs using full hardware refresh, but if you try partial hardware refresh with those you get a irrecognizable mess.
>>
>>>> +#ifndef _UAPI_GDEPAPER_DRM_H_
>>>> +#define _UAPI_GDEPAPER_DRM_H_
>>>> +
>>>> +#include "drm.h"
>>>> +
>>>> +#if defined(__cplusplus)
>>>> +extern "C" {
>>>> +#endif
>>>> +
>>>> +enum drm_gdepaper_vghl_lv {
>>>> +	DRM_GDEP_PWR_VGHL_16V = 0,
>>>> +	DRM_GDEP_PWR_VGHL_15V = 1,
>>>> +	DRM_GDEP_PWR_VGHL_14V = 2,
>>>> +	DRM_GDEP_PWR_VGHL_13V = 3,
>>>> +};
>>>> +
>>>> +struct gdepaper_refresh_params {
>>>> +	enum drm_gdepaper_vghl_lv vg_lv; /* gate voltage level */
>>> From my experience, kernel drivers aim to avoid exposing voltage control
>>> to userspace. AFAICT exceptions are present, but generally it's a no-go
>> I agree with that. FWIW, in this draft these properties are exposed through a DRM_ROOT_ONLY ioctl.
>>
>>>> +	__u32 vcom_sel; /* VCOM select bit according to datasheet */
>>>> +	__s32 vdh_bw_mv; /* drive high level, b/w pixel (mV) */
>>>> +	__s32 vdh_col_mv; /* drive high level, red/yellow pixel (mV) */
>>>> +	__s32 vdl_mv; /* drive low level (mV) */
>>>> +	__s32 vcom_dc_mv;
>>>> +	__u32 vcom_data_ivl_hsync; /* data ivl len in hsync periods */
>>>> +	__u32 border_data_sel; /* "vbd" in datasheet */
>>>> +	__u32 data_polarity; /* "ddx" in datasheet */
>>> These properties look like they should live in the device-tree bindings.
>>
>> On init they are loaded from dt, but they can be overwritten via ioctl. This would be necessary for anything using the display's partial hardware refresh feature and might change frame-by-frame.
>>
>>>> +	__u32 use_otp_luts_flag; /* Use OTP LUTs */
>>>> +	__u8 lut_vcom_dc[44];
>>>> +	__u8 lut_ww[42];
>>>> +	__u8 lut_bw[42];
>>>> +	__u8 lut_bb[42];
>>>> +	__u8 lut_wb[42];
>>> There is UAPI to manage LUT (or was it WIP with patches on the list) via
>>> the atomic API. Is that not flexible enough for your needs?
>>
>> I had a look around, and I found something in uapi/drm/drm_mode.h for color LUTs. This isn't color LUTs though. The vendor should really have called them "waveform tables". They basically contain a list of voltage levels a pixel transitioning white-black, white-red etc. should be driven at. The format seems to be standardized across different driver chips, but I'd really treat them as device-dependent binary blobs since for some chips they're not even specified and there's no guarantee the format won't suddenly change for some new chip.
>>
>>>> +};
>>>> +
>>>> +/* Force a full display refresh */
>>>> +#define DRM_GDEPAPER_FORCE_FULL_REFRESH		0x00
>>>> +#define DRM_GDEPAPER_GET_REFRESH_PARAMS		0x01
>>>> +#define DRM_GDEPAPER_SET_REFRESH_PARAMS		0x02
>>>> +#define DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN	0x03
>>>> +
>>>> +#define DRM_IOCTL_GDEPAPER_FORCE_FULL_REFRESH \
>>>> +	DRM_IO(DRM_COMMAND_BASE + DRM_GDEPAPER_FORCE_FULL_REFRESH)
>>>> +#define DRM_IOCTL_GDEPAPER_GET_REFRESH_PARAMS \
>>>> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_GET_REFRESH_PARAMS, \
>>>> +	struct gdepaper_refresh_params)
>>>> +#define DRM_IOCTL_GDEPAPER_SET_REFRESH_PARAMS \
>>>> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_REFRESH_PARAMS, \
>>>> +	struct gdepaper_refresh_params)
>>>> +#define DRM_IOCTL_GDEPAPER_SET_PARTIAL_UPDATE_EN \
>>>> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN, __u32)
>>>> +
>>> Similarly to the LUT above, the atomic UAPI has support for partial
>>> updates. The property is called FB_DAMAGE_CLIPS and there is an example
>>> in weston how to use it see 009b3cfa6f16bb361eb54efcc7435bfede4524bc.
>>
>> I do already have support for that. The partial_update_en flag here controls whether the partial hardware refresh is used to implement that. The force_full_refresh thing would be useful to do the periodic (every 10hrs) refresh required by the display's specs without having to re-render the content.
>>
> Correct me if I'm wrong, so it sounds like at least the full refresh is
> a decision that can and should in the kernel? After all we don't need
> an ioctl if it's a trivial "wait 10h, full refresh".

I think I might remove this then, and instead have a timeout on updates. If userspace doesn't update for x hours, kernel forces a refresh. Then, userspace can still manage this if necessary with a full redraw.

> With regards to the other properties, what heuristic are you using to
> adjust the parameters? Perhaps it's better to expose the decision itself
> to the kernel module?

I think my problem is I don't have a heuristic yet. I think you'd use something like [0] here. My issue putting that into kernel is that I don't understand it well enough to be confident this is all anybody would ever need.

> This way, the kernel can change voltages and perform sanity checks (rate
> limit, temperature, etc.) instead of "blindly" damaging the hardware.

I wouldn't know how to come up with safe boundaries for such checks. The vendor's datasheets are not much of a help. They basically say "don't deviate from our defaults for too long", but then there's others[1] who totally do deviate without a problem. The built-in hardware limits seem to be sensible. This patch configures both the b/w high drive voltage and the b/w/r low drive voltage to maximums (+/-11.0V) according to an example from the vendor, and it's working fine.

Maybe a way to go at this would be to have a set of parameter presets in dt along with limits (full refresh at least every x seconds, full refresh at least every x partial refreshes, etc.), and allow userspace to select one of these presets using a drm property? This way it can still be configured but and it doesn't need any ioctls.

- Jan

[0] https://github.com/zkarcher/FancyEPD/blob/master/FancyEPD_Demo/FancyEPD.cpp#L900
[1] https://www.youtube.com/watch?v=MsbiO8EAsGw
