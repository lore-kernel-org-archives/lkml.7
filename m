Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B5EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE58620C01
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406105AbfHIJ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:27:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405571AbfHIJ1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B5C4530027B5;
        Fri,  9 Aug 2019 09:27:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 152295D721;
        Fri,  9 Aug 2019 09:27:36 +0000 (UTC)
Date:   Fri, 9 Aug 2019 11:27:36 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] perf_sample_id::idx
Message-ID: <20190809092736.GA9377@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 09 Aug 2019 09:27:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
what's the perf_sample_id::idx for? It was added in here:
  3c659eedada2 perf tools: Add id index

but I dont see any practical usage of it in the sources,
when I remove it like below, I get clean build

any idea?

thanks,
jirka


---
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 70841d115349..24b90f68d616 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -498,7 +498,7 @@ struct tracing_data_event {
 
 struct id_index_entry {
 	u64 id;
-	u64 idx;
+	u64 idx; /* deprecated */
 	u64 cpu;
 	u64 tid;
 };
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c4489a1ad6bc..e55133cacb64 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -519,11 +519,11 @@ int perf_evlist__id_add_fd(struct evlist *evlist,
 }
 
 static void perf_evlist__set_sid_idx(struct evlist *evlist,
-				     struct evsel *evsel, int idx, int cpu,
+				     struct evsel *evsel, int cpu,
 				     int thread)
 {
 	struct perf_sample_id *sid = SID(evsel, cpu, thread);
-	sid->idx = idx;
+
 	if (evlist->core.cpus && cpu >= 0)
 		sid->cpu = evlist->core.cpus->map[cpu];
 	else
@@ -795,8 +795,7 @@ static int perf_evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 			if (perf_evlist__id_add_fd(evlist, evsel, cpu, thread,
 						   fd) < 0)
 				return -1;
-			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
-						 thread);
+			perf_evlist__set_sid_idx(evlist, evsel, cpu, thread);
 		}
 	}
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3cf35aa782b9..b9d864933d75 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -23,7 +23,6 @@ struct perf_sample_id {
 	struct hlist_node 	node;
 	u64		 	id;
 	struct evsel		*evsel;
-	int			idx;
 	int			cpu;
 	pid_t			tid;
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b9fe71d11bf6..2642d60aa875 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2394,7 +2394,6 @@ int perf_event__process_id_index(struct perf_session *session,
 		sid = perf_evlist__id2sid(evlist, e->id);
 		if (!sid)
 			return -ENOENT;
-		sid->idx = e->idx;
 		sid->cpu = e->cpu;
 		sid->tid = e->tid;
 	}
@@ -2454,7 +2453,7 @@ int perf_event__synthesize_id_index(struct perf_tool *tool,
 				return -ENOENT;
 			}
 
-			e->idx = sid->idx;
+			e->idx = -1;
 			e->cpu = sid->cpu;
 			e->tid = sid->tid;
 		}
