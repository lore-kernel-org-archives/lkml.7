Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5093BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 237EC24682
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 22:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLPWQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 17:16:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:54731 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbfLPWP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 17:15:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Dec 2019 14:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,323,1571727600"; 
   d="scan'208";a="212362086"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga008.fm.intel.com with ESMTP; 16 Dec 2019 14:15:23 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Sai Praneeth Prakhya" <sai.praneeth.prakhya@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v9 05/13] selftests/resctrl: Add built in benchmark
Date:   Mon, 16 Dec 2019 14:26:39 -0800
Message-Id: <1576535207-2417-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Built-in benchmark fill_buf generates stressful memory bandwidth
and cache traffic.

Later it will be used as a default benchmark by various resctrl tests
such as MBA (Memory Bandwidth Allocation) and MBM (Memory Bandwidth
Monitoring) tests.

Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Co-developed-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/fill_buf.c | 207 +++++++++++++++++++++
 1 file changed, 207 insertions(+)
 create mode 100644 tools/testing/selftests/resctrl/fill_buf.c

diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
new file mode 100644
index 000000000000..b76bf6a4a0a5
--- /dev/null
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fill_buf benchmark
+ *
+ * Copyright (C) 2018 Intel Corporation
+ *
+ * Authors:
+ *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
+ *    Fenghua Yu <fenghua.yu@intel.com>
+ */
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <inttypes.h>
+#include <malloc.h>
+#include <string.h>
+
+#include "resctrl.h"
+
+#define CL_SIZE			(64)
+#define PAGE_SIZE		(4 * 1024)
+#define MB			(1024 * 1024)
+
+static unsigned char *startptr;
+
+static void sb(void)
+{
+#if defined(__i386) || defined(__x86_64)
+	asm volatile("sfence\n\t"
+		     : : : "memory");
+#endif
+}
+
+static void ctrl_handler(int signo)
+{
+	free(startptr);
+	printf("\nEnding\n");
+	sb();
+	exit(EXIT_SUCCESS);
+}
+
+static void cl_flush(void *p)
+{
+#if defined(__i386) || defined(__x86_64)
+	asm volatile("clflush (%0)\n\t"
+		     : : "r"(p) : "memory");
+#endif
+}
+
+static void mem_flush(void *p, size_t s)
+{
+	char *cp = (char *)p;
+	size_t i = 0;
+
+	s = s / CL_SIZE; /* mem size in cache llines */
+
+	for (i = 0; i < s; i++)
+		cl_flush(&cp[i * CL_SIZE]);
+
+	sb();
+}
+
+static void *malloc_and_init_memory(size_t s)
+{
+	uint64_t *p64;
+	size_t s64;
+
+	void *p = memalign(PAGE_SIZE, s);
+
+	p64 = (uint64_t *)p;
+	s64 = s / sizeof(uint64_t);
+
+	while (s64 > 0) {
+		*p64 = (uint64_t)rand();
+		p64 += (CL_SIZE / sizeof(uint64_t));
+		s64 -= (CL_SIZE / sizeof(uint64_t));
+	}
+
+	return p;
+}
+
+static int fill_one_span_read(unsigned char *start_ptr, unsigned char *end_ptr)
+{
+	unsigned char sum, *p;
+
+	sum = 0;
+	p = start_ptr;
+	while (p < end_ptr) {
+		sum += *p;
+		p += (CL_SIZE / 2);
+	}
+
+	return sum;
+}
+
+static
+void fill_one_span_write(unsigned char *start_ptr, unsigned char *end_ptr)
+{
+	unsigned char *p;
+
+	p = start_ptr;
+	while (p < end_ptr) {
+		*p = '1';
+		p += (CL_SIZE / 2);
+	}
+}
+
+static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
+			   char *resctrl_val)
+{
+	int ret = 0;
+	FILE *fp;
+
+	while (1)
+		ret = fill_one_span_read(start_ptr, end_ptr);
+
+	/* Consume read result so that reading memory is not optimized out. */
+	fp = fopen("/dev/null", "w");
+	if (!fp)
+		perror("Unable to write to /dev/null");
+	fprintf(fp, "Sum: %d ", ret);
+	fclose(fp);
+
+	return 0;
+}
+
+static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
+			    char *resctrl_val)
+{
+	while (1)
+		fill_one_span_write(start_ptr, end_ptr);
+
+	return 0;
+}
+
+static int
+fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
+	   int op, char *resctrl_val)
+{
+	unsigned char *start_ptr, *end_ptr;
+	unsigned long long i;
+	int ret;
+
+	if (malloc_and_init)
+		start_ptr = malloc_and_init_memory(buf_size);
+	else
+		start_ptr = malloc(buf_size);
+
+	if (!start_ptr)
+		return -1;
+
+	startptr = start_ptr;
+	end_ptr = start_ptr + buf_size;
+
+	/*
+	 * It's better to touch the memory once to avoid any compiler
+	 * optimizations
+	 */
+	if (!malloc_and_init) {
+		for (i = 0; i < buf_size; i++)
+			*start_ptr++ = (unsigned char)rand();
+	}
+
+	start_ptr = startptr;
+
+	/* Flush the memory before using to avoid "cache hot pages" effect */
+	if (memflush)
+		mem_flush(start_ptr, buf_size);
+
+	if (op == 0)
+		ret = fill_cache_read(start_ptr, end_ptr, resctrl_val);
+	else
+		ret = fill_cache_write(start_ptr, end_ptr, resctrl_val);
+
+	if (ret) {
+		printf("\n Errror in fill cache read/write...\n");
+		return -1;
+	}
+
+	free(startptr);
+
+	return 0;
+}
+
+int run_fill_buf(unsigned long span, int malloc_and_init_memory,
+		 int memflush, int op, char *resctrl_val)
+{
+	unsigned long long cache_size = span;
+	int ret;
+
+	/* set up ctrl-c handler */
+	if (signal(SIGINT, ctrl_handler) == SIG_ERR)
+		printf("Failed to catch SIGINT!\n");
+	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
+		printf("Failed to catch SIGHUP!\n");
+
+	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
+			 resctrl_val);
+	if (ret) {
+		printf("\n Errror in fill cache\n");
+		return -1;
+	}
+
+	return 0;
+}
-- 
2.19.1

