Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1C1ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EE821A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="m+omBAHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbfJAR22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 13:28:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40016 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfJAR22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 13:28:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id d26so4660553pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89LjCF4nnVOchv6tRtvlCTR+voV7AebrnejBV1VPn1I=;
        b=m+omBAHkhT51nLWKjmRCWs7DoVSmLgkv4Wbp9PCKSu2KIar+DmNGXmca84Dn1RX1vV
         XNqHXyWm0AVQd6FglFYggt+TymOKbuC3MjV+tUWyrPitTj4xwWD8W2eSABP7jC2LjpEQ
         FbKfRiHVgzAWwdkYx+iYyzmXi5MYd2TVJAiZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89LjCF4nnVOchv6tRtvlCTR+voV7AebrnejBV1VPn1I=;
        b=VejBeVDYrW87xBOU0l7ATqZsp2bcLjF9oapQaLmDNNXS+E7+MY0ya/Jh/6pT8A9a5Q
         jz0PlP9DNhJHhV3nLwjaTQ3O4+ues8xLnwy4FRNhW8eoowTNBMB8I6j4sdODOEHemK4j
         ZScJ+YF4rfMPIXKKJluUrjWm3GjeO0wVoDnVSxXoSo1ylt1f4Eikh0sleruEDnz+gPUv
         +OIWiDGhA2QQQGraj/faEXF5K41n9Nci1XUd0lgLV+uZfnBD+9dEm9RTdE5BeW3FfnmF
         Uu137JbHjUlcA5rWc2MUDjRduAFBglJNyuDfBLFInqfnGLaTBcnXwX9LYq1PjCdhYGoU
         LSZw==
X-Gm-Message-State: APjAAAWcf+CTH/Yq5jjH1g5tYCKnCkg+2SCnIqpdhknqTQiwxPU/vJ7L
        yQmGJhqD6YK98TzdIHI8sVCWnpmhR1s=
X-Google-Smtp-Source: APXvYqwoLCJEyEQN9U9LFMOf6V2m/TjY4kIVxiHBfOBUHULteY3NFbfqAsNWQvh9aQJhaURFioR49Q==
X-Received: by 2002:a62:7d54:: with SMTP id y81mr28985112pfc.86.1569950906178;
        Tue, 01 Oct 2019 10:28:26 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z20sm17564093pfj.156.2019.10.01.10.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 10:28:25 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Michal Hocko <mhocko@suse.com>,
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
Subject: [PATCH v3] mm: emit tracepoint when RSS changes
Date:   Tue,  1 Oct 2019 13:28:17 -0400
Message-Id: <20191001172817.234886-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Regarding the fact that the RSS may change too often thus flooding the
traces - note that, there is some "hysterisis" with this already. That
is - We update the counter only if we receive 64 page faults due to
SPLIT_RSS_ACCOUNTING. However, during zapping or copying of pte range,
the RSS is updated immediately which can become noisy/flooding. In a
previous discussion, we agreed that BPF or ftrace can be used to rate
limit the signal if this becomes an issue.

Also note that I added wrappers to trace_rss_stat to prevent compiler
errors where linux/mm.h is included from tracing code, causing errors
such as:
  CC      kernel/trace/power-traces.o
In file included from ./include/trace/define_trace.h:102,
                 from ./include/trace/events/kmem.h:342,
                 from ./include/linux/mm.h:31,
                 from ./include/linux/ring_buffer.h:5,
                 from ./include/linux/trace_events.h:6,
                 from ./include/trace/events/power.h:12,
                 from kernel/trace/power-traces.c:15:
./include/trace/trace_events.h:113:22: error: field ‘ent’ has incomplete type
   struct trace_entry ent;    \

Link: http://lore.kernel.org/r/20190903200905.198642-1-joel@joelfernandes.org
Acked-by: Michal Hocko <mhocko@suse.com>
Co-developed-by: Tim Murray <timmurray@google.com>
Signed-off-by: Tim Murray <timmurray@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---

v2->v3: Removed optimization for rate limitting and we can do so from
        tracing code.
        Added Michal's ack after private discussion.

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
 mm/memory.c                 |  6 ++++++
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 0334ca97c584..fb8619c5a87d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1671,19 +1671,27 @@ static inline unsigned long get_mm_counter(struct mm_struct *mm, int member)
 	return (unsigned long)val;
 }
 
+void mm_trace_rss_stat(int member, long count);
+
 static inline void add_mm_counter(struct mm_struct *mm, int member, long value)
 {
-	atomic_long_add(value, &mm->rss_stat.count[member]);
+	long count = atomic_long_add_return(value, &mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count);
 }
 
 static inline void inc_mm_counter(struct mm_struct *mm, int member)
 {
-	atomic_long_inc(&mm->rss_stat.count[member]);
+	long count = atomic_long_inc_return(&mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count);
 }
 
 static inline void dec_mm_counter(struct mm_struct *mm, int member)
 {
-	atomic_long_dec(&mm->rss_stat.count[member]);
+	long count = atomic_long_dec_return(&mm->rss_stat.count[member]);
+
+	mm_trace_rss_stat(member, count);
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
index e2bb51b6242e..4b31ac2fef42 100644
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
@@ -140,6 +142,10 @@ static int __init init_zero_pfn(void)
 }
 core_initcall(init_zero_pfn);
 
+void mm_trace_rss_stat(int member, long count)
+{
+	trace_rss_stat(member, count);
+}
 
 #if defined(SPLIT_RSS_COUNTING)
 
-- 
2.23.0.444.g18eeb5a265-goog
