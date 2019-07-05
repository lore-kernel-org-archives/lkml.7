Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7953C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5903218BC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 07:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfGEH7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 03:59:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:36382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727506AbfGEH7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 03:59:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1F7BACD4;
        Fri,  5 Jul 2019 07:59:06 +0000 (UTC)
Date:   Fri, 5 Jul 2019 09:59:04 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>,
        Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/isolate: Drop pre-validating migrate type in
 undo_isolate_page_range()
Message-ID: <20190705075857.GA28725@linux>
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

On Fri, Jul 05, 2019 at 11:42:41AM +0530, Anshuman Khandual wrote:
> unset_migratetype_isolate() already validates under zone lock that a given
> page has already been isolated as MIGRATE_ISOLATE. There is no need for
> another check before. Hence just drop this redundant validation.
> 
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

I have seen this kinda behavior-checks all over the kernel.
I guess that one of the main goals is to avoid lock contention, so we check
if the page has the right migratetype, and then we check it again under the lock
to see whether that has changed.

e.g: simultaneous calls to undo_isolate_page_range

But I am not sure if the motivation behind was something else, as the changelog
that added this code was quite modest.

Anyway, how did you come across with this?
Do things get speed up without this check? Or what was the motivation to remove it?

thanks


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
> 

-- 
Oscar Salvador
SUSE L3
