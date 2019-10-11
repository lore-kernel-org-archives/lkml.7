Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA71ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1722190F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824563;
	bh=cbUnWxt2KBYx8a6yg+8+lMzH33F7Wttrt2XqH4jysrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ATr0mwt1jjl/BwZsFNrSj0P2kvGPlDg8D64BO6KfZKHiWjqmLBmfOwwA6Ex4ALZsg
	 lwFajLwE4voPve1PyFh2it1QHIoF2dfdzBrcZOoeJmOvn4Uzgj9baHUbXP427L4Kg+
	 r6z5P/P03Uo+nvy+c/M1PWimPADOZ3nm/i8gPpPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfJKUJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:21 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4840921D71;
        Fri, 11 Oct 2019 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824560;
        bh=cbUnWxt2KBYx8a6yg+8+lMzH33F7Wttrt2XqH4jysrw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NW759qNaU9KTMzu7JUJLoI9wMORfdZD6EFDTcRm2pB4efTU5UrryOujZ1dqllxRT1
         IeWfYUktnnnnxuZFeDjdgem6VeJ4dQEZXJQYeTDoRjTeDkrYSZPs95JzgvZGT8QUXu
         Uj4/OVPblaTCB58Ovl12SuNOX3Xfm6DlWpMQcxkc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 32/69] perf evlist: Factor out asprintf routine to build a tracepoint pid filter
Date:   Fri, 11 Oct 2019 17:05:22 -0300
Message-Id: <20191011200559.7156-33-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Will be used to append such lists to existing filters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-798vlyqfqw938ehoe8etivx1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b4c43ac4583f..c1b46080426b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1053,6 +1053,9 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	struct evsel *evsel;
 	int err = 0;
 
+	if (filter == NULL)
+		return -1;
+
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
@@ -1065,16 +1068,15 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
-int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
-	int ret = -1;
 	size_t i;
 
 	for (i = 0; i < npids; ++i) {
 		if (i == 0) {
 			if (asprintf(&filter, "common_pid != %d", pids[i]) < 0)
-				return -1;
+				return NULL;
 		} else {
 			char *tmp;
 
@@ -1086,8 +1088,17 @@ int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *
 		}
 	}
 
-	ret = perf_evlist__set_tp_filter(evlist, filter);
+	return filter;
 out_free:
+	free(filter);
+	return NULL;
+}
+
+int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+{
+	char *filter = asprintf__tp_filter_pids(npids, pids);
+	int ret = perf_evlist__set_tp_filter(evlist, filter);
+
 	free(filter);
 	return ret;
 }
-- 
2.21.0

