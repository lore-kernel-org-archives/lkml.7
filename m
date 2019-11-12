Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C9BC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D7F214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573583932;
	bh=kWkgkVQLDYGB8bt/GX3iea+zCLJGp0N1t/w7+/bbqmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QShw9NnHgroOYOfuqn6vAw30BfgVbUi6WYnKThstNIiXNzzXU/HWjb4TVs4Th6NHC
	 nLo7g2EyEpHheeX7j7Z4uKxGjbJe43ZtXgJQCeYbL8+2FrOPWnmiLUJHso68WypXRZ
	 kuHxIdNPSWvb09WQy3TZCJpYLWU01Ojra17mD+9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfKLSiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:38:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727265AbfKLSit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:38:49 -0500
Received: from quaco.ghostprotocols.net (unknown [177.195.211.83])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B43B20818;
        Tue, 12 Nov 2019 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573583928;
        bh=kWkgkVQLDYGB8bt/GX3iea+zCLJGp0N1t/w7+/bbqmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZFC2hdF7Bx58k7Ywum/MTQbDuf5OmgcHWYOkh04FJAnUzjIip+clmTPwDg70oWBU
         wC4WpPvgOGLDQGczPxs1FTSi2TXODGu34VqHT8YM1Z5G0neBZhMxYTrzu4duJl696F
         h/kRZK6fOmDcefyeCIaxHaPnZbM3GeChiqikNY70=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 10/15] perf tools: Add a 'struct map_groups' pointer to 'struct map_symbol'
Date:   Tue, 12 Nov 2019 15:37:52 -0300
Message-Id: <20191112183757.28660-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And fill it whenever we setup a a 'struct map_symbol', now we need to
use it, next cset.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fzwfcnddenz1o7uj1fzw3g46@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c              | 1 +
 tools/perf/util/hist.c                   | 4 ++++
 tools/perf/util/machine.c                | 3 +++
 tools/perf/util/map_symbol.h             | 2 ++
 tools/perf/util/unwind-libdw.c           | 1 +
 tools/perf/util/unwind-libunwind-local.c | 1 +
 6 files changed, 12 insertions(+)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8f89c5a4781f..5cefce33b66b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1106,6 +1106,7 @@ int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *samp
 int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
 			bool hide_unresolved)
 {
+	al->mg	= node->ms.mg;
 	al->map = node->ms.map;
 	al->sym = node->ms.sym;
 	al->srcline = node->srcline;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index dec996133cdf..0a8d72ae93ca 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -692,6 +692,7 @@ __hists__add_entry(struct hists *hists,
 			.ino = ns ? ns->link_info[CGROUP_NS_INDEX].ino : 0,
 		},
 		.ms = {
+			.mg	= al->mg,
 			.map	= al->map,
 			.sym	= al->sym,
 		},
@@ -759,6 +760,7 @@ struct hist_entry *hists__add_entry_block(struct hists *hists,
 		.block_info = block_info,
 		.hists = hists,
 		.ms = {
+			.mg  = al->mg,
 			.map = al->map,
 			.sym = al->sym,
 		},
@@ -893,6 +895,7 @@ iter_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
 	if (iter->curr >= iter->total)
 		return 0;
 
+	al->mg  = bi[i].to.ms.mg;
 	al->map = bi[i].to.ms.map;
 	al->sym = bi[i].to.ms.sym;
 	al->addr = bi[i].to.addr;
@@ -1069,6 +1072,7 @@ iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
 		.comm = thread__comm(al->thread),
 		.ip = al->addr,
 		.ms = {
+			.mg  = al->mg,
 			.map = al->map,
 			.sym = al->sym,
 		},
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 614094d87f05..6a0f5c25ce3e 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1968,6 +1968,7 @@ static void ip__resolve_ams(struct thread *thread,
 
 	ams->addr = ip;
 	ams->al_addr = al.addr;
+	ams->ms.mg  = al.mg;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = 0;
@@ -1985,6 +1986,7 @@ static void ip__resolve_data(struct thread *thread,
 
 	ams->addr = addr;
 	ams->al_addr = al.addr;
+	ams->ms.mg  = al.mg;
 	ams->ms.sym = al.sym;
 	ams->ms.map = al.map;
 	ams->phys_addr = phys_addr;
@@ -2101,6 +2103,7 @@ static int add_callchain_ip(struct thread *thread,
 		iter_cycles = iter->cycles;
 	}
 
+	ms.mg  = al.mg;
 	ms.map = al.map;
 	ms.sym = al.sym;
 	srcline = callchain_srcline(&ms, al.addr);
diff --git a/tools/perf/util/map_symbol.h b/tools/perf/util/map_symbol.h
index f71cbe1a26a9..2964d971aeab 100644
--- a/tools/perf/util/map_symbol.h
+++ b/tools/perf/util/map_symbol.h
@@ -4,10 +4,12 @@
 
 #include <linux/types.h>
 
+struct map_groups;
 struct map;
 struct symbol;
 
 struct map_symbol {
+	struct map_groups *mg;
 	struct map    *map;
 	struct symbol *sym;
 };
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 73c00d776a5f..d2a8df01c4a7 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -81,6 +81,7 @@ static int entry(u64 ip, struct unwind_info *ui)
 		return -1;
 
 	e->ip	  = ip;
+	e->ms.mg  = al.mg;
 	e->ms.map = al.map;
 	e->ms.sym = al.sym;
 
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index 6e3873dd9a31..6d53347d6744 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -578,6 +578,7 @@ static int entry(u64 ip, struct thread *thread,
 	e.ms.sym = thread__find_symbol(thread, PERF_RECORD_MISC_USER, ip, &al);
 	e.ip     = ip;
 	e.ms.map = al.map;
+	e.ms.mg  = al.mg;
 
 	pr_debug("unwind: %s:ip = 0x%" PRIx64 " (0x%" PRIx64 ")\n",
 		 al.sym ? al.sym->name : "''",
-- 
2.21.0

