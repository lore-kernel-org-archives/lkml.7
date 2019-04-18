Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1499C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905D4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ow9ytdFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfDRRZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:25:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45461 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDRRZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:25:47 -0400
Received: by mail-ed1-f68.google.com with SMTP id k92so2417021edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RU2FXYzCGCDBScxgS+TFDBX9ycMEvmJdg5CleRVF5GI=;
        b=Ow9ytdFGdKyNNF+/99qcVyraOekBhXm2OUdKaq+LCyGan6Ozr62AN6bAqVk9r0jS9T
         Hiah3dPf/Zh7Kdc0CfWVKPili8YY/PQWHc02H1cQSty9MRnJoLpZ44+H79hAdZnVCTZF
         V52C0i9vSjBUJ0/zoiFYmJcvnzkKft4Jiqbi0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RU2FXYzCGCDBScxgS+TFDBX9ycMEvmJdg5CleRVF5GI=;
        b=MJI1clXdM+uLnxJI6MkdayqSol3DA6+5f0ng3Do8R9Eqa6qKm71sCYoPqTWxrBgKOu
         NjM3Of0r49IDwcJHTcK4cA9NorUJeHmqTUN3DgVKsZJjmRSpCuABBJGpC0vrhdwBMmXI
         I4jid2g6aFO+gp5s/+fp10YlS+4KOoktIrYygMGOaaymcelcdmg14HZ3h0k53l/V3lpT
         tjZkWYF+EAG8WWLC5wAojMEujz4y9pXOhGPz0lLfBTIV+9ntSiItQGsh/GIq4EMXN9mI
         w/radKRssLFMU6Yx5hN07g2+e1xyE/dq5tErQ3NCerFW8ZFYO9YkIMGpTq/dycyBbzQg
         43bw==
X-Gm-Message-State: APjAAAUjivljFT6nERC9Yo4sy3fu77+pSYpV/yYEF3J1dap26L/GObnL
        0E+mI+ckgPWYn8mUEz21Mqobog==
X-Google-Smtp-Source: APXvYqwZGjb2/uJzYwyqA6bd3WQSgjJyruiOaKWJyhPYSBAPmKfprLxVTOKBo7UMa1GsN/L6lD+0gA==
X-Received: by 2002:a50:cccc:: with SMTP id b12mr60231795edj.94.1555608345331;
        Thu, 18 Apr 2019 10:25:45 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id b11sm693110edm.5.2019.04.18.10.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:25:44 -0700 (PDT)
Subject: Re: [PATCH] i2c: iproc: Change driver to use 'BIT' macro
To:     Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>
Cc:     "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
References: <20190403210535.32236-1-ray.jui@broadcom.com>
 <f28f604a-55a4-7542-0e13-a92a83ab2144@axentia.se>
 <c47c6ec2-6d6f-8885-932c-35390783f55b@axentia.se>
 <bd0c7b0f-1936-dd1e-b8f3-ebafebdea252@broadcom.com>
 <497d0668-3065-a357-72ca-a7e79fc9cfb0@axentia.se>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <477ebe18-68e0-f5c8-e7a0-5476b6a886db@broadcom.com>
Date:   Thu, 18 Apr 2019 10:25:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <497d0668-3065-a357-72ca-a7e79fc9cfb0@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/2019 11:21 PM, Peter Rosin wrote:
> On 2019-04-18 01:48, Ray Jui wrote:
>>
>>
>> On 4/14/2019 11:56 PM, Peter Rosin wrote:
>>> On 2019-04-13 00:59, Peter Rosin wrote:
>>>> On 2019-04-03 23:05, Ray Jui wrote:
>>>>> Change the iProc I2C driver to use the 'BIT' macro from all '1 << XXX'
>>>>> bit operations to get rid of compiler warning and improve readability of
>>>>> the code
>>>>
>>>> All? I see lots more '1 << XXX_SHIFT' matches. I might be behind though?
>>>
>>> I verified that, and yes indeed, I was behind. That said, see below...
>>>
>>
>> Right. Previous change that this change depends on is already queued in
>> i2c/for-next.
>>
>>>> Anyway, if you are cleaning up, I'm just flagging that BIT(XXX_SHIFT) looks
>>>> a bit clunky to me. You might consider renaming all those single-bit
>>>> XXX_SHIFT macros to simple be
>>>>
>>>> #define XXX BIT(<xxx>)
>>>>
>>>> instead of
>>>>
>>>> #define XXX_SHIFT <xxx>
>>>>
>>>> but that triggers more churn, so is obviously more error prone. You might
>>>> not dare it?
>>>>
>>
>> With the current code, I don't see how that is cleaner. With XXX_SHIFT
>> specified, it makes it very clear to the user that the define a for a
>> bit location within a register. You can argue and say it makes the
>> define longer, but not less clear.
>>
>>>> Cheers,
>>>> Peter
>>>>
>>>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>>>> ---
>>>>>  drivers/i2c/busses/i2c-bcm-iproc.c | 6 +++---
>>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
>>>>> index 562942d0c05c..a845b8decac8 100644
>>>>> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
>>>>> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
>>>>> @@ -717,7 +717,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>>>>>  
>>>>>  			/* mark the last byte */
>>>>>  			if (i == msg->len - 1)
>>>>> -				val |= 1 << M_TX_WR_STATUS_SHIFT;
>>>>> +				val |= BIT(M_TX_WR_STATUS_SHIFT);
>>>>>  
>>>>>  			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
>>>>>  		}
>>>>> @@ -844,7 +844,7 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
>>>>>  
>>>>>  	iproc_i2c->bus_speed = bus_speed;
>>>>>  	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
>>>>> -	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
>>>>> +	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
>>>>>  	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
>>>
>>> These two statements now no longer "match". One uses BIT and the other open
>>> codes the shift. I think that's bad. Losing the _SHIFT suffix and including
>>> BIT in the macro expansion, as suggested above, yields:
>>>
>>> 	val &= ~TIM_CFG_MODE_400;
>>> 	if (bus_speed == 400000)
>>> 		val |= TIM_CFG_MODE_400;
>>>
>>> which is perhaps one more line, but also more readable IMO.
>>>
>>
>> A single line with evaluation embedded is nice and clean to me. I guess
>> this is subjective.
> 
> The "problem" I had when I looked at the driver was not any one specific
> instance. It was just that, for my taste, the code had too many shifts
> etc inline with the real code. Replacing 1 << xyz_SHIFT with BIT(xyz_SHIFT)
> is not a real improvement, they are just about equal to me, it's just that
> there are still too many mechanical things happening that could easily be
> tucked away with the suggested approach.
> 

Right, for your taste. Like I said, I feel this is very subjective. To
me, and many other I2C driver owners (I just checked how many other I2C
drivers also appear to prefer to use XXX_SHIFT and there are a lot of
them), using XXX_SHIFT makes it more clear that the define is intended
to be used for bit shift operation.

>> I'll leave the decision to Wolfram. If he also prefers the above change
>> to be made, sure. Otherwise, I'll leave it as it is.
> 
> But if you see no value in my suggestion and/or don't what to take the
> cleanup one step further, then just leave it as-is.
> 

Again, this is subjective. Personally I do not feel this is "cleanup one
step further". To me, this change will make the code less clear on the
intended operation.

>>> But all this is of course in deep nit-pick-territory...
>>>
>>> Cheers,
>>> Peter
>>>
>>
>> Thanks,
>>
>> Ray
>>
> 
