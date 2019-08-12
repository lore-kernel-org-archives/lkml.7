Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3D9C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E94B20679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=devtank-co-uk.20150623.gappssmtp.com header.i=@devtank-co-uk.20150623.gappssmtp.com header.b="wAwgpYB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHLVDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:03:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51953 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfHLVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:03:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id 207so857621wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 14:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=GpW5qLhZyrECHDegQNaRLHT0CfKc1qacLHW2hCzZ6z0=;
        b=wAwgpYB8w4BwSUbHdghD8ZImzZ2FTixXUOwdkOyc5UkRbhHwFXv5wOp0aRuAsm8HQL
         Jqgu6hb/QdI3DbANUVBCxoJpxDnBtCfiknDeKjSUPYV+V015LZy+VbM5sRBMVX9FP7L1
         T5pYGDHZ3BJPEKDxIJWr9ixFAx/E7AsZMHIA/8a1PmLw2MFL+g88EALquzE/RdbHlvKh
         AaEAkZ1Fnk3Llh3AWa2BXAFfGxcGXB+k56JKIteyztsehnO+BBqBCFXzX1+O+vWyrq8v
         vQIFVtbqB2msnSz/DlSZWCbmYojaUogg1VS4xZNeeX2vJMxQ633XZIx681ncsw+q7VNi
         wfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GpW5qLhZyrECHDegQNaRLHT0CfKc1qacLHW2hCzZ6z0=;
        b=lyY15UxfUeVbBSWpvWegzN28gCvdFjp95p99ar4A/5vAgIdNoem86Dyz6ePlkySZ7q
         pDzubWlO7uyuMD7RWX6YdPyFIFePktRFIimlwXuq3A7hkfOJwOe+NemSm1f1pPEOTUdu
         eAc84bmmc/tzIonXrGb2xhLiZS9JgtL7Htm//YIgUe3qBrPs14MMHcCBj6xryKs+3Q6W
         3Ckx5owChHxZPOa8r7zb5v1jjT0cpKjKQ7a9fXwRrQX/zNxBpA1kmWzt5UxFWEXApBV8
         gf5L+09eKFA24feaiFZ6ks1HSOd3j5kgc+5yBKJfGubHqWXK6XQSRosevML5WXEI+d0g
         t6TQ==
X-Gm-Message-State: APjAAAVmCjv9LU0dbKT1LusyRH2bgU+Xj3JvEt0VGba/J5mfJldURjnV
        d7wUXDluPro+83Gpge0kwh+FInbqAo4=
X-Google-Smtp-Source: APXvYqyHfviym5EAsN4aOLK9l3Gc+8Rugp5zzQU53Zta2+hZ75MbKJHpSQrkpexpDGZde6NNTsSSzA==
X-Received: by 2002:a7b:c310:: with SMTP id k16mr961676wmj.133.1565643813877;
        Mon, 12 Aug 2019 14:03:33 -0700 (PDT)
Received: from [192.168.222.141] (82-71-5-123.dsl.in-addr.zen.co.uk. [82.71.5.123])
        by smtp.gmail.com with ESMTPSA id h97sm32667090wrh.74.2019.08.12.14.03.32
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 14:03:33 -0700 (PDT)
Subject: Re: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
To:     David Laight <David.Laight@ACULAB.COM>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
 <9f1c7d45020d482390737be22c885a9b@AcuMS.aculab.com>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Message-ID: <dd5f6b9f-13bd-8127-71a8-40e7a7017d25@devtank.co.uk>
Date:   Mon, 12 Aug 2019 22:03:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9f1c7d45020d482390737be22c885a9b@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2019 16:51, David Laight wrote:
> From: Joe Burmeister
>> Sent: 09 August 2019 13:54
>>
>> Many, though not all, AT25s have an instruction for chip erase.
>> If there is one in the datasheet, it can be added to device tree.
>> Erase can then be done in userspace via the sysfs API with a new
>> "erase" device attribute. This matches the eeprom_93xx46 driver's
>> "erase".
> Is it actually worth doing though?
>
> I'm guessing that device erase can easily take over a minute.


That must depend on the AT25. The one we're using (AT25F512A), as it's 
setup, it's fast enough. The datasheet states "The CHIP ERASE cycle time 
typically is 2 seconds.". I've not timed it's because as I said, seamed 
fast enough.


If you can't erase it, then it's basically write once, or you expose it 
with spi_dev to Flashrom to erase it.


> When I looked at 'device erase' on an EEPROM it took just as long
> as erasing the sectors one at a time - but without the warm cosy
> feeling that progress was being made.


I didn't look at sector erase as I'm only interested in erasing it all 
and there was a command for it. I figured if someone wanted sector by 
sector they would implement it.



> Not only that you can't really interrupt the erase, so either
> the application has to sleep uninterruptibly for the duration
> or you have to have some kind of 'device busy' response while
> it is done asynchronously.


That's true, but as I said, it's fast enough it's not an issue for us.

> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

Regards,

Joe

