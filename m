Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940D2C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F817216FD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558121814;
	bh=QS66hGG5BEdHzYiE0IDk8s9h8+64bA38yOAyrLzNqw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STlLCpigm6xg0sNQXr9IM29T/HxbQcg9aCJkYZPJHbNwTA60s+8RUIwu/WSuTnKjV
	 8NbE+61yJ9OQfrlBi3rjPyzzZTkjUTLT0/UdEaOzvUgrIQJQAay6B5wv2Dr8bXTX5z
	 147NIIm4iagunl+WpOeRkQRjdKKj+NTJGiEvrVUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbfEQTgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 15:36:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfEQTgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 15:36:50 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB6B21734;
        Fri, 17 May 2019 19:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558121809;
        bh=QS66hGG5BEdHzYiE0IDk8s9h8+64bA38yOAyrLzNqw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1rHYsGjeiX84AWUh5qstTW2+YZaiJ0n9U+qzXg/O8qDK7JeKSSVS00K/9qy8YiEVj
         o4Xsw2tA0wNskU8aWyp8hChdm01Sr6qwwiWbAH5Os1dBFpdNtBAV4fIz7KGCfwzELP
         DYef7snDvy71tFN+uBWONSsQk02eGxJdJCoyPFRc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/73] perf tools: Speed up report for perf compiled with linwunwind
Date:   Fri, 17 May 2019 16:35:03 -0300
Message-Id: <20190517193611.4974-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517193611.4974-1-acme@kernel.org>
References: <20190517193611.4974-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

When compiled with libunwind, perf does some preparatory work when
processing side-band events. This is not needed when report actually
don't unwind dwarf callchains, so it's disabled with
dwarf_callchain_users bool.

However we could move that check to higher level and shield more
unwanted code for normal report processing, giving us following speed up
on kernel build profile:

Before:

  $ perf record make -j40
  ...
  $ ll ../../perf.data
  -rw-------. 1 jolsa jolsa 461783932 Apr 26 09:11 perf.data
  $ perf stat -e cycles:u,instructions:u perf report -i perf.data > out

   Performance counter stats for 'perf report -i perf.data':

    78,669,920,155      cycles:u
    99,076,431,951      instructions:u            #    1.26  insn per cycle

      55.382823668 seconds time elapsed

      27.512341000 seconds user
      27.712871000 seconds sys

After:

  $ perf stat -e cycles:u,instructions:u perf report -i perf.data > out

   Performance counter stats for 'perf report -i perf.data':

    59,626,798,904      cycles:u
    88,583,575,849      instructions:u            #    1.49  insn per cycle

      21.296935559 seconds time elapsed

      20.010191000 seconds user
       1.202935000 seconds sys

The speed is higher with profile having many side-band events,
because these trigger libunwind preparatory code.

This does not apply for perf compiled with libdw for dwarf unwind,
only for build with libunwind.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190426073804.17238-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c                 |  3 ++-
 tools/perf/util/unwind-libunwind-local.c |  6 ------
 tools/perf/util/unwind-libunwind.c       | 10 ++++++++++
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 50678d318185..403045a2bbea 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -15,6 +15,7 @@
 #include "map.h"
 #include "symbol.h"
 #include "unwind.h"
+#include "callchain.h"
 
 #include <api/fs/fs.h>
 
@@ -327,7 +328,7 @@ static int thread__prepare_access(struct thread *thread)
 {
 	int err = 0;
 
-	if (symbol_conf.use_callchain)
+	if (dwarf_callchain_users)
 		err = __thread__prepare_access(thread);
 
 	return err;
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index f3c666a84e4d..25e1406b1f8b 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -617,8 +617,6 @@ static unw_accessors_t accessors = {
 
 static int _unwind__prepare_access(struct thread *thread)
 {
-	if (!dwarf_callchain_users)
-		return 0;
 	thread->addr_space = unw_create_addr_space(&accessors, 0);
 	if (!thread->addr_space) {
 		pr_err("unwind: Can't create unwind address space.\n");
@@ -631,15 +629,11 @@ static int _unwind__prepare_access(struct thread *thread)
 
 static void _unwind__flush_access(struct thread *thread)
 {
-	if (!dwarf_callchain_users)
-		return;
 	unw_flush_cache(thread->addr_space, 0, 0);
 }
 
 static void _unwind__finish_access(struct thread *thread)
 {
-	if (!dwarf_callchain_users)
-		return;
 	unw_destroy_addr_space(thread->addr_space);
 }
 
diff --git a/tools/perf/util/unwind-libunwind.c b/tools/perf/util/unwind-libunwind.c
index 9778b3133b77..c0811977d7d5 100644
--- a/tools/perf/util/unwind-libunwind.c
+++ b/tools/perf/util/unwind-libunwind.c
@@ -5,6 +5,7 @@
 #include "session.h"
 #include "debug.h"
 #include "env.h"
+#include "callchain.h"
 
 struct unwind_libunwind_ops __weak *local_unwind_libunwind_ops;
 struct unwind_libunwind_ops __weak *x86_32_unwind_libunwind_ops;
@@ -24,6 +25,9 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 	struct unwind_libunwind_ops *ops = local_unwind_libunwind_ops;
 	int err;
 
+	if (!dwarf_callchain_users)
+		return 0;
+
 	if (thread->addr_space) {
 		pr_debug("unwind: thread map already set, dso=%s\n",
 			 map->dso->name);
@@ -65,12 +69,18 @@ int unwind__prepare_access(struct thread *thread, struct map *map,
 
 void unwind__flush_access(struct thread *thread)
 {
+	if (!dwarf_callchain_users)
+		return;
+
 	if (thread->unwind_libunwind_ops)
 		thread->unwind_libunwind_ops->flush_access(thread);
 }
 
 void unwind__finish_access(struct thread *thread)
 {
+	if (!dwarf_callchain_users)
+		return;
+
 	if (thread->unwind_libunwind_ops)
 		thread->unwind_libunwind_ops->finish_access(thread);
 }
-- 
2.20.1

