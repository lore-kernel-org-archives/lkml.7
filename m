Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18870C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61A82070B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455501;
	bh=HH6Gb0AJgHDcuK0vN7J9AdCGome4YsNM3lvpAxDSgB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1OW+fXIxDIZN7sr5ibWZZz0l2m/Vwg8IWTgM7froloFpm6LTBawJssgR3QApjIjCk
	 7Aw5kORE3my++WacxBx5vPAnn5lrEROWf6rYrDruVbMk+9x7bFyesqcKsegnKSBMl6
	 wHAa5wcaYNX6fccD6jMHl5Tfjx7Sq6rNgnUh6egA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731964AbfG3C6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731945AbfG3C6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:16 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47626217D4;
        Tue, 30 Jul 2019 02:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455494;
        bh=HH6Gb0AJgHDcuK0vN7J9AdCGome4YsNM3lvpAxDSgB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPDU2gNIEQM13heQ29I9b6KLa3JVMcj9AfG+CZ2P+ehZEv6l9uErg8+3Al7VDuaaB
         c7XWzIQQ05+YBgMREspFiWyKzCzFLF2FbutPvj+R6sQwsGnMQscJw5iFdvYTW3pYRG
         2b6+Oq2tzRpJhuniBpdsw8X8zhG4+PciEWbPtyRA=
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
Subject: [PATCH 036/107] perf evlist: Rename perf_evlist__delete() to evlist__delete()
Date:   Mon, 29 Jul 2019 23:54:59 -0300
Message-Id: <20190730025610.22603-37-acme@kernel.org>
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

Rename perf_evlist__delete() to evlist__delete(), so we don't have a
name clash when we add perf_evlist__delete() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/intel-cqm.c        |  2 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c |  2 +-
 tools/perf/builtin-ftrace.c                  |  2 +-
 tools/perf/builtin-kvm.c                     |  4 ++--
 tools/perf/builtin-record.c                  |  2 +-
 tools/perf/builtin-stat.c                    |  2 +-
 tools/perf/builtin-top.c                     |  2 +-
 tools/perf/builtin-trace.c                   |  2 +-
 tools/perf/tests/backward-ring-buffer.c      |  2 +-
 tools/perf/tests/bpf.c                       |  2 +-
 tools/perf/tests/code-reading.c              |  4 ++--
 tools/perf/tests/event-times.c               |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c      |  4 ++--
 tools/perf/tests/hists_cumulate.c            |  2 +-
 tools/perf/tests/hists_filter.c              |  2 +-
 tools/perf/tests/hists_link.c                |  2 +-
 tools/perf/tests/hists_output.c              |  2 +-
 tools/perf/tests/keep-tracking.c             |  2 +-
 tools/perf/tests/mmap-basic.c                |  2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  |  2 +-
 tools/perf/tests/parse-events.c              |  2 +-
 tools/perf/tests/parse-no-sample-id-all.c    |  2 +-
 tools/perf/tests/perf-record.c               |  2 +-
 tools/perf/tests/sw-clock.c                  |  2 +-
 tools/perf/tests/switch-tracking.c           |  2 +-
 tools/perf/tests/task-exit.c                 |  2 +-
 tools/perf/util/data-convert-bt.c            |  2 +-
 tools/perf/util/evlist.c                     | 12 ++++++------
 tools/perf/util/evlist.h                     |  2 +-
 tools/perf/util/header.c                     |  4 ++--
 tools/perf/util/parse-events.c               |  2 +-
 tools/perf/util/record.c                     |  4 ++--
 32 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/tools/perf/arch/x86/tests/intel-cqm.c b/tools/perf/arch/x86/tests/intel-cqm.c
index 8089a33c6c16..2a105e3b2ad1 100644
--- a/tools/perf/arch/x86/tests/intel-cqm.c
+++ b/tools/perf/arch/x86/tests/intel-cqm.c
@@ -124,6 +124,6 @@ int test__intel_cqm_count_nmi_context(struct test *test __maybe_unused, int subt
 	kill(pid, SIGKILL);
 	wait(NULL);
 out:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return err;
 }
diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index da9a3302d8e6..09b6cef76f5b 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -163,6 +163,6 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 	err = 0;
 
 out_err:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return err;
 }
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b8bdc593e5b8..105ef2a17a9c 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -508,7 +508,7 @@ int cmd_ftrace(int argc, const char **argv)
 	ret = __cmd_ftrace(&ftrace, argc, argv);
 
 out_delete_evlist:
-	perf_evlist__delete(ftrace.evlist);
+	evlist__delete(ftrace.evlist);
 
 out_delete_filters:
 	delete_filter_func(&ftrace.filters);
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index ee896b8a9fe8..8f54bdfb5743 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1325,7 +1325,7 @@ static struct evlist *kvm_live_event_list(void)
 
 out:
 	if (err) {
-		perf_evlist__delete(evlist);
+		evlist__delete(evlist);
 		evlist = NULL;
 	}
 
@@ -1460,7 +1460,7 @@ static int kvm_events_live(struct perf_kvm_stat *kvm,
 out:
 	perf_session__delete(kvm->session);
 	kvm->session = NULL;
-	perf_evlist__delete(kvm->evlist);
+	evlist__delete(kvm->evlist);
 
 	return err;
 }
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e8aa8a078dff..06966a2c2cdd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2449,7 +2449,7 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
-	perf_evlist__delete(rec->evlist);
+	evlist__delete(rec->evlist);
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 	return err;
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ee0dc8088ac0..d28d4d71d9b7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2015,7 +2015,7 @@ int cmd_stat(int argc, const char **argv)
 	if (smi_cost && smi_reset)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
 
-	perf_evlist__delete(evsel_list);
+	evlist__delete(evsel_list);
 
 	runtime_stat_delete(&stat_config);
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index e4b7146cd666..6c0c2b78093a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1661,7 +1661,7 @@ int cmd_top(int argc, const char **argv)
 		perf_evlist__stop_sb_thread(sb_evlist);
 
 out_delete_evlist:
-	perf_evlist__delete(top.evlist);
+	evlist__delete(top.evlist);
 	perf_session__delete(top.session);
 
 	return status;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 767b04eaaf45..e133204b3bb9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3498,7 +3498,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 out_delete_evlist:
 	trace__symbols__exit(trace);
 
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	cgroup__put(trace->cgroup);
 	trace->evlist = NULL;
 	trace->live = false;
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 3883b315b25b..ef3c6db2fae4 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -150,6 +150,6 @@ int test__backward_ring_buffer(struct test *test __maybe_unused, int subtest __m
 
 	ret = TEST_OK;
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return ret;
 }
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index d15f62dc4261..313ff1aadd9c 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -200,7 +200,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 	ret = TEST_OK;
 
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return ret;
 }
 
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index dd0325eabc25..1c7f092a7388 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -658,7 +658,7 @@ static int do_test_code_reading(bool try_kcore)
 				cpu_map__get(cpus);
 				thread_map__get(threads);
 				perf_evlist__set_maps(evlist, NULL, NULL);
-				perf_evlist__delete(evlist);
+				evlist__delete(evlist);
 				evlist = NULL;
 				continue;
 			}
@@ -703,7 +703,7 @@ static int do_test_code_reading(bool try_kcore)
 out_err:
 
 	if (evlist) {
-		perf_evlist__delete(evlist);
+		evlist__delete(evlist);
 	} else {
 		cpu_map__put(cpus);
 		thread_map__put(threads);
diff --git a/tools/perf/tests/event-times.c b/tools/perf/tests/event-times.c
index 8d3cf9792d9e..0f74ca103c41 100644
--- a/tools/perf/tests/event-times.c
+++ b/tools/perf/tests/event-times.c
@@ -204,7 +204,7 @@ static int test_times(int (attach)(struct evlist *),
 		 count.ena, count.run);
 
 out_err:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return !err ? TEST_OK : TEST_FAIL;
 }
 
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 74e79d6b7e96..5330f106a6ee 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -60,7 +60,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 		}
 	}
 
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return ret;
 }
 
