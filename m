Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548E4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDF92133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 03:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDKD6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 23:58:12 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:55887 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbfDKD6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 23:58:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TP0I5rB_1554955031;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TP0I5rB_1554955031)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Apr 2019 11:57:24 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 9/9] mm: numa: add page promotion counter
Date:   Thu, 11 Apr 2019 11:56:59 +0800
Message-Id: <1554955019-29472-10-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add counter for page promotion for NUMA balancing.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 include/linux/vm_event_item.h | 1 +
 mm/huge_memory.c              | 4 ++++
 mm/memory.c                   | 4 ++++
 mm/vmstat.c                   | 1 +
 4 files changed, 10 insertions(+)

diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 499a3aa..9f52a62 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -51,6 +51,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
+		NUMA_PAGE_PROMOTE,
 #endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 0b18ac45..ca9d688 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1609,6 +1609,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
 	migrated = migrate_misplaced_transhuge_page(vma->vm_mm, vma,
 				vmf->pmd, pmd, vmf->address, page, target_nid);
 	if (migrated) {
+		if (!node_state(page_nid, N_CPU_MEM) &&
+		    node_state(target_nid, N_CPU_MEM))
+			count_vm_numa_events(NUMA_PAGE_PROMOTE, HPAGE_PMD_NR);
+
 		flags |= TNF_MIGRATED;
 		page_nid = target_nid;
 	} else
diff --git a/mm/memory.c b/mm/memory.c
index 01c1ead..7b1218b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3704,6 +3704,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	/* Migrate to the requested node */
 	migrated = migrate_misplaced_page(page, vma, target_nid);
 	if (migrated) {
+		if (!node_state(page_nid, N_CPU_MEM) &&
+		    node_state(target_nid, N_CPU_MEM))
+			count_vm_numa_event(NUMA_PAGE_PROMOTE);
+
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
 	} else
diff --git a/mm/vmstat.c b/mm/vmstat.c
index d1e4993..fd194e3 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1220,6 +1220,7 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 	"numa_hint_faults",
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
+	"numa_pages_promoted",
 #endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
-- 
1.8.3.1

