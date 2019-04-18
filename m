Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86445C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD20214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389877AbfDRTXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:23:55 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:54297 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729641AbfDRTXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:23:54 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPeyaMj_1555615421;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPeyaMj_1555615421)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Apr 2019 03:23:47 +0800
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
To:     Keith Busch <keith.busch@intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, mgorman@techsingularity.net,
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
 <5c2d37e1-c7f6-5b7b-4f8e-a34e981b841e@intel.com>
 <20190418181643.GB7659@localhost.localdomain>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <8259dfd6-9044-b9f8-29b1-f427b4435eda@linux.alibaba.com>
Date:   Thu, 18 Apr 2019 12:23:41 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190418181643.GB7659@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/19 11:16 AM, Keith Busch wrote:
> On Wed, Apr 17, 2019 at 10:13:44AM -0700, Dave Hansen wrote:
>> On 4/17/19 2:23 AM, Michal Hocko wrote:
>>> yes. This could be achieved by GFP_NOWAIT opportunistic allocation for
>>> the migration target. That should prevent from loops or artificial nodes
>>> exhausting quite naturaly AFAICS. Maybe we will need some tricks to
>>> raise the watermark but I am not convinced something like that is really
>>> necessary.
>> I don't think GFP_NOWAIT alone is good enough.
>>
>> Let's say we have a system full of clean page cache and only two nodes:
>> 0 and 1.  GFP_NOWAIT will eventually kick off kswapd on both nodes.
>> Each kswapd will be migrating pages to the *other* node since each is in
>> the other's fallback path.
>>
>> I think what you're saying is that, eventually, the kswapds will see
>> allocation failures and stop migrating, providing hysteresis.  This is
>> probably true.
>>
>> But, I'm more concerned about that window where the kswapds are throwing
>> pages at each other because they're effectively just wasting resources
>> in this window.  I guess we should figure our how large this window is
>> and how fast (or if) the dampening occurs in practice.
> I'm still refining tests to help answer this and have some preliminary
> data. My test rig has CPU + memory Node 0, memory-only Node 1, and a
> fast swap device. The test has an application strict mbind more than
> the total memory to node 0, and forever writes random cachelines from
> per-cpu threads.

Thanks for the test. A follow-up question, how about the size for each 
node? Is node 1 bigger than node 0? Since PMEM typically has larger 
capacity, so I'm wondering whether the capacity may make things 
different or not.

> I'm testing two memory pressure policies:
>
>    Node 0 can migrate to Node 1, no cycles
>    Node 0 and Node 1 migrate with each other (0 -> 1 -> 0 cycles)
>
> After the initial ramp up time, the second policy is ~7-10% slower than
> no cycles. There doesn't appear to be a temporary window dealing with
> bouncing pages: it's just a slower overall steady state. Looks like when
> migration fails and falls back to swap, the newly freed pages occasionaly
> get sniped by the other node, keeping the pressure up.

