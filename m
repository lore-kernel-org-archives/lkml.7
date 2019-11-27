Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418CEC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E46D2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aoJu8fh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfK0KFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:05:50 -0500
Received: from mail-eopbgr680068.outbound.protection.outlook.com ([40.107.68.68]:37510
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726143AbfK0KFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:05:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFeRAoz9CmVkT7E1kKUyesq9fFTMODW5+errN6n7wSSMQdw5/8DBF6V5sBsp/kixp86bvOJbjVCftVDWApJPQcjTYVUTFnha0+llcVT9QZnvFgiyhtDQDeWmGwzoWf+EVg70aq+pmsB/ro0qHesw6f0zFN9PakCic/JBG7kq3oEl+VaKwHh66k+Eod6k2dNABTLdB3Kk/hVl8tmVy7RcHaBXtghptMytD/VyAadVg81n4q9iujX8wvRFVHgGh34yC6rU8+wyDxuuo0IsyrslfyjmTJ66ZcVFFmXZzpUeenhqBCApfRRVg0dy1bcJ+/vKAXZJs+uBy5MKREImuSXzJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nGH0I1hFT2Gt9NUfDAnLyV5MNlTHpPaHNKR7xWqbJE=;
 b=M86yPYFjb8sYBJm42E6AlOTmBv65ADEOiYnf4S0u3RpPWyAtq6WfE34bJT+5kEXVSr6n2tNQLBoQgHRDy27z2++QceA3owrDhfPYrmODatwl3eh7gefl+8SZOWvE2n7CC+qi4ZhwcEmQIrlcycbXfD2bErJrLZv5CQo5DJKKAxXKZCgVManm/mp69V3nrGXaoQy2eEjaY42rYM85uvRjbKEnqw8As25vCqJGTgbHYh2q9UJqczBU3ovASMvTEhqX6FmLdK2m5uvK3J/gwMIrKc+Tb6mlCBzYcvThXAblsVUYiFsostrmyQW08evGpVWrQXpVOB7yrKUQE7teC5YKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3nGH0I1hFT2Gt9NUfDAnLyV5MNlTHpPaHNKR7xWqbJE=;
 b=aoJu8fh25mqzehb76RSrZM/+Zs/zpaDMW/qTv6jfBFrTNkkTjbhsjFKPPRE3zesM5JIfEAw/3SOuhCeaEMeHXh2Sha5PZzEL7McNGpNwcyVIIUD5I5YOnOxNK8fk2DVXdKRkVMZ9Bp8cx2XwpTawuoS6DTJvcykPkW5lZDsO+2U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1692.namprd12.prod.outlook.com (10.172.34.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Wed, 27 Nov 2019 10:05:46 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::e5e7:96f0:ad90:d933%7]) with mapi id 15.20.2474.023; Wed, 27 Nov 2019
 10:05:45 +0000
Subject: Re: [RFC PATCH 6/7] drm/ttm: Introduce a huge page aligning TTM range
 manager.
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
 <20191127083120.34611-7-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c43b3dc8-7ec2-542b-a767-a725cf9c442b@amd.com>
Date:   Wed, 27 Nov 2019 11:05:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20191127083120.34611-7-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0082.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::23) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 622272b5-7a2e-4b18-ed85-08d773215eb1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1692:
X-Microsoft-Antispam-PRVS: <DM5PR12MB16920CEBB6EABE2BF8B2E2B983440@DM5PR12MB1692.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 023495660C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(66476007)(66556008)(66946007)(31686004)(2906002)(2870700001)(6666004)(478600001)(6436002)(6486002)(4326008)(6512007)(6246003)(65806001)(47776003)(65956001)(5660300002)(66574012)(6116002)(7736002)(386003)(58126008)(305945005)(229853002)(25786009)(46003)(50466002)(6506007)(2486003)(186003)(8936002)(86362001)(23676004)(14444005)(76176011)(316002)(81156014)(14454004)(31696002)(8676002)(81166006)(2616005)(52116002)(54906003)(7416002)(36756003)(446003)(11346002)(99286004)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1692;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Q/7j9XWC+t/gv/wx1/6Ub/ScbbQgFV3j3ZL7IEKYJIb/mmJ77eqmlYfee3xBlWhQKozyZn3Ncdtoy/yrAEgKaEcOrRnzAUc0Q0nXUOBVc+BhEu9q4DahYExP1LPtU6o8x/Y9cpBPWrMQaMNvzLu0Xt+nkZryTLC332+2uHPsI2JwIzJb1ukpuzTP9hHfnPmtq/YsB5kLHu+hmLvkM+9QUgOwwtWVRbgvJu8omcztqIA093qw7mqdTL8JHljHhc46aO5OvGFERYSYNX10rZRbeMsaHoP5qZi7AV2wghV3OO2Uhc7sFjVpaYw1b9HKexShV/0FxotIRVyddLsPw1KLt2WMyolrXGy/dQkaXUI1MOu5gyh58U/FStWbCLRCxnygMD+nW/kA15hrnResIaZVZ8tSBN/dEy7FZc/tRCpE0OI0SgWJFAFzKMgR36zVe3f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622272b5-7a2e-4b18-ed85-08d773215eb1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2019 10:05:45.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plg25KJFKz0YDjeEYDChzSbpPh+pXt997UJ/0gEF6Vp9bSGh1RzH2zNa1ay2gP1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see the advantage over just increasing the alignment 
requirements in the driver side?

That would be a one liner if I'm not completely mistaken.

Regards,
Christian.

Am 27.11.19 um 09:31 schrieb Thomas Hellström (VMware):
> From: Thomas Hellstrom <thellstrom@vmware.com>
>
> Using huge page-table entries require that the start of a buffer object
> is huge page size aligned. So introduce a ttm_bo_man_get_node_huge()
> function that attempts to accomplish this for allocations that are larger
> than the huge page size, and provide a new range-manager instance that
> uses that function.
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

