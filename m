Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E0DC47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8A020873
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 16:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfJDQnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:43:43 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55182 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbfJDQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 12:43:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Te4gntB_1570207414;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Te4gntB_1570207414)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 05 Oct 2019 00:43:37 +0800
Subject: Re: [PATCH] mm: vmscan: remove unused scan_control parameter from
 pageout()
To:     Michal Hocko <mhocko@kernel.org>
Cc:     mgorman@techsingularity.net, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1570124498-19300-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191004081612.GB9578@dhcp22.suse.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <f064f2e1-4f9f-c93d-e3d8-099be77fbcff@linux.alibaba.com>
Date:   Fri, 4 Oct 2019 09:43:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191004081612.GB9578@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/4/19 1:16 AM, Michal Hocko wrote:
> On Fri 04-10-19 01:41:38, Yang Shi wrote:
>> Since lumpy reclaim was removed in v3.5 scan_control is not used by
>> may_write_to_{queue|inode} and pageout() anymore, remove the unused
>> parameter.
> I haven't really checked whether it was the lumpy reclaim removal but it
> is clearly not used these days.

It was removed by commit c53919adc045bf803252e912f23028a68525753d ("mm: 
vmscan: remove lumpy reclaim").

>
>> Cc: Mel Gorman <mgorman@techsingularity.net>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks!
>
>> ---
>>   mm/vmscan.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index e5d52d6..17489b8 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -774,7 +774,7 @@ static inline int is_page_cache_freeable(struct page *page)
>>   	return page_count(page) - page_has_private(page) == 1 + page_cache_pins;
>>   }
>>   
>> -static int may_write_to_inode(struct inode *inode, struct scan_control *sc)
>> +static int may_write_to_inode(struct inode *inode)
>>   {
>>   	if (current->flags & PF_SWAPWRITE)
>>   		return 1;
>> @@ -822,8 +822,7 @@ static void handle_write_error(struct address_space *mapping,
>>    * pageout is called by shrink_page_list() for each dirty page.
>>    * Calls ->writepage().
>>    */
>> -static pageout_t pageout(struct page *page, struct address_space *mapping,
>> -			 struct scan_control *sc)
>> +static pageout_t pageout(struct page *page, struct address_space *mapping)
>>   {
>>   	/*
>>   	 * If the page is dirty, only perform writeback if that write
>> @@ -859,7 +858,7 @@ static pageout_t pageout(struct page *page, struct address_space *mapping,
>>   	}
>>   	if (mapping->a_ops->writepage == NULL)
>>   		return PAGE_ACTIVATE;
>> -	if (!may_write_to_inode(mapping->host, sc))
>> +	if (!may_write_to_inode(mapping->host))
>>   		return PAGE_KEEP;
>>   
>>   	if (clear_page_dirty_for_io(page)) {
>> @@ -1396,7 +1395,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>   			 * starts and then write it out here.
>>   			 */
>>   			try_to_unmap_flush_dirty();
>> -			switch (pageout(page, mapping, sc)) {
>> +			switch (pageout(page, mapping)) {
>>   			case PAGE_KEEP:
>>   				goto keep_locked;
>>   			case PAGE_ACTIVATE:
>> -- 
>> 1.8.3.1

