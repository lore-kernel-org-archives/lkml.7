Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3FFCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC1D222C9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KV/ow4iF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502503AbfJRQLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:11 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:52415 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442963AbfJRQLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:08 -0400
Received: by mail-pf1-f201.google.com with SMTP id u12so4963227pfn.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W3WDjYH/VAvmVL4+53CGlFooJvBVNnR4Xo1gyIsB1cA=;
        b=KV/ow4iF9rNc040TkpTO6MVpIairBWehEzBlCF7oKFaCOnaCnM5zX4GvWthj1gqY0d
         PX9Y3DI/oK29Df6zneqURkzRbTBLJqkuaLffnq7A4El6cHZNlrUbQpzFcfL4ESnRkS+0
         kFhJ8Srmh16l8pEUmTU/JhFulu4JDEH9dAL61TECT+ox0IG5tl+4w5amGJdnwnMlbBfZ
         fvGk8hbTsGc8lLqAgbYtD+1aodLStTRQ0VjzQsrgM1JFg2d+31jVYMY7X6BIqzpdsBol
         R753jt71O16ZF2aSp6FFKGjB7W8gPpZIrKVa5w89N/ZSJgIv+lGCKKJdnaWyQl7QvbhY
         plHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W3WDjYH/VAvmVL4+53CGlFooJvBVNnR4Xo1gyIsB1cA=;
        b=CCeZ3UJdGBr7JmigG2HJ0hV6srqzEXzOKtgZSFB7ghC7uK7faqUbmsZnxDq5P+CUP2
         HTof5xL+3j7OI8koOAf3MXsv4uDmOFjyavjJOJs+Y4LGAI1x9KHbpSDGEEeAEeMlNZaz
         w2lajsCbEFy30owwgWkpWOx6dwjhgxrvUQ0P95bJYIL01Y3FMOxWuK6e7q7Y+7YhKhfU
         MJZ/G7NJEdDTm25dxWeXrjIyWRTCdT7SAZK76LM4ZzmqI1hz2rGRnxlkU2GoynoUJ+em
         yJwn39GxBWRWVLQeSZt3vdn+/gCliKKnia8jv5y1qHzi+tg/BjyUdlDSnhKJFbPjCxhq
         mGMQ==
X-Gm-Message-State: APjAAAW0OWrYRqGZyJ7l/ubYf+oOXpSEJvYVNUn3E8n1p2SKTLFGf/cB
        eXiv3/U7uq2+oXVY7OFrS1HwcU4Zj7VOFXbsaSQ=
X-Google-Smtp-Source: APXvYqwgwFmbX6ZGPldjZxfBYIvVprCTpRWpmeoJv1AAdr3RY4ifrVx/55EnGx/lsXIR5pOg65l4zkBFehMDe52czU4=
X-Received: by 2002:a63:cf46:: with SMTP id b6mr10822679pgj.90.1571415067795;
 Fri, 18 Oct 2019 09:11:07 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:22 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-8-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 07/18] scs: add accounting
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds accounting for the memory allocated for shadow stacks.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 drivers/base/node.c    |  6 ++++++
 fs/proc/meminfo.c      |  4 ++++
 include/linux/mmzone.h |  3 +++
 kernel/scs.c           | 20 ++++++++++++++++++++
 mm/page_alloc.c        |  6 ++++++
 mm/vmstat.c            |  3 +++
 6 files changed, 42 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 296546ffed6c..111e58ec231e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -415,6 +415,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       "Node %d AnonPages:      %8lu kB\n"
 		       "Node %d Shmem:          %8lu kB\n"
 		       "Node %d KernelStack:    %8lu kB\n"
+#ifdef CONFIG_SHADOW_CALL_STACK
+		       "Node %d ShadowCallStack:%8lu kB\n"
+#endif
 		       "Node %d PageTables:     %8lu kB\n"
 		       "Node %d NFS_Unstable:   %8lu kB\n"
 		       "Node %d Bounce:         %8lu kB\n"
