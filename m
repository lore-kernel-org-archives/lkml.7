Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3372176F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 23:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNfEePHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731059AbfDPX7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:59:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37585 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDPX7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 19:59:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id v14so1200647wmf.2;
        Tue, 16 Apr 2019 16:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=mutIkyEqeNW2ETXLLgh8LdG/MooWOc9qQtfVHC3xpt4=;
        b=aNfEePHlKmyK0Nl38HLolxAl6X3/DEnr4a1hPGSBjrOM4H1o7zIADpoT40OIKmtGo3
         7UZNmWKyy6KMZBs5A5wHIteHFsTrkQO0Xz08MTr3EgHwZW5/miLtVeAUpS/1aIF31DX9
         KkVv8dp/RNlLEcjia98zyy2va4eYx16bfUvT32c5nRfAuWpjZE9dOhXcP4zHDBtis7zt
         7FGamj1wjvo0jsZuI9lbGhEVAnZQVgMs3gBxoKO5bktHoCSoy6AisYsm1ryFN1yFVLKi
         qrwNXZqjTsJ93IX68AKPWHKU+EYgBkx8mS4oHvRENLN3mXe4nxJHGyPZEzS7qfJtujUR
         MbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=mutIkyEqeNW2ETXLLgh8LdG/MooWOc9qQtfVHC3xpt4=;
        b=KzCSnVkIgDXeAI1BHY9aDV+NuN6W8lVPq5LG4CWFJjxm60Ya4hsKpbeWrIvhWUfhce
         iMq+KvEK3EO0GX/Zgrlhmni+dfjeWuiiGy7JhH50Ww7uxhdAXit6fWBxO5qg/m3FpU5G
         zSo45WqmIntn7Uph6iBcxOr6qJBu6NWEZGCHZ2QHZ0Whb2QIWSgiTinGUtS9fMMiI6SQ
         zB8iqGSDMJKXzjgE3K86DJSM4wP/a1Tj1T8O5ev2HUEeyEGf+bOYf5wyQnIP2k1+CpIF
         uFcnX3sm3fLiqhqEJvnK2oTD16QlwI4iaLJcW0w+coGoQck7vDsRJAX0PlRj/Ckzc9tP
         UmCQ==
X-Gm-Message-State: APjAAAVkYCxEm2sWYjJ/x1ve6XONuek0qU6xbo3W+0jxRHmuYmaMzwjb
        2Eow2iBGNlDhCVK+vyZYbHapbTuR
X-Google-Smtp-Source: APXvYqxBf7dCKNkwiIFh/QTmJNtUQSqM4pAhNBcCZar8gG6vgUh5QX7fFlcZmtIVrhAdVOI6yZm61g==
X-Received: by 2002:a1c:1d4:: with SMTP id 203mr30048165wmb.101.1555459184889;
        Tue, 16 Apr 2019 16:59:44 -0700 (PDT)
