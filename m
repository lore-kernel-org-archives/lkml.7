Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D2C010A2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1478121929
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388522AbfKEKTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:19:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388283AbfKEKTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:19:11 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7C982204E6E447042405;
        Tue,  5 Nov 2019 18:19:09 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 5 Nov 2019
 18:19:01 +0800
Subject: Re: [PATCH v2] mm/memory-failure.c: replace with page_shift() in
 add_to_kill()
To:     David Hildenbrand <david@redhat.com>, <n-horiguchi@ah.jp.nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
References: <543d8bc9-f2e7-3023-7c35-2e7ed67c0e82@huawei.com>
 <ff090004-2cf7-9c77-9c9e-7fc5aff90d35@redhat.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <0220b5ff-bc47-9616-3897-52fa1c674487@huawei.com>
Date:   Tue, 5 Nov 2019 18:18:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ff090004-2cf7-9c77-9c9e-7fc5aff90d35@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/11/5 17:50, David Hildenbrand wrote:
> On 05.11.19 10:38, Yunfeng Ye wrote:
>> The function page_shift() is supported after the commit 94ad9338109f
>> ("mm: introduce page_shift()").
>>
>> So replace with page_shift() in add_to_kill() for readability.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> ---
>> v1 -> v2:
>>   - add Reviewed-by and Acked-by
> 
> Note for the future: No need to resend if there were no code/documentation changes. Andrew will apply the tags when picking up the patch.
> 
ok, thanks.

>>
>>   mm/memory-failure.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 3151c87dff73..e48c50cac889 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -326,7 +326,7 @@ static void add_to_kill(struct task_struct *tsk, struct page *p,
>>       if (is_zone_device_page(p))
>>           tk->size_shift = dev_pagemap_mapping_shift(p, vma);
>>       else
>> -        tk->size_shift = compound_order(compound_head(p)) + PAGE_SHIFT;
>> +        tk->size_shift = page_shift(compound_head(p));
>>
>>       /*
>>        * Send SIGKILL if "tk->addr == -EFAULT". Also, as
>>
> 
> 