@@ -438,6 +441,9 @@ static ssize_t node_read_meminfo(struct device *dev,
 		       nid, K(node_page_state(pgdat, NR_ANON_MAPPED)),
 		       nid, K(i.sharedram),
 		       nid, sum_zone_node_page_state(nid, NR_KERNEL_STACK_KB),
+#ifdef CONFIG_SHADOW_CALL_STACK
+		       nid, sum_zone_node_page_state(nid, NR_KERNEL_SCS_BYTES) / 1024,
+#endif
 		       nid, K(sum_zone_node_page_state(nid, NR_PAGETABLE)),
 		       nid, K(node_page_state(pgdat, NR_UNSTABLE_NFS)),
 		       nid, K(sum_zone_node_page_state(nid, NR_BOUNCE)),
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index ac9247371871..df352e4bab90 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -103,6 +103,10 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 	show_val_kb(m, "SUnreclaim:     ", sunreclaim);
 	seq_printf(m, "KernelStack:    %8lu kB\n",
 		   global_zone_page_state(NR_KERNEL_STACK_KB));
+#ifdef CONFIG_SHADOW_CALL_STACK
+	seq_printf(m, "ShadowCallStack:%8lu kB\n",
+		   global_zone_page_state(NR_KERNEL_SCS_BYTES) / 1024);
+#endif
 	show_val_kb(m, "PageTables:     ",
 		    global_zone_page_state(NR_PAGETABLE));
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index bda20282746b..fcb8c1708f9e 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -200,6 +200,9 @@ enum zone_stat_item {
 	NR_MLOCK,		/* mlock()ed pages found and moved off LRU */
 	NR_PAGETABLE,		/* used for pagetables */
 	NR_KERNEL_STACK_KB,	/* measured in KiB */
+#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
+	NR_KERNEL_SCS_BYTES,	/* measured in bytes */
+#endif
 	/* Second 128 byte cacheline */
 	NR_BOUNCE,
 #if IS_ENABLED(CONFIG_ZSMALLOC)
diff --git a/kernel/scs.c b/kernel/scs.c
index 47324e8d313b..0e3cba49ea1a 100644
--- a/kernel/scs.c
+++ b/kernel/scs.c
@@ -7,9 +7,11 @@
 
 #include <linux/cpuhotplug.h>
 #include <linux/mm.h>
+#include <linux/mmzone.h>
 #include <linux/slab.h>
 #include <linux/scs.h>
 #include <linux/vmalloc.h>
+#include <linux/vmstat.h>
 #include <asm/scs.h>
 
 #define SCS_END_MAGIC	0xaf0194819b1635f6UL
@@ -59,6 +61,11 @@ static void scs_free(void *s)
 	vfree_atomic(s);
 }
 
+static struct page *__scs_page(struct task_struct *tsk)
+{
+	return vmalloc_to_page(__scs_base(tsk));
+}
+
 static int scs_cleanup(unsigned int cpu)
 {
 	int i;
@@ -92,6 +99,11 @@ static inline void scs_free(void *s)
 	kmem_cache_free(scs_cache, s);
 }
 
+static struct page *__scs_page(struct task_struct *tsk)
+{
+	return virt_to_page(__scs_base(tsk));
+}
+
 void __init scs_init(void)
 {
 	scs_cache = kmem_cache_create("scs_cache", SCS_SIZE, SCS_SIZE,
@@ -128,6 +140,12 @@ void scs_set_init_magic(struct task_struct *tsk)
 	scs_load(tsk);
 }
 
+static void scs_account(struct task_struct *tsk, int account)
+{
+	mod_zone_page_state(page_zone(__scs_page(tsk)), NR_KERNEL_SCS_BYTES,
+		account * SCS_SIZE);
+}
+
 int scs_prepare(struct task_struct *tsk, int node)
 {
 	void *s;
@@ -138,6 +156,7 @@ int scs_prepare(struct task_struct *tsk, int node)
 
 	task_set_scs(tsk, s);
 	scs_set_magic(tsk);
+	scs_account(tsk, 1);
 
 	return 0;
 }
@@ -157,6 +176,7 @@ void scs_release(struct task_struct *tsk)
 
 	WARN_ON(scs_corrupted(tsk));
 
+	scs_account(tsk, -1);
 	scs_task_init(tsk);
 	scs_free(s);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ecc3dbad606b..fe17d69d98a7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5361,6 +5361,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			" managed:%lukB"
 			" mlocked:%lukB"
 			" kernel_stack:%lukB"
+#ifdef CONFIG_SHADOW_CALL_STACK
+			" shadow_call_stack:%lukB"
+#endif
 			" pagetables:%lukB"
 			" bounce:%lukB"
 			" free_pcp:%lukB"
@@ -5382,6 +5385,9 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(zone_managed_pages(zone)),
 			K(zone_page_state(zone, NR_MLOCK)),
 			zone_page_state(zone, NR_KERNEL_STACK_KB),
+#ifdef CONFIG_SHADOW_CALL_STACK
+			zone_page_state(zone, NR_KERNEL_SCS_BYTES) / 1024,
+#endif
 			K(zone_page_state(zone, NR_PAGETABLE)),
 			K(zone_page_state(zone, NR_BOUNCE)),
 			K(free_pcp),
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 6afc892a148a..9fe4afe670fe 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1118,6 +1118,9 @@ const char * const vmstat_text[] = {
 	"nr_mlock",
 	"nr_page_table_pages",
 	"nr_kernel_stack",
+#if IS_ENABLED(CONFIG_SHADOW_CALL_STACK)
+	"nr_shadow_call_stack_bytes",
+#endif
 	"nr_bounce",
 #if IS_ENABLED(CONFIG_ZSMALLOC)
 	"nr_zspages",
-- 
2.23.0.866.gb869b98d4c-goog

