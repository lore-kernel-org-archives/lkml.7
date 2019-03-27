Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98B4F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732414AbfC0DlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:41:24 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:54931 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727511AbfC0DlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:41:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TNkXKFO_1553658075;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNkXKFO_1553658075)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Mar 2019 11:41:19 +0800
Subject: Re: [PATCH 06/10] mm: vmscan: demote anon DRAM pages to PMEM node
To:     Keith Busch <kbusch@kernel.org>
Cc:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <1553316275-21985-7-git-send-email-yang.shi@linux.alibaba.com>
 <20190324222040.GE31194@localhost.localdomain>
 <ceec5604-b1df-2e14-8966-933865245f1c@linux.alibaba.com>
 <20190327003541.GE4328@localhost.localdomain>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <39d8fb56-df60-9382-9b47-59081d823c3c@linux.alibaba.com>
Date:   Tue, 26 Mar 2019 20:41:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190327003541.GE4328@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/26/19 5:35 PM, Keith Busch wrote:
> On Mon, Mar 25, 2019 at 12:49:21PM -0700, Yang Shi wrote:
>> On 3/24/19 3:20 PM, Keith Busch wrote:
>>> How do these pages eventually get to swap when migration fails? Looks
>>> like that's skipped.
>> Yes, they will be just put back to LRU. Actually, I don't expect it would be
>> very often to have migration fail at this stage (but I have no test data to
>> support this hypothesis) since the pages have been isolated from LRU, so
>> other reclaim path should not find them anymore.
>>
>> If it is locked by someone else right before migration, it is likely
>> referenced again, so putting back to LRU sounds not bad.
>>
>> A potential improvement is to have sync migration for kswapd.
> Well, it's not that migration fails only if the page is recently
> referenced. Migration would fail if there isn't available memory in
> the migration node, so this implementation carries an expectation that
> migration nodes have higher free capacity than source nodes. And since
> your attempting THP's without ever splitting them, that also requires
> lower fragmentation for a successful migration.

Yes, it is possible. However, migrate_pages() already has logic to 
handle such case. If the target node has not enough space for migrating 
THP in a whole, it would split THP then retry with base pages.

Swapping THP has been optimized to swap in a whole too. It would try to 
add THP into swap cache in a whole, split THP if the attempt fails, then 
add base pages into swap cache.

So, I think we can leave this to migrate_pages() without splitting in 
advance all the time.

Thanks,
Yang

>
> Applications, however, may allocate and pin pages directly out of that
> migration node to the point it does not have so much free capacity or
> physical continuity, so we probably shouldn't assume it's the only way
> to reclaim pages.

