Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93322C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0C2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="j6h6vfI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFVGp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:45:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50087 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfFVGp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:45:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6j8q32008820
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:45:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6j8q32008820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185909;
        bh=4Kb1N4VQ0FrXt10H6wLP7nvJMCs36fxUAek7yHgoLKM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=j6h6vfI6krQhy4N/aFpUKC1gSkflP/stTSGopEPeGIHLdeH8CtVKv+PFVVkqqehzC
         ROlXHxwgqU4KggF/H85QnkWDq242rO/tU3p7DgTRpD4+sl+eK6lvmx8S/d1lZloZYL
         fk/VqWNnMR0wHvmEqSIw48OHrX+ixszxJUOzAHTY82RdmDcL5uy0jE5xbmgGrPocnK
         jXhzbJ4UZm+HM3ajNjlxJ0Aww7GMK7/7eqEVR1JrAPq9OB2wP8EALkqo9a+OYJQ5yU
         cJtA+d688J0mc12+jHbII++7f/yAjzYNklibwgpHjJ8o5sYpkLu5WAFaHU4jpeOqJb
         zXlYkkANzXGhQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6j8452008815;
        Fri, 21 Jun 2019 23:45:08 -0700
Date:   Fri, 21 Jun 2019 23:45:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-kpgyn8xjdjgt0timrrnniquv@git.kernel.org>
Cc:     jolsa@kernel.org, suzuki.poulose@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        leo.yan@linaro.org, mathieu.poirier@linaro.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, hpa@zytor.com, mike.leach@linaro.org,
        adrian.hunter@intel.com
Reply-To: alexander.shishkin@linux.intel.com, acme@redhat.com,
          adrian.hunter@intel.com, mike.leach@linaro.org, hpa@zytor.com,
          suzuki.poulose@arm.com, jolsa@kernel.org,
          mathieu.poirier@linaro.org, namhyung@kernel.org,
          tglx@linutronix.de, leo.yan@linaro.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Streamline validation of select syscall
 names list
Git-Commit-ID: 99f26f854867175ad7e157c7efc1e91ddc7eec44
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

Commit-ID:  99f26f854867175ad7e157c7efc1e91ddc7eec44
Gitweb:     https://git.kernel.org/tip/99f26f854867175ad7e157c7efc1e91ddc7eec44
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Jun 2019 18:17:41 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:19 -0300

perf trace: Streamline validation of select syscall names list

Rename the 'i' variable to 'nr_used' and use set 'nr_allocated' since
the start of this function, leaving the final assignment of the longer
named trace->ev_qualifier_ids.nr state to 'nr_used' at the end of the
function.

No change in behaviour intended.

Cc: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-kpgyn8xjdjgt0timrrnniquv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fa9eb467eb4c..d5b2e4d8bf41 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1529,11 +1529,10 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0;
 	bool printed_invalid_prefix = false;
-	size_t nr_allocated, i;
 	struct str_node *pos;
+	size_t nr_used = 0, nr_allocated = strlist__nr_entries(trace->ev_qualifier);
 
-	trace->ev_qualifier_ids.nr = strlist__nr_entries(trace->ev_qualifier);
-	trace->ev_qualifier_ids.entries = malloc(trace->ev_qualifier_ids.nr *
+	trace->ev_qualifier_ids.entries = malloc(nr_allocated *
 						 sizeof(trace->ev_qualifier_ids.entries[0]));
 
 	if (trace->ev_qualifier_ids.entries == NULL) {
@@ -1543,9 +1542,6 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 		goto out;
 	}
 
-	nr_allocated = trace->ev_qualifier_ids.nr;
-	i = 0;
-
 	strlist__for_each_entry(pos, trace->ev_qualifier) {
 		const char *sc = pos->s;
 		int id = syscalltbl__id(trace->sctbl, sc), match_next = -1;
@@ -1566,7 +1562,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			continue;
 		}
 matches:
-		trace->ev_qualifier_ids.entries[i++] = id;
+		trace->ev_qualifier_ids.entries[nr_used++] = id;
 		if (match_next == -1)
 			continue;
 
@@ -1574,7 +1570,7 @@ matches:
 			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
 			if (id < 0)
 				break;
-			if (nr_allocated == i) {
+			if (nr_allocated == nr_used) {
 				void *entries;
 
 				nr_allocated += 8;
@@ -1587,11 +1583,11 @@ matches:
 				}
 				trace->ev_qualifier_ids.entries = entries;
 			}
-			trace->ev_qualifier_ids.entries[i++] = id;
+			trace->ev_qualifier_ids.entries[nr_used++] = id;
 		}
 	}
 
-	trace->ev_qualifier_ids.nr = i;
+	trace->ev_qualifier_ids.nr = nr_used;
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
