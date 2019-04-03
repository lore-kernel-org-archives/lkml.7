Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF2C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3D9F2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDCNM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:12:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39912 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCNM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:12:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEB58A78;
        Wed,  3 Apr 2019 06:12:27 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCED23F59C;
        Wed,  3 Apr 2019 06:12:24 -0700 (PDT)
Subject: Re: [PATCH 1/6] arm64/mm: Enable sysfs based memory hot add interface
To:     David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com
Cc:     mhocko@suse.com, mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, cai@lca.pw
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-2-git-send-email-anshuman.khandual@arm.com>
 <4b9dd2b0-3b11-608c-1a40-9a3d203dd904@redhat.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e5665673-60ab-eee8-bc05-53dafb941039@arm.com>
Date:   Wed, 3 Apr 2019 14:12:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <4b9dd2b0-3b11-608c-1a40-9a3d203dd904@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2019 09:20, David Hildenbrand wrote:
> On 03.04.19 06:30, Anshuman Khandual wrote:
>> Sysfs memory probe interface (/sys/devices/system/memory/probe) can accept
>> starting physical address of an entire memory block to be hot added into
>> the kernel. This is in addition to the existing ACPI based interface. This
>> just enables it with the required config CONFIG_ARCH_MEMORY_PROBE.
>>
> 
> We recently discussed that the similar interface for removal should
> rather be moved to a debug/test module
> 
> I wonder if we should try to do the same for the sysfs probing
> interface. Rather try to get rid of it than open the doors for more users.

Agreed - if this option even exists in a released kernel, there's a risk 
that distros will turn it on for the sake of it, and at that point arm64 
is stuck carrying the same ABI baggage as well.

If users turn up in future with a desperate and unavoidable need for the 
legacy half-an-API on arm64, we can always reconsider adding it at that 
point. It was very much deliberate that my original hot-add support did 
not include a patch like this one.

Robin.

>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/arm64/Kconfig | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 7e34b9e..a2418fb 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -266,6 +266,15 @@ config HAVE_GENERIC_GUP
>>   config ARCH_ENABLE_MEMORY_HOTPLUG
>>   	def_bool y
>>   
>> +config ARCH_MEMORY_PROBE
>> +	bool "Enable /sys/devices/system/memory/probe interface"
>> +	depends on MEMORY_HOTPLUG
>> +	help
>> +	  This option enables a sysfs /sys/devices/system/memory/probe
>> +	  interface for testing. See Documentation/memory-hotplug.txt
>> +	  for more information. If you are unsure how to answer this
>> +	  question, answer N.
>> +
>>   config SMP
>>   	def_bool y
>>   
>>
> 
> 
