Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59861C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26E6420879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfCYT2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:28:20 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51393 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729548AbfCYT2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:28:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TNeJ6Wf_1553542093;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNeJ6Wf_1553542093)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Mar 2019 03:28:16 +0800
Subject: Re: [PATCH 01/10] mm: control memory placement by nodemask for two
 tier main memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-2-git-send-email-yang.shi@linux.alibaba.com>
 <CAPcyv4g5RoHhXhkKQaYkqYLN1y3KavbGeM1zVus-3fY5Q+JdxA@mail.gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <688dffbc-2adc-005d-223e-fe488be8c5fc@linux.alibaba.com>
Date:   Mon, 25 Mar 2019 12:28:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4g5RoHhXhkKQaYkqYLN1y3KavbGeM1zVus-3fY5Q+JdxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/19 10:21 AM, Dan Williams wrote:
> On Fri, Mar 22, 2019 at 9:45 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>> When running applications on the machine with NVDIMM as NUMA node, the
>> memory allocation may end up on NVDIMM node.  This may result in silent
>> performance degradation and regression due to the difference of hardware
>> property.
>>
>> DRAM first should be obeyed to prevent from surprising regression.  Any
>> non-DRAM nodes should be excluded from default allocation.  Use nodemask
>> to control the memory placement.  Introduce def_alloc_nodemask which has
>> DRAM nodes set only.  Any non-DRAM allocation should be specified by
>> NUMA policy explicitly.
>>
>> In the future we may be able to extract the memory charasteristics from
>> HMAT or other source to build up the default allocation nodemask.
>> However, just distinguish DRAM and PMEM (non-DRAM) nodes by SRAT flag
>> for the time being.
>>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   arch/x86/mm/numa.c     |  1 +
>>   drivers/acpi/numa.c    |  8 ++++++++
>>   include/linux/mmzone.h |  3 +++
>>   mm/page_alloc.c        | 18 ++++++++++++++++--
>>   4 files changed, 28 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
>> index dfb6c4d..d9e0ca4 100644
>> --- a/arch/x86/mm/numa.c
>> +++ b/arch/x86/mm/numa.c
>> @@ -626,6 +626,7 @@ static int __init numa_init(int (*init_func)(void))
>>          nodes_clear(numa_nodes_parsed);
>>          nodes_clear(node_possible_map);
>>          nodes_clear(node_online_map);
>> +       nodes_clear(def_alloc_nodemask);
>>          memset(&numa_meminfo, 0, sizeof(numa_meminfo));
>>          WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
>>                                    MAX_NUMNODES));
>> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
>> index 867f6e3..79dfedf 100644
>> --- a/drivers/acpi/numa.c
>> +++ b/drivers/acpi/numa.c
>> @@ -296,6 +296,14 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
>>                  goto out_err_bad_srat;
>>          }
>>
>> +       /*
>> +        * Non volatile memory is excluded from zonelist by default.
>> +        * Only regular DRAM nodes are set in default allocation node
>> +        * mask.
>> +        */
>> +       if (!(ma->flags & ACPI_SRAT_MEM_NON_VOLATILE))
>> +               node_set(node, def_alloc_nodemask);
> Hmm, no, I don't think we should do this. Especially considering
> current generation NVDIMMs are energy backed DRAM there is no
> performance difference that should be assumed by the non-volatile
> flag.

Actually, here I would like to initialize a node mask for default 
allocation. Memory allocation should not end up on any nodes excluded by 
this node mask unless they are specified by mempolicy.

We may have a few different ways or criteria to initialize the node 
mask, for example, we can read from HMAT (when HMAT is ready in the 
future), and we definitely could have non-DRAM nodes set if they have no 
performance difference (I'm supposed you mean NVDIMM-F  or HBM).

As long as there are different tiers, distinguished by performance, for 
main memory, IMHO, there should be a defined default allocation node 
mask to control the memory placement no matter where we get the information.

But, for now we haven't had such information ready for such use yet, so 
the SRAT flag might be a choice.

>
> Why isn't default SLIT distance sufficient for ensuring a DRAM-first
> default policy?

"DRAM-first" may sound ambiguous, actually I mean "DRAM only by 
default". SLIT should just can tell us what node is local what node is 
remote, but can't tell us the performance difference.

Thanks,
Yang


