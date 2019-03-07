Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFADC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA1520661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980873;
	bh=1LdIkuhKiOEs05eq+8MqY1sS/alaPXSH0UZlfhFR7eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D4oZjSQsmXOy61KaxiJYlEOHZb83ftzQHi6kTCavbzNboAvLlOLc3BcUlW4xxUaHH
	 JxQAeyNdG9z1LNfAGq9hklG1Flc8ZhBHPrXkDlgJzLcHr46IHnvJi1W9Xz3KeiZE5j
	 uASI73WSoIYneGlhFIb20FfMssaznTBQ29ezXaXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbfCGRqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:38540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbfCGRqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:10 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942882087C;
        Thu,  7 Mar 2019 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980770;
        bh=1LdIkuhKiOEs05eq+8MqY1sS/alaPXSH0UZlfhFR7eg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gTxI0Ki28uLND+qZm94oJkpjFvxc669OmJwokWTlQjzy31Ly5qYzKuPK0p1o6j0F3
         Qch9I4igKVG0x2VqjMWFIdcqLua4mHien7wsnJu+PW6OD4d+BrMhdlB9h1ckMwg8y2
         w0bMb1qubDspuF+1jSFcRur4vbgDFM70RxaJ3wZQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/35] perf thread: Generalize function to copy from thread addr space from intel-bts code
Date:   Thu,  7 Mar 2019 14:44:18 -0300
Message-Id: <20190307174433.28819-21-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

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
-- 
2.20.1

