Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC551C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9822B2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfC2OnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:43:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728858AbfC2OnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:43:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BE4523086207;
        Fri, 29 Mar 2019 14:43:00 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6DB9E5C226;
        Fri, 29 Mar 2019 14:42:56 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v4 2/2] drivers/base/memory.c: Clean up relicts in function parameters
Date:   Fri, 29 Mar 2019 22:42:50 +0800
Message-Id: <20190329144250.14315-2-bhe@redhat.com>
In-Reply-To: <20190329144250.14315-1-bhe@redhat.com>
References: <20190329144250.14315-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 29 Mar 2019 14:43:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The input parameter 'phys_index' of memory_block_action() is actually
the section number, but not the phys_index of memory_block. This is
a relict from the past when one memory block could only contain one
section. Rename it to start_section_nr.

And also in remove_memory_section(), the 'node_id' and 'phys_device'
are not used by anyone. Remove them.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
v3->v4:
  Remove useless parameters in remove_memory_section().

 drivers/base/memory.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index cb8347500ce2..d9ebb89816f7 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -231,13 +231,14 @@ static bool pages_correctly_probed(unsigned long start_pfn)
  * OK to have direct references to sparsemem variables in here.
  */
 static int
-memory_block_action(unsigned long phys_index, unsigned long action, int online_type)
+memory_block_action(unsigned long start_section_nr, unsigned long action,
+		    int online_type)
 {
 	unsigned long start_pfn;
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
 	int ret;
 
-	start_pfn = section_nr_to_pfn(phys_index);
+	start_pfn = section_nr_to_pfn(start_section_nr);
 
 	switch (action) {
 	case MEM_ONLINE:
@@ -251,7 +252,7 @@ memory_block_action(unsigned long phys_index, unsigned long action, int online_t
 		break;
 	default:
 		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
-		     "%ld\n", __func__, phys_index, action, action);
+		     "%ld\n", __func__, start_section_nr, action, action);
 		ret = -EINVAL;
 	}
 
@@ -738,8 +739,7 @@ unregister_memory(struct memory_block *memory)
 	device_unregister(&memory->dev);
 }
 
-static int remove_memory_section(unsigned long node_id,
-			       struct mem_section *section, int phys_device)
+static int remove_memory_section(struct mem_section *section)
 {
 	struct memory_block *mem;
 
@@ -771,7 +771,7 @@ int unregister_memory_section(struct mem_section *section)
 	if (!present_section(section))
 		return -EINVAL;
 
-	return remove_memory_section(0, section, 0);
+	return remove_memory_section(section);
 }
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
-- 
2.17.2

