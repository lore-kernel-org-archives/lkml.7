Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA67C31E4A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A4D20896
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 23:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfFMXaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 19:30:19 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38197 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725789AbfFMXaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 19:30:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TU6DYEz_1560468591;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TU6DYEz_1560468591)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 14 Jun 2019 07:30:01 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, mgorman@techsingularity.net, riel@surriel.com,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, keith.busch@intel.com,
        dan.j.williams@intel.com, fengguang.wu@intel.com, fan.du@intel.com,
        ying.huang@intel.com, ziy@nvidia.com
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 9/9] mm: numa: add page promotion counter
Date:   Fri, 14 Jun 2019 07:29:37 +0800
Message-Id: <1560468577-101178-10-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1560468577-101178-1-git-send-email-yang.shi@linux.alibaba.com>
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
index 9f8bce9..01cfe29 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1638,6 +1638,10 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
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
index 96f1d47..e554cd5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3770,6 +3770,10 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
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
index eee29a9..0140736 100644
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

