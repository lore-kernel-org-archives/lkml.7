Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1F9C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB7920833
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 12:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="d27KWTH1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfLDMQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 07:16:54 -0500
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:6039
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727445AbfLDMQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 07:16:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNkePJwHQGE22BKxRSnv4zkcJnTIzgWAPWzmKf1OEs/M0Xn/hCJYiZPhll7nMQbMPGOQPaNPfRS5uvPZbaa+cswXQ0F2ORAC1DddyQMRH/+dwnSXqjboDgc2KN1r5ds93rL+5i2jN2jq6ueGrwKUbSBNBbTo7VoKuiJg84+T3ZYju6zH0JrHoTtmuuBkNpj0krWp0WlCqi4RFVkZibAT93HkVqEC6aI3JDNcDL1a4zIBu/7rUrCmvT/8TpHUSGJBNCFNvyReBza2Vxr0SWELpdTXRigO4bLhnKmn3utWY7exm0YlYQ/KuQwGKmPpq93le0A1Plzr8fiIE2c6Sh7DVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgrpgcZglvWl+Z9U2/ciJQ/EgzWXTmO64sOnn9cwfp8=;
 b=T7HjLEkP9+2UWu1EeCT82Z287z3gQz6pphDmQvBedbJv42ZbGtMhOL8xFfexQLxQ//52YIBLUCCa2oxRL/diFdAGk9KCq1h4OQfws/H9VIWCvdegSFyoUTtkOPMrOXKzQ9EwNj9YMT4brZPdt7JSO1i8GZOrihvYNVplnssCAoH32EnZvn7TQLApUuDOfYC3E618aSMklNHm0TN9L5/yKb6A8ZpQgrSr2mgwfEl9tm7nJU65YTXshrv4uhuOOKUj020EQ0dEEnZIsGOgGl9aFqSueok4pNklNHgxDcAFVskBWN20+hIZoT+Ogams5bD4L5/9VGqyGy85mCPcihoyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgrpgcZglvWl+Z9U2/ciJQ/EgzWXTmO64sOnn9cwfp8=;
 b=d27KWTH1UXYjVAqh3mKg72ucIiJvOmqnzkQ0oxmh1BmbKPtG13GUi4S4tuh3ynByDDFmg82M6PmIV7MSepvLVJmoAxEwM1k49DqYZGSIbq30o9TpWLk36IvV4tUIWETapEF/r6wqsGMeOAuKkgpl6smSFHQ5hIIxUldxRNh5gKE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1820.namprd12.prod.outlook.com (10.175.88.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 12:16:46 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::80df:f8b:e547:df84%12]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 12:16:46 +0000
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
 <39b9d651-6afd-1926-7302-aa2a8d4ca626@amd.com>
 <7223bee1-cb3f-3d88-a70b-f4e1a5088b76@shipmail.org>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f87a03da-ea9d-fe2b-8069-8fe0bda57c12@amd.com>
