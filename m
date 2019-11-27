Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD41C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF972068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="qYP4CXBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfK0MZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 07:25:00 -0500
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:33920 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfK0MY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 07:24:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 73B8E3F683;
        Wed, 27 Nov 2019 13:24:57 +0100 (CET)
Authentication-Results: pio-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=qYP4CXBt;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EWrtG9W4vugB; Wed, 27 Nov 2019 13:24:55 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 691493F556;
        Wed, 27 Nov 2019 13:24:52 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 9FF2D360140;
        Wed, 27 Nov 2019 13:24:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1574857492; bh=G8kszZs1jtzCSQxM7XxfwjE4wxpMdv4dFcCTVfNkcPE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qYP4CXBt+c2IMRKHRJkjJRGWfHNF/5SJN0EB9A4yORFOsXTA9iICXqdzjiZP/4lh/
         bZLDtjvtQuKbvC8qXX/XUmor9wnCMjOTrQgB6desRFuKm8tZVwTZRjGAxmLUZbxZTI
         66A3krVi3PNGQLEESuTGUy+BTQ6e45Ky/A+ZrFDU=
Subject: Re: [RFC PATCH 4/7] drm/ttm: Support huge pagefaults
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-graphics-maintainer@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191127083120.34611-1-thomas_os@shipmail.org>
 <20191127083120.34611-5-thomas_os@shipmail.org>
 <b7e21292-2967-b11c-a0b6-8b857c89f9df@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <83b83746-7d54-e56b-3753-0b29b01074a2@shipmail.org>
Date:   Wed, 27 Nov 2019 13:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b7e21292-2967-b11c-a0b6-8b857c89f9df@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/19 10:12 AM, Christian König wrote:
> Am 27.11.19 um 09:31 schrieb Thomas Hellström (VMware):
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Support huge (PMD-size and PUD-size) page-table entries by providing a
>> huge_fault() callback.
>> We still support private mappings and write-notify by splitting the huge
>> page-table entries on write-access.
>>
>> Note that for huge page-faults to occur, either the kernel needs to be
>> compiled with trans-huge-pages always enabled, or the kernel needs to be
>> compiled with trans-huge-pages enabled using madvise, and the user-space
>> app needs to call madvise() to enable trans-huge pages on a per-mapping
>> basis.
>>
>> Furthermore huge page-faults will not occur unless buffer objects and
>> user-space addresses are aligned on huge page size boundaries.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>> Cc: "Christian König" <christian.koenig@amd.com>
>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 139 +++++++++++++++++++++++++++++++-
>>   include/drm/ttm/ttm_bo_api.h    |   3 +-
>>   2 files changed, 138 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c 
>> b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 2098f8d4dfc5..8d6089880e39 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -150,6 +150,84 @@ vm_fault_t ttm_bo_vm_reserve(struct 
>> ttm_buffer_object *bo,
>>   }
>>   EXPORT_SYMBOL(ttm_bo_vm_reserve);
>>   +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +/**
>> + * ttm_bo_vm_insert_huge - Insert a pfn for PUD or PMD faults
>> + * @vmf: Fault data
>> + * @bo: The buffer object
>> + * @page_offset: Page offset from bo start
>> + * @fault_page_size: The size of the fault in pages.
>> + * @pgprot: The page protections.
>> + * Does additional checking whether it's possible to insert a PUD or 
>> PMD
>> + * pfn and performs the insertion.
>> + *
>> + * Return: VM_FAULT_NOPAGE on successful insertion, 
>> VM_FAULT_FALLBACK if
>> + * a huge fault was not possible, and a VM_FAULT_ERROR code otherwise.
>> + */
>> +static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
>> +                    struct ttm_buffer_object *bo,
>> +                    pgoff_t page_offset,
>> +                    pgoff_t fault_page_size,
>> +                    pgprot_t pgprot)
>> +{
>> +    pgoff_t i;
>> +    vm_fault_t ret;
>> +    unsigned long pfn;
>> +    pfn_t pfnt;
>> +    struct ttm_tt *ttm = bo->ttm;
>> +    bool write = vmf->flags & FAULT_FLAG_WRITE;
>> +
>> +
>> +    /* Fault should not cross bo boundary */
>> +    page_offset &= ~(fault_page_size - 1);
>> +    if (page_offset + fault_page_size > bo->num_pages)
>> +        goto out_fallback;
>> +
>> +    if (bo->mem.bus.is_iomem)
>> +        pfn = ttm_bo_io_mem_pfn(bo, page_offset);
>> +    else
>> +        pfn = page_to_pfn(ttm->pages[page_offset]);
>> +
>> +    /* pfn must be fault_page_size aligned. */
>> +    if ((pfn & (fault_page_size - 1)) != 0)
>> +        goto out_fallback;
>> +
>> +    /* IO memory is OK now, TT memory must be contigous. */
>
> That won't work correctly, IO mem might not be contiguous either.
>
> We either need to call ttm_bo_io_mem_pfn() multiple times and check 
> that the addresses are linear or return the length additional to the pfn.

Yes, you're right. Will fix that up.

Thanks,

Thomas



>
> Regards,
> Christian. 



