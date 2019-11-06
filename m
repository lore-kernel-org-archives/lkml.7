Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F6DC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F821848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbfKFMjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:39:21 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:47514 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfKFMjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:39:21 -0500
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iSKah-0001UA-TD; Wed, 06 Nov 2019 12:39:16 +0000
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.3)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iSKah-0001wq-DJ; Wed, 06 Nov 2019 12:39:15 +0000
From:   "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory_hotplug: move definitions of {set,clear}_zone_contiguous
Date:   Wed,  6 Nov 2019 12:39:11 +0000
Message-Id: <20191106123911.7435-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.24.0.rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The {set,clear}_zone_contiguous are built whatever the
configuraiton so move the definitions outside the current
ifdef to avoid the following compiler warnings:

mm/page_alloc.c:1550:6: warning: no previous prototype for âset_zone_contiguousâ [-Wmissing-prototypes]
mm/page_alloc.c:1571:6: warning: no previous prototype for âclear_zone_contiguousâ [-Wmissing-prototypes]

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
---
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memory_hotplug.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index f46ea71b4ffd..6a6456040802 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -229,9 +229,6 @@ void put_online_mems(void);
 void mem_hotplug_begin(void);
 void mem_hotplug_done(void);
 
-extern void set_zone_contiguous(struct zone *zone);
-extern void clear_zone_contiguous(struct zone *zone);
-
 #else /* ! CONFIG_MEMORY_HOTPLUG */
 #define pfn_to_online_page(pfn)			\
 ({						\
@@ -339,6 +336,9 @@ static inline int remove_memory(int nid, u64 start, u64 size)
 static inline void __remove_memory(int nid, u64 start, u64 size) {}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
+extern void set_zone_contiguous(struct zone *zone);
+extern void clear_zone_contiguous(struct zone *zone);
+
 extern void __ref free_area_init_core_hotplug(int nid);
 extern int __add_memory(int nid, u64 start, u64 size);
 extern int add_memory(int nid, u64 start, u64 size);
-- 
2.24.0.rc1

