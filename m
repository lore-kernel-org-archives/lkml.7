Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FA1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1948215EA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561138843;
	bh=YQvXRqbk9OH40NWHHVeThY+9jg+QbMYsbcnU6PW81YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Tvpq3mJ4QODmgFGGXDQrCgmFZ2+gXjVvX66UIgIt3ZRUA6BbnB8k+tePv5s4PUmP8
	 oIoaSMGemIuCeiaJS0hXeqW7DRjYRdsHhPDYREZt3MBhhShqRYxfVAbX7w8rkG0fdG
	 sub61Wr/3pFD6fpOBp/ssBk8j/SRaQGaUMa+r02M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfFURkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:40:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfFURkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:40:41 -0400
Received: from quaco.ghostprotocols.net (187-26-104-93.3g.claro.net.br [187.26.104.93])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F57208C3;
        Fri, 21 Jun 2019 17:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561138841;
        bh=YQvXRqbk9OH40NWHHVeThY+9jg+QbMYsbcnU6PW81YI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qr+VS9+j6J94fEYJRCsw2o01+KbVukIN5ZQ7UPSxrKe3V1y4pmyDIa0SXCEFIdpGi
         efULlrJ3by2s6rI/bDm+o+eYiyQ6Ddy7noVZkltzMGfFjsRKNhuudzd4Y2UThkgG0R
         yvrgiXggP3yKlJsU/KWpNvyZM/q0jModEJ636SGo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 16/25] perf trace: Streamline validation of select syscall names list
Date:   Fri, 21 Jun 2019 14:38:22 -0300
Message-Id: <20190621173831.13780-17-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Rename the 'i' variable to 'nr_used' and use set 'nr_allocated' since
the start of this function, leaving the final assignment of the longer
named trace->ev_qualifier_ids.nr state to 'nr_used' at the end of the
function.

No change in behaviour intended.

Cc: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lkml.kernel.org/n/tip-kpgyn8xjdjgt0timrrnniquv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index fa9eb467eb4c..d5b2e4d8bf41 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1529,11 +1529,10 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 {
 	int err = 0;
 	bool printed_invalid_prefix = false;
-	size_t nr_allocated, i;
 	struct str_node *pos;
+	size_t nr_used = 0, nr_allocated = strlist__nr_entries(trace->ev_qualifier);
 
-	trace->ev_qualifier_ids.nr = strlist__nr_entries(trace->ev_qualifier);
-	trace->ev_qualifier_ids.entries = malloc(trace->ev_qualifier_ids.nr *
+	trace->ev_qualifier_ids.entries = malloc(nr_allocated *
 						 sizeof(trace->ev_qualifier_ids.entries[0]));
 
 	if (trace->ev_qualifier_ids.entries == NULL) {
@@ -1543,9 +1542,6 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 		goto out;
 	}
 
-	nr_allocated = trace->ev_qualifier_ids.nr;
-	i = 0;
-
 	strlist__for_each_entry(pos, trace->ev_qualifier) {
 		const char *sc = pos->s;
 		int id = syscalltbl__id(trace->sctbl, sc), match_next = -1;
@@ -1566,7 +1562,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			continue;
 		}
 matches:
-		trace->ev_qualifier_ids.entries[i++] = id;
+		trace->ev_qualifier_ids.entries[nr_used++] = id;
 		if (match_next == -1)
 			continue;
 
@@ -1574,7 +1570,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
 			if (id < 0)
 				break;
-			if (nr_allocated == i) {
+			if (nr_allocated == nr_used) {
 				void *entries;
 
 				nr_allocated += 8;
@@ -1587,11 +1583,11 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 				}
 				trace->ev_qualifier_ids.entries = entries;
 			}
-			trace->ev_qualifier_ids.entries[i++] = id;
+			trace->ev_qualifier_ids.entries[nr_used++] = id;
 		}
 	}
 
-	trace->ev_qualifier_ids.nr = i;
+	trace->ev_qualifier_ids.nr = nr_used;
 out:
 	if (printed_invalid_prefix)
 		pr_debug("\n");
-- 
2.20.1

