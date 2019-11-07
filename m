Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88499C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8A2085B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153775;
	bh=woFXZs3BAk2Iae8lEpVbIn69LoAmBJmSq8o3dyQU64g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xj8lwlxUFYSymQo9MgtBwwgh7STZhjRLyIEPsDKxG0RDkm8XJVKFdhjX/sp0esc3Y
	 tGcfa1R+NX+LHTLTVe23d00TjQ1e20VGPfvmRTeeqWDb1JOm70Mc4zlVj7uaAfA7bq
	 1NX90I9B/SbWEyCsZiD88AMnzHkP+RwLzNB59EuE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbfKGTJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:09:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727578AbfKGTJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:09:33 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A25D21D79;
        Thu,  7 Nov 2019 19:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153771;
        bh=woFXZs3BAk2Iae8lEpVbIn69LoAmBJmSq8o3dyQU64g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ocrEtTLEmQaOh3QFhe8DZp1ffpBM/sDDyLc038tFKwSYl9QjuCebSlia5/n+vDCI8
         du3LzlR7a+lWw5uiVQ5cgP8HiXra3hcO0OYGs4C9phOE0LI5M7N+9C1wKNkLqB27m0
         F5t/kXL+wRaJ1wyknKNFiF7kFzhEQ+aJhmzJrR3s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 62/63] perf report: Support --percent-limit for --total-cycles
Date:   Thu,  7 Nov 2019 16:00:10 -0300
Message-Id: <20191107190011.23924-63-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We have already supported the '--total-cycles' option in previous patch.
It's also useful to show entries only above a threshold percent.

This patch enables '--percent-limit' for not showing entries
under that percent.

For example:

 perf report --total-cycles --stdio --percent-limit 1

 # To display the perf.data header info, please use --header/--header-only options.
 #
 #
 # Total Lost Samples: 0
 #
 # Samples: 2M of event 'cycles'
 # Event count (approx.): 2753248
 #
 # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                              [Program Block Range]         Shared Object
 # ...............  ..............  ...........  ..........  .................................................................  ....................
 #
            26.04%            2.8M        0.40%          18                                             [div.c:42 -> div.c:39]                   div
            15.17%            1.2M        0.16%           7                                 [random_r.c:357 -> random_r.c:380]          libc-2.27.so
             5.11%          402.0K        0.04%           2                                             [div.c:27 -> div.c:28]                   div
             4.87%          381.6K        0.04%           2                                     [random.c:288 -> random.c:291]          libc-2.27.so
             4.53%          381.0K        0.04%           2                                             [div.c:40 -> div.c:40]                   div
             3.85%          300.9K        0.02%           1                                             [div.c:22 -> div.c:25]                   div
             3.08%          241.1K        0.02%           1                                           [rand.c:26 -> rand.c:27]          libc-2.27.so
             3.06%          240.0K        0.02%           1                                     [random.c:291 -> random.c:291]          libc-2.27.so
             2.78%          215.7K        0.02%           1                                     [random.c:298 -> random.c:298]          libc-2.27.so
             2.52%          198.3K        0.02%           1                                     [random.c:293 -> random.c:293]          libc-2.27.so
             2.36%          184.8K        0.02%           1                                           [rand.c:28 -> rand.c:28]          libc-2.27.so
             2.33%          180.5K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.28%          176.7K        0.02%           1                                     [random.c:295 -> random.c:295]          libc-2.27.so
             2.20%          168.8K        0.02%           1                                         [rand@plt+0 -> rand@plt+0]                   div
             1.98%          158.2K        0.02%           1                                 [random_r.c:388 -> random_r.c:388]          libc-2.27.so
             1.57%          123.3K        0.02%           1                                             [div.c:42 -> div.c:44]                   div
             1.44%          116.0K        0.42%          19                                 [random_r.c:357 -> random_r.c:394]          libc-2.27.so

Committer testing:

