Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9104C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 02:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2072054F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 02:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfJKCWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 22:22:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:50747 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfJKCWT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 22:22:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Oct 2019 19:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,282,1566889200"; 
   d="scan'208";a="207324825"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga001.fm.intel.com with ESMTP; 10 Oct 2019 19:22:16 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf report: Add warning when libunwind not compiled in
Date:   Fri, 11 Oct 2019 10:21:22 +0800
Message-Id: <20191011022122.26369-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We received a user report that call-graph dwarf mode was enabled in perf
record but perf report didn't unwind the callstack correctly. The reason was,
libunwind was not compiled in.

We can use 'perf -vv' to check the compiled libraries but it would be valuable
to report a warning to user directly (especially valuable for perf newbie).

The warning is,

Warning:
Please install libunwind development packages during the perf build.

Both tui and stdio are supported.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aae0e57c60fb..7accaf8ef689 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -399,6 +399,13 @@ static int report__setup_sample_type(struct report *rep)
 				PERF_SAMPLE_BRANCH_ANY))
 		rep->nonany_branch_mode = true;
 
+#ifndef HAVE_LIBUNWIND_SUPPORT
+	if (dwarf_callchain_users) {
+		ui__warning("Please install libunwind development packages "
+			    "during the perf build.\n");
+	}
+#endif
+
 	return 0;
 }
 
-- 
2.17.1

