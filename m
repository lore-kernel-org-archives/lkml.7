Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731DDC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEB72186A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279726;
	bh=5g1Sh+g6MVJuxYG459abCA0/7ZSzTOL0v+YQVCsttY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c6skpvRy+oUuSEXr2icncjeX9C/wj6iPSMePTsDHMkkQMVFI+stMACShebjsyH+eg
	 p5CYoK+AlYXkgjTFGi2GL06ZnPJJP681lwRW72jqrZXhswOeGmHqJLAWiVxGoN290T
	 VWPH05OBRuv4ZdCYaqMDDil6FDE1bQeagFnYYjic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392340AbfFKTCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391025AbfFKTCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:04 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36DE42183E;
        Tue, 11 Jun 2019 19:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279723;
        bh=5g1Sh+g6MVJuxYG459abCA0/7ZSzTOL0v+YQVCsttY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JwvCsA54GwY21EcKDCR+kLg630IK0t6pzeZ9L2uVmZdb5SeKvRFfYLmwPvaCvqE8P
         eP7oxKDuwqgKsPvlFJJ+Fm4fxC+TP4KyrmG1Ybod+xC8JMcbNw61stQRoHe3zTabTi
         9FTxHHhO3ev3o6R7ZMLAQSJTaeI5ptBr6kWbeBQo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 36/85] perf evsel: Remove superfluous nthreads system_wide setup in alloc_fd()
Date:   Tue, 11 Jun 2019 15:58:22 -0300
Message-Id: <20190611185911.11645-37-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

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
-- 
2.20.1

