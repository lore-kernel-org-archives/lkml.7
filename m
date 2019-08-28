Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C0AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE4922DA7
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977527;
	bh=4h9HcKgovhstkDQcQtFltOgTbHibs7x+cu1+qIb80ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Fd/p65rm9NUBQicS7tXpuG4Z1oHkNnkKAgmKkOFrK3e10Kyxc5YPyzzCEEJ49A7sk
	 tJUAbWheoMoJQQl25aqIAM/WW0foW0Jxshc3/cX7RJxHB+smmK9ojoTjwhboJUGw9b
	 5dWi10C4ehQf3WhcIkMaAnGfX9OsTO7e+wf5cRSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfH1HcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:32:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41125 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfH1HcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:32:00 -0400
Received: by mail-pg1-f193.google.com with SMTP id x15so959546pgg.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iqm7gsnClUPCYol6XTrH8aK9FY0Uk3Vdil6q8YYxpvU=;
        b=VzVMk9S91NCS9Iq4DyaWU4vCrZdEg0If4z35xRfvaTp6i87D87jjE7ltyj256e0+NV
         oKzea6sef4URjSDgJH9ssNzGaCz4Cu2U5dxlirhqu/2GsADVJ6xAgMUVenyqZqdbcETN
         VepLKjd4nrTPhDsNojeF1TjSfRj3IhMM1REZNpIw2spdzv9bSGxoqdErCJ6pWj5owun/
         v5XsL8qU7b1qcpHdGGKt0XsmrdY4+siJL3YLE2AaFkawz1kedKvovpxnao9nCaWO6T7g
         Zd3wkGf2agNDV1ofVbYNFnWgb+on2DLJzq7/IWjmTvIKZKReqawHZjYn7+QDRRi5eDYq
         b7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=iqm7gsnClUPCYol6XTrH8aK9FY0Uk3Vdil6q8YYxpvU=;
        b=Qcj8KTDmafQ5/QZagpQgmxYsmjG1C4kgrYjR5NDqGgQg9InZAIQKVxMq4XTuT9qF+d
         rV45qRsjQeDTrx4idViqP9LuUO1O152ZM1XVRF1ZnOXzE21IkvLKGCQw6RCZtmWVH5dv
         LWvVmS6bWAgWY45JtspkZ0nbO4N9ZqVDjHReMtt7dFd3di0xR3eCasni4XqRaQflGP7F
         h87Bai4H8yejctUYGYySYF2GMQjRFgss6jKm9199HO32XYcT79TPSm+nZ2NwiyQpVTii
         ZOEXIOnVtZdbcBhXeUF1pZ0QqWrOAYUqixVISKfpZI/K5p1Ponr1r/sq2e1sJllvglvR
         LHNg==
X-Gm-Message-State: APjAAAXTs4ojFc7UvfU/VJtJXvAnzTPLHtLAkbAAAdGxIASS/x4TpcVS
        SzrC2RnF5m88AQjqIVaDRc7zF4se
X-Google-Smtp-Source: APXvYqxIBm164wnB0Na5fbeYi3AcmSsdWf2rmI8tuYj6K3ppUnMD/UqNWyGIkCtmn30eYz5w1xB1dA==
X-Received: by 2002:a62:31c3:: with SMTP id x186mr2976078pfx.97.1566977519820;
        Wed, 28 Aug 2019 00:31:59 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:31:59 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 5/9] perf report: Add 'cgroup' sort key
Date:   Wed, 28 Aug 2019 16:31:26 +0900
Message-Id: <20190828073130.83800-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cgroup sort key is to show cgroup membership of each task.
Currently it shows full path in the cgroupfs (not relative to the root
of cgroup namespace) since it'd be more intuitive IMHO.  Otherwise
root cgroup in different namespaces will all show same name - "/".

The cgroup sort key should come before cgroup_id otherwise
sort_dimension__add() will match it to cgroup_id as it only matches
with the given substring.

For example it will look like following.  Note that record patch
adding --all-cgroups patch will come later.

  $ perf record -a --namespace --all-cgroups  cgtest
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.208 MB perf.data (4090 samples) ]

  $ perf report -s cgroup_id,cgroup,pid
  ...
  # Overhead  cgroup id (dev/inode)  cgroup          Pid:Command
  # ........  .....................  ..........  ...............
  #
      93.96%  0/0x0                  /                 0:swapper
       1.25%  3/0xeffffffb           /               278:looper0
       0.86%  3/0xf000015f           /sub/cgrp1      280:cgtest
       0.37%  3/0xf0000160           /sub/cgrp2      281:cgtest
       0.34%  3/0xf0000163           /sub/cgrp3      282:cgtest
       0.22%  3/0xeffffffb           /sub            278:looper0
       0.20%  3/0xeffffffb           /               280:cgtest
       0.15%  3/0xf0000163           /sub/cgrp3      285:looper3

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.c                   |  7 ++++++
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 31 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  2 ++
 5 files changed, 42 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 7315f155803f..4c22146ae8fe 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -95,6 +95,7 @@ OPTIONS
 	abort cost. This is the global weight.
 	- local_weight: Local weight version of the weight above.
 	- cgroup_id: ID derived from cgroup namespace device and inode numbers.
