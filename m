Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B88FC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CAB2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 01:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfF1Bdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 21:33:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:41598 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbfF1Bdp (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 21:33:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 18:33:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,425,1557212400"; 
   d="scan'208";a="189283624"
Received: from skl.sh.intel.com ([10.239.159.132])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jun 2019 18:33:44 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 3/7] perf diff: Check if all data files with branch stacks
Date:   Fri, 28 Jun 2019 17:23:00 +0800
Message-Id: <1561713784-30533-4-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
References: <1561713784-30533-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will expand perf diff to support diff cycles of individual programs
blocks, so it requires all data files having branch stacks.

This patch checks HEADER_BRANCH_STACK in header, and only set the flag
has_br_stack when HEADER_BRANCH_STACK are set in all data files.

 v2:
 ---
 Move check_file_brstack() from __cmd_diff() to cmd_diff().
 Because later patch will check flag 'has_br_stack' before
 ui_init().

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/builtin-diff.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 6e79207..a7e0420 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -32,6 +32,7 @@ struct perf_diff {
 	struct perf_time_interval	*ptime_range;
 	int				 range_size;
 	int				 range_num;
+	bool				 has_br_stack;
 };
 
 /* Diff command specific HPP columns. */
@@ -873,6 +874,31 @@ static int parse_time_str(struct data__file *d, char *abstime_ostr,
 	return ret;
 }
 
+static int check_file_brstack(void)
+{
+	struct data__file *d;
+	bool has_br_stack;
+	int i;
+
+	data__for_each_file(i, d) {
+		d->session = perf_session__new(&d->data, false, &pdiff.tool);
+		if (!d->session) {
+			pr_err("Failed to open %s\n", d->data.path);
+			return -1;
+		}
+
+		has_br_stack = perf_header__has_feat(&d->session->header,
+						     HEADER_BRANCH_STACK);
+		perf_session__delete(d->session);
+		if (!has_br_stack)
+			return 0;
+	}
+
+	/* Set only all files having branch stacks */
+	pdiff.has_br_stack = true;
+	return 0;
+}
+
 static int __cmd_diff(void)
 {
 	struct data__file *d;
@@ -1487,6 +1513,9 @@ int cmd_diff(int argc, const char **argv)
 	if (data_init(argc, argv) < 0)
 		return -1;
 
+	if (check_file_brstack() < 0)
+		return -1;
+
 	if (ui_init() < 0)
 		return -1;
 
-- 
2.7.4

