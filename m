Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF54C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B10520673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411292AbfIYC6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:58:00 -0400
Received: from foss.arm.com ([217.140.110.172]:40348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbfIYC6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:58:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9CBA337;
        Tue, 24 Sep 2019 19:57:58 -0700 (PDT)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FA8D3F694;
        Tue, 24 Sep 2019 19:57:55 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH V2] mm/hotplug: Reorder memblock_[free|remove]() calls in try_remove_memory()
Date:   Wed, 25 Sep 2019 08:27:53 +0530
Message-Id: <1569380273-7708-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently during memory hot add procedure, memory gets into memblock before
calling arch_add_memory() which creates it's linear mapping.

add_memory_resource() {
	..................
	memblock_add_node()
	..................
	arch_add_memory()
	..................
}

But during memory hot remove procedure, removal from memblock happens first
before it's linear mapping gets teared down with arch_remove_memory() which
is not consistent. Resource removal should happen in reverse order as they
were added. However this does not pose any problem for now, unless there is
an assumption regarding linear mapping. One example was a subtle failure on
arm64 platform [1]. Though this has now found a different solution.

try_remove_memory() {
	..................
	memblock_free()
	memblock_remove()
	..................
	arch_remove_memory()
	..................
}

This changes the sequence of resource removal including memblock and linear
mapping tear down during memory hot remove which will now be the reverse
order in which they were added during memory hot add. The changed removal
order looks like the following.

try_remove_memory() {
	..................
	arch_remove_memory()
	..................
	memblock_free()
	memblock_remove()
	..................
}

[1] https://patchwork.kernel.org/patch/11127623/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V2:

- Changed the commit message as per Michal and David 

Changed in V1: https://patchwork.kernel.org/patch/11146361/

Original patch https://lkml.org/lkml/2019/9/3/327

Memory hot remove now works on arm64 without this because a recent commit
60bb462fc7ad ("drivers/base/node.c: simplify unregister_memory_block_under_nodes()").

David mentioned that re-ordering should still make sense for consistency
purpose (removing stuff in the reverse order they were added). This patch
is now detached from arm64 hot-remove series.

https://lkml.org/lkml/2019/9/3/326

 mm/memory_hotplug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 49f7bf91c25a..4f7d426a84d0 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1763,13 +1763,13 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
-	memblock_free(start, size);
-	memblock_remove(start, size);
 
 	/* remove memory block devices before removing memory */
 	remove_memory_block_devices(start, size);
 
 	arch_remove_memory(nid, start, size, NULL);
+	memblock_free(start, size);
+	memblock_remove(start, size);
 	__release_memory_resource(start, size);
 
 	try_offline_node(nid);
-- 
2.20.1

