Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFC4C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77FD2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WalXed60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfFVGsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:48:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfFVGsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:48:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6mepl2009742
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:48:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6mepl2009742
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561186120;
        bh=qBUdV1VWho2F7uNdMn2urUjGRxMIKSwmSObEToaKHPQ=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=WalXed602zyWXUg+BKomcxurlt0DzumDl+NtYIgBSmqHNdCDxr6JFaj1uXFclmAEI
         k3Ez5bQjxjKotEtAMKiExxiQoOcopIyMKU7xIbR83lqeIRZ42UyLm5tO3P4pIsAyqE
         ESejfg19mKfvcwDhuhBUNPU9MGJ1PBOTXSZ3JhHz+gdXnK8bLaswhL46OyDhywit4X
         fI7a5Jpe9Xt6GfB0aEgvT/8jf4jLjmnbgZ47QyGYMvxpibUttA9KtLkhE6Jts8shhL
         3iggIC46W1S7elM6O35IDxG0y6BZHau5oLnXHwPXQvYefvwWd+aNOHSHXWrl9AM7Yz
         hTJ3uSc1WeTww==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6me1U2009738;
        Fri, 21 Jun 2019 23:48:40 -0700
Date:   Fri, 21 Jun 2019 23:48:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-f30ztaasku3z935cn3ak3h53@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org, leo.yan@linaro.org,
        acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, acme@redhat.com,
          tglx@linutronix.de, jolsa@kernel.org, leo.yan@linaro.org,
          mingo@kernel.org, adrian.hunter@intel.com, namhyung@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Make perf_evsel__name() accept a NULL
 argument
Git-Commit-ID: fdbdd7e8580eac9bdafa532746c865644d125e34
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

Commit-ID:  fdbdd7e8580eac9bdafa532746c865644d125e34
Gitweb:     https://git.kernel.org/tip/fdbdd7e8580eac9bdafa532746c865644d125e34
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 17 Jun 2019 14:32:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:20 -0300

perf evsel: Make perf_evsel__name() accept a NULL argument

In which case it simply returns "unknown", like when it can't figure out
the evsel->name value.

This makes this code more robust and fixes a problem in 'perf trace'
where a NULL evsel was being passed to a routine that only used the
evsel for printing its name when a invalid syscall id was passed.

Reported-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-f30ztaasku3z935cn3ak3h53@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 0f506f10ecf0..04c4ed1573cb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -589,6 +589,9 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 {
 	char bf[128];
 
+	if (!evsel)
+		goto out_unknown;
+
 	if (evsel->name)
 		return evsel->name;
 
@@ -628,7 +631,10 @@ const char *perf_evsel__name(struct perf_evsel *evsel)
 
 	evsel->name = strdup(bf);
 
-	return evsel->name ?: "unknown";
+	if (evsel->name)
+		return evsel->name;
+out_unknown:
+	return "unknown";
 }
 
 const char *perf_evsel__group_name(struct perf_evsel *evsel)
