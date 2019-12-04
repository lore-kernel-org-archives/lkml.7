Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D277C2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDA920656
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0U4+H7Vq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbfLDMIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:08:20 -0500
Received: from mail-eopbgr680078.outbound.protection.outlook.com ([40.107.68.78]:59457
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfLDMIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:08:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLLJT6hWtoRecfURTtq3u5qg2vIL32KHnXIYlACo88mZMwlfZZTBydLJMJfVukTqkzMVMm69/eHEmHCe1xGWVsGl1nOdk7qMyzXPe21BAWXHYYpzLrpyxQFFFJ/pxQKWSLl906rc2vSEQUyc4l/N18NdppS74IxoonxMLPoSuFFlhSIb/HMuWD5CXNpLU5eOI7nuRnTmO9ZMQVLf9KoLD0mqa0WSaPbrLABPWIxAiVOrSIwc7YcEy/SU65w25gaMtcruyqv+s++yKXqvXqW7KJZsCsRFv4uJjjtTsgzSYMIA0+ydKcehKMwrCSi2VsayvEcWEMY3iB6vkbA2K5G3Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R8orIXzWLcvtbaHq48bFNI79eqxECS3bX4fh4GcKw4=;
 b=IVF4qzkh9p6z7bysFdARznGkD3I+qSVsRNo/zpV7jseKOA+r8XAPOK3PMfdfAvmsfj7BFXF6Kn1iaTtodvYwXpAR0WKVT5FEum6vasO2D9i3vLTp9omgQrhyUnjqg8cs/nhhGP8pnZfCfgmKPmR/FXPIROygAa7fn2Hb3EWM9b91RJ+l1vHlvLaT8+X0yLXXhB/qFuF9sjIttwztI9C01CJEDGp4XjmMIyZ03WYnWxvqvih54hfPsqoF5DP8CbC8GKDTgEjruyHhUXQf5VLvT82I5WVNnZhWLrfanCi7WBTxzDsbY8Wx0z/vDzA0wwSwr5ToZqkR7uZ+AlYRebswMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R8orIXzWLcvtbaHq48bFNI79eqxECS3bX4fh4GcKw4=;
 b=0U4+H7VqK4ZUBeEx1/PcaujNcOo/OUNz6aaWrTOq/ZAIilU0IrWfce3fQzEtDhqrw6n8lZFhooInmkYl2Xi5qE2o0Zc74G1umPU9GBDQ5B1oHxIQafK9St3ezE6lalDuLHsBeZrRybICXRMpJYfJ0xE3ovIk/3EUrvM17W5RZQg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1692.namprd12.prod.outlook.com (10.172.34.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Wed, 4 Dec 2019 12:08:13 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 12:08:13 +0000
Subject: Re: [PATCH 6/8] drm: Add a drm_get_unmapped_area() helper
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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
 <98af5b11-1034-91fa-aa38-5730f116d1cd@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3cc5b796-20c6-9f4c-3f62-d844f34d81b7@amd.com>
Date:   Wed, 4 Dec 2019 13:08:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <98af5b11-1034-91fa-aa38-5730f116d1cd@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::11) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d2de4a8-7c2b-40cf-a9f2-08d778b2a2d0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1692151338B635105023A35D835D0@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(199004)(189003)(52116002)(2906002)(76176011)(81156014)(25786009)(6246003)(316002)(305945005)(54906003)(7736002)(99286004)(58126008)(2616005)(6486002)(4326008)(6506007)(81166006)(53546011)(50466002)(86362001)(7416002)(11346002)(6512007)(229853002)(65956001)(478600001)(14454004)(23676004)(8936002)(66476007)(6436002)(31696002)(66946007)(36756003)(66556008)(186003)(6666004)(66574012)(31686004)(6116002)(14444005)(5660300002)(8676002)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1692;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kn3XnIiJIW2VEXr0di7f/llViNg9DArh5TXLc7AYwd8c/7PUT/hV+F/4NJP9PF1bW/BlELQzfBrBJAKPcM4CGKEDNisDLTnHtv8H+eu3n0SJ0lEDgmPfRE/3CVdiVxkQ6EGdA9hgxm52+hyMMrwDvKv5qb7U/qsvGN90EGu79RVEvz9WH5qHea7KCCMetEy6ZE0XqT8pgfkrwxUIgW2Zl+/zMN2W4juPFBDwP9RVfG4IBIJ/dM24se+dg6wVwaZODsFNrBnsFrJsT4ueSTZESsdv9gJXzOaEi6iwSxmaehOZuRtXQ78U97DlB6jDEdKZgxT+Igvh3huOJBwfGKRZ1lk6QoTPhbw8wCuluB7T/EcFN6zAa67ifVFeB+7sST3dM3FeuVfbEQFIb+WJIld9k8dbXWXKZlGF1rIFDqV4QZB0zfZL3cTY9f/a7qwHfgMK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2de4a8-7c2b-40cf-a9f2-08d778b2a2d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 12:08:13.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tS86RwcXuvKOyJBkPtqnxQ/wt7lIPdAsw/9vDl7h3ol0EMMJQb87wPhmU+9oB8ZI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.12.19 um 12:36 schrieb Thomas Hellström (VMware):
> On 12/4/19 12:11 PM, Christian König wrote:
>> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>
>>> This helper is used to align user-space buffer object addresses to
>>> huge page boundaries, minimizing the chance of alignment mismatch
>>> between user-space addresses and physical addresses.
>>
>> Mhm, I'm wondering if that is really such a good idea.
>
> Could you elaborate? What drawbacks do you see?

Main problem for me seems to be that I don't fully understand what the 
get_unmapped_area callback is doing.

For example why do we need to use drm_vma_offset_lookup_locked() to 
adjust the pgoff?

The mapped offset should be completely irrelevant for finding some piece 
of userspace address space or am I totally off here?

> Note that this is the way other subsystems are doing it. Take a look 
> at shmem_get_unmapped_area() for instance.
>
>>
>> Wouldn't it be sufficient if userspace uses MAP_HUGETLB?
>
> MAP_HUGETLB is something different and appears to be tied to the 
> kernel persistent huge page mechanism, whereas the TTM huge pages is 
> tided to the THP functionality (although skipped by khugepaged).

Ok, that makes sense. Over all we want to be transparent here.

Regards,
Christian.

>
> Thanks,
>
> Thomas
>
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Michal Hocko <mhocko@suse.com>
>>> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>> Cc: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: "Jérôme Glisse" <jglisse@redhat.com>
>>> Cc: "Christian König" <christian.koenig@amd.com>
>>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
>>> ---
>>>   drivers/gpu/drm/drm_file.c | 130 
>>> +++++++++++++++++++++++++++++++++++++
>>>   include/drm/drm_file.h     |   5 ++
>>>   2 files changed, 135 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
>>> index ea34bc991858..e5b4024cd397 100644
>>> --- a/drivers/gpu/drm/drm_file.c
>>> +++ b/drivers/gpu/drm/drm_file.c
>>> @@ -31,6 +31,8 @@
>>>    * OTHER DEALINGS IN THE SOFTWARE.
>>>    */
>>>   +#include <uapi/asm/mman.h>
>>> +
>>>   #include <linux/dma-fence.h>
>>>   #include <linux/module.h>
>>>   #include <linux/pci.h>
>>> @@ -41,6 +43,7 @@
>>>   #include <drm/drm_drv.h>
>>>   #include <drm/drm_file.h>
>>>   #include <drm/drm_print.h>
>>> +#include <drm/drm_vma_manager.h>
>>>     #include "drm_crtc_internal.h"
>>>   #include "drm_internal.h"
>>> @@ -754,3 +757,130 @@ void drm_send_event(struct drm_device *dev, 
>>> struct drm_pending_event *e)
>>>       spin_unlock_irqrestore(&dev->event_lock, irqflags);
>>>   }
>>>   EXPORT_SYMBOL(drm_send_event);
>>> +
>>> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +/*
>>> + * drm_addr_inflate() attempts to construct an aligned area by 
>>> inflating
>>> + * the area size and skipping the unaligned start of the area.
>>> + * adapted from shmem_get_unmapped_area()
>>> + */
>>> +static unsigned long drm_addr_inflate(unsigned long addr,
>>> +                      unsigned long len,
>>> +                      unsigned long pgoff,
>>> +                      unsigned long flags,
>>> +                      unsigned long huge_size)
>>> +{
>>> +    unsigned long offset, inflated_len;
>>> +    unsigned long inflated_addr;
>>> +    unsigned long inflated_offset;
>>> +
>>> +    offset = (pgoff << PAGE_SHIFT) & (huge_size - 1);
>>> +    if (offset && offset + len < 2 * huge_size)
>>> +        return addr;
>>> +    if ((addr & (huge_size - 1)) == offset)
>>> +        return addr;
>>> +
>>> +    inflated_len = len + huge_size - PAGE_SIZE;
>>> +    if (inflated_len > TASK_SIZE)
>>> +        return addr;
>>> +    if (inflated_len < len)
>>> +        return addr;
>>> +
>>> +    inflated_addr = current->mm->get_unmapped_area(NULL, 0, 
>>> inflated_len,
>>> +                               0, flags);
>>> +    if (IS_ERR_VALUE(inflated_addr))
>>> +        return addr;
>>> +    if (inflated_addr & ~PAGE_MASK)
>>> +        return addr;
>>> +
>>> +    inflated_offset = inflated_addr & (huge_size - 1);
>>> +    inflated_addr += offset - inflated_offset;
>>> +    if (inflated_offset > offset)
>>> +        inflated_addr += huge_size;
>>> +
>>> +    if (inflated_addr > TASK_SIZE - len)
>>> +        return addr;
>>> +
>>> +    return inflated_addr;
>>> +}
>>> +
>>> +/**
>>> + * drm_get_unmapped_area() - Get an unused user-space virtual 
>>> memory area
>>> + * suitable for huge page table entries.
>>> + * @file: The struct file representing the address space being 
>>> mmap()'d.
>>> + * @uaddr: Start address suggested by user-space.
>>> + * @len: Length of the area.
>>> + * @pgoff: The page offset into the address space.
>>> + * @flags: mmap flags
>>> + * @mgr: The address space manager used by the drm driver. This 
>>> argument can
>>> + * probably be removed at some point when all drivers use the same
>>> + * address space manager.
>>> + *
>>> + * This function attempts to find an unused user-space virtual 
>>> memory area
>>> + * that can accommodate the size we want to map, and that is properly
>>> + * aligned to facilitate huge page table entries matching actual
>>> + * huge pages or huge page aligned memory in buffer objects. Buffer 
>>> objects
>>> + * are assumed to start at huge page boundary pfns (io memory) or be
>>> + * populated by huge pages aligned to the start of the buffer object
>>> + * (system- or coherent memory). Adapted from shmem_get_unmapped_area.
>>> + *
>>> + * Return: aligned user-space address.
>>> + */
>>> +unsigned long drm_get_unmapped_area(struct file *file,
>>> +                    unsigned long uaddr, unsigned long len,
>>> +                    unsigned long pgoff, unsigned long flags,
>>> +                    struct drm_vma_offset_manager *mgr)
>>> +{
>>> +    unsigned long addr;
>>> +    unsigned long inflated_addr;
>>> +    struct drm_vma_offset_node *node;
>>> +
>>> +    if (len > TASK_SIZE)
>>> +        return -ENOMEM;
>>> +
>>> +    /* Adjust mapping offset to be zero at bo start */
>>> +    drm_vma_offset_lock_lookup(mgr);
>>> +    node = drm_vma_offset_lookup_locked(mgr, pgoff, 1);
>>> +    if (node)
>>> +        pgoff -= node->vm_node.start;
>>> +    drm_vma_offset_unlock_lookup(mgr);
>>> +
>>> +    addr = current->mm->get_unmapped_area(file, uaddr, len, pgoff, 
>>> flags);
>>> +    if (IS_ERR_VALUE(addr))
>>> +        return addr;
>>> +    if (addr & ~PAGE_MASK)
>>> +        return addr;
>>> +    if (addr > TASK_SIZE - len)
>>> +        return addr;
>>> +
>>> +    if (len < HPAGE_PMD_SIZE)
>>> +        return addr;
>>> +    if (flags & MAP_FIXED)
>>> +        return addr;
>>> +    /*
>>> +     * Our priority is to support MAP_SHARED mapped hugely;
>>> +     * and support MAP_PRIVATE mapped hugely too, until it is COWed.
>>> +     * But if caller specified an address hint, respect that as 
>>> before.
>>> +     */
>>> +    if (uaddr)
>>> +        return addr;
>>> +
>>> +    inflated_addr = drm_addr_inflate(addr, len, pgoff, flags,
>>> +                     HPAGE_PMD_SIZE);
>>> +
>>> +    if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
>>> +        len >= HPAGE_PUD_SIZE)
>>> +        inflated_addr = drm_addr_inflate(inflated_addr, len, pgoff,
>>> +                         flags, HPAGE_PUD_SIZE);
>>> +    return inflated_addr;
>>> +}
>>> +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
>>> +unsigned long drm_get_unmapped_area(struct file *file,
>>> +                    unsigned long uaddr, unsigned long len,
>>> +                    unsigned long pgoff, unsigned long flags,
>>> +                    struct drm_vma_offset_manager *mgr)
>>> +{
>>> +    return current->mm->get_unmapped_area(file, uaddr, len, pgoff, 
>>> flags);
>>> +}
>>> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>> +EXPORT_SYMBOL_GPL(drm_get_unmapped_area);
>>> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
>>> index 67af60bb527a..4719cc80d547 100644
>>> --- a/include/drm/drm_file.h
>>> +++ b/include/drm/drm_file.h
>>> @@ -386,5 +386,10 @@ void drm_event_cancel_free(struct drm_device *dev,
>>>                  struct drm_pending_event *p);
>>>   void drm_send_event_locked(struct drm_device *dev, struct 
>>> drm_pending_event *e);
>>>   void drm_send_event(struct drm_device *dev, struct 
>>> drm_pending_event *e);
>>> +struct drm_vma_offset_manager;
>>> +unsigned long drm_get_unmapped_area(struct file *file,
>>> +                    unsigned long uaddr, unsigned long len,
>>> +                    unsigned long pgoff, unsigned long flags,
>>> +                    struct drm_vma_offset_manager *mgr);
>>>     #endif /* _DRM_FILE_H_ */
>
>