Date:   Wed, 4 Dec 2019 13:16:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <7223bee1-cb3f-3d88-a70b-f4e1a5088b76@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::28) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b05f807e-4fc0-422e-2ad0-08d778b3d4e9
X-MS-TrafficTypeDiagnostic: DM5PR12MB1820:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1820EA9A7F32684F39B30912835D0@DM5PR12MB1820.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0241D5F98C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(189003)(199004)(66946007)(5660300002)(7736002)(66476007)(6512007)(14444005)(50466002)(86362001)(66556008)(6666004)(7416002)(4326008)(31686004)(31696002)(6246003)(305945005)(25786009)(54906003)(58126008)(316002)(6116002)(8936002)(186003)(229853002)(65956001)(2870700001)(8676002)(11346002)(478600001)(2906002)(81166006)(81156014)(14454004)(2616005)(52116002)(66574012)(23676004)(6436002)(76176011)(36756003)(99286004)(6506007)(53546011)(6486002)(14583001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1820;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mk4NoVQ+xuz1kYuVEcVfkJYO2MCBiaZ379N9fO3Jywhen3DOR/JJVskOumSvl4eBSTYmhPGXSdT5nxuKX4ivGU73PvuDUvxBvSK8OUnHDpvMsPRZAY6umBlKpklqvKMAmg3Jb93UtLsZuFPkXXRhwdHYu1+Ju+RGCIp64RhiiLOrD72/+x/wdhfvf5bFMzDTx55uDsULoSR8/eWCOokSGXN0/b38gKooEQyoeIumpeaqjHFHWvauFH6S5MZJZHqVpjjQCX6ZbIsRlOMSG7sDHEld1f6v8BblithtSPQROCCjf1RmnVHG8Uq3dOIZOtWMSjVxQYYUXqadjt0KPMpAyahCif9sU0J5devlm9hqTznnEHGafgkJqpWY7O6TkpXJ8nd85nNUSaCU4/p/pUxZmOfu6dVzU8JAJrzHhn18GUy3+EACHqSrDQrKg3/zVSJCuJiaEXmUSz3XtvFULddet6IVdRHmXpcQZRbK5N7M0RFHAai7oGlASKtZtY0Au8WP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05f807e-4fc0-422e-2ad0-08d778b3d4e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2019 12:16:46.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfFHrXHEP7HNWm4qjkUSLoWBxPUIqS3dXoV6Lf3xWuVh/9bOQzft2VVvDi5tSmbi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1820
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.12.19 um 12:45 schrieb Thomas Hellström (VMware):
> On 12/4/19 12:13 PM, Christian König wrote:
>> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>>
>>> Using huge page-table entries require that the start of a buffer object
>>> is huge page size aligned. So introduce a ttm_bo_man_get_node_huge()
>>> function that attempts to accomplish this for allocations that are 
>>> larger
>>> than the huge page size, and provide a new range-manager instance that
>>> uses that function.
>>
>> I still don't think that this is a good idea.
>
> Again, can you elaborate with some specific concerns?

You seems to be seeing PUD as something optional.

>>
>> The driver/userspace should just use a proper alignment if it wants 
>> to use huge pages.
>
> There are drawbacks with this approach. The TTM alignment is a hard 
> constraint. Assume that you want to fit a 1GB buffer object into 
> limited VRAM space, and _if possible_ use PUD size huge pages. Let's 
> say there is 1GB available, but not 1GB aligned. The proper alignment 
> approach would fail and possibly start to evict stuff from VRAM just 
> to be able to accomodate the PUD alignment. That's bad. The approach I 
> suggest would instead fall back to PMD alignment and use 2MB page 
> table entries if possible, and as a last resort use 4K page table 
> entries.

And exactly that sounds like a bad idea to me.

Using 1GB alignment is indeed unrealistic in most cases, but for 2MB 
alignment we should really start to evict BOs.

Otherwise the address space can become fragmented and we won't be able 
de-fragment it in any way.

Additional to that 2MB pages is becoming mandatory for some hardware 
features. E.g. scanning out of system memory won't be possible with 4k 
pages in the future.

Regards,
Christian.

> Or do I misunderstand how you envision enforcing the alignment?
>
> Thanks,
>
> Thomas
>
>
>
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
>>>   drivers/gpu/drm/ttm/ttm_bo_manager.c | 92 
>>> ++++++++++++++++++++++++++++
>>>   include/drm/ttm/ttm_bo_driver.h      |  1 +
>>>   2 files changed, 93 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_manager.c 
>>> b/drivers/gpu/drm/ttm/ttm_bo_manager.c
>>> index 18d3debcc949..26aa1a2ae7f1 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo_manager.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo_manager.c
>>> @@ -89,6 +89,89 @@ static int ttm_bo_man_get_node(struct 
>>> ttm_mem_type_manager *man,
>>>       return 0;
>>>   }
>>>   +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>> +static int ttm_bo_insert_aligned(struct drm_mm *mm, struct 
>>> drm_mm_node *node,
>>> +                 unsigned long align_pages,
>>> +                 const struct ttm_place *place,
>>> +                 struct ttm_mem_reg *mem,
>>> +                 unsigned long lpfn,
>>> +                 enum drm_mm_insert_mode mode)
>>> +{
>>> +    if (align_pages >= mem->page_alignment &&
>>> +        (!mem->page_alignment || align_pages % mem->page_alignment 
>>> == 0)) {
>>> +        return drm_mm_insert_node_in_range(mm, node,
>>> +                           mem->num_pages,
>>> +                           align_pages, 0,
>>> +                           place->fpfn, lpfn, mode);
>>> +    }
>>> +
>>> +    return -ENOSPC;
>>> +}
>>> +
>>> +static int ttm_bo_man_get_node_huge(struct ttm_mem_type_manager *man,
>>> +                    struct ttm_buffer_object *bo,
>>> +                    const struct ttm_place *place,
>>> +                    struct ttm_mem_reg *mem)
>>> +{
>>> +    struct ttm_range_manager *rman = (struct ttm_range_manager *) 
>>> man->priv;
>>> +    struct drm_mm *mm = &rman->mm;
>>> +    struct drm_mm_node *node;
>>> +    unsigned long align_pages;
>>> +    unsigned long lpfn;
>>> +    enum drm_mm_insert_mode mode = DRM_MM_INSERT_BEST;
>>> +    int ret;
>>> +
>>> +    node = kzalloc(sizeof(*node), GFP_KERNEL);
>>> +    if (!node)
>>> +        return -ENOMEM;
>>> +
>>> +    lpfn = place->lpfn;
>>> +    if (!lpfn)
>>> +        lpfn = man->size;
>>> +
>>> +    mode = DRM_MM_INSERT_BEST;
>>> +    if (place->flags & TTM_PL_FLAG_TOPDOWN)
>>> +        mode = DRM_MM_INSERT_HIGH;
>>> +
>>> +    spin_lock(&rman->lock);
>>> +    if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)) {
>>> +        align_pages = (HPAGE_PUD_SIZE >> PAGE_SHIFT);
>>> +        if (mem->num_pages >= align_pages) {
>>> +            ret = ttm_bo_insert_aligned(mm, node, align_pages,
>>> +                            place, mem, lpfn, mode);
>>> +            if (!ret)
>>> +                goto found_unlock;
>>> +        }
>>> +    }
>>> +
>>> +    align_pages = (HPAGE_PMD_SIZE >> PAGE_SHIFT);
>>> +    if (mem->num_pages >= align_pages) {
>>> +        ret = ttm_bo_insert_aligned(mm, node, align_pages, place, mem,
>>> +                        lpfn, mode);
>>> +        if (!ret)
>>> +            goto found_unlock;
>>> +    }
>>> +
>>> +    ret = drm_mm_insert_node_in_range(mm, node, mem->num_pages,
>>> +                      mem->page_alignment, 0,
>>> +                      place->fpfn, lpfn, mode);
>>> +found_unlock:
>>> +    spin_unlock(&rman->lock);
>>> +
>>> +    if (unlikely(ret)) {
>>> +        kfree(node);
>>> +    } else {
>>> +        mem->mm_node = node;
>>> +        mem->start = node->start;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +#else
>>> +#define ttm_bo_man_get_node_huge ttm_bo_man_get_node
>>> +#endif
>>> +
>>> +
>>>   static void ttm_bo_man_put_node(struct ttm_mem_type_manager *man,
>>>                   struct ttm_mem_reg *mem)
>>>   {
>>> @@ -154,3 +237,12 @@ const struct ttm_mem_type_manager_func 
>>> ttm_bo_manager_func = {
>>>       .debug = ttm_bo_man_debug
>>>   };
>>>   EXPORT_SYMBOL(ttm_bo_manager_func);
>>> +
>>> +const struct ttm_mem_type_manager_func ttm_bo_manager_huge_func = {
>>> +    .init = ttm_bo_man_init,
>>> +    .takedown = ttm_bo_man_takedown,
>>> +    .get_node = ttm_bo_man_get_node_huge,
>>> +    .put_node = ttm_bo_man_put_node,
>>> +    .debug = ttm_bo_man_debug
>>> +};
>>> +EXPORT_SYMBOL(ttm_bo_manager_huge_func);
>>> diff --git a/include/drm/ttm/ttm_bo_driver.h 
>>> b/include/drm/ttm/ttm_bo_driver.h
>>> index cac7a8a0825a..868bd0d4be6a 100644
>>> --- a/include/drm/ttm/ttm_bo_driver.h
>>> +++ b/include/drm/ttm/ttm_bo_driver.h
>>> @@ -888,5 +888,6 @@ int ttm_bo_pipeline_gutting(struct 
>>> ttm_buffer_object *bo);
>>>   pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp);
>>>     extern const struct ttm_mem_type_manager_func ttm_bo_manager_func;
>>> +extern const struct ttm_mem_type_manager_func 
>>> ttm_bo_manager_huge_func;
>>>     #endif
>
>

