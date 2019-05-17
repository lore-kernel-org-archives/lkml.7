Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFE5C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 767CB2087B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558122068;
	bh=qAD0RO1D4Cr2JPA10+NT22bd2tnyQeiayXMveeRCxmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OFvOAfiyKM+bMqXtQB89rfgv8oORDdsKj7RV7Vra/+qgJ/Ip90Ku4xdnmKR1FEd62
	 v0uaypBt/ZB5aY+wZnmK+dCxqNLzNxMPHjOiFijfKtq8wkcVjOnvHk40wUzKnjidCB
	 WR4J+8VEqg9sRGQlPk5Sw0mbMgQDg3E0devjyuas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfEQTlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:41:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfEQTlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:41:05 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9662E21880;
        Fri, 17 May 2019 19:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558122064;
        bh=qAD0RO1D4Cr2JPA10+NT22bd2tnyQeiayXMveeRCxmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BYL6uCD9oF/KaJ1QPdnU1eCSFkzgZS6NanyhN8HLwCoFV0sIzWvIgOVW7wP+UqPP7
         HwhI4MRtOMQTth7fFzXxpFApn8FYdgbiznYqk4UZqnit85IY5l864ouo3cw5DplpfZ
         3lJ/gS/VkB+toA0Ugkfzgii9NFdEDron9pyTi4GM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 64/73] perf parse-regs: Split parse_regs
Date:   Fri, 17 May 2019 16:36:02 -0300
Message-Id: <20190517193611.4974-65-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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
 
@@ -69,3 +70,15 @@ parse_regs(const struct option *opt, const char *str, int unset)
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
-- 
2.20.1