@@ -91,7 +91,7 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 	}
 
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return err;
 }
 
diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
index 897e74b5ed1f..1f3de85ae18b 100644
--- a/tools/perf/tests/hists_cumulate.c
+++ b/tools/perf/tests/hists_cumulate.c
@@ -731,7 +731,7 @@ int test__hists_cumulate(struct test *test __maybe_unused, int subtest __maybe_u
 
 out:
 	/* tear down everything */
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	machines__exit(&machines);
 
 	return err;
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index b0468db74ca3..a274716fc438 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -321,7 +321,7 @@ int test__hists_filter(struct test *test __maybe_unused, int subtest __maybe_unu
 
 out:
 	/* tear down everything */
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	reset_output_field();
 	machines__exit(&machines);
 
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 878cb5bfbe78..b25383aa2e6e 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -334,7 +334,7 @@ int test__hists_link(struct test *test __maybe_unused, int subtest __maybe_unuse
 
 out:
 	/* tear down everything */
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	reset_output_field();
 	machines__exit(&machines);
 
diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
index 87a05e7afb7e..009888adf4b3 100644
--- a/tools/perf/tests/hists_output.c
+++ b/tools/perf/tests/hists_output.c
@@ -618,7 +618,7 @@ int test__hists_output(struct test *test __maybe_unused, int subtest __maybe_unu
 
 out:
 	/* tear down everything */
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	machines__exit(&machines);
 
 	return err;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 4c73377bfccb..cdc19bcc7523 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -147,7 +147,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 out_err:
 	if (evlist) {
 		perf_evlist__disable(evlist);
-		perf_evlist__delete(evlist);
+		evlist__delete(evlist);
 	} else {
 		cpu_map__put(cpus);
 		thread_map__put(threads);
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 8d1be34fd951..7f96bb72f7e5 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -151,7 +151,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 	}
 
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	cpus	= NULL;
 	threads = NULL;
 out_free_cpus:
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 141592437520..0263420f4495 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -134,7 +134,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 out_ok:
 	err = 0;
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 out:
 	return err;
 }
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 6e81a930b224..2365dd655c88 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1790,7 +1790,7 @@ static int test_event(struct evlist_test *e)
 		ret = e->check(evlist);
 	}
 
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 
 	return ret;
 }
diff --git a/tools/perf/tests/parse-no-sample-id-all.c b/tools/perf/tests/parse-no-sample-id-all.c
index fc0213246aaf..396e40d68922 100644
--- a/tools/perf/tests/parse-no-sample-id-all.c
+++ b/tools/perf/tests/parse-no-sample-id-all.c
@@ -46,7 +46,7 @@ static int process_events(union perf_event **events, size_t count)
 	for (i = 0; i < count && !err; i++)
 		err = process_event(&evlist, events[i]);
 
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 
 	return err;
 }
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 99b2d26881f9..779d5996428b 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -325,7 +325,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 		++errs;
 	}
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 out:
 	return (err < 0 || errs > 0) ? -1 : 0;
 }
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index 88a75cbae230..1c7d8adb43d0 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -128,7 +128,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 	cpu_map__put(cpus);
 	thread_map__put(threads);
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return err;
 }
 
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 89bc20b2178a..ac5da4fd222f 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -567,7 +567,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 out:
 	if (evlist) {
 		perf_evlist__disable(evlist);
-		perf_evlist__delete(evlist);
+		evlist__delete(evlist);
 	} else {
 		cpu_map__put(cpus);
 		thread_map__put(threads);
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 5c2cdb0ccb96..698ee5369c02 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -138,6 +138,6 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	cpu_map__put(cpus);
 	thread_map__put(threads);
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return err;
 }
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index 083101ae7b77..ca30bb25b3c5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1319,7 +1319,7 @@ static void cleanup_events(struct perf_session *session)
 		zfree(&evsel->priv);
 	}
 
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	session->evlist = NULL;
 }
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 317b2d64ba6d..9fa3663068b4 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -70,7 +70,7 @@ struct evlist *perf_evlist__new_default(void)
 	struct evlist *evlist = evlist__new();
 
 	if (evlist && perf_evlist__add_default(evlist)) {
-		perf_evlist__delete(evlist);
+		evlist__delete(evlist);
 		evlist = NULL;
 	}
 
