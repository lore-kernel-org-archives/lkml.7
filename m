Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D175C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E4122D6D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 09:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfICJqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 05:46:17 -0400
Received: from foss.arm.com ([217.140.110.172]:35032 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbfICJqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 05:46:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE6CC1570;
        Tue,  3 Sep 2019 02:46:15 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.42.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 185DD3F59C;
        Tue,  3 Sep 2019 02:46:08 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     mark.rutland@arm.com, mhocko@suse.com, ira.weiny@intel.com,
        david@redhat.com, cai@lca.pw, logang@deltatee.com,
        cpandya@codeaurora.org, arunks@codeaurora.org,
        dan.j.williams@intel.com, mgorman@techsingularity.net,
        osalvador@suse.de, ard.biesheuvel@arm.com, steve.capper@arm.com,
        broonie@kernel.org, valentin.schneider@arm.com,
        Robin.Murphy@arm.com, steven.price@arm.com, suzuki.poulose@arm.com
Subject: [PATCH V7 2/3] arm64/mm: Hold memory hotplug lock while walking for kernel page table dump
Date:   Tue,  3 Sep 2019 15:15:57 +0530
Message-Id: <1567503958-25831-3-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567503958-25831-1-git-send-email-anshuman.khandual@arm.com>
References: <1567503958-25831-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 page table dump code can race with concurrent modification of the
kernel page tables. When a leaf entries are modified concurrently, the dump
code may log stale or inconsistent information for a VA range, but this is
otherwise not harmful.

When intermediate levels of table are freed, the dump code will continue to
use memory which has been freed and potentially reallocated for another
purpose. In such cases, the dump code may dereference bogus addresses,
leading to a number of potential problems.

Intermediate levels of table may by freed during memory hot-remove,
which will be enabled by a subsequent patch. To avoid racing with
this, take the memory hotplug lock when walking the kernel page table.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/ptdump_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/ptdump_debugfs.c b/arch/arm64/mm/ptdump_debugfs.c
index 064163f25592..b5eebc8c4924 100644
--- a/arch/arm64/mm/ptdump_debugfs.c
+++ b/arch/arm64/mm/ptdump_debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/debugfs.h>
+#include <linux/memory_hotplug.h>
 #include <linux/seq_file.h>
 
 #include <asm/ptdump.h>
@@ -7,7 +8,10 @@
 static int ptdump_show(struct seq_file *m, void *v)
 {
 	struct ptdump_info *info = m->private;
+
+	get_online_mems();
 	ptdump_walk_pgd(m, info);
+	put_online_mems();
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(ptdump);
-- 
2.20.1

