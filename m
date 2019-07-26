Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A192CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BA921880
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSqGZeXU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfGZINP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:13:15 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37756 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZINO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:13:14 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so24133941pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=49lIJZlNEqxVVjdVbG3GngEaZbWZkD0IekWgDjyuCa0=;
        b=kSqGZeXUUBrCtLibBD9oHLeXvAhi8eD5ICUBQZcYFrarKv6vRw8XR28+l4jaaGBZuZ
         v8xvSdcYGg220HvYo+JQpsdjyjEyDaTUPnT9P6drufrmu2Mpwewns1X67yHuyGPK+9wy
         NX7QrZ4uCHIP8EOlU7Gl8kPbVCYgyb4aXv1h3925CTO03Pwy8gr5zPOYrL/an6T2FVIl
         rkkjYtgJYjQczzme5fAirTp2y6AmitpkczSmvQk6Q9okNeiBxCqNDww9j8R6cg2JJTZs
         VUAGAsf4SddsAnn1TekYT9IZu1i1uRiYg9evjd3ff8uHyP//b+Ii5SpqvaJDKirTYCdD
         eKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49lIJZlNEqxVVjdVbG3GngEaZbWZkD0IekWgDjyuCa0=;
        b=D/Bq9X0DocmPLhtkXEcN23e1KRwgTVYguBgcDneJgfa8coATGT6ZNZ353WQLsklRn5
         1gHztejujfDlFQV1aW8Rba9/0AwU6OstjbZFw62tQcysNz+Yix9jXm4wnDTSDTw4aaHi
         o8XpcF4nL2vl6VfcBqn12/pby6uVVALKBCtZ8MnVTUX4WVPXEuv2TzQcKdgSCdI6kxIJ
         tMSjma/0vVRc+HDb3+QeWSJnhnyaHTcrGKuADz2bIpv5cEBtJ8A6CyjclQFDhJcaOF1/
         CDkAUs2d/z0rqDGEi5z6ZPOHFw5nZfsY1V/oEYBGmvwfOd+q2SlkLsuYxHXs2PDrfHbf
         +F5g==
X-Gm-Message-State: APjAAAUjLYKrriuRV2/pxjrkNfWUcTecqB6pZiW27tNCmit+u4bgg7O7
        Mu1yNLyzE+cXJm6eiiLb1yEMGTQA
X-Google-Smtp-Source: APXvYqxHqfx4S/HkQw7ttiSSjT9jgpVQ0ufP8+xiFT/ZeE857q/1JgwkKGK9anwXf6aC2p+ZIrpzXg==
X-Received: by 2002:a62:fb18:: with SMTP id x24mr20487244pfm.231.1564128793751;
        Fri, 26 Jul 2019 01:13:13 -0700 (PDT)
Received: from [10.0.2.15] ([110.227.69.93])
        by smtp.gmail.com with ESMTPSA id 2sm94331910pgm.39.2019.07.26.01.13.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 01:13:13 -0700 (PDT)
Subject: Re: [PATCH] mfd: max77620: Add of_node_put() before return
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20190709173132.13886-1-nishkadg.linux@gmail.com>
 <20190725121552.GG23883@dell>
From:   Nishka Dasgupta <nishkadg.linux@gmail.com>
Message-ID: <588f136b-95e2-7582-9833-70256cb73f7c@gmail.com>
Date:   Fri, 26 Jul 2019 13:43:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190725121552.GG23883@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 5:45 PM, Lee Jones wrote:
> On Tue, 09 Jul 2019, Nishka Dasgupta wrote:
> 
>> Each iteration of for_each_child_of_node puts the previous node, but in
>> the case of a return from the middle of the loop, there is no put, thus
>> causing a memory leak. Hence add an of_node_put before the return.
>> Issue found with Coccinelle.
>>
>> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
>> ---
>>   drivers/mfd/max77620.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Ah, I've just seen that you didn't send this to the list.
> 
> When submitting patches upstream, you must CC at least one list.
> 
> Usually people CC LKML as a matter of course.

My mistake, sorry. I'll CC the list from next time.

Thanking you,
Nishka
> 
> I've CC'ed LMKL here and applied the patch.
> 
>> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
>> index 0c28965fcc6a..a851ff473a44 100644
>> --- a/drivers/mfd/max77620.c
>> +++ b/drivers/mfd/max77620.c
>> @@ -416,8 +416,10 @@ static int max77620_initialise_fps(struct max77620_chip *chip)
>>   
>>   	for_each_child_of_node(fps_np, fps_child) {
>>   		ret = max77620_config_fps(chip, fps_child);
>> -		if (ret < 0)
>> +		if (ret < 0) {
>> +			of_node_put(fps_child);
>>   			return ret;
>> +		}
>>   	}
>>   
>>   	config = chip->enable_global_lpm ? MAX77620_ONOFFCNFG2_SLP_LPM_MSK : 0;
> 

