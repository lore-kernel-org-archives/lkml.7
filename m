Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81F3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B29206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 00:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rJG4BTCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKNAa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 19:30:57 -0500
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35440 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfKNAaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 19:30:55 -0500
Received: by mail-pl1-f202.google.com with SMTP id x9so2636089plv.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2019 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=24sb2iIYLdlHxI3dhEd8bJtA3WG5bvRweeBiL76YFS4=;
        b=rJG4BTCzqLmA0NCw5cuTPgEdYai8q1GVgCzAqATMSN97Mw+O+5jOJyoJeZ12R0eF90
         UjxjXJlHttGjfeO/qwNqGzWCYYJLi1+AxN3o2K61BY9Djw+FW7tcGqeUPjb/myHXGKzh
         yYvM5kehpNkVlNkEJx+Fxt2IfzzFtShaQHrFuqo5CTjoLFj5XpfJNlTSqItNShXdEp6I
         oLUyX+yyXkpAqhvfmJgWwjlJiXvBVL6PSW0yNC7cfF5EyFPmHrTmBGVTh7bv/MPPl3Tu
         emHFk+Hn8c/izlZSaq4BWn4Vgne2vgWURTBUBtzMeNV56XbYMdMtMPWiBD9Uo+SfHzaM
         kn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=24sb2iIYLdlHxI3dhEd8bJtA3WG5bvRweeBiL76YFS4=;
        b=iQy+8jiy3TCqVP26iB5MFFYffYzBYfHXiB8LEJlKH3+QfMs8wBgeHVYisj17zkR8J8
         UfkntoY0GmXueFOqwPRJ/gyNEyB+z1k3ebHHbCtDmxqIx9B6KNmG/4iM94MnLMq9ES9R
         awCDlHh0c/yH0qiwZY1pqbX2VqFwjGgdU5dbrAA+o7x2e1vtVdl/PdugSZcTJwiIdNN0
         rORzTr0UKcI6DRV3BASj8znRUvai4yYqU7X/zxVqbNYw+R0r27DaXOfEbNtKzAkcgSKK
         Vq0z6RynydMComd2usugdt4iRFNVrgPBy2ebOHYYdflARAv5yk5aeAubG/a0xCH3codf
         LQ5w==
X-Gm-Message-State: APjAAAVM7lVhq6kRRcXSuClyPqpZfNBjuDa4CNrfXCGEEP61Nuq9Yqe4
        n/tnq1UH2ADY/Qrf+z8M2HVtbN8NizfV
X-Google-Smtp-Source: APXvYqy8DjUsfGYf/q0Zg14Fk0fcWuv0tnV5DHW2YCY3KnmtGcfqxPPQu1T4FlcYteG13y36HTI8dCm16UM9
X-Received: by 2002:a63:584a:: with SMTP id i10mr6557477pgm.29.1573691453041;
 Wed, 13 Nov 2019 16:30:53 -0800 (PST)
Date:   Wed, 13 Nov 2019 16:30:34 -0800
In-Reply-To: <20191114003042.85252-1-irogers@google.com>
Message-Id: <20191114003042.85252-3-irogers@google.com>
Mime-Version: 1.0
References: <20191114003042.85252-1-irogers@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v3 02/10] lib: introduce generic min max heap
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Qian Cai <cai@lca.pw>, Joe Lawrence <joe.lawrence@redhat.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Gary Hook <Gary.Hook@amd.com>, Arnd Bergmann <arnd@arndb.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based-on-work-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/linux/min_max_heap.h | 134 ++++++++++++++++++++++++
 lib/Kconfig.debug            |  10 ++
 lib/Makefile                 |   1 +
 lib/test_min_max_heap.c      | 194 +++++++++++++++++++++++++++++++++++
 4 files changed, 339 insertions(+)
 create mode 100644 include/linux/min_max_heap.h
 create mode 100644 lib/test_min_max_heap.c

