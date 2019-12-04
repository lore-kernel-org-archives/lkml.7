Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1577C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C9AC20659
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 11:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="AQ6ftDsa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfLDLpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 06:45:13 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:57972 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfLDLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 06:45:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 5747447635;
        Wed,  4 Dec 2019 12:45:10 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=AQ6ftDsa;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YFEw0tE4KGLx; Wed,  4 Dec 2019 12:45:08 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id BBCBD47400;
        Wed,  4 Dec 2019 12:45:02 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id F2518360608;
        Wed,  4 Dec 2019 12:45:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1575459902; bh=IUI8T4+dzUJPrzpV/dC3M/X2apCqGRCy+CHRNfzSFJw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AQ6ftDsafbU5wD6PNdeD/GmblZPIyPmzioENTDbUsj7GU1DUXZBDpLNjxNRb8VjnK
         FPr03dVrQzL6z5izQ5KU5BSh9mteAYeS0Z6leF/91B0plG0KvHi5iAcb0qFv5vXsr7
         jcKTc/P0Igb9y2/dwDRteMg1FKMSRbalu7c2NGKo=
Subject: Re: [PATCH 7/8] drm/ttm: Introduce a huge page aligning TTM range
 manager.
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
 <20191203132239.5910-8-thomas_os@shipmail.org>
 <39b9d651-6afd-1926-7302-aa2a8d4ca626@amd.com>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <7223bee1-cb3f-3d88-a70b-f4e1a5088b76@shipmail.org>
Date:   Wed, 4 Dec 2019 12:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <39b9d651-6afd-1926-7302-aa2a8d4ca626@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/19 12:13 PM, Christian König wrote:
> Am 03.12.19 um 14:22 schrieb Thomas Hellström (VMware):
>> From: Thomas Hellstrom <thellstrom@vmware.com>
>>
>> Using huge page-table entries require that the start of a buffer object
>> is huge page size aligned. So introduce a ttm_bo_man_get_node_huge()
>> function that attempts to accomplish this for allocations that are 
>> larger
>> than the huge page size, and provide a new range-manager instance that
>> uses that function.
>
> I still don't think that this is a good idea.

Again, can you elaborate with some specific concerns?

>
> The driver/userspace should just use a proper alignment if it wants to 
> use huge pages.

There are drawbacks with this approach. The TTM alignment is a hard 
constraint. Assume that you want to fit a 1GB buffer object into limited 
VRAM space, and _if possible_ use PUD size huge pages. Let's say there 
is 1GB available, but not 1GB aligned. The proper alignment approach 
would fail and possibly start to evict stuff from VRAM just to be able 
to accomodate the PUD alignment. That's bad. The approach I suggest 
would instead fall back to PMD alignment and use 2MB page table entries 
if possible, and as a last resort use 4K page table entries.

