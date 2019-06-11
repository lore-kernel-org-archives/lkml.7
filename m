Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38FC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 663E521850
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279890;
	bh=nOZpDWQeIEL55E5kF7f+Poxww8ilQsyckmWin6qNH2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W54nh0Qdi7dVxL9RkdQS0PYO+I0lotiayNwJOtygRdEQWVHRq1Zf2WGTM8Frmv6X8
	 DmUXseUc5WXKBwqJyd7ksuWKL1KdYQsnwIjA7BfCUNqcqn5jc5kU1QIFOvka0uwnK3
	 CCTbQw2FW4wIMhBsc6LymodQo2UjX52GNGGEPcwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407351AbfFKTEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407324AbfFKTEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:46 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F7ED21871;
        Tue, 11 Jun 2019 19:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279886;
        bh=nOZpDWQeIEL55E5kF7f+Poxww8ilQsyckmWin6qNH2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yignxCerGhv+0BmJgdZo6hshQaCmDMWt6hgKJbVoCGwUvJ4+ctLmJ/cvu9MaHUAa0
         tqpIq3tNhoCWW2KDWR3YCv0vcvrG52/QHAyuCWdE4N2KXi3S2MT09HkJoIhhKn8vPf
         YaALhwCpgMlbhyh1QZEN8u9BWT0iSG2yR804nDw4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 78/85] perf time-utils: Simplify perf_time__parse_for_ranges() error paths slightly
Date:   Tue, 11 Jun 2019 15:59:04 -0300
Message-Id: <20190611185911.11645-79-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Simplify perf_time__parse_for_ranges() error paths slightly.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-17-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 3e87c21c293c..9a463752dba8 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -403,7 +403,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				int *range_size, int *range_num)
 {
 	struct perf_time_interval *ptime_range;
-	int size, num, ret;
+	int size, num, ret = -EINVAL;
 
 	ptime_range = perf_time__range_alloc(time_str, &size);
 	if (!ptime_range)
@@ -415,7 +415,6 @@ int perf_time__parse_for_ranges(const char *time_str,
 			pr_err("HINT: no first/last sample time found in perf data.\n"
 			       "Please use latest perf binary to execute 'perf record'\n"
 			       "(if '--buildid-all' is enabled, please set '--timestamp-boundary').\n");
-			ret = -EINVAL;
 			goto error;
 		}
 
@@ -425,11 +424,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 				session->evlist->first_sample_time,
 				session->evlist->last_sample_time);
 
-		if (num < 0) {
-			pr_err("Invalid time string\n");
-			ret = -EINVAL;
-			goto error;
-		}
+		if (num < 0)
+			goto error_invalid;
 	} else {
 		num = 1;
 	}
@@ -439,6 +435,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 	*ranges = ptime_range;
 	return 0;
 
+error_invalid:
+	pr_err("Invalid time string\n");
 error:
 	free(ptime_range);
 	return ret;
-- 
2.20.1