diff --git a/include/linux/min_max_heap.h b/include/linux/min_max_heap.h
new file mode 100644
index 000000000000..ea7764a8252a
--- /dev/null
+++ b/include/linux/min_max_heap.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MIN_MAX_HEAP_H
+#define _LINUX_MIN_MAX_HEAP_H
+
+#include <linux/bug.h>
+#include <linux/string.h>
+
+/*
+ * Data structure used to hold a min or max heap, the number of elements varies
+ * but the maximum size is fixed.
+ */
+struct min_max_heap {
+	/* Start of array holding the heap elements. */
+	void *data;
+	/* Number of elements currently in min-heap. */
+	int size;
+	/* Maximum number of elements that can be held in current storage. */
+	int cap;
+};
+
+struct min_max_heap_callbacks {
+	/* Size of elements in the heap. */
+	int elem_size;
+	/*
+	 * A function which returns *lhs < *rhs or *lhs > *rhs depending on
+	 * whether this is a min or a max heap. Note, another compare function
+	 * style in the kernel will return -ve, 0 and +ve and won't handle
+	 * minimum integer correctly if implemented as a subtract.
+	 */
+	bool (*cmp)(const void *lhs, const void *rhs);
+	/* Swap the element values at lhs with those at rhs. */
+	void (*swp)(void *lhs, void *rhs);
+};
+
+/* Sift the element at pos down the heap. */
+static inline void heapify(struct min_max_heap *heap, int pos,
+			const struct min_max_heap_callbacks *func) {
+	void *left_child, *right_child, *parent, *large_or_smallest;
+	char *data = (char *)heap->data;
+
+	for (;;) {
+		if (pos * 2 + 1 >= heap->size)
+			break;
+
+		left_child = data + ((pos * 2 + 1) * func->elem_size);
+		parent = data + (pos * func->elem_size);
+		large_or_smallest = parent;
+		if (func->cmp(left_child, large_or_smallest))
+			large_or_smallest = left_child;
+
+		if (pos * 2 + 2 < heap->size) {
+			right_child = data + ((pos * 2 + 2) * func->elem_size);
+			if (func->cmp(right_child, large_or_smallest))
+				large_or_smallest = right_child;
+		}
+		if (large_or_smallest == parent)
+			break;
+		func->swp(large_or_smallest, parent);
+		if (large_or_smallest == left_child)
+			pos = (pos * 2) + 1;
+		else
+			pos = (pos * 2) + 2;
+	}
+}
+
+/* Floyd's approach to heapification that is O(size). */
+static inline void
+heapify_all(struct min_max_heap *heap,
+	const struct min_max_heap_callbacks *func)
+{
+	int i;
+
+	for (i = heap->size / 2; i >= 0; i--)
+		heapify(heap, i, func);
+}
+
+/* Remove minimum element from the heap, O(log2(size)). */
+static inline void
+heap_pop(struct min_max_heap *heap, const struct min_max_heap_callbacks *func)
+{
+	char *data = (char *)heap->data;
+
+	if (WARN_ONCE(heap->size <= 0, "Popping an empty heap"))
+		return;
+
+	/* Place last element at the root (position 0) and then sift down. */
+	heap->size--;
+	memcpy(data, data + (heap->size * func->elem_size), func->elem_size);
+	heapify(heap, 0, func);
+}
+
+/*
+ * Remove the minimum element and then push the given element. The
+ * implementation performs 1 sift (O(log2(size))) and is therefore more
+ * efficient than a pop followed by a push that does 2.
+ */
+static void heap_pop_push(struct min_max_heap *heap,
+			const void *element,
+			const struct min_max_heap_callbacks *func)
+{
+	char *data = (char *)heap->data;
+
+	memcpy(data, element, func->elem_size);
+	heapify(heap, 0, func);
+}
+
+/* Push an element on to the heap, O(log2(size)). */
+static inline void
+heap_push(struct min_max_heap *heap, const void *element,
+	const struct min_max_heap_callbacks *func)
+{
+	void *child, *parent;
+	int pos;
+	char *data = (char *)heap->data;
+
+	if (WARN_ONCE(heap->size >= heap->cap, "Pushing on a full heap"))
+		return;
+
+	/* Place at the end of data. */
+	pos = heap->size;
+	memcpy(data + (pos * func->elem_size), element, func->elem_size);
+	heap->size++;
+
+	/* Sift up. */
+	for (; pos > 0; pos = (pos - 1) / 2) {
+		child = data + (pos * func->elem_size);
+		parent = data + ((pos - 1) / 2) * func->elem_size;
+		if (func->cmp(parent, child))
+			break;
+		func->swp(parent, child);
+	}
+}
+
+#endif /* _LINUX_MIN_MAX_HEAP_H */
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93d97f9b0157..6a2cf82515eb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1693,6 +1693,16 @@ config TEST_LIST_SORT
 
 	  If unsure, say N.
 
+config TEST_MIN_MAX_HEAP
+	tristate "Min-max heap test"
+	depends on DEBUG_KERNEL || m
+	help
+	  Enable this to turn on min-max heap function tests. This test is
+	  executed only once during system boot (so affects only boot time),
+	  or at module load time.
+
+	  If unsure, say N.
+
 config TEST_SORT
 	tristate "Array-based sort test"
 	depends on DEBUG_KERNEL || m
diff --git a/lib/Makefile b/lib/Makefile
index c5892807e06f..e73df06adaab 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -67,6 +67,7 @@ CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
 UBSAN_SANITIZE_test_ubsan.o := y
 obj-$(CONFIG_TEST_KSTRTOX) += test-kstrtox.o
 obj-$(CONFIG_TEST_LIST_SORT) += test_list_sort.o
+obj-$(CONFIG_TEST_MIN_MAX_HEAP) += test_min_max_heap.o
 obj-$(CONFIG_TEST_LKM) += test_module.o
 obj-$(CONFIG_TEST_VMALLOC) += test_vmalloc.o
 obj-$(CONFIG_TEST_OVERFLOW) += test_overflow.o
