Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B782BECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB1021835
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824572;
	bh=9bBl6KRpBXS0GE4f1pDYtzHivcxZHEAedKc4McMFH60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EuesgwAfxRdo0z66KxIutJtRdTTVKL30L76el9kgQeJdCn4SfigYyWs6Wl4M9jgGk
	 UZv9+LtUNJz/Th3nw3WQzn/++chelvayffNOwLqqjDCx+zNSgtKlUJZXJkh0o8kyq6
	 CfCDN58nAS5uovdp9nyuXlZM04ONYTi4+bjiKgcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfJKUJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:30 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71F7A21D7C;
        Fri, 11 Oct 2019 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824570;
        bh=9bBl6KRpBXS0GE4f1pDYtzHivcxZHEAedKc4McMFH60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxxN91ZvJXmbeqozrPrp4B3Q47xyvTD5H2HTXTegRpBqANo7C2GBgCjNyedOfSFRk
         sJuI3Gko4r2R8989icavwoFK1uANJza+JoLfo5oZ53xYqfEQEIy+AKp555Vynu2RdR
         MBtzCHIrmz7qPV089SmAFIYZ2erK546bG9rXcXoY=
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
Subject: [PATCH 34/69] perf evlist: Introduce append_tp_filter_pid() and append_tp_filter_pids()
Date:   Fri, 11 Oct 2019 17:05:24 -0300
Message-Id: <20191011200559.7156-35-acme@kernel.org>
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

We'll need this to support 'perf trace e tracepoint --filter=expr', as
the command line tracepoint filter is attache to the preceding evsel,
just like in 'perf record' and when we go to set pid filters, which we
do at the minimum to filter 'perf trace' own syscalls, we need to
append, not set the tp filter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-daynpknni44ywuzi8iua57nn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 ++++++++++++++
 tools/perf/util/evlist.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1650d242a1c8..e33b46aca5cb 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1128,6 +1128,20 @@ int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
 	return perf_evlist__set_tp_filter_pids(evlist, 1, &pid);
 }
 
+int perf_evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+{
+	char *filter = asprintf__tp_filter_pids(npids, pids);
+	int ret = perf_evlist__append_tp_filter(evlist, filter);
+
+	free(filter);
+	return ret;
+}
+
+int perf_evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid)
+{
+	return perf_evlist__append_tp_filter_pids(evlist, 1, &pid);
+}
+
 bool perf_evlist__valid_sample_type(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c58fd1908bfc..13051409fd22 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -142,6 +142,9 @@ int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *
 
 int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter);
 
+int perf_evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
+int perf_evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
+
 struct evsel *
 perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 
-- 
2.21.0

