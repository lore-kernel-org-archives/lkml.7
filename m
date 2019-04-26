Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502F2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23361206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556264289;
	bh=mRXuhjLbOGTpJ0v5E3I1EoiWfYKwFwJP8uYncEc65iA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bfZG60AErAx/yyvtX8G+jBwzPJu92Ford6AKdom6GJeDRqLjalkyLaRf1Au+fZwXE
	 w2LSV3BqQ5uXOI0Yr5Yxd2YazGQVKiJikGep+2Udjrypq6p9kzNL5ay2GpaOyEkS88
	 +6gfYzTBgCdqx3Se1qZbH0P3GHpqtBiJWzeIK0jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfDZHiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:38:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52610 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfDZHiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:38:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 011BB3082132;
        Fri, 26 Apr 2019 07:38:07 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 707ED5D71A;
        Fri, 26 Apr 2019 07:38:05 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf tools: Speed up report for perf compiled with linwunwind
Date:   Fri, 26 Apr 2019 09:38:04 +0200
Message-Id: <20190426073804.17238-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 26 Apr 2019 07:38:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiled with libunwind, perf does some preparatory work
when processing side-band events. This is not needed when report
actually don't unwind dwarf callchains, so it's disabled with
dwarf_callchain_users bool.

However we could move that check to higher level and shield more
unwanted code for normal report processing, giving us following
speed up on kernel build profile:

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

Link: http://lkml.kernel.org/n/tip-rqm3489ghqq07fdrcpniynfs@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
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

