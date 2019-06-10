Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA1C468BC
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9525207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560151621;
	bh=LRAuRE7ce8qz4+Kbkc30Cgj4pRg85qA2MXbM0HL90ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0O/15va4zMTnYCFQIZLOPH87lb7eU9/ykaxTTriJH0ip4+RCT7xkVJMTEV/yRfLDh
	 xATRNK8wV4Eawo5t8xIL5eRM8fDGk77r0lNAgoTcFOmjqZRHfiEARgJ2FSfjCV3YJx
	 wQUQmSXiGMyFCnC+jNGJwvubk3zMztwA73ux8w+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbfFJH1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:27:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:59628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387982AbfFJH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:26:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6B06FAE5A;
        Mon, 10 Jun 2019 07:26:56 +0000 (UTC)
Date:   Mon, 10 Jun 2019 09:26:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     ChenGang <cg.chen@huawei.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, osalvador@suse.de,
        pavel.tatashin@microsoft.com, mgorman@techsingularity.net,
        rppt@linux.ibm.com, richard.weiyang@gmail.com,
        alexander.h.duyck@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: align up min_free_kbytes to multipy of 4
Message-ID: <20190610072655.GB30967@dhcp22.suse.cz>
References: <1560071428-24267-1-git-send-email-cg.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560071428-24267-1-git-send-email-cg.chen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 09-06-19 17:10:28, ChenGang wrote:
> Usually the value of min_free_kbytes is multiply of 4,
> and in this case ,the right shift is ok.
> But if it's not, the right-shifting operation will lose the low 2 bits,
> and this cause kernel don't reserve enough memory.
> So it's necessary to align the value of min_free_kbytes to multiply of 4.
> For example, if min_free_kbytes is 64, then should keep 16 pages,
> but if min_free_kbytes is 65 or 66, then should keep 17 pages.

Could you describe the actual problem? Do we ever generate
min_free_kbytes that would lead to unexpected reserves or is this trying
to compensate for those values being configured from the userspace? If
later why do we care at all?

Have you seen this to be an actual problem or is this mostly motivated
by the code reading?

> Signed-off-by: ChenGang <cg.chen@huawei.com>
> ---
>  mm/page_alloc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index d66bc8a..1baeeba 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7611,7 +7611,8 @@ static void setup_per_zone_lowmem_reserve(void)
>  
>  static void __setup_per_zone_wmarks(void)
>  {
> -	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
> +	unsigned long pages_min =
> +		(PAGE_ALIGN(min_free_kbytes * 1024) / 1024) >> (PAGE_SHIFT - 10);
>  	unsigned long lowmem_pages = 0;
>  	struct zone *zone;
>  	unsigned long flags;
> -- 
> 1.8.5.6
> 

-- 
Michal Hocko
SUSE Labs
