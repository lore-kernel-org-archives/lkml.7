Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8B5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40652084B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ew9GgHEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfFQTwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:52:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41467 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbfFQTwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:52:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJonZg3570374
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:50:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJonZg3570374
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560801049;
        bh=x6ysKUqtuQb0Ii5d1O6zddhkHnhBY6DoqjRb4tmqvn8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ew9GgHEg1FsXXcVs/9ReproNQuusF80tasxRip4ZiraoHb3DqPwrdndMTBQEfFH/s
         4cpfnuQiGoYNLCGp1NO+XejWjNwcZhgJ6Ev/q4pQhRjy2jb6LYx/SzJSPKPP9uWRB4
         yXMN2MZjQTpM7OeI+hwSboKBZzIGsJfXeXtjKcmH1oxbbb6t2OukG8y3azS28URuCQ
         U4hiZIyzJjHeGq6pnyHMViOKX9XaV+YBWwjBOYz8NvEavZoMvO+8qInMrSYftylrbd
         I9WOH7FSzVEeZmknpItWmZ0lK5sSIiQgPUDYXTk3sESYrQvTP61UzWydxYwf1n6itP
         NRiOG7txBn6OQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJonxW3570371;
        Mon, 17 Jun 2019 12:50:49 -0700
Date:   Mon, 17 Jun 2019 12:50:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-a77a05e2337df1347f4de96bfa313db7008fe8bd@git.kernel.org>
Cc:     jolsa@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
        acme@redhat.com, yao.jin@linux.intel.com
Reply-To: yao.jin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
          adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@redhat.com
In-Reply-To: <20190604130017.31207-20-adrian.hunter@intel.com>
References: <20190604130017.31207-20-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf time-utils: Add support for multiple explicit
 time intervals
Git-Commit-ID: a77a05e2337df1347f4de96bfa313db7008fe8bd
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

Commit-ID:  a77a05e2337df1347f4de96bfa313db7008fe8bd
Gitweb:     https://git.kernel.org/tip/a77a05e2337df1347f4de96bfa313db7008fe8bd
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 4 Jun 2019 16:00:17 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 16:20:13 -0300

perf time-utils: Add support for multiple explicit time intervals

Currently only a single explicit time range is accepted. Add support for
multiple ranges separated by spaces, which requires the string to be
quoted. Update the time utils test accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-20-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-diff.txt   |  8 ++--
 tools/perf/Documentation/perf-report.txt |  3 +-
 tools/perf/Documentation/perf-script.txt |  3 +-
 tools/perf/tests/time-utils-test.c       | 17 ++++++++
 tools/perf/util/time-utils.c             | 74 +++++++++++++++++++++++++++++---
 5 files changed, 94 insertions(+), 11 deletions(-)

diff --git a/tools/perf/Documentation/perf-diff.txt b/tools/perf/Documentation/perf-diff.txt
index 5732f69580ab..facd91e4e945 100644
--- a/tools/perf/Documentation/perf-diff.txt
+++ b/tools/perf/Documentation/perf-diff.txt
@@ -145,9 +145,11 @@ OPTIONS
 	<start>,<stop>. Times have the format seconds.nanoseconds. If 'start'
 	is not given (i.e. time string is ',x.y') then analysis starts at
 	the beginning of the file. If stop time is not given (i.e. time
-	string is 'x.y,') then analysis goes to the end of the file. Time string is
-	'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps for different
-	perf.data files.
+	string is 'x.y,') then analysis goes to the end of the file.
+	Multiple ranges can be separated by spaces, which requires the argument
+	to be quoted e.g. --time "1234.567,1234.789 1235,"
+	Time string is'a1.b1,c1.d1:a2.b2,c2.d2'. Use ':' to separate timestamps
+	for different perf.data files.
 
 	For example, we get the timestamp information from 'perf script'.
 
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 3de029f6881d..8c4372819e11 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -415,7 +415,8 @@ OPTIONS
 	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
 	stop time is not given (i.e. time string is 'x.y,') then analysis goes
-	to end of file.
+	to end of file. Multiple ranges can be separated by spaces, which
+	requires the argument to be quoted e.g. --time "1234.567,1234.789 1235,"
 
 	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 878349cce968..d4e2e18a5881 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -364,7 +364,8 @@ include::itrace.txt[]
 	have the format seconds.nanoseconds. If start is not given (i.e. time
 	string is ',x.y') then analysis starts at the beginning of the file. If
 	stop time is not given (i.e. time string is 'x.y,') then analysis goes
