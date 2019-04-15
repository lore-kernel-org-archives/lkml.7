Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D407C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251DF2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbfDOWKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:10:12 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59956 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbfDOWKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:10:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPP1TeS_1555366205;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPP1TeS_1555366205)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Apr 2019 06:10:08 +0800
Subject: Re: [v2 PATCH 5/9] mm: vmscan: demote anon DRAM pages to PMEM node
To:     Dave Hansen <dave.hansen@intel.com>, mhocko@suse.com,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <1554955019-29472-6-git-send-email-yang.shi@linux.alibaba.com>
 <bc4cd9b2-327d-199b-6de4-61561b45c661@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <0f4d092d-1421-7163-d937-f8aa681db594@linux.alibaba.com>
Date:   Mon, 15 Apr 2019 15:10:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <bc4cd9b2-327d-199b-6de4-61561b45c661@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/19 7:31 AM, Dave Hansen wrote:
> On 4/10/19 8:56 PM, Yang Shi wrote:
>>   include/linux/gfp.h            |  12 ++++
>>   include/linux/migrate.h        |   1 +
>>   include/trace/events/migrate.h |   3 +-
>>   mm/debug.c                     |   1 +
>>   mm/internal.h                  |  13 +++++
>>   mm/migrate.c                   |  15 ++++-
>>   mm/vmscan.c                    | 127 +++++++++++++++++++++++++++++++++++------
>>   7 files changed, 149 insertions(+), 23 deletions(-)
> Yikes, that's a lot of code.
>
> And it only handles anonymous pages?

Yes, for the time being. But, it is easy to extend to all kind of pages.

>
> Also, I don't see anything in the code tying this to strictly demote
> from DRAM to PMEM.  Is that the end effect, or is it really implemented
> that way and I missed it?

No, not restrict to PMEM. It just tries to demote from "preferred node" 
(or called compute node) to a memory-only node. In the hardware with 
PMEM, PMEM would be the memory-only node.

Thanks,
Yang


