Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A560C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03694216FD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562600580;
	bh=r09yOia058PCrGFNgLE5XEV85SDolYpnVtWv4U3LiRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=e28/mnllNEC//bqjPcyCss4/C1asfsPWRFb8sRpNyU/GoDZNzF7Xk+Pt2SwFJ3xRz
	 qjD4BkJi7KJe4DDrhZxvLgUzsfPqnUs/ELtaBQOrd+Xc2/DZCp16sX3C5QdVqTE2j2
	 HWt+KfAoUF4MDGCdZhluUoGcGkrC43jeWuo4yVw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403816AbfGHPm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:42:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389736AbfGHPm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:42:57 -0400
Received: from quaco.ghostprotocols.net (179-240-135-35.3g.claro.net.br [179.240.135.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D6A7217D4;
        Mon,  8 Jul 2019 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562600576;
        bh=r09yOia058PCrGFNgLE5XEV85SDolYpnVtWv4U3LiRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMKh0Ojl07olyBEytwF/pEZ06nqqpqlOV9WCN3pZ4Oyqh2GntqRIDK/AZePZuJBKF
         XFktwTKkybnsac+R5hUNk87+yijESRD5liF+iSN1U6SzyOvEEnLEJxQfSWcdydhigR
         KD9SVa3RdcMgAhv7+P4H7+4yLn47YXz04beC+Nlo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/8] perf evsel: Do not rely on errno values for precise_ip fallback
Date:   Mon,  8 Jul 2019 12:42:03 -0300
Message-Id: <20190708154207.11403-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190708154207.11403-1-acme@kernel.org>
References: <20190708154207.11403-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Konstantin reported problem with default perf record command, which
fails on some AMD servers, because of the default maximum precise
config.

The current fallback mechanism counts on getting ENOTSUP errno for
precise_ip fails, but that's not the case on some AMD servers.

We can fix this by removing the errno check completely, because the
precise_ip fallback is separated. We can just try  (if requested by
evsel->precise_max) all possible precise_ip, and if one succeeds we win,
if not, we continue with standard fallback.

Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Quentin Monnet <quentin.monnet@netronome.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Link: http://lkml.kernel.org/r/20190703080949.10356-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a5947625c5c..69beb9f80f07 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1785,14 +1785,8 @@ static int perf_event_open(struct perf_evsel *evsel,
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
2.20.1

