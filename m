Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A38C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBCA32166E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GNNwsoP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfERIqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:46:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50549 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfERIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:46:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8kLWp1731480
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:46:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8kLWp1731480
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169182;
        bh=jzKe6OoXGUczvNJ7aYNFg9+utOHpMMn5yu7IoexwlAs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GNNwsoP/yAZEePMyY1aETwN7z0rRH01i7kPYNdI3k1au1WXg4rQ++KVI0SoVoGmF6
         PO/xYgsobMBWpDbml39fdfDTBhP2IgYE96ai1Pe9/Z+QSZhpsn8Iv0GnRt3Z/6t/J3
         0k+5Dh6wElDhjeLGZ1jDvAlFYPNDbUz3eHYuQvfDTF64ITImnWznydtsK5HkPssKym
         oTwso+yZtU9LvExj+ZNMuZMLoaO5XfkgqobWjqzLklJlcm8cK8fdhNj/IbfgBynbGy
         VzD3ekS4cIRZjFOrK13zlCewjmS7qY5yDjM+GWu1nCtrZBwIeAdgx9qUpZIcjluhkQ
         C/PEHbgo8DilA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8kE4D1731455;
        Sat, 18 May 2019 01:46:14 -0700
Date:   Sat, 18 May 2019 01:46:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jin Yao <tipbot@zytor.com>
Message-ID: <tip-bdd1666b3d03d675bdb7f8d92b29f2797acbc5e8@git.kernel.org>
Cc:     acme@redhat.com, ak@linux.intel.com, peterz@infradead.org,
        kan.liang@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
        yao.jin@intel.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de
Reply-To: mingo@kernel.org, tglx@linutronix.de,
          alexander.shishkin@linux.intel.com, yao.jin@intel.com,
          hpa@zytor.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
          peterz@infradead.org, kan.liang@linux.intel.com,
          yao.jin@linux.intel.com, ak@linux.intel.com, acme@redhat.com
In-Reply-To: <1552684577-29041-1-git-send-email-yao.jin@linux.intel.com>
References: <1552684577-29041-1-git-send-email-yao.jin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Remove hist__account_cycles() from
 callback
Git-Commit-ID: bdd1666b3d03d675bdb7f8d92b29f2797acbc5e8
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

Commit-ID:  bdd1666b3d03d675bdb7f8d92b29f2797acbc5e8
Gitweb:     https://git.kernel.org/tip/bdd1666b3d03d675bdb7f8d92b29f2797acbc5e8
Author:     Jin Yao <yao.jin@linux.intel.com>
AuthorDate: Sat, 16 Mar 2019 05:16:17 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

perf annotate: Remove hist__account_cycles() from callback

The hist__account_cycles() function is executed when the
hist_iter__branch_callback() is called.

But it looks it's not necessary.  In hist__account_cycles, it already
walks on all branch entries.

This patch moves the hist__account_cycles out of callback, now the data
processing is much faster than before.

Previous code has an issue that the ch[offset].num++ (in
__symbol__account_cycles) is executed repeatedly since
hist__account_cycles is called in each hist_iter__branch_callback, so
the counting of ch[offset].num is not correct (too big).

With this patch, the issue is fixed. And we don't need the code of
"ch->reset >= ch->num / 2" to check if there are too many overlaps (in
annotation__count_and_fill), otherwise some data would be hidden.

Now, we can try, for example:

  perf record -b ...
  perf annotate or perf report -s symbol

The before/after output should be no change.

 v3:
 ---
 Fix the crash in stdio mode.
 Like previous code, it needs the checking of ui__has_annotation()
 before hist__account_cycles()

 v2:
 ---
 1. Cover the similar perf report
 2. Remove the checking code "ch->reset >= ch->num / 2"

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1552684577-29041-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c |  4 ++--
 tools/perf/builtin-report.c   | 11 +++++------
 tools/perf/util/annotate.c    |  2 +-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 67f9d9ffacfb..77deb3a40596 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -159,8 +159,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 	int err;
 
-	hist__account_cycles(sample->branch_stack, al, sample, false);
-
 	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 
@@ -199,6 +197,8 @@ static int process_branch_callback(struct perf_evsel *evsel,
 	if (a.map != NULL)
 		a.map->dso->hit = 1;
 
+	hist__account_cycles(sample->branch_stack, al, sample, false);
+
 	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
 	return ret;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4054eb1f98ac..91e27ac297c2 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -136,9 +136,6 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	hist__account_cycles(sample->branch_stack, al, sample,
-			     rep->nonany_branch_mode);
-
 	if (sort__mode == SORT_MODE__BRANCH) {
 		bi = he->branch_info;
 		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
@@ -181,9 +178,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	if (!ui__has_annotation() && !rep->symbol_ipc)
 		return 0;
 
-	hist__account_cycles(sample->branch_stack, al, sample,
-			     rep->nonany_branch_mode);
-
 	bi = he->branch_info;
 	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 	if (err)
@@ -282,6 +276,11 @@ static int process_sample_event(struct perf_tool *tool,
 	if (al.map != NULL)
 		al.map->dso->hit = 1;
 
+	if (ui__has_annotation() || rep->symbol_ipc) {
+		hist__account_cycles(sample->branch_stack, &al, sample,
+				     rep->nonany_branch_mode);
+	}
+
 	ret = hist_entry_iter__add(&iter, &al, rep->max_stack, rep);
 	if (ret < 0)
 		pr_debug("problem adding hist entry, skipping event\n");
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 09762985c713..0b8573fd9b05 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1021,7 +1021,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 		float ipc = n_insn / ((double)ch->cycles / (double)ch->num);
 
 		/* Hide data when there are too many overlaps. */
-		if (ch->reset >= 0x7fff || ch->reset >= ch->num / 2)
+		if (ch->reset >= 0x7fff)
 			return;
 
 		for (offset = start; offset <= end; offset++) {
