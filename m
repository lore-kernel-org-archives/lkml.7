Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE0C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C7C208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577081312;
	bh=s5sUEMUuRSxhD255GsQGmj0WmUB/3MELmZFh+nkO2lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NKAlWlQi5oFcMoVrCpOq9Msas+QDF/T33XMtYKUXEVz8o27S43Iae8b2IS+kOCasO
	 BsOGpTxC6uNsEo3r38pnNE7fzG2QVTfJgRlleq2HIPvrI7Qg3j9+DOMGIWmQ6aiQYQ
	 1HL46AcdjQv7gvxs9DqXKt24g+Vgrx4FyXrAt79w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfLWGIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:08:31 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39834 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfLWGI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:08:27 -0500
Received: by mail-pj1-f68.google.com with SMTP id t101so7013305pjb.4;
        Sun, 22 Dec 2019 22:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSBaKinEilWr6xbL32uPs2VW25VT/Y+mxkN8hAms0hs=;
        b=FqnilaZ7TQoxDMiv4VdCyVoohE6x6GL23eWgDO5+E8L+Ri6mETPNOwOkd+j1YpmLHG
         p6qS3lrXNlwZrHetsFU622BV29BQpQHEUcrc9PJxFO+J+czYihoxqXCPXUeHqYGuzAOB
         RK9MMlMcs7reFarAyJfSgM2kmf6wza0Sz5P6+3d626VwmCMlwFzjzYFt87Ir3MLpTQNe
         XHTZZXis3soRYmtL7BejMzf6IqAfzRcbQMsJlrTI0J6rPX67eEeUipvpB0hFzCoohUfb
         P3jova0Q40qB3kiyW9mRbxj7p21DqINicYjhZdCZT8+ZhCANCaatTBfsaEuzOp8NKAYv
         prHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KSBaKinEilWr6xbL32uPs2VW25VT/Y+mxkN8hAms0hs=;
        b=RVZfqnYQFVj55FeAX/VS9+4Ab9cZHjZmpHexbQRlKO+vl6vm/takd0rEihMl/8VW24
         9Zn/bDWXFNeQGNk83e9VF70Y+4UjoxWl4boMiRCdzQw7vB4VZOIpmbQ+1S1z2cVub6Ix
         wwic60KqWb5ggCSRx6Ui4UQxi6dtQVJgeLWsO17wydZi9wb7KhA2o/L1S4CvgvW+peMm
         /1FhP26X/J0a40AXUHrxO5xaT5Ix2YP2RCXT/bTQzlZTyBePeXMiQfmDH+6BLmVpt681
         3lR9exhlFdbw80CNuAH9hjK8tVJ4WmesJ2WKDwECrCYwfSkJVQEPZAVV02qmtFF+wDZt
         J1+Q==
X-Gm-Message-State: APjAAAWccD4TPRf4zk8QjVnsaUBiHWk2uzWFuJSYMhU623eiP/CdyW0a
        R7Xas1QvYlz8a+jKwm9SkiI=
X-Google-Smtp-Source: APXvYqxlK2/XotRNp3G5NR7Ax8iwAdzDG6qBDgt6JdSyiZd+nsy4uKYG2iF83g7FGtxu9/+wm+Z4gw==
X-Received: by 2002:a17:902:124:: with SMTP id 33mr27814503plb.115.1577081306607;
        Sun, 22 Dec 2019 22:08:26 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p185sm22978212pfg.61.2019.12.22.22.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:08:26 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 5/9] perf report: Add 'cgroup' sort key
Date:   Mon, 23 Dec 2019 15:07:55 +0900
Message-Id: <20191223060759.841176-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
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
index 8dbe2119686a..5af43f3faf9f 100644
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
index ca5a8f4d007e..9f28d2f487c1 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -10,6 +10,7 @@
 #include "mem-events.h"
 #include "session.h"
 #include "namespaces.h"
+#include "cgroup.h"
 #include "sort.h"
 #include "units.h"
 #include "evlist.h"
@@ -222,6 +223,11 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *h)
 
 	if (h->trace_output)
 		hists__new_col_len(hists, HISTC_TRACE, strlen(h->trace_output));
+
+	if (h->cgroup) {
+		struct cgroup *cgrp = cgroup__findnew(h->cgroup, "<unknown>");
+		hists__new_col_len(hists, HISTC_CGROUP, strlen(cgrp->name));
+	}
 }
 
 void hists__output_recalc_col_len(struct hists *hists, int max_rows)
@@ -691,6 +697,7 @@ __hists__add_entry(struct hists *hists,
 			.dev = ns ? ns->link_info[CGROUP_NS_INDEX].dev : 0,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
+		.cgroup = sample->cgroup,
 		.ms = {
 			.maps	= al->maps,
 			.map	= al->map,
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 45286900aacb..191d6a84a96b 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -38,6 +38,7 @@ enum hist_column {
 	HISTC_THREAD,
 	HISTC_COMM,
 	HISTC_CGROUP_ID,
+	HISTC_CGROUP,
 	HISTC_PARENT,
 	HISTC_CPU,
 	HISTC_SOCKET,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 9fcba2872130..9abdab67b0aa 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -25,6 +25,7 @@
 #include "mem-events.h"
 #include "annotate.h"
 #include "time-utils.h"
+#include "cgroup.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 
@@ -635,6 +636,35 @@ struct sort_entry sort_cgroup_id = {
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
@@ -1659,6 +1689,7 @@ static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_TRACE, "trace", sort_trace),
 	DIM(SORT_SYM_SIZE, "symbol_size", sort_sym_size),
 	DIM(SORT_DSO_SIZE, "dso_size", sort_dso_size),
+	DIM(SORT_CGROUP, "cgroup", sort_cgroup),
 	DIM(SORT_CGROUP_ID, "cgroup_id", sort_cgroup_id),
 	DIM(SORT_SYM_IPC_NULL, "ipc_null", sort_sym_ipc_null),
 	DIM(SORT_TIME, "time", sort_time),
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5aff9542d9b7..321a3995f69b 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -101,6 +101,7 @@ struct hist_entry {
 	struct thread		*thread;
 	struct comm		*comm;
 	struct namespace_id	cgroup_id;
+	u64			cgroup;
 	u64			ip;
 	u64			transaction;
 	s32			socket;
@@ -222,6 +223,7 @@ enum sort_type {
 	SORT_TRACE,
 	SORT_SYM_SIZE,
 	SORT_DSO_SIZE,
+	SORT_CGROUP,
 	SORT_CGROUP_ID,
 	SORT_SYM_IPC_NULL,
 	SORT_TIME,
-- 
2.24.1.735.g03f4e72817-goog

