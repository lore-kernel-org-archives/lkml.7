Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E501BC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4E4217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbfKFRnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:43:01 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53771 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727286AbfKFRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:43:01 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ThMmvMI_1573062176;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0ThMmvMI_1573062176)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Nov 2019 01:42:58 +0800
Subject: Re: [PATCH] mm: rmap: use VM_BUG_ON() in __page_check_anon_rmap()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1572973416-18532-1-git-send-email-yang.shi@linux.alibaba.com>
 <20191106082848.eukf2jnjqxlvxgnx@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <0d881dbe-b517-a68c-a61f-c4bfe18e75ca@linux.alibaba.com>
Date:   Wed, 6 Nov 2019 09:42:52 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20191106082848.eukf2jnjqxlvxgnx@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/19 12:28 AM, Kirill A. Shutemov wrote:
> On Wed, Nov 06, 2019 at 01:03:36AM +0800, Yang Shi wrote:
>> The __page_check_anon_rmap() just calls two BUG_ON()s protected by
>> CONFIG_DEBUG_VM, the #ifdef could be eliminated by using VM_BUG_ON().
>>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   mm/rmap.c | 6 ++----
>>   1 file changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index d17cbf3..39178eb 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1055,7 +1055,6 @@ static void __page_set_anon_rmap(struct page *page,
>>   static void __page_check_anon_rmap(struct page *page,
>>   	struct vm_area_struct *vma, unsigned long address)
>>   {
>> -#ifdef CONFIG_DEBUG_VM
>>   	/*
>>   	 * The page's anon-rmap details (mapping and index) are guaranteed to
>>   	 * be set up correctly at this point.
>> @@ -1068,9 +1067,8 @@ static void __page_check_anon_rmap(struct page *page,
>>   	 * are initially only visible via the pagetables, and the pte is locked
>>   	 * over the call to page_add_new_anon_rmap.
>>   	 */
>> -	BUG_ON(page_anon_vma(page)->root != vma->anon_vma->root);
>> -	BUG_ON(page_to_pgoff(page) != linear_page_index(vma, address));
>> -#endif
>> +	VM_BUG_ON(page_anon_vma(page)->root != vma->anon_vma->root);
>> +	VM_BUG_ON(page_to_pgoff(page) != linear_page_index(vma, address));
> Why not VM_BUG_ON_PAGE()?

Because I was not intended to change the behavior, just cleanup. We 
definitely could use VM_BUG_ON_PAGE() if that is preferred.

>

