Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209F7C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE05206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCIT7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:59:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:45153 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfCIT7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:59:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JxYF13203236
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:59:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JxY6R3203233;
        Sat, 9 Mar 2019 11:59:34 -0800
Date:   Sat, 9 Mar 2019 11:59:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-153259382633ecbbc0af4f3f0b6515757ebe2984@git.kernel.org>
Cc:     namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        ak@linux.intel.com, acme@redhat.com, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, jolsa@kernel.org, acme@redhat.com,
          linux-kernel@vger.kernel.org, ak@linux.intel.com
In-Reply-To: <20190305144758.12397-2-andi@firstfloor.org>
References: <20190305144758.12397-2-andi@firstfloor.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf thread: Generalize function to copy from
 thread addr space from intel-bts code
Git-Commit-ID: 153259382633ecbbc0af4f3f0b6515757ebe2984
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

Commit-ID:  153259382633ecbbc0af4f3f0b6515757ebe2984
Gitweb:     https://git.kernel.org/tip/153259382633ecbbc0af4f3f0b6515757ebe2984
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Wed, 6 Mar 2019 17:55:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 17:55:35 -0300

perf thread: Generalize function to copy from thread addr space from intel-bts code

Add a utility function to fetch executable code. Convert one
user over to it. There are more places doing that, but they
do significantly different actions, so they are not
easy to fit into a single library function.

Committer changes:

. No need to cast around, make 'buf' be a void pointer.

. Rename it to thread__memcpy() to reflect the fact it is about copying
  a chunk of memory from a thread, i.e. from its address space.

. No need to have it in a separate object file, move it to thread.[ch]

. Check the return of map__load(), the original code didn't do it, but
  since we're moving this around, check that as well.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190305144758.12397-2-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c | 20 ++------------------
 tools/perf/util/thread.c    | 23 +++++++++++++++++++++++
 tools/perf/util/thread.h    |  3 +++
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 0c0180c67574..47025bc727e1 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -328,35 +328,19 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
 {
 	struct machine *machine = btsq->bts->machine;
 	struct thread *thread;
-	struct addr_location al;
 	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
 	ssize_t len;
-	int x86_64;
-	uint8_t cpumode;
+	bool x86_64;
 	int err = -1;
 
-	if (machine__kernel_ip(machine, ip))
-		cpumode = PERF_RECORD_MISC_KERNEL;
-	else
-		cpumode = PERF_RECORD_MISC_USER;
-
 	thread = machine__find_thread(machine, -1, btsq->tid);
 	if (!thread)
 		return -1;
 
-	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
-		goto out_put;
-
-	len = dso__data_read_addr(al.map->dso, al.map, machine, ip, buf,
-				  INTEL_PT_INSN_BUF_SZ);
+	len = thread__memcpy(thread, machine, buf, ip, INTEL_PT_INSN_BUF_SZ, &x86_64);
 	if (len <= 0)
 		goto out_put;
 
-	/* Load maps to ensure dso->is_64_bit has been updated */
-	map__load(al.map);
-
-	x86_64 = al.map->dso->is_64_bit;
-
 	if (intel_pt_get_insn(buf, len, x86_64, &btsq->intel_pt_insn))
 		goto out_put;
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 4c179fef442d..50678d318185 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -12,6 +12,7 @@
 #include "debug.h"
 #include "namespaces.h"
 #include "comm.h"
+#include "map.h"
 #include "symbol.h"
 #include "unwind.h"
 
@@ -393,3 +394,25 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 	return machine__find_thread(machine, thread->pid_, thread->pid_);
 }
+
+int thread__memcpy(struct thread *thread, struct machine *machine,
+		   void *buf, u64 ip, int len, bool *is64bit)
+{
+       u8 cpumode = PERF_RECORD_MISC_USER;
+       struct addr_location al;
+       long offset;
+
+       if (machine__kernel_ip(machine, ip))
+               cpumode = PERF_RECORD_MISC_KERNEL;
+
+       if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso ||
+	   al.map->dso->data.status == DSO_DATA_STATUS_ERROR ||
+	   map__load(al.map) < 0)
+               return -1;
+
+       offset = al.map->map_ip(al.map, ip);
+       if (is64bit)
+               *is64bit = al.map->dso->is_64_bit;
+
+       return dso__data_read_offset(al.map->dso, machine, offset, buf, len);
+}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8276ffeec556..cf8375c017a0 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -113,6 +113,9 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
 
+int thread__memcpy(struct thread *thread, struct machine *machine,
+		   void *buf, u64 ip, int len, bool *is64bit);
+
 static inline void *thread__priv(struct thread *thread)
 {
 	return thread->priv;
