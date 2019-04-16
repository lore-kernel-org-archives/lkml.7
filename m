Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B5C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938152173C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbfDPV7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:59:24 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:37204 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727136AbfDPV7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:59:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPUpGFx_1555451951;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPUpGFx_1555451951)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 17 Apr 2019 05:59:15 +0800
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
To:     Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <99320338-d9d3-74ca-5b07-6c3ca718800f@linux.alibaba.com>
Date:   Tue, 16 Apr 2019 14:59:10 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/19 2:22 PM, Dave Hansen wrote:
> On 4/16/19 12:19 PM, Yang Shi wrote:
>> would we prefer to try all the nodes in the fallback order to find the
>> first less contended one (i.e. DRAM0 -> PMEM0 -> DRAM1 -> PMEM1 -> Swap)?
> Once a page went to DRAM1, how would we tell that it originated in DRAM0
> and is following the DRAM0 path rather than the DRAM1 path?
>
> Memory on DRAM0's path would be:
>
> 	DRAM0 -> PMEM0 -> DRAM1 -> PMEM1 -> Swap
>
> Memory on DRAM1's path would be:
>
> 	DRAM1 -> PMEM1 -> DRAM0 -> PMEM0 -> Swap
>
> Keith Busch had a set of patches to let you specify the demotion order
> via sysfs for fun.  The rules we came up with were:
> 1. Pages keep no history of where they have been
> 2. Each node can only demote to one other node

Does this mean any remote node? Or just DRAM to PMEM, but remote PMEM 
might be ok?

> 3. The demotion path can not have cycles

I agree with these rules, actually my implementation does imply the 
similar rule. I tried to understand what Michal means. My current 
implementation expects to have demotion happen from the initiator to the 
target in the same local pair. But, Michal may expect to be able to 
demote to remote initiator or target if the local target is contended.

IMHO, demotion in the local pair makes things much simpler.

>
> That ensures that we *can't* follow the paths you described above, if we
> follow those rules...

Yes, it might create a circle.


