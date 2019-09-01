Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC10C3A5A7
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 187382343A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340638;
	bh=Z8wJe3M6l9yY0XMJS2Q/4PmjdFxNA1SOeMDq5UD2qL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9BfAmk62KjKB3smJkEj5/GdyLqETlXS5WN7rOw7q2Ss9v4TXHBSiJIMDZj4v64ny
	 o88Qs88dXTH7qh8vN42SRHEzU3XxkzFLo3KenLcaqz9yCDKJI+CyXMa6nprBmCkjOG
	 fSmzTK5KyFMLnwrwkzR1A97QBG0Mz+BT7/lys03g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfIAMX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:23:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfIAMXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:23:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EF132339D;
        Sun,  1 Sep 2019 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340632;
        bh=Z8wJe3M6l9yY0XMJS2Q/4PmjdFxNA1SOeMDq5UD2qL4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=prd8LnSQCO0YrO3rMKddCiwOoH8U8vjMk9Pc26TzaNHjXCuBZt6NLDOZrLZVk/kZv
         oJlNcQd8rHReAgh0MiV5Hf7fX6YLFBdVv8msbHFXo/A47Zqw0oldcCwO46wPFeDhgM
         Q1T92oI14xgyvPQcnZ37IUEp3izM2iuPA7hCZzDM=
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
Subject: [PATCH 05/47] perf session: Replace MAX_NR_CPUS with perf_env::nr_cpus_online
Date:   Sun,  1 Sep 2019 09:22:44 -0300
Message-Id: <20190901122326.5793-6-acme@kernel.org>
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

nr_cpus, the number of CPUs online during a record session bound by
MAX_NR_CPUS, can be used as a dynamic alternative for MAX_NR_CPUS in
perf_session__cpu_bitmap.

Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russ Anderson <russ.anderson@hpe.com>
Link: http://lore.kernel.org/lkml/20190827214352.94272-5-meyerk@stormcage.eag.rdlabs.hpecorp.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7350b0dfbc1e..13486bcf74a0 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2292,6 +2292,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 {
 	int i, err = -1;
 	struct perf_cpu_map *map;
+	int nr_cpus = min(session->header.env.nr_cpus_online, MAX_NR_CPUS);
 
 	for (i = 0; i < PERF_TYPE_MAX; ++i) {
 		struct evsel *evsel;
@@ -2316,7 +2317,7 @@ int perf_session__cpu_bitmap(struct perf_session *session,
 	for (i = 0; i < map->nr; i++) {
 		int cpu = map->map[i];
 
-		if (cpu >= MAX_NR_CPUS) {
+		if (cpu >= nr_cpus) {
 			pr_err("Requested CPU %d too large. "
 			       "Consider raising MAX_NR_CPUS\n", cpu);
 			goto out_delete_map;
-- 
2.21.0

