Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D794C7618E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 287AA2070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455503;
	bh=vPWMhHXvEIp1f8rQvEUp8WfA0fBqdzfIM/0CpCB+daw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsZr+ydD9Qi+3Z+oY+5outi1poTwQKF8flZ3PpWlkO9UD1HvZw5vEB9rKRIAUtFtz
	 EO3yUhYiwi+HZgUm9Kh2h0kpuzD/d8RnGbtnQ3kcZH/PGMXJEt3jxTqpO0Zxtj2RmV
	 jVfvoN5jCj2RloJMFNU8KSPYTaH15su19KLG6RXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbfG3C6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731959AbfG3C6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA071216C8;
        Tue, 30 Jul 2019 02:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455497;
        bh=vPWMhHXvEIp1f8rQvEUp8WfA0fBqdzfIM/0CpCB+daw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDkeETxTLpOy2qp0odzCogofa4r9yE7k8kcqd9U8ZfRBXopG2wJxfGqwu39/cBHNj
         /+lRlkBDd5F0V6qVML1gl7qWaSY4w3X3C8rnHQ2l4wcVmx2S7wUczz3+H1CWEtmurB
         275U70XXtgDR9rT3ad3bj/pUGIpL6BfWo/vK+ltI=
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
Subject: [PATCH 037/107] perf evsel: Rename perf_evsel__delete() to evsel__delete()
Date:   Mon, 29 Jul 2019 23:55:00 -0300
Message-Id: <20190730025610.22603-38-acme@kernel.org>
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

Remame perf_evsel__delete() to evsel__delete(), so we don't have a name
clash when we add perf_evsel__delete() in libperf.

Also renaming perf_evsel__delete_priv() to evsel__delete_priv().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c                |  4 ++--
 tools/perf/builtin-trace.c                 | 12 ++++++------
 tools/perf/tests/evsel-tp-sched.c          |  4 ++--
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/util/evlist.c                   |  4 ++--
 tools/perf/util/evsel.c                    |  4 ++--
 tools/perf/util/evsel.h                    |  2 +-
 tools/perf/util/parse-events.c             |  4 ++--
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index d2131fc863be..917c8fb4baa5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -623,7 +623,7 @@ static void strip_fini(struct perf_inject *inject)
 		    ok_to_remove(evlist, evsel)) {
 			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
 			perf_evlist__remove(evlist, evsel);
-			perf_evsel__delete(evsel);
+			evsel__delete(evsel);
 		}
 	}
 }
@@ -725,7 +725,7 @@ static int __cmd_inject(struct perf_inject *inject)
 				pr_debug("Deleting %s\n",
 					 perf_evsel__name(evsel));
 				perf_evlist__remove(session->evlist, evsel);
-				perf_evsel__delete(evsel);
+				evsel__delete(evsel);
 			}
 			if (inject->strip)
 				strip_fini(inject);
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index e133204b3bb9..0f7d1859a2d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -274,10 +274,10 @@ static int perf_evsel__init_tp_ptr_field(struct evsel *evsel,
 	({ struct syscall_tp *sc = evsel->priv;\
 	   perf_evsel__init_tp_ptr_field(evsel, &sc->name, #name); })
 
-static void perf_evsel__delete_priv(struct evsel *evsel)
+static void evsel__delete_priv(struct evsel *evsel)
 {
 	zfree(&evsel->priv);
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 }
 
 static int perf_evsel__init_syscall_tp(struct evsel *evsel)
@@ -368,7 +368,7 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
 	return evsel;
 
 out_delete:
-	perf_evsel__delete_priv(evsel);
+	evsel__delete_priv(evsel);
 	return NULL;
 }
 
@@ -2638,7 +2638,7 @@ static bool perf_evlist__add_vfs_getname(struct evlist *evlist)
 
 		list_del_init(&evsel->node);
 		evsel->evlist = NULL;
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	}
 
 	return found;
@@ -2739,9 +2739,9 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	return ret;
 
 out_delete_sys_exit:
-	perf_evsel__delete_priv(sys_exit);
+	evsel__delete_priv(sys_exit);
 out_delete_sys_enter:
-	perf_evsel__delete_priv(sys_enter);
+	evsel__delete_priv(sys_enter);
 	goto out;
 }
 
diff --git a/tools/perf/tests/evsel-tp-sched.c b/tools/perf/tests/evsel-tp-sched.c
index 0170e9d2e329..261e6eaaee99 100644
--- a/tools/perf/tests/evsel-tp-sched.c
+++ b/tools/perf/tests/evsel-tp-sched.c
@@ -64,7 +64,7 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "next_prio", 4, true))
 		ret = -1;
 
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 
 	evsel = perf_evsel__newtp("sched", "sched_wakeup");
 
