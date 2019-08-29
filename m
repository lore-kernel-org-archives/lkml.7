Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1990CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA724208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 16:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfH2Q62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 12:58:28 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:38548 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727087AbfH2Q62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 12:58:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TanJx0D_1567097902;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TanJx0D_1567097902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 30 Aug 2019 00:58:23 +0800
Subject: Re: [PATCH v2] vfio/type1: avoid redundant PageReserved checking
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190827124041.4f986005@x1.home>
 <3517844d6371794cff59b13bf9c2baf1dcbe571c.1566966365.git.luoben@linux.alibaba.com>
 <20190828095501.12e71bd3@x1.home>
From:   Ben Luo <luoben@linux.alibaba.com>
Message-ID: <6c234632-b7e9-45c7-3d70-51a4c83161f6@linux.alibaba.com>
Date:   Fri, 30 Aug 2019 00:58:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828095501.12e71bd3@x1.home>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/8/28 ÏÂÎç11:55, Alex Williamson Ð´µÀ:
> On Wed, 28 Aug 2019 12:28:04 +0800
> Ben Luo <luoben@linux.alibaba.com> wrote:
>
>> currently, if the page is not a tail of compound page, it will be
>> checked twice for the same thing.
>>
>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
>> ---
>>   drivers/vfio/vfio_iommu_type1.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 054391f..d0f7346 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>>   static bool is_invalid_reserved_pfn(unsigned long pfn)
>>   {
>>   	if (pfn_valid(pfn)) {
>> -		bool reserved;
>>   		struct page *tail = pfn_to_page(pfn);
>>   		struct page *head = compound_head(tail);
>> -		reserved = !!(PageReserved(head));
>>   		if (head != tail) {
>> +			bool reserved = PageReserved(head);
>>   			/*
>>   			 * "head" is not a dangling pointer
>>   			 * (compound_head takes care of that)
> Thinking more about this, the code here was originally just a copy of
> kvm_is_mmio_pfn() which was simplified in v3.12 with the commit below.
> Should we instead do the same thing here?  Thanks,
>
> Alex
ok, and kvm_is_mmio_pfn() has also been updated since then, I will take 
a look at that and compose a new patch
>
> commit 11feeb498086a3a5907b8148bdf1786a9b18fc55
> Author: Andrea Arcangeli <aarcange@redhat.com>
> Date:   Thu Jul 25 03:04:38 2013 +0200
>
>      kvm: optimize away THP checks in kvm_is_mmio_pfn()
>      
>      The checks on PG_reserved in the page structure on head and tail pages
>      aren't necessary because split_huge_page wouldn't transfer the
>      PG_reserved bit from head to tail anyway.
>      
>      This was a forward-thinking check done in the case PageReserved was
>      set by a driver-owned page mapped in userland with something like
>      remap_pfn_range in a VM_PFNMAP region, but using hugepmds (not
>      possible right now). It was meant to be very safe, but it's overkill
>      as it's unlikely split_huge_page could ever run without the driver
>      noticing and tearing down the hugepage itself.
>      
>      And if a driver in the future will really want to map a reserved
>      hugepage in userland using an huge pmd it should simply take care of
>      marking all subpages reserved too to keep KVM safe. This of course
>      would require such a hypothetical driver to tear down the huge pmd
>      itself and splitting the hugepage itself, instead of relaying on
>      split_huge_page, but that sounds very reasonable, especially
>      considering split_huge_page wouldn't currently transfer the reserved
>      bit anyway.
>      
>      Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>      Signed-off-by: Gleb Natapov <gleb@redhat.com>
>
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index d2836788561e..0fc25aed79a8 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -102,28 +102,8 @@ static bool largepages_enabled = true;
>   
>   bool kvm_is_mmio_pfn(pfn_t pfn)
>   {
> -       if (pfn_valid(pfn)) {
> -               int reserved;
> -               struct page *tail = pfn_to_page(pfn);
> -               struct page *head = compound_trans_head(tail);
> -               reserved = PageReserved(head);
> -               if (head != tail) {
> -                       /*
> -                        * "head" is not a dangling pointer
> -                        * (compound_trans_head takes care of that)
> -                        * but the hugepage may have been splitted
> -                        * from under us (and we may not hold a
> -                        * reference count on the head page so it can
> -                        * be reused before we run PageReferenced), so
> -                        * we've to check PageTail before returning
> -                        * what we just read.
> -                        */
> -                       smp_rmb();
> -                       if (PageTail(tail))
> -                               return reserved;
> -               }
> -               return PageReserved(tail);
> -       }
> +       if (pfn_valid(pfn))
> +               return PageReserved(pfn_to_page(pfn));
>   
>          return true;
>   }
