Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A68C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF19A21882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153311;
	bh=P5WBOeVw8QZn/PrWglG2xVbdNTiJ8X/fKwXu05gwSbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KqhkNMB2KsG4O3136tkPLMUYgpxov9aRnm2hrL+i+97OCaTUPTINOAbMpcMbTj1zI
	 Esvy1Zv2a8d6iSfxg/hDIyFZo3n6EUgj0JNKmhLrHhPggKrolqcvSVfG0PpfL0MZmR
	 H4t5nRX7rjrIg2yzZAyAp2QbRahyJvQQTImpWYw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbfKGTBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:01:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfKGTBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:01:50 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E6B321D7E;
        Thu,  7 Nov 2019 19:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153309;
        bh=P5WBOeVw8QZn/PrWglG2xVbdNTiJ8X/fKwXu05gwSbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sEOfDTftcJXXT6cY57SNoLBK65AGAI06yaJ5BdvcjmDmzdbqSt3XRExt9OFiTBAl4
         guIhwSk/Z8yDi8qBkYG2TTtlLMpCQKFz33Q5Odo1j+FAKBPeBHhNgcGaZZSaFLNxvt
         F02k0M2IMSZgtsePCvDuKwzSO7eMmaKrRxGh6PgM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/63] perf evsel: Avoid close(-1)
Date:   Thu,  7 Nov 2019 15:59:18 -0300
Message-Id: <20191107190011.23924-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

In some weak fallback cases close can be called a lot with -1. Check for
this case and avoid calling close then.

This is mainly to shut up valgrind which complains about this case.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191020175202.32456-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evsel.c  | 3 ++-
 tools/perf/util/evsel.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
index a8cb582e2721..5a89857b0381 100644
--- a/tools/perf/lib/evsel.c
+++ b/tools/perf/lib/evsel.c
@@ -120,7 +120,8 @@ void perf_evsel__close_fd(struct perf_evsel *evsel)
 
 	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 }
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d831038b55f2..d4451846af93 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1815,7 +1815,8 @@ int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 	old_errno = errno;
 	do {
 		while (--thread >= 0) {
-			close(FD(evsel, cpu, thread));
+			if (FD(evsel, cpu, thread) >= 0)
+				close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
 		thread = nthreads;
-- 
2.21.0

