Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714E9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 530DB2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 15:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfKUPWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:22:17 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:55285 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfKUPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 10:22:16 -0500
X-Originating-IP: 153.3.140.100
Received: from localhost.localdomain.localdomain (unknown [153.3.140.100])
        (Authenticated sender: fly@kernel.page)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 14DCF1C000D;
        Thu, 21 Nov 2019 15:22:05 +0000 (UTC)
From:   Pengfei Li <fly@kernel.page>
To:     akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, mhocko@kernel.org, vbabka@suse.cz,
        cl@linux.com, iamjoonsoo.kim@lge.com, guro@fb.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Pengfei Li <fly@kernel.page>
Subject: [RFC v1 15/19] mm, mm_init: rename mminit_verify_zonelist
Date:   Thu, 21 Nov 2019 23:18:07 +0800
Message-Id: <20191121151811.49742-16-fly@kernel.page>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121151811.49742-1-fly@kernel.page>
References: <20191121151811.49742-1-fly@kernel.page>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup patch. Rename mminit_verify_zonelist to
mminit_verify_nodelist.

Signed-off-by: Pengfei Li <fly@kernel.page>
---
 mm/internal.h   | 4 ++--
 mm/mm_init.c    | 2 +-
 mm/page_alloc.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 90008f9fe7d9..73ba9b6376cd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -443,7 +443,7 @@ do { \
 } while (0)
 
 extern void mminit_verify_pageflags_layout(void);
-extern void mminit_verify_zonelist(void);
+extern void mminit_verify_nodelist(void);
 #else
 
 static inline void mminit_dprintk(enum mminit_level level,
@@ -455,7 +455,7 @@ static inline void mminit_verify_pageflags_layout(void)
 {
 }
 
-static inline void mminit_verify_zonelist(void)
+static inline void mminit_verify_nodelist(void)
 {
 }
 #endif /* CONFIG_DEBUG_MEMORY_INIT */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 448e3228a911..ac91374b0e95 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -59,7 +59,7 @@ void __init mminit_print_nodelist(int nid, int nl_type)
 }
 
 /* The zonelists are simply reported, validation is manual. */
-void __init mminit_verify_zonelist(void)
+void __init mminit_verify_nodelist(void)
 {
 	int nid;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3987b8e97158..5b735eb88c0d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5803,7 +5803,7 @@ build_all_zonelists_init(void)
 	for_each_possible_cpu(cpu)
 		setup_pageset(&per_cpu(boot_pageset, cpu), 0);
 
-	mminit_verify_zonelist();
+	mminit_verify_nodelist();
 	cpuset_init_current_mems_allowed();
 }
 
-- 
2.23.0

