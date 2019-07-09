Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA1C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04605214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562697142;
	bh=1fBop64o/FMXZjQOW6QlBFcRFBQuKQQI+pbsa0mhF0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahC+7k33BVZ9oOkaEt81CqEjJ3oYvuwqC9MiPntpmsIb5zaNakc2mRp8dFqjhXj0/
	 pOI5c/3aaZnVGuJoxLVzfIIgrOvsvv58XHQ+k0MRlPgNFL4/BHJKpEn5D13JnCduXW
	 t7FahAatAQ7UCI5Q555ZwmH8KTTPR86xsJNpnBoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfGIScU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:32:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfGIScT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:32:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8780321670;
        Tue,  9 Jul 2019 18:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562697139;
        bh=1fBop64o/FMXZjQOW6QlBFcRFBQuKQQI+pbsa0mhF0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xYubdSB8ADpG/lEuXVrf9u7wJ1OilXumYbGJYARJy2bw4tRHrzXklw/8fvDQqIX6L
         CbFOQy9nFXmALv4cSpbh6QUeFP9EARV6TSIp0nQr5B4KusujDZ/taWuVLsoxP6QRl/
         sUOVcdIkwcYpslRjVGDMS5s0UilS+TEfK+PznnAo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 07/25] perf inject: The tool->read() call may pass a NULL evsel, handle it
Date:   Tue,  9 Jul 2019 15:31:08 -0300
Message-Id: <20190709183126.30257-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190709183126.30257-1-acme@kernel.org>
References: <20190709183126.30257-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Check first, as machines__deliver_event() may have
perf_evlist__id2evsel() returning NULL.

This was found while checking a report from Leo Yan that used the smatch
tool to find places where a pointer is checked before use and then,
later in the same function gets used without checking.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-muvb8xqyh0gysgfjfq35w642@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 8e0e06d3edfc..f4591a1438b4 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -224,7 +224,7 @@ static int perf_event__repipe_sample(struct perf_tool *tool,
 				     struct perf_evsel *evsel,
 				     struct machine *machine)
 {
-	if (evsel->handler) {
+	if (evsel && evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
 	}
-- 
2.21.0

