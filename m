Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E3EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D00206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfGOLCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:02:24 -0400
Received: from 8bytes.org ([81.169.241.247]:35386 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729844AbfGOLCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:02:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 948EB41D; Mon, 15 Jul 2019 13:02:22 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
Date:   Mon, 15 Jul 2019 13:02:12 +0200
Message-Id: <20190715110212.18617-4-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190715110212.18617-1-joro@8bytes.org>
References: <20190715110212.18617-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

On x86-32 with PTI enabled, parts of the kernel page-tables
are not shared between processes. This can cause mappings in
the vmalloc/ioremap area to persist in some page-tables
after the regions is unmapped and released.

When the region is re-used the processes with the old
mappings do not fault in the new mappings but still access
the old ones.

This causes undefined behavior, in reality often data
corruption, kernel oopses and panics and even spontaneous
reboots.

Fix this problem by activly syncing unmaps in the
vmalloc/ioremap area to all page-tables in the system.

References: https://bugzilla.suse.com/show_bug.cgi?id=1118689
Fixes: 7757d607c6b3 ('x86/pti: Allow CONFIG_PAGE_TABLE_ISOLATION for x86_32')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 mm/vmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4fa8d84599b0..322b11a374fd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -132,6 +132,8 @@ static void vunmap_page_range(unsigned long addr, unsigned long end)
 			continue;
 		vunmap_p4d_range(pgd, addr, next);
 	} while (pgd++, addr = next, addr != end);
+
+	vmalloc_sync_all();
 }
 
 static int vmap_pte_range(pmd_t *pmd, unsigned long addr,
-- 
2.17.1

