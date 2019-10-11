Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622CFC47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304F8214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824568;
	bh=AmU4Ga0rLoQmJLiBkIrnYyEdiJvM8V2mYtqsj9eHnJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qXbauW0UkjOrct53kqIuk9TLWgZNSYlFEl9tJSVwWDfHkPD6Ivm1idB8unKcTi8GB
	 PODUvOlm846STkoyVjjhPpyi63DsIZLhrCJ/xi17Wm/nCxxP7mLwBGVyTdnH0UWYPF
	 EdwvnG+BBiqDkeMk6zBrG4LOqokGCpQ3/3knJkiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfJKUJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:26 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E042521D7D;
        Fri, 11 Oct 2019 20:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824565;
        bh=AmU4Ga0rLoQmJLiBkIrnYyEdiJvM8V2mYtqsj9eHnJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dElyUKM9KqJWD/B2Gr62BrsIivSstMP85TqnMTC0Wm1+Zi4hwu5hD3LFZJuKKN+33
         yvkPPjCYnw8o/mmDApixJY8ro96Kxh3JyUSlD0nClGBy2Kf8Bu174kIS7e7nfkPdzm
         Arfjb7Jeebl555ZG1GV4A1sq1XCyZPL9Si8KBrZE=
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
Subject: [PATCH 33/69] perf evlist: Introduce append_tp_filter() method
Date:   Fri, 11 Oct 2019 17:05:23 -0300
Message-Id: <20191011200559.7156-34-acme@kernel.org>
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

Will be used by 'perf trace' to support 'perf trace --filter', we need
to append to any pre-existing filter.

When parse_filter() gets invoked to process --filter, it'll set the
filter to that specified on the command line, later on, when we filter
out 'perf trace' own pid to avoid an event feedback loop, we need to
preserve the command line filter put in place by parse_filter().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h9rot08qmxlnfmte0holt68x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 20 ++++++++++++++++++++
 tools/perf/util/evlist.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c1b46080426b..1650d242a1c8 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1068,6 +1068,26 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
+int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter)
+{
+	struct evsel *evsel;
+	int err = 0;
+
+	if (filter == NULL)
+		return -1;
+
+	evlist__for_each_entry(evlist, evsel) {
+		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
+			continue;
+
+		err = perf_evsel__append_tp_filter(evsel, filter);
+		if (err)
+			break;
+	}
+
+	return err;
+}
+
 static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 00eab9435847..c58fd1908bfc 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -140,6 +140,8 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter);
 int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid);
 int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
 
+int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter);
+
 struct evsel *
 perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 
-- 
2.21.0