From second exapmple onwards slightly edited for brevity:

  # perf report --total-cycles --percent-limit 2 --stdio
  # To display the perf.data header info, please use --header/--header-only options.
  #
  #
  # Total Lost Samples: 0
  #
  # Samples: 6M of event 'cycles'
  # Event count (approx.): 6299936
  #
  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                                   [Program Block Range]         Shared Object
  # ...............  ..............  ...........  ..........  ......................................................................  ....................
  #
              2.17%            1.7M        0.08%         607                                        [compiler.h:199 -> common.c:221]      [kernel.vmlinux]
  #
  # (Tip: Create an archive with symtabs to analyse on other machine: perf archive)
  #
  # perf report --total-cycles --percent-limit 1 --stdio
  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                                   [Program Block Range]         Shared Object
              2.17%            1.7M        0.08%         607                                        [compiler.h:199 -> common.c:221]      [kernel.vmlinux]
              1.75%            1.3M        8.34%       65.5K    [memset-vec-unaligned-erms.S:147 -> memset-vec-unaligned-erms.S:151]          libc-2.29.so
  #
  # perf report --total-cycles --percent-limit 0.7 --stdio
  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles                                                   [Program Block Range]         Shared Object
              2.17%            1.7M        0.08%         607                                        [compiler.h:199 -> common.c:221]      [kernel.vmlinux]
              1.75%            1.3M        8.34%       65.5K    [memset-vec-unaligned-erms.S:147 -> memset-vec-unaligned-erms.S:151]          libc-2.29.so
              0.72%          544.5K        0.03%         230                                      [entry_64.S:657 -> entry_64.S:662]      [kernel.vmlinux]
  #

-------------------------------------------

It only shows the entries which 'Sampled Cycles%' > 1%.

 v7:
 ---
 No functional change. Only fix the conflict issue because
 previous patches are changed.

 v6:
 ---
 No functional change. Only fix the conflict issue because
 previous patches are changed.

 v5:
 ---
 No functional change. Only fix the conflict issue because
 previous patches are changed.

 v4:
 ---
 No functional change. Only fix the build issue because
 previous patches are changed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191107074719.26139-7-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c  |  2 +-
 tools/perf/ui/stdio/hist.c   |  7 ++++++-
 tools/perf/util/block-info.c | 10 ++++++++++
 tools/perf/util/block-info.h |  2 ++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 992b18bdd723..ca41187525ed 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -509,7 +509,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 
 		if (rep->total_cycles_mode) {
 			report__browse_block_hists(&rep->block_reports[i++].hist,
-						   0, pos);
+						   rep->min_percent, pos);
 			continue;
 		}
 
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 655ef7708cd0..132056c7d5b7 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -15,6 +15,7 @@
 #include "../../util/srcline.h"
 #include "../../util/string2.h"
 #include "../../util/thread.h"
+#include "../../util/block-info.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 
@@ -856,7 +857,11 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		if (h->filtered)
 			continue;
 
-		percent = hist_entry__get_percent_limit(h);
+		if (symbol_conf.report_individual_block)
+			percent = block_info__total_cycles_percent(h);
+		else
+			percent = hist_entry__get_percent_limit(h);
+
 		if (percent < min_pcnt)
 			continue;
 
diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
index ba891751a6ed..597d1205fa6c 100644
--- a/tools/perf/util/block-info.c
+++ b/tools/perf/util/block-info.c
@@ -454,3 +454,13 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
 
 	return 0;
 }
+
+float block_info__total_cycles_percent(struct hist_entry *he)
+{
+	struct block_info *bi = he->block_info;
+
+	if (bi->total_cycles)
+		return bi->cycles * 100.0 / bi->total_cycles;
+
+	return 0.0;
+}
diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
index 8309297a6e8f..e4d20bccd9b6 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -73,4 +73,6 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel);
 
+float block_info__total_cycles_percent(struct hist_entry *he);
+
 #endif /* __PERF_BLOCK_H */
-- 
2.21.0

