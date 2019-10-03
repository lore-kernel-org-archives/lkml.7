Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313CCC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA2A21D71
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 12:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfJCMBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 08:01:45 -0400
Received: from foss.arm.com ([217.140.110.172]:43092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbfJCMBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 08:01:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12729337;
        Thu,  3 Oct 2019 05:01:44 -0700 (PDT)
Received: from [10.162.40.180] (p8cg001049571a15.blr.arm.com [10.162.40.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C6203F534;
        Thu,  3 Oct 2019 05:01:40 -0700 (PDT)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in
 has_unmovable_pages()
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
References: <d3a88afd-63c6-1091-cf4c-75cd10b7f547@arm.com>
 <983E7EA4-A022-448C-B11D-8C10441A2E07@lca.pw>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <49fa7dea-00ac-155f-e7b7-eeca206556b5@arm.com>
Date:   Thu, 3 Oct 2019 17:32:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <983E7EA4-A022-448C-B11D-8C10441A2E07@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2019 05:20 PM, Qian Cai wrote:
> 
> 
>> On Oct 3, 2019, at 7:31 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>
>> Ohh, never meant that the 'Reserved' bit is anything special here but it
>> is a reason to make a page unmovable unlike many other flags.
> 
> But dump_page() is used everywhere, and it is better to reserve “reason” to indicate something more important rather than duplicating the page flags.
> 
> Especially, it is trivial enough right now for developers look in the page flags dumping from has_unmovable_pages(), and figure out the exact branching in the code.
> 

Will something like this be better ? hugepage_migration_supported() has got
uncertainty depending on platform and huge page size.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 15c2050c629b..8dbc86696515 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8175,7 +8175,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
        unsigned long found;
        unsigned long iter = 0;
        unsigned long pfn = page_to_pfn(page);
-       const char *reason = "unmovable page";
+       const char *reason;

        /*
         * TODO we could make this much more efficient by not checking every
@@ -8194,7 +8194,7 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
                if (is_migrate_cma(migratetype))
                        return false;

-               reason = "CMA page";
+               reason = "Unmovable CMA page";
                goto unmovable;
        }

@@ -8206,8 +8206,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,

                page = pfn_to_page(check);

-               if (PageReserved(page))
+               if (PageReserved(page)) {
+                       reason = "Unmovable reserved page";
                        goto unmovable;
+               }

                /*
                 * If the zone is movable and we have ruled out all reserved
@@ -8226,8 +8228,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
                        struct page *head = compound_head(page);
                        unsigned int skip_pages;

-                       if (!hugepage_migration_supported(page_hstate(head)))
+                       if (!hugepage_migration_supported(page_hstate(head))) {
+                               reason = "Unmovable HugeTLB page";
                                goto unmovable;
+                       }

                        skip_pages = compound_nr(head) - (page - head);
                        iter += skip_pages - 1;
@@ -8271,8 +8275,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
                 * is set to both of a memory hole page and a _used_ kernel
                 * page at boot.
                 */
-               if (found > count)
+               if (found > count) {
+                       reason = "Unmovable non-LRU page";
                        goto unmovable;
+               }
        }
        return false;
 unmovable:
