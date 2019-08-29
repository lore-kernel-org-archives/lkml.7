Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13BEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0920828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 07:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567063636;
	bh=Mh/z4FxetejOmjjNyzrxk4mRPaZviAQd9NZxe/r6IAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k62k1HjDzrCB1LDcYnwof/YRD72j3whtiQP0A/6SDWdIvweoij60k4nBTcbyWSNoK
	 G47Y2yccgBl9QTQZakWtcyPlMCvHXSyNoxhuetLWG60gATEntYnTLKvZGfgejRyXIs
	 lCtT1L9EA0gNO96/8D8a7TNKlE79hUAeMY383vyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfH2H1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 03:27:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:39476 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbfH2H1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 03:27:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 405D2AFCB;
        Thu, 29 Aug 2019 07:27:14 +0000 (UTC)
Date:   Thu, 29 Aug 2019 09:27:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Baoquan He <bhe@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove NULL check in clear_hwpoisoned_pages()
Message-ID: <20190829072712.GS28313@dhcp22.suse.cz>
References: <20190829035151.20975-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829035151.20975-1-alastair@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 29-08-19 13:51:50, Alastair D'Silva wrote:
> There is no possibility for memmap to be NULL in the current
> codebase.
> 
> This check was added in commit 95a4774d055c ("memory-hotplug:
> update mce_bad_pages when removing the memory")
> where memmap was originally inited to NULL, and only conditionally
> given a value.
> 
> The code that could have passed a NULL has been removed, so there

removed by  ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> is no longer a possibility that memmap can be NULL.

I haven't studied whether section_mem_map could have been NULL before
then but the important part is that NULL is not possible anymore as
pfn_to_page shouldn't ever return NULL.
 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/sparse.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 78979c142b7d..9f7e3682cdcb 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -754,9 +754,6 @@ static void clear_hwpoisoned_pages(struct page *memmap, int nr_pages)
>  {
>  	int i;
>  
> -	if (!memmap)
> -		return;
> -
>  	/*
>  	 * A further optimization is to have per section refcounted
>  	 * num_poisoned_pages.  But that would need more space per memmap, so
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
