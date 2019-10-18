Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D8ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DD520700
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 11:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571399316;
	bh=idJrDIQCpgFChGbt+UHdm83yNIaMd7O80kxnumL0Ejg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GJO5Z9NFjCjptgAL6oHygCKmZMmQ0by3tTfdPtX693qUwcsjEnoWeBhprE14WKuOo
	 V8ss1er1GZYGRC4RchTNAlnYMDaS4/EEJmos0L4ciPt51x3mowumD8qTzZL1T8shfR
	 R7rtCTuJ2jyM3mMQYOZIYpKfMGRS+panBsU3CFTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633592AbfJRLsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 07:48:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:58434 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729946AbfJRLse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 07:48:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F776B537;
        Fri, 18 Oct 2019 11:48:33 +0000 (UTC)
Date:   Fri, 18 Oct 2019 13:48:32 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/16] mm,hwpoison: cleanup unused PageHuge() check
Message-ID: <20191018114832.GK5017@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-2-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017142123.24245-2-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 16:21:08, Oscar Salvador wrote:
> From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> 
> Drop the PageHuge check since memory_failure forks into memory_failure_hugetlb()
> for hugetlb pages.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

s-o-b chain is reversed.

The code is a bit confusing. Doesn't this check aim for THP? AFAICS
PageTransHuge(hpage) will split the THP or fail so PageTransHuge
shouldn't be possible anymore, right? But why does hwpoison_user_mappings
still work with hpage then?

> ---
>  mm/memory-failure.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 05c8c6df25e6..2cbadb58c7df 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1345,10 +1345,7 @@ int memory_failure(unsigned long pfn, int flags)
>  	 * page_remove_rmap() in try_to_unmap_one(). So to determine page status
>  	 * correctly, we save a copy of the page flags at this time.
>  	 */
> -	if (PageHuge(p))
> -		page_flags = hpage->flags;
> -	else
> -		page_flags = p->flags;
> +	page_flags = p->flags;
>  
>  	/*
>  	 * unpoison always clear PG_hwpoison inside page lock
> -- 
> 2.12.3

-- 
Michal Hocko
SUSE Labs
