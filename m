Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EAAC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46562075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfDOWGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:06:39 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53134 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725786AbfDOWGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:06:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TPPk8ij_1555365992;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPPk8ij_1555365992)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Apr 2019 06:06:35 +0800
Subject: Re: [v2 PATCH 7/9] mm: vmscan: check if the demote target node is
 contended or not
To:     Dave Hansen <dave.hansen@intel.com>, mhocko@suse.com,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <1554955019-29472-8-git-send-email-yang.shi@linux.alibaba.com>
 <6d40d60e-dde4-7d70-c7a8-1a444c70c3ff@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5082655c-6a24-a3d7-1b7d-bb256597890c@linux.alibaba.com>
Date:   Mon, 15 Apr 2019 15:06:27 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6d40d60e-dde4-7d70-c7a8-1a444c70c3ff@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/11/19 9:06 AM, Dave Hansen wrote:
> On 4/10/19 8:56 PM, Yang Shi wrote:
>> When demoting to PMEM node, the target node may have memory pressure,
>> then the memory pressure may cause migrate_pages() fail.
>>
>> If the failure is caused by memory pressure (i.e. returning -ENOMEM),
>> tag the node with PGDAT_CONTENDED.  The tag would be cleared once the
>> target node is balanced again.
>>
>> Check if the target node is PGDAT_CONTENDED or not, if it is just skip
>> demotion.
> This seems like an actively bad idea to me.
>
> Why do we need an *active* note to say the node is contended?  Why isn't
> just getting a failure back from migrate_pages() enough?  Have you
> observed this in practice?

The flag will be used to check if the target node is contended or not 
before moving the page into the demotion list. If the target node is 
contended (i.e. GFP_NOWAIT would likely fail), the page reclaim code 
even won't scan anonymous page list on swapless system. It will just try 
to reclaim page cache. This would save some scanning time.

Thanks,
Yang


