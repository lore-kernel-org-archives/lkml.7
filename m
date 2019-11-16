Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0ADC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF3EB2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 05:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfKPFxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 00:53:13 -0500
Received: from mga07.intel.com ([134.134.136.100]:23977 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfKPFwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 00:52:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 21:52:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,311,1569308400"; 
   d="scan'208";a="230668186"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga004.fm.intel.com with ESMTP; 15 Nov 2019 21:52:44 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id DF01C300FFA; Fri, 15 Nov 2019 21:52:43 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v7 03/12] perf cpumap: Maintain cpumaps ordered and without dups
Date:   Fri, 15 Nov 2019 21:52:20 -0800
Message-Id: <20191116055229.62002-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191116055229.62002-1-andi@firstfloor.org>
References: <20191116055229.62002-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Enforce this in _trim()

Needed for followon change.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/lib/cpumap.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 2ca1fafa620d..d81656b4635e 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -68,14 +68,28 @@ static struct perf_cpu_map *cpu_map__default_new(void)
 	return cpus;
 }
 
+static int cmp_int(const void *a, const void *b)
+{
+	return *(const int *)a - *(const int*)b;
+}
+
 static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus)
 {
 	size_t payload_size = nr_cpus * sizeof(int);
 	struct perf_cpu_map *cpus = malloc(sizeof(*cpus) + payload_size);
+	int i, j;
 
 	if (cpus != NULL) {
-		cpus->nr = nr_cpus;
 		memcpy(cpus->map, tmp_cpus, payload_size);
+		qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
+		/* Remove dups */
+		j = 0;
+		for (i = 0; i < nr_cpus; i++) {
+			if (i == 0 || cpus->map[i] != cpus->map[i - 1])
+				cpus->map[j++] = cpus->map[i];
+		}
+		cpus->nr = j;
+		assert(j <= nr_cpus);
 		refcount_set(&cpus->refcnt, 1);
 	}
 
-- 
2.23.0

