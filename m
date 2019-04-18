Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F5EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F2A2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbfDRQYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:24:52 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38848 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725888AbfDRQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:24:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPecSvf_1555604676;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPecSvf_1555604676)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Apr 2019 00:24:40 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <20190417152345.GB4786@localhost.localdomain>
 <20190417153923.GO5878@dhcp22.suse.cz>
 <20190417153739.GD4786@localhost.localdomain>
 <20190417163911.GA9523@dhcp22.suse.cz>
 <fcb30853-8039-8154-7ae0-706930642576@linux.alibaba.com>
 <20190417175151.GB9523@dhcp22.suse.cz>
Message-ID: <bdc25ae2-bddd-1ecb-58b8-ce506274f1bb@linux.alibaba.com>
Date:   Thu, 18 Apr 2019 09:24:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190417175151.GB9523@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/19 10:51 AM, Michal Hocko wrote:
> On Wed 17-04-19 10:26:05, Yang Shi wrote:
>> On 4/17/19 9:39 AM, Michal Hocko wrote:
>>> On Wed 17-04-19 09:37:39, Keith Busch wrote:
>>>> On Wed, Apr 17, 2019 at 05:39:23PM +0200, Michal Hocko wrote:
>>>>> On Wed 17-04-19 09:23:46, Keith Busch wrote:
>>>>>> On Wed, Apr 17, 2019 at 11:23:18AM +0200, Michal Hocko wrote:
>>>>>>> On Tue 16-04-19 14:22:33, Dave Hansen wrote:
>>>>>>>> Keith Busch had a set of patches to let you specify the demotion order
>>>>>>>> via sysfs for fun.  The rules we came up with were:
>>>>>>> I am not a fan of any sysfs "fun"
>>>>>> I'm hung up on the user facing interface, but there should be some way a
>>>>>> user decides if a memory node is or is not a migrate target, right?
>>>>> Why? Or to put it differently, why do we have to start with a user
>>>>> interface at this stage when we actually barely have any real usecases
>>>>> out there?
>>>> The use case is an alternative to swap, right? The user has to decide
>>>> which storage is the swap target, so operating in the same spirit.
>>> I do not follow. If you use rebalancing you can still deplete the memory
>>> and end up in a swap storage. If you want to reclaim/swap rather than
>>> rebalance then you do not enable rebalancing (by node_reclaim or similar
>>> mechanism).
>> I'm a little bit confused. Do you mean just do *not* do reclaim/swap in
>> rebalancing mode? If rebalancing is on, then node_reclaim just move the
>> pages around nodes, then kswapd or direct reclaim would take care of swap?
> Yes, that was the idea I wanted to get through. Sorry if that was not
> really clear.
>
>> If so the node reclaim on PMEM node may rebalance the pages to DRAM node?
>> Should this be allowed?
> Why it shouldn't? If there are other vacant Nodes to absorb that memory
> then why not use it?
>
>> I think both I and Keith was supposed to treat PMEM as a tier in the reclaim
>> hierarchy. The reclaim should push inactive pages down to PMEM, then swap.
>> So, PMEM is kind of a "terminal" node. So, he introduced sysfs defined
>> target node, I introduced N_CPU_MEM.
> I understand that. And I am trying to figure out whether we really have
> to tream PMEM specially here. Why is it any better than a generic NUMA
> rebalancing code that could be used for many other usecases which are
> not PMEM specific. If you present PMEM as a regular memory then also use
> it as a normal memory.

This also makes some sense. We just look at PMEM from different point of 
view. Taking into account the performance disparity may outweigh 
treating it as a normal memory in this patchset.

A ridiculous idea, may we have two modes? One for "rebalancing", the 
other for "demotion"?