+	- cgroup: cgroup pathname in the cgroupfs.
 	- transaction: Transaction abort flags.
 	- overhead: Overhead percentage of sample
 	- overhead_sys: Overhead percentage of sample running in system mode
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 33702675073c..b1f0a7d2a951 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -5,6 +5,7 @@
 #include "map.h"
 #include "session.h"
 #include "namespaces.h"
+#include "cgroup.h"
 #include "sort.h"
 #include "units.h"
 #include "evlist.h"
@@ -212,6 +213,11 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	if (h->trace_output)
 		hists__new_col_len(hists, HISTC_TRACE, strlen(h->trace_output));
+
+	if (h->cgroup) {
+		struct cgroup *cgrp = cgroup__findnew(h->cgroup, "<unknown>");
+		hists__new_col_len(hists, HISTC_CGROUP, strlen(cgrp->name));
+	}
 }
 
 void hists__output_recalc_col_len(struct hists *hists, int max_rows)
@@ -681,6 +687,7 @@ __hists__add_entry(struct hists *hists,
 			.dev = ns ? ns->link_info[CGROUP_NS_INDEX].dev : 0,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
+		.cgroup = sample->cgroup,
 		.ms = {
 			.map	= al->map,
 			.sym	= al->sym,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 83d5fc15429c..1e5c4087391b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -37,6 +37,7 @@ enum hist_column {
 	HISTC_THREAD,
 	HISTC_COMM,
 	HISTC_CGROUP_ID,
+	HISTC_CGROUP,
 	HISTC_PARENT,
 	HISTC_CPU,
 	HISTC_SOCKET,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 83eb3fa6f941..5524b10d7d38 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -20,6 +20,7 @@
 #include "mem-events.h"
 #include "annotate.h"
 #include "time-utils.h"
+#include "cgroup.h"
 #include <linux/kernel.h>
 
 regex_t		parent_regex;
@@ -627,6 +628,35 @@ struct sort_entry sort_cgroup_id = {
 	.se_width_idx	= HISTC_CGROUP_ID,
 };
 
+/* --sort cgroup */
+
+static int64_t
+sort__cgroup_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return right->cgroup - left->cgroup;
+}
+
+static int hist_entry__cgroup_snprintf(struct hist_entry *he,
+				       char *bf, size_t size,
+				       unsigned int width __maybe_unused)
+{
+	const char *cgrp_name = "N/A";
+
+	if (he->cgroup) {
+		struct cgroup *cgrp = cgroup__findnew(he->cgroup, cgrp_name);
+		cgrp_name = cgrp->name;
+	}
+
+	return repsep_snprintf(bf, size, "%s", cgrp_name);
+}
+
+struct sort_entry sort_cgroup = {
+	.se_header      = "cgroup",
+	.se_cmp	        = sort__cgroup_cmp,
+	.se_snprintf    = hist_entry__cgroup_snprintf,
+	.se_width_idx	= HISTC_CGROUP,
+};
+
 /* --sort socket */
 
 static int64_t
@@ -1667,6 +1697,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_TRACE, "trace", sort_trace),
 	DIM(SORT_SYM_SIZE, "symbol_size", sort_sym_size),
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
+	DIM(SORT_CGROUP, "cgroup", sort_cgroup),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
 	DIM(SORT_TIME, "time", sort_time),
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 3d7cef73924c..571092136e3b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -98,6 +98,7 @@ struct hist_entry {
 	struct thread		*thread;
 	struct comm		*comm;
 	struct namespace_id	cgroup_id;
+	u64			cgroup;
 	u64			ip;
 	u64			transaction;
 	s32			socket;
@@ -219,6 +220,7 @@ enum sort_type {
 	SORT_TRACE,
 	SORT_SYM_SIZE,
 	SORT_DSO_SIZE,
+	SORT_CGROUP,
 	SORT_CGROUP_ID,
 	SORT_SYM_IPC_NULL,
 	SORT_TIME,
-- 
2.23.0.187.g17f5b7556c-goog

