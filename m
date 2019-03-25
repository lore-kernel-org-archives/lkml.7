Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4201120863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 16:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbfCYQwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:52:09 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:38094 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCYQwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 12:52:09 -0400
Received: from [167.98.27.226] (helo=[10.35.5.150])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h8SpS-0000O4-KH; Mon, 25 Mar 2019 16:52:06 +0000
Subject: Re: [PATCH v2] Documentation: acpi: Add an example for PRP0001
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
References: <20190325151210.23226-1-thomas.preston@codethink.co.uk>
 <20190325153032.GG9224@smile.fi.intel.com>
 <3ae33d42-1175-bdbe-036b-1df5edc6a802@codethink.co.uk>
 <20190325163423.GJ9224@smile.fi.intel.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <2ccd44f4-5f5b-60db-d002-3f33dfcdd321@codethink.co.uk>
Date:   Mon, 25 Mar 2019 16:52:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190325163423.GJ9224@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2019 16:34, Andy Shevchenko wrote:
> On Mon, Mar 25, 2019 at 03:58:13PM +0000, Thomas Preston wrote:
>> On 25/03/2019 15:30, Andy Shevchenko wrote:
>>> On Mon, Mar 25, 2019 at 03:12:10PM +0000, Thomas Preston wrote:
>>>> Add an example for the magic PRP0001 device ID which allows matching
>>>> ACPI devices against drivers using OF Device Tree compatible property.
>>>
>>>> It wasn't clear to me that PRP0001 could be used in _CID.
>>>
>>> Yes, but it's not necessary to have it if we have defined a _HID.
>>>
>>> In that case PRP0001 is a temporary stub until corresponding driver
>>> incorporates an official _HID.
>>>
>>> On the contrary, when there is no official _HID available, PRP0001 can be used
>>> instead directly as a _HID and no _CID is needed.
>>>
>>
>> In that case, how do we uniquely identify devices in sysfs?
> 
> By their class, etc.
> 
> Identifying devices based in instance name is bad idea to start with.
> 
>> We have a
>> case where sound/soc/soc-core.c generates an i2c codec name i2c-TDA7802:00.
>> It is useful to identify that device by part name, rather than some indexed
>> generic PRP device i2c-PRP0001:04. I can achieve this with:
> 
> If TDA7802 is *official* _HID dedicated for that codec by vendor, add it to the
> driver...
> 
>> 	_HID("TDA7802")
> 
>> 	_CID("PRP0001")
>> 	...
>> 	compatible = "st,tda7802" // driver I want to load using OF DT
> 
> ...and these lines become unneeded.
> 
> The only case when both are needed is a time between one gets a case and actual
> ID appears in the upstream driver. Effectively means product developing stage.
> 
> P.S. Yes, I know that sometimes the platform/BIOS vendors abuse specification
> and ACPI ID registry and made up IDs, in that case we need to support them as a
> "de facto" quirks.
> 
> And yes, ASoC subsystem in ACPI case abuses Linux device hierarchy by matching
> by instance instead of matching by let say fwnode. It should be fixed there,
> not in ACPI table.
> 

Okay this is all really useful information. Thank you.

>>
>>> I would really recommend to look at the examples in meta-acpi repository. There
>>> are cases like described above.
>>>
>>> This one is good enough, though see below.
>>>
>>
>> I will drop the superfluous _CID - I think the example is still useful
>> to have. Even if we don't illustrate my special case for _HID/_CID.
> 
> Yes, I agree with that.
> 

I will remove _CID weirdness, and resend. I will deal with my special case
elsewhere. Thanks again
