Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C03A215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138838;
	bh=lSlHl5Pw8tb9Sv+GJAabbB4wQ7WOuuXly4rFUJOqfzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vt/zxQQ99xsqFksANG65DfFMQpw2KsOlrcrnhFqRTArVFcVKufqF4oF5Sa9rvALsz
	 HhzfvLpalFepyNPVeKV96CdxncHAOSf/QmnWp8afkDH1dauvwq8oJIK5YACftzF9ws
	 ccCwL5ZQvuFbHpntcWNT1q5OwcIBSlEXR+k744xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfFURkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfFURkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:36 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E368521530;
        Fri, 21 Jun 2019 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138834;
        bh=lSlHl5Pw8tb9Sv+GJAabbB4wQ7WOuuXly4rFUJOqfzA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yIJy4aAiV2xqhe1HIDPoSbfo9XNv5N0i4PPwB1jjZCcM4YpAUpRZW8x4UItsF/R/u
         SgUosvTylMs3CHEx8EJTan1ZoUD6O9Hqi4zTiMtYDT9fgP3rIRtnX8dm1o9/NhA85N
         9IBrCoGCOlQvx4lp3jgkGASBHEpmjfZrh+C736bs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 15/25] perf trace: Fix exclusion of not available syscall names from selector list
Date:   Fri, 21 Jun 2019 14:38:21 -0300
Message-Id: <20190621173831.13780-16-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
@@ -1574,7 +1574,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
 			if (id < 0)
 				break;
-			if (nr_allocated == trace->ev_qualifier_ids.nr) {
+			if (nr_allocated == i) {
 				void *entries;
 
 				nr_allocated += 8;
@@ -1587,11 +1587,11 @@ static int trace__validate_ev_qualifier(struct trace *trace)
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
-- 
2.20.1

