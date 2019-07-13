Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A2BC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D782084C
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="k1ctJqHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbfGMK6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:58:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46303 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMK6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:58:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAw8qb3838324
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:58:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAw8qb3838324
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015488;
        bh=f9xl/rbSWLTAfVZqaHsPBEcpoXU4LojEcbVvHKFRAoA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=k1ctJqHX58dt+0U3IHXBp8KhWHc9l/W3L8csEft4HWKfU08ZM1oPQv7GCE5AZIZYN
         QOgNoyZOemWDu6l7jhUfr7erDkTM3uUndGKTPuUUDgsQg1a5jJuF3HEey0m/H8R7ID
         JLc9yq9fVXZFWhznmIetocMIHwgx+n93nYhz30c0TwDZPhDvDvmnBSpt/sVetHpJv9
         4tX9OCCJ5g+UXDZ4AlSUCLB2CYZAST5Z5Nw/K1Vc3Xz0/vkkEst/MwZ84hHVEMlv5l
         4KMs8A/TNQ0PNMp+JlgXVQLsrBzfOXJHkFDrSiRoVFUeXSVMB57pC6sMgv9oKCZSEd
         u137ZneIc2HQw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAw69M3838321;
        Sat, 13 Jul 2019 03:58:06 -0700
Date:   Sat, 13 Jul 2019 03:58:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-4okvjmm18arjrcyfhuahgfxm@git.kernel.org>
Cc:     mingo@kernel.org, acme@redhat.com, leo.yan@linaro.org,
        tglx@linutronix.de, hpa@zytor.com, adrian.hunter@intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org
Reply-To: mingo@kernel.org, namhyung@kernel.org, acme@redhat.com,
          hpa@zytor.com, leo.yan@linaro.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf evsel: perf_evsel__name(NULL) is valid, no
 need to check evsel
Git-Commit-ID: fc50e0ba9bcac92ff177ff3ac64644108b6d8dd8
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fc50e0ba9bcac92ff177ff3ac64644108b6d8dd8
Gitweb:     https://git.kernel.org/tip/fc50e0ba9bcac92ff177ff3ac64644108b6d8dd8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 3 Jul 2019 16:12:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:55 -0300

perf evsel: perf_evsel__name(NULL) is valid, no need to check evsel

It'll return "unknown", no need to open code it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4okvjmm18arjrcyfhuahgfxm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 2 +-
 tools/perf/util/session.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index aef59f318a67..93d4b12e248e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -298,7 +298,7 @@ static int process_read_event(struct perf_tool *tool,
 	struct report *rep = container_of(tool, struct report, tool);
 
 	if (rep->show_threads) {
-		const char *name = evsel ? perf_evsel__name(evsel) : "unknown";
+		const char *name = perf_evsel__name(evsel);
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
 					   evsel->idx,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2e61dd6a3574..e3463df18493 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1246,7 +1246,7 @@ static void dump_read(struct perf_evsel *evsel, union perf_event *event)
 		return;
 
 	printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
-	       evsel ? perf_evsel__name(evsel) : "FAIL",
+	       perf_evsel__name(evsel),
 	       event->read.value);
 
 	if (!evsel)
