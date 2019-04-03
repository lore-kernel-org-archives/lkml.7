Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F20C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F7820700
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFxEsUxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDCUOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:14:34 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44156 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDCUOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:14:33 -0400
Received: by mail-lf1-f68.google.com with SMTP id v71so47776lfa.11;
        Wed, 03 Apr 2019 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zZeuv8D14bU8Ym4uwHTGLzLdx/g47nfgJ0GaaXsF09c=;
        b=jFxEsUxX8w82gUdfeL4cqZF53SMhVYI+fquVtidcKIOeis9ZzVqDJGiyLyl3jkApdD
         6M+VesjvkY98XQSpr3Um4NxTnh38TU+I2n+BkvSBuxR47fXIMQ6ohQP96O55/KfOUU6F
         6GucydQqmfacDcta4dE4XWVVh+u5a31DkJ0N4WFbcFJKc4F9Lwen2mI5QJ8BLkqyH8Zo
         q7Zo/EB9aOi5fZmdR5FTqqveuOPOaNmPz6BAPqaXjnZI0ugii1erbdmUOz6UFKqWU3+x
         y2IiILuQ9t2m88EnPgGZoLBZ7M93TDyo/REI7+Wbqrq5wFQwwGu6wU79FeQZ863ZEJdm
         Zmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zZeuv8D14bU8Ym4uwHTGLzLdx/g47nfgJ0GaaXsF09c=;
        b=SLAz0tOrvVhbDS8gOTN5S2Qn7AitzptpzGlu9wSzWrNV3fk4Iio1G5MIQ0EaQhzuWX
         iQeA3H6eJGBA8XnzPiNuLi6pFAoNYZvRKnRkSAG48GZSIox1c1v0n4fP39HkGm+IDTew
         huNtoUj+gvRuWODO2P4pQYruMh6SePd5mGkHk3lBSTOHTEmn5waTuZ0Vpuplfd/Lhcgf
         ApRYokXklBNJmoGHPbAqt+G9Yvynn8i251E/42562KDEfRcO3uCTcuLV87B2U/ryTK9G
         YUVl7pdxI8GlmVMMlsOuQwQMvqmjGSI8Smic4VZONvWL9LLAoDHQlj16Z0tYnC0+/+1F
         53vw==
X-Gm-Message-State: APjAAAVljMwR1GqfS8tzdUQI9Jl5E0X8NQRKMXAktIS1LCiRF/woVAJ1
        9vXnXhE4UBBE0dQ5yWEges4=
X-Google-Smtp-Source: APXvYqzHmdYvGulS68M6i9Xi5teNNZ4lDlTvM4CAmozVHkMyxiygmQek5VSNWsRkYyMvUn4M5VRj4g==
X-Received: by 2002:a19:c784:: with SMTP id x126mr843398lff.91.1554322471489;
        Wed, 03 Apr 2019 13:14:31 -0700 (PDT)
Received: from [192.168.1.19] (bkr161.neoplus.adsl.tpnet.pl. [83.28.185.161])
        by smtp.gmail.com with ESMTPSA id e18sm3487602ljb.12.2019.04.03.13.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 13:14:30 -0700 (PDT)
Subject: Re: [PATCH 0/5] TI LMU rework
To:     Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
References: <20190325142403.30447-1-dmurphy@ti.com>
 <1037091e-1f4a-3922-16ee-282253dad7e0@ti.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <1f24fe22-7265-df4b-872a-cfb3622002c9@gmail.com>
Date:   Wed, 3 Apr 2019 22:14:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1037091e-1f4a-3922-16ee-282253dad7e0@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 4/3/19 2:02 PM, Dan Murphy wrote:
> Hello
> 
> On 3/25/19 9:23 AM, Dan Murphy wrote:
>> All
>>
>> I know that it has been a long time but I put some additional effort into this
>> code.  The TI LMU common code right now handles brightness and ramp up/down
>> setting for the LM3697.  This so far are the common features I could find.
>>
>> The LM3697 driver has the ability to assign HVLED strings to specific control
>> banks as well as assigning different max brightnesses to these strings.
>>
>> Fault monitoring was removed as the data sheet indicates that this is for
>> production tests only.
>>
>> I have plans to add additional LED drivers to use the TI LMU but I figured trying
>> to add all of them at once would be a daunting review and probably wrought with
>> problems.
>>
> 
> I have a new device I need to add to the TI LMU code LM36274.
> This will use the MFD ti-lmu code and I will need to create the backlight and regulator drivers.
> 
> I need to know how to proceed.  I can base the work off of the LM3532 patchset or use what is in mainline
> or base it off this patchset.  The LM36274 would use the ti-lmu-led-common code for brightness setting but the
> ramping times are different.
> 
> Please let me know how to proceed.

The patch set looks good to me with a single reservation I've just
posted. You can base your work off it.

-- 
Best regards,
Jacek Anaszewski
