Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FB5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2546A217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665274;
	bh=tV6/iS+kVjkZcrFcXhihROUnJfuveuZdiIJ97fDA978=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dyx+koLoZNXIhrswOneCGKErdwGwvd26ZQV7edPKlgNVfrU69AuwFVyKBBFEAxVFc
	 cMYKXDlWi0F+ABI1LEhQqqwAt05JvChLTQnkv2IXp+qSj1sA5qNYEpt21kInAfVnUa
	 QqiH35xo3W4V+UMdSICo09oVAttbz1dT/R5+vJAc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbfJUNlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbfJUNlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:41:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91E3621872;
        Mon, 21 Oct 2019 13:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665269;
        bh=tV6/iS+kVjkZcrFcXhihROUnJfuveuZdiIJ97fDA978=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENAnVInkkTtWesZvYDhP1H7tlzKGluQMUxpg+A15Mg259PjQ5LvHoaSSLoOggK9dE
         rrNnZd2Kz7XKKld1j5yLsXOa7CSq+UfnMmdf7vlNsQoIj95V4blw1FsdOEoKQ1QW01
         GxFz3Km944iQPw/VpmpkPKqWV32/R9J2IgPdLa/E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 45/57] libperf: Move mask setup to perf_evlist__mmap_ops()
Date:   Mon, 21 Oct 2019 10:38:22 -0300
Message-Id: <20191021133834.25998-46-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the mask setup to perf_evlist__mmap_ops(), because it's the same on
both perf and libperf path.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Link: http://lore.kernel.org/lkml/20191017105918.20873-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/evlist.c  | 3 ++-
 tools/perf/util/evlist.c | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 73aac6bb2ac5..205ddbb80bc1 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -578,6 +578,8 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (!ops || !ops->get || !ops->mmap)
 		return -EINVAL;
 
+	mp->mask = evlist->mmap_len - page_size - 1;
+
 	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
 
 	perf_evlist__for_each_entry(evlist, evsel) {
@@ -605,7 +607,6 @@ int perf_evlist__mmap(struct perf_evlist *evlist, int pages)
 	};
 
 	evlist->mmap_len = (pages + 1) * page_size;
-	mp.mask = evlist->mmap_len - page_size - 1;
 
 	return perf_evlist__mmap_ops(evlist, &ops, &mp);
 }
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 5cded4ec5806..fdce590d2278 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -813,7 +813,6 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
-	mp.core.mask = evlist->core.mmap_len - page_size - 1;
 
 	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
-- 
2.21.0

