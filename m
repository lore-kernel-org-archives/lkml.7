Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179302087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbfCYS15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:27:57 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53238 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYS15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:27:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 766A91596;
        Mon, 25 Mar 2019 11:27:56 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BE513F575;
        Mon, 25 Mar 2019 11:27:54 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] EDAC: add EDAC driver for DMC520
To:     Borislav Petkov <bp@alien8.de>, Rui Zhao <ruizhao@outlook.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        Rui Zhao <ruizhao@microsoft.com>
References: <BN7PR08MB5572D3A5217C4749AC4E7DC4AE4C0@BN7PR08MB5572.namprd08.prod.outlook.com>
 <20190323092342.GD23698@zn.tnic>
From:   James Morse <james.morse@arm.com>
Message-ID: <c1a16ab4-72d9-f736-065c-b80858f85b7b@arm.com>
Date:   Mon, 25 Mar 2019 18:27:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190323092342.GD23698@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 23/03/2019 09:23, Borislav Petkov wrote:
> On Thu, Mar 07, 2019 at 01:24:01AM +0000, Rui Zhao wrote:
>> From: Rui Zhao <ruizhao@microsoft.com>
>>
>> New driver supports error detection and correction on
>> the devices with ARM DMC-520 memory controller.

A question/suggestion on the direction...

Could we avoid probing the driver based on the root hardware compatible?
Could we use the device/chip/platform specific one instead?


We want to avoid per-function edac drivers. If ${my_chip} has edac support for L3 and
memory, I should have a ${my_chip}_edac driver that pulls in the appropriate L3 and memory
code, and presents a sensible view to edac_core.

Thinking out loud...

You have:

>> +static const struct of_device_id dmc520_edac_driver_id[] = {
>> +	{ .compatible = "arm,dmc-520", },
>> +	{ /* end of table */ }
>> +};
>> +

If you wanted to add another device with edac support, we'd ask you to create
${your_chip}_edac driver and pull in the DMC520 and the other device.

But probing the 'arm,dmc-520' compatible like this leaves us in a tricky place if someone
else does this: ${their_device} probes the dmc520 like this too, but they can't stop it on
their platform as it will break yours...


It's normal to have a specific compatible, vexpress has:
| compatible = "arm,vexpress,v2f-2xv6,ca7x3", "arm,vexpress,v2f-2xv6", "arm,vexpress";

Could we do the same here:
| compatible = "vendor,soc-name-dmc520", "arm,dmc-520";

or even:
| compatible = "microsoft,product-name-dmc520", "arm,dmc-520";
if there is some firmware/board configuration that means vendor/soc isn't precise enough.

Then we always probe the driver from "vendor,soc-name-dmc520", never from "arm,dmc520".

This means we grow a list of vendor/soc-name that are using this driver, but if one of
them wants to support a second edac device, we can remove their vendor/soc-name from the
list without affecting anyone else.


Thanks,

James
