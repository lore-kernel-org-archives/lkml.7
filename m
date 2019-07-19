Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEAFC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D90021851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfGSA76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:59:58 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37053 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726015AbfGSA76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:59:58 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TXEfKGN_1563497991;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TXEfKGN_1563497991)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jul 2019 08:59:53 +0800
Subject: Re: list corruption in deferred_split_scan()
To:     Qian Cai <cai@lca.pw>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <1562795006.8510.19.camel@lca.pw>
 <cd6e10bc-cb79-65c5-ff2b-4c244ae5eb1c@linux.alibaba.com>
 <1562879229.8510.24.camel@lca.pw>
 <b38ee633-f8e0-00ee-55ee-2f0aaea9ed6b@linux.alibaba.com>
 <9F50D703-FF08-44FA-B1E5-4F8A2F8C7061@lca.pw>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <7a0c0092-40d1-eede-14dd-3c4c052edf0c@linux.alibaba.com>
Date:   Thu, 18 Jul 2019 17:59:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <9F50D703-FF08-44FA-B1E5-4F8A2F8C7061@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/18/19 5:54 PM, Qian Cai wrote:
>
>> On Jul 12, 2019, at 3:12 PM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>
>>
>>
>> On 7/11/19 2:07 PM, Qian Cai wrote:
>>> On Wed, 2019-07-10 at 17:16 -0700, Yang Shi wrote:
>>>> Hi Qian,
>>>>
>>>>
>>>> Thanks for reporting the issue. But, I can't reproduce it on my machine.
>>>> Could you please share more details about your test? How often did you
>>>> run into this problem?
>>> I can almost reproduce it every time on a HPE ProLiant DL385 Gen10 server. Here
>>> is some more information.
>>>
>>> # cat .config
>>>
>>> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
>> I tried your kernel config, but I still can't reproduce it. My compiler doesn't have retpoline support, so CONFIG_RETPOLINE is disabled in my test, but I don't think this would make any difference for this case.
>>
>> According to the bug call trace in the earlier email, it looks deferred _split_scan lost race with put_compound_page. The put_compound_page would call free_transhuge_page() which delete the page from the deferred split queue, but it may still appear on the deferred list due to some reason.
>>
>> Would you please try the below patch?
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index b7f709d..66bd9db 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -2765,7 +2765,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
>>          if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
>>                  if (!list_empty(page_deferred_list(head))) {
>>                          ds_queue->split_queue_len--;
>> -                       list_del(page_deferred_list(head));
>> +                       list_del_init(page_deferred_list(head));
>>                  }
>>                  if (mapping)
>>                          __dec_node_page_state(page, NR_SHMEM_THPS);
>> @@ -2814,7 +2814,7 @@ void free_transhuge_page(struct page *page)
>>          spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
>>          if (!list_empty(page_deferred_list(page))) {
>>                  ds_queue->split_queue_len--;
>> -               list_del(page_deferred_list(page));
>> +               list_del_init(page_deferred_list(page));
>>          }
>>          spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>>          free_compound_page(page);
> Unfortunately, I am no longer be able to reproduce the original list corruption with today’s linux-next.

It is because the patches have been dropped from -mm tree by Andrew due 
to this problem I guess. You have to use next-20190711, or apply the 
patches on today's linux-next.


