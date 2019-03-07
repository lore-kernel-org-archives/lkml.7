Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8986C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D98720851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980833;
	bh=Zsk5wpMogtdqLIsFMSUdZXYdM0DspwZjplhycZtDCKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OTLB0LERPUSAulpsrhfC8FfAL4XnCvuFNiljdutbQ/zd7+AhZ7GSCp+RmsXXfEyW5
	 2H8wDiOoa8ZdW0Cs5LOKsz4frcYQWEUjVdPlLcfYsuBd/myexpGyYw7We9rUc3xNeq
	 w3cJNe5Nz9OVoNwNeT4Xfv7hRN+1HQND7fRo09+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfCGRrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbfCGRrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:47:09 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7AB6208E4;
        Thu,  7 Mar 2019 17:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980828;
        bh=Zsk5wpMogtdqLIsFMSUdZXYdM0DspwZjplhycZtDCKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HAqMWQ5qvpKfK2pLz4xxnSwPSKXl8JGpjyAJ+avQxFw1swIKAAJDZHTeSd86SOh0R
         S7QPJWdRZ8JRTD2+YmmEY8kBpxfx9rxOBlOvkmhKCrzNFj/jTKNyAo5ETpkOUq/R7g
         SkKJsfXOQEpMT0uD21LE521G5urIt+Nxv9gQ/Ixk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Nageswara R Sastry <nasastry@in.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 33/35] perf evsel: Probe for precise_ip with simple attr
Date:   Thu,  7 Mar 2019 14:44:31 -0300
Message-Id: <20190307174433.28819-34-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.20.1

