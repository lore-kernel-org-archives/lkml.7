Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D147214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583965;
	bh=EcluUYJyWDo8rmZCzv6gpZ8WCvhWVcaLIeExWAIxZ+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LByYkJWx/PRx9H5/Lbd+uZhCMPG9RW4W9a3/2JDxqTzxhRYMGL25RtvdpEd/C174j
	 VZ0pyQXBgHXpzx871B1sD3cBD5axpD1AV8zOCwZMXk7P1tFXXiDzCnQlJEeUtATm81
	 Eoy2KTKBcRjIpDCJ4RQZIhjovQ13c71tNqHCSTj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKLSjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:39:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfKLSjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:39:21 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73C2020818;
        Tue, 12 Nov 2019 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583961;
        bh=EcluUYJyWDo8rmZCzv6gpZ8WCvhWVcaLIeExWAIxZ+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ad0s1A5wm58DffZblgjFNyDWhehRTZ6aqsqnfQzrbxAj8ITh1ixqXWC39Ewv9CX6Z
         A/BuJE4etJplHKu7ssQsBWlt2rff7jJ/KnEgk0fhqjCOTJ5P4g7cZdGd7Al5dq90Xp
         oUvGwdWmgDyPKmqc58vMLhFXO7fYWFmz2wC3n/Wg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/15] perf parse: Use YYABORT to clear stack after failure, plugging leaks
Date:   Tue, 12 Nov 2019 15:37:57 -0300
Message-Id: <20191112183757.28660-16-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

Using return rather than YYABORT means that the stack isn't cleared up
following a failure. The change to YYABORT means the return value is 1
rather than -1, but the callers just check for a result of 0 (success).
Add missing free of a list when an error occurs in event_pmu.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191109075840.181231-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.y | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 4cac830015be..e2eea4e601b4 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -284,6 +284,7 @@ PE_NAME opt_pmu_config
 	do {						\
 		parse_events_terms__delete($2);		\
 		parse_events_terms__delete(orig_terms);	\
+		free(list);				\
 		free($1);				\
 		free(pattern);				\
 		YYABORT;				\
@@ -550,7 +551,7 @@ tracepoint_name opt_event_config
 	free($1.event);
 	if (err) {
 		free(list);
-		return -1;
+		YYABORT;
 	}
 	$$ = list;
 }
-- 
2.21.0

