Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97B2C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC2F206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfCIUI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:08:57 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49189 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCIUI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:08:56 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K8VPM3206101
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:08:31 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K8U4k3206098;
        Sat, 9 Mar 2019 12:08:30 -0800
Date:   Sat, 9 Mar 2019 12:08:30 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-5b61adb16599be04346e7e943c1b5113b57485ad@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        ravi.bangoria@linux.ibm.com, namhyung@kernel.org,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        jonas.rabenstein@studium.uni-erlangen.de, ak@linux.intel.com,
        nasastry@in.ibm.com, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org,
          jonas.rabenstein@studium.uni-erlangen.de, ak@linux.intel.com,
          tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
          nasastry@in.ibm.com, hpa@zytor.com, acme@redhat.com,
          alexander.shishkin@linux.intel.com, ravi.bangoria@linux.ibm.com,
          peterz@infradead.org, namhyung@kernel.org
In-Reply-To: <20190305152536.21035-7-jolsa@kernel.org>
References: <20190305152536.21035-7-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: Probe for precise_ip with simple attr
Git-Commit-ID: 5b61adb16599be04346e7e943c1b5113b57485ad
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

Commit-ID:  5b61adb16599be04346e7e943c1b5113b57485ad
Gitweb:     https://git.kernel.org/tip/5b61adb16599be04346e7e943c1b5113b57485ad
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Tue, 5 Mar 2019 16:25:34 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:19:45 -0300

perf evsel: Probe for precise_ip with simple attr

Currently we probe for precise_ip with user specified perf_event_attr,
which might fail because of unsupported kernel features, which would get
disabled during the open time anyway.

Switching the probe to take place on simple hw cycles, so the following
record sets proper precise_ip:

  # perf record -e cycles:P ls
  # perf evlist -v
  cycles:P: size: 112, ... precise_ip: 3, ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Cc: Nageswara R Sastry <nasastry@in.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190305152536.21035-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 25 ++++++++++++++++++++-----
 tools/perf/util/evsel.c  |  8 --------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 08cedb643ea6..ed20f4379956 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -230,18 +230,33 @@ void perf_evlist__set_leader(struct perf_evlist *evlist)
 	}
 }
 
-void perf_event_attr__set_max_precise_ip(struct perf_event_attr *attr)
+void perf_event_attr__set_max_precise_ip(struct perf_event_attr *pattr)
 {
-	attr->precise_ip = 3;
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_HARDWARE,
+		.config		= PERF_COUNT_HW_CPU_CYCLES,
+		.exclude_kernel	= 1,
+		.precise_ip	= 3,
+	};
 
-	while (attr->precise_ip != 0) {
-		int fd = sys_perf_event_open(attr, 0, -1, -1, 0);
+	event_attr_init(&attr);
+
+	/*
+	 * Unnamed union member, not supported as struct member named
+	 * initializer in older compilers such as gcc 4.4.7
+	 */
+	attr.sample_period = 1;
+
+	while (attr.precise_ip != 0) {
+		int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
 		if (fd != -1) {
 			close(fd);
 			break;
 		}
-		--attr->precise_ip;
+		--attr.precise_ip;
 	}
+
+	pattr->precise_ip = attr.precise_ip;
 }
 
 int __perf_evlist__add_default(struct perf_evlist *evlist, bool precise)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index dfe2958e6287..3bbf73e979c0 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -294,20 +294,12 @@ struct perf_evsel *perf_evsel__new_cycles(bool precise)
 
 	if (!precise)
 		goto new_event;
-	/*
-	 * Unnamed union member, not supported as struct member named
-	 * initializer in older compilers such as gcc 4.4.7
-	 *
-	 * Just for probing the precise_ip:
-	 */
-	attr.sample_period = 1;
 
 	perf_event_attr__set_max_precise_ip(&attr);
 	/*
 	 * Now let the usual logic to set up the perf_event_attr defaults
 	 * to kick in when we return and before perf_evsel__open() is called.
 	 */
-	attr.sample_period = 0;
 new_event:
 	evsel = perf_evsel__new(&attr);
 	if (evsel == NULL)
