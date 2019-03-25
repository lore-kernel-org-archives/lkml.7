Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB009C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DFA20879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbfCYUFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:05:10 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:49446 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729610AbfCYUFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:05:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNeJAtn_1553544298;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNeJAtn_1553544298)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Mar 2019 04:05:05 +0800
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
To:     Brice Goglin <Brice.Goglin@inria.fr>, mhocko@suse.com,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <cc6f44e2-48b5-067f-9685-99d8ae470b50@inria.fr>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <33b4d3ff-3a8d-d565-53b6-cde6310ddbef@linux.alibaba.com>
Date:   Mon, 25 Mar 2019 13:04:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cc6f44e2-48b5-067f-9685-99d8ae470b50@inria.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/19 9:15 AM, Brice Goglin wrote:
> Le 23/03/2019 à 05:44, Yang Shi a écrit :
>> With Dave Hansen's patches merged into Linus's tree
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4
>>
>> PMEM could be hot plugged as NUMA node now. But, how to use PMEM as NUMA node
>> effectively and efficiently is still a question.
>>
>> There have been a couple of proposals posted on the mailing list [1] [2].
>>
>> The patchset is aimed to try a different approach from this proposal [1]
>> to use PMEM as NUMA nodes.
>>
>> The approach is designed to follow the below principles:
>>
>> 1. Use PMEM as normal NUMA node, no special gfp flag, zone, zonelist, etc.
>>
>> 2. DRAM first/by default. No surprise to existing applications and default
>> running. PMEM will not be allocated unless its node is specified explicitly
>> by NUMA policy. Some applications may be not very sensitive to memory latency,
>> so they could be placed on PMEM nodes then have hot pages promote to DRAM
>> gradually.
>
> I am not against the approach for some workloads. However, many HPC
> people would rather do this manually. But there's currently no easy way
> to find out from userspace whether a given NUMA node is DDR or PMEM*. We
> have to assume HMAT is available (and correct) and look at performance
> attributes. When talking to humans, it would be better to say "I
> allocated on the local DDR NUMA node" rather than "I allocated on the
> fastest node according to HMAT latency".

Yes, I agree to have some information exposed to kernel or userspace to 
tell what nodes are DRAM nodes what nodes are not (maybe HBM or PMEM). I 
assume the default allocation should end up on DRAM nodes for the most 
workloads. If someone would like to control this manually other than 
mempolicy, the default allocation node mask may be exported to user 
space by sysfs so that it can be changed on demand.

>
> Also, when we'll have HBM+DDR, some applications may want to use DDR by
> default, which means they want the *slowest* node according to HMAT (by
> the way, will your hybrid policy work if we ever have HBM+DDR+PMEM?).
> Performance attributes could help, but how does user-space know for sure
> that X>Y will still mean HBM>DDR and not DDR>PMEM in 5 years?

This is what I mentioned above we need the information exported from 
HMAT or anything similar to tell us what nodes are DRAM nodes since DRAM 
may be the lowest tier memory.

Or we may be able to assume the nodes associated with CPUs are DRAM 
nodes by assuming both HBM and PMEM is CPU less node.

Thanks,
Yang

>
> It seems to me that exporting a flag in sysfs saying whether a node is
> PMEM could be convenient. Patch series [1] exported a "type" in sysfs
> node directories ("pmem" or "dram"). I don't know how if there's an easy
> way to define what HBM is and expose that type too.
>
> Brice
>
> * As far as I know, the only way is to look at all DAX devices until you
> find the given NUMA node in the "target_node" attribute. If none, you're
> likely not PMEM-backed.
>
>
>> [1]: https://lore.kernel.org/linux-mm/20181226131446.330864849@intel.com/

