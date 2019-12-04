Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49657C2BBE2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147722073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OC/ZhxT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfLDLNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:13:45 -0500
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:17363
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLDLNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:13:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gC+DkWJM5DsGI788QqKWzaOAX61tmJ4nD5AJeMBtv+GAkeT7blryCbAJPCifPHXFlzjuGNr3pgT6JZXaK7WLCMNfHxtKLTvRtg1GndY0KStUk9nx5ErbAoIUi5Y59Y9g2kfH1kaWslcwZ8jc3S5VSHfCRSpF+OuVSx4CBdT7cPtCMjcLftGiWaEmDAITIlVsX2oycMGILo+msU69Na6NGRWzlj5u4V+0LeVmECSWwSJfMZuAcGiin5KNhMg46eW/1xiWJAq5igGvUQ1+59RrNswXl/640HFrjNrW7W2rUzIl86ZGE8htTAZv2+ECMe6YZJunwqzWi/VqCsdypp27bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI+SQr1I75+EWSiNTlzsSzWJtxQAWHytHBZP8wHRE0s=;
 b=joFcb0O4lfA8bFfbzXWTLRvrdKnCKIHt6k4VDtbp46ZWBT1dT6tEsMBw+4dOYoSxDJTVndv48TJxlstc73fSrmGLGbDIaAYeQSJTvnBkHNG0JA6Qj5xzbmN7IM7uql0stikzlYkQvQ9DZpsK7O6MUfszgn1taOkk3Zk/zTgNEOGyVkKbT0Un7mhGVWeNJrk1gYUJwXVq6I+aVCs4JOKYIxa9a4lw4PRnFeV3OWiH7qOmDzAmY+aF9pe7vmFr9AvxkawQ23p8112kbFNo2mikjK1tn3pVsf2D4UocuRLPAYSwXkmXQafZb/DHQcIiOZsASIUdhbMaJOQo8Y/E7IqaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI+SQr1I75+EWSiNTlzsSzWJtxQAWHytHBZP8wHRE0s=;
 b=OC/ZhxT8kw8kKxoQ1+a6Z/LPrlhki7qmznsi8TAHuq0GZmop5BQzxcQIAJ+e1hH++j4XWCwqFH+WDk15SzYh7Tp1plKbqMH89hwBglY7SAIqmW8M8855ubKg9a3bRUwrG8wBwyAZ7n4xLImqT7kDA4B7XrR4XJQamKttKVqeuwM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1579.namprd12.prod.outlook.com (10.172.38.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.13; Wed, 4 Dec 2019 11:13:40 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 11:13:40 +0000
Subject: Re: [PATCH 7/8] drm/ttm: Introduce a huge page aligning TTM range
 manager.
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
 <20191203132239.5910-8-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <39b9d651-6afd-1926-7302-aa2a8d4ca626@amd.com>
Date:   Wed, 4 Dec 2019 12:13:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191203132239.5910-8-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::33) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84404af2-d807-41cf-5873-08d778ab0426
X-MS-TrafficTypeDiagnostic: DM5PR12MB1579:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1579E9B571AF56A1E347B592835D0@DM5PR12MB1579.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(199004)(189003)(229853002)(7416002)(31686004)(316002)(6512007)(36756003)(305945005)(2906002)(31696002)(6486002)(2870700001)(52116002)(6436002)(6666004)(76176011)(7736002)(14444005)(58126008)(23676004)(6116002)(478600001)(6506007)(25786009)(99286004)(14454004)(66574012)(186003)(50466002)(81156014)(81166006)(2616005)(11346002)(8936002)(65956001)(8676002)(5660300002)(4326008)(66556008)(66476007)(6246003)(66946007)(86362001)(54906003)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1579;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AnsMKwcNeHemgmc4Nx8VwPcKn+K5hmqmr4TDv44Kz04B3uSh3DAnQs9JR8vtrIrEKkTV6BzjkCo9SMfJaNcI+BjgPHJ3x8IdxfmlA9EKib8zkfQGXhjHjfSRuq4AacwCVxGAtsC1ee5d9l05xw9KQW+ezxzxQ66KHgQXS7TVb6g4/5eDYl/IDrOXm5TeWwv+HPpMMPJcjOlivKzeIvd8G572e97eAflGx60F9vpzkMFFVCihLd0Bt7WS8gHhFoM5e/e4pk6KF5A3UC3kl9V4rQBRrVbFVN+PWd2+Fk5cniYy4XxsVR1HAmLSwFs0ZVHsEacjx+LhDon1AfcWBREk0rsh/lQOH6WuGMsdn1wjcJ3UjxgG1RJP+omBFyl0ojwKc8Fd5kduQGRCSafh/2l8GKWK7DwZUvXUd8QOhLROWtcxRSPwSWNTYwAuceg51bkpk3ShaKFiWYx80KpNwAGR9psToIE8+mBoGnOO0BhkerJAexmVSjGr9IniNLQlSTZZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84404af2-d807-41cf-5873-08d778ab0426
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 11:13:40.2046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrlEtBROiD/bihZ56UqXLpozZjX5E8vJ1tFHNvRP3LQiK8bHUUF0xak8/GSqvKfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> Using huge page-table entries require that the start of a buffer object
> is huge page size aligned. So introduce a ttm_bo_man_get_node_huge()
> function that attempts to accomplish this for allocations that are larger
> than the huge page size, and provide a new range-manager instance that
> uses that function.

