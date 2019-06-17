Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDDBC31E5D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7192D208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="M+tDEZt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbfFQTTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:19:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:19:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJJUrk3560237
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:19:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJJUrk3560237
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799171;
        bh=fa5am97uqiQ5V0tWhMubdiPnChRIYXWXMqQrOcXFnCw=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=M+tDEZt2Isjmj62vyM80lAOrj8COGiWaBPlQ+BHKOlX/lZUxy+l5DciCfY+RuuTsS
         fEYAHTdO9KFmLXuO+MNu2OjcUbr115bZYm3aCfXwdXHVBkELwaeIPsu91SI7hipPsc
         tIb4vpee6udMVG6cxMGtt6u+sTaOCpDBCZ39ODGCVXRXlhEtL4or1yOh3Ghc2nR+0E
         qfghEOLFe1z1f8DUoU1nfFOsMUK5VZAL6iocbhi6XnsvHuvXvnqbKjcshU9q36Xf7U
         2OXMqCrUrXRQ8hf+S6IMZQT3A4ffVJXo4KISdU9RzwhjKztr25riiRGXhvqB3XpUDy
         RRCP72ZcuhkVw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJJUOh3560234;
        Mon, 17 Jun 2019 12:19:30 -0700
Date:   Mon, 17 Jun 2019 12:19:30 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-1k8lhyjxfk7o8v4g3r7eyjc9@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, hpa@zytor.com, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
          acme@redhat.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evsel: Remove superfluous nthreads system_wide
 setup in alloc_fd()
Git-Commit-ID: 10981c8012bc9ad4119420716a5dccfe8043b596
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

Commit-ID:  10981c8012bc9ad4119420716a5dccfe8043b596
Gitweb:     https://git.kernel.org/tip/10981c8012bc9ad4119420716a5dccfe8043b596
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 May 2019 13:33:47 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf evsel: Remove superfluous nthreads system_wide setup in alloc_fd()

It's already setup in the only caller of this method in
perf_evsel__open(), right before calling perf_evsel__alloc_fd(), no need
to do it again.

Also it's better to have it out of the function before we move it to
libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1k8lhyjxfk7o8v4g3r7eyjc9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 9f3b58071863..68beef8f47ff 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1148,9 +1148,6 @@ void perf_evsel__config(struct perf_evsel *evsel, struct record_opts *opts,
 
 static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 {
-	if (evsel->system_wide)
-		nthreads = 1;
-
 	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
 
 	if (evsel->fd) {