-	to end of file.
+	to end of file. Multiple ranges can be separated by spaces, which
+	requires the argument to be quoted e.g. --time "1234.567,1234.789 1235,"
 
 	Also support time percent with multiple time ranges. Time string is
 	'a%/n,b%/m,...' or 'a%-b%,c%-%d,...'.
diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-utils-test.c
index 7504046b111c..4f53006233a1 100644
--- a/tools/perf/tests/time-utils-test.c
+++ b/tools/perf/tests/time-utils-test.c
@@ -168,6 +168,23 @@ int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
 		pass &= test__perf_time__parse_for_ranges(&d);
 	}
 
+	{
+		u64 b = 1234567123456789ULL;
+		u64 c = 7654321987654321ULL;
+		u64 e = 8000000000000000ULL;
+		struct test_data d = {
+			.str   = "1234567.123456789,1234567.123456790 "
+				 "7654321.987654321,7654321.987654444 "
+				 "8000000,8000000.000000005",
+			.ptime = { {b, b + 1}, {c, c + 123}, {e, e + 5}, },
+			.num = 3,
+			.skip = { b - 1, b + 2, c - 1, c + 124, e - 1, e + 6 },
+			.noskip = { b, b + 1, c, c + 123, e, e + 5 },
+		};
+
+		pass &= test__perf_time__parse_for_ranges(&d);
+	}
+
 	{
 		u64 b = 7654321ULL * NSEC_PER_SEC;
 		struct test_data d = {
diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index d942840356e3..2b48816a2d2e 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include <inttypes.h>
 #include <math.h>
+#include <ctype.h>
 
 #include "perf.h"
 #include "debug.h"
@@ -116,6 +117,69 @@ int perf_time__parse_str(struct perf_time_interval *ptime, const char *ostr)
 	return rc;
 }
 
+static int perf_time__parse_strs(struct perf_time_interval *ptime,
+				 const char *ostr, int size)
+{
+	const char *cp;
+	char *str, *arg, *p;
+	int i, num = 0, rc = 0;
+
+	/* Count the commas */
+	for (cp = ostr; *cp; cp++)
+		num += !!(*cp == ',');
+
+	if (!num)
+		return -EINVAL;
+
+	BUG_ON(num > size);
+
+	str = strdup(ostr);
+	if (!str)
+		return -ENOMEM;
+
+	/* Split the string and parse each piece, except the last */
+	for (i = 0, p = str; i < num - 1; i++) {
+		arg = p;
+		/* Find next comma, there must be one */
+		p = strchr(p, ',') + 1;
+		/* Skip white space */
+		while (isspace(*p))
+			p++;
+		/* Skip the value, must not contain space or comma */
+		while (*p && !isspace(*p)) {
+			if (*p++ == ',') {
+				rc = -EINVAL;
+				goto out;
+			}
+		}
+		/* Split and parse */
+		if (*p)
+			*p++ = 0;
+		rc = perf_time__parse_str(ptime + i, arg);
+		if (rc < 0)
+			goto out;
+	}
+
+	/* Parse the last piece */
+	rc = perf_time__parse_str(ptime + i, p);
+	if (rc < 0)
+		goto out;
+
+	/* Check there is no overlap */
+	for (i = 0; i < num - 1; i++) {
+		if (ptime[i].end >= ptime[i + 1].start) {
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
+	rc = num;
+out:
+	free(str);
+
+	return rc;
+}
+
 static int parse_percent(double *pcnt, char *str)
 {
 	char *c, *endptr;
@@ -424,15 +488,13 @@ int perf_time__parse_for_ranges(const char *time_str,
 				time_str,
 				session->evlist->first_sample_time,
 				session->evlist->last_sample_time);
-
-		if (num < 0)
-			goto error_invalid;
 	} else {
-		if (perf_time__parse_str(ptime_range, time_str))
-			goto error_invalid;
-		num = 1;
+		num = perf_time__parse_strs(ptime_range, time_str, size);
 	}
 
+	if (num < 0)
+		goto error_invalid;
+
 	*range_size = size;
 	*range_num = num;
 	*ranges = ptime_range;
