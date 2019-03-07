Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12984C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7DBE20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCGKtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:49:33 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:60330 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfCGKtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:49:32 -0500
Received: from [167.98.27.226] (helo=[10.35.4.91])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h1qaf-0003mR-Q8; Thu, 07 Mar 2019 10:49:29 +0000
Subject: Re: [PATCH] drm/i915/ddi: Fix default eDP detection on port A
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190306200618.17405-1-thomas.preston@codethink.co.uk>
 <874l8fm72f.fsf@intel.com>
 <a1434319-daba-756f-34c7-3ea653a9d2eb@codethink.co.uk>
 <87va0vkm6e.fsf@intel.com>
From:   Thomas Preston <thomas.preston@codethink.co.uk>
Message-ID: <1bc46e12-5cee-e3d0-83db-2feee4fe5210@codethink.co.uk>
Date:   Thu, 7 Mar 2019 10:49:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87va0vkm6e.fsf@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2019 10:34, Jani Nikula wrote:
>>> On Wed, 06 Mar 2019, Thomas Preston <thomas.preston@codethink.co.uk> wrote:
>>>> We rely on VBT DDI port info for eDP detection on GEN9 platforms and
>>>> above. This breaks GEN9 platforms which don't have VBT because port A
>>>> eDP now defaults to false. Fix this by defaulting to true when VBT is
>>>> missing.
>>>
>>> Please include more details about the machine that doesn't have VBT. Why
>>> don't you have VBT?
>>>
>>
>> We have upgraded from an earlier kernel version (an Intel BSP on v4.1)
>> which did not require VBT and so our BIOS isn't set up correctly. The
>> BIOS doesn't set ASLS and fails to find ACPI OpRegion:
>>
>> [    9.368433] [drm:intel_opregion_setup [i915]] graphic opregion physical addr: 0x0
>> [    9.368490] [drm:intel_opregion_setup [i915]] ACPI OpRegion not supported!
>>
>> So now our port A is DP instead of eDP. I was hoping a return to "default"
>> values would remedy this, but I think it's pretty clear now that we should
>> focus on fixing VBT.
> 
> In the long run you'll have better control of what your specific product
> does by using a VBT. However, I think we'll probably have to take the
> patch anyway.
> 

Would you like me to resubmit with the suggested changes?

>> I've found a default VBT in the BSP but not sure how to get it into BIOS.
>> If you could point me in the right direction here that would be really
>> useful!
> 
> There are dangers with default VBTs too. They might contain incorrect
> information about the specific board you have. You'll also have to set
> up the opregion, not just VBT.
> 

I believe OpRegion is being set up correctly with ACPI tables, but ASLS=0
(points to OpRegion) is quite suspicious. I need to do more digging around
how our BIOS is set up.

> I'm afraid I can't help you there. You already know where to look to see
> how the kernel side expects things to work.
> 
> For testing, the i915.vbt_firmware module parameter is helpful, so you
> don't need to change your BIOS to change the VBT.
> 

That's great thanks, I will work on VBT using this for now.
