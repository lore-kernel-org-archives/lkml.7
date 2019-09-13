Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F53C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9D6206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381168;
	bh=JfkAvQkU8pHrGczlF3cY9zqBs/JoSO5IcHx0gjEyf1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WDtBeLAMjpK8j857jTjR+RwF6pxWSNi2Yeuo/1ufvBq5d9q9COKuA4Wo9C1Z4S997
	 8/nAPqt/7aCTfzfbWnMcfhQo21KgKnZkJRgFXDgWTJ/b9fn69Z9rejDM9jVRrngh8w
	 cNi2NCyhdJmSc0bM43pAZpR+lw0/II//Cg5euARc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391074AbfIMN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:26:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391490AbfIMN0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:26:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F125018C4260;
        Fri, 13 Sep 2019 13:26:00 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5502B5C1D4;
        Fri, 13 Sep 2019 13:25:59 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 50/73] libperf: Add perf_mmap__read_done function
Date:   Fri, 13 Sep 2019 15:23:32 +0200
Message-Id: <20190913132355.21634-51-jolsa@kernel.org>
In-Reply-To: <20190913132355.21634-1-jolsa@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.62]); Fri, 13 Sep 2019 13:26:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move perf_mmap__read_init function under libperf
and export it in perf/mmap.h header.

Link: http://lkml.kernel.org/n/tip-qc6p8q4t9dk7x1ik2a8yuf8z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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
index ca5e483c3fda..04da28d15039 100644
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
index ca7e48379f57..4b281d77d22c 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -790,7 +790,7 @@ static s64 perf_kvm__mmap_read_idx(struct perf_kvm_stat *kvm, int idx,
 			break;
 	}
 
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 	return n;
 }
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 86b7a71dc5ed..c122aa1e9ca1 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -890,7 +890,7 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		}
 	}
 
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 }
 
 static void perf_top__mmap_read(struct perf_top *top)
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fcdb30e93a81..1ae249d9ecf0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3467,7 +3467,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
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
index fba8cdfb3987..eca40c75b753 100644
--- a/tools/perf/lib/libperf.map
+++ b/tools/perf/lib/libperf.map
@@ -41,6 +41,7 @@ LIBPERF_0.0.1 {
 		perf_evlist__poll;
 		perf_mmap__consume;
 		perf_mmap__read_init;
+		perf_mmap__read_done;
 	local:
 		*;
 };
diff --git a/tools/perf/lib/mmap.c b/tools/perf/lib/mmap.c
index 15f91b976ce7..f27cb743183c 100644
--- a/tools/perf/lib/mmap.c
+++ b/tools/perf/lib/mmap.c
@@ -185,3 +185,20 @@ int perf_mmap__read_init(struct perf_mmap *map)
 
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
index 085e4d632be4..4b5625ac257c 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -53,7 +53,7 @@ static int count_samples(struct evlist *evlist, int *sample_count,
 				return TEST_FAIL;
 			}
 		}
-		perf_mmap__read_done(map);
+		perf_mmap__read_done(&map->core);
 	}
 	return TEST_OK;
 }
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index d7e328d2d1f2..a0b559c90f9b 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -193,7 +193,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 			if (type == PERF_RECORD_SAMPLE)
 				count ++;
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 
 	if (count != expect) {
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 3c5de881b43c..3306d75cb596 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -434,7 +434,7 @@ static int process_events(struct machine *machine, struct evlist *evlist,
 			if (ret < 0)
 				return ret;
 		}
-		perf_mmap__read_done(md);
+		perf_mmap__read_done(&md->core);
 	}
 	return 0;
 }
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 3cdee969958d..10ea5112b996 100644
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
index e9c1fbe5a9aa..65b84032ee13 100644
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
index 6c04753fe5f0..771d1671f1fe 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -123,7 +123,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 				goto out_ok;
 			}
-			perf_mmap__read_done(md);
+			perf_mmap__read_done(&md->core);
 		}
 
 		if (nr_events == before)
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 086cabb56db2..a0a2d9a49157 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -278,7 +278,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 
 				perf_mmap__consume(&md->core);
 			}
-			perf_mmap__read_done(md);
+			perf_mmap__read_done(&md->core);
 		}
 
 		/*
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 4b13d746f264..d2612960669f 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -119,7 +119,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 next_event:
 		perf_mmap__consume(&md->core);
 	}
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 
 out_init:
 	if ((u64) nr_samples == total_periods) {
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index f774b50f926e..e2beb68281e2 100644
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
index 6a1ca5d6dfdf..988739fcaf8d 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -126,7 +126,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 
 		perf_mmap__consume(&md->core);
 	}
-	perf_mmap__read_done(md);
+	perf_mmap__read_done(&md->core);
 
 out_init:
 	if (!exited || !nr_exit) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 38fd27f5bf0f..4f92b65e702c 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1765,7 +1765,7 @@ static void *perf_evlist__poll_thread(void *arg)
 				perf_mmap__consume(&map->core);
 				got_data = true;
 			}
-			perf_mmap__read_done(map);
+			perf_mmap__read_done(&map->core);
 		}
 
 		if (draining && !got_data)
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5913f7354232..5ede1d2c84b1 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -404,20 +404,3 @@ int perf_mmap__push(struct mmap *md, void *to,
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
index 3849bcbbe9ce..efc2392747ba 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -82,5 +82,4 @@ int perf_mmap__push(struct mmap *md, void *to,
 
 size_t mmap__mmap_len(struct mmap *map);
 
-void perf_mmap__read_done(struct mmap *map);
 #endif /*__PERF_MMAP_H */
-- 
2.21.0

