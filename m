Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC43C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AD221851
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034516;
	bh=oinelY0MFGhMldycJ8mbSfvHGFrzwwPGNPuoXeDNglE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YbdC0gMmeKPUUvnoENAAC9f0U303tDuXC12cMXQeOIDhbHAulZhBP7QAFT63H9mZ1
	 8H2054cBoyeU/RWFJ/6/uNytGZFijBk8mVyRGWROtBLancjbVcWexo4BPGU8UdfLNa
	 toJ6MV00FUVq+tuix6H2Sl0QK3rsBMMx5kZr+/Kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfGBC2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbfGBC2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68597206A2;
        Tue,  2 Jul 2019 02:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034511;
        bh=oinelY0MFGhMldycJ8mbSfvHGFrzwwPGNPuoXeDNglE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nEOEBdCkSmwhTzhIweAnc9z280IAHcUNwZYqAz/m8nVNAL8yjWM6iP/5TrKLuypoR
         3UBmZ2CsQPDB4j+FYodBFvrN/CcHMh2Q2gDfzX2GTKL9/novEtn4FfiUthGBn5SXiU
         d3mIiNSH/vPCNh/rsaj8LO8BZyt9B67OkEI+2Rzw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 39/43] perf stat: Don't merge events in the same PMU
Date:   Mon,  1 Jul 2019 23:26:12 -0300
Message-Id: <20190702022616.1259-40-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Event merging is mainly to collapse similar events in lots of different
duplicated PMUs.

It can break metric displaying. It's possible for two metrics to have
the same event, and when the two events happen in a row the second
wouldn't be displayed.  This would also not show the second metric.

To avoid this don't merge events in the same PMU. This makes sense, if
we have multiple events in the same PMU there is likely some reason for
it (e.g. using multiple groups) and we better not merge them.

While in theory it would be possible to construct metrics that have
events with the same name in different PMU no current metrics have this
problem.

This is the fix for perf stat -M UPI,IPC (needs also another bug fix to
completely work)

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Fixes: 430daf2dc7af ("perf stat: Collapse identically named events")
Link: http://lkml.kernel.org/r/20190624193711.35241-3-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 90df41169113..58df6a0dbb9f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -554,7 +554,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct perf_evs
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
 		    strcmp(alias->unit, counter->unit) ||
-		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter))
+		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter) ||
+		    !strcmp(alias->pmu_name, counter->pmu_name))
 			break;
 		alias->merged_stat = true;
 		cb(config, alias, data, false);
-- 
2.20.1

