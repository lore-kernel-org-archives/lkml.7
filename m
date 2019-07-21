Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8566C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CD92147A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563708748;
	bh=MmHMV1xTEk03l5AM3vtzhUoEBKn5BniBnM4ZOyLouNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iyu6Cfb4aLc0T/0v/VG5Nqp1diHTJBtqj+/aRc622j14HRwVIGSBh27OKl/oc5L0V
	 jHHQKJjILOaHTl6+ePOwV1oo0fDfbr7MZgUgBG7YfNB2Y5sQqNEjHnHU8CVvh/W2sB
	 Cn+pyYhmEhbeWHdrSkWPBOh2C3KTKzaAb3qwOJ6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfGULc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 07:32:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbfGULc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 07:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0BDB53082B5F;
        Sun, 21 Jul 2019 11:32:27 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-23.brq.redhat.com [10.40.204.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D9975D9D3;
        Sun, 21 Jul 2019 11:32:22 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 69/79] libperf: Add perf_evlist__enable/disable functions
Date:   Sun, 21 Jul 2019 13:24:56 +0200
Message-Id: <20190721112506.12306-70-jolsa@kernel.org>
In-Reply-To: <20190721112506.12306-1-jolsa@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Sun, 21 Jul 2019 11:32:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moving following functions:
  perf_evlist__enable
  perf_evlist__disable

Link: http://lkml.kernel.org/n/tip-9icfpf3v1etadp53io13b8ga@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/lib/evlist.c              | 16 ++++++++++++++++
 tools/perf/lib/include/perf/evlist.h |  2 ++
 tools/perf/lib/libperf.map           |  2 ++
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 044f664e0733..18e30d96f832 100644
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

