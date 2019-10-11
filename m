Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8478CECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DE2222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824646;
	bh=t7VeL7fbADHRyzTdPSkLFIY6peE4Wd6xyMh/un+MFs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vDTem0dmVF9di7UOdPg0vVy5kN7iMPpSlyPA7yGxbmfX4hodzKjDHbRPPIcwmyRrh
	 DT5vWxUM0NIenA/gm2UQ4SRLmJjJkuCe6qSlgQKNS/kxW51BbOFfTicOUSRzUWp+gc
	 bDqSuB17lu3lej55AaFfbVtlTAvZbq+r/zxvZc5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfJKUKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbfJKUKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:10:41 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28853222D1;
        Fri, 11 Oct 2019 20:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824640;
        bh=t7VeL7fbADHRyzTdPSkLFIY6peE4Wd6xyMh/un+MFs0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c5CImgkBmL/bK4caJv4uQMvB0pCvABdg5xy4UoivlB34endfc70HZHuW4/xmmrxoA
         fzj24WlO8v0qIOFl2DG6UHJaILeeH5nZDgApxIpkJFNC9fwo9SrzBxnIGe4I/XfzaP
         wc0SAYp3q8s1WQGGacLIUqhCASeu4HkSDEZIt4Ks=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 49/69] perf tools: Use perf_mmap way to detect aux mmap
Date:   Fri, 11 Oct 2019 17:05:39 -0300
Message-Id: <20191011200559.7156-50-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We will move this code to libperf shortly, so we need to free it of
'struct auxtrace_mmap' usage, because it won't be available in libperf
(for now).

The perf_event_mmap_page::aux_size is set when the aux mmap is mapped,
so the check is equivalent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 9f150d50cea5..f246dd403507 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -107,7 +107,9 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 
 static bool perf_mmap__empty(struct mmap *map)
 {
-	return perf_mmap__read_head(map) == map->core.prev && !map->auxtrace_mmap.base;
+	struct perf_event_mmap_page *pc = map->core.base;
+
+	return perf_mmap__read_head(map) == map->core.prev && !pc->aux_size;
 }
 
 void perf_mmap__consume(struct mmap *map)
-- 
2.21.0

