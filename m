Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51740ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136ED222C5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824658;
	bh=XH1RaH3HUAbbdqX6CV+n02QX0DYMnwvq+SMO/sKZJ6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QPiXvzK7E1iJGufoXQaP4yPFz9OfYtiz/0FgDRyZPAYkZbdpNJmncTSuuaW2xph1n
	 p0J1OjKDuJbSLKDUbpvmGqJWm89784VQAWbHuKFid9yj2TpoV0Vdux4VCMa8gN7GOJ
	 iZvMtLgEImBct/ogPmBvwXUuWGx3iuRhFbq52D/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfJKUKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbfJKUKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:53 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D7CE222C1;
        Fri, 11 Oct 2019 20:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824652;
        bh=XH1RaH3HUAbbdqX6CV+n02QX0DYMnwvq+SMO/sKZJ6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VP8PIslO1i8JuNyxo2ad2kTIPE7FbTmkwcx+AuAUD6y3pSosl5z/3zvk/epEp/eGJ
         WnNfRwsL4c097RF0MSUPAkBKS7vhbv2VAWiPRYYU+c6mRCi4ZFT8wTPKnB7W786eKE
         z+/+6sdN43FAW73OGOfq928J/IGHLe6XZnPGwdH0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 52/69] libperf: Adopt perf_mmap__read_done() from tools/perf
Date:   Fri, 11 Oct 2019 17:05:42 -0300
Message-Id: <20191011200559.7156-53-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
index 6a0c3ff78e01..c90d925f7ae6 100644
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
index b6a8078dd446..4c087a8c9fed 100644
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
index 4a4bb7b20c39..1a54069ccd9c 100644
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
index cd69d68e7f1d..23116289f710 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3821,7 +3821,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 				draining = true;
 			}
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 
 	if (trace->nr_events == before) {
diff --git a/tools/perf/lib/include/perf/mmap.h b/tools/perf/lib/include/perf/mmap.h
index 646e9052b003..4f946e7f724b 100644
--- a/tools/perf/lib/include/perf/mmap.h
+++ b/tools/perf/lib/include/perf/mmap.h
@@ -8,5 +8,6 @@ struct perf_mmap;
 
 LIBPERF_API void perf_mmap__consume(struct perf_mmap *map);
 LIBPERF_API int perf_mmap__read_init(struct perf_mmap *map);
+LIBPERF_API void perf_mmap__read_done(struct perf_mmap *map);
 
 #endif /* __LIBPERF_MMAP_H */
diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
index bc3fbb213a3e..7e3ea2e9c917 100644
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
index fdbc6c550dea..97297cba44e3 100644
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
index ff3a986983ab..13e67cd213bd 100644
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
index 73d26c63d624..fd45529e29c1 100644
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
index cf992e0b27ff..9947cda29bad 100644
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
index e85da7e77269..e950907f6f57 100644
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
index 77f42f0ac15d..bb15d405a42c 100644
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
index d6a563120d93..c95eb1bbf396 100644
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
index 2587cb8b2c0f..92a53be3b32b 100644
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
index 808669507c30..ace20921ad55 100644
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
index bedfdec34972..8400fb17c170 100644
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
index 035d42375d4b..c6a13948821c 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -127,7 +127,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 		perf_mmap__consume(&md->core);
 	}
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 
 out_init:
 	if (!exited || !nr_exit) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d9a4a4b188ed..6e070ee9ad39 100644
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
index 59379118c2f1..2dedef9b06fd 100644
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
index 6d818ef51f05..0b15702be1a5 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -54,5 +54,4 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
-void perf_mmap__read_done(struct mmap *map);
 #endif /*__PERF_MMAP_H */
-- 
2.21.0