@@ -82,7 +82,7 @@ struct evlist *perf_evlist__new_dummy(void)
 	struct evlist *evlist = evlist__new();
 
 	if (evlist && perf_evlist__add_dummy(evlist)) {
-		perf_evlist__delete(evlist);
+		evlist__delete(evlist);
 		evlist = NULL;
 	}
 
@@ -134,7 +134,7 @@ void perf_evlist__exit(struct evlist *evlist)
 	fdarray__exit(&evlist->pollfd);
 }
 
-void perf_evlist__delete(struct evlist *evlist)
+void evlist__delete(struct evlist *evlist)
 {
 	if (evlist == NULL)
 		return;
@@ -1859,7 +1859,7 @@ int perf_evlist__add_sb_event(struct evlist **evlist,
 
 out_err:
 	if (new_evlist) {
-		perf_evlist__delete(*evlist);
+		evlist__delete(*evlist);
 		*evlist = NULL;
 	}
 	return -1;
@@ -1938,7 +1938,7 @@ int perf_evlist__start_sb_thread(struct evlist *evlist,
 	return 0;
 
 out_delete_evlist:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	evlist = NULL;
 	return -1;
 }
@@ -1949,5 +1949,5 @@ void perf_evlist__stop_sb_thread(struct evlist *evlist)
 		return;
 	evlist->thread.done = 1;
 	pthread_join(evlist->thread.th, NULL);
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 }
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 60e1c9268e9e..12a5fd6972df 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -71,7 +71,7 @@ struct evlist *perf_evlist__new_dummy(void);
 void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		  struct perf_thread_map *threads);
 void perf_evlist__exit(struct evlist *evlist);
-void perf_evlist__delete(struct evlist *evlist);
+void evlist__delete(struct evlist *evlist);
 
 void perf_evlist__add(struct evlist *evlist, struct evsel *entry);
 void perf_evlist__remove(struct evlist *evlist, struct evsel *evsel);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 5b90786a8436..29bbfd699226 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3591,7 +3591,7 @@ int perf_session__read_header(struct perf_session *session)
 		evsel->needs_swap = header->needs_swap;
 		/*
 		 * Do it before so that if perf_evsel__alloc_id fails, this
-		 * entry gets purged too at perf_evlist__delete().
+		 * entry gets purged too at evlist__delete().
 		 */
 		perf_evlist__add(session->evlist, evsel);
 
@@ -3628,7 +3628,7 @@ int perf_session__read_header(struct perf_session *session)
 	return -errno;
 
 out_delete_evlist:
-	perf_evlist__delete(session->evlist);
+	evlist__delete(session->evlist);
 	session->evlist = NULL;
 	return -ENOMEM;
 }
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index d341b11fb141..6a4bfc7ab0c1 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1935,7 +1935,7 @@ int parse_events(struct evlist *evlist, const char *str,
 
 	/*
 	 * There are 2 users - builtin-record and builtin-test objects.
-	 * Both call perf_evlist__delete in case of error, so we dont
+	 * Both call evlist__delete in case of error, so we dont
 	 * need to bother.
 	 */
 	return ret;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index a23c69137dfc..9f8841548539 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -53,7 +53,7 @@ static int perf_do_probe_api(setup_probe_fn_t fn, int cpu, const char *str)
 	err = 0;
 
 out_delete:
-	perf_evlist__delete(evlist);
+	evlist__delete(evlist);
 	return err;
 }
 
@@ -299,7 +299,7 @@ bool perf_evlist__can_select_event(struct evlist *evlist, const char *str)
 	ret = true;
 
 out_delete:
-	perf_evlist__delete(temp_evlist);
+	evlist__delete(temp_evlist);
 	return ret;
 }
 
-- 
2.21.0

