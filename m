Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9065CC17448
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63E8A2246F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 11:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbfKLLV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:21:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33601 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfKLLSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBB-0000Ck-LX; Tue, 12 Nov 2019 12:17:49 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 529DD1C0357;
        Tue, 12 Nov 2019 12:17:49 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:17:49 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf report: Support --percent-limit for --total-cycles
Cc:     Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191107074719.26139-7-yao.jin@linux.intel.com>
References: <20191107074719.26139-7-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157355746900.29376.16941199530024447077.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0b49f83657d5fb9a35c592faab7c5ea16e387539
Gitweb:        https://git.kernel.org/tip/0b49f83657d5fb9a35c592faab7c5ea16e387539
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Thu, 07 Nov 2019 15:47:18 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 07 Nov 2019 10:14:48 -03:00

perf report: Support --percent-limit for --total-cycles

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

>From second exapmple onwards slightly edited for brevity:

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
index 992b18b..ca41187 100644
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
index 655ef77..132056c 100644
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
index ba89175..597d120 100644
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
index 8309297..e4d20bc 100644
--- a/tools/perf/util/block-info.h
+++ b/tools/perf/util/block-info.h
@@ -73,4 +73,6 @@ struct block_report *block_info__create_report(struct evlist *evlist,
 int report__browse_block_hists(struct block_hist *bh, float min_percent,
 			       struct evsel *evsel);
 
+float block_info__total_cycles_percent(struct hist_entry *he);
+
 #endif /* __PERF_BLOCK_H */
