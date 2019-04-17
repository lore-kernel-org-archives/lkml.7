Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C08BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5D5217FA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Oz4pYM1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387539AbfDQXsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:48:38 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42037 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQXsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:48:37 -0400
Received: by mail-yw1-f65.google.com with SMTP id e76so138965ywa.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=665+0pFKyxwXCyv21VneQVU1As4CVMYTozUOJPdlNHI=;
        b=Oz4pYM1kfRauE+pi5yD8QV1MgC8jSTF2zuWFz+4Ga/TfqMtlEJ5QDmfqHLqN0UXmE9
         sWaurVXObPnrOIHWnvxE09ey2Ekhj8R19agHlz3bgwHJnkhy73XnZVTB03anP0S+9+ze
         phJUzzRukX3j5R7sxxXnb+FX1QCHxsOYdWqC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=665+0pFKyxwXCyv21VneQVU1As4CVMYTozUOJPdlNHI=;
        b=RRKVPhupmQD7DIdWCDTPyG2S6ppFTOtrUH28J4CPA8ZUFgzT/UnQsebMuSZMigIYHd
         awNSNiq0ZnYIhRbljiF1rLsUT0NgASpQ2JC6liGL2O7PnKYpSgtoRCO8R4liizJSxYc3
         /TETi6DgRtFFUhnMG7EVECe7Jsq+xUe34yBzwcoDf8xHEb71aHBYkUbOzdxHg0c3e8sT
         xVN6MOkj4tSggai0BS+UKBQTPHVNoDl5SfQJSVQypk//hTN3N9QAVxWcKuh1+mQfs5yM
         PTrB0V6LLswLcm049O9Cy9tqdy1R1vi+EOCFaVtaLBAFSeuJM3hD26lhNgq/5k77jYJI
         7rLA==
X-Gm-Message-State: APjAAAVr/BrbHBBS/El3gyKDsM/9vybHfEThIqxdFKfiJWtRvqCGXyaH
        pLn/xIQ0Fok3B9eGPiZ0hbxRqg==
X-Google-Smtp-Source: APXvYqyFeHsr/8yghhNu/pOXxTzDoFr7WKQvoYgmxzyUlyso9/Q0ZPTvWDcqSxv+H339UeoRLyBxxA==
X-Received: by 2002:a81:2d09:: with SMTP id t9mr73665130ywt.436.1555544916432;
        Wed, 17 Apr 2019 16:48:36 -0700 (PDT)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id g5sm157504ywf.100.2019.04.17.16.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:48:35 -0700 (PDT)
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
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <bd0c7b0f-1936-dd1e-b8f3-ebafebdea252@broadcom.com>
Date:   Wed, 17 Apr 2019 16:48:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c47c6ec2-6d6f-8885-932c-35390783f55b@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2019 11:56 PM, Peter Rosin wrote:
> On 2019-04-13 00:59, Peter Rosin wrote:
>> On 2019-04-03 23:05, Ray Jui wrote:
>>> Change the iProc I2C driver to use the 'BIT' macro from all '1 << XXX'
>>> bit operations to get rid of compiler warning and improve readability of
>>> the code
>>
>> All? I see lots more '1 << XXX_SHIFT' matches. I might be behind though?
> 
> I verified that, and yes indeed, I was behind. That said, see below...
> 

Right. Previous change that this change depends on is already queued in
i2c/for-next.

>> Anyway, if you are cleaning up, I'm just flagging that BIT(XXX_SHIFT) looks
>> a bit clunky to me. You might consider renaming all those single-bit
>> XXX_SHIFT macros to simple be
>>
>> #define XXX BIT(<xxx>)
>>
>> instead of
>>
>> #define XXX_SHIFT <xxx>
>>
>> but that triggers more churn, so is obviously more error prone. You might
>> not dare it?
>>

With the current code, I don't see how that is cleaner. With XXX_SHIFT
specified, it makes it very clear to the user that the define a for a
bit location within a register. You can argue and say it makes the
define longer, but not less clear.

>> Cheers,
>> Peter
>>
>>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
>>> ---
>>>  drivers/i2c/busses/i2c-bcm-iproc.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
>>> index 562942d0c05c..a845b8decac8 100644
>>> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
>>> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
>>> @@ -717,7 +717,7 @@ static int bcm_iproc_i2c_xfer_single_msg(struct bcm_iproc_i2c_dev *iproc_i2c,
>>>  
>>>  			/* mark the last byte */
>>>  			if (i == msg->len - 1)
>>> -				val |= 1 << M_TX_WR_STATUS_SHIFT;
>>> +				val |= BIT(M_TX_WR_STATUS_SHIFT);
>>>  
>>>  			iproc_i2c_wr_reg(iproc_i2c, M_TX_OFFSET, val);
>>>  		}
>>> @@ -844,7 +844,7 @@ static int bcm_iproc_i2c_cfg_speed(struct bcm_iproc_i2c_dev *iproc_i2c)
>>>  
>>>  	iproc_i2c->bus_speed = bus_speed;
>>>  	val = iproc_i2c_rd_reg(iproc_i2c, TIM_CFG_OFFSET);
>>> -	val &= ~(1 << TIM_CFG_MODE_400_SHIFT);
>>> +	val &= ~BIT(TIM_CFG_MODE_400_SHIFT);
>>>  	val |= (bus_speed == 400000) << TIM_CFG_MODE_400_SHIFT;
> 
> These two statements now no longer "match". One uses BIT and the other open
> codes the shift. I think that's bad. Losing the _SHIFT suffix and including
> BIT in the macro expansion, as suggested above, yields:
> 
> 	val &= ~TIM_CFG_MODE_400;
> 	if (bus_speed == 400000)
> 		val |= TIM_CFG_MODE_400;
> 
> which is perhaps one more line, but also more readable IMO.
> 

A single line with evaluation embedded is nice and clean to me. I guess
this is subjective.

I'll leave the decision to Wolfram. If he also prefers the above change
to be made, sure. Otherwise, I'll leave it as it is.

> But all this is of course in deep nit-pick-territory...
> 
> Cheers,
> Peter
> 

Thanks,

Ray
