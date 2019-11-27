Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E8CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0314D2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 08:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RrSBhf9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfK0Inq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 03:43:46 -0500
Received: from mail-eopbgr790048.outbound.protection.outlook.com ([40.107.79.48]:11496
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726194AbfK0Ino (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 03:43:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSWJRcNEhBmK8mEJ5nUvoC/bG9MwbnpRdKKeLmRx33VDtpkohhEI2vcGPwYjKUT9Rw3sr2HJ0LJmYyvOgouCPPsn8A0fQX/t+dtc2Gd4dgrCx77N4p9J45vp36r8QOOhb/fN5gASjH71bLJExEN0+Z3wrZUyOPrzVPiIy4MzK7nw0ZqY2mPu2qDqLGYlD5PvkectprrJGM2y/evLVpaDjC+9YJz9lQUTelzZAE4v5y91hvOavF0ILz8VbEGjTbUlj1GhPDbOx1+3sfjAjNE4dVZ+B6fMDE5hDY4zVlMbfK4JVheHV7O/CU07qGLUDNOppHTeIFrW1y5HyLn62O6qAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GOdGPmLbLK2dWtxDG4fQ+gRLqxmPik3t4IKg2vFwTo=;
 b=UFB8EXTZdi6tBntA1HqXRo9gEvq19KzOdmk6xe0g+j7ICsiqOBJERyaM/aXdKMrKdI15BhSZFuroM04eGjqzN+AqqIsWnxlFn8YasURVTlbcuTP943isIlDO/ILusd/3JRgXEkvMyHIU20CcILtiV89EaP3OGOYgtZSs0n+0Kbe2IPYhxOOYSST/X8ONRm3JoWuvgDbwOIYVsCyAI61g8WK/765OvaS49ldvL6PHmXnLPluASoUHzDNdihCOAIBuJYmU9z/sOtqT7uHLeWvQh74o2Ae6c2IFnVKHEQ7R6KTQS+hUMlXH4g3kck9gc4EeShWk8qy11s9EthogZwfLzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GOdGPmLbLK2dWtxDG4fQ+gRLqxmPik3t4IKg2vFwTo=;
 b=RrSBhf9rCm0Gst0I4YHMAyyBCRG/k9L9aQ2tmi7JiZyYuJmokVgEYIApdo9aOJcT2L9dmGKiaOy2vEdFRQVxEJWDlI42wroDrtL3RQHGLpQQnE8+CuwSwhkj0gpw9d3tLcgA0j5RYmHO3XpzPQ62YE6IRXxETWexh2GCQWcVPMQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1211.namprd12.prod.outlook.com (10.168.239.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 08:43:42 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 08:43:42 +0000
Subject: Re: [PATCH 2/2] drm/ttm: Fix vm page protection handling
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
References: <20191126202717.30762-1-thomas_os@shipmail.org>
 <20191126202717.30762-2-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <04b5dae3-6e72-2c35-117a-a79421d274d9@amd.com>
Date:   Wed, 27 Nov 2019 09:43:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191126202717.30762-2-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0031.eurprd07.prod.outlook.com
 (2603:10a6:205:1::44) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0568cbb9-b7f2-42a3-00a5-08d77315e805
X-MS-TrafficTypeDiagnostic: DM5PR12MB1211:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1211C66892F454E687E558E483440@DM5PR12MB1211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 023495660C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(189003)(199004)(31686004)(446003)(11346002)(4326008)(50466002)(65806001)(47776003)(316002)(2616005)(186003)(46003)(2486003)(58126008)(229853002)(65956001)(6246003)(81166006)(81156014)(66556008)(386003)(66476007)(8676002)(6506007)(52116002)(7736002)(54906003)(76176011)(66946007)(23676004)(5660300002)(478600001)(6436002)(99286004)(6116002)(7416002)(8936002)(305945005)(66574012)(6512007)(25786009)(6666004)(14454004)(86362001)(31696002)(2906002)(6486002)(14444005)(36756003)(2870700001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1211;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2aI+74WArvZDM7lEo7TZnFuPzBnIDf3Evbz5PyfQ9kUg1GTUSYOfcrIUtFslGD7ubbfCyTNXyz2PX5L23ItPNGxntRRBpMHX1FdF1d0uDSAzn4xB7z1UNXIcBP7u+dzu5J/ZaktRi/WJo8hrZxCbm/nLWlYRx3o3o6QWHAYetYS5WqyBuyIVvayMxC1wLDpHmEmsVtedQya5Jk5Hrub3L4z/x1hJR9gJKMRTwIzqZPC6D8WgPhPuKYzXdViXlxZEZq01fKBNjXL+1w8JtslmqRJXTg9kFI21286uxjLrnFMxnHt78QItvdggX5d5602skLdHoXuhmoYiZeYtdt8FiwoCz7CJkXmGNBVmLIQYAnlsHqRSwXfViDBYe7nxCLID+a1A+UgGE44ncxG8NU2u6wGfQU4EFnMGOmEO32XVs4MQtqOBgeVR9B93Imvj9fU7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0568cbb9-b7f2-42a3-00a5-08d77315e805
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 08:43:42.2573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFypZ/Ucq29xrbRpEI1kZxa/pmJk3kQOBUriu2tSnxYH1IsrH0ypc+H/PjAK1zHj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.11.19 um 21:27 schrieb Thomas Hellström (VMware):
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> We were using an ugly hack to set the page protection correctly.
> Fix that and instead use vmf_insert_mixed_prot() and / or
> vmf_insert_pfn_prot().
> Also get the default page protection from
> struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
> This way we catch modifications done by the vm system for drivers that
> want write-notification.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index e6495ca2630b..2098f8d4dfc5 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -173,7 +173,6 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   				    pgoff_t num_prefault)
>   {
>   	struct vm_area_struct *vma = vmf->vma;
> -	struct vm_area_struct cvma = *vma;
>   	struct ttm_buffer_object *bo = vma->vm_private_data;
>   	struct ttm_bo_device *bdev = bo->bdev;
>   	unsigned long page_offset;
> @@ -244,7 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   		goto out_io_unlock;
>   	}
>   
> -	cvma.vm_page_prot = ttm_io_prot(bo->mem.placement, prot);
> +	prot = ttm_io_prot(bo->mem.placement, prot);
>   	if (!bo->mem.bus.is_iomem) {
>   		struct ttm_operation_ctx ctx = {
>   			.interruptible = false,
> @@ -260,7 +259,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   		}
>   	} else {
>   		/* Iomem should not be marked encrypted */
> -		cvma.vm_page_prot = pgprot_decrypted(cvma.vm_page_prot);
> +		prot = pgprot_decrypted(prot);
>   	}
>   
>   	/*
> @@ -284,10 +283,11 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>   		}
>   
>   		if (vma->vm_flags & VM_MIXEDMAP)
> -			ret = vmf_insert_mixed(&cvma, address,
> -					__pfn_to_pfn_t(pfn, PFN_DEV));
> +			ret = vmf_insert_mixed_prot(vma, address,
> +						    __pfn_to_pfn_t(pfn, PFN_DEV),
> +						    prot);
>   		else
> -			ret = vmf_insert_pfn(&cvma, address, pfn);
> +			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
>   
>   		/* Never error on prefaulted PTEs */
>   		if (unlikely((ret & VM_FAULT_ERROR))) {
> @@ -319,7 +319,7 @@ vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>   	if (ret)
>   		return ret;
>   
> -	prot = vm_get_page_prot(vma->vm_flags);
> +	prot = vma->vm_page_prot;
>   	ret = ttm_bo_vm_fault_reserved(vmf, prot, TTM_BO_VM_NUM_PREFAULT);
>   	if (ret == VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT))
>   		return ret;

