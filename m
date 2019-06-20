Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6391DC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2E8206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EMN0ZZAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbfFTIrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:47:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40899 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfFTIrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:47:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so2237606wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 01:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2rZ1vs5Z2JW66fClysbgEwISMUXpRxeDXqb9LFQrbQ=;
        b=EMN0ZZAxDf0DZUy03S2fHKwnt9FDKNzOTUhPQWTWmNSqUGTloeKfgG4UjBNnSISm1U
         +HMWNNSL7p5KnlXUxkBAki3Kmv8OGAckmjGZOnSMGXv/sPSajBBN0bCyFHFjT1Var//D
         2IRy4vR5zuNOGmRD9zW12jO6GMkyHLgzC3SVkGL3b6WWPq8EeIQgs+z1yFuAPp+TDrXE
         3RssX3wSApd3AyNPZsGq5mSwWl1V60O8E8jPm5Sdz81rWpNxV0oLwGAbvIZeIiEtecMw
         Urv7iXmGsM6ZDizCnSMFDLwbzqKOPVwJtWlUNUYjs6UWWV6pLE0w76H0gsK7rARDEcOv
         RuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2rZ1vs5Z2JW66fClysbgEwISMUXpRxeDXqb9LFQrbQ=;
        b=NqH7KicLxvV1sPNGeH2shobSqGpMotebolgixzA2zRRb0yXJ1wTH1ls+732gAGNHhN
         OgvBqEkNHpsFWrxK7rF9ECP8pa1qIp8McLjYASuRWGzYUpEHt8DYH2aaFQ9WFB69gWB3
         ET9UnOm6tL+3nIRwDDt6qFCk/tdkm4ivagUTucnwhyMWluHniBj/lXMmwOXhkK+vhLXt
         pSlxM7gMrtVAD9LTl6UB7mQOXFr9EmXFTJv8ZZ+fnzTpcGX8coJxHJH/SxU3BIAtdqK4
         da4M9qGGX7z79UB7bIzgOGYbw9VKi0dRlSbi8BFoCFCpwGqc5ZKQysGVPCfueR3sZR26
         psdg==
X-Gm-Message-State: APjAAAVSILAN9eGJhfxkncRwkoptl60M3xNGNo5eBYlINWmwgtun2Stt
        FZsZwYKLUiVYMPsC7DDD0llsfJN2G1Y=
X-Google-Smtp-Source: APXvYqy/elDMLeinwU8ML/8ifxSsuhVIyGkEymjAadwLhlxmAld0SUOQ+25yzqJnknmIeRbmMIrl6A==
X-Received: by 2002:a1c:e90f:: with SMTP id q15mr1921742wmc.89.1561020470956;
        Thu, 20 Jun 2019 01:47:50 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id r4sm44492370wra.96.2019.06.20.01.47.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 01:47:50 -0700 (PDT)
Subject: Re: [PATCH 1/3] slimbus: fix kerneldoc comments
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20190620081129.4721-1-srinivas.kandagatla@linaro.org>
 <20190620081129.4721-2-srinivas.kandagatla@linaro.org>
 <20190620084623.GA20943@kroah.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c6c172db-3eec-8f4e-ac32-0b7cb487c5e3@linaro.org>
Date:   Thu, 20 Jun 2019 09:47:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190620084623.GA20943@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/06/2019 09:46, Greg KH wrote:
> On Thu, Jun 20, 2019 at 09:11:27AM +0100, Srinivas Kandagatla wrote:
>> From: Jonathan Corbet <corbet@lwn.net>
>>
>> The kerneldoc comments in drivers/slimbus/stream.c were not properly
>> formatted, leading to a distinctly unsatisfying "no structured comments
>> found" warning in the docs build.  Sprinkle some asterisks around so that
>> the comments will be properly recognized.
>>
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/slimbus/stream.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> Turns out this was already in my tree :)
>
Ah, I should have rebased it on top of char-misc!


> Also, when sending out patches, be sure to cc: the authors, no need to
> suppress that in git send-email.
> 
Sure, I will keep that in mind!

thanks,
srini
> thanks,
> 
> greg k-h
> 
