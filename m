Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E47C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFF92070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ZQW5PqQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFVGqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:46:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50231 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:46:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6iQd82008458
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:44:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6iQd82008458
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185867;
        bh=EpynL7DL6i9iFiMMavub/OLi6CNGhdRPbxNyazWTnrU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ZQW5PqQdwPnc1yBzXXDMJaRBQwXtwo/iqJgBr5jlTLyTyo1hKqywQOzifgzj/aQZ7
         ZYuqyNzSVNjAh/8WgeqpfwhWxASNHLih+qr4btmQS2uWgUcIM8QCPJkCpkW6kWBgcE
         fdOKSfyGbEx+GV5bT29W0A7HH5DwY66v/3cxfDrcdzUbOeW5szG/IICFSwz8WGhw32
         4Ytul0nL8UprCxFzlqA0YDTFdOnaA/1VLq3pc9D8/HJYxWDhqaG7KC6aXmtoWNVw3X
         EtOXDdG/cqCeFDWQIX7L2H3lTeE87vMth4FehEWEcqmnODgYW+MboVenJRez3RVNPg
         z44tnZ7u3z24g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6iQ422008455;
        Fri, 21 Jun 2019 23:44:26 -0700
Date:   Fri, 21 Jun 2019 23:44:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-a4066d64d9391a734ee0e49c8d2757f5685013b4@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        suzuki.poulose@arm.com, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, acme@redhat.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org
Reply-To: mike.leach@linaro.org, leo.yan@linaro.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
          acme@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de, mingo@kernel.org, suzuki.poulose@arm.com,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org
In-Reply-To: <20190613181514.GC1402@kernel.org>
References: <20190613181514.GC1402@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Fix exclusion of not available syscall
 names from selector list
Git-Commit-ID: a4066d64d9391a734ee0e49c8d2757f5685013b4
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

Commit-ID:  a4066d64d9391a734ee0e49c8d2757f5685013b4
Gitweb:     https://git.kernel.org/tip/a4066d64d9391a734ee0e49c8d2757f5685013b4
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 13 Jun 2019 17:35:09 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:19 -0300

perf trace: Fix exclusion of not available syscall names from selector list

We were just skipping the syscalls not available in a particular
architecture without reflecting this in the number of entries in the
ev_qualifier_ids.nr variable, fix it.

This was done with the most minimalistic way, reusing the index variable
'i', a followup patch will further clean this by making 'i' renamed to
'nr_used' and using 'nr_allocated' in a few more places.

Reported-by: Leo Yan <leo.yan@linaro.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Fixes: 04c41bcb862b ("perf trace: Skip unknown syscalls when expanding strace like syscall groups")
Link: https://lkml.kernel.org/r/20190613181514.GC1402@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 12f5ad98f8c1..fa9eb467eb4c 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1527,9 +1527,9 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 
 static int trace__validate_ev_qualifier(struct trace *trace)
 {
-	int err = 0, i;
+	int err = 0;
 	bool printed_invalid_prefix = false;
-	size_t nr_allocated;
+	size_t nr_allocated, i;
 	struct str_node *pos;
 
 	trace->ev_qualifier_ids.nr = strlist__nr_entries(trace->ev_qualifier);
@@ -1574,7 +1574,7 @@ matches:
 			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
 			if (id < 0)
 				break;
-			if (nr_allocated == trace->ev_qualifier_ids.nr) {
+			if (nr_allocated == i) {
 				void *entries;
 
 				nr_allocated += 8;
@@ -1587,11 +1587,11 @@ matches:
 				}
 				trace->ev_qualifier_ids.entries = entries;
 			}
-			trace->ev_qualifier_ids.nr++;
 			trace->ev_qualifier_ids.entries[i++] = id;
 		}
 	}
 
+	trace->ev_qualifier_ids.nr = i;
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
