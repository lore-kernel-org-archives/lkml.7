Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2729DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56B0206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389723AbfDRQS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:18:26 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:51800 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389016AbfDRQSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:18:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TPeaAyH_1555604295;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPeaAyH_1555604295)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Apr 2019 00:18:18 +0800
Subject: Re: [QUESTIONS] THP allocation in NUMA fault migration path
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <aa34f38e-5e55-bdb2-133c-016b91245533@linux.alibaba.com>
 <20190418063218.GA6567@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <bb2464c9-dc45-eff1-b9ac-f29105ccd27b@linux.alibaba.com>
Date:   Thu, 18 Apr 2019 09:18:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190418063218.GA6567@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/19 11:32 PM, Michal Hocko wrote:
> On Wed 17-04-19 21:15:41, Yang Shi wrote:
>> Hi folks,
>>
>>
>> I noticed that there might be new THP allocation in NUMA fault migration
>> path (migrate_misplaced_transhuge_page()) even when THP is disabled (set to
>> "never"). When THP is set to "never", there should be not any new THP
>> allocation, but the migration path is kind of special. So I'm not quite sure
>> if this is the expected behavior or not?
>>
>>
>> And, it looks this allocation disregards defrag setting too, is this
>> expected behavior too?H
> Could you point to the specific code? But in general the miTgration path

Yes. The code is in migrate_misplaced_transhuge_page() called by 
do_huge_pmd_numa_page().

It would just do:
alloc_pages_node(node, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE), 
HPAGE_PMD_ORDER);
without checking if transparent_hugepage is enabled or not.

THP may be disabled before calling into do_huge_pmd_numa_page(). The 
do_huge_pmd_wp_page() does check if THP is disabled or not. If THP is 
disabled, it just tries to allocate 512 base pages.

> should allocate the memory matching the migration origin. If the origin
> was a THP then I find it quite natural if the target was a huge page as

Yes, this is what I would like to confirm. Migration allocates a new THP 
to replace the old one.

> well. How hard the allocation should try is another question and I
> suspect we do want to obedy the defrag setting.

Yes, I thought so too. However, THP NUMA migration was added in 3.8 by 
commit b32967f ("mm: numa: Add THP migration for the NUMA working set 
scanning fault case."). It disregarded defrag setting at the very 
beginning. So, I'm not quite sure if it was done on purpose or just 
forgot it.

Thanks,
Yang


