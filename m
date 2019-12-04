Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C307C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E30E2077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="PlXbStpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfLDLhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:37:00 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:38947 "EHLO
        ste-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfLDLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:36:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTP id E54F047BA8;
        Wed,  4 Dec 2019 12:36:56 +0100 (CET)
Authentication-Results: ste-pvt-msa2.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=PlXbStpw;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Authentication-Results: ste-ftg-msa2.bahnhof.se (amavisd-new);
        dkim=pass (1024-bit key) header.d=shipmail.org
Received: from ste-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (ste-ftg-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JlA6HdtsDBLF; Wed,  4 Dec 2019 12:36:55 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id E4C0B3F802;
        Wed,  4 Dec 2019 12:36:48 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F2FA8360608;
        Wed,  4 Dec 2019 12:36:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575459408; bh=YaxGHckT/+4Bzy1VBWGGWN9Dy0KBMg6XIzVFkcyn1+0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=PlXbStpwEvZtnm6PVOT4yH9HBJ32oNP4sYGwOMbRVPq/l76dIjSHvGPyvn58mVENG
         5JQ76oRbcNSe2mWCpP8VXgrLF1qtkN4YddXdUB+XWDD+fn5c+MITWOVb2ybhQbzFal
         qfFuZZoP+FKVMIN18ZnryNopm/2pYWKxICI6s/ew=
Subject: Re: [PATCH 6/8] drm: Add a drm_get_unmapped_area() helper
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191203132239.5910-1-thomas_os@shipmail.org>
 <20191203132239.5910-7-thomas_os@shipmail.org>
 <e091063c-2c4a-866e-acdb-9efb1e20d737@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <98af5b11-1034-91fa-aa38-5730f116d1cd@shipmail.org>
Date:   Wed, 4 Dec 2019 12:36:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e091063c-2c4a-866e-acdb-9efb1e20d737@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 12:11 PM, Christian König wrote:
> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> This helper is used to align user-space buffer object addresses to
>> huge page boundaries, minimizing the chance of alignment mismatch
>> between user-space addresses and physical addresses.
>
> Mhm, I'm wondering if that is really such a good idea.

Could you elaborate? What drawbacks do you see?
Note that this is the way other subsystems are doing it. Take a look at 
shmem_get_unmapped_area() for instance.

>
> Wouldn't it be sufficient if userspace uses MAP_HUGETLB?

MAP_HUGETLB is something different and appears to be tied to the kernel 
persistent huge page mechanism, whereas the TTM huge pages is tided to 
the THP functionality (although skipped by khugepaged).

Thanks,

Thomas



>
> Regards,
> Christian.
>
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
>>   drivers/gpu/drm/drm_file.c | 130 +++++++++++++++++++++++++++++++++++++
>>   include/drm/drm_file.h     |   5 ++
>>   2 files changed, 135 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>> index ea34bc991858..e5b4024cd397 100644
>> --- a/drivers/gpu/drm/drm_file.c
>> +++ b/drivers/gpu/drm/drm_file.c
>> @@ -31,6 +31,8 @@
>>    * OTHER DEALINGS IN THE SOFTWARE.
>>    */
>>   +#include <uapi/asm/mman.h>
>> +
>>   #include <linux/dma-fence.h>
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>> @@ -41,6 +43,7 @@
>>   #include <drm/drm_drv.h>
>>   #include <drm/drm_file.h>
>>   #include <drm/drm_print.h>
>> +#include <drm/drm_vma_manager.h>
>>     #include "drm_crtc_internal.h"
>>   #include "drm_internal.h"
>> @@ -754,3 +757,130 @@ void drm_send_event(struct drm_device *dev, 
>> struct drm_pending_event *e)
>>       spin_unlock_irqrestore(&dev->event_lock, irqflags);
>>   }
>>   EXPORT_SYMBOL(drm_send_event);
>> +
>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +/*
>> + * drm_addr_inflate() attempts to construct an aligned area by 
>> inflating
>> + * the area size and skipping the unaligned start of the area.
>> + * adapted from shmem_get_unmapped_area()
>> + */
>> +static unsigned long drm_addr_inflate(unsigned long addr,
>> +                      unsigned long len,
>> +                      unsigned long pgoff,
>> +                      unsigned long flags,
>> +                      unsigned long huge_size)
>> +{
>> +    unsigned long offset, inflated_len;
>> +    unsigned long inflated_addr;
>> +    unsigned long inflated_offset;
>> +
>> +    offset = (pgoff << PAGE_SHIFT) & (huge_size - 1);
>> +    if (offset && offset + len < 2 * huge_size)
>> +        return addr;
>> +    if ((addr & (huge_size - 1)) == offset)
>> +        return addr;
>> +
>> +    inflated_len = len + huge_size - PAGE_SIZE;
>> +    if (inflated_len > TASK_SIZE)
>> +        return addr;
>> +    if (inflated_len < len)
>> +        return addr;
>> +
>> +    inflated_addr = current->mm->get_unmapped_area(NULL, 0, 
>> inflated_len,
>> +                               0, flags);
>> +    if (IS_ERR_VALUE(inflated_addr))
>> +        return addr;
>> +    if (inflated_addr & ~PAGE_MASK)
>> +        return addr;
>> +
>> +    inflated_offset = inflated_addr & (huge_size - 1);
>> +    inflated_addr += offset - inflated_offset;
>> +    if (inflated_offset > offset)
>> +        inflated_addr += huge_size;
>> +
>> +    if (inflated_addr > TASK_SIZE - len)
>> +        return addr;
>> +
>> +    return inflated_addr;
>> +}
>> +
>> +/**
>> + * drm_get_unmapped_area() - Get an unused user-space virtual memory 
>> area
>> + * suitable for huge page table entries.
>> + * @file: The struct file representing the address space being 
>> mmap()'d.
>> + * @uaddr: Start address suggested by user-space.
>> + * @len: Length of the area.
>> + * @pgoff: The page offset into the address space.
>> + * @flags: mmap flags
>> + * @mgr: The address space manager used by the drm driver. This 
>> argument can
>> + * probably be removed at some point when all drivers use the same
>> + * address space manager.
>> + *
>> + * This function attempts to find an unused user-space virtual 
>> memory area
>> + * that can accommodate the size we want to map, and that is properly
>> + * aligned to facilitate huge page table entries matching actual
>> + * huge pages or huge page aligned memory in buffer objects. Buffer 
>> objects
>> + * are assumed to start at huge page boundary pfns (io memory) or be
>> + * populated by huge pages aligned to the start of the buffer object
>> + * (system- or coherent memory). Adapted from shmem_get_unmapped_area.
>> + *
>> + * Return: aligned user-space address.
>> + */
>> +unsigned long drm_get_unmapped_area(struct file *file,
>> +                    unsigned long uaddr, unsigned long len,
>> +                    unsigned long pgoff, unsigned long flags,
>> +                    struct drm_vma_offset_manager *mgr)
>> +{
>> +    unsigned long addr;
>> +    unsigned long inflated_addr;
>> +    struct drm_vma_offset_node *node;
>> +
>> +    if (len > TASK_SIZE)
>> +        return -ENOMEM;
>> +
>> +    /* Adjust mapping offset to be zero at bo start */
>> +    drm_vma_offset_lock_lookup(mgr);
>> +    node = drm_vma_offset_lookup_locked(mgr, pgoff, 1);
>> +    if (node)
>> +        pgoff -= node->vm_node.start;
>> +    drm_vma_offset_unlock_lookup(mgr);
>> +
>> +    addr = current->mm->get_unmapped_area(file, uaddr, len, pgoff, 
>> flags);
>> +    if (IS_ERR_VALUE(addr))
>> +        return addr;
>> +    if (addr & ~PAGE_MASK)
>> +        return addr;
>> +    if (addr > TASK_SIZE - len)
>> +        return addr;
>> +
>> +    if (len < HPAGE_PMD_SIZE)
>> +        return addr;
>> +    if (flags & MAP_FIXED)
>> +        return addr;
>> +    /*
>> +     * Our priority is to support MAP_SHARED mapped hugely;
>> +     * and support MAP_PRIVATE mapped hugely too, until it is COWed.
>> +     * But if caller specified an address hint, respect that as before.
>> +     */
>> +    if (uaddr)
>> +        return addr;
>> +
>> +    inflated_addr = drm_addr_inflate(addr, len, pgoff, flags,
>> +                     HPAGE_PMD_SIZE);
>> +
>> +    if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>> +        len >= HPAGE_PUD_SIZE)
>> +        inflated_addr = drm_addr_inflate(inflated_addr, len, pgoff,
>> +                         flags, HPAGE_PUD_SIZE);
>> +    return inflated_addr;
>> +}
>> +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +unsigned long drm_get_unmapped_area(struct file *file,
>> +                    unsigned long uaddr, unsigned long len,
>> +                    unsigned long pgoff, unsigned long flags,
>> +                    struct drm_vma_offset_manager *mgr)
>> +{
>> +    return current->mm->get_unmapped_area(file, uaddr, len, pgoff, 
>> flags);
>> +}
>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>> +EXPORT_SYMBOL_GPL(drm_get_unmapped_area);
>> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
>> index 67af60bb527a..4719cc80d547 100644
>> --- a/include/drm/drm_file.h
>> +++ b/include/drm/drm_file.h
>> @@ -386,5 +386,10 @@ void drm_event_cancel_free(struct drm_device *dev,
>>                  struct drm_pending_event *p);
>>   void drm_send_event_locked(struct drm_device *dev, struct 
>> drm_pending_event *e);
>>   void drm_send_event(struct drm_device *dev, struct 
>> drm_pending_event *e);
>> +struct drm_vma_offset_manager;
>> +unsigned long drm_get_unmapped_area(struct file *file,
>> +                    unsigned long uaddr, unsigned long len,
>> +                    unsigned long pgoff, unsigned long flags,
>> +                    struct drm_vma_offset_manager *mgr);
>>     #endif /* _DRM_FILE_H_ */


