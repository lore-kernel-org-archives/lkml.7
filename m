Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1DFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330B62084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="t3M9pwV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfFQTp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:45:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43803 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfFQTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:45:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id j29so7435747lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 12:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Pin+t3SQw4xphykuXVSln0ZpS8PlkIhkvTYeC1W+arw=;
        b=t3M9pwV5Nc2mU7uNt2Gvnyp5rug6s3gMOzSQhkbioeWsXDWGEqmXc6aaf3JVQnyynE
         39nqYCpdi6HwURW17MD79yYSW2tbCLpJ1q5lmBFV7s/6ICNjwvhTn5pZNy6i5e7k72Mv
         0EKw0i5EuazD6hktrnZTwjneWPeVMBkPYwKj7x3dB+DvHtQTzxPM9CPPJnDyx65FMlTr
         GF2EbWcgE/4M7bNuTTOKC3fkfc5gvFmiQBwxhHB1iOZa5cA1k4h57MHY6mr1BUw/lnaD
         sVG2heZ3+n7uX+iaIKkYj0QyROYLRWrbsWrOsnGpaNKVH3JHolf6DNjxdknje470eix7
         rHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Pin+t3SQw4xphykuXVSln0ZpS8PlkIhkvTYeC1W+arw=;
        b=LUQ092J8Zs/CVWeemTXnEFeVpqbY0OjjzwvBAVU91EHGsAPdzB+tIPSo81bRGF++Mv
         Fsr7BoKcZMkjRDOqI23etv8sVaxELfRXbVMkiYFRw53dIht/6Y/5oevU3Ntv7d/LZQkS
         urvwTVuXnYeRRllLpza2Mexrkopq4RzUtoADcwHopmERHl/HzPnQpoB9USYwanpZvNwb
         JP5lHQ/RjjLV9zQB6TZORH8oL2G3eC+cJ9REsKqvTvsn/c9XCrf4B3mU30u/jcWDs0o1
         /0gxQNyu59I/WLEJvFW8CHEXLs5coRhKeHOgaA+PBseHqx0JY9w+iqaHSIZeOI2OolBq
         /37w==
X-Gm-Message-State: APjAAAUs8lmuErOrVgv+1zfQ6Wl62slVVqfQOPX2ifucoOFl4tvgte69
        TvhaXwBtrjN343X9Lb5bVIuJhhyujzA=
X-Google-Smtp-Source: APXvYqwnv9Uovhd1yzWG0Ky0E4Kuv0bMMTtpTFsQwdEAhIBty2VzHQTpmW1NoXnrE45jznhlWWBRCw==
X-Received: by 2002:a19:5007:: with SMTP id e7mr60037319lfb.76.1560800751924;
        Mon, 17 Jun 2019 12:45:51 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.80.15])
        by smtp.gmail.com with ESMTPSA id z83sm2231722ljb.73.2019.06.17.12.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 12:45:51 -0700 (PDT)
Subject: Re: [PATCH v5 3/5] mtd: Add support for HyperBus memory devices
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        devicetree@vger.kernel.org, Mason Yang <masonccyang@mxic.com.tw>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190609103227.24875-1-vigneshr@ti.com>
 <20190609103227.24875-4-vigneshr@ti.com>
 <58e9608d-35ff-0436-6075-b2e4ed4b8594@cogentembedded.com>
 <f47d4d57-afb2-3b39-fae9-3ed740a2b8a6@ti.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9dbd8132-ce8f-9ce7-ddf5-d9826e2a1be1@cogentembedded.com>
Date:   Mon, 17 Jun 2019 22:45:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <f47d4d57-afb2-3b39-fae9-3ed740a2b8a6@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 06/11/2019 02:57 PM, Vignesh Raghavendra wrote:

