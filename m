Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21266C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE3222071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 14:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574434678;
	bh=XIRVLzvM3Cv5q1q02RT9jGxcS+dPozDKLxIg4pSicHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t4rZ/YwExv0To9NvP4wBStHDiKZ3ytA7GmvtYicSl/goMFHu9ilEF0kC/chnEsuqI
	 1CS+KhfhQKvZfywDrExiIG17odx+TivZvIhDODbGOj0gQuuvq05SzCMnHmvg/6y/QU
	 o98CclYZANTQmmSIgziK8gUyIGwg03dJFQnkeeJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKVO54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:57:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbfKVO5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 09:57:51 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86357207FA;
        Fri, 22 Nov 2019 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574434670;
        bh=XIRVLzvM3Cv5q1q02RT9jGxcS+dPozDKLxIg4pSicHc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rPrbkg9MV9KCYo2LuJWXTkLDjia2UyZWLJbxiUMkty1ATkVnnhlOpbBIHb266doRE
         Q9U0Bb5FwXWmXd1ZXrgoBMuUXwPrh7sfB/pK39+zudXKg0aLpkBTgRWkDYlOXxoSlY
         FmiXXoGn+3bj4NGPh0ekSI5JpYK/IING/qosVom0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/26] perf auxtrace: Move perf_evsel__find_pmu()
Date:   Fri, 22 Nov 2019 11:56:56 -0300
Message-Id: <20191122145711.3171-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191122145711.3171-1-acme@kernel.org>
References: <20191122145711.3171-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Move perf_evsel__find_pmu() so it can be used without forward
declaration.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index c555c3ccd79d..263d1d9d8987 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -57,6 +57,18 @@
 #include "symbol/kallsyms.h"
 #include <internal/lib.h>
 
+static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
+{
+	struct perf_pmu *pmu = NULL;
+
+	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
+		if (pmu->type == evsel->core.attr.type)
+			break;
+	}
+
+	return pmu;
+}
+
 static bool auxtrace__dont_decode(struct perf_session *session)
 {
 	return !session->itrace_synth_opts ||
@@ -2180,18 +2192,6 @@ static int parse_addr_filter(struct evsel *evsel, const char *filter,
 	return err;
 }
 
-static struct perf_pmu *perf_evsel__find_pmu(struct evsel *evsel)
-{
-	struct perf_pmu *pmu = NULL;
-
-	while ((pmu = perf_pmu__scan(pmu)) != NULL) {
-		if (pmu->type == evsel->core.attr.type)
-			break;
-	}
-
-	return pmu;
-}
-
 static int perf_evsel__nr_addr_filter(struct evsel *evsel)
 {
 	struct perf_pmu *pmu = perf_evsel__find_pmu(evsel);
-- 
2.21.0

