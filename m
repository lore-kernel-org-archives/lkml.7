Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31524C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C47721848
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfJOFcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:32:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42061 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfJOFcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:04 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQy-00006h-35; Tue, 15 Oct 2019 07:31:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8AFA21C04CB;
        Tue, 15 Oct 2019 07:31:39 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:39 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Adopt perf_mmap__read_done() from tools/perf
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-12-jolsa@kernel.org>
References: <20191007125344.14268-12-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111749950.12254.17630839598670891545.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     32fdc2ca7e2ae8ae5d0ff660ca7783acd8ee6396
Gitweb:        https://git.kernel.org/tip/32fdc2ca7e2ae8ae5d0ff660ca7783acd8ee6396
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:19 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 11:45:32 -03:00

libperf: Adopt perf_mmap__read_done() from tools/perf

Move perf_mmap__read_init() from tools/perf to libperf and export it in
the perf/mmap.h header.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-kvm.c                     |  2 +-
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/lib/include/perf/mmap.h           |  1 +
 tools/perf/lib/libperf.map                   |  1 +
 tools/perf/lib/mmap.c                        | 17 +++++++++++++++++
 tools/perf/tests/backward-ring-buffer.c      |  2 +-
 tools/perf/tests/bpf.c                       |  2 +-
 tools/perf/tests/code-reading.c              |  2 +-
 tools/perf/tests/keep-tracking.c             |  2 +-
 tools/perf/tests/mmap-basic.c                |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  2 +-
 tools/perf/tests/perf-record.c               |  2 +-
 tools/perf/tests/sw-clock.c                  |  2 +-
 tools/perf/tests/switch-tracking.c           |  2 +-
 tools/perf/tests/task-exit.c                 |  2 +-
 tools/perf/util/evlist.c                     |  2 +-
 tools/perf/util/mmap.c                       | 17 -----------------
 tools/perf/util/mmap.h                       |  1 -
 20 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index 6a0c3ff..c90d925 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -142,7 +142,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 next_event:
 			perf_mmap__consume(&md->core);
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 
 	if (!comm1_time || !comm2_time)
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index b6a8078..4c087a8 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -794,7 +794,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 			break;
 	}
 
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 	return n;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 4a4bb7b..1a54069 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -894,7 +894,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		}
 	}
 
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 }
 
 static void perf_top__mmap_read(struct perf_top *top)
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index cd69d68..2311628 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3821,7 +3821,7 @@ again:
 				draining = true;
 			}
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 
 	if (trace->nr_events == before) {
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
index 646e905..4f946e7 100644
--- a/tools/perf/lib/include/perf/mmap.h
+++ b/tools/perf/lib/include/perf/mmap.h
@@ -8,5 +8,6 @@ struct perf_mmap;
 
 LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
 LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
+LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
 
 #endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index bc3fbb2..7e3ea2e 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -42,6 +42,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__poll;
 		perf_mmap__consume;
 		perf_mmap__read_init;
+		perf_mmap__read_done;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index fdbc6c5..97297cb 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -175,3 +175,20 @@ int perf_mmap__read_init(struct perf_mmap *map)
 
 	return __perf_mmap__read_init(map);
 }
+
+/*
+ * Mandatory for overwrite mode
+ * The direction of overwrite mode is backward.
+ * The last perf_mmap__read() will set tail to map->core.prev.
+ * Need to correct the map->core.prev to head which is the end of next read.
+ */
+void perf_mmap__read_done(struct perf_mmap *map)
+{
+	/*
+	 * Check if event was unmapped due to a POLLHUP/POLLERR.
+	 */
+	if (!refcount_read(&map->refcnt))
+		return;
+
+	map->prev = perf_mmap__read_head(map);
+}
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index ff3a986..13e67cd 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -54,7 +54,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 				return TEST_FAIL;
 			}
 		}
-		perf_mmap__read_done(map);
+		perf_mmap__read_done(&map->core);
 	}
 	return TEST_OK;
 }
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 73d26c6..fd45529 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -194,7 +194,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 			if (type == PERF_RECORD_SAMPLE)
 				count ++;
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 
 	if (count != expect) {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index cf992e0..9947cda 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -435,7 +435,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 			if (ret < 0)
 				return ret;
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 	return 0;
 }
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index e85da7e..e950907 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -49,7 +49,7 @@ static int find_comm(struct evlist *evlist, const char *comm)
 				found += 1;
 			perf_mmap__consume(&md->core);
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 	return found;
 }
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 77f42f0..bb15d40 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -142,7 +142,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		nr_events[evsel->idx]++;
 		perf_mmap__consume(&md->core);
 	}
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 
 out_init:
 	err = 0;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index d6a5631..c95eb1b 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -124,7 +124,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 				goto out_ok;
 			}
-			perf_mmap__read_done(md);
+			perf_mmap__read_done(&md->core);
 		}
 
 		if (nr_events == before)
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 2587cb8..92a53be 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -279,7 +279,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 
 				perf_mmap__consume(&md->core);
 			}
-			perf_mmap__read_done(md);
+			perf_mmap__read_done(&md->core);
 		}
 
 		/*
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 8086695..ace2092 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -120,7 +120,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 next_event:
 		perf_mmap__consume(&md->core);
 	}
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 
 out_init:
 	if ((u64) nr_samples == total_periods) {
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index bedfdec..8400fb1 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -280,7 +280,7 @@ static int process_events(struct evlist *evlist,
 			if (ret < 0)
 				goto out_free_nodes;
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 
 	events_array = calloc(cnt, sizeof(struct event_node));
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 035d423..c6a1394 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -127,7 +127,7 @@ retry:
 
 		perf_mmap__consume(&md->core);
 	}
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 
 out_init:
 	if (!exited || !nr_exit) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d9a4a4b..6e070ee 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1822,7 +1822,7 @@ static void *perf_evlist__poll_thread(void *arg)
 				perf_mmap__consume(&map->core);
 				got_data = true;
 			}
-			perf_mmap__read_done(map);
+			perf_mmap__read_done(&map->core);
 		}
 
 		if (draining && !got_data)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5937911..2dedef9 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -405,20 +405,3 @@ int perf_mmap__push(struct mmap *md, void *to,
 out:
 	return rc;
 }
-
-/*
- * Mandatory for overwrite mode
- * The direction of overwrite mode is backward.
- * The last perf_mmap__read() will set tail to map->core.prev.
- * Need to correct the map->core.prev to head which is the end of next read.
- */
-void perf_mmap__read_done(struct mmap *map)
-{
-	/*
-	 * Check if event was unmapped due to a POLLHUP/POLLERR.
-	 */
-	if (!refcount_read(&map->core.refcnt))
-		return;
-
-	map->core.prev = perf_mmap__read_head(&map->core);
-}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 6d818ef..0b15702 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -54,5 +54,4 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
-void perf_mmap__read_done(struct mmap *map);
 #endif /*__PERF_MMAP_H */
