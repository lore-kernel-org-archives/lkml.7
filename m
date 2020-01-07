Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A4AC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92AD2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgAHCnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:43:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:62958 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHCnu (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:43:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 18:43:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; 
   d="scan'208";a="370823473"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by orsmga004.jf.intel.com with ESMTP; 07 Jan 2020 18:43:47 -0800
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, tmricht@linux.ibm.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf report: Fix no libunwind compiled warning break s390 issue
Date:   Wed,  8 Jan 2020 03:17:45 +0800
Message-Id: <20200107191745.18415-1-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
breaks the s390 platform. S390 uses libdw-dwarf-unwind for call chain
unwinding and had no support for libunwind.

So the warning "Please install libunwind development packages during the perf build."
caused the confusion even if the call-graph is displayed correctly.

This patch adds checking for HAVE_DWARF_SUPPORT, which is set when
libdw-dwarf-unwind is compiled in.

Fixes: 800d3f561659 ("perf report: Add warning when libunwind not compiled in")

Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index de988589d99b..66cd97cc8b92 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -412,10 +412,10 @@ static int report__setup_sample_type(struct report *rep)
 				PERF_SAMPLE_BRANCH_ANY))
 		rep->nonany_branch_mode = true;
 
-#ifndef HAVE_LIBUNWIND_SUPPORT
+#if !defined(HAVE_LIBUNWIND_SUPPORT) && !defined(HAVE_DWARF_SUPPORT)
 	if (dwarf_callchain_users) {
-		ui__warning("Please install libunwind development packages "
-			    "during the perf build.\n");
+		ui__warning("Please install libunwind or libdw "
+			    "development packages during the perf build.\n");
 	}
 #endif
 
-- 
2.17.1

