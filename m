Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED129CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEF202166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665137;
	bh=xm5LPEbt5KjBMbDJZbY6I0KLMlnaVCcymuiJLkWPo0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rJqtbiS7Z9gzXnH22v73FPhawPF1mfScWyiyrAc8G7BQKZhN6phWVpdhjYCG3HITO
	 jgK4DU9tFSSf11dXfBzaiwvdqGehKPihm9/UkeGb890jIL0zWqUxzahLOCTvMsfOj9
	 /ArK/fxHrHOMpXlUoA9SwvX89A0+poFxi0eIpgc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfJUNi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfJUNiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:38:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3814F21906;
        Mon, 21 Oct 2019 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665134;
        bh=xm5LPEbt5KjBMbDJZbY6I0KLMlnaVCcymuiJLkWPo0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7dKCUkYl9VDCduHjv1YlOiNJXu3EggJFudSBCw1iUssbiy2JBjRN8hKkVAE76zDB
         fa7g7iw16OQadbf8imJTX/2qIa423AmOlT/woVhDdaEek8VGw+FyvdwBIjZfao2OL/
         CTBFy77ijeY7cOAA9ir+2o9hKouZ1YhUMoFwJLa8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/57] perf test: Report failure for mmap events
Date:   Mon, 21 Oct 2019 10:37:41 -0300
Message-Id: <20191021133834.25998-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

When fail to mmap events in task exit case, it misses to set 'err' to
-1; thus the testing will not report failure for it.

This patch sets 'err' to -1 when fails to mmap events, thus Perf tool
can report correct result.

Fixes: d723a55096b8 ("perf test: Add test case for checking number of EXIT events")
Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/lkml/20191011091942.29841-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/task-exit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 4965f8b9055b..19fa7cb429fd 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -111,6 +111,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 	if (evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
+		err = -1;
 		goto out_delete_evlist;
 	}
 
-- 
2.21.0

