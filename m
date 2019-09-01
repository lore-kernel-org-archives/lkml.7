Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC33BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA272377D
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340648;
	bh=1ZXKQdGOBhzTrA4w/4LP/lVmm6BIDPUQ2R3+9mCjDuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OrHCBneGsef/tqH0qxJHsVs5yPV6ZNCpqME6WyDMmjYLsaNR3xYOeA1IrSIJVk/iG
	 mSaT6am87DmnxT4J0rZH7tL6CHkV3FJLDMvOZHxgvB0MBK1+NZjj224VUYT8z52eZy
	 L4SAHS1npeKQmHCYXAswHB8nTI5SWchJ6cyZ2zCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbfIAMYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:40642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbfIAMYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:24:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC37D2339D;
        Sun,  1 Sep 2019 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340643;
        bh=1ZXKQdGOBhzTrA4w/4LP/lVmm6BIDPUQ2R3+9mCjDuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/ydYYWFHgCqgRsHLnei7xWEMHiymIyH3FXjGEWHRrwZvueZgztoRw2wHz2HzW17J
         Cv6QZiBEoPhkIaOFF4T5+w6kBO7aPd8IjTPEgUeBYUACQOQZxRtpdserCp1WojBpCQ
         TEv2rFBfBGupnvdiUHiDMAGH+FRQ9ZpFNpJ82nGc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kyle Meyer <meyerk@hpe.com>, Kyle Meyer <kyle.meyer@hpe.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russ Anderson <russ.anderson@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/47] libperf: Warn when exceeding MAX_NR_CPUS in cpumap
Date:   Sun,  1 Sep 2019 09:22:47 -0300
Message-Id: <20190901122326.5793-9-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Meyer <meyerk@hpe.com>

Display a warning when attempting to profile more than MAX_NR_CPU CPUs.
This patch should not change any behavior.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-8-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/cpumap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
index 2834753576b2..1f0e6f334237 100644
--- a/tools/perf/lib/cpumap.c
+++ b/tools/perf/lib/cpumap.c
@@ -100,6 +100,9 @@ struct perf_cpu_map *perf_cpu_map__read(FILE *file)
 		if (prev >= 0) {
 			int new_max = nr_cpus + cpu - prev - 1;
 
+			WARN_ONCE(new_max >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+							  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
 			if (new_max >= max_entries) {
 				max_entries = new_max + MAX_NR_CPUS / 2;
 				tmp = realloc(tmp_cpus, max_entries * sizeof(int));
@@ -192,6 +195,9 @@ struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list)
 			end_cpu = start_cpu;
 		}
 
+		WARN_ONCE(end_cpu >= MAX_NR_CPUS, "Perf can support %d CPUs. "
+						  "Consider raising MAX_NR_CPUS\n", MAX_NR_CPUS);
+
 		for (; start_cpu <= end_cpu; start_cpu++) {
 			/* check for duplicates */
 			for (i = 0; i < nr_cpus; i++)
-- 
2.21.0

