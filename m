Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3EBC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E82214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 16:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=devtank-co-uk.20150623.gappssmtp.com header.i=@devtank-co-uk.20150623.gappssmtp.com header.b="1IjnohLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437114AbfHIQ2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 12:28:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34238 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407432AbfHIQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 12:28:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id e8so6243344wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=devtank-co-uk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=oFUupXLYzF//Q3bn0VJxW9ri4k7+mQJ4gPnrxCRZee8=;
        b=1IjnohLhqWJpXDw8KNRbz/KTj/bZsaUd+iViv/6kO+RBNbE0zfPMDPV1dj2eHhOS+b
         YqVGbvD01DFwlNGYKYMOUZhPvhVS+ZcwiBFiO/bAKiS6iuHFstZ30DEyhY0T03gdJkdA
         SvmzRrj4hTywTVRg5ITVIGK/3hQU3WGWwFrieLkOpulnidzaDCPwe9miboxalPESjky+
         C3Z07cctrX4GMA4RVAFUzb3Lman+Fm2H7MCXRMmF7ouivGYFO0aHEJ+MfsT/0Qrmiypz
         JdvyaHR02G/Ivs2BkJMhHNGA7dA6/XuarIB52vBGNX9NwL5mBIM8jZ8waNCkRPYJxrjc
         Nc8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oFUupXLYzF//Q3bn0VJxW9ri4k7+mQJ4gPnrxCRZee8=;
        b=jl+VInLXLOUDOhtxO5/7/4NwEzxMOZCT+mC886nCO563RSxmkfBc/TASySrRvKfgCC
         jycQaf1LAEZoN90jucXF8GOT1KmO+1eeWHhEJ5jgJ4QTKyk9C92ScQqjWT+xIMd7i1on
         y3a0KmHFW6qDCn3dHS5fgP7BMVoNgke1e4xdTeKX7nUe5pjFMz7cGh/z/iysfvw7j/b/
         Tf4YVZIFuEoU+u5N56bFBS57+huHhcmSAPS4QIVcs93pxJKRV66p5a17sA2GTgUuYJt3
         XBQQNLeFw0pignlhQQ2+jBCCixpA/KF8a6ApIufAhEBq4ZELM/hcXkB1kQidGR5s6EgI
         og8w==
X-Gm-Message-State: APjAAAWjqahjCves+c4yN+C9DCxXA7mATcXm82REEh9JjH6rq8m1KozL
        ti6VwAg2MdE71ORfDweU4560bPSrf/c=
X-Google-Smtp-Source: APXvYqwqQHbDL7xhW8KbpUhtivpVA643JTZ3TJ7/13vHFxFQa/51rdZyOGAwOfiEA85womrn6Kl1Kw==
X-Received: by 2002:a1c:a701:: with SMTP id q1mr5802453wme.72.1565368124533;
        Fri, 09 Aug 2019 09:28:44 -0700 (PDT)
Received: from [192.168.200.229] ([141.105.200.141])
        by smtp.gmail.com with ESMTPSA id h12sm2912765wrq.73.2019.08.09.09.28.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 09:28:43 -0700 (PDT)
Subject: Re: [PATCH] Add optional chip erase functionality to AT25 EEPROM
 driver.
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190809125358.24440-1-joe.burmeister@devtank.co.uk>
 <20190809135440.GI48423@lakrids.cambridge.arm.com>
From:   Joe Burmeister <joe.burmeister@devtank.co.uk>
Message-ID: <f9316727-607b-7c05-1c47-05319b3cdecf@devtank.co.uk>
Date:   Fri, 9 Aug 2019 17:28:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190809135440.GI48423@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,


On 09/08/2019 14:54, Mark Rutland wrote:
> On Fri, Aug 09, 2019 at 01:53:55PM +0100, Joe Burmeister wrote:
>> Many, though not all, AT25s have an instruction for chip erase.
>> If there is one in the datasheet, it can be added to device tree.
>> Erase can then be done in userspace via the sysfs API with a new
>> "erase" device attribute. This matches the eeprom_93xx46 driver's
>> "erase".
>>
>> Signed-off-by: Joe Burmeister <joe.burmeister@devtank.co.uk>
>> ---
>>   .../devicetree/bindings/eeprom/at25.txt       |  2 +
>>   drivers/misc/eeprom/at25.c                    | 83 ++++++++++++++++++-
>>   2 files changed, 82 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/eeprom/at25.txt b/Documentation/devicetree/bindings/eeprom/at25.txt
>> index b3bde97dc199..c65d11e14c7a 100644
>> --- a/Documentation/devicetree/bindings/eeprom/at25.txt
>> +++ b/Documentation/devicetree/bindings/eeprom/at25.txt
>> @@ -19,6 +19,7 @@ Optional properties:
>>   - spi-cpha : SPI shifted clock phase, as per spi-bus bindings.
>>   - spi-cpol : SPI inverse clock polarity, as per spi-bus bindings.
>>   - read-only : this parameter-less property disables writes to the eeprom
>> +- chip_erase_instruction : Chip erase instruction for this AT25, often 0xc7 or 0x62.
> This should be using '-' rather than '_', as per general DT conventions
> and as with the existing properties.
>
>>   Obsolete legacy properties can be used in place of "size", "pagesize",
>>   "address-width", and "read-only":
>> @@ -39,4 +40,5 @@ Example:
>>   		pagesize = <64>;
>>   		size = <32768>;
>>   		address-width = <16>;
>> +		chip_erase_instruction = <0x62>;
> [...]
>
>> +	/* Optional chip erase instruction */
>> +	device_property_read_u8(&spi->dev, "chip_erase_instruction", &at25->erase_instr);
> This will not behave as you expect, since you didn't mark the property as
> 8-bits.

Rats, I forgot to update the documentation. In my device tree I have 
already found the /bit 8/ bit.

> Read this as a u32 into the existing val temporary variable, as is done
> for pagesize. You can add a warnign if it's out-of-range.

32bit would certainly read better in the device tree. I'll do that.

> Thanks,
> Mark.


Cheers,


Joe



