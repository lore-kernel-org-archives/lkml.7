Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB5EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9CE206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="osHYWiJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfG3Sk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:40:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48829 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfG3Sk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:40:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UIeFR93332237
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:40:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UIeFR93332237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564512016;
        bh=aNj8LBRLVy6o+TvdiqsVMBtoCnmVmmPuApNYdp+U8kA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=osHYWiJLar8jGXxA3qcxj68WgUFMM1oVKbggoxrLXuH6HENhFInpaOy8zaEMgS7B7
         R6kk0+HCb6iRO97wbjJk7SnQydpj5axQ4we/33+CU0Ck86uuNbSBT14dgnhzLI2KRL
         g5vF5byNuaKTMmpBlKcvzsVwJttBf2i7RW96C3ocGqZyjyIhmsvDdtPsQlrhbr2UPz
         tw411UV4ElJuCGXCAbkjO73y4Th+pOBor0lAZly/PkA+3q4jZ9I2kQvZe4DgQUca4T
         BELZ1shOd8Lb7410EY99FluDE0Aq2e5wJ1vTHXuQDf3GSaOYsLxtdZ5Niab4jI1Z0a
         3uDFLAGLhZmrg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UIeFsx3332233;
        Tue, 30 Jul 2019 11:40:15 -0700
Date:   Tue, 30 Jul 2019 11:40:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-93bce7e5bfcd570e9250c974b5c2c91d6b8332ef@git.kernel.org>
Cc:     alexey.budankov@linux.intel.com, tglx@linutronix.de,
        ak@linux.intel.com, peterz@infradead.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com, jolsa@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com,
        mingo@kernel.org, namhyung@kernel.org
Reply-To: ak@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
          tglx@linutronix.de, alexey.budankov@linux.intel.com,
          acme@redhat.com, alexander.shishkin@linux.intel.com,
          jolsa@kernel.org, mpetlan@redhat.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          mingo@kernel.org
In-Reply-To: <20190721112506.12306-45-jolsa@kernel.org>
References: <20190721112506.12306-45-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] libperf: Move zalloc.o into libperf
Git-Commit-ID: 93bce7e5bfcd570e9250c974b5c2c91d6b8332ef
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

Commit-ID:  93bce7e5bfcd570e9250c974b5c2c91d6b8332ef
Gitweb:     https://git.kernel.org/tip/93bce7e5bfcd570e9250c974b5c2c91d6b8332ef
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Sun, 21 Jul 2019 13:24:31 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:45 -0300

libperf: Move zalloc.o into libperf

We need it in both perf and libperf, thus moving it to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-45-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/Build               | 5 +++++
 tools/perf/util/Build              | 5 -----
 tools/perf/util/python-ext-sources | 1 -
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/lib/Build b/tools/perf/lib/Build
index b27c1543b046..faf64db13e37 100644
--- a/tools/perf/lib/Build
+++ b/tools/perf/lib/Build
@@ -3,3 +3,8 @@ libperf-y += cpumap.o
 libperf-y += threadmap.o
 libperf-y += evsel.o
 libperf-y += evlist.o
+libperf-y += zalloc.o
+
+$(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 14f812bb07a7..08f670d21615 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -26,7 +26,6 @@ perf-y += rbtree.o
 perf-y += libstring.o
 perf-y += bitmap.o
 perf-y += hweight.o
-perf-y += zalloc.o
 perf-y += smt.o
 perf-y += strbuf.o
 perf-y += string.o
@@ -243,7 +242,3 @@ $(OUTPUT)util/hweight.o: ../lib/hweight.c FORCE
 $(OUTPUT)util/vsprintf.o: ../lib/vsprintf.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
-
-$(OUTPUT)util/zalloc.o: ../lib/zalloc.c FORCE
-	$(call rule_mkdir)
-	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index ceb8afdf9a89..2237bac9fadb 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -18,7 +18,6 @@ util/namespaces.c
 ../lib/hweight.c
 ../lib/string.c
 ../lib/vsprintf.c
-../lib/zalloc.c
 util/thread_map.c
 util/util.c
 util/xyarray.c
