Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BDCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B1E2192D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194366;
	bh=12VZynzVXWWQDN2rHiT65elYepLvPeDrMQt5ejjJvdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tFyYf3ewEy3jHojGWqIaEEdtcJ42B/sM2/1Nj4jFn9x1wV4ap0eiYLaS5WE62ZaSP
	 eGTFCBInw7KzgbRLXfJZqk2UeFDj/BlHv05M/IrvkIJnlv8r4zy1mRkwl82M7ADUIw
	 oVPJLaWxN2pYvYK+ehFWH/uj4j4ppX1LvrAkR4xU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfCUSwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbfCUSwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:52:43 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2FB21916;
        Thu, 21 Mar 2019 18:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194362;
        bh=12VZynzVXWWQDN2rHiT65elYepLvPeDrMQt5ejjJvdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=shtAgxNjmqUCHK/kxN/ylYwqvSju2K2SRQ8HrQK483DUpBVnpDZypQTHCz0crb4O5
         iEUw0Eo2xTq9BatDuCQN/zAQzwI/y8pkiKVlDvMlPrqoBEJAxBc/JMAM6ktfZxhinv
         dw2H2K+f09Ngf8IYs5svr5yAXZBPwHGKgLcZeAF4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/44] perf tools: Fix errors under optimization level '-Og'
Date:   Thu, 21 Mar 2019 15:51:10 -0300
Message-Id: <20190321185142.11441-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Optimization level '-Og' offers a reasonable level of optimization while
maintaining fast compilation and a good debugging experience. This patch
tries to make it work.

  $ make DEBUG=1 EXTRA_CFLAGS='-Og'
  bench/epoll-ctl.c: In function ‘do_threads’:
  bench/epoll-ctl.c:274:9: error: ‘ret’ may be used uninitialized in this function [-Werror=maybe-uninitialized]
    return ret;
           ^~~
  ...

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20190316080556.3075-4-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/bpf/libbpf.c                  | 2 +-
 tools/perf/bench/epoll-ctl.c            | 2 +-
 tools/perf/bench/epoll-wait.c           | 2 +-
 tools/perf/tests/backward-ring-buffer.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f5eb60379c8d..4884557aa17f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -622,7 +622,7 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
 	bool strict = !(flags & MAPS_RELAX_COMPAT);
 	int i, map_idx, map_def_sz, nr_maps = 0;
 	Elf_Scn *scn;
-	Elf_Data *data;
+	Elf_Data *data = NULL;
 	Elf_Data *symbols = obj->efile.symbols;
 
 	if (obj->efile.maps_shndx < 0)
diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index 0c0a6e824934..2af067859966 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -224,7 +224,7 @@ static int do_threads(struct worker *worker, struct cpu_map *cpu)
 	pthread_attr_t thread_attr, *attrp = NULL;
 	cpu_set_t cpuset;
 	unsigned int i, j;
-	int ret;
+	int ret = 0;
 
 	if (!noaffinity)
 		pthread_attr_init(&thread_attr);
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 5a11534e96a0..fe85448abd45 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -293,7 +293,7 @@ static int do_threads(struct worker *worker, struct cpu_map *cpu)
 	pthread_attr_t thread_attr, *attrp = NULL;
 	cpu_set_t cpuset;
 	unsigned int i, j;
-	int ret, events = EPOLLIN;
+	int ret = 0, events = EPOLLIN;
 
 	if (oneshot)
 		events |= EPOLLONESHOT;
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 6d598cc071ae..1a9c3becf5ff 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -18,7 +18,7 @@ static void testcase(void)
 	int i;
 
 	for (i = 0; i < NR_ITERS; i++) {
-		char proc_name[10];
+		char proc_name[15];
 
 		snprintf(proc_name, sizeof(proc_name), "p:%d\n", i);
 		prctl(PR_SET_NAME, proc_name);
-- 
2.20.1