@@ -85,6 +85,6 @@ int test__perf_evsel__tp_sched_test(struct test *test __maybe_unused, int subtes
 	if (perf_evsel__test_field(evsel, "target_cpu", 4, true))
 		ret = -1;
 
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 	return ret;
 }
diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 4bf73896695a..001a0e8e6998 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -118,7 +118,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 out_close_fd:
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 out_cpu_map_delete:
 	cpu_map__put(cpus);
 out_thread_map_delete:
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index f3efadd05863..20e353fbfdd0 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -59,7 +59,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 out_close_fd:
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9fa3663068b4..986d20c15778 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -121,7 +121,7 @@ static void perf_evlist__purge(struct evlist *evlist)
 	evlist__for_each_entry_safe(evlist, n, pos) {
 		list_del_init(&pos->node);
 		pos->evlist = NULL;
-		perf_evsel__delete(pos);
+		evsel__delete(pos);
 	}
 
 	evlist->nr_entries = 0;
@@ -277,7 +277,7 @@ static int perf_evlist__add_attrs(struct evlist *evlist,
 
 out_delete_partial_list:
 	__evlist__for_each_entry_safe(&head, n, evsel)
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	return -1;
 }
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 97bee83f0f98..de379b63f1ce 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -316,7 +316,7 @@ struct evsel *perf_evsel__new_cycles(bool precise)
 out:
 	return evsel;
 error_free:
-	perf_evsel__delete(evsel);
+	evsel__delete(evsel);
 	evsel = NULL;
 	goto out;
 }
@@ -1333,7 +1333,7 @@ void perf_evsel__exit(struct evsel *evsel)
 	perf_evsel__object.fini(evsel);
 }
 
-void perf_evsel__delete(struct evsel *evsel)
+void evsel__delete(struct evsel *evsel)
 {
 	perf_evsel__exit(evsel);
 	free(evsel);
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index af230d92fbef..20b4e31b63a9 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -240,7 +240,7 @@ struct tep_event *event_format__new(const char *sys, const char *name);
 
 void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void perf_evsel__exit(struct evsel *evsel);
-void perf_evsel__delete(struct evsel *evsel);
+void evsel__delete(struct evsel *evsel);
 
 struct callchain_param;
 
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6a4bfc7ab0c1..cc63367f6e45 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -662,7 +662,7 @@ static int add_bpf_event(const char *group, const char *event, int fd, struct bp
 			 group, event);
 		list_for_each_entry_safe(evsel, tmp, &new_evsels, node) {
 			list_del_init(&evsel->node);
-			perf_evsel__delete(evsel);
+			evsel__delete(evsel);
 		}
 		return err;
 	}
@@ -2334,7 +2334,7 @@ static bool is_event_supported(u8 type, unsigned config)
 			evsel->attr.exclude_kernel = 1;
 			ret = perf_evsel__open(evsel, NULL, tmap) >= 0;
 		}
-		perf_evsel__delete(evsel);
+		evsel__delete(evsel);
 	}
 
 	thread_map__put(tmap);
-- 
2.21.0

