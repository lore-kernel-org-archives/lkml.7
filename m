Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2CBC3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 21:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFE922CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 21:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406179AbfHWVDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 17:03:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:18378 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731003AbfHWVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 17:03:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 14:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,422,1559545200"; 
   d="scan'208";a="208661163"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2019 14:03:43 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 79354301C11; Fri, 23 Aug 2019 14:03:43 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/2] perf report: Fix --ns time sort key output
Date:   Fri, 23 Aug 2019 14:03:38 -0700
Message-Id: <20190823210338.12360-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190823210338.12360-1-andi@firstfloor.org>
References: <20190823210338.12360-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

If the user specified --ns, the column to print the sort time stamp
wasn't wide enough to actually print the full nanoseconds.

Widen the time key column width when --ns is specified.

Before:

% perf record -a sleep 1
% perf report --sort time,overhead,symbol --stdio --ns
...
     2.39%  187851.10000  [k] smp_call_function_single                                                                                -      -
     1.53%  187851.10000  [k] intel_idle                                                                                              -      -
     0.59%  187851.10000  [.] __wcscmp_ifunc                                                                                          -      -
     0.33%  187851.10000  [.] 0000000000000000                                                                                        -      -
     0.28%  187851.10000  [k] cpuidle_enter_state                                                                                     -      -

After:

% perf report --sort time,overhead,symbol --stdio --ns
...
     2.39%  187851.100000000  [k] smp_call_function_single                                                                                -      -
     1.53%  187851.100000000  [k] intel_idle                                                                                              -      -
     0.59%  187851.100000000  [.] __wcscmp_ifunc                                                                                          -      -
     0.33%  187851.100000000  [.] 0000000000000000                                                                                        -      -
     0.28%  187851.100000000  [k] cpuidle_enter_state                                                                                     -      -

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/hist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 8efbf58dc3d0..33702675073c 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -193,7 +193,10 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 	hists__new_col_len(hists, HISTC_MEM_LVL, 21 + 3);
 	hists__new_col_len(hists, HISTC_LOCAL_WEIGHT, 12);
 	hists__new_col_len(hists, HISTC_GLOBAL_WEIGHT, 12);
-	hists__new_col_len(hists, HISTC_TIME, 12);
+	if (symbol_conf.nanosecs)
+		hists__new_col_len(hists, HISTC_TIME, 16);
+	else
+		hists__new_col_len(hists, HISTC_TIME, 12);
 
 	if (h->srcline) {
 		len = MAX(strlen(h->srcline), strlen(sort_srcline.se_header));
-- 
2.20.1

