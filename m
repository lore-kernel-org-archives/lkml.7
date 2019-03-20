Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4192183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfCTP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:27:27 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:33551 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfCTP1Z (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Wed, 20 Mar 2019 11:27:25 -0400
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Wed, 20 Mar 2019 16:27:24 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.202])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Wed, 20 Mar 2019 15:27:04 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH resend 2/2] mm,memory_hotplug: Drop redundant hugepage_migration_supported check
Date:   Wed, 20 Mar 2019 16:26:58 +0100
Message-Id: <20190320152658.10855-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190320152658.10855-1-osalvador@suse.de>
References: <20190320152658.10855-1-osalvador@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

has_unmovable_pages() does alreay check whether the hugetlb page supports
migration, so all non-migrateable hugetlb pages should have been caught there.
Let us drop the check from scan_movable_pages() as is redundant.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 02283732544e..37a83a83e8f8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1340,8 +1340,7 @@ static unsigned long scan_movable_pages(unsigned long start, unsigned long end)
 		if (!PageHuge(page))
 			continue;
 		head = compound_head(page);
-		if (hugepage_migration_supported(page_hstate(head)) &&
-		    page_huge_active(head))
+		if (page_huge_active(head))
 			return pfn;
 		skip = (1 << compound_order(head)) - (page - head);
 		pfn += skip - 1;
-- 
2.13.7

