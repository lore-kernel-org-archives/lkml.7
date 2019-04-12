Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF75C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3C20652
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfDLMGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:06:32 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:40618 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726244AbfDLMGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:06:32 -0400
Received: from [IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68] ([IPv6:2001:983:e9a7:1:f507:24ec:6ad2:dc68])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Euwuh0pJZNG8zEuwvhCkHB; Fri, 12 Apr 2019 14:06:29 +0200
Subject: Re: [PATCH 1/3] media: atmel: atmel-isc: limit incoming pixels per
 frame
To:     Eugen.Hristev@microchip.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ksloat@aampglobal.com, mchehab@kernel.org
References: <1555064098-19310-1-git-send-email-eugen.hristev@microchip.com>
 <1555064098-19310-2-git-send-email-eugen.hristev@microchip.com>
 <7978caee-9ae1-a428-af14-34bfa12ad223@xs4all.nl>
 <7461deba-eca0-24cb-f232-3dbade95c297@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <48dc0a0e-85ba-0a77-effe-cb4fc17c74c5@xs4all.nl>
Date:   Fri, 12 Apr 2019 14:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7461deba-eca0-24cb-f232-3dbade95c297@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJaODEbDVMizbd34M+PrzuBzgr6kQ7Qx0ck96VlAYqNXuMk4k2fERgwdoHYYatbjx5oujl3LpNZTjywdVW5ZX47JFqj3NFeG1uiJt+3l+dLeOBMQVd1J
 q+C34sJk9N0hF5llZt3cgkfh2VpyHs9W5LthPGRk13Lz5eGbSdpPzS76W2ex2AnQvbzpI/lClj729xfwl4ZqkJcB5m0vmTv95WzYi8goRsdZCegXxawVCuas
 TwWEYCm0r0cobHdvyJkAEjF0mFTG+j3ayWBvbLDyulgG687V3SOKCDz5oqJVn3QI4yVszYs1k8WekH6QJ2n+ovnCfVb89Cu+8bmSQOuxzE9IGP6mE2ydypYQ
 nE+UXFDDXX5FMUgQArB4vdH0YHySV7xxASERC4+4waUqfRC03PnljPbOGSilvq0Ju9ofD/pX6sFjJkLm9GpSeZR9RBzHSPpKbDA4k+Cq01p9K5pQJUsc3rrq
 WpQ3uNEZT3CbW6j/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/19 2:02 PM, Eugen.Hristev@microchip.com wrote:
