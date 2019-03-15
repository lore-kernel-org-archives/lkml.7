Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26DBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F1402186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 12:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfCOMPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 08:15:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727441AbfCOMPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 08:15:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ACA1B30832D0;
        Fri, 15 Mar 2019 12:15:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1E31919C5A;
        Fri, 15 Mar 2019 12:15:47 +0000 (UTC)
Date:   Fri, 15 Mar 2019 13:15:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] perf tools: Move precise_ip detection into perf_evsel__open
Message-ID: <20190315121546.GB1400@krava>
References: <20190305152536.21035-1-jolsa@kernel.org>
 <20190305152536.21035-6-jolsa@kernel.org>
 <20190305161319.GC17272@tassilo.jf.intel.com>
 <20190305162854.GB4533@krava>
 <20190305164017.GD17272@tassilo.jf.intel.com>
 <20190307153500.GC29474@krava>
 <20190307165123.GE7535@tassilo.jf.intel.com>
 <20190314140124.GE4406@krava>
 <20190314154911.GE24002@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314154911.GE24002@tassilo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 15 Mar 2019 12:15:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 08:49:11AM -0700, Andi Kleen wrote:
> > > Still seems like a hack. Even though I don't know of a case that
> > > would break now. But it would be better to have the precise probing
> > > in the open retry loop, instead of trying to reinvent it here.
> > 
> > how about something like below?
> 
> Yes looks reasonable.

full patch attached,

jirka


---
After discussion with Andi, moving the precise_ip detection
for maximum precise config (via :P modifier or for default
cycles event) into perf_evsel__open code.

The current detection code in perf_event_attr__set_max_precise_ip
function is tricky, because precise_ip config is specific for
given event and it currently checks only hw cycles.

We now check for valid precise_ip value right after failing
sys_perf_event_open for specific event, before any of the
perf_event_attr fallback code gets executed. This way we get
the proper config in perf_event_attr together with allowed
precise_ip settings.

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
Link: http://lkml.kernel.org/n/tip-dkvxxbeg7lu74155d4jhlmc9@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evlist.c | 29 ----------------
 tools/perf/util/evlist.h |  2 --
 tools/perf/util/evsel.c  | 72 ++++++++++++++++++++++++++++++++--------
 3 files changed, 59 insertions(+), 44 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index ed20f4379956..3a243c249c29 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -230,35 +230,6 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
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
index 744906dd4887..cb15e3366eba 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -303,8 +303,6 @@ void perf_evlist__to_front(struct perf_evlist *evlist,
 void perf_evlist__set_tracking_event(struct perf_evlist *evlist,
 				     struct perf_evsel *tracking_evsel);
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr);
-
 struct perf_evsel *
 perf_evlist__find_evsel_by_str(struct perf_evlist *evlist, const char *str);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e979c0..f606e8a81f0e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -295,7 +295,6 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 	if (!precise)
 		goto new_event;
 
-	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
@@ -305,6 +304,8 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
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
@@ -1824,12 +1878,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
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
 
@@ -1841,13 +1890,10 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 
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
 
-- 
2.17.2

