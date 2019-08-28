Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADC0C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CCE022CF4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 06:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfH1GAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 02:00:25 -0400
Received: from mga12.intel.com ([192.55.52.136]:22123 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfH1GAX (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 02:00:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 23:00:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,440,1559545200"; 
   d="scan'208";a="181924747"
Received: from kbl.sh.intel.com ([10.239.159.163])
  by fmsmga007.fm.intel.com with ESMTP; 27 Aug 2019 23:00:21 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/4] perf util: Change convert_scale from static to global
Date:   Wed, 28 Aug 2019 13:59:29 +0800
Message-Id: <20190828055932.8269-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190828055932.8269-1-yao.jin@linux.intel.com>
References: <20190828055932.8269-1-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function convert_scale() can be used to convert string
to unit and scale. For example,

s = "6000000000ns";
convert_scale(s, &unit, &scale);

unit = "ns", scale = 6000000000.

Currently this function is static. This patch renames the function
to perf_pmu__convert_scale and changes the function to global.
No functional change.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/pmu.c | 6 +++---
 tools/perf/util/pmu.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 9807be6f09bb..8e35e97ecf90 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -101,7 +101,7 @@ static int pmu_format(const char *name, struct list_head *format)
 	return 0;
 }
 
-static int convert_scale(const char *scale, char **end, double *sval)
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 {
 	char *lc;
 	int ret = 0;
@@ -164,7 +164,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
 	else
 		scale[sret] = '\0';
 
-	ret = convert_scale(scale, NULL, &alias->scale);
+	ret = perf_pmu__convert_scale(scale, NULL, &alias->scale);
 error:
 	close(fd);
 	return ret;
@@ -372,7 +372,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
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
2.17.1

