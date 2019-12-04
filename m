Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78130C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B9E206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Trq9EU0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbfLDLLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:11:39 -0500
Received: from mail-bn8nam12on2072.outbound.protection.outlook.com ([40.107.237.72]:6123
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDLLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:11:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0kiz/+4Li2puj153KK7P+ISGYWA9YIW/jUBLVn6X30pG4wK5HJsmbwBsGJQumM+jjSKf+ptuHXVEKArqbGVuBXEqcnX5XkUoCCmdpCk1KbYGekT8M1FJ3Yi+6GkZmFXeKGjFli4O5oF7vpxv8ewjHFtLC5CZF5wIPp156T+0eBqWdD4/1W+tdVcKOmu68eN6p828/61syLYSWyTQxiTiDF/24SkNBvaY7WXtMyg7Gr/GTVmq0ONZTF+QGtiApgr1ryDt+H+kH5uGEX2HyoB2flXJ3RUt2s/NMbYE8kpmo+8+TRxj1YPjJQ7kovYPDY/0hYVjOhPwR9oEQRRKEktnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwC8p985N8D/JhTOTrUp/uGQ9GIxC9O+hZe5wEXTJn4=;
 b=PIniw/WnRX9GjqIux1pa/NmP6kKduKZ2HIzTaHVDLt0eyS7Yqecrm/R5ItUWtl4bCfkBy8PADXlRkYSUebCEI4sRhqgJ1O8570NnJ+Uy0WeYYmY2+jKPss+mA+uJXCEJjS3i15/XerAANVASSb1XW3kGyKFILEa4lOrTvMhmU6Hte+1BXaFYkPicY6pDzzE3v8MflT2nqO5iuAN+slbQEl7y2+yv6UK3rtEHmTA5L1sLAwjVxlCMikSk5g/0BMnkWpGfR8LnUmVXSrvxfE0wXc1GRU4COf9stq7cptzQUr3iN7r7SzSi+MFlPWhN1kTZXqgQvjOQHT0bOhUNnepc5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwC8p985N8D/JhTOTrUp/uGQ9GIxC9O+hZe5wEXTJn4=;
 b=Trq9EU0tgu+Ep3ok1qLK70eo/Xh94Ic/FSHcEezLseh+Hdoz8IUajhg7suWCIlP5eJ/mOLaqFLhKbvtElBl2atP6rXnUBwXxDJ+8TovKW/DZdPK/WzheUmA8pklkFoq4yYjvrKQFjDn9FEdEfvZc5yXzrpW16i0QAFzYtk304Kc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1579.namprd12.prod.outlook.com (10.172.38.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 11:11:31 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:11:31 +0000
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
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e091063c-2c4a-866e-acdb-9efb1e20d737@amd.com>
Date:   Wed, 4 Dec 2019 12:11:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191203132239.5910-7-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0030.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:69::43) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19c69daa-c70c-4b1a-1001-08d778aab70b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1579:
X-Microsoft-Antispam-PRVS: <DM5PR12MB15792EAD563DB83266ECD780835D0@DM5PR12MB1579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(229853002)(7416002)(31686004)(316002)(6512007)(36756003)(305945005)(2906002)(31696002)(6486002)(2870700001)(52116002)(6436002)(6666004)(76176011)(7736002)(14444005)(58126008)(23676004)(6116002)(478600001)(6506007)(25786009)(99286004)(14454004)(66574012)(186003)(50466002)(81156014)(81166006)(2616005)(11346002)(8936002)(65956001)(8676002)(5660300002)(4326008)(66556008)(66476007)(6246003)(66946007)(86362001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1579;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ul63h5kW8k+uzbLNRHhKyI9wM4NYqzYxZi/IHpCNb5xbW1MuH47qErJ1S76RM3cLmgGeNZIhzuT6OgNd3VYOTXaogwcP//i+EcPd600G+7BvavwjmphADJ55bCARGWJvOvVvRgkxjFUUTF68WCaSR0Nd9G6JxyfKnMWEN8jrgicU+3AdTy6+A9pneZBdPEh2j7p9NGXBVmPwSJbTbklNE+av2jyXuRMs6p/Ei4P41pMJcY20eMSK7Daf3AG7dm6qXzkcYwxKXlLfgX5gJHG0dBDaC9On+LQA5da9nUFd5asTjPmQRIB4j4fL3bTu0sU9w5ialobAPgMzjqGXhb5ovNaYcluWi3OnqPg5xlE3MHnEV+OUfv5Wfhk1Uqhz+i0oQFnqXxXVlMTkQM1zSPTH4n+WCj64m8j+lPKmDJdSUSRuK7U+L42QE73NzueZtWjd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c69daa-c70c-4b1a-1001-08d778aab70b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:11:31.1451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSb5oY0ov2iExyhzEIX6FrCGD8tDH6wnIVFMI4XDTOqFFhx4ec6kuAqF8/1DF63u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> This helper is used to align user-space buffer object addresses to
> huge page boundaries, minimizing the chance of alignment mismatch
> between user-space addresses and physical addresses.

Mhm, I'm wondering if that is really such a good idea.

Wouldn't it be sufficient if userspace uses MAP_HUGETLB?

Regards,
Christian.

>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> ---
>   drivers/gpu/drm/drm_file.c | 130 +++++++++++++++++++++++++++++++++++++
>   include/drm/drm_file.h     |   5 ++
>   2 files changed, 135 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ea34bc991858..e5b4024cd397 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -31,6 +31,8 @@
>    * OTHER DEALINGS IN THE SOFTWARE.
>    */
>   
> +#include <uapi/asm/mman.h>
> +
>   #include <linux/dma-fence.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> @@ -41,6 +43,7 @@
>   #include <drm/drm_drv.h>
>   #include <drm/drm_file.h>
>   #include <drm/drm_print.h>
> +#include <drm/drm_vma_manager.h>
>   
>   #include "drm_crtc_internal.h"
>   #include "drm_internal.h"
> @@ -754,3 +757,130 @@ void drm_send_event(struct drm_device *dev, struct drm_pending_event *e)
>   	spin_unlock_irqrestore(&dev->event_lock, irqflags);
>   }
>   EXPORT_SYMBOL(drm_send_event);
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +/*
> + * drm_addr_inflate() attempts to construct an aligned area by inflating
> + * the area size and skipping the unaligned start of the area.
> + * adapted from shmem_get_unmapped_area()
> + */
> +static unsigned long drm_addr_inflate(unsigned long addr,
> +				      unsigned long len,
> +				      unsigned long pgoff,
> +				      unsigned long flags,
> +				      unsigned long huge_size)
> +{
> +	unsigned long offset, inflated_len;
> +	unsigned long inflated_addr;
> +	unsigned long inflated_offset;
> +
> +	offset = (pgoff << PAGE_SHIFT) & (huge_size - 1);
> +	if (offset && offset + len < 2 * huge_size)
> +		return addr;
> +	if ((addr & (huge_size - 1)) == offset)
> +		return addr;
> +
> +	inflated_len = len + huge_size - PAGE_SIZE;
> +	if (inflated_len > TASK_SIZE)
> +		return addr;
> +	if (inflated_len < len)
> +		return addr;
> +
> +	inflated_addr = current->mm->get_unmapped_area(NULL, 0, inflated_len,
> +						       0, flags);
> +	if (IS_ERR_VALUE(inflated_addr))
> +		return addr;
> +	if (inflated_addr & ~PAGE_MASK)
> +		return addr;
> +
> +	inflated_offset = inflated_addr & (huge_size - 1);
> +	inflated_addr += offset - inflated_offset;
> +	if (inflated_offset > offset)
> +		inflated_addr += huge_size;
> +
> +	if (inflated_addr > TASK_SIZE - len)
> +		return addr;
> +
> +	return inflated_addr;
> +}
> +
> +/**
> + * drm_get_unmapped_area() - Get an unused user-space virtual memory area
> + * suitable for huge page table entries.
> + * @file: The struct file representing the address space being mmap()'d.
> + * @uaddr: Start address suggested by user-space.
> + * @len: Length of the area.
> + * @pgoff: The page offset into the address space.
> + * @flags: mmap flags
> + * @mgr: The address space manager used by the drm driver. This argument can
> + * probably be removed at some point when all drivers use the same
> + * address space manager.
> + *
> + * This function attempts to find an unused user-space virtual memory area
> + * that can accommodate the size we want to map, and that is properly
> + * aligned to facilitate huge page table entries matching actual
> + * huge pages or huge page aligned memory in buffer objects. Buffer objects
> + * are assumed to start at huge page boundary pfns (io memory) or be
> + * populated by huge pages aligned to the start of the buffer object
> + * (system- or coherent memory). Adapted from shmem_get_unmapped_area.
> + *
> + * Return: aligned user-space address.
> + */
> +unsigned long drm_get_unmapped_area(struct file *file,
> +				    unsigned long uaddr, unsigned long len,
> +				    unsigned long pgoff, unsigned long flags,
> +				    struct drm_vma_offset_manager *mgr)
> +{
> +	unsigned long addr;
> +	unsigned long inflated_addr;
> +	struct drm_vma_offset_node *node;
> +
> +	if (len > TASK_SIZE)
> +		return -ENOMEM;
> +
> +	/* Adjust mapping offset to be zero at bo start */
> +	drm_vma_offset_lock_lookup(mgr);
> +	node = drm_vma_offset_lookup_locked(mgr, pgoff, 1);
> +	if (node)
> +		pgoff -= node->vm_node.start;
> +	drm_vma_offset_unlock_lookup(mgr);
> +
> +	addr = current->mm->get_unmapped_area(file, uaddr, len, pgoff, flags);
> +	if (IS_ERR_VALUE(addr))
> +		return addr;
> +	if (addr & ~PAGE_MASK)
> +		return addr;
> +	if (addr > TASK_SIZE - len)
> +		return addr;
> +
> +	if (len < HPAGE_PMD_SIZE)
> +		return addr;
> +	if (flags & MAP_FIXED)
> +		return addr;
> +	/*
> +	 * Our priority is to support MAP_SHARED mapped hugely;
> +	 * and support MAP_PRIVATE mapped hugely too, until it is COWed.
> +	 * But if caller specified an address hint, respect that as before.
> +	 */
> +	if (uaddr)
> +		return addr;
> +
> +	inflated_addr = drm_addr_inflate(addr, len, pgoff, flags,
> +					 HPAGE_PMD_SIZE);
> +
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) &&
> +	    len >= HPAGE_PUD_SIZE)
> +		inflated_addr = drm_addr_inflate(inflated_addr, len, pgoff,
> +						 flags, HPAGE_PUD_SIZE);
> +	return inflated_addr;
> +}
> +#else /* CONFIG_TRANSPARENT_HUGEPAGE */
> +unsigned long drm_get_unmapped_area(struct file *file,
> +				    unsigned long uaddr, unsigned long len,
> +				    unsigned long pgoff, unsigned long flags,
> +				    struct drm_vma_offset_manager *mgr)
> +{
> +	return current->mm->get_unmapped_area(file, uaddr, len, pgoff, flags);
> +}
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +EXPORT_SYMBOL_GPL(drm_get_unmapped_area);
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 67af60bb527a..4719cc80d547 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -386,5 +386,10 @@ void drm_event_cancel_free(struct drm_device *dev,
>   			   struct drm_pending_event *p);
>   void drm_send_event_locked(struct drm_device *dev, struct drm_pending_event *e);
>   void drm_send_event(struct drm_device *dev, struct drm_pending_event *e);
> +struct drm_vma_offset_manager;
> +unsigned long drm_get_unmapped_area(struct file *file,
> +				    unsigned long uaddr, unsigned long len,
> +				    unsigned long pgoff, unsigned long flags,
> +				    struct drm_vma_offset_manager *mgr);
>   
>   #endif /* _DRM_FILE_H_ */

