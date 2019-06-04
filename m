Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D45C28CC3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C78E24929
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfFDNCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:02:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:5114 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbfFDNCX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:02:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 06:02:22 -0700
X-ExtLoop1: 1
Received: from ahunter-desktop.fi.intel.com ([10.237.72.198])
  by fmsmga005.fm.intel.com with ESMTP; 04 Jun 2019 06:02:21 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/19] perf time-utils: Add support for multiple explicit time intervals
Date:   Tue,  4 Jun 2019 16:00:17 +0300
Message-Id: <20190604130017.31207-20-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190604130017.31207-1-adrian.hunter@intel.com>
References: <20190604130017.31207-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only a single explicit time range is accepted. Add support for
multiple ranges separated by spaces, which requires the string to be
quoted. Update the time utils test accordingly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/Documentation/perf-diff.txt   |  8 ++-
 tools/perf/Documentation/perf-report.txt |  3 +-
 tools/perf/Documentation/perf-script.txt |  3 +-
 tools/perf/tests/time-utils-test.c       | 17 ++++++
 tools/perf/util/time-utils.c             | 74 ++++++++++++++++++++++--
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
-- 
2.17.1

