Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6ECC432C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D6B222C8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 00:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569458012;
	bh=ijGGNi0fPRQ9g4kxxcYUIwUixLE5Wi0m3WU2JQjktLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QDOIbs4dTR8IChYRj9zjrpX3YCXvP3MdRzyEwMv0laIFh5j2dLrMMvJHjxF63S7WF
	 af9zVizsM/MOjzWu6Gdb5V6S7GOnZTy02j9dIIHntKMBMMYObqLz7ym+R02t5+OEsQ
	 ykxSE16bcYXdq39OGNz2ihq1194UQzduB0KGdvvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387755AbfIZAdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 20:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfIZAd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 20:33:27 -0400
Received: from quaco.localdomain (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7355E222C1;
        Thu, 26 Sep 2019 00:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569458006;
        bh=ijGGNi0fPRQ9g4kxxcYUIwUixLE5Wi0m3WU2JQjktLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOKK0InpBDXtKOIRWX3pTfTkcvWBYwruicjXTm09GUwQDMfNqp3omAjzWlDtozeA9
         US4JWCk9qQwlcnJl38ILqNV67c0fgEcwjeD0wrlFepBlHTy6Hmw7tr+ubPCAXMjWIA
         VIXdnO63ySWtVo/K8AZxwdBHORnOAoohaUdAAs7U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Janakarajan Natarajan <janakarajan.natarajan@amd.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Luke Mujica <lukemujica@google.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 06/66] perf list: Allow plurals for metric, metricgroup
Date:   Wed, 25 Sep 2019 21:31:44 -0300
Message-Id: <20190926003244.13962-7-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Enhance usability by allowing the same plurality used in the output
title, for the command line parameter.

BEFORE, perf deceitfully acts as if there are no metrics to be had:

  $ perf list metrics

  List of pre-defined events (to be used in -e):

  Metric Groups:

  $

But singular 'metric' shows a list of metrics:

  $ perf list metric

  List of pre-defined events (to be used in -e):

  Metrics:

    IPC
         [Instructions Per Cycle (per logical thread)]
    UPI
         [Uops Per Instruction]

AFTER, when asking for 'metrics', we actually see the metrics get listed:

  $ perf list metrics

  List of pre-defined events (to be used in -e):

  Metrics:

    IPC
         [Instructions Per Cycle (per logical thread)]
    UPI
         [Uops Per Instruction]

Fixes: 71b0acce78d1 ("perf list: Add metric groups to perf list")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Janakarajan Natarajan <janakarajan.natarajan@amd.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Luke Mujica <lukemujica@google.com>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190919204306.12598-4-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e290f6b348d8..08e62ae9d37e 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -81,9 +81,9 @@ int cmd_list(int argc, const char **argv)
 						long_desc_flag, details_flag);
 		else if (strcmp(argv[i], "sdt") == 0)
 			print_sdt_events(NULL, NULL, raw_dump);
-		else if (strcmp(argv[i], "metric") == 0)
+		else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
 			metricgroup__print(true, false, NULL, raw_dump, details_flag);
-		else if (strcmp(argv[i], "metricgroup") == 0)
+		else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
 			metricgroup__print(false, true, NULL, raw_dump, details_flag);
 		else if ((sep = strchr(argv[i], ':')) != NULL) {
 			int sep_idx;
-- 
2.21.0

