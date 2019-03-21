Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29798C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA03D218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 04:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfCUENX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 00:13:23 -0400
Received: from foss.arm.com ([217.140.101.70]:50306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfCUENX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 00:13:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4B2B374;
        Wed, 20 Mar 2019 21:13:22 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1B1FD3F71A;
        Wed, 20 Mar 2019 21:13:19 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     mike.kravetz@oracle.com, zi.yan@cs.rutgers.edu, osalvador@suse.de,
        mhocko@suse.com, akpm@linux-foundation.org
Subject: [PATCH] mm/isolation: Remove redundant pfn_valid_within() in __first_valid_page()
Date:   Thu, 21 Mar 2019 09:43:15 +0530
Message-Id: <1553141595-26907-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pfn_valid_within() calls pfn_valid() when CONFIG_HOLES_IN_ZONE making it
redundant for both definitions (w/wo CONFIG_MEMORY_HOTPLUG) of the helper
pfn_to_online_page() which either calls pfn_valid() or pfn_valid_within().
pfn_valid_within() being 1 when !CONFIG_HOLES_IN_ZONE is irrelevant either
way. This does not change functionality.

Fixes: 2ce13640b3f4 ("mm: __first_valid_page skip over offline pages")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 mm/page_isolation.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index ce323e56b34d..d9b02bb13d60 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -150,8 +150,6 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
 
-		if (!pfn_valid_within(pfn + i))
-			continue;
 		page = pfn_to_online_page(pfn + i);
 		if (!page)
 			continue;
-- 
2.20.1