> 
> 
> On 12.04.2019 14:50, Hans Verkuil wrote:
> 
>>
>> On 4/12/19 12:19 PM, Eugen.Hristev@microchip.com wrote:
>>> From: Eugen Hristev <eugen.hristev@microchip.com>
>>>
>>> This will limit the incoming pixels per frame from the sensor.
>>> Currently, the ISC will stop sampling the frame only when the vsync/hsync
>>> are detected.
>>> If we misconfigure the resolution in the sensor w.r.t. resolution in the ISC,
>>> the buffer used for DMA in the ISC will be smaller than the number of pixels
>>> that the ISC DMA engine will copy.
>>> In this case it happens that the DMA will overwrite parts of the memory which
>>> should not be written, leading to memory corruption.
>>> To avoid this situation, use the PFE CFG1 and PFE CFG2 registers, which crop
>>> the incoming frame to the resolution that we configure.
>>> This way the DMA engine will never write more data than we expect it to.
>>>
>>> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
>>> ---
>>>   drivers/media/platform/atmel/atmel-isc-regs.h | 19 +++++++++++++++
>>>   drivers/media/platform/atmel/atmel-isc.c      | 34 +++++++++++++++++++++++++++
>>>   2 files changed, 53 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/atmel/atmel-isc-regs.h b/drivers/media/platform/atmel/atmel-isc-regs.h
>>> index 2aadc19..768a5ad 100644
>>> --- a/drivers/media/platform/atmel/atmel-isc-regs.h
>>> +++ b/drivers/media/platform/atmel/atmel-isc-regs.h
>>> @@ -35,6 +35,25 @@
>>>   #define ISC_PFG_CFG0_BPS_TWELVE (0x0 << 28)
>>>   #define ISC_PFE_CFG0_BPS_MASK   GENMASK(30, 28)
>>>   
>>> +#define ISC_PFE_CFG0_COLEN	BIT(12)
>>> +#define ISC_PFE_CFG0_ROWEN	BIT(13)
>>> +
>>> +/* ISC Parallel Front End Configuration 1 Register */
>>> +#define ISC_PFE_CFG1    0x00000010
>>> +
>>> +#define ISC_PFE_CFG1_COLMIN(v)		((v))
>>> +#define ISC_PFE_CFG1_COLMIN_MASK	GENMASK(15, 0)
>>> +#define ISC_PFE_CFG1_COLMAX(v)		((v) << 16)
>>> +#define ISC_PFE_CFG1_COLMAX_MASK	GENMASK(31, 16)
>>> +
>>> +/* ISC Parallel Front End Configuration 2 Register */
>>> +#define ISC_PFE_CFG2    0x00000014
>>> +
>>> +#define ISC_PFE_CFG2_ROWMIN(v)		((v))
>>> +#define ISC_PFE_CFG2_ROWMIN_MASK	GENMASK(15, 0)
>>> +#define ISC_PFE_CFG2_ROWMAX(v)		((v) << 16)
>>> +#define ISC_PFE_CFG2_ROWMAX_MASK	GENMASK(31, 16)
>>> +
>>>   /* ISC Clock Enable Register */
>>>   #define ISC_CLKEN               0x00000018
>>>   
>>> diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
>>> index a10db16..ea7520a 100644
>>> --- a/drivers/media/platform/atmel/atmel-isc.c
>>> +++ b/drivers/media/platform/atmel/atmel-isc.c
>>> @@ -721,6 +721,40 @@ static void isc_start_dma(struct isc_device *isc)
>>>   	u32 sizeimage = isc->fmt.fmt.pix.sizeimage;
>>>   	u32 dctrl_dview;
>>>   	dma_addr_t addr0;
>>> +	u32 h, w;
>>> +
>>> +	h = isc->fmt.fmt.pix.height;
>>> +	w = isc->fmt.fmt.pix.width;
>>> +
>>> +	/*
>>> +	 * In case the sensor is not RAW, it will output a pixel (12-16 bits)
>>> +	 * with two samples on the ISC Data bus (which is 8-12)
>>> +	 * ISC will count each sample, so, we need to multiply these values
>>> +	 * by two, to get the real number of samples for the required pixels.
>>> +	 */
>>> +	if (!ISC_IS_FORMAT_RAW(isc->config.sd_format->mbus_code)) {
>>
>> The ISC_IS_FORMAT_RAW define doesn't exist?!
>>
>> Something clearly went wrong...
>>
>> Regards,
>>
>> 	Hans
> 
> Hello Hans,
> 
> Sorry , I forgot to copy this from the previous series 
> (https://www.spinics.net/lists/linux-media/msg149501.html for reference):
> 
> It applies only on top of my previous patchset:
> media: atmel: atmel-isc: removed ARGB32 added ABGR32 and XBGR32
> media: atmel: atmel-isc: reworked driver and formats
> available at:
> https://git.linuxtv.org/hverkuil/media_tree.git/commit/?h=for-v5.2b&id=03ef1b56cba6ad17f6ead13c85a81e0e80fbc9d1
> 
> So it should work on top of those patches...

Ah, now I see. I'll park this patch series until the pull request containing
those two patches is merged. Feel free to remind me of this series once Mauro
merged that pull request.

Regards,

	Hans

> 
> Eugen
> 
> 
>>
>>
>>> +		h <<= 1;
>>> +		w <<= 1;
>>> +	}
>>> +
>>> +	/*
>>> +	 * We limit the column/row count that the ISC will output according
>>> +	 * to the configured resolution that we want.
>>> +	 * This will avoid the situation where the sensor is misconfigured,
>>> +	 * sending more data, and the ISC will just take it and DMA to memory,
>>> +	 * causing corruption.
>>> +	 */
>>> +	regmap_write(regmap, ISC_PFE_CFG1,
>>> +		     (ISC_PFE_CFG1_COLMIN(0) & ISC_PFE_CFG1_COLMIN_MASK) |
>>> +		     (ISC_PFE_CFG1_COLMAX(w - 1) & ISC_PFE_CFG1_COLMAX_MASK));
>>> +
>>> +	regmap_write(regmap, ISC_PFE_CFG2,
>>> +		     (ISC_PFE_CFG2_ROWMIN(0) & ISC_PFE_CFG2_ROWMIN_MASK) |
>>> +		     (ISC_PFE_CFG2_ROWMAX(h - 1) & ISC_PFE_CFG2_ROWMAX_MASK));
>>> +
>>> +	regmap_update_bits(regmap, ISC_PFE_CFG0,
>>> +			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN,
>>> +			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN);
>>>   
>>>   	addr0 = vb2_dma_contig_plane_dma_addr(&isc->cur_frm->vb.vb2_buf, 0);
>>>   	regmap_write(regmap, ISC_DAD0, addr0);
>>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>

