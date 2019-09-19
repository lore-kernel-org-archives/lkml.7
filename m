Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E713AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06712067B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732706AbfISOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:42:29 -0400
Received: from foss.arm.com ([217.140.110.172]:59920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732606AbfISOm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:42:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02528337;
        Thu, 19 Sep 2019 07:42:28 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFF463F575;
        Thu, 19 Sep 2019 07:42:25 -0700 (PDT)
Subject: Re: [UNVERIFIED SENDER] Re: [UNVERIFIED SENDER] Re: [PATCH v2 2/3]
 soc: amazon: al-pos: Introduce Amazon's Annapurna Labs POS driver
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, mchehab+samsung@kernel.org,
        shawn.lin@rock-chips.com, gregkh@linuxfoundation.org,
        dwmw@amazon.co.uk, benh@kernel.crashing.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1568142310-17622-1-git-send-email-talel@amazon.com>
 <1568142310-17622-3-git-send-email-talel@amazon.com>
 <86d0g6syva.wl-maz@kernel.org>
 <3205f7ae-5568-c064-23ac-ea726246173b@amazon.com>
 <865zlxsxtd.wl-maz@kernel.org>
 <36f19b3f-46d3-f6d0-3681-71e3a9bb52ce@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <93e5ac72-13e1-4672-16f0-62ee6b8a8390@arm.com>
Date:   Thu, 19 Sep 2019 15:42:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <36f19b3f-46d3-f6d0-3681-71e3a9bb52ce@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 12/09/2019 10:19, Shenhar, Talel wrote:
> On 9/12/2019 11:50 AM, Marc Zyngier wrote:
>> On Thu, 12 Sep 2019 07:50:03 +0100,
>> "Shenhar, Talel" <talel@amazon.com> wrote:
>>> On 9/11/2019 5:15 PM, Marc Zyngier wrote:
>>>> On Tue, 10 Sep 2019 20:05:09 +0100,
>>>> Talel Shenhar <talel@amazon.com> wrote:
>>>>> +    if (!FIELD_GET(AL_POS_ERROR_LOG_1_VALID, log1))
>>>>> +        return IRQ_NONE;
>>>>> +
>>>>> +    log0 = readl(pos->mmio_base + AL_POS_ERROR_LOG_0);
>>>>> +    writel(0, pos->mmio_base + AL_POS_ERROR_LOG_1);
>>>>> +
>>>>> +    addr = FIELD_GET(AL_POS_ERROR_LOG_0_ADDR_LOW, log0);
>>>>> +    addr |= (FIELD_GET(AL_POS_ERROR_LOG_1_ADDR_HIGH, log1) << 32);
>>>>> +    request_id = FIELD_GET(AL_POS_ERROR_LOG_1_REQUEST_ID, log1);
>>>>> +    bresp = FIELD_GET(AL_POS_ERROR_LOG_1_BRESP, log1);
>>>>> +
>>>>> +    dev_err(&pdev->dev, "addr=0x%llx request_id=0x%x bresp=0x%x\n",
>>>>> +        addr, request_id, bresp);

>>>> What is this information? How do we make use of it? Given that this is
>>>> asynchronous, how do we correlate it to the offending software?

>>> Indeed this information arriving from the HW is asynchronous.
>>>
>>> There is no direct method to get the offending software.
>>>
>>> There are all kinds of hacks we do to find the offending software once
>>> we find this error. most of the time its a new patch introduced but
>>> some of the time is just digging.

>> OK, so that the moment, this is more of a debug tool than anything
>> else, right?

> Not sure what do you mean by debug tool. this is used to capture iliigle access and allow
> panic() based on them or simple logging.

Plumbing this into edac as a 'device' gives you the existing/standard interface for
user-space. For example the 'panic_on_ue' that is exposed via sysfs, this saves you having
another interface to toggle it for your driver. You can then use the existing distro tools
to drive/monitor/sample it.


>>>> The whole think looks to me like a poor man's EDAC handling, and I'd
>>>> expect to be plugged in that subsystem instead. Any reason why this
>>>> isn't the case? It would certainly make the handling uniform for the
>>>> user.

>>> This logic was not plugged into EDAC as there is no "Correctable"
>>> error here. its just error event. Not all errors are EDAC in the sense
>>> of Error Detection And *Correction*. There are no correctable errors
>>> for this driver.

>> I'd argue the opposite! Because you obviously don't let a read-only
>> register being written to, the error has been corrected, and you
>> signal the correction status.

> Not the meaning of corrected from my point of view - the system as a whole (sw&hw) are not
> working state. a driver thinks it configured the system to do A while the system doesn't
> really do that. and the critical part is that the driver that did operation A doesn't even
> have a way to know it.
> 
> So I would not call this corrected.

I don't think corrected/uncorrected helps here. If the register is read-only, and software
writes to it, its a software bug.

(from the v8.2's RAS extensions view, its somewhere between unrecoverable and uncontained)


>>> So plugging it  under EDAC seems like abusing the EDAC system.

If EDAC doesn't do what you need, it can always be extended.


>>> Now that I've emphasize the reason for not putting this under EDAC,
>>> what do you think? should this "only uncorrectable event" driver
>>> should be part of EDAC?

Sure, (its for memory controllers, but:) enum edac_type has a EDAC_EC: "Error Checking, no
correction". This wouldn't be the only device that only reports uncorrectable errors.


>> My choice would be to plug it into the EDAC subsystem, and report all
>> interrupts as "Corrected" events. Optionally, and only if you are
>> debugging something that requires it, report the error as
>> "Uncorrectable", in which case the EDAC subsystem should trigger a
>> panic.

>> At least you'd get the infrastructure, logging and tooling that the
>> EDAC subsystem offers (parsing the kernel log doesn't really count).

> I see what you say. However, I don't see too much added value in plugging this to EDAC and
> feel like it would abuse EDAC framework.

> James, will love your input from EDAC point of view, does it make sense to plug
> un-correctable only event to EDAC?

I think this device is an example of something like a "Fabric switch units" in
Documentation/driver-api/edac.rst. It makes sense that it should be described as a
'device' to edac. You can then use the existing user-space tools to control/report/monitor
the values.


Thanks,

James
