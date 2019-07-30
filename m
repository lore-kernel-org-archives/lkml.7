Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4979BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209F6206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455712;
	bh=8fCo+FsXAwJQ7MNMVB0NVYlqBesw+GzF0uRKBXW5SA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hF5m2OXe2SBPyGNG6tYlcuZeSGZwd6iMGRtpgCZlN6Ud5BGBSHtDWBYKRgBq5CwTt
	 z1C/kDqp0OvJn9HTvAc1X5LAPD5aeC2S3Q+N54rft02LNe55878LHZJ1jJ1Nyodb3L
	 9MITcZ6xnwepqzzKV3l/3LUI3gg3K/N4g/TIDo0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732687AbfG3DBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:01:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732635AbfG3DBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:01:48 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D46272171F;
        Tue, 30 Jul 2019 03:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455707;
        bh=8fCo+FsXAwJQ7MNMVB0NVYlqBesw+GzF0uRKBXW5SA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0BGX6zukXZQd/eSSsvk6tOyMIoUqSUJln0K1mNvfzi+RjLWhLaWIAOseH9lnMfbkH
         4+CYpDjUoxht+jPrtU+MhSEjOrDaqQbviFLbt65c0wgBTqCe1zr42TIQSbCmKM6+vX
         ESh1QFLfPZz7zTyzQnj7d56hpy5bQFiSQ7vnaF+8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 096/107] libperf: Adopt perf_evlist__enable()/disable() functions from perf
Date:   Mon, 29 Jul 2019 23:55:59 -0300
Message-Id: <20190730025610.22603-97-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adopt the following functions from tools/perf:

  perf_evlist__enable()
  perf_evlist__disable()

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-70-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c              | 16 ++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  2 ++
 tools/perf/lib/libperf.map           |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 5dda96b1d4da..f4dc9a208332 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -141,3 +141,19 @@ void perf_evlist__close(struct perf_evlist *evlist)
 	perf_evlist__for_each_entry_reverse(evlist, evsel)
 		perf_evsel__close(evsel);
 }
+
+void perf_evlist__enable(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel)
+		perf_evsel__enable(evsel);
+}
+
+void perf_evlist__disable(struct perf_evlist *evlist)
+{
+	struct perf_evsel *evsel;
+
+	perf_evlist__for_each_entry(evlist, evsel)
+		perf_evsel__disable(evsel);
+}
diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
index 6d3dda743541..38365f8f3fba 100644
--- a/tools/perf/lib/include/perf/evlist.h
+++ b/tools/perf/lib/include/perf/evlist.h
@@ -20,6 +20,8 @@ LIBPERF_API struct perf_evsel* perf_evlist__next(struct perf_evlist *evlist,
 						 struct perf_evsel *evsel);
 LIBPERF_API int perf_evlist__open(struct perf_evlist *evlist);
 LIBPERF_API void perf_evlist__close(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__enable(struct perf_evlist *evlist);
+LIBPERF_API void perf_evlist__disable(struct perf_evlist *evlist);
 
 #define perf_evlist__for_each_evsel(evlist, pos)	\
 	for ((pos) = perf_evlist__next((evlist), NULL);	\
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index 4f966ddd5e53..2068e3d52227 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -27,6 +27,8 @@ LIBPERF_0.0.1 {
 		perf_evlist__delete;
 		perf_evlist__open;
 		perf_evlist__close;
+		perf_evlist__enable;
+		perf_evlist__disable;
 		perf_evlist__init;
 		perf_evlist__add;
 		perf_evlist__remove;
-- 
2.21.0

