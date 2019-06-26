Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7ABC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E09208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfFZIRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:17:13 -0400
Received: from foss.arm.com ([217.140.110.172]:56062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbfFZIRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:17:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE1232B;
        Wed, 26 Jun 2019 01:17:09 -0700 (PDT)
Received: from [10.162.40.140] (p8cg001049571a15.blr.arm.com [10.162.40.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A38793F246;
        Wed, 26 Jun 2019 01:17:06 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] mm,memory_hotplug: allocate memmap from the added
 memory range for sparse-vmemmap
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@soleen.com, Jonathan.Cameron@huawei.com,
        david@redhat.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190625075227.15193-1-osalvador@suse.de>
 <20190625075227.15193-5-osalvador@suse.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <3056b153-20a3-ac86-4a49-c26f8be4b2a6@arm.com>
Date:   Wed, 26 Jun 2019 13:47:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190625075227.15193-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oscar,

On 06/25/2019 01:22 PM, Oscar Salvador wrote:
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 93ed0df4df79..d4b5661fa6b6 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -765,7 +765,10 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>  		if (pmd_none(READ_ONCE(*pmdp))) {
>  			void *p = NULL;
>  
> -			p = vmemmap_alloc_block_buf(PMD_SIZE, node);
> +			if (altmap)
> +				p = altmap_alloc_block_buf(PMD_SIZE, altmap);
> +			else
> +				p = vmemmap_alloc_block_buf(PMD_SIZE, node);
>  			if (!p)
>  				return -ENOMEM;

Is this really required to be part of this series ? I have an ongoing work
(reworked https://patchwork.kernel.org/patch/10882781/) enabling altmap
support on arm64 during memory hot add and remove path which is waiting on
arm64 memory-hot remove to be merged first.

- Anshuman
