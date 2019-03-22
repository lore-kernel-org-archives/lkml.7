Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDBCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C570F21925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfCVWAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:00:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34625 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCVWAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:00:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MM0b5Q745226
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:00:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MM0a28745223;
        Fri, 22 Mar 2019 15:00:36 -0700
Date:   Fri, 22 Mar 2019 15:00:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-f8c856cb2c947f4fad0a2dff5e95cdcddb801303@git.kernel.org>
Cc:     namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        acme@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        mingo@kernel.org, jolsa@kernel.org
Reply-To: namhyung@kernel.org, hpa@zytor.com, acme@redhat.com,
          tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <20190305144758.12397-11-andi@firstfloor.org>
References: <20190305144758.12397-11-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf time-utils: Add utility function to print
 time stamps in nanoseconds
Git-Commit-ID: f8c856cb2c947f4fad0a2dff5e95cdcddb801303
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

Commit-ID:  f8c856cb2c947f4fad0a2dff5e95cdcddb801303
Gitweb:     https://git.kernel.org/tip/f8c856cb2c947f4fad0a2dff5e95cdcddb801303
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Tue, 5 Mar 2019 06:47:53 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 11 Mar 2019 11:56:02 -0300

perf time-utils: Add utility function to print time stamps in nanoseconds

Add a utility function to print nanosecond timestamps.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190305144758.12397-11-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 8 ++++++++
 tools/perf/util/time-utils.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 0f53baec660e..20663a460df3 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -453,6 +453,14 @@ int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz)
 	return scnprintf(buf, sz, "%"PRIu64".%06"PRIu64, sec, usec);
 }
 
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz)
+{
+	u64 sec  = timestamp / NSEC_PER_SEC,
+	    nsec = timestamp % NSEC_PER_SEC;
+
+	return scnprintf(buf, sz, "%" PRIu64 ".%09" PRIu64, sec, nsec);
+}
+
 int fetch_current_timestamp(char *buf, size_t sz)
 {
 	struct timeval tv;
diff --git a/tools/perf/util/time-utils.h b/tools/perf/util/time-utils.h
index b923de44e36f..72a42ea1d513 100644
--- a/tools/perf/util/time-utils.h
+++ b/tools/perf/util/time-utils.h
@@ -30,6 +30,7 @@ int perf_time__parse_for_ranges(const char *str, struct perf_session *session,
 				int *range_size, int *range_num);
 
 int timestamp__scnprintf_usec(u64 timestamp, char *buf, size_t sz);
+int timestamp__scnprintf_nsec(u64 timestamp, char *buf, size_t sz);
 
 int fetch_current_timestamp(char *buf, size_t sz);
 
