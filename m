Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED5ECA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33FA20820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 06:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504432AbfJRGmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 02:42:35 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42106 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730508AbfJRGmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 02:42:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TfNs02I_1571380952;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TfNs02I_1571380952)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Oct 2019 14:42:33 +0800
Subject: Re: [PATCH] vfio/type1: remove hugepage checks in
 is_invalid_reserved_pfn()
To:     alex.williamson@redhat.com
Cc:     aarcange@redhat.com, linux-kernel@vger.kernel.org
References: <1d6b7e1c40783f2db4c6cb15bf679a94222ec6a3.1570073993.git.luoben@linux.alibaba.com>
 <20191003164133.GG13922@redhat.com>
From:   Ben Luo <luoben@linux.alibaba.com>
Message-ID: <ae787a52-a7ed-f7b8-074f-ab8883037ac0@linux.alibaba.com>
Date:   Fri, 18 Oct 2019 14:42:32 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191003164133.GG13922@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A friendly reminder :)


Thanks,

     Ben

在 2019/10/4 上午12:41, Andrea Arcangeli 写道:
> On Thu, Oct 03, 2019 at 11:49:42AM +0800, Ben Luo wrote:
>> Currently, no hugepage split code can transfer the reserved bit
>> from head to tail during the split, so checking the head can't make
>> a difference in a racing condition with hugepage spliting.
>>
>> The buddy wouldn't allow a driver to allocate an hugepage if any
>> subpage is reserved in the e820 map at boot, if any driver sets the
>> reserved bit of head page before mapping the hugepage in userland,
>> it needs to set the reserved bit in all subpages to be safe.
>>
>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
>
>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 26 ++++----------------------
>>   1 file changed, 4 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 054391f..e2019ba 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -287,31 +287,13 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>>    * Some mappings aren't backed by a struct page, for example an mmap'd
>>    * MMIO range for our own or another device.  These use a different
>>    * pfn conversion and shouldn't be tracked as locked pages.
>> + * For compound pages, any driver that sets the reserved bit in head
>> + * page needs to set the reserved bit in all subpages to be safe.
>>    */
>>   static bool is_invalid_reserved_pfn(unsigned long pfn)
>>   {
>> -	if (pfn_valid(pfn)) {
>> -		bool reserved;
>> -		struct page *tail = pfn_to_page(pfn);
>> -		struct page *head = compound_head(tail);
>> -		reserved = !!(PageReserved(head));
>> -		if (head != tail) {
>> -			/*
>> -			 * "head" is not a dangling pointer
>> -			 * (compound_head takes care of that)
>> -			 * but the hugepage may have been split
>> -			 * from under us (and we may not hold a
>> -			 * reference count on the head page so it can
>> -			 * be reused before we run PageReferenced), so
>> -			 * we've to check PageTail before returning
>> -			 * what we just read.
>> -			 */
>> -			smp_rmb();
>> -			if (PageTail(tail))
>> -				return reserved;
>> -		}
>> -		return PageReserved(tail);
>> -	}
>> +	if (pfn_valid(pfn))
>> +		return PageReserved(pfn_to_page(pfn));
>>   
>>   	return true;
>>   }
>> -- 
>> 1.8.3.1
>>
