Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E93C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907172184C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfKLACh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:02:37 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:40947 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726845AbfKLACh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:02:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0ThqC6Nj_1573516950;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ThqC6Nj_1573516950)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Nov 2019 08:02:33 +0800
Subject: Re: [PATCH] mm: migrate: handle freed page at the first place
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, mgorman@techsingularity.net, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1573510165-113395-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191111151801.fb206aa84cc8ab3059994f7e@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <efbaa7c3-5b56-5c7a-c7e8-b0977823a80f@linux.alibaba.com>
Date:   Mon, 11 Nov 2019 16:02:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191111151801.fb206aa84cc8ab3059994f7e@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/19 3:18 PM, Andrew Morton wrote:
> On Tue, 12 Nov 2019 06:09:25 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> When doing migration if the freed page is met, we just return without
>> migrating it since it is pointless to migrate a freed page.  But, the
>> current code did two things before handling freed page:
>>
>> 1. Return -ENOMEM if the page is THP and THP migration is not supported.
>> 2. Allocate target page unconditionally.
>>
>> Both makes not too much sense.  If we handle freed page at the first place
>> we don't have to worry about allocating/freeing target page and split
>> THP at all.
>>
>> For example (worst case) if we are trying to migrate a freed THP without
>> THP migration supported, the migrate_pages() would just split the THP then
>> retry to migrate base pages one by one by pointless allocating and freeing
>> pages, this is just waste of time.
>>
>> I didn't run into any actual problem with the current code (or I may
>> just not notice it yet), it was found by visual inspection.
>>
>>
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1170,13 +1170,6 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>>   	int rc = MIGRATEPAGE_SUCCESS;
>>   	struct page *newpage;
>>   
>> -	if (!thp_migration_supported() && PageTransHuge(page))
>> -		return -ENOMEM;
>> -
>> -	newpage = get_new_page(page, private);
>> -	if (!newpage)
>> -		return -ENOMEM;
>> -
>>   	if (page_count(page) == 1) {
> Is it possible to have (!thp_migration_supported() &&
> PageTransHuge(page) && page_count(page) == 1)?  If so, isn't this new
> behviour?

IMHO it should be possible on some architectures, i.e. aarch64, with 
anonymous THP. I just saw PowerPC and x86_64 have 
CONFIG_ARCH_ENABLE_THP_MIGRATION selected. I'm not quite sure if I miss 
something.

It should be not new behavior since migrate_pages() should just split 
the THP then retry with base pages one by one. Even though it returns 
-EBUSY due to THP split failure in the current code, the behavior sounds 
problematic. We should not return errno for a freed page, right?

>
>>   		/* page was freed from under us. So we are done. */
>>   		ClearPageActive(page);
>> @@ -1187,13 +1180,16 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>>   				__ClearPageIsolated(page);
>>   			unlock_page(page);
>>   		}
>> -		if (put_new_page)
>> -			put_new_page(newpage, private);
>> -		else
>> -			put_page(newpage);
>>   		goto out;
>>   	}
>>   
>> +	if (!thp_migration_supported() && PageTransHuge(page))
>> +		return -ENOMEM;
>> +
>> +	newpage = get_new_page(page, private);
>> +	if (!newpage)
>> +		return -ENOMEM;
>> +
>>   	rc = __unmap_and_move(page, newpage, force, mode);
>>   	if (rc == MIGRATEPAGE_SUCCESS)
>>   		set_page_owner_migrate_reason(newpage, reason);

