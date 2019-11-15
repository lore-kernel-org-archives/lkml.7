Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573CBC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5432072D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 12:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfKOMoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 07:44:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:58938 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727576AbfKOMn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 07:43:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 04:43:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="257749660"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.197])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2019 04:43:26 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] perf tools: Add a function to test for kernel support for AUX area sampling
Date:   Fri, 15 Nov 2019 14:42:13 +0200
Message-Id: <20191115124225.5247-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191115124225.5247-1-adrian.hunter@intel.com>
References: <20191115124225.5247-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures are expected to know if AUX area sampling is supported by the
hardware. Add a function perf_can_aux_sample() which will determine whether
the kernel supports it.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/evlist.h |  1 +
 tools/perf/util/record.c | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 13051409fd22..3655b9ebb147 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -176,6 +176,7 @@ void perf_evlist__set_id_pos(struct evlist *evlist);
 bool perf_can_sample_identifier(void);
 bool perf_can_record_switch_events(void);
 bool perf_can_record_cpu_wide(void);
+bool perf_can_aux_sample(void);
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain);
 int record_opts__config(struct record_opts *opts);
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 8579505c29a4..e2321edcdd8f 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -136,6 +136,36 @@ bool perf_can_record_cpu_wide(void)
 	return true;
 }
 
+/*
+ * Architectures are expected to know if AUX area sampling is supported by the
+ * hardware. Here we check for kernel support.
+ */
+bool perf_can_aux_sample(void)
+{
+	struct perf_event_attr attr = {
+		.exclude_kernel = 1,
+		/*
+		 * Non-zero value causes the kernel to calculate the effective
+		 * attribute size up to that byte.
+		 */
+		.aux_sample_size = 1,
+	};
+	int fd;
+
+	fd = sys_perf_event_open(&attr, -1, 0, -1, 0);
+	/*
+	 * If the kernel attribute is big enough to contain aux_sample_size
+	 * then we assume that it is supported. We are relying on the kernel to
+	 * validate the attribute size before anything else that could be wrong.
+	 */
+	if (fd == -E2BIG)
+		return false;
+	if (fd >= 0)
+		close(fd);
+
+	return true;
+}
+
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
 			 struct callchain_param *callchain)
 {
-- 
2.17.1

