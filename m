Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA05EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A082520821
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbfDQR0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:26:44 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:59634 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729641AbfDQR0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:26:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPa6XZW_1555521966;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPa6XZW_1555521966)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 18 Apr 2019 01:26:12 +0800
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
To:     Michal Hocko <mhocko@kernel.org>,
        Keith Busch <keith.busch@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <20190417152345.GB4786@localhost.localdomain>
 <20190417153923.GO5878@dhcp22.suse.cz>
 <20190417153739.GD4786@localhost.localdomain>
 <20190417163911.GA9523@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <fcb30853-8039-8154-7ae0-706930642576@linux.alibaba.com>
Date:   Wed, 17 Apr 2019 10:26:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190417163911.GA9523@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/19 9:39 AM, Michal Hocko wrote:
> On Wed 17-04-19 09:37:39, Keith Busch wrote:
>> On Wed, Apr 17, 2019 at 05:39:23PM +0200, Michal Hocko wrote:
>>> On Wed 17-04-19 09:23:46, Keith Busch wrote:
>>>> On Wed, Apr 17, 2019 at 11:23:18AM +0200, Michal Hocko wrote:
>>>>> On Tue 16-04-19 14:22:33, Dave Hansen wrote:
>>>>>> Keith Busch had a set of patches to let you specify the demotion order
>>>>>> via sysfs for fun.  The rules we came up with were:
>>>>> I am not a fan of any sysfs "fun"
>>>> I'm hung up on the user facing interface, but there should be some way a
>>>> user decides if a memory node is or is not a migrate target, right?
>>> Why? Or to put it differently, why do we have to start with a user
>>> interface at this stage when we actually barely have any real usecases
>>> out there?
>> The use case is an alternative to swap, right? The user has to decide
>> which storage is the swap target, so operating in the same spirit.
> I do not follow. If you use rebalancing you can still deplete the memory
> and end up in a swap storage. If you want to reclaim/swap rather than
> rebalance then you do not enable rebalancing (by node_reclaim or similar
> mechanism).

I'm a little bit confused. Do you mean just do *not* do reclaim/swap in 
rebalancing mode? If rebalancing is on, then node_reclaim just move the 
pages around nodes, then kswapd or direct reclaim would take care of swap?

If so the node reclaim on PMEM node may rebalance the pages to DRAM 
node? Should this be allowed?

I think both I and Keith was supposed to treat PMEM as a tier in the 
reclaim hierarchy. The reclaim should push inactive pages down to PMEM, 
then swap. So, PMEM is kind of a "terminal" node. So, he introduced 
sysfs defined target node, I introduced N_CPU_MEM.

>