diff --git a/lib/test_min_max_heap.c b/lib/test_min_max_heap.c
new file mode 100644
index 000000000000..72c756d96e5e
--- /dev/null
+++ b/lib/test_min_max_heap.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#define pr_fmt(fmt) "min_max_heap_test: " fmt
+
+/*
+ * Test cases for the min max heap.
+ */
+
+#include <linux/log2.h>
+#include <linux/min_max_heap.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/random.h>
+
+static __init bool less_than(const void *lhs, const void *rhs)
+{
+	return *(int *)lhs < *(int *)rhs;
+}
+
+static __init bool greater_than(const void *lhs, const void *rhs)
+{
+	return *(int *)lhs > *(int *)rhs;
+}
+
+static __init void swap_ints(void *lhs, void *rhs)
+{
+	int temp = *(int *)lhs;
+
+	*(int *)lhs = *(int *)rhs;
+	*(int *)rhs = temp;
+}
+
+static __init int pop_verify_heap(bool min_heap,
+				struct min_max_heap *heap,
+				const struct min_max_heap_callbacks *funcs)
+{
+	int last;
+	int *values = (int *)heap->data;
+	int err = 0;
+
+	last = values[0];
+	heap_pop(heap, funcs);
+	while (heap->size > 0) {
+		if (min_heap) {
+			if (last > values[0]) {
+				pr_err("error: expected %d <= %d\n", last,
+					values[0]);
+				err++;
+			}
+		} else {
+			if (last < values[0]) {
+				pr_err("error: expected %d >= %d\n", last,
+					values[0]);
+				err++;
+			}
+		}
+		last = values[0];
+		heap_pop(heap, funcs);
+	}
+	return err;
+}
+
+static __init int test_heapify_all(bool min_heap)
+{
+	int values[] = { 3, 1, 2, 4, 0x8000000, 0x7FFFFFF, 0,
+			 -3, -1, -2, -4, 0x8000000, 0x7FFFFFF };
+	struct min_max_heap heap = {
+		.data = values,
+		.size = ARRAY_SIZE(values),
+		.cap =  ARRAY_SIZE(values),
+	};
+	struct min_max_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.cmp = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, err;
+
+	/* Test with known set of values. */
+	heapify_all(&heap, &funcs);
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+
+	/* Test with randomly generated values. */
+	heap.size = ARRAY_SIZE(values);
+	for (i = 0; i < heap.size; i++)
+		values[i] = get_random_int();
+
+	heapify_all(&heap, &funcs);
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static __init int test_heap_push(bool min_heap)
+{
+	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
+			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
+	int values[ARRAY_SIZE(data)];
+	struct min_max_heap heap = {
+		.data = values,
+		.size = 0,
+		.cap =  ARRAY_SIZE(values),
+	};
+	struct min_max_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.cmp = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, temp, err;
+
+	/* Test with known set of values copied from data. */
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		heap_push(&heap, &data[i], &funcs);
+
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+	/* Test with randomly generated values. */
+	while (heap.size < heap.cap) {
+		temp = get_random_int();
+		heap_push(&heap, &temp, &funcs);
+	}
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static __init int test_heap_pop_push(bool min_heap)
+{
+	const int data[] = { 3, 1, 2, 4, 0x80000000, 0x7FFFFFFF, 0,
+			     -3, -1, -2, -4, 0x80000000, 0x7FFFFFFF };
+	int values[ARRAY_SIZE(data)];
+	struct min_max_heap heap = {
+		.data = values,
+		.size = 0,
+		.cap =  ARRAY_SIZE(values),
+	};
+	struct min_max_heap_callbacks funcs = {
+		.elem_size = sizeof(int),
+		.cmp = min_heap ? less_than : greater_than,
+		.swp = swap_ints,
+	};
+	int i, temp, err;
+
+	/* Fill values with data to pop and replace. */
+	temp = min_heap ? 0x80000000 : 0x7FFFFFFF;
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		heap_push(&heap, &temp, &funcs);
+
+	/* Test with known set of values copied from data. */
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		heap_pop_push(&heap, &data[i], &funcs);
+
+	err = pop_verify_heap(min_heap, &heap, &funcs);
+
+	heap.size = 0;
+	for (i = 0; i < ARRAY_SIZE(data); i++)
+		heap_push(&heap, &temp, &funcs);
+
+	/* Test with randomly generated values. */
+	for (i = 0; i < ARRAY_SIZE(data); i++) {
+		temp = get_random_int();
+		heap_pop_push(&heap, &temp, &funcs);
+	}
+	err += pop_verify_heap(min_heap, &heap, &funcs);
+
+	return err;
+}
+
+static int __init test_min_max_heap_init(void)
+{
+	int err = 0;
+
+	err += test_heapify_all(true);
+	err += test_heapify_all(false);
+	err += test_heap_push(true);
+	err += test_heap_push(false);
+	err += test_heap_pop_push(true);
+	err += test_heap_pop_push(false);
+	if (err) {
+		pr_err("test failed with %d errors\n", err);
+		return -EINVAL;
+	}
+	pr_info("test passed\n");
+	return 0;
+}
+module_init(test_min_max_heap_init);
+
+static void __exit test_min_max_heap_exit(void)
+{
+	/* do nothing */
+}
+module_exit(test_min_max_heap_exit);
+
+MODULE_LICENSE("GPL");
-- 
2.24.0.432.g9d3f5f5b63-goog

