Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDE5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AEB2175B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfCUUDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:03:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:5169 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbfCUUC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:02:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 13:02:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="scan'208";a="309246248"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2019 13:02:58 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 5/5] mm/migrate: Add page movement trace event
Date:   Thu, 21 Mar 2019 14:01:57 -0600
Message-Id: <20190321200157.29678-6-keith.busch@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190321200157.29678-1-keith.busch@intel.com>
References: <20190321200157.29678-1-keith.busch@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trace the source and destination node of a page migration to help debug
memory usage.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 include/trace/events/migrate.h | 26 ++++++++++++++++++++++++++
 mm/migrate.c                   |  1 +
 2 files changed, 27 insertions(+)

diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
index d25de0cc8714..3d4b7131e547 100644
--- a/include/trace/events/migrate.h
+++ b/include/trace/events/migrate.h
@@ -6,6 +6,7 @@
 #define _TRACE_MIGRATE_H
 
 #include <linux/tracepoint.h>
+#include <trace/events/mmflags.h>
 
 #define MIGRATE_MODE						\
 	EM( MIGRATE_ASYNC,	"MIGRATE_ASYNC")		\
@@ -71,6 +72,31 @@ TRACE_EVENT(mm_migrate_pages,
 		__print_symbolic(__entry->mode, MIGRATE_MODE),
 		__print_symbolic(__entry->reason, MIGRATE_REASON))
 );
+
+TRACE_EVENT(mm_migrate_move_page,
+
+	TP_PROTO(struct page *from, struct page *to, int status),
+
+	TP_ARGS(from, to, status),
+
+	TP_STRUCT__entry(
+		__field(struct page *, from)
+		__field(struct page *, to)
+		__field(int, status)
+	),
+
+	TP_fast_assign(
+		__entry->from = from;
+		__entry->to = to;
+		__entry->status = status;
+	),
+
+	TP_printk("node from=%d to=%d status=%d flags=%s refs=%d",
+		page_to_nid(__entry->from), page_to_nid(__entry->to),
+		__entry->status,
+		show_page_flags(__entry->from->flags & ((1UL << NR_PAGEFLAGS) - 1)),
+		page_ref_count(__entry->from))
+);
 #endif /* _TRACE_MIGRATE_H */
 
 /* This part must be outside protection */
diff --git a/mm/migrate.c b/mm/migrate.c
index 83fad87361bf..d97433da12c0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -997,6 +997,7 @@ static int move_to_new_page(struct page *newpage, struct page *page,
 			page->mapping = NULL;
 	}
 out:
+	trace_mm_migrate_move_page(page, newpage, rc);
 	return rc;
 }
 
-- 
2.14.4

