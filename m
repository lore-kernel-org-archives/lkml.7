Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08154C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E2721D6C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 18:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfKGSQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:16:50 -0500
Received: from mga11.intel.com ([192.55.52.93]:28855 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfKGSQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 13:16:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 10:16:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="230789381"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Nov 2019 10:16:49 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id A25A6301BE9; Thu,  7 Nov 2019 10:16:49 -0800 (PST)
From:   Andi Kleen <andi@firstfloor.org>
To:     jolsa@kernel.org
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v5 03/13] perf cpumap: Maintain cpumaps ordered and without dups
Date:   Thu,  7 Nov 2019 10:16:36 -0800
Message-Id: <20191107181646.506734-4-andi@firstfloor.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191107181646.506734-1-andi@firstfloor.org>
References: <20191107181646.506734-1-andi@firstfloor.org>
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

