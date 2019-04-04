Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFC4C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503EA2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 02:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sent.com header.i=@sent.com header.b="fdG7ZhJt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndTS5P7P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbfDDCLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 22:11:48 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:51809 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfDDCJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 22:09:45 -0400
X-Greylist: delayed 509 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 22:09:44 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BE5D922B6A;
        Wed,  3 Apr 2019 22:01:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 03 Apr 2019 22:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:in-reply-to:references:reply-to
        :mime-version:content-transfer-encoding; s=fm3; bh=3T42stGTEO5ya
        BeosRcIHJtycIIQs381815PCz0cSnU=; b=fdG7ZhJtpi82VTO5NK8xh0TlTw62C
        8chyJiNLcSRPLCPCzhQNGJA6pRCfAlbglgqgay1XkS7iR8kiNcXOMUBKUSsWmue5
        leWLYppitvB7QhkUcBz/BEGJnbQkl2+ae5++jORUQZHoRQ/EfFnfrIHb6zaVyGpy
        +odnxxnOrMYnjyBER2Chm0ZliVIQYufit4BkU0ZTZxWYy++QR3uR6tKLecYqpGXE
        hY7Tg13vEWZ+uOH4cGGumZAZ0EBPIz+LhMMJEK0quK7aQF1Ap0eq34R3q1bj760H
        2G9gkIruWkuWmGtX6+CjKXA100hig8M5kexoPWP9WBmuwmJoh4BYLTC/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:reply-to:subject
        :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=3T42stGTEO5yaBeosRcIHJtycIIQs381815PCz0cSnU=; b=ndTS5P7P
        Qxd+Ar6roAAVVpGH9xCeYy7Geo+mo94CLKb/oUbWs0cCIEiyGxakuKff58A66qvj
        kgdDO62ecGWtQYlO1OjXrqAjMjH+05dLReIYoEcUqF9KEnVytE2DeZnl/rb/Po0E
        JMA1ZkWN9x4sTXtvU7BGC0Mr4FCyczgPnHoRomZuvnWkmAXlrta5j3Fybc45HQ6m
        BtBNbaFeQ2/ENDSfZrwMxeFLzvi15B81siMXbk6Pf3HsKcAVIDW9ujxUZEZLSUim
        K0aV/eavecjeWXfz67rnUexfMsvqvDJQA6T/TT/oh7/GFQr70ZyOhIsengZEh0qk
        qj3WXk5xsgjW7g==
X-ME-Sender: <xms:k2WlXEYsKwVboEkNg4yPp-hFC6sTIZaL4yFO1rhbgTEYXsBg_L37UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrtdeggdehudculddtuddrgedutddrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhhrggfgsedtkeertdertddt
    necuhfhrohhmpegkihcujggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucfkph
    epvdduiedrvddvkedrudduvddrvddvnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdr
    higrnhesshgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgepvddu
X-ME-Proxy: <xmx:k2WlXM6gnvsxDK2bGl2lCLqIDJYQQdk605pnXCfvAiJGjwlWE4WnvQ>
    <xmx:k2WlXBl_sSb8wd1O4FkG8JxSfe5tDKvofaEh_8ItYwlJQEE23mgBwQ>
    <xmx:k2WlXEHhRpLRryFESMkImObinS6l7x5lgX04b9bDI0gxLVleOvWOkg>
    <xmx:k2WlXHu4Cu86GMcXqOAkMY4hH1c8DAfa0sIhaEnnIHFSZvnHt5K7xg>
Received: from nvrsysarch5.nvidia.com (thunderhill.nvidia.com [216.228.112.22])
        by mail.messagingengine.com (Postfix) with ESMTPA id C218010310;
        Wed,  3 Apr 2019 22:01:53 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        John Hubbard <jhubbard@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        Nitin Gupta <nigupta@nvidia.com>,
        Javier Cabezas <jcabezas@nvidia.com>,
        David Nellans <dnellans@nvidia.com>, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH 24/25] memory manage: limit migration batch size.
Date:   Wed,  3 Apr 2019 19:00:45 -0700
Message-Id: <20190404020046.32741-25-zi.yan@sent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404020046.32741-1-zi.yan@sent.com>
References: <20190404020046.32741-1-zi.yan@sent.com>
Reply-To: ziy@nvidia.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Make migration batch size adjustable to avoid excessive migration
overheads when a lot of pages are under migration.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 kernel/sysctl.c    |  8 ++++++++
 mm/memory_manage.c | 60 ++++++++++++++++++++++++++++++++++++------------------
 2 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index b8712eb..b92e2da9 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -105,6 +105,7 @@ extern int accel_page_copy;
 extern unsigned int limit_mt_num;
 extern int use_all_dma_chans;
 extern int limit_dma_chans;
+extern int migration_batch_size;
 
 /* External variables not in a header file. */
 extern int suid_dumpable;
