Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF22C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED88218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551345718;
	bh=QjAB/Z/ufkhaxSELAqlor+8zUpr73uzeNhJiNCfbfhM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UHvcZz9yTY0TutOl819lQ82G7qLJuAHoWDcMNqSgxHbZFC81xZJgMQFWyE17N8BEj
	 c7VI855Sg6+sIVR91/VJ7USYzHwtp5+OumTcO/NaNZb6csHKPrl/3rCLAYD6kd5sF8
	 TwAXMbxId/dWS6uAJfxaSCvZ1KpyOzNJA1+/tyPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732152AbfB1JV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 04:21:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:52888 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfB1JV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 04:21:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2EA8BAC5A;
        Thu, 28 Feb 2019 09:21:55 +0000 (UTC)
Date:   Thu, 28 Feb 2019 10:21:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
        mike.kravetz@oracle.com
Subject: Re: [RFC PATCH] mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
Message-ID: <20190228092154.GV10588@dhcp22.suse.cz>
References: <20190221094212.16906-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221094212.16906-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-02-19 10:42:12, Oscar Salvador wrote:
[...]
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index d5f7afda67db..04f6695b648c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1337,8 +1337,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
>  		if (!PageHuge(page))
>  			continue;
>  		head = compound_head(page);
> -		if (hugepage_migration_supported(page_hstate(head)) &&
> -		    page_huge_active(head))
> +		if (page_huge_active(head))
>  			return pfn;
>  		skip = (1 << compound_order(head)) - (page - head);
>  		pfn += skip - 1;

Is this part correct? Say we have a gigantic page which is migrateable.
Now scan_movable_pages would skip it and we will not migrate it, no?

> @@ -1378,10 +1377,6 @@ do_migrate_range(unsigned long start_pfn, unsigned long end_pfn)
>  
>  		if (PageHuge(page)) {
>  			struct page *head = compound_head(page);
> -			if (compound_order(head) > PFN_SECTION_SHIFT) {
> -				ret = -EBUSY;
> -				break;
> -			}
>  			pfn = page_to_pfn(head) + (1<<compound_order(head)) - 1;
>  			isolate_huge_page(head, &source);
>  			continue;

I think it would be much easier to have only this check removed in this
patch. Because it is obviously bogus and wrong as well. The other check
might be considered in a separate patch.
-- 
Michal Hocko
SUSE Labs
