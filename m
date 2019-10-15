Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA16ECE595
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE5A205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 12:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571141576;
	bh=wtg0eEchOXgSjaTH88QuPWmVcQOuSrobqa/ieMPeiGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XcV+31ejrY/1Qz8W7r4Zk5QgU+AqQfHTC/Yh2h9DRpjOuDsoaKbLeRFgvjioF6bBJ
	 DD2Scs/77KHyKKbn1oZ/Zr2+h/NvBzbq1qo0hf3LJrS/O5Axj5K1XG0ItNR1lJRrUI
	 pjuwsdhpYImITzUh1qyo+t3qdoxSal3iLVHu5PI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730387AbfJOMMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 08:12:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:32812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726139AbfJOMMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:12:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F8E2B392;
        Tue, 15 Oct 2019 12:12:53 +0000 (UTC)
Date:   Tue, 15 Oct 2019 14:12:53 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1] hugetlbfs: don't access uninitialized memmaps in
 pfn_range_valid_gigantic()
Message-ID: <20191015121253.GH317@dhcp22.suse.cz>
References: <20191015120717.4858-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015120717.4858-1-david@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-10-19 14:07:17, David Hildenbrand wrote:
> Uninitialized memmaps contain garbage and in the worst case trigger
> kernel BUGs, especially with CONFIG_PAGE_POISONING. They should not get
> touched.
> 
> Let's make sure that we only consider online memory (managed by the
> buddy) that has initialized memmaps. ZONE_DEVICE is not applicable.
> 
> page_zone() will call page_to_nid(), which will trigger
> VM_BUG_ON_PGFLAGS(PagePoisoned(page), page) with CONFIG_PAGE_POISONING
> and CONFIG_DEBUG_VM_PGFLAGS when called on uninitialized memmaps. This
> can be the case when an offline memory block (e.g., never onlined) is
> spanned by a zone.
> 
> Note: As explained by Michal in [1], alloc_contig_range() will verify
> the range. So it boils down to the wrong access in this function.
> 
> [1] http://lkml.kernel.org/r/20180423000943.GO17484@dhcp22.suse.cz
> 
> Reported-by: Michal Hocko <mhocko@kernel.org>
> Fixes: f1dd2cd13c4b ("mm, memory_hotplug: do not associate hotadded memory to zones until online") # visible after d0dc12e86b319
> Cc: stable@vger.kernel.org # v4.13+
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/hugetlb.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ef37c85423a5..b45a95363a84 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1084,11 +1084,10 @@ static bool pfn_range_valid_gigantic(struct zone *z,
>  	struct page *page;
>  
>  	for (i = start_pfn; i < end_pfn; i++) {
> -		if (!pfn_valid(i))
> +		page = pfn_to_online_page(i);
> +		if (!page)
>  			return false;
>  
> -		page = pfn_to_page(i);
> -
>  		if (page_zone(page) != z)
>  			return false;
>  
> -- 
> 2.21.0

-- 
Michal Hocko
SUSE Labs
