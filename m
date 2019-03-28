Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80EBE20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfC1PU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:20:58 -0400
Received: from foss.arm.com ([217.140.101.70]:46102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfC1PU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:20:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74AB115AB;
        Thu, 28 Mar 2019 08:20:57 -0700 (PDT)
Received: from [192.168.100.242] (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 643EA3F557;
        Thu, 28 Mar 2019 08:20:56 -0700 (PDT)
Subject: Re: [PATCH 1/4] ACPI/PPTT: Add function to return ACPI 6.3 Identical
 tokens
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        James Morse <james.morse@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>
References: <20190326223938.5365-1-jeremy.linton@arm.com>
 <20190326223938.5365-2-jeremy.linton@arm.com>
 <CAJZ5v0g7DOTiP=UiyqW6wf7AWyK8bi93CGsAsg_T=6HJDWrQww@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <7b1a15e4-3d16-4c39-542b-f86a4451a592@arm.com>
Date:   Thu, 28 Mar 2019 10:20:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g7DOTiP=UiyqW6wf7AWyK8bi93CGsAsg_T=6HJDWrQww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First, thanks for taking a look at this.

On 3/28/19 5:04 AM, Rafael J. Wysocki wrote:
> On Tue, Mar 26, 2019 at 11:40 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> ACPI 6.3 adds a flag to indicate that child nodes are all
>> identical cores. This is useful to authoritatively determine
>> if a set of (possibly offline) cores are identical or not.
>>
>> Since the flag doesn't give us a unique id we can generate
>> one and use it to create bitmaps of sibling nodes, or simply
>> in a loop to determine if a subset of cores are identical.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   drivers/acpi/pptt.c  | 26 ++++++++++++++++++++++++++
>>   include/linux/acpi.h |  5 +++++
>>   2 files changed, 31 insertions(+)
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> index 065c4fc245d1..472c95ec816b 100644
>> --- a/drivers/acpi/pptt.c
>> +++ b/drivers/acpi/pptt.c
>> @@ -660,3 +660,29 @@ int find_acpi_cpu_topology_package(unsigned int cpu)
>>          return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>>                                            ACPI_PPTT_PHYSICAL_PACKAGE);
>>   }
>> +
>> +/**
>> + * find_acpi_cpu_topology_hetero_id() - Determine a unique implementation
> 
> Maybe "Get a core architecture tag"?

Sure.

> 
>> + * @cpu: Kernel logical cpu number
> 
> s/logical cpu/logical CPU/ please.

Sure.

> 
>> + *
>> + * Determine a unique heterogeneous ID for the given CPU. CPUs with the same
>> + * implementation should have matching IDs. Since this is a tree we can only
>> + * detect implementations where the heterogeneous flag is the parent to all
>> + * matching cores. AKA if a two socket machine has two different core types
>> + * in each socket this will end up being represented as four unique core types
>> + * rather than two.
> 
> I find it quite difficult to parse that comment, honestly.
> 
> AFAICS, the function returns a tag that will be the same for all cores
> with the same architecture in one package.  That is, if the package is
> heterogeneous and there are two types of cores in it, there will be
> two different tags.  Is this correct?

Yes, two ID/tags per package, but since there are two packages (in this 
example) its four different tags total. This is forced by the need to 
have a node with the PACKAGE flag set splitting up IDENTICAL cores 
within the tree. A simpler topology would hopefully be able to group all 
the identical cores in the machine together. But in the above case using 
only the PPTT tree, it may not be possible to authoritatively tell how 
many different core types are in the machine if there are more than two 
tag groupings. By itself those four tags in the above example may be 
four different core types, or only two. That is likely not a huge 
problem as a processor container, or MIDR, can be used to merge 
different tag groups together depending on the callers needs.

> 
>> + *
>> + * The returned ID can be used to group peers with identical implementation.
>> + *
>> + * The search terminates when a level is found with the identical implementation
>> + * flag set or we reach a root node.
>> + *
>> + * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
>> + * Otherwise returns a value which represents a group of identical cores
>> + * similar to this cpu.
>> + */
>> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>> +{
>> +       return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
>> +                                         ACPI_PPTT_ACPI_IDENTICAL);
>> +}
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index d5dcebd7aad3..1444fb042898 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -1309,6 +1309,7 @@ static inline int lpit_read_residency_count_address(u64 *address)
>>   #ifdef CONFIG_ACPI_PPTT
>>   int find_acpi_cpu_topology(unsigned int cpu, int level);
>>   int find_acpi_cpu_topology_package(unsigned int cpu);
>> +int find_acpi_cpu_topology_hetero_id(unsigned int cpu);
>>   int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
>>   #else
>>   static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
>> @@ -1319,6 +1320,10 @@ static inline int find_acpi_cpu_topology_package(unsigned int cpu)
>>   {
>>          return -EINVAL;
>>   }
>> +static int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>> +{
>> +       return -EINVAL;
>> +}
>>   static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
>>   {
>>          return -EINVAL;
>> --
>> 2.20.1
>>

