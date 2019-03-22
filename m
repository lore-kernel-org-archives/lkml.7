Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CB73206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553246631;
	bh=EN8QrHx9pid8ljfIFXbcbPs8EFLTK78c7Mq3w4t+Jio=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u9qbODQX/fYlwzRJQtHKSFJVcwbOwiUx+YCGHG2uACFM6Tyvp3T0l9gciV3ICd9/X
	 vJ7Dd6eNf9GpHnuWOs2+xrX5AbFhJAONK41bfehIAwV3M5VEjFinwqXDe0jyOlirq2
	 viOTb+gCog6BguxEntsbPeKiEt60oH9g0VDx2SYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCVJXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:23:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCVJXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:23:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 42A9CAFBE;
        Fri, 22 Mar 2019 09:23:48 +0000 (UTC)
Date:   Fri, 22 Mar 2019 10:23:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mike.kravetz@oracle.com, zi.yan@cs.rutgers.edu, osalvador@suse.de,
        akpm@linux-foundation.org
Subject: Re: [PATCH] mm/isolation: Remove redundant pfn_valid_within() in
 __first_valid_page()
Message-ID: <20190322092347.GA32508@dhcp22.suse.cz>
References: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-03-19 09:43:15, Anshuman Khandual wrote:
> pfn_valid_within() calls pfn_valid() when CONFIG_HOLES_IN_ZONE making it
> redundant for both definitions (w/wo CONFIG_MEMORY_HOTPLUG) of the helper
> pfn_to_online_page() which either calls pfn_valid() or pfn_valid_within().
> pfn_valid_within() being 1 when !CONFIG_HOLES_IN_ZONE is irrelevant either
> way. This does not change functionality.
> 
> Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Forgot about
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_isolation.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index ce323e56b34d..d9b02bb13d60 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -150,8 +150,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
>  	for (i = 0; i < nr_pages; i++) {
>  		struct page *page;
>  
> -		if (!pfn_valid_within(pfn + i))
> -			continue;
>  		page = pfn_to_online_page(pfn + i);
>  		if (!page)
>  			continue;
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