I still don't think that this is a good idea.

The driver/userspace should just use a proper alignment if it wants to 
use huge pages.

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
>   drivers/gpu/drm/ttm/ttm_bo_manager.c | 92 ++++++++++++++++++++++++++++
>   include/drm/ttm/ttm_bo_driver.h      |  1 +
>   2 files changed, 93 insertions(+)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_manager.c b/drivers/gpu/drm/ttm/ttm_bo_manager.c
> index 18d3debcc949..26aa1a2ae7f1 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_manager.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_manager.c
> @@ -89,6 +89,89 @@ static int ttm_bo_man_get_node(struct ttm_mem_type_manager *man,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +static int ttm_bo_insert_aligned(struct drm_mm *mm, struct drm_mm_node *node,
> +				 unsigned long align_pages,
> +				 const struct ttm_place *place,
> +				 struct ttm_mem_reg *mem,
> +				 unsigned long lpfn,
> +				 enum drm_mm_insert_mode mode)
> +{
> +	if (align_pages >= mem->page_alignment &&
> +	    (!mem->page_alignment || align_pages % mem->page_alignment == 0)) {
> +		return drm_mm_insert_node_in_range(mm, node,
> +						   mem->num_pages,
> +						   align_pages, 0,
> +						   place->fpfn, lpfn, mode);
> +	}
> +
> +	return -ENOSPC;
> +}
> +
> +static int ttm_bo_man_get_node_huge(struct ttm_mem_type_manager *man,
> +				    struct ttm_buffer_object *bo,
> +				    const struct ttm_place *place,
> +				    struct ttm_mem_reg *mem)
> +{
> +	struct ttm_range_manager *rman = (struct ttm_range_manager *) man->priv;
> +	struct drm_mm *mm = &rman->mm;
> +	struct drm_mm_node *node;
> +	unsigned long align_pages;
> +	unsigned long lpfn;
> +	enum drm_mm_insert_mode mode = DRM_MM_INSERT_BEST;
> +	int ret;
> +
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +
> +	lpfn = place->lpfn;
> +	if (!lpfn)
> +		lpfn = man->size;
> +
> +	mode = DRM_MM_INSERT_BEST;
> +	if (place->flags & TTM_PL_FLAG_TOPDOWN)
> +		mode = DRM_MM_INSERT_HIGH;
> +
> +	spin_lock(&rman->lock);
> +	if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)) {
> +		align_pages = (HPAGE_PUD_SIZE >> PAGE_SHIFT);
> +		if (mem->num_pages >= align_pages) {
> +			ret = ttm_bo_insert_aligned(mm, node, align_pages,
> +						    place, mem, lpfn, mode);
> +			if (!ret)
> +				goto found_unlock;
> +		}
> +	}
> +
> +	align_pages = (HPAGE_PMD_SIZE >> PAGE_SHIFT);
> +	if (mem->num_pages >= align_pages) {
> +		ret = ttm_bo_insert_aligned(mm, node, align_pages, place, mem,
> +					    lpfn, mode);
> +		if (!ret)
> +			goto found_unlock;
> +	}
> +
> +	ret = drm_mm_insert_node_in_range(mm, node, mem->num_pages,
> +					  mem->page_alignment, 0,
> +					  place->fpfn, lpfn, mode);
> +found_unlock:
> +	spin_unlock(&rman->lock);
> +
> +	if (unlikely(ret)) {
> +		kfree(node);
> +	} else {
> +		mem->mm_node = node;
> +		mem->start = node->start;
> +	}
> +
> +	return 0;
> +}
> +#else
> +#define ttm_bo_man_get_node_huge ttm_bo_man_get_node
> +#endif
> +
> +
>   static void ttm_bo_man_put_node(struct ttm_mem_type_manager *man,
>   				struct ttm_mem_reg *mem)
>   {
> @@ -154,3 +237,12 @@ const struct ttm_mem_type_manager_func ttm_bo_manager_func = {
>   	.debug = ttm_bo_man_debug
>   };
>   EXPORT_SYMBOL(ttm_bo_manager_func);
> +
> +const struct ttm_mem_type_manager_func ttm_bo_manager_huge_func = {
> +	.init = ttm_bo_man_init,
> +	.takedown = ttm_bo_man_takedown,
> +	.get_node = ttm_bo_man_get_node_huge,
> +	.put_node = ttm_bo_man_put_node,
> +	.debug = ttm_bo_man_debug
> +};
> +EXPORT_SYMBOL(ttm_bo_manager_huge_func);
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index cac7a8a0825a..868bd0d4be6a 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -888,5 +888,6 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo);
>   pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp);
>   
>   extern const struct ttm_mem_type_manager_func ttm_bo_manager_func;
> +extern const struct ttm_mem_type_manager_func ttm_bo_manager_huge_func;
>   
>   #endif

