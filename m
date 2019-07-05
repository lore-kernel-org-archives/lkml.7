Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BC4C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C08D7218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562317877;
	bh=tDa5/FJHftDMGxN2+VF57QLt4BM9Tjzy5JuFXiGmiSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZRmrEIkg5epIVDmH0P2jlDW15VovFmWgC7gc7kNuILD/keDcJZ/Gywg3+DzWABRkO
	 7bztJDG1WLsq1a7PWTQUL3lU36yNHt5KO8VWCYnqloiyb+TnOE8meN8ar39wFnDH/b
	 1mVc/W3EFrrUXFSXMTFEB1xn5BxIRosPjTqZmayI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfGEJLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:11:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:52086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727565AbfGEJLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:11:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56408AC68;
        Fri,  5 Jul 2019 09:11:15 +0000 (UTC)
Date:   Fri, 5 Jul 2019 11:11:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Oscar Salvador <osalvador@suse.de>,
        Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/isolate: Drop pre-validating migrate type in
 undo_isolate_page_range()
Message-ID: <20190705091114.GG8231@dhcp22.suse.cz>
References: <1562307161-30554-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562307161-30554-1-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 05-07-19 11:42:41, Anshuman Khandual wrote:
> unset_migratetype_isolate() already validates under zone lock that a given
> page has already been isolated as MIGRATE_ISOLATE. There is no need for
> another check before. Hence just drop this redundant validation.

unset_migratetype_isolate take zone lock and it is always preferable to
skip not take this lock if we know it would be pointless. Besides that
undo_isolate_page_range is a slow path so a nano optimizing it is not
worth it.

> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Is there any particular reason to do this migratetype pre-check without zone
> lock before calling unsert_migrate_isolate() ? If not this should be removed.
> 
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index e3638a5bafff..f529d250c8a5 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -243,7 +243,7 @@ int undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
>  	     pfn < end_pfn;
>  	     pfn += pageblock_nr_pages) {
>  		page = __first_valid_page(pfn, pageblock_nr_pages);
> -		if (!page || !is_migrate_isolate_page(page))
> +		if (!page)
>  			continue;
>  		unset_migratetype_isolate(page, migratetype);
>  	}
> -- 
> 2.20.1

-- 
Michal Hocko
SUSE Labs
