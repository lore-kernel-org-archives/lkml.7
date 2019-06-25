Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCCFC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE7C205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfFYWdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 18:33:47 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41517 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfFYWdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 18:33:47 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TVCOb2O_1561502020;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TVCOb2O_1561502020)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 Jun 2019 06:33:44 +0800
Subject: Re: [v3 PATCH 4/4] mm: thp: make deferred split shrinker memcg aware
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     ktkhai@virtuozzo.com, kirill.shutemov@linux.intel.com,
        hannes@cmpxchg.org, mhocko@suse.com, hughd@google.com,
        shakeelb@google.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1560376609-113689-1-git-send-email-yang.shi@linux.alibaba.com>
 <1560376609-113689-5-git-send-email-yang.shi@linux.alibaba.com>
 <20190625150040.feb6ea9d11fff73a57320a3c@linux-foundation.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b21bc991-b375-82d8-46f3-a5a9779b79c9@linux.alibaba.com>
Date:   Tue, 25 Jun 2019 15:33:40 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190625150040.feb6ea9d11fff73a57320a3c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/25/19 3:00 PM, Andrew Morton wrote:
> On Thu, 13 Jun 2019 05:56:49 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>> Currently THP deferred split shrinker is not memcg aware, this may cause
>> premature OOM with some configuration. For example the below test would
>> run into premature OOM easily:
>>
>> $ cgcreate -g memory:thp
>> $ echo 4G > /sys/fs/cgroup/memory/thp/memory/limit_in_bytes
>> $ cgexec -g memory:thp transhuge-stress 4000
>>
>> transhuge-stress comes from kernel selftest.
>>
>> It is easy to hit OOM, but there are still a lot THP on the deferred
>> split queue, memcg direct reclaim can't touch them since the deferred
>> split shrinker is not memcg aware.
>>
>> Convert deferred split shrinker memcg aware by introducing per memcg
>> deferred split queue.  The THP should be on either per node or per memcg
>> deferred split queue if it belongs to a memcg.  When the page is
>> immigrated to the other memcg, it will be immigrated to the target
>> memcg's deferred split queue too.
>>
>> Reuse the second tail page's deferred_list for per memcg list since the
>> same THP can't be on multiple deferred split queues.
>>
>> ...
>>
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -4579,6 +4579,11 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>>   #ifdef CONFIG_CGROUP_WRITEBACK
>>   	INIT_LIST_HEAD(&memcg->cgwb_list);
>>   #endif
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	spin_lock_init(&memcg->deferred_split_queue.split_queue_lock);
>> +	INIT_LIST_HEAD(&memcg->deferred_split_queue.split_queue);
>> +	memcg->deferred_split_queue.split_queue_len = 0;
>> +#endif
>>   	idr_replace(&mem_cgroup_idr, memcg, memcg->id.id);
>>   	return memcg;
>>   fail:
>> @@ -4949,6 +4954,14 @@ static int mem_cgroup_move_account(struct page *page,
>>   		__mod_memcg_state(to, NR_WRITEBACK, nr_pages);
>>   	}
>>   
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +	if (compound && !list_empty(page_deferred_list(page))) {
>> +		spin_lock(&from->deferred_split_queue.split_queue_lock);
>> +		list_del(page_deferred_list(page));
> It's worrisome that this page still appears to be on the deferred_list
> and that the above if() would still succeed.  Should this be
> list_del_init()?

list_del_init() sounds safe although I'm not quite sure this is 
possible. Will update this with fixing build issue together.

>
>> +		from->deferred_split_queue.split_queue_len--;
>> +		spin_unlock(&from->deferred_split_queue.split_queue_lock);
>> +	}
>> +#endif

