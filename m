Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F01A20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfC1Tk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:40:26 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42508 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725885AbfC1Tk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:40:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TNrZtXd_1553802015;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNrZtXd_1553802015)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 29 Mar 2019 03:40:22 +0800
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
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
References: <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz>
 <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
 <20190327090100.GD11927@dhcp22.suse.cz>
 <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
 <c3690a19-e2a6-7db7-b146-b08aa9b22854@linux.alibaba.com>
 <20190327193918.GP11927@dhcp22.suse.cz>
 <6f8b4c51-3f3c-16f9-ca2f-dbcd08ea23e6@linux.alibaba.com>
 <20190328065802.GQ11927@dhcp22.suse.cz>
 <6487e0f5-aee4-3fea-00f5-c12602b8ad2b@linux.alibaba.com>
 <20190328191206.GC7155@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5934ed42-c512-a4c7-cbed-9062065bf276@linux.alibaba.com>
Date:   Thu, 28 Mar 2019 12:40:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190328191206.GC7155@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/19 12:12 PM, Michal Hocko wrote:
> On Thu 28-03-19 11:58:57, Yang Shi wrote:
>>
>> On 3/27/19 11:58 PM, Michal Hocko wrote:
>>> On Wed 27-03-19 19:09:10, Yang Shi wrote:
>>>> One question, when doing demote and promote we need define a path, for
>>>> example, DRAM <-> PMEM (assume two tier memory). When determining what nodes
>>>> are "DRAM" nodes, does it make sense to assume the nodes with both cpu and
>>>> memory are DRAM nodes since PMEM nodes are typically cpuless nodes?
>>> Do we really have to special case this for PMEM? Why cannot we simply go
>>> in the zonelist order? In other words why cannot we use the same logic
>>> for a larger NUMA machine and instead of swapping simply fallback to a
>>> less contended NUMA node? It can be a regular DRAM, PMEM or whatever
>>> other type of memory node.
>> Thanks for the suggestion. It makes sense. However, if we don't specialize a
>> pmem node, its fallback node may be a DRAM node, then the memory reclaim may
>> move the inactive page to the DRAM node, it sounds not make too much sense
>> since memory reclaim would prefer to move downwards (DRAM -> PMEM -> Disk).
> There are certainly many details to sort out. One thing is how to handle
> cpuless nodes (e.g. PMEM). Those shouldn't get any direct allocations
> without an explicit binding, right? My first naive idea would be to only

Wait a minute. I thought we were arguing about the default allocation 
node mask yesterday. And, the conclusion is PMEM node should not be 
excluded from the node mask. PMEM nodes are cpuless nodes. I think I 
should replace all "PMEM node" to "cpuless node" in the cover letter and 
commit logs to make it explicitly.

Quoted from Dan "For ACPI platforms the HMAT is effectively going to 
enforce "cpu-less" nodes for any memory range that has differentiated 
performance from the conventional memory pool, or differentiated 
performance for a specific initiator."

I apologize I didn't elaborate PMEM nodes are cpuless nodes at the first 
place. Of course, cpuless node may be not PMEM node.

To your question, yes, I do agree. Actually, this is what I mean about 
"DRAM only by default", or I should rephrase it to "exclude cpuless 
node", I thought they mean the same thing.

> migrate-on-reclaim only from the preferred node. We might need

If we exclude cpuless nodes, yes. The preferred node would be DRAM node 
only. Actually, the patchset does follow "migrate-on-reclaim only from 
the preferred node".

Thanks,
Yang

> additional heuristics but I wouldn't special case PMEM from other
> cpuless NUMA nodes.

