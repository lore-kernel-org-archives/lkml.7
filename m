Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342FAC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095122411A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 13:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfE3N3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 09:29:47 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38831 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726849AbfE3N3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 09:29:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TT0VdIh_1559222982;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TT0VdIh_1559222982)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 May 2019 21:29:42 +0800
Subject: Re: [PATCH 1/3] mm: thp: make deferred split shrinker memcg aware
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        shakeelb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1559047464-59838-1-git-send-email-yang.shi@linux.alibaba.com>
 <1559047464-59838-2-git-send-email-yang.shi@linux.alibaba.com>
 <20190530120718.52xuxgezkzsmaxqi@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <8c14a749-d94e-754d-656e-24e123ab28c6@linux.alibaba.com>
Date:   Thu, 30 May 2019 21:29:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190530120718.52xuxgezkzsmaxqi@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/19 8:07 PM, Kirill A. Shutemov wrote:
> On Tue, May 28, 2019 at 08:44:22PM +0800, Yang Shi wrote:
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index bc74d6a..9ff5fab 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -316,6 +316,12 @@ struct mem_cgroup {
>>   	struct list_head event_list;
>>   	spinlock_t event_list_lock;
>>   
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	struct list_head split_queue;
>> +	unsigned long split_queue_len;
>> +	spinlock_t split_queue_lock;
> Maybe we should wrap there into a struct and have helper that would return
> pointer to the struct which is right for the page: from pgdat or from
> memcg, depending on the situation?
>
> This way we will be able to kill most of code duplication, right?

Yes, it sounds simpler than using list_lru.

>

