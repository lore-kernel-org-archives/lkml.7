Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF5C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE3D222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfDSS3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:10 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:34073 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbfDSS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:09 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TPjGOrH_1555691304;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPjGOrH_1555691304)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 20 Apr 2019 00:28:26 +0800
Subject: Re: [QUESTIONS] THP allocation in NUMA fault migration path
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <aa34f38e-5e55-bdb2-133c-016b91245533@linux.alibaba.com>
 <20190418063218.GA6567@dhcp22.suse.cz>
 <bb2464c9-dc45-eff1-b9ac-f29105ccd27b@linux.alibaba.com>
 <20190419111356.GK18914@techsingularity.net>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <e48a5899-7139-ba76-46e9-76bda4a7ab78@linux.alibaba.com>
Date:   Fri, 19 Apr 2019 09:28:21 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190419111356.GK18914@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/19 4:13 AM, Mel Gorman wrote:
> On Thu, Apr 18, 2019 at 09:18:15AM -0700, Yang Shi wrote:
>>
>> On 4/17/19 11:32 PM, Michal Hocko wrote:
>>> On Wed 17-04-19 21:15:41, Yang Shi wrote:
>>>> Hi folks,
>>>>
>>>>
>>>> I noticed that there might be new THP allocation in NUMA fault migration
>>>> path (migrate_misplaced_transhuge_page()) even when THP is disabled (set to
>>>> "never"). When THP is set to "never", there should be not any new THP
>>>> allocation, but the migration path is kind of special. So I'm not quite sure
>>>> if this is the expected behavior or not?
>>>>
>>>>
>>>> And, it looks this allocation disregards defrag setting too, is this
>>>> expected behavior too?H
>>> Could you point to the specific code? But in general the miTgration path
>> Yes. The code is in migrate_misplaced_transhuge_page() called by
>> do_huge_pmd_numa_page().
>>
>> It would just do:
>> alloc_pages_node(node, (GFP_TRANSHUGE_LIGHT | __GFP_THISNODE),
>> HPAGE_PMD_ORDER);
>> without checking if transparent_hugepage is enabled or not.
>>
>> THP may be disabled before calling into do_huge_pmd_numa_page(). The
>> do_huge_pmd_wp_page() does check if THP is disabled or not. If THP is
>> disabled, it just tries to allocate 512 base pages.
>>
>>> should allocate the memory matching the migration origin. If the origin
>>> was a THP then I find it quite natural if the target was a huge page as
>> Yes, this is what I would like to confirm. Migration allocates a new THP to
>> replace the old one.
>>
>>> well. How hard the allocation should try is another question and I
>>> suspect we do want to obedy the defrag setting.
>> Yes, I thought so too. However, THP NUMA migration was added in 3.8 by
>> commit b32967f ("mm: numa: Add THP migration for the NUMA working set
>> scanning fault case."). It disregarded defrag setting at the very beginning.
>> So, I'm not quite sure if it was done on purpose or just forgot it.
>>
> It was on purpose as migration due to NUMA misplacement was not intended
> to change the type of page used. It would be impossible to tell in advance
> if locality was more important than the page size from a performance point
> of view. This is particularly relevant if the workload is virtualised and
> there is an expectation that huge pages are preserved.  I'm not aware of
> any bugs whereby there was a complaint that the THP migration caused an
> excessive stall. It could be altered of course, but it would be preferred
> to have an example workload demonstrating the problem before making a
> decision.

Thanks a lot for elaborating the idea. I didn't run into any problem at 
the moment, just didn't get the thinking behind the choice since other 
page fault paths (i.e. wp) do allocate hugepages more aggressively.

>

