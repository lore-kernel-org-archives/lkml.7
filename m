Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6222EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FED420828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="sXoGtaPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZHvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:51:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37137 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730569AbfCZHvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:51:46 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so10216004ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B01lGyfJBsAdGUtQGWQpzVe+7/KX45Rc7+rWFjohi0o=;
        b=sXoGtaPOpaD9D53XCcm8wcxwm1LFUwVg4IMAN/WVKJTQIo7hZQl+sni7ILF/4GAymN
         q3xDP9Z6bdPumfRWIn2V0nNtgeKeaYKCHaBpQMxvMgWhPDGJ9M96czwD6jwRGe6EJLW/
         UUtzAEoWBrXxKG2PVZCngkFkdxy64+T5xyVoWPeYcy/KQ+PuRlDRRaEKaP0SIo+cO3Yh
         /+M8e/XRxZ49UbnLV+3fNDzx0ZgjjP4hSduPYRu1q9RnU9GmaWC8yYbEzideiPNt18wq
         WojzOTSpa0a4r4uMxEK3L6k0zaZFvFMcR1SYAi7nadIty4Y3kK1fNGK7Fombn6B/70lu
         K7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B01lGyfJBsAdGUtQGWQpzVe+7/KX45Rc7+rWFjohi0o=;
        b=YkH1Y8LGPTn9Wt3pGnxGtIgLpjQGKJWNma78xFumuUTRVP/AblrdRgK5B+b9618vaU
         SttMLmfZvK+8OAMywSp9HpZPDY8zD/SF0vy3E4fobXyFcbvLgwHreASzuJMRoVDDAJ/2
         w0oNupeU9psqSXYTyulM6mC1UzDL/umdV8UI8eIgaeSbQTMvgRQoQcJ9IPafZ2xIurrc
         agm4cLIjnO9Ogn2oyqjHWzFdVAAkbP0G69QFiIbH3N20EzVDr+W656GSx0Bhu88SlHj3
         V3ZpWZmu+lIVaO0302bajgANx66ONpLCNjJs84rQ0UFw5RrALFkPMaF4b/52wJ7rCg8D
         2r4g==
X-Gm-Message-State: APjAAAX/34lZN/0somP6mr1a3LfJ22MrFN+hR4LdC9STWOqeQJ4uBOuY
        8ZQk62ZQZX6rNbkS4/BEDhmSHQ==
X-Google-Smtp-Source: APXvYqzuG4lVrmC5DK2tFNK2dsX3zJVU4wg/Glb6yaxJZ8YcwCwtuYUbE+8Dza7NdgZrZWBXw7g8Sg==
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr13584393lja.49.1553586702905;
        Tue, 26 Mar 2019 00:51:42 -0700 (PDT)
Received: from [192.168.0.199] ([31.173.80.243])
        by smtp.gmail.com with ESMTPSA id k19sm3727508lje.7.2019.03.26.00.51.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 00:51:42 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/5] mtd: Add support for Hyperbus memory devices
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tudor.ambarus@microchip.com,
        nsekhar@ti.com, Mason Yang <masonccyang@mxic.com.tw>
References: <20190321174548.9288-1-vigneshr@ti.com>
 <20190321174548.9288-4-vigneshr@ti.com>
 <98e1e3ad-75d3-670f-bcf7-27389cc60a98@cogentembedded.com>
Message-ID: <02dfcf5d-f7f8-f33a-22b2-462ea92b0702@cogentembedded.com>
Date:   Tue, 26 Mar 2019 10:51:23 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <98e1e3ad-75d3-670f-bcf7-27389cc60a98@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.03.2019 23:13, Sergei Shtylyov wrote:

>> Cypress' Hyperbus is Low Signal Count, High Performance Double Data Rate
> 
>     It's HyperBus, according to the spec...
> 
>> Bus interface between a host system master and one or more slave
>> interfaces. Hyperbus is used to connect microprocessor, microcontroller,
>> or ASIC devices with random access NOR flash memory (called Hyperflash)
>> or self refresh DRAM (called HyperRAM).
>>
>> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
>> signal and either Single-ended clock(3.0V parts) or Differential clock
>> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
>> At bus level, it follows a separate protocol described in Hyperbus
>> specification[1].
> 
>     HyperBus.
>> Hyperflash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
>> to that of existing parallel NORs. Since Hyperbus is x8 DDR bus,
>> its equivalent to x16 parallel NOR flash wrt bits per clock cycle. But
>> Hyperbus operates at >166MHz frequencies.
>> HyperRAM provides direct random read/write access to flash memory
>> array.
>>
>> But, Hyperbus memory controllers seem to abstract implementation details
> 
>     HyperBus.
> 
>> and expose a simple MMIO interface to access connected flash.
>>
>> Add support for registering Hyperflash devices with MTD framework. MTD
> 
>     HyperFlash.
> 
>> maps framework along with CFI chip support framework are used to support
>> communicating with flash.
>>
>> Framework is modelled along the lines of spi-nor framework. Hyperbus
> 
>     HyperBus.
> 
>> memory controller (HBMC) drivers calls hyperbus_register_device() to
>> register a single Hyperflash device. Hyperflash core parses MMIO access
> 
>     HyperFlash.
> 
>> information from DT, sets up the map_info struct, probes CFI flash and
>> registers it with MTD framework.
>>
>> Some HBMC masters need calibration/training sequence[3] to be carried
>> out, in order for DLL inside the controller to lock, by reading a known
>> string/pattern. This is done by repeatedly reading CFI Query
>> Identification String. Calibration needs to be done before trying to detect
>> flash as part of CFI flash probe.
>>
>> HyperRAM is not supported at the moment.
>>
>> Hyperbus specification can be found at[1]
>> Hyperflash datasheet can be found at[2]
> 
>    HyperBus & HyperFlash.
>   
>> [1] https://www.cypress.com/file/213356/download
>> [2] https://www.cypress.com/file/213346/download
>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>      Table 12-5741. HyperFlash Access Sequence
>>
>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [...]
>> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
>> new file mode 100644
>> index 000000000000..4c2876c367fc
>> --- /dev/null
>> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
>> @@ -0,0 +1,183 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +//
>> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>> +// Author: Vignesh Raghavendra <vigneshr@ti.com>
>> +
>> +#include <linux/err.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/mtd/hyperbus.h>
>> +#include <linux/mtd/map.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/cfi.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/types.h>
>> +
>> +#define HYPERBUS_CALIB_COUNT 25
> 
>     As I said, this seems platform specific...
> 
> [...]
>> +/* Default calibration routine for use by Hyperbus controller.
> 
>     No, there should be easy opt-out from the calibration method.
> Currently, the driver will have to define its own calibrate method, even
> if does't need any calibration...

    Nevermind -- the method ptr can be NULL, of course, so there's easy opt-out...

[...]

MBR, Sergei
