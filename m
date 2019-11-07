Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E2AC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D8421D79
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 19:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573153599;
	bh=jJTEj+RC34URrm6dmyaPlrShoJzL4K1WKRn4uzRNk/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M75QKyzQd+gDK1flgCulOlO9hkyg8+wESjkTmQajHm9CldmOpywwz08k9p2Hmj9jR
	 FKCPWa0zyyEkZ4hl73FZXb7G2nEotzI54h5hCSuXCbuAjlVm0s1KQ9GrwcgYbSUsF7
	 Xqtm2bnCyQ30vI95m2CQdDW528jWAc/Tjk/PRMD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfKGTGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 14:06:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726946AbfKGTGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 14:06:37 -0500
Received: from quaco.ghostprotocols.net (179-240-172-58.3g.claro.net.br [179.240.172.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B424421D6C;
        Thu,  7 Nov 2019 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573153596;
        bh=jJTEj+RC34URrm6dmyaPlrShoJzL4K1WKRn4uzRNk/0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DUCGO4FNQs4Sqb5v6XRMX6xgaCUbFwnJ+ZCHjwUXQ5uxOpRHFOkNs4I7zBhz391cL
         D9iEnBzEBr2/gREhsVWTRooDWR5DdasmVEFwiJlPdWVMF8S+CaAfs0htJ885QmRntj
         v2oS2Fcu7sTaiynXeU9YLCni0NvoV04rzrnpMrMU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 40/63] perf inject: Make --strip keep evsels
Date:   Thu,  7 Nov 2019 15:59:48 -0300
Message-Id: <20191107190011.23924-41-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

create_gcov (refer to the autofdo example in tools/perf/Documentation/intel-pt.txt)
now needs the evsels to read the perf.data file. So don't strip them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lore.kernel.org/lkml/20191105100057.21465-1-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 54 -------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 372ecb3e2c06..1e5d28311e14 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -578,58 +578,6 @@ static void strip_init(struct perf_inject *inject)
 		evsel->handler = drop_sample;
 }
 
-static bool has_tracking(struct evsel *evsel)
-{
-	return evsel->core.attr.mmap || evsel->core.attr.mmap2 || evsel->core.attr.comm ||
-	       evsel->core.attr.task;
-}
-
-#define COMPAT_MASK (PERF_SAMPLE_ID | PERF_SAMPLE_TID | PERF_SAMPLE_TIME | \
-		     PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
-
-/*
- * In order that the perf.data file is parsable, tracking events like MMAP need
- * their selected event to exist, except if there is only 1 selected event left
- * and it has a compatible sample type.
- */
-static bool ok_to_remove(struct evlist *evlist,
-			 struct evsel *evsel_to_remove)
-{
-	struct evsel *evsel;
-	int cnt = 0;
-	bool ok = false;
-
-	if (!has_tracking(evsel_to_remove))
-		return true;
-
-	evlist__for_each_entry(evlist, evsel) {
-		if (evsel->handler != drop_sample) {
-			cnt += 1;
-			if ((evsel->core.attr.sample_type & COMPAT_MASK) ==
-			    (evsel_to_remove->core.attr.sample_type & COMPAT_MASK))
-				ok = true;
-		}
-	}
-
-	return ok && cnt == 1;
-}
-
-static void strip_fini(struct perf_inject *inject)
-{
-	struct evlist *evlist = inject->session->evlist;
-	struct evsel *evsel, *tmp;
-
-	/* Remove non-synthesized evsels if possible */
-	evlist__for_each_entry_safe(evlist, tmp, evsel) {
-		if (evsel->handler == drop_sample &&
-		    ok_to_remove(evlist, evsel)) {
-			pr_debug("Deleting %s\n", perf_evsel__name(evsel));
-			evlist__remove(evlist, evsel);
-			evsel__delete(evsel);
-		}
-	}
-}
-
 static int __cmd_inject(struct perf_inject *inject)
 {
 	int ret = -EINVAL;
@@ -729,8 +677,6 @@ static int __cmd_inject(struct perf_inject *inject)
 				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
-			if (inject->strip)
-				strip_fini(inject);
 		}
 		session->header.data_offset = output_data_offset;
 		session->header.data_size = inject->bytes_written;
-- 
2.21.0

