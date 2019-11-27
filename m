Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B70C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655702070A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 09:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dNPT7Mk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfK0JM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 04:12:57 -0500
Received: from mail-eopbgr770080.outbound.protection.outlook.com ([40.107.77.80]:10091
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfK0JM5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/AWIBC3J4qlYdVeWtRsDkouy+j+mfQtYAX+yPdIIxJyYLbYCEM8M0BXATq2A8cZAU5WHnr09eC73OPlNwdxZCKY+Z21mZfq9ZXPjc9e5tpkEld59cn6AH+4hbFNQPn+4KeebKV3AVTYQm1J+OcjKsxZ/hmwWmEQIeR5rrublBi1R3FVL4kidk801ksu85jBSoSWYQzixy+uLxEQPKcpiL4bMHZTHGQFkNVx3LbX+1AAAf97bK18U02G7zlh/gD/ztsM/2+2EQffhIKQiFIlbCyiXG1fpyinHoCY8tVFqthz8lifOKPyWxIw1Y/FrDLPqEnjcfeBLRdJp/zuNUroGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExqbDUVbse+YiXhNTU5zOR7ICi9Xa/lfAU76LDB+TSE=;
 b=oa976Au/b+qVMAyXs37MzFNcK8ZMuvN9zc0BtEvUZIKiF4yny2K/+r0MrHyDy4YvSQPOHM8235O5aPL6Cym8zwOm7R1Fd497PA3YV2el8ltDpLzz6jsu1nIajzxjp/YXtbHZY6+T9j7+3ZEONzVjndrOLVKgNalsrp/toZrxNxIS6wM80PCb7WAPB9btKNg0z40woLmc1QlrHbUsFXGJDtiOOIq7QnB/3tB3CIo+E0nVwgm+T2ixOV5l/jBpWf58M0QdbjwjCoZdDTj/4e9ElMyzafT/5J3JhjGTAbXsCrJ1MwYrJRKzjGl0VaNOJtpMdS0hZZEGgSJzKZt6miJkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExqbDUVbse+YiXhNTU5zOR7ICi9Xa/lfAU76LDB+TSE=;
 b=dNPT7Mk9bvWvK2h3RnJ6b4+esoaI9N3FmMS/JCKElf3Hs5cNLBWTTapCoxlCG6kjwrIbf9BkQ+g5o3zG/Mc5HwNaLgjepJgYRH4acFWFRUdQIGsgcyxA3cwV6cJW5gOzGeKtmumIlT4OhL5poThh/WwUEPyDxs3pf2eCNva9VBM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1692.namprd12.prod.outlook.com (10.172.34.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 09:12:48 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 09:12:48 +0000
Subject: Re: [RFC PATCH 4/7] drm/ttm: Support huge pagefaults
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-graphics-maintainer@vmware.com
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20191127083120.34611-1-thomas_os@shipmail.org>
 <20191127083120.34611-5-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b7e21292-2967-b11c-a0b6-8b857c89f9df@amd.com>
Date:   Wed, 27 Nov 2019 10:12:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191127083120.34611-5-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR0102CA0016.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:14::29) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b974a5dc-2634-45ae-8b5f-08d77319f8c0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1692679F278E5CD0CF53E0D483440@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 023495660C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(396003)(376002)(189003)(199004)(2486003)(50466002)(186003)(6506007)(23676004)(86362001)(8936002)(386003)(7736002)(58126008)(6116002)(25786009)(46003)(305945005)(229853002)(36756003)(446003)(7416002)(99286004)(11346002)(316002)(76176011)(14444005)(31696002)(14454004)(81156014)(52116002)(54906003)(2616005)(8676002)(81166006)(31686004)(2906002)(6666004)(2870700001)(66946007)(66476007)(66556008)(65806001)(65956001)(47776003)(66574012)(5660300002)(6512007)(6246003)(6486002)(6436002)(478600001)(4326008)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1692;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nspHhdsGJA19ktooRfcSfyQKRvEx5q/nb4zH0ZrylIe1Ly/vpNPW6SineQTzOCYJoOrgayFMljXQCW6YnQb0j60OtsTv7Sn8qTdCNSAJevEycEPGP2lJOAtG4+GoezQavcFQJ0b9QxYjVZ39TJEVubV/sWbqgDq3D3+crhci0cFl360Fy+z/l5wv4yTUyEkttskNetNMeP/v8ya9QcHJX3Rlc02A6q8Cz1ap95khlmetUSni5xi3a5B7xpXgb2oTC2DsBOuaiNfG3iR2SDuUZd7lsGrNw2XsHKqHGmv19Y92Du2ujJKWYRtB88iskFc/MACRZfWP8Fh/oIzuTyFCXuc6ZSPNPGO4eh8mwATH2aScN+y40lAoKm9h3xVDc6KYleupWSVWHSQyyWdZz+aHrr4jTpJ2a00AEzKIFHKYfFdKqNSNB1RkALfZrfRlenuB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b974a5dc-2634-45ae-8b5f-08d77319f8c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 09:12:48.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8P4uDoZfLLXzJ/zUMHQYxUVmtft3ujCLDToVjssZTn8wCDcJZw2NnUdHKgQOFeP0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.11.19 um 09:31 schrieb Thomas Hellström (VMware):
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> Support huge (PMD-size and PUD-size) page-table entries by providing a
> huge_fault() callback.
> We still support private mappings and write-notify by splitting the huge
> page-table entries on write-access.
>
> Note that for huge page-faults to occur, either the kernel needs to be
> compiled with trans-huge-pages always enabled, or the kernel needs to be
> compiled with trans-huge-pages enabled using madvise, and the user-space
> app needs to call madvise() to enable trans-huge pages on a per-mapping
> basis.
>
> Furthermore huge page-faults will not occur unless buffer objects and
> user-space addresses are aligned on huge page size boundaries.
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
>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 139 +++++++++++++++++++++++++++++++-
>   include/drm/ttm/ttm_bo_api.h    |   3 +-
>   2 files changed, 138 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 2098f8d4dfc5..8d6089880e39 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -150,6 +150,84 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
>   }
>   EXPORT_SYMBOL(ttm_bo_vm_reserve);
>   
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +/**
> + * ttm_bo_vm_insert_huge - Insert a pfn for PUD or PMD faults
> + * @vmf: Fault data
> + * @bo: The buffer object
> + * @page_offset: Page offset from bo start
> + * @fault_page_size: The size of the fault in pages.
> + * @pgprot: The page protections.
> + * Does additional checking whether it's possible to insert a PUD or PMD
> + * pfn and performs the insertion.
> + *
> + * Return: VM_FAULT_NOPAGE on successful insertion, VM_FAULT_FALLBACK if
> + * a huge fault was not possible, and a VM_FAULT_ERROR code otherwise.
> + */
> +static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> +					struct ttm_buffer_object *bo,
> +					pgoff_t page_offset,
> +					pgoff_t fault_page_size,
> +					pgprot_t pgprot)
> +{
> +	pgoff_t i;
> +	vm_fault_t ret;
> +	unsigned long pfn;
> +	pfn_t pfnt;
> +	struct ttm_tt *ttm = bo->ttm;
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +
> +
> +	/* Fault should not cross bo boundary */
> +	page_offset &= ~(fault_page_size - 1);
> +	if (page_offset + fault_page_size > bo->num_pages)
> +		goto out_fallback;
> +
> +	if (bo->mem.bus.is_iomem)
> +		pfn = ttm_bo_io_mem_pfn(bo, page_offset);
> +	else
> +		pfn = page_to_pfn(ttm->pages[page_offset]);
> +
> +	/* pfn must be fault_page_size aligned. */
> +	if ((pfn & (fault_page_size - 1)) != 0)
> +		goto out_fallback;
> +
> +	/* IO memory is OK now, TT memory must be contigous. */

That won't work correctly, IO mem might not be contiguous either.

We either need to call ttm_bo_io_mem_pfn() multiple times and check that 
the addresses are linear or return the length additional to the pfn.

Regards,
Christian.

> +	if (!bo->mem.bus.is_iomem)
> +		for (i = 1; i < fault_page_size; ++i) {
> +			if (page_to_pfn(ttm->pages[page_offset + i]) != pfn + i)
> +				goto out_fallback;
> +		}
> +
> +	pfnt = __pfn_to_pfn_t(pfn, PFN_DEV);
> +	if (fault_page_size == (HPAGE_PMD_SIZE >> PAGE_SHIFT))
> +		ret = vmf_insert_pfn_pmd_prot(vmf, pfnt, pgprot, write);
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +	else if (fault_page_size == (HPAGE_PUD_SIZE >> PAGE_SHIFT))
> +		ret = vmf_insert_pfn_pud_prot(vmf, pfnt, pgprot, write);
> +#endif
> +	else
> +		WARN_ON_ONCE(ret = VM_FAULT_FALLBACK);
> +
> +	if (ret != VM_FAULT_NOPAGE)
> +		goto out_fallback;
> +
> +	return VM_FAULT_NOPAGE;
> +out_fallback:
> +	count_vm_event(THP_FAULT_FALLBACK);
> +	return VM_FAULT_FALLBACK;
> +}
> +#else
> +static vm_fault_t ttm_bo_vm_insert_huge(struct vm_fault *vmf,
> +					struct ttm_buffer_object *bo,
> +					pgoff_t page_offset,
> +					pgoff_t fault_page_size,
> +					pgprot_t pgprot)
> +{
> +	return VM_FAULT_NOPAGE;
> +}
> +#endif
> +
>   /**
>    * ttm_bo_vm_fault_reserved - TTM fault helper
>    * @vmf: The struct vm_fault given as argument to the fault callback
> @@ -170,7 +248,8 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
>    */
>   vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   				    pgprot_t prot,
> -				    pgoff_t num_prefault)
> +				    pgoff_t num_prefault,
> +				    pgoff_t fault_page_size)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
>   	struct ttm_buffer_object *bo = vma->vm_private_data;
> @@ -262,6 +341,13 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   		prot = pgprot_decrypted(prot);
>   	}
>   
> +	/* We don't prefault on huge faults. Yet. */
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && fault_page_size != 1) {
> +		ret = ttm_bo_vm_insert_huge(vmf, bo, page_offset,
> +					    fault_page_size, prot);
> +		goto out_io_unlock;
> +	}
> +
>   	/*
>   	 * Speculatively prefault a number of pages. Only error on
>   	 * first page.
> @@ -320,7 +406,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   		return ret;
>   
>   	prot = vma->vm_page_prot;
> -	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
> +	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT, 1);
>   	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>   		return ret;
>   
> @@ -330,6 +416,50 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   }
>   EXPORT_SYMBOL(ttm_bo_vm_fault);
>   
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static vm_fault_t ttm_bo_vm_huge_fault(struct vm_fault *vmf,
> +				       enum page_entry_size pe_size)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	pgprot_t prot;
> +	struct ttm_buffer_object *bo = vma->vm_private_data;
> +	vm_fault_t ret;
> +	pgoff_t fault_page_size = 0;
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +
> +	switch (pe_size) {
> +	case PE_SIZE_PMD:
> +		fault_page_size = HPAGE_PMD_SIZE >> PAGE_SHIFT;
> +		break;
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +	case PE_SIZE_PUD:
> +		fault_page_size = HPAGE_PUD_SIZE >> PAGE_SHIFT;
> +		break;
> +#endif
> +	default:
> +		WARN_ON_ONCE(1);
> +		return VM_FAULT_FALLBACK;
> +	}
> +
> +	/* Fallback on write dirty-tracking or COW */
> +	if (write && !(pgprot_val(vmf->vma->vm_page_prot) & _PAGE_RW))
> +		return VM_FAULT_FALLBACK;
> +
> +	ret = ttm_bo_vm_reserve(bo, vmf);
> +	if (ret)
> +		return ret;
> +
> +	prot = vm_get_page_prot(vma->vm_flags);
> +	ret = ttm_bo_vm_fault_reserved(vmf, prot, 1, fault_page_size);
> +	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
> +		return ret;
> +
> +	dma_resv_unlock(bo->base.resv);
> +
> +	return ret;
> +}
> +#endif
> +
>   void ttm_bo_vm_open(struct vm_area_struct *vma)
>   {
>   	struct ttm_buffer_object *bo = vma->vm_private_data;
> @@ -431,7 +561,10 @@ static const struct vm_operations_struct ttm_bo_vm_ops = {
>   	.fault = ttm_bo_vm_fault,
>   	.open = ttm_bo_vm_open,
>   	.close = ttm_bo_vm_close,
> -	.access = ttm_bo_vm_access
> +	.access = ttm_bo_vm_access,
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	.huge_fault = ttm_bo_vm_huge_fault,
> +#endif
>   };
>   
>   static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> index 66ca49db9633..4fc90d53aa15 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -732,7 +732,8 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
>   
>   vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   				    pgprot_t prot,
> -				    pgoff_t num_prefault);
> +				    pgoff_t num_prefault,
> +				    pgoff_t fault_page_size);
>   
>   vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf);
>   

