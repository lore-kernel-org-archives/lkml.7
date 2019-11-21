Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77F0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985A6206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 17:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKURzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:55:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33114 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKURzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:55:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXqfr-0002F6-CK; Thu, 21 Nov 2019 18:55:23 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E24B11C1A45;
        Thu, 21 Nov 2019 18:55:22 +0100 (CET)
Date:   Thu, 21 Nov 2019 17:55:22 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/pat: Rename pat_rbtree.c to pat_interval.c
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191121011601.20611-5-dave@stgolabs.net>
References: <20191121011601.20611-5-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <157435892282.21853.15649757798933944731.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     7f264dab5b60343358e788d4c939c166c22ea4a2
Gitweb:        https://git.kernel.org/tip/7f264dab5b60343358e788d4c939c166c22ea4a2
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Wed, 20 Nov 2019 17:16:01 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 21 Nov 2019 18:48:18 +01:00

x86/mm/pat: Rename pat_rbtree.c to pat_interval.c

Considering the previous changes, this is a more proper name.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/20191121011601.20611-5-dave@stgolabs.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/Makefile       |   2 +-
 arch/x86/mm/pat_interval.c | 185 ++++++++++++++++++++++++++++++++++++-
 arch/x86/mm/pat_rbtree.c   | 185 +------------------------------------
 3 files changed, 186 insertions(+), 186 deletions(-)
 create mode 100644 arch/x86/mm/pat_interval.c
 delete mode 100644 arch/x86/mm/pat_rbtree.c

diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 84373dc..de403df 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -23,7 +23,7 @@ CFLAGS_mem_encrypt_identity.o	:= $(nostackp)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
-obj-$(CONFIG_X86_PAT)		+= pat_rbtree.o
+obj-$(CONFIG_X86_PAT)		+= pat_interval.o
 
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
diff --git a/arch/x86/mm/pat_interval.c b/arch/x86/mm/pat_interval.c
new file mode 100644
index 0000000..47a1bf3
--- /dev/null
+++ b/arch/x86/mm/pat_interval.c
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Handle caching attributes in page tables (PAT)
+ *
+ * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
+ *          Suresh B Siddha <suresh.b.siddha@intel.com>
+ *
+ * Interval tree used to store the PAT memory type reservations.
+ */
+
+#include <linux/seq_file.h>
+#include <linux/debugfs.h>
+#include <linux/kernel.h>
+#include <linux/interval_tree_generic.h>
+#include <linux/sched.h>
+#include <linux/gfp.h>
+
+#include <asm/pgtable.h>
+#include <asm/pat.h>
+
+#include "pat_internal.h"
+
+/*
+ * The memtype tree keeps track of memory type for specific
+ * physical memory areas. Without proper tracking, conflicting memory
+ * types in different mappings can cause CPU cache corruption.
+ *
+ * The tree is an interval tree (augmented rbtree) with tree ordered
+ * on starting address. Tree can contain multiple entries for
+ * different regions which overlap. All the aliases have the same
+ * cache attributes of course.
+ *
+ * memtype_lock protects the rbtree.
+ */
+static inline u64 memtype_interval_start(struct memtype *memtype)
+{
+	return memtype->start;
+}
+
+static inline u64 memtype_interval_end(struct memtype *memtype)
+{
+	return memtype->end - 1;
+}
+INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
+		     memtype_interval_start, memtype_interval_end,
+		     static, memtype_interval)
+
+static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
+
+enum {
+	MEMTYPE_EXACT_MATCH	= 0,
+	MEMTYPE_END_MATCH	= 1
+};
+
+static struct memtype *memtype_match(u64 start, u64 end, int match_type)
+{
+	struct memtype *match;
+
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	while (match != NULL && match->start < end) {
+		if ((match_type == MEMTYPE_EXACT_MATCH) &&
+		    (match->start == start) && (match->end == end))
+			return match;
+
+		if ((match_type == MEMTYPE_END_MATCH) &&
+		    (match->start < start) && (match->end == end))
+			return match;
+
+		match = memtype_interval_iter_next(match, start, end);
+	}
+
+	return NULL; /* Returns NULL if there is no match */
+}
+
+static int memtype_check_conflict(u64 start, u64 end,
+				  enum page_cache_mode reqtype,
+				  enum page_cache_mode *newtype)
+{
+	struct memtype *match;
+	enum page_cache_mode found_type = reqtype;
+
+	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
+	if (match == NULL)
+		goto success;
+
+	if (match->type != found_type && newtype == NULL)
+		goto failure;
+
+	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
+	found_type = match->type;
+
+	match = memtype_interval_iter_next(match, start, end);
+	while (match) {
+		if (match->type != found_type)
+			goto failure;
+
+		match = memtype_interval_iter_next(match, start, end);
+	}
+success:
+	if (newtype)
+		*newtype = found_type;
+
+	return 0;
+
+failure:
+	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
+		current->comm, current->pid, start, end,
+		cattr_name(found_type), cattr_name(match->type));
+	return -EBUSY;
+}
+
+int memtype_check_insert(struct memtype *new,
+			 enum page_cache_mode *ret_type)
+{
+	int err = 0;
+
+	err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
+	if (err)
+		return err;
+
+	if (ret_type)
+		new->type = *ret_type;
+
+	memtype_interval_insert(new, &memtype_rbroot);
+	return 0;
+}
+
+struct memtype *memtype_erase(u64 start, u64 end)
+{
+	struct memtype *data;
+
+	/*
+	 * Since the memtype_rbroot tree allows overlapping ranges,
+	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
+	 * a whole node for the munmap case.  If no such entry is found,
+	 * it then checks with END_MATCH, i.e. shrink the size of a node
+	 * from the end for the mremap case.
+	 */
+	data = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
+	if (!data) {
+		data = memtype_match(start, end, MEMTYPE_END_MATCH);
+		if (!data)
+			return ERR_PTR(-EINVAL);
+	}
+
+	if (data->start == start) {
+		/* munmap: erase this node */
+		memtype_interval_remove(data, &memtype_rbroot);
+	} else {
+		/* mremap: update the end value of this node */
+		memtype_interval_remove(data, &memtype_rbroot);
+		data->end = start;
+		memtype_interval_insert(data, &memtype_rbroot);
+		return NULL;
+	}
+
+	return data;
+}
+
+struct memtype *memtype_lookup(u64 addr)
+{
+	return memtype_interval_iter_first(&memtype_rbroot, addr,
+					   addr + PAGE_SIZE);
+}
+
+#if defined(CONFIG_DEBUG_FS)
+int memtype_copy_nth_element(struct memtype *out, loff_t pos)
+{
+	struct memtype *match;
+	int i = 1;
+
+	match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
+	while (match && pos != i) {
+		match = memtype_interval_iter_next(match, 0, ULONG_MAX);
+		i++;
+	}
+
+	if (match) { /* pos == i */
+		*out = *match;
+		return 0;
+	} else {
+		return 1;
+	}
+}
+#endif
diff --git a/arch/x86/mm/pat_rbtree.c b/arch/x86/mm/pat_rbtree.c
deleted file mode 100644
index 47a1bf3..0000000
--- a/arch/x86/mm/pat_rbtree.c
+++ /dev/null
@@ -1,185 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Handle caching attributes in page tables (PAT)
- *
- * Authors: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
- *          Suresh B Siddha <suresh.b.siddha@intel.com>
- *
- * Interval tree used to store the PAT memory type reservations.
- */
-
-#include <linux/seq_file.h>
-#include <linux/debugfs.h>
-#include <linux/kernel.h>
-#include <linux/interval_tree_generic.h>
-#include <linux/sched.h>
-#include <linux/gfp.h>
-
-#include <asm/pgtable.h>
-#include <asm/pat.h>
-
-#include "pat_internal.h"
-
-/*
- * The memtype tree keeps track of memory type for specific
- * physical memory areas. Without proper tracking, conflicting memory
- * types in different mappings can cause CPU cache corruption.
- *
- * The tree is an interval tree (augmented rbtree) with tree ordered
- * on starting address. Tree can contain multiple entries for
- * different regions which overlap. All the aliases have the same
- * cache attributes of course.
- *
- * memtype_lock protects the rbtree.
- */
-static inline u64 memtype_interval_start(struct memtype *memtype)
-{
-	return memtype->start;
-}
-
-static inline u64 memtype_interval_end(struct memtype *memtype)
-{
-	return memtype->end - 1;
-}
-INTERVAL_TREE_DEFINE(struct memtype, rb, u64, subtree_max_end,
-		     memtype_interval_start, memtype_interval_end,
-		     static, memtype_interval)
-
-static struct rb_root_cached memtype_rbroot = RB_ROOT_CACHED;
-
-enum {
-	MEMTYPE_EXACT_MATCH	= 0,
-	MEMTYPE_END_MATCH	= 1
-};
-
-static struct memtype *memtype_match(u64 start, u64 end, int match_type)
-{
-	struct memtype *match;
-
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
-	while (match != NULL && match->start < end) {
-		if ((match_type == MEMTYPE_EXACT_MATCH) &&
-		    (match->start == start) && (match->end == end))
-			return match;
-
-		if ((match_type == MEMTYPE_END_MATCH) &&
-		    (match->start < start) && (match->end == end))
-			return match;
-
-		match = memtype_interval_iter_next(match, start, end);
-	}
-
-	return NULL; /* Returns NULL if there is no match */
-}
-
-static int memtype_check_conflict(u64 start, u64 end,
-				  enum page_cache_mode reqtype,
-				  enum page_cache_mode *newtype)
-{
-	struct memtype *match;
-	enum page_cache_mode found_type = reqtype;
-
-	match = memtype_interval_iter_first(&memtype_rbroot, start, end);
-	if (match == NULL)
-		goto success;
-
-	if (match->type != found_type && newtype == NULL)
-		goto failure;
-
-	dprintk("Overlap at 0x%Lx-0x%Lx\n", match->start, match->end);
-	found_type = match->type;
-
-	match = memtype_interval_iter_next(match, start, end);
-	while (match) {
-		if (match->type != found_type)
-			goto failure;
-
-		match = memtype_interval_iter_next(match, start, end);
-	}
-success:
-	if (newtype)
-		*newtype = found_type;
-
-	return 0;
-
-failure:
-	pr_info("x86/PAT: %s:%d conflicting memory types %Lx-%Lx %s<->%s\n",
-		current->comm, current->pid, start, end,
-		cattr_name(found_type), cattr_name(match->type));
-	return -EBUSY;
-}
-
-int memtype_check_insert(struct memtype *new,
-			 enum page_cache_mode *ret_type)
-{
-	int err = 0;
-
-	err = memtype_check_conflict(new->start, new->end, new->type, ret_type);
-	if (err)
-		return err;
-
-	if (ret_type)
-		new->type = *ret_type;
-
-	memtype_interval_insert(new, &memtype_rbroot);
-	return 0;
-}
-
-struct memtype *memtype_erase(u64 start, u64 end)
-{
-	struct memtype *data;
-
-	/*
-	 * Since the memtype_rbroot tree allows overlapping ranges,
-	 * memtype_erase() checks with EXACT_MATCH first, i.e. free
-	 * a whole node for the munmap case.  If no such entry is found,
-	 * it then checks with END_MATCH, i.e. shrink the size of a node
-	 * from the end for the mremap case.
-	 */
-	data = memtype_match(start, end, MEMTYPE_EXACT_MATCH);
-	if (!data) {
-		data = memtype_match(start, end, MEMTYPE_END_MATCH);
-		if (!data)
-			return ERR_PTR(-EINVAL);
-	}
-
-	if (data->start == start) {
-		/* munmap: erase this node */
-		memtype_interval_remove(data, &memtype_rbroot);
-	} else {
-		/* mremap: update the end value of this node */
-		memtype_interval_remove(data, &memtype_rbroot);
-		data->end = start;
-		memtype_interval_insert(data, &memtype_rbroot);
-		return NULL;
-	}
-
-	return data;
-}
-
-struct memtype *memtype_lookup(u64 addr)
-{
-	return memtype_interval_iter_first(&memtype_rbroot, addr,
-					   addr + PAGE_SIZE);
-}
-
-#if defined(CONFIG_DEBUG_FS)
-int memtype_copy_nth_element(struct memtype *out, loff_t pos)
-{
-	struct memtype *match;
-	int i = 1;
-
-	match = memtype_interval_iter_first(&memtype_rbroot, 0, ULONG_MAX);
-	while (match && pos != i) {
-		match = memtype_interval_iter_next(match, 0, ULONG_MAX);
-		i++;
-	}
-
-	if (match) { /* pos == i */
-		*out = *match;
-		return 0;
-	} else {
-		return 1;
-	}
-}
-#endif