@@ -1470,6 +1471,13 @@ static struct ctl_table vm_table[] = {
 		.extra1		= &zero,
 	 },
 	 {
+		.procname	= "migration_batch_size",
+		.data		= &migration_batch_size,
+		.maxlen		= sizeof(migration_batch_size),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	 },
+	 {
 		.procname	= "hugetlb_shm_group",
 		.data		= &sysctl_hugetlb_shm_group,
 		.maxlen		= sizeof(gid_t),
diff --git a/mm/memory_manage.c b/mm/memory_manage.c
index d63ad25..8b76fcf 100644
--- a/mm/memory_manage.c
+++ b/mm/memory_manage.c
@@ -16,6 +16,8 @@
 
 #include "internal.h"
 
+int migration_batch_size = 16;
+
 enum isolate_action {
 	ISOLATE_COLD_PAGES = 1,
 	ISOLATE_HOT_PAGES,
@@ -137,35 +139,49 @@ static unsigned long isolate_pages_from_lru_list(pg_data_t *pgdat,
 }
 
 static int migrate_to_node(struct list_head *page_list, int nid,
-		enum migrate_mode mode)
+		enum migrate_mode mode, int batch_size)
 {
 	bool migrate_concur = mode & MIGRATE_CONCUR;
+	bool unlimited_batch_size = (batch_size <=0 || !migrate_concur);
 	int num = 0;
-	int from_nid;
+	int from_nid = -1;
 	int err;
 
 	if (list_empty(page_list))
 		return num;
 
-	from_nid = page_to_nid(list_first_entry(page_list, struct page, lru));
+	while (!list_empty(page_list)) {
+		LIST_HEAD(batch_page_list);
+		int i;
 
-	if (migrate_concur)
-		err = migrate_pages_concur(page_list, alloc_new_node_page,
-			NULL, nid, mode, MR_SYSCALL);
-	else
-		err = migrate_pages(page_list, alloc_new_node_page,
-			NULL, nid, mode, MR_SYSCALL);
+		/* it should move all pages to batch_page_list if !migrate_concur */
+		for (i = 0; i < batch_size || unlimited_batch_size; i++) {
+			struct page *item = list_first_entry_or_null(page_list, struct page, lru);
+			if (!item)
+				break;
+			list_move(&item->lru, &batch_page_list);
+		}
 
-	if (err) {
-		struct page *page;
+		from_nid = page_to_nid(list_first_entry(&batch_page_list, struct page, lru));
 
-		list_for_each_entry(page, page_list, lru)
-			num += hpage_nr_pages(page);
-		pr_debug("%d pages failed to migrate from %d to %d\n",
-			num, from_nid, nid);
+		if (migrate_concur)
+			err = migrate_pages_concur(&batch_page_list, alloc_new_node_page,
+				NULL, nid, mode, MR_SYSCALL);
+		else
+			err = migrate_pages(&batch_page_list, alloc_new_node_page,
+				NULL, nid, mode, MR_SYSCALL);
 
-		putback_movable_pages(page_list);
+		if (err) {
+			struct page *page;
+
+			list_for_each_entry(page, &batch_page_list, lru)
+				num += hpage_nr_pages(page);
+
+			putback_movable_pages(&batch_page_list);
+		}
 	}
+	pr_debug("%d pages failed to migrate from %d to %d\n",
+		num, from_nid, nid);
 	return num;
 }
 
@@ -325,10 +341,12 @@ static int do_mm_manage(struct task_struct *p, struct mm_struct *mm,
 		/* Migrate pages to slow node */
 		/* No multi-threaded migration for base pages */
 		nr_isolated_fast_base_pages -=
-			migrate_to_node(&fast_base_page_list, slow_nid, mode & ~MIGRATE_MT);
+			migrate_to_node(&fast_base_page_list, slow_nid,
+				mode & ~MIGRATE_MT, migration_batch_size);
 
 		nr_isolated_fast_huge_pages -=
-			migrate_to_node(&fast_huge_page_list, slow_nid, mode);
+			migrate_to_node(&fast_huge_page_list, slow_nid, mode,
+				migration_batch_size);
 	}
 
 	if (nr_isolated_fast_base_pages != ULONG_MAX &&
@@ -342,10 +360,12 @@ static int do_mm_manage(struct task_struct *p, struct mm_struct *mm,
 	/* Migrate pages to fast node */
 	/* No multi-threaded migration for base pages */
 	nr_isolated_slow_base_pages -=
-		migrate_to_node(&slow_base_page_list, fast_nid, mode & ~MIGRATE_MT);
+		migrate_to_node(&slow_base_page_list, fast_nid, mode & ~MIGRATE_MT,
+				migration_batch_size);
 
 	nr_isolated_slow_huge_pages -=
-		migrate_to_node(&slow_huge_page_list, fast_nid, mode);
+		migrate_to_node(&slow_huge_page_list, fast_nid, mode,
+				migration_batch_size);
 
 	return err;
 }
-- 
2.7.4

