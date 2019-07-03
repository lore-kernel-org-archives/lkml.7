Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D01AC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5F6218BE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562141406;
	bh=nOUyZ8ZIGy2/2j9YLVpy++Xh6/o5wJDQQ3VzZOkc49o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bPIRc2NXDSn9AxlSuEttMVLoSHVjIUpPVoP6vi9SKkJ0j3ij68w8DiL72xBGIYVAH
	 +RAIThaRmD/0RPGb0RFgNxtVk60JLOO45FFs/UOqPr1ptH08v3GQ4BrmIkjeOATkWP
	 eT53B0dBKx3UGAIkqhD3Okv+QIk7Gb4gGMaV/0QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbfGCIKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 04:10:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfGCIKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 04:10:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E8F8885A04;
        Wed,  3 Jul 2019 08:09:53 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FD605C29A;
        Wed,  3 Jul 2019 08:09:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf tools: Do not rely on errno values for precise_ip fallback
Date:   Wed,  3 Jul 2019 10:09:49 +0200
Message-Id: <20190703080949.10356-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Jul 2019 08:10:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konstantin reported problem with default perf record command,
which fails on some AMD servers, because of the default maximum
precise config.

The current fallback mechanism counts on getting ENOTSUP errno for
precise_ip fails, but that's not the case on some AMD servers.

We can fix this by removing the errno check completely, because the
precise_ip fallback is separated. We can just try  (if requested by
evsel->precise_max) all possible precise_ip, and if one succeeds we
win, if not, we continue with standard fallback.

Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/evsel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5ab31a4a658d..7fb4ae82f34c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1800,14 +1800,8 @@ static int perf_event_open(struct perf_evsel *evsel,
 		if (fd >= 0)
 			break;
 
-		/*
-		 * Do quick precise_ip fallback if:
-		 *  - there is precise_ip set in perf_event_attr
-		 *  - maximum precise is requested
-		 *  - sys_perf_event_open failed with ENOTSUP error,
-		 *    which is associated with wrong precise_ip
-		 */
-		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
+		/* Do not try less precise if not requested. */
+		if (!evsel->precise_max)
 			break;
 
 		/*
-- 
2.21.0

