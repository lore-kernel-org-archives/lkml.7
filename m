Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364FDC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F0F20679
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Mv/Wi5/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388487AbfG3S7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:59:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47959 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388059AbfG3S7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:59:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIxJkR3337266
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:59:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIxJkR3337266
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564513160;
        bh=7My4pYYk36bmJGws44d7BYqHZJEKGEcNiUvLKUVB70I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Mv/Wi5/1Q9ClCy2UfS5nnUSqHIjRhlC5IuVuYcGBAxmTDXWlBOANCftKUPYVuMiAX
         QxvqNWhA0hUw/vOesydviE33Vuvr5VebyS+VsX74Vpeze8hGAgIHs8Owe4gsXAxQMX
         5mxSWsW0iExWgqF63Cg0QzTSGLSGVDFnx5+XUQZVwzD4CLQPqj/TF8V4PyeGNWm8e+
         VPeVYZJZKsdC+8xpqBuq0GDLw7LysTYaziT0rQzlrM87q2MaNR8rJtG2mYuGNPHKFI
         dRatLcvTQ4WbARrcnyd/0KAFTIWGtBz9sY1aeJhlzRRTPlzyotJ9fcZpneDhtVVpNa
         YKNDpxQIo030g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIxIqA3337263;
        Tue, 30 Jul 2019 11:59:19 -0700
Date:   Tue, 30 Jul 2019 11:59:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-fcc97c3e7a9d6fd3fda7674f52fb005f4e8453e7@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, acme@redhat.com,
        ak@linux.intel.com, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
        mpetlan@redhat.com, hpa@zytor.com, peterz@infradead.org
Reply-To: namhyung@kernel.org, hpa@zytor.com, mpetlan@redhat.com,
          peterz@infradead.org, acme@redhat.com,
          alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org,
          ak@linux.intel.com, alexander.shishkin@linux.intel.com,
          mingo@kernel.org, tglx@linutronix.de, jolsa@kernel.org
In-Reply-To: <20190721112506.12306-70-jolsa@kernel.org>
References: <20190721112506.12306-70-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Adopt perf_evlist__enable()/disable()
 functions from perf
Git-Commit-ID: fcc97c3e7a9d6fd3fda7674f52fb005f4e8453e7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fcc97c3e7a9d6fd3fda7674f52fb005f4e8453e7
Gitweb:     https://git.kernel.org/tip/fcc97c3e7a9d6fd3fda7674f52fb005f4e8453e7
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:56 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:46 -0300

libperf: Adopt perf_evlist__enable()/disable() functions from perf

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
