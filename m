Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC15BC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C45520665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbfGHI2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:28:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:39384 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfGHI2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:28:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 01:28:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="170224078"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 08 Jul 2019 01:28:32 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, will@kernel.org,
        peterz@infradead.org, Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] mm: remove redundant assignment of entry
Date:   Mon,  8 Jul 2019 16:27:40 +0800
Message-Id: <20190708082740.21111-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ptent will not be changed after previous assignment of entry, it
is not necessary to do the assignment again.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 mm/memory.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index ddf20bd0c317..d108bb979a08 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1127,7 +1127,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (unlikely(details))
 			continue;
 
-		entry = pte_to_swp_entry(ptent);
 		if (!non_swap_entry(entry))
 			rss[MM_SWAPENTS]--;
 		else if (is_migration_entry(entry)) {
-- 
2.17.1

