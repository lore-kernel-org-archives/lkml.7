Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5CAC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D180207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437552AbfFLJgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:36:36 -0400
Received: from foss.arm.com ([217.140.110.172]:48678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437526AbfFLJgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:36:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6773028;
        Wed, 12 Jun 2019 02:36:35 -0700 (PDT)
Received: from [10.1.196.93] (en101.cambridge.arm.com [10.1.196.93])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E27453F246;
        Wed, 12 Jun 2019 02:36:30 -0700 (PDT)
Subject: Re: [PATCH 03/13] driver_find_device: Unify the match function with
 class_find_device()
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, minyard@acm.org, linux@armlinux.org.uk,
        thierry.reding@gmail.com, will.deacon@arm.com, joro@8bytes.org,
        oberpar@linux.ibm.com, sebott@linux.ibm.com, airlied@linux.ie,
        daniel@ffwll.ch, nehal-bakulchandra.shah@amd.com,
        shyam-sundar.s-k@amd.com, borntraeger@de.ibm.com
References: <1559747630-28065-1-git-send-email-suzuki.poulose@arm.com>
 <1559747630-28065-4-git-send-email-suzuki.poulose@arm.com>
 <20190612093246.GE4797@dell>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <136ab9e5-694a-c277-5125-070df60453e3@arm.com>
Date:   Wed, 12 Jun 2019 10:36:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612093246.GE4797@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 12/06/2019 10:32, Lee Jones wrote:
> On Wed, 05 Jun 2019, Suzuki K Poulose wrote:
> 
>> The driver_find_device() accepts a match function pointer to
>> filter the devices for lookup, similar to bus/class_find_device().
>> However, there is a minor difference in the prototype for the
>> match parameter for driver_find_device() with the now unified
>> version accepted by {bus/class}_find_device(), where it doesn't
>> accept a "const" qualifier for the data argument. This prevents
>> us from reusing the generic match functions for driver_find_device().
>>
>> For this reason, change the prototype of the driver_find_device() to
>> make the "match" parameter in line with {bus/class}_find_device()
>> and adjust its callers to use the const qualifier. Also, we could
>> now promote the "data" parameter to const as we pass it down
>> as a const parameter to the match functions.
>>
>> Cc: Corey Minyard <minyard@acm.org>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Joerg Roedel <joro@8bytes.org>
>> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
>> Cc: Sebastian Ott <sebott@linux.ibm.com>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: Nehal Shah <nehal-bakulchandra.shah@amd.com>
>> Cc: Shyam Sundar S K <shyam-sundar.s-k@amd.com>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>>   drivers/mfd/altera-sysmgr.c          | 4 ++--
>>   drivers/mfd/syscon.c                 | 2 +-
> 
> I'm okay with the changes.  How do you plan on managing the merge?

Thanks for looking the changes.

I assume, Greg can pull this once we have got the Acks.
Btw, would you mind providing the necessary tags here if you are OK with it ?


Cheers
Suzuki
