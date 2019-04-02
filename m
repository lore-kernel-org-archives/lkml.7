Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670C6C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E20320883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OkNMZf5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729807AbfDBJCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:02:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42718 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729636AbfDBJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:02:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3292EIJ109365;
        Tue, 2 Apr 2019 04:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554195734;
        bh=wtb5R5aI/GLh1gztO1w0I9ZF0gkIOauXSbF3PlpxYSQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OkNMZf5SSOaATWVlaUQnxeB1EMx0pg+Uo2oF0XYrkOuKA1ttRQ/dnRxSyVIGWJOO2
         ys72mH9OuV1kN9MM9HwZ5wYTLsoJzG+ypJtXhkkm0r9X+o2FAdcN6IjIsYHvXTs/x/
         avcD8KrqVSjYehQOfjVYKzKguKDVPOX2YazRuzwo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3292EqL015631
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 04:02:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 04:02:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 04:02:14 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32924m7119828;
        Tue, 2 Apr 2019 04:02:05 -0500
Subject: Re: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling
 status register
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "nsekhar@ti.com" <nsekhar@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "masonccyang@mxic.com.tw" <masonccyang@mxic.com.tw>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "sergei.shtylyov@cogentembedded.com" 
        <sergei.shtylyov@cogentembedded.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>
References: <20190321174548.9288-1-vigneshr@ti.com>
 <20190321174548.9288-2-vigneshr@ti.com>
 <f92362a0678b07d22ccc0f271fe3483dc77364a9.camel@infinera.com>
 <b1961c49-6795-89e7-e154-6270bf43d49c@ti.com>
 <107cd92703919f97f4cf2d9cd279b091bc90518e.camel@infinera.com>
 <08f5424f-3ce3-492a-d2b3-4798993d35b9@ti.com>
 <f0be796d3662f5b0016edfe73e8665b466b16d20.camel@infinera.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <470c9659-93bb-27ba-f425-ba6ee0c0c9b1@ti.com>
Date:   Tue, 2 Apr 2019 14:33:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <f0be796d3662f5b0016edfe73e8665b466b16d20.camel@infinera.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/03/19 10:54 PM, Joakim Tjernlund wrote:
> On Mon, 2019-03-25 at 22:36 +0530, Vignesh Raghavendra wrote:
>>
>> On 25/03/19 7:21 PM, Joakim Tjernlund wrote:
>>> On Mon, 2019-03-25 at 18:27 +0530, Vignesh Raghavendra wrote:
>>>> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>>>>
>>>>
>>>> Hi,
>>>>
>>>> On 21/03/19 11:41 PM, Joakim Tjernlund wrote:
>>>>> On Thu, 2019-03-21 at 23:15 +0530, Vignesh Raghavendra wrote:
>>>>>> HyperFlash devices are compliant with CFI AMD/Fujitsu Extended Command
>>>>>> Set(0x0002) for flash operations, therefore drivers/mtd/chips/cfi_cmdset_0002.c
>>>>>> can be use as is. But these devices do not support DQ polling method of
>>>>>> determining chip ready/good status. These flashes provide Status
>>>>>> Register whose bits can be polled to know status of flash operation.
>>>>>>
>>>>>> Cypress HyperFlash datasheet here[1], talks about CFI Amd/Fujitsu
>>>>>> Extended Query version 1.5. Bit 0 of "Software Features supported" field
>>>>>> of CFI Primary Vendor-Specific Extended Query table indicates
>>>>>> presence/absence of status register and Bit 1 indicates whether or not
>>>>>> DQ polling is supported. Using these bits, its possible to determine
>>>>>> whether flash supports DQ polling or need to use Status Register.
>>>>>>
>>>>>> Add support for polling status register to know device ready/status of
>>>>>> erase/write operations when DQ polling is not supported.
>>>>>
>>>>> Isn't this new Status scheme just a copy of Intels(cmdset_0001)?
>>>>
>>>> Yes, but with one difference: At the end of program/erase operation,
>>>> device directly enters status register mode and  starts reflecting
>>>> status register content at any address.
>>>> The device remains in the read status register state until another
>>>> command is written to the device. Therefore there is notion of device is
>>>> in "status register read mode" (FL_STATUS) state
>>>
>>> That seems to vary and long time ago RMK added this:
>>> 		/* If the flash has finished erasing, then 'erase suspend'
>>> 		 * appears to make some (28F320) flash devices switch to
>>> 		 * 'read' mode.  Make sure that we switch to 'read status'
>>> 		 * mode so we get the right data. --rmk
>>> 		 */
>>> 		map_write(map, CMD(0x70), chip->in_progress_block_addr);
>>>
>>
>> This behavior is expected with cmdset_0001. Because "The device remains
>> in the read status register state until another command is written",
>> therefore "erase suspend' command after erase completion will switch
>> device to read mode. And therefore read status is safe thing to do for
>> cmdset_0001.
>>
>> But in case of cmdset_0002 erase completion will not put device to read
>> status mode and therefore no special status tracking is required.
>>
>>>> But in case of cfi_cmdset_0002, once program/erase operation is
>>>> complete, device returns to previous address space overlay from which
>>>> operation was started from (mostly read mode)
>>>
>>> I hope you can do the same as Intel here, issue an explicit Status CMD or you will be in trouble.
>>
>> Even if we issue Read Status command to enter read status mode, any
>> single subsequent read will put device back to read mode. So, sending
>> explicit Status CMD is of not much use.
>>
>> As long as cmdset_0002 driver ensures sending Read Status cmd and next
>> single read can be done in one go (ie. mutex held), I don't see any
>> trouble here. This is already take care off.
> 
> Ouch, a non sticky Status sounds borken. Are you sure that nothing can change the
> chip between you issue the Status CMD and read out of status bits?
> Like if an erase/suspend/resume completes just after Status CMD but before Status readout?
> 

Yes, I did some tests(with HyperFlash) and erase/program
completion/suspend in b/w issue of Status CMD but before status readout
does not result in exiting status read address space overlay. So we are
safe here with non sticky Status.


-- 
Regards
Vignesh
