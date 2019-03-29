Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BAB82184C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfC2UgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:36:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37773 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730054AbfC2UgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:36:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TKa34U3937631
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 13:36:04 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TKa3Zs3937603;
        Fri, 29 Mar 2019 13:36:03 -0700
Date:   Fri, 29 Mar 2019 13:36:03 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-dkvxxbeg7lu74155d4jhlmc9@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, ak@linux.intel.com,
        jolsa@kernel.org
Reply-To: ak@linux.intel.com, jolsa@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Fix max perf_event_attr.precise_ip
 detection
Git-Commit-ID: 4e8a5c1551370ebc0fbdb8f5c33dad13e45bdc99
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

Commit-ID:  4e8a5c1551370ebc0fbdb8f5c33dad13e45bdc99
Gitweb:     https://git.kernel.org/tip/4e8a5c1551370ebc0fbdb8f5c33dad13e45bdc99
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 14 Mar 2019 15:00:10 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 28 Mar 2019 14:31:56 -0300

perf evsel: Fix max perf_event_attr.precise_ip detection

After a discussion with Andi, move the perf_event_attr.precise_ip
detection for maximum precise config (via :P modifier or for default
cycles event) to perf_evsel__open().

The current detection in perf_event_attr__set_max_precise_ip() is
tricky, because precise_ip config is specific for given event and it
currently checks only hw cycles.

We now check for valid precise_ip value right after failing
sys_perf_event_open() for specific event, before any of the
perf_event_attr fallback code gets executed.

This way we get the proper config in perf_event_attr together with
allowed precise_ip settings.

We can see that code activity with -vv, like:

  $ perf record -vv ls
  ...
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    ...
    precise_ip                       3
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
  ------------------------------------------------------------
  sys_perf_event_open: pid 9926  cpu 0  group_fd -1  flags 0x8
  sys_perf_event_open failed, error -95
  decreasing precise_ip by one (2)
  ------------------------------------------------------------
  perf_event_attr:
    size                             112
    { sample_period, sample_freq }   4000
    ...
    precise_ip                       2
    sample_id_all                    1
    exclude_guest                    1
    mmap2                            1
    comm_exec                        1
    ksymbol                          1
  ------------------------------------------------------------
  sys_perf_event_open: pid 9926  cpu 0  group_fd -1  flags 0x8 = 4
  ...

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/n/tip-dkvxxbeg7lu74155d4jhlmc9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 29 -------------------
 tools/perf/util/evlist.h |  2 --
 tools/perf/util/evsel.c  | 72 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ec78e93085de..6689378ee577 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -231,35 +231,6 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
-{
-	struct perf_event_attr attr = {
-		.type		= PERF_TYPE_HARDWARE,
-		.config		= PERF_COUNT_HW_CPU_CYCLES,
-		.exclude_kernel	= 1,
-		.precise_ip	= 3,
-	};
-
-	event_attr_init(&attr);
-
-	/*
-	 * Unnamed union member, not supported as struct member named
-	 * initializer in older compilers such as gcc 4.4.7
-	 */
-	attr.sample_period = 1;
-
-	while (attr.precise_ip != 0) {
-		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
-		if (fd != -1) {
-			close(fd);
-			break;
-		}
-		--attr.precise_ip;
-	}
-
-	pattr->precise_ip = attr.precise_ip;
-}
-
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
 {
 	struct perf_evsel *evsel = perf_evsel__new_cycles(precise);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dcb68f34d2cd..6a94785b9100 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -315,8 +315,6 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
 				     struct perf_evsel *tracking_evsel);
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr);
-
 struct perf_evsel *
 perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 7835e05f0c0a..66d066f18b5b 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -295,7 +295,6 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 	if (!precise)
 		goto new_event;
 
-	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
@@ -305,6 +304,8 @@ new_event:
 	if (evsel == NULL)
 		goto out;
 
+	evsel->precise_max = true;
+
 	/* use asprintf() because free(evsel) assumes name is allocated */
 	if (asprintf(&evsel->name, "cycles%s%s%.*s",
 		     (attr.precise_ip || attr.exclude_kernel) ? ":" : "",
@@ -1083,7 +1084,7 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 	}
 
 	if (evsel->precise_max)
-		perf_event_attr__set_max_precise_ip(attr);
+		attr->precise_ip = 3;
 
 	if (opts->all_user) {
 		attr->exclude_kernel = 1;
@@ -1749,6 +1750,59 @@ static bool ignore_missing_thread(struct perf_evsel *evsel,
 	return true;
 }
 
+static void display_attr(struct perf_event_attr *attr)
+{
+	if (verbose >= 2) {
+		fprintf(stderr, "%.60s\n", graph_dotted_line);
+		fprintf(stderr, "perf_event_attr:\n");
+		perf_event_attr__fprintf(stderr, attr, __open_attr__fprintf, NULL);
+		fprintf(stderr, "%.60s\n", graph_dotted_line);
+	}
+}
+
+static int perf_event_open(struct perf_evsel *evsel,
+			   pid_t pid, int cpu, int group_fd,
+			   unsigned long flags)
+{
+	int precise_ip = evsel->attr.precise_ip;
+	int fd;
+
+	while (1) {
+		pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
+			  pid, cpu, group_fd, flags);
+
+		fd = sys_perf_event_open(&evsel->attr, pid, cpu, group_fd, flags);
+		if (fd >= 0)
+			break;
+
+		/*
+		 * Do quick precise_ip fallback if:
+		 *  - there is precise_ip set in perf_event_attr
+		 *  - maximum precise is requested
+		 *  - sys_perf_event_open failed with ENOTSUP error,
+		 *    which is associated with wrong precise_ip
+		 */
+		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
+			break;
+
+		/*
+		 * We tried all the precise_ip values, and it's
+		 * still failing, so leave it to standard fallback.
+		 */
+		if (!evsel->attr.precise_ip) {
+			evsel->attr.precise_ip = precise_ip;
+			break;
+		}
+
+		pr_debug2("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
+		evsel->attr.precise_ip--;
+		pr_debug2("decreasing precise_ip by one (%d)\n", evsel->attr.precise_ip);
+		display_attr(&evsel->attr);
+	}
+
+	return fd;
+}
+
 int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		     struct thread_map *threads)
 {
@@ -1824,12 +1878,7 @@ retry_sample_id:
 	if (perf_missing_features.sample_id_all)
 		evsel->attr.sample_id_all = 0;
 
-	if (verbose >= 2) {
-		fprintf(stderr, "%.60s\n", graph_dotted_line);
-		fprintf(stderr, "perf_event_attr:\n");
-		perf_event_attr__fprintf(stderr, &evsel->attr, __open_attr__fprintf, NULL);
-		fprintf(stderr, "%.60s\n", graph_dotted_line);
-	}
+	display_attr(&evsel->attr);
 
 	for (cpu = 0; cpu < cpus->nr; cpu++) {
 
@@ -1841,13 +1890,10 @@ retry_sample_id:
 
 			group_fd = get_group_fd(evsel, cpu, thread);
 retry_open:
-			pr_debug2("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
-				  pid, cpus->map[cpu], group_fd, flags);
-
 			test_attr__ready();
 
-			fd = sys_perf_event_open(&evsel->attr, pid, cpus->map[cpu],
-						 group_fd, flags);
+			fd = perf_event_open(evsel, pid, cpus->map[cpu],
+					     group_fd, flags);
 
 			FD(evsel, cpu, thread) = fd;
 
