Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007C7C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C754621883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 20:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RAFKiSFF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfICUJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 16:09:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39014 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICUJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:09:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id s12so4571399pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 13:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eVGP53YTW/D0hbaqvHg3EgbpTi7q/9GTd1TuT/wVbs=;
        b=RAFKiSFFOo6SWz2LmXsJCz9OopbHRQ1px8LjsohZczWNPODmZ8d250yRDbLckVfPQi
         fCdXUHhxg3W+O9ovB2KR7q51aN+DvqFDAe0QDKABwNuf+zut+p+XENj3KsQ/Y82HSVH8
         38RS42Vo8hje0mxI7kPzRZQtRcFgtUsRmiRSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7eVGP53YTW/D0hbaqvHg3EgbpTi7q/9GTd1TuT/wVbs=;
        b=pLCqkKhCEL2hGBJJnrMyBJbvj1oH+J2suxam8dsZLeDX9BcFJPfhknpASwWHg8KL4g
         lRyEzsrZ9msef4rUAUANgc8lyNmyK7WDdE+L6psC30yKRzR7zLbWvqYrCGoPS5WX+RDR
         Dh0ugFWU4vR7oDy+q481b8QZ7mrAdJ4LGuzD+XE6ZzEEak556OD4OUEjxR/6G4HFcYdP
         yDSnVh1U7o8KVBM9nJSIJiCRwl57NGLCYlUsy79G8Et5h1lJLV8K7jJb4tWDVClNEmDA
         GEDlBjVy6ZViDxubC/bWJPanAssicPBJPvuM7TUbHC84In8R9bX8nulSF7c/2akI6GEA
         2R2g==
X-Gm-Message-State: APjAAAWJY1d/3kKJvuJLP6a8+98DkvtjwHzysZyRA6+hX7ui6ZNVQGZn
        ZebQY88ZOQ6JrHaLevYgYVjGrZtUL9E=
X-Google-Smtp-Source: APXvYqxyyljZGlHrPmCRSYgC2fuoUWmRy8YfTx4pOoOE+ElDtTnIKw5bOMZ4hJBZcO0wfMbBd6wtOA==
X-Received: by 2002:a62:7641:: with SMTP id r62mr40628483pfc.201.1567541352326;
        Tue, 03 Sep 2019 13:09:12 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a23sm19651758pfo.80.2019.09.03.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 13:09:11 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Tim Murray <timmurray@google.com>, carmenjackson@google.com,
        mayankgupta@google.com, dancol@google.com, rostedt@goodmis.org,
        minchan@kernel.org, akpm@linux-foundation.org,
        kernel-team@android.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Jerome Glisse" <jglisse@redhat.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.cz>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2] mm: emit tracepoint when RSS changes by threshold
Date:   Tue,  3 Sep 2019 16:09:05 -0400
Message-Id: <20190903200905.198642-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Useful to track how RSS is changing per TGID to detect spikes in RSS and
memory hogs. Several Android teams have been using this patch in various
kernel trees for half a year now. Many reported to me it is really
useful so I'm posting it upstream.

Initial patch developed by Tim Murray. Changes I made from original patch:
o Prevent any additional space consumed by mm_struct.
o Keep overhead low by checking if tracing is enabled.
o Add some noise reduction and lower overhead by emitting only on
  threshold changes.

Co-developed-by: Tim Murray <timmurray@google.com>
Signed-off-by: Tim Murray <timmurray@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---

v1->v2: Added more commit message.

Cc: carmenjackson@google.com
Cc: mayankgupta@google.com
Cc: dancol@google.com
Cc: rostedt@goodmis.org
Cc: minchan@kernel.org
Cc: akpm@linux-foundation.org
Cc: kernel-team@android.com

 include/linux/mm.h          | 14 +++++++++++---
 include/trace/events/kmem.h | 21 +++++++++++++++++++++
 mm/memory.c                 | 20 ++++++++++++++++++++
 3 files changed, 52 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..823aaf759bdb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1671,19 +1671,27 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 	return (unsigned long)val;
 }
 
+void mm_trace_rss_stat(int member, long count, long value);
+
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	atomic_long_add(value, &mm->rss_stat.count[member]);
+	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count, value);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	atomic_long_inc(&mm->rss_stat.count[member]);
+	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count, 1);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	atomic_long_dec(&mm->rss_stat.count[member]);
+	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count, -1);
 }
 
 /* Optimized variant when page is already known not to be PageAnon */
diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
index eb57e3037deb..8b88e04fafbf 100644
--- a/include/trace/events/kmem.h
+++ b/include/trace/events/kmem.h
@@ -315,6 +315,27 @@ TRACE_EVENT(mm_page_alloc_extfrag,
 		__entry->change_ownership)
 );
 
+TRACE_EVENT(rss_stat,
+
+	TP_PROTO(int member,
+		long count),
+
+	TP_ARGS(member, count),
+
+	TP_STRUCT__entry(
+		__field(int, member)
+		__field(long, size)
+	),
+
+	TP_fast_assign(
+		__entry->member = member;
+		__entry->size = (count << PAGE_SHIFT);
+	),
+
+	TP_printk("member=%d size=%ldB",
+		__entry->member,
+		__entry->size)
+	);
 #endif /* _TRACE_KMEM_H */
 
 /* This part must be outside protection */
diff --git a/mm/memory.c b/mm/memory.c
index e2bb51b6242e..9d81322c24a3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -72,6 +72,8 @@
 #include <linux/oom.h>
 #include <linux/numa.h>
 
+#include <trace/events/kmem.h>
+
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
@@ -140,6 +142,24 @@ static int __init init_zero_pfn(void)
 }
 core_initcall(init_zero_pfn);
 
+/*
+ * This threshold is the boundary in the value space, that the counter has to
+ * advance before we trace it. Should be a power of 2. It is to reduce unwanted
+ * trace overhead. The counter is in units of number of pages.
+ */
+#define TRACE_MM_COUNTER_THRESHOLD 128
+
+void mm_trace_rss_stat(int member, long count, long value)
+{
+	long thresh_mask = ~(TRACE_MM_COUNTER_THRESHOLD - 1);
+
+	if (!trace_rss_stat_enabled())
+		return;
+
+	/* Threshold roll-over, trace it */
+	if ((count & thresh_mask) != ((count - value) & thresh_mask))
+		trace_rss_stat(member, count);
+}
 
 #if defined(SPLIT_RSS_COUNTING)
 
-- 
2.23.0.187.g17f5b7556c-goog