Received: from [172.30.89.52] (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id 4sm707732wmi.14.2019.04.16.16.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:59:44 -0700 (PDT)
Subject: Re: [RFC PATCH] media: rcar-csi2: Fix field detection
To:     =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     linux-media@vger.kernel.org, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Michael Rodin <mrodin@de.adit-jv.com>,
        Eugen Friedrich <efriedrich@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "open list:MEDIA DRIVERS FOR RENESAS - VIN" 
        <linux-renesas-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190416233807.20213-1-slongerbeam@gmail.com>
 <20190416235018.GJ28515@bigcity.dyn.berto.se>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <de946538-c958-1694-9e28-e2ab5d6fd997@gmail.com>
Date:   Tue, 16 Apr 2019 16:59:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416235018.GJ28515@bigcity.dyn.berto.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 4/16/19 4:50 PM, Niklas Söderlund wrote:
> Hi Steve,
>
> Thanks for your work.
>
> I upported most rcar-csi2 patches but a few of them are still pending,
> an alternating version based on this BSP patch is already on its way.
>
> https://patchwork.linuxtv.org/patch/55623/

Great, that patch confirms that FLD_NUM should be set to 0 or 1 when 
setting FLD_DET_SEL = 0x01.

But your patch has it inverted. NTSC should be FLD_NUM=1, PAL should be 
FLD_NUM=0. Can you please confirm that after reading the commit 
description of my RFC patch.


> As a general feedback calling v4l2_subdev_call() for g_std is not the
> best way to handle this problem in a MC centric driver. There is a
> discussion about in in earlier versions of the patch mentioned above.

Ok, yes that's true. I borrowed that code from rcar-3.9.0 BSP, but the 
important thing is to get the above right and confirmed.

Steve

>
> On 2019-04-16 16:38:07 -0700, Steve Longerbeam wrote:
>> The RCAR Gen3 hardware manual doesn't mention that the "Word Count" field
>> in the MIPI CSI-2 Frame Start packet is really the frame number. FS packets
>> are short packets, and short packets do not have a WC but rather a 16-bit
>> data field, and for Frame synchronization packets (FS/FE) the 16-bit data
>> field contains a frame number.
>>
>> Here is a reprinting from the MIPI CSI-2 specification, version 2
>> (section 9.1.2 Low Level Protocol Short Packet Format):
>>
>> "Figure 42 and Figure 43 show the Low Level Protocol Short Packet
>> structures for the D-PHY and C-PHY physical layer options, respectively.
>> For each option, the Short Packet structure matches the Packet Header of
>> the corresponding Low Level Protocol Long Packet structure with the
>> exception that the Packet Header Word Count (WC) field shall be replaced
>> by the Short Packet Data Field...For Frame Synchronization Data Types
>> the Short Packet Data Field shall be the frame number..."
>>
>> Also in section 9.8.1 Frame Synchronization Packets, the CSI-2 spec reads:
>>
>> "The behavior of the 16-bit frame number shall be as one of the following
>> - Frame number is always zero – frame number is inoperative.
>> - Frame number increments by 1 for every FS packet with the same Virtual
>>    Channel and is periodically reset to one e.g. 1, 2, 1, 2, 1, 2, 1, 2 or
>>    1, 2, 3, 4, 1, 2, 3, 4"
>>
>> So from the above, FLD_NUM in the FLD register matches against the
>> frame number transmitted by the CSI-2 source in the Frame Start Packet,
>> and goes as "1,2,1,2,1,2" or "1,2,3,4,...,1,2,3,4". If there is a match,
>> the RCAR CSI-2 receiver declares the field as the even, e.g. the BOTTOM,
>> field.
>>
>> NTSC transmits bottom/even field first, and PAL and HD transmit top/odd
>> field first. So fields with a frame number 1 in the CSI-2 Frame Start
>> Packet are bottom/even fields for NTSC, and frame number 2 are bottom/even
>> fields for PAL/HD.
>>
>> But the above assumes the transmitting CSI-2 sensor is sending frame
>> numbers in the sequence "1,2,1,2,...". But according to the CSI-2 spec,
>> sensors are also allowed to send frame numbers that simply increment as
>> in "1,2,3,4,...". To generalize to catch those cases, set FLD_DET_SEL
>> to 0x01, which according to the RCAR Gen3 hardware manual means "the
>> field is detected as the EVEN field when FLD_NUM[0] matches WC[0]".
>> Then, the even/bottom fields have odd frame numbers for NTSC, and even
>> frame numbers for PAL (this patch assumes HDMI sources will not
>> implement .g_std(), so std will be 0 in that case).
>>
>> Finally, set the FLD register to non-zero value only if trnsmitter is
>> sending ALTERNATE fields.
>>
>> Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
>> ---
>>   drivers/media/platform/rcar-vin/rcar-csi2.c | 37 ++++++++++++++++++---
>>   1 file changed, 32 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
>> index a438ec2c218f..c5bee20d7907 100644
>> --- a/drivers/media/platform/rcar-vin/rcar-csi2.c
>> +++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
>> @@ -67,6 +67,7 @@ struct rcar_csi2;
>>   /* Field Detection Control */
>>   #define FLD_REG				0x1c
>>   #define FLD_FLD_NUM(n)			(((n) & 0xff) << 16)
>> +#define FLD_FLD_DET_SEL(n)		(((n) & 0x3) << 4)
>>   #define FLD_FLD_EN4			BIT(3)
>>   #define FLD_FLD_EN3			BIT(2)
>>   #define FLD_FLD_EN2			BIT(1)
>> @@ -462,10 +463,11 @@ static int rcsi2_calc_mbps(struct rcar_csi2 *priv, unsigned int bpp)
>>   	return mbps;
>>   }
>>   
>> -static int rcsi2_start(struct rcar_csi2 *priv)
>> +static int rcsi2_start(struct rcar_csi2 *priv, struct v4l2_subdev *nextsd)
>>   {
>>   	const struct rcar_csi2_format *format;
>> -	u32 phycnt, vcdt = 0, vcdt2 = 0;
>> +	u32 phycnt, vcdt = 0, vcdt2 = 0, fld = 0;
>> +	v4l2_std_id std = 0;
>>   	unsigned int i;
>>   	int mbps, ret;
>>   
>> @@ -476,6 +478,10 @@ static int rcsi2_start(struct rcar_csi2 *priv)
>>   	/* Code is validated in set_fmt. */
>>   	format = rcsi2_code_to_fmt(priv->mf.code);
>>   
>> +	ret = v4l2_subdev_call(nextsd, video, g_std, &std);
>> +	if (ret < 0 && ret != -ENOIOCTLCMD && ret != -ENODEV)
>> +		return ret;
>> +
>>   	/*
>>   	 * Enable all supported CSI-2 channels with virtual channel and
>>   	 * data type matching.
>> @@ -509,9 +515,30 @@ static int rcsi2_start(struct rcar_csi2 *priv)
>>   	rcsi2_reset(priv);
>>   	rcsi2_write(priv, PHTC_REG, 0);
>>   
>> +	/*
>> +	 * NTSC standard transmits even/bottom field first, then odd/top.
>> +	 * PAL standard and interlaced HD transmit odd/top field first,
>> +	 * then even/bottom.
>> +	 *
>> +	 * For CSI-2 sensors that transmit frame numbers (in the CSI-2
>> +	 * Frame Start packet) as "1,2,1,2,..." or "1,2,3,4,5,...", then:
>> +	 *
>> +	 * - for NTSC, the even/bottom fields have odd frame numbers.
>> +	 * - for PAL and HD, the even/bottom fields have even frame numbers.
>> +	 */
>> +	if (priv->mf.field == V4L2_FIELD_ALTERNATE) {
>> +		fld = FLD_FLD_DET_SEL(1) | FLD_FLD_EN4 | FLD_FLD_EN3 |
>> +			FLD_FLD_EN2 | FLD_FLD_EN;
>> +
>> +		if (std & V4L2_STD_525_60)
>> +			fld |= FLD_FLD_NUM(1); /* NTSC */
>> +		else
>> +			fld |= FLD_FLD_NUM(0); /* PAL or HD */
>> +	}
>> +
>>   	/* Configure */
>> -	rcsi2_write(priv, FLD_REG, FLD_FLD_NUM(2) | FLD_FLD_EN4 |
>> -		    FLD_FLD_EN3 | FLD_FLD_EN2 | FLD_FLD_EN);
>> +	rcsi2_write(priv, FLD_REG, fld);
>> +
>>   	rcsi2_write(priv, VCDT_REG, vcdt);
>>   	if (vcdt2)
>>   		rcsi2_write(priv, VCDT2_REG, vcdt2);
>> @@ -591,7 +618,7 @@ static int rcsi2_s_stream(struct v4l2_subdev *sd, int enable)
>>   	if (enable && priv->stream_count == 0) {
>>   		pm_runtime_get_sync(priv->dev);
>>   
>> -		ret = rcsi2_start(priv);
>> +		ret = rcsi2_start(priv, nextsd);
>>   		if (ret) {
>>   			pm_runtime_put(priv->dev);
>>   			goto out;
>> -- 
>> 2.17.1
>>

