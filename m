Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9C3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E2B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfC0C7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:59:08 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55512 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726922AbfC0C7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:59:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0TNk2xdD_1553655539;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNk2xdD_1553655539)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 10:59:03 +0800
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz>
 <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
Date:   Tue, 26 Mar 2019 19:58:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190326183731.GV28406@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/19 11:37 AM, Michal Hocko wrote:
> On Tue 26-03-19 11:33:17, Yang Shi wrote:
>>
>> On 3/26/19 6:58 AM, Michal Hocko wrote:
>>> On Sat 23-03-19 12:44:25, Yang Shi wrote:
>>>> With Dave Hansen's patches merged into Linus's tree
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4
>>>>
>>>> PMEM could be hot plugged as NUMA node now. But, how to use PMEM as NUMA node
>>>> effectively and efficiently is still a question.
>>>>
>>>> There have been a couple of proposals posted on the mailing list [1] [2].
>>>>
>>>> The patchset is aimed to try a different approach from this proposal [1]
>>>> to use PMEM as NUMA nodes.
>>>>
>>>> The approach is designed to follow the below principles:
>>>>
>>>> 1. Use PMEM as normal NUMA node, no special gfp flag, zone, zonelist, etc.
>>>>
>>>> 2. DRAM first/by default. No surprise to existing applications and default
>>>> running. PMEM will not be allocated unless its node is specified explicitly
>>>> by NUMA policy. Some applications may be not very sensitive to memory latency,
>>>> so they could be placed on PMEM nodes then have hot pages promote to DRAM
>>>> gradually.
>>> Why are you pushing yourself into the corner right at the beginning? If
>>> the PMEM is exported as a regular NUMA node then the only difference
>>> should be performance characteristics (module durability which shouldn't
>>> play any role in this particular case, right?). Applications which are
>>> already sensitive to memory access should better use proper binding already.
>>> Some NUMA topologies might have quite a large interconnect penalties
>>> already. So this doesn't sound like an argument to me, TBH.
>> The major rationale behind this is we assume the most applications should be
>> sensitive to memory access, particularly for meeting the SLA. The
>> applications run on the machine may be agnostic to us, they may be sensitive
>> or non-sensitive. But, assuming they are sensitive to memory access sounds
>> safer from SLA point of view. Then the "cold" pages could be demoted to PMEM
>> nodes by kernel's memory reclaim or other tools without impairing the SLA.
>>
>> If the applications are not sensitive to memory access, they could be bound
>> to PMEM or allowed to use PMEM (nice to have allocation on DRAM) explicitly,
>> then the "hot" pages could be promoted to DRAM.
> Again, how is this different from NUMA in general?

It is still NUMA, users still can see all the NUMA nodes.

Introduced default allocation node mask (please refer to patch #1) to 
control the memory placement. Typically, the node mask just includes 
DRAM nodes. PMEM nodes are excluded by the node mask for memory allocation.

The node mask could be override by user per the discussion with Dan.

Thanks,
Yang


