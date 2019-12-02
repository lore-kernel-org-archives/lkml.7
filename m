Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05395C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3A0B20833
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 06:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfLBG6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:58:10 -0500
Received: from mga05.intel.com ([192.55.52.43]:37396 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725976AbfLBG6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 01:58:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2019 22:58:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,268,1571727600"; 
   d="scan'208";a="241825632"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 01 Dec 2019 22:58:10 -0800
Received: from [10.252.19.98] (abudanko-mobl.ccr.corp.intel.com [10.252.19.98])
        by linux.intel.com (Postfix) with ESMTP id 2E4CC580127;
        Sun,  1 Dec 2019 22:58:06 -0800 (PST)
Subject: [PATCH v4 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f1e6e809-9e41-e410-57eb-1740512285a1@linux.intel.com>
Organization: Intel Corp.
Message-ID: <4fbe64e4-0607-e4ad-5309-b54114eb438b@linux.intel.com>
Date:   Mon, 2 Dec 2019 09:58:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <f1e6e809-9e41-e410-57eb-1740512285a1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Declare a dedicated struct map_cpu_mask type for cpu masks of
arbitrary length. Mask is available thru bits pointer and the
mask length is kept in nbits field. MMAP_CPU_MASK_BYTES() macro
returns mask storage size in bytes. mmap_cpu_mask__scnprintf()
function can be used to log text representation of the mask.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/mmap.c | 12 ++++++++++++
 tools/perf/util/mmap.h | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 063d1b93c53d..43c12b4a3e17 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -23,6 +23,18 @@
 #include "mmap.h"
 #include "../perf.h"
 #include <internal/lib.h> /* page_size */
+#include <linux/bitmap.h>
+
+#define MASK_SIZE 1023
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag)
+{
+	char buf[MASK_SIZE + 1];
+	size_t len;
+
+	len = bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
+	buf[len] = '\0';
+	pr_debug("%p: %s mask[%ld]: %s\n", mask, tag, mask->nbits, buf);
+}
 
 size_t mmap__mmap_len(struct mmap *map)
 {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index bee4e83f7109..ef51667fabcb 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -15,6 +15,15 @@
 #include "event.h"
 
 struct aiocb;
+
+struct mmap_cpu_mask {
+	unsigned long *bits;
+	size_t nbits;
+};
+
+#define MMAP_CPU_MASK_BYTES(m) \
+	(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned long))
+
 /**
  * struct mmap - perf's ring buffer mmap details
  *
@@ -52,4 +61,6 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
+void mmap_cpu_mask__scnprintf(struct mmap_cpu_mask *mask, const char *tag);
+
 #endif /*__PERF_MMAP_H */
-- 
2.20.1

