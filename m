Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1916AC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D964520872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aHPZoXQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbfERItT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:49:19 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41937 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERItT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:49:19 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8n6DW1731906
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:49:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8n6DW1731906
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169347;
        bh=bU2FxHe30nLVpx1WLyjV37uuwWtqn3kee6b/esey+XI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aHPZoXQB7KSG8736qUJU2tymiGzl+JUM4R75OswOp+JfJIVVKR30+ls1D3rAOtP4U
         jzJuJQdLHkx7rXW1KpImBXGc+PkVnIO92i9YuZ7ijCZkzJTe8O5OHoFsEiEoV9e2uY
         EEszYfgChnmnNQRA8WTo7wfd9iW8tbpnqdTKc9SxAXPGReaYFxAuay0s+d82+KvkUy
         iiU4pQw7lNfYlRhvSNzR0AQq5Nhdd8zR+IUvHDEz1ndSKJehqpSRnt+0Cgdf6/A813
         l8ek6AlmBcKptgvS/aDg2THOjIykas15ML3fjso9joAZu5WvYlMRHoM4fFHwnt4PQX
         dmrpvScKiiq6A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8n6qQ1731903;
        Sat, 18 May 2019 01:49:06 -0700
Date:   Sat, 18 May 2019 01:49:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-382619c07ff6491b33d54fccff7407336ddcb6d4@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, jolsa@kernel.org, mingo@kernel.org, hpa@zytor.com,
        peterz@infradead.org
Reply-To: acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
          mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          namhyung@kernel.org, linux-kernel@vger.kernel.org,
          alexander.shishkin@linux.intel.com
In-Reply-To: <20190426073804.17238-1-jolsa@kernel.org>
References: <20190426073804.17238-1-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Speed up report for perf compiled with
 linwunwind
Git-Commit-ID: 382619c07ff6491b33d54fccff7407336ddcb6d4
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

Commit-ID:  382619c07ff6491b33d54fccff7407336ddcb6d4
Gitweb:     https://git.kernel.org/tip/382619c07ff6491b33d54fccff7407336ddcb6d4
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 26 Apr 2019 09:38:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

perf tools: Speed up report for perf compiled with linwunwind

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
@@ -65,12 +69,18 @@ out_register:
 
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