Or do I misunderstand how you envision enforcing the alignment?

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
>>   drivers/gpu/drm/ttm/ttm_bo_manager.c | 92 ++++++++++++++++++++++++++++
>>   include/drm/ttm/ttm_bo_driver.h      |  1 +
>>   2 files changed, 93 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_manager.c 
>> b/drivers/gpu/drm/ttm/ttm_bo_manager.c
>> index 18d3debcc949..26aa1a2ae7f1 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_manager.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_manager.c
>> @@ -89,6 +89,89 @@ static int ttm_bo_man_get_node(struct 
>> ttm_mem_type_manager *man,
>>       return 0;
>>   }
>>   +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> +static int ttm_bo_insert_aligned(struct drm_mm *mm, struct 
>> drm_mm_node *node,
>> +                 unsigned long align_pages,
>> +                 const struct ttm_place *place,
>> +                 struct ttm_mem_reg *mem,
>> +                 unsigned long lpfn,
>> +                 enum drm_mm_insert_mode mode)
>> +{
>> +    if (align_pages >= mem->page_alignment &&
>> +        (!mem->page_alignment || align_pages % mem->page_alignment 
>> == 0)) {
>> +        return drm_mm_insert_node_in_range(mm, node,
>> +                           mem->num_pages,
>> +                           align_pages, 0,
>> +                           place->fpfn, lpfn, mode);
>> +    }
>> +
>> +    return -ENOSPC;
>> +}
>> +
>> +static int ttm_bo_man_get_node_huge(struct ttm_mem_type_manager *man,
>> +                    struct ttm_buffer_object *bo,
>> +                    const struct ttm_place *place,
>> +                    struct ttm_mem_reg *mem)
>> +{
>> +    struct ttm_range_manager *rman = (struct ttm_range_manager *) 
>> man->priv;
>> +    struct drm_mm *mm = &rman->mm;
>> +    struct drm_mm_node *node;
>> +    unsigned long align_pages;
>> +    unsigned long lpfn;
>> +    enum drm_mm_insert_mode mode = DRM_MM_INSERT_BEST;
>> +    int ret;
>> +
>> +    node = kzalloc(sizeof(*node), GFP_KERNEL);
>> +    if (!node)
>> +        return -ENOMEM;
>> +
>> +    lpfn = place->lpfn;
>> +    if (!lpfn)
>> +        lpfn = man->size;
>> +
>> +    mode = DRM_MM_INSERT_BEST;
>> +    if (place->flags & TTM_PL_FLAG_TOPDOWN)
>> +        mode = DRM_MM_INSERT_HIGH;
>> +
>> +    spin_lock(&rman->lock);
>> +    if (IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD)) {
>> +        align_pages = (HPAGE_PUD_SIZE >> PAGE_SHIFT);
>> +        if (mem->num_pages >= align_pages) {
>> +            ret = ttm_bo_insert_aligned(mm, node, align_pages,
>> +                            place, mem, lpfn, mode);
>> +            if (!ret)
>> +                goto found_unlock;
>> +        }
>> +    }
>> +
>> +    align_pages = (HPAGE_PMD_SIZE >> PAGE_SHIFT);
>> +    if (mem->num_pages >= align_pages) {
>> +        ret = ttm_bo_insert_aligned(mm, node, align_pages, place, mem,
>> +                        lpfn, mode);
>> +        if (!ret)
>> +            goto found_unlock;
>> +    }
>> +
>> +    ret = drm_mm_insert_node_in_range(mm, node, mem->num_pages,
>> +                      mem->page_alignment, 0,
>> +                      place->fpfn, lpfn, mode);
>> +found_unlock:
>> +    spin_unlock(&rman->lock);
>> +
>> +    if (unlikely(ret)) {
>> +        kfree(node);
>> +    } else {
>> +        mem->mm_node = node;
>> +        mem->start = node->start;
>> +    }
>> +
>> +    return 0;
>> +}
>> +#else
>> +#define ttm_bo_man_get_node_huge ttm_bo_man_get_node
>> +#endif
>> +
>> +
>>   static void ttm_bo_man_put_node(struct ttm_mem_type_manager *man,
>>                   struct ttm_mem_reg *mem)
>>   {
>> @@ -154,3 +237,12 @@ const struct ttm_mem_type_manager_func 
>> ttm_bo_manager_func = {
>>       .debug = ttm_bo_man_debug
>>   };
>>   EXPORT_SYMBOL(ttm_bo_manager_func);
>> +
>> +const struct ttm_mem_type_manager_func ttm_bo_manager_huge_func = {
>> +    .init = ttm_bo_man_init,
>> +    .takedown = ttm_bo_man_takedown,
>> +    .get_node = ttm_bo_man_get_node_huge,
>> +    .put_node = ttm_bo_man_put_node,
>> +    .debug = ttm_bo_man_debug
>> +};
>> +EXPORT_SYMBOL(ttm_bo_manager_huge_func);
>> diff --git a/include/drm/ttm/ttm_bo_driver.h 
>> b/include/drm/ttm/ttm_bo_driver.h
>> index cac7a8a0825a..868bd0d4be6a 100644
>> --- a/include/drm/ttm/ttm_bo_driver.h
>> +++ b/include/drm/ttm/ttm_bo_driver.h
>> @@ -888,5 +888,6 @@ int ttm_bo_pipeline_gutting(struct 
>> ttm_buffer_object *bo);
>>   pgprot_t ttm_io_prot(uint32_t caching_flags, pgprot_t tmp);
>>     extern const struct ttm_mem_type_manager_func ttm_bo_manager_func;
>> +extern const struct ttm_mem_type_manager_func ttm_bo_manager_huge_func;
>>     #endif


