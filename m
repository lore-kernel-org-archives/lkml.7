Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FFAC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35A021726
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455486;
	bh=wqBiRHXtkFm5Nq3u/QemL+b96XDSNVUtlaEnLZ/R0vk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ySJQJ87u1MehquZEpyBl4fn3khEtu2VFBgbtjhwLttB9V4TgbgTA5fMDyeidCpqwh
	 4MKYfEvOHyL1Z7kStCI93TAws60XwuOJDgELUwBAroXnjY4MtBZtlRHxaSwTptvAx6
	 qTGT6GIOHzkW9ucob9DyRLzzefvyCqnab++krHsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfG3C6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbfG3C6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3613217F5;
        Tue, 30 Jul 2019 02:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455483;
        bh=wqBiRHXtkFm5Nq3u/QemL+b96XDSNVUtlaEnLZ/R0vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Whg4L0U0IWMZ4N4VLQa1/6JACZT5tIjExKZSkgkUlkKdBb+XC32bzsaVKxZE/yNDU
         EeMI43/k/sMJpzfFVL6d8dyra27S7z+sUoCvwOnpjhP+XdJ7/z++OMr3C+JpiVAMac
         PO8Z36cEM28wANnl1ITs1IG5hWtBzT695O1RLY38=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 033/107] perf evsel: Rename perf_evsel__init() to evsel__init()
Date:   Mon, 29 Jul 2019 23:54:56 -0300
Message-Id: <20190730025610.22603-34-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evsel__init() to evsel__init(), so we don't have a name
clash when we add perf_evsel__init() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-7-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c  | 8 ++++----
 tools/perf/util/evsel.h  | 3 +--
 tools/perf/util/python.c | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f7f97ca6e96d..97bee83f0f98 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -223,8 +223,8 @@ bool perf_evsel__is_function_event(struct evsel *evsel)
 #undef FUNCTION_EVENT
 }
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx)
+void evsel__init(struct evsel *evsel,
+		 struct perf_event_attr *attr, int idx)
 {
 	evsel->idx	   = idx;
 	evsel->tracking	   = !idx;
@@ -255,7 +255,7 @@ struct evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 	if (!evsel)
 		return NULL;
-	perf_evsel__init(evsel, attr, idx);
+	evsel__init(evsel, attr, idx);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
 		evsel->attr.sample_type |= (PERF_SAMPLE_RAW | PERF_SAMPLE_TIME |
@@ -350,7 +350,7 @@ struct evsel *perf_evsel__newtp_idx(const char *sys, const char *name, int idx)
 		event_attr_init(&attr);
 		attr.config = evsel->tp_format->id;
 		attr.sample_period = 1;
-		perf_evsel__init(evsel, &attr, idx);
+		evsel__init(evsel, &attr, idx);
 	}
 
 	return evsel;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 3caabd8a4aa6..af230d92fbef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -238,8 +238,7 @@ struct evsel *perf_evsel__new_cycles(bool precise);
 
 struct tep_event *event_format__new(const char *sys, const char *name);
 
-void perf_evsel__init(struct evsel *evsel,
-		      struct perf_event_attr *attr, int idx);
+void evsel__init(struct evsel *evsel, struct perf_event_attr *attr, int idx);
 void perf_evsel__exit(struct evsel *evsel);
 void perf_evsel__delete(struct evsel *evsel);
 
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index ed57b6b5ed91..f6fe3c90828f 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -782,7 +782,7 @@ static int pyrf_evsel__init(struct pyrf_evsel *pevsel,
 	attr.sample_id_all  = sample_id_all;
 	attr.size	    = sizeof(attr);
 
-	perf_evsel__init(&pevsel->evsel, &attr, idx);
+	evsel__init(&pevsel->evsel, &attr, idx);
 	return 0;
 }
 
-- 
2.21.0

