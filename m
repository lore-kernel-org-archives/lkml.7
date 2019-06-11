Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E95C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBCF21873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279893;
	bh=gSfKZd4eJCP2SmWDQvtSxXjaMNRqDBM3fbtDpRJmlaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpo0yOPXgy15OshipYn4zkhmCEEzbO8XFBfitI3wIKpKczcAaIj0jgQj3lx95yQVY
	 VoThVm4m9UyOaREH1mAPZcVIC1xrDpREsMxgDyAX65AHVJkzRGsyj6hj87fGeHj8ua
	 2RXOYEaE1hCgNMAc0/5Ct2J/PRr4y5PYgz1DlybI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407359AbfFKTEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:41064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407324AbfFKTEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:50 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33562184B;
        Tue, 11 Jun 2019 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279889;
        bh=gSfKZd4eJCP2SmWDQvtSxXjaMNRqDBM3fbtDpRJmlaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oy8MZUCvYwIFMYiZXgKaupmUaaByHfRooEM1oeiLgpqBp75sndTNgnZ8fo9wxpMqj
         3umETDAwO+xrkqFySNrIcysdWUO3Sj3lWsV9tE3L7p+z8ElKsV4THm+sU4wsV5S6ks
         pCtAHboBGNp7P0jBZCOgTGKEH4g3l1AQLRvGiyA0=
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
Subject: [PATCH 79/85] perf time-utils: Make perf_time__parse_for_ranges() more logical
Date:   Tue, 11 Jun 2019 15:59:05 -0300
Message-Id: <20190611185911.11645-80-acme@kernel.org>
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

Explicit time ranges never contain a percent sign whereas percentage
ranges always do, so it is possible to call the correct parser.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-18-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/time-utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/time-utils.c b/tools/perf/util/time-utils.c
index 9a463752dba8..d942840356e3 100644
--- a/tools/perf/util/time-utils.c
+++ b/tools/perf/util/time-utils.c
@@ -402,6 +402,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 				struct perf_time_interval **ranges,
 				int *range_size, int *range_num)
 {
+	bool has_percent = strchr(time_str, '%');
 	struct perf_time_interval *ptime_range;
 	int size, num, ret = -EINVAL;
 
@@ -409,7 +410,7 @@ int perf_time__parse_for_ranges(const char *time_str,
 	if (!ptime_range)
 		return -ENOMEM;
 
-	if (perf_time__parse_str(ptime_range, time_str) != 0) {
+	if (has_percent) {
 		if (session->evlist->first_sample_time == 0 &&
 		    session->evlist->last_sample_time == 0) {
 			pr_err("HINT: no first/last sample time found in perf data.\n"
@@ -427,6 +428,8 @@ int perf_time__parse_for_ranges(const char *time_str,
 		if (num < 0)
 			goto error_invalid;
 	} else {
+		if (perf_time__parse_str(ptime_range, time_str))
+			goto error_invalid;
 		num = 1;
 	}
 
-- 
2.20.1