>>> Cypress' HyperBus is Low Signal Count, High Performance Double Data Rate
>>> Bus interface between a host system master and one or more slave
>>> interfaces. HyperBus is used to connect microprocessor, microcontroller,
>>> or ASIC devices with random access NOR flash memory (called HyperFlash)
>>> or self refresh DRAM (called HyperRAM).
>>>
>>> Its a 8-bit data bus (DQ[7:0]) with  Read-Write Data Strobe (RWDS)
>>> signal and either Single-ended clock(3.0V parts) or Differential clock
>>> (1.8V parts). It uses ChipSelect lines to select b/w multiple slaves.
>>> At bus level, it follows a separate protocol described in HyperBus
>>> specification[1].
>>>
>>> HyperFlash follows CFI AMD/Fujitsu Extended Command Set (0x0002) similar
>>> to that of existing parallel NORs. Since HyperBus is x8 DDR bus,
>>> its equivalent to x16 parallel NOR flash wrt bits per clock cycle. But
>>> HyperBus operates at >166MHz frequencies.
>>> HyperRAM provides direct random read/write access to flash memory
>>> array.
>>>
>>> But, HyperBus memory controllers seem to abstract implementation details
>>> and expose a simple MMIO interface to access connected flash.
>>>
>>> Add support for registering HyperFlash devices with MTD framework. MTD
>>> maps framework along with CFI chip support framework are used to support
>>> communicating with flash.
>>>
>>> Framework is modelled along the lines of spi-nor framework. HyperBus
>>> memory controller (HBMC) drivers calls hyperbus_register_device() to
>>> register a single HyperFlash device. HyperFlash core parses MMIO access
>>> information from DT, sets up the map_info struct, probes CFI flash and
>>> registers it with MTD framework.
>>>
>>> Some HBMC masters need calibration/training sequence[3] to be carried
>>> out, in order for DLL inside the controller to lock, by reading a known
>>> string/pattern. This is done by repeatedly reading CFI Query
>>> Identification String. Calibration needs to be done before trying to detect
>>> flash as part of CFI flash probe.
>>>
>>> HyperRAM is not supported at the moment.
>>>
>>> HyperBus specification can be found at[1]
>>> HyperFlash datasheet can be found at[2]
>>>
>>> [1] https://www.cypress.com/file/213356/download
>>> [2] https://www.cypress.com/file/213346/download
>>> [3] http://www.ti.com/lit/ug/spruid7b/spruid7b.pdf
>>>     Table 12-5741. HyperFlash Access Sequence
>>>
>>> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
>> [...]
>>> diff --git a/drivers/mtd/hyperbus/hyperbus-core.c b/drivers/mtd/hyperbus/hyperbus-core.c
>>> new file mode 100644
>>> index 000000000000..df1f75e10b1a
>>> --- /dev/null
>>> +++ b/drivers/mtd/hyperbus/hyperbus-core.c
>>> @@ -0,0 +1,191 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +//
>>> +// Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com/
>>> +// Author: Vignesh Raghavendra <vigneshr@ti.com>
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mtd/hyperbus.h>
>>> +#include <linux/mtd/map.h>
>>> +#include <linux/mtd/mtd.h>
>>> +#include <linux/mtd/cfi.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_address.h>
>>> +#include <linux/types.h>
>>> +
>>> +#define HYPERBUS_CALIB_COUNT 25
>>
>>    Mhm, I think I've already protested about this being #define'd here...
> 
> I thought you had agreed that default optional calibration routine can
> be part of core code and thus this #define.
> 
> Anyways, what is your preference here? Drop the constant and use a local
> variable in hyperbus_calibrate()?
> Or are you suggesting to move hyperbus_calibrate() TI's specific driver?

   I'm just not comfortable with the common HF code using quite an arbitrary
constant...

>> [...]
>>> diff --git a/include/linux/mtd/hyperbus.h b/include/linux/mtd/hyperbus.h
>>> new file mode 100644
>>> index 000000000000..ee2eefd822c9
>>> --- /dev/null
>>> +++ b/include/linux/mtd/hyperbus.h
>>> @@ -0,0 +1,91 @@
[...]
>>> + * @mtd: pointer to MTD struct
>>> + * @ctlr: pointer to HyperBus controller struct
>>> + * @memtype: type of memory device: HyperFlash or HyperRAM
>>> + * @registered: flag to indicate whether device is registered with MTD core
>>> + */
>>> +
>>> +struct hyperbus_device {
>>> +	struct map_info map;
>>> +	struct device_node *np;
>>> +	struct mtd_info *mtd;
>>> +	struct hyperbus_ctlr *ctlr;
>>> +	enum hyperbus_memtype memtype;
>>> +	bool registered;
>>> +};
>>> +
>>> +/**
>>> + * struct hyperbus_ops - struct representing custom HyperBus operations
>>> + * @read16: read 16 bit of data, usually from register/ID-CFI space
>>> + * @write16: write 16 bit of data, usually to register/ID-CFI space
>>
>>    Usually? How to differ the register/memory transfers if both are possible?

> CFI + map framework does not provide a way to differentiate b/w reg
> access vs memory access. read16()/write16() is used to either access
> registers or for sending various cmds like lock/unlock etc or for
> programming a single word.
> For regular read/writes copy_from() and copy_to() are used.

   In my case only copy_from() would exist -- no proper acceleration for
writes...

> Looking at HyperBus protocol, controllers would not need to
> differentiate b/w registers vs memory transfers for HyperFlash devices.
> So, I think I can drop read16/write16 and redirect these calls to
> copy_from()/copy_to()

   Doubt it, frankly speaking.

> I mainly added these functions keeping HyperRAM in mind. Idea was
> drivers would look at hyperbus_device->memtype and set to register
> access mode for HyperRAM in case of write16()/read16(). Looks like the
> interface is not intuitive enough
> So, will drop these and add it back when adding HyperRAM support.
> 
> Does that work for your HW as well?

   Don't think so...

   However, my HyperFlash driver could make use of the following #define's in
the HyperBus header:

#define HF_CMD_CA47		BIT(7)	/* Read */
#define HF_CMD_CA46		BIT(6)	/* Register space */
#define HF_CMD_CA45		BIT(5)	/* Linear burst */

#define HF_CMD_READ_REG		(HF_CMD_CA47 | HF_CMD_CA46)
#define HF_CMD_READ_MEM		HF_CMD_CA47
#define HF_CMD_WRITE_REG	HF_CMD_CA46
#define HF_CMD_WRITE_MEM	0

MBR, Sergei
