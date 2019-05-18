Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF9C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D2220872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iTtOOn3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfERJbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:31:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45533 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERJbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:31:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I9UeB61742052
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 02:30:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I9UeB61742052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558171841;
        bh=6veWEyauEbwAT9CnyjcJx+j3ulVb/X1n35V/4eyveE0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iTtOOn3I02crY7JNLgfvx1cVIISn7PbuenwfHHWJL9oGv4UkQ5d9AsFFZ6Uw9MVrY
         s+/YLu3s+1se4Fh6TS+vdAdMT/a0xehxuc3bzzOogPgotS7BYENAZm4raAfTBBhpht
         lWEsZgql2UQu+oWk5+f9n0NLCVpd/CbPcu4SQDq9ChPQbldCyC3MFBCW2Hg1gauZ9k
         fhEthG1LsUJujyRD3ft0DHeR4mM3smWg7kLK6kAh8cY/eadRVqi7oEbcKss+XW9MG5
         wnDkDsCvqa/pjnWpK+iNJ6ktSG4rsskNPVMdmTOwgKWf8I2ooEx4lHUeoRLjfDFxlb
         c/Z4poGhgYhtQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I9UdwT1742049;
        Sat, 18 May 2019 02:30:39 -0700
Date:   Sat, 18 May 2019 02:30:39 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-aeea9062d949584ac1f2f9a20f0e5ed306539a3e@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        hpa@zytor.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        ravi.bangoria@linux.ibm.com, jolsa@kernel.org, acme@redhat.com
Reply-To: acme@redhat.com, jolsa@kernel.org, ravi.bangoria@linux.ibm.com,
          kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, ak@linux.intel.com,
          mingo@kernel.org
In-Reply-To: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
References: <1557865174-56264-1-git-send-email-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf parse-regs: Split parse_regs
Git-Commit-ID: aeea9062d949584ac1f2f9a20f0e5ed306539a3e
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

Commit-ID:  aeea9062d949584ac1f2f9a20f0e5ed306539a3e
Gitweb:     https://git.kernel.org/tip/aeea9062d949584ac1f2f9a20f0e5ed306539a3e
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Tue, 14 May 2019 13:19:32 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:49 -0300

perf parse-regs: Split parse_regs

The available registers for --int-regs and --user-regs may be different,
e.g. XMM registers.

Split parse_regs into two dedicated functions for --int-regs and
--user-regs respectively.

Modify the warning message. "--user-regs=?" should be applied to show
the available registers for --user-regs.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/1557865174-56264-1-git-send-email-kan.liang@linux.intel.com
[ Changed docs as suggested by Ravi and agreed by Kan ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt |  3 ++-
 tools/perf/builtin-record.c              |  4 ++--
 tools/perf/util/parse-regs-options.c     | 19 ++++++++++++++++---
 tools/perf/util/parse-regs-options.h     |  3 ++-
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 27b37624c376..de269430720a 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -406,7 +406,8 @@ symbolic names, e.g. on x86, ax, si. To list the available registers use
 --intr-regs=ax,bx. The list of register is architecture dependent.
 
 --user-regs::
-Capture user registers at sample time. Same arguments as -I.
+Similar to -I, but capture user registers at sample time. To list the available
+user registers use --user-regs=\?.
 
 --running-time::
 Record running and enabled time for read events (:S)
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 861395753c25..e2c3a585a61e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2168,10 +2168,10 @@ static struct option __record_options[] = {
 		    "use per-thread mmaps"),
 	OPT_CALLBACK_OPTARG('I', "intr-regs", &record.opts.sample_intr_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use '-I?' to list register names", parse_regs),
+		    " use '-I?' to list register names", parse_intr_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use '-I?' to list register names", parse_regs),
+		    " use '--user-regs=?' to list register names", parse_user_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
 	OPT_CALLBACK('k', "clockid", &record.opts,
diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index 9cb187a20fe2..b21617f2bec1 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -5,8 +5,8 @@
 #include <subcmd/parse-options.h>
 #include "util/parse-regs-options.h"
 
-int
-parse_regs(const struct option *opt, const char *str, int unset)
+static int
+__parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
 	const struct sample_reg *r;
@@ -48,7 +48,8 @@ parse_regs(const struct option *opt, const char *str, int unset)
 					break;
 			}
 			if (!r->name) {
-				ui__warning("Unknown register \"%s\", check man page or run \"perf record -I?\"\n", s);
+				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
+					    s, intr ? "-I" : "--user-regs=");
 				goto error;
 			}
 
@@ -69,3 +70,15 @@ error:
 	free(os);
 	return ret;
 }
+
+int
+parse_user_regs(const struct option *opt, const char *str, int unset)
+{
+	return __parse_regs(opt, str, unset, false);
+}
+
+int
+parse_intr_regs(const struct option *opt, const char *str, int unset)
+{
+	return __parse_regs(opt, str, unset, true);
+}
diff --git a/tools/perf/util/parse-regs-options.h b/tools/perf/util/parse-regs-options.h
index cdefb1acf6be..2b23d25c6394 100644
--- a/tools/perf/util/parse-regs-options.h
+++ b/tools/perf/util/parse-regs-options.h
@@ -2,5 +2,6 @@
 #ifndef _PERF_PARSE_REGS_OPTIONS_H
 #define _PERF_PARSE_REGS_OPTIONS_H 1
 struct option;
-int parse_regs(const struct option *opt, const char *str, int unset);
+int parse_user_regs(const struct option *opt, const char *str, int unset);
+int parse_intr_regs(const struct option *opt, const char *str, int unset);
 #endif /* _PERF_PARSE_REGS_OPTIONS_H */
