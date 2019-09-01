Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5BC9C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D25A2342C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340729;
	bh=e+OWfzWSim6mi7bIfnryGp5KyjFvIkJdU75yr2ZeLoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sWiRTjHyx+1vNAshzrXqYYjQ7ZiVzPl+iA2tcjMspyjtK8oABvWUCWeNVQm1W9mNn
	 ad0zTU50CEiyVRYWRUOqlLhDAcQ0qACthkSKj3FgIMlc62tZJA+zh6xM4f6IkXOVRL
	 cdhrlMKspLK0jU/q2ly/29zhSe0kkVcFR1TkJ1tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfIAMZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728895AbfIAMZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36429233A2;
        Sun,  1 Sep 2019 12:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340725;
        bh=e+OWfzWSim6mi7bIfnryGp5KyjFvIkJdU75yr2ZeLoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRVyOvKM0JMq7+9QHh3bITC85ffXgPlVuYfTJRi1m4LjeezvN43xyHlvZPX2A376O
         Pw48tLMnrvxB8/l6+p+lC1Pt1O2SAbjpseHZxYX8n4RjFz8hiFZRBeLN+exKjetMS2
         7VgFtgZWn/bEsIU970Afph0Wctf3USiKFnYkLNtA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 38/47] perf pmu: Change convert_scale from static to global
Date:   Sun,  1 Sep 2019 09:23:17 -0300
Message-Id: <20190901122326.5793-39-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The function convert_scale() can be used to convert string to unit and
scale. For example,

  s = "6000000000ns";
  convert_scale(s, &unit, &scale);

unit = "ns", scale = 6000000000.

Currently this function is static. This patch renames the function to
perf_pmu__convert_scale and changes the function to global.  No
functional change.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190828055932.8269-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 +++---
 tools/perf/util/pmu.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6b3448f6eb94..fb597fa94234 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -102,7 +102,7 @@ static int pmu_format(const char *name, struct list_head *format)
 	return 0;
 }
 
-static int convert_scale(const char *scale, char **end, double *sval)
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 {
 	char *lc;
 	int ret = 0;
@@ -165,7 +165,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
 	else
 		scale[sret] = '\0';
 
-	ret = convert_scale(scale, NULL, &alias->scale);
+	ret = perf_pmu__convert_scale(scale, NULL, &alias->scale);
 error:
 	close(fd);
 	return ret;
@@ -373,7 +373,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				desc ? strdup(desc) : NULL;
 	alias->topic = topic ? strdup(topic) : NULL;
 	if (unit) {
-		if (convert_scale(unit, &unit, &alias->scale) < 0)
+		if (perf_pmu__convert_scale(unit, &unit, &alias->scale) < 0)
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 3f8b79b1dd85..f36ade6df76d 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -96,4 +96,6 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
+
 #endif /* __PMU_H */
-- 
2.21.0

