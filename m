Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0348C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D577020727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 20:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfKNU6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 15:58:23 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44776 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726567AbfKNU6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 15:58:23 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ti5F9SG_1573765096;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Ti5F9SG_1573765096)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Nov 2019 04:58:19 +0800
Subject: Re: [v2 PATCH] mm: migrate: handle freed page at the first place
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1573755869-106954-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191114185643.GM20866@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <360f448e-3c77-95a7-79a8-ff8c65e8c7ff@linux.alibaba.com>
Date:   Thu, 14 Nov 2019 12:58:16 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191114185643.GM20866@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/19 10:56 AM, Michal Hocko wrote:
> On Fri 15-11-19 02:24:29, Yang Shi wrote:
>> When doing migration if the freed page is met, we just return without
>> migrating it since it is pointless to migrate a freed page.  But, the
>> current code allocates target page unconditionally before handling freed
>> page, if the page is freed, the newly allocated will be just freed.  It
>> doesn't make too much sense and is just a waste of time although
>> migrating freed page is rare.
>>
>> So, handle freed page at the before that to avoid unnecessary page
>> allocation and free.
>>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> I would be really surprised if this led to any runtime visible effect
> but I do agree that one less put_page path looks slightly better. For
> that reason
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

>
>> ---
>> v2: * Keep thp migration support check before handling freed page per Michal Hocko
>>      * Fixed the build warning reported by 0-day
>>
>>   mm/migrate.c | 14 +++++---------
>>   1 file changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 4fe45d1..a8f87cb 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1168,15 +1168,11 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
>>   				   enum migrate_reason reason)
>>   {
>>   	int rc = MIGRATEPAGE_SUCCESS;
>> -	struct page *newpage;
>> +	struct page *newpage = NULL;
>>   
>>   	if (!thp_migration_supported() && PageTransHuge(page))
>>   		return -ENOMEM;
>>   
>> -	newpage = get_new_page(page, private);
>> -	if (!newpage)
>> -		return -ENOMEM;
>> -
>>   	if (page_count(page) == 1) {
>>   		/* page was freed from under us. So we are done. */
>>   		ClearPageActive(page);
>> @@ -1187,13 +1183,13 @@ static ICE_noinline int unmap_and_move(new_page_t get_new_page,
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
>> +	newpage = get_new_page(page, private);
>> +	if (!newpage)
>> +		return -ENOMEM;
>> +
>>   	rc = __unmap_and_move(page, newpage, force, mode);
>>   	if (rc == MIGRATEPAGE_SUCCESS)
>>   		set_page_owner_migrate_reason(newpage, reason);
>> -- 
>> 1.8.3.1
>>

