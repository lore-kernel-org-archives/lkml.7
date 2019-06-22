Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB207C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22F22089C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 06:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fS99K0lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfFVGgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 02:36:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58025 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfFVGgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 02:36:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5M6ZBwa2004250
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 21 Jun 2019 23:35:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5M6ZBwa2004250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561185311;
        bh=iXt7r7DNQ/3jCcVeC4OBkNideOo0HXAjx8R33AJVQNY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=fS99K0lcDBl9PgyBYkmf0YSSZSeaTbZaX429J2kgoa+PjcrwGemdgJB+QwSpTMf1+
         xgrluUNwD/lT5nJpK73DsAHbN/QOFgqdrGm8bvFye20cDk0UZct4ZoZj6lyrH+VAVY
         fCpbOVA+U8XnO7Gt/6SNarXYeJfiugoHa8bcaFuOYckbr2+Xeq99C50uFHIUBXAgjf
         wKk6z8qWbSqvTfu33yNxkimzAY8zgp0iA3OrOFQrbsHOj0kAFr12qEmf0Ssfea3fFr
         s36MRroM5Ai1dT5n85DdZ1OgSIXnBDojZYMJDn040TgxZ4vd155VpYvm3epJL1pPyn
         a/mdEeUozqmFA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5M6ZB1e2004247;
        Fri, 21 Jun 2019 23:35:11 -0700
Date:   Fri, 21 Jun 2019 23:35:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-374d910f87b87283df2b1e8a60a6a546d4a14c90@git.kernel.org>
Cc:     tglx@linutronix.de, mathieu.poirier@linaro.org, acme@redhat.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, suzuki.poulose@arm.com, mingo@kernel.org,
        peterz@infradead.org
Reply-To: peterz@infradead.org, namhyung@kernel.org, mingo@kernel.org,
          suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
          jolsa@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          acme@redhat.com, mathieu.poirier@linaro.org, tglx@linutronix.de
In-Reply-To: <20190611204528.20093-1-mathieu.poirier@linaro.org>
References: <20190611204528.20093-1-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf: cs-etm: Optimize option setup for CPU-wide
 sessions
Git-Commit-ID: 374d910f87b87283df2b1e8a60a6a546d4a14c90
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

Commit-ID:  374d910f87b87283df2b1e8a60a6a546d4a14c90
Gitweb:     https://git.kernel.org/tip/374d910f87b87283df2b1e8a60a6a546d4a14c90
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 11 Jun 2019 14:45:28 -0600
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 17 Jun 2019 15:57:16 -0300

perf: cs-etm: Optimize option setup for CPU-wide sessions

Call function cs_etm_set_option() once with all relevant options set
rather than multiple times to avoid going through the list of CPU more
than once.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190611204528.20093-1-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 279c69caef91..c6f1ab5499b5 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -162,20 +162,19 @@ static int cs_etm_set_option(struct auxtrace_record *itr,
 		    !cpu_map__has(online_cpus, i))
 			continue;
 
-		switch (option) {
-		case ETM_OPT_CTXTID:
+		if (option & ETM_OPT_CTXTID) {
 			err = cs_etm_set_context_id(itr, evsel, i);
 			if (err)
 				goto out;
-			break;
-		case ETM_OPT_TS:
+		}
+		if (option & ETM_OPT_TS) {
 			err = cs_etm_set_timestamp(itr, evsel, i);
 			if (err)
 				goto out;
-			break;
-		default:
-			goto out;
 		}
+		if (option & ~(ETM_OPT_CTXTID | ETM_OPT_TS))
+			/* Nothing else is currently supported */
+			goto out;
 	}
 
 	err = 0;
@@ -398,11 +397,8 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	if (!cpu_map__empty(cpus)) {
 		perf_evsel__set_sample_bit(cs_etm_evsel, CPU);
 
-		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_CTXTID);
-		if (err)
-			goto out;
-
-		err = cs_etm_set_option(itr, cs_etm_evsel, ETM_OPT_TS);
+		err = cs_etm_set_option(itr, cs_etm_evsel,
+					ETM_OPT_CTXTID | ETM_OPT_TS);
 		if (err)
 			goto out;
 	}
