Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D15C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011F021726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455514;
	bh=/qOO9NqGbyDDZnrAM2X93K240F+h9kLKAKeAyhyTTvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YwOyV6+Sg1XkkKs2y10u2gWo4NevD1MoY9lRGvjqEcyRZKsDe0cK1ehmoMjP3kbru
	 KYOjkqBz+AJWdVv5mTB13gTGe21sUocp75h5j3Q21kgbpcAt73CJFveSV3zxzfFWnp
	 46+sIdNnpRMhLLi+KwQCJbiyMjMK3iNP0MSbcmAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbfG3C6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732001AbfG3C63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63F55206DD;
        Tue, 30 Jul 2019 02:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455508;
        bh=/qOO9NqGbyDDZnrAM2X93K240F+h9kLKAKeAyhyTTvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VMA8yVpz0lYDhAsUlpVvoYFfVZHJX3pAtBp6lJL2vdfxdR65zgN1KrSu1LvDEc8FP
         /kbJ/lj+lj2mMae9IG+qz9Rb/GChh6h3m+9ENWhgoCHO2aWmekx/DJ4W+wYFK2N5rV
         mbNSzU4b/dN/gqwB8YHlL346/C44NabzgKTVZBXk=
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
Subject: [PATCH 040/107] perf evlist: Rename perf_evlist__remove() to evlist__remove()
Date:   Mon, 29 Jul 2019 23:55:03 -0300
Message-Id: <20190730025610.22603-41-acme@kernel.org>
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

Rename perf_evlist__remove() to evlist__remove(), so we don't have a
name clash when we add perf_evlist__remove() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 4 ++--
 tools/perf/util/evlist.c    | 2 +-
 tools/perf/util/evlist.h    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 917c8fb4baa5..4e56e399bbc8 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -622,7 +622,7 @@ static void strip_fini(struct perf_inject *inject)
 		if (evsel->handler == drop_sample &&
 		    ok_to_remove(evlist, evsel)) {
 			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			perf_evlist__remove(evlist, evsel);
+			evlist__remove(evlist, evsel);
 			evsel__delete(evsel);
 		}
 	}
@@ -724,7 +724,7 @@ static int __cmd_inject(struct perf_inject *inject)
 			if (evsel) {
 				pr_debug("Deleting %s\n",
 					 perf_evsel__name(evsel));
-				perf_evlist__remove(session->evlist, evsel);
+				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
 			if (inject->strip)
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 7741e12bdcb0..47516db62424 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -190,7 +190,7 @@ void evlist__add(struct evlist *evlist, struct evsel *entry)
 	__perf_evlist__propagate_maps(evlist, entry);
 }
 
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel)
+void evlist__remove(struct evlist *evlist, struct evsel *evsel)
 {
 	evsel->evlist = NULL;
 	list_del_init(&evsel->node);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index d52b29a1d852..b3a44e2eed08 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -74,7 +74,7 @@ void perf_evlist__exit(struct evlist *evlist);
 void evlist__delete(struct evlist *evlist);
 
 void evlist__add(struct evlist *evlist, struct evsel *entry);
-void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
+void evlist__remove(struct evlist *evlist, struct evsel *evsel);
 
 int __perf_evlist__add_default(struct evlist *evlist, bool precise);
 
-- 
2.21.0

