Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4E6C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D59B20674
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 06:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfKYGIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:08:00 -0500
Received: from mga07.intel.com ([134.134.136.100]:24016 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfKYGIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 01:08:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 22:07:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="291273084"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2019 22:07:59 -0800
Received: from [10.251.82.176] (abudanko-mobl.ccr.corp.intel.com [10.251.82.176])
        by linux.intel.com (Postfix) with ESMTP id AE24B580577;
        Sun, 24 Nov 2019 22:07:57 -0800 (PST)
Subject: [PATCH v2 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e1465b77-bf21-524a-d5eb-94d4c97f3fa4@linux.intel.com>
Date:   Mon, 25 Nov 2019 09:07:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
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
returns mask storage size in bytes.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- capitalized MMAP_CPU_MASK_BYTES() macro

---
 tools/perf/util/mmap.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index bee4e83f7109..786c235d6062 100644
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
-- 
2.20.1
