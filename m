Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA17C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EF0215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfIBIIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:08:20 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:9320 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729475AbfIBIIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:08:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R361e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Tb6xSxi_1567411089;
Received: from bn0418deMacBook-Pro.local(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tb6xSxi_1567411089)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 15:58:10 +0800
Subject: Re: [PATCH v2] vfio/type1: avoid redundant PageReserved checking
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     cohuck@redhat.com, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
References: <20190827124041.4f986005@x1.home>
 <3517844d6371794cff59b13bf9c2baf1dcbe571c.1566966365.git.luoben@linux.alibaba.com>
 <20190828095501.12e71bd3@x1.home>
 <6c234632-b7e9-45c7-3d70-51a4c83161f6@linux.alibaba.com>
 <20190829110601.6dd74052@x1.home>
From:   Ben Luo <luoben@linux.alibaba.com>
Message-ID: <7e4b77e1-2f67-650c-bbf7-93e1b3d09fd6@linux.alibaba.com>
Date:   Mon, 2 Sep 2019 15:58:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829110601.6dd74052@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2019/8/30 上午1:06, Alex Williamson 写道:
> On Fri, 30 Aug 2019 00:58:22 +0800
> Ben Luo <luoben@linux.alibaba.com> wrote:
>
>> 在 2019/8/28 下午11:55, Alex Williamson 写道:
>>> On Wed, 28 Aug 2019 12:28:04 +0800
>>> Ben Luo <luoben@linux.alibaba.com> wrote:
>>>   
>>>> currently, if the page is not a tail of compound page, it will be
>>>> checked twice for the same thing.
>>>>
>>>> Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
>>>> ---
>>>>    drivers/vfio/vfio_iommu_type1.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>>>> index 054391f..d0f7346 100644
>>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>>> @@ -291,11 +291,10 @@ static int vfio_lock_acct(struct vfio_dma *dma, long npage, bool async)
>>>>    static bool is_invalid_reserved_pfn(unsigned long pfn)
>>>>    {
>>>>    	if (pfn_valid(pfn)) {
>>>> -		bool reserved;
>>>>    		struct page *tail = pfn_to_page(pfn);
>>>>    		struct page *head = compound_head(tail);
>>>> -		reserved = !!(PageReserved(head));
>>>>    		if (head != tail) {
>>>> +			bool reserved = PageReserved(head);
>>>>    			/*
>>>>    			 * "head" is not a dangling pointer
>>>>    			 * (compound_head takes care of that)
>>> Thinking more about this, the code here was originally just a copy of
>>> kvm_is_mmio_pfn() which was simplified in v3.12 with the commit below.
>>> Should we instead do the same thing here?  Thanks,
>>>
>>> Alex
>> ok, and kvm_is_mmio_pfn() has also been updated since then, I will take
>> a look at that and compose a new patch
> I'm not sure if the further updates are quite as relevant for vfio, but
> appreciate your review of them.  Thanks,
>
> Alex
After studying the related code, my personal understandings are:

kvm_is_mmio_pfn() is used to find out whether a memory range is MMIO 
mapped so
that to set the proper MTRR TYPE to spte.

is_invalid_reserved_pfn() is used in two scenarios:
1, to tell whether a page should be counted against user's mlock limits, as
the function's name implies, all 'invalid' PFNs who are not backed by struct
page and those reserved pages (including zero page and those from NVDIMM 
DAX)
should be excluded.
2, to check if we have got a valid and pinned pfn for the vma with VM_PFNMAP
flag. So, for the zero page and 'RAM' backed PFNs without 'struct page',
kvm_is_mmio_pfn() should return false because they are not MMIO and are
cacheable, but is_invalid_reserved_pfn() should return true since they are
truely reserved or invalid and should not be counted against user's mlock
limits.

For fsdax-page, current get_user_pages() returns -EOPNOTSUPP, and VFIO also
returns this error code to user, seems not support fsdax for now, so 
there is
no chance to call into is_invalid_reserved_pfn() currently, if fsdax is 
to be
supported, not only this function needs to be updated, vaddr_get_pfn() also
needs some changes.

Now, with the assumption that PFNs of compound pages with reserved bit 
set in
head will not be passed to is_invalid_reserved_pfn(), we can simplify this
function to:

static bool is_invalid_reserved_pfn(unsigned long pfn)
{
         if (pfn_valid(pfn))
                 return PageReserved(pfn_to_page(pfn));

         return true;
}

But, I am not sure if the assumption above is true, if not, we still need to
check the reserved bit of head for a tail page as this PATCH v2 does.

Thanks,

     Ben

