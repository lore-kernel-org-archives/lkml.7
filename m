Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECDCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62C7218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfCVW1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:27:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48391 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbfCVW1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:27:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMQ5UB752764
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:26:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMQ5o3752761;
        Fri, 22 Mar 2019 15:26:05 -0700
Date:   Fri, 22 Mar 2019 15:26:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-11c1ea6f1a9bc97bf857fd12f72eacb6c69794e2@git.kernel.org>
Cc:     namhyung@kernel.org, daniel@iogearbox.net, hpa@zytor.com,
        jolsa@kernel.org, acme@redhat.com, changbin.du@gmail.com,
        rostedt@goodmis.org, ast@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: ast@kernel.org, mingo@kernel.org, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, daniel@iogearbox.net, hpa@zytor.com,
          jolsa@kernel.org, acme@redhat.com, changbin.du@gmail.com,
          rostedt@goodmis.org
In-Reply-To: <20190316080556.3075-4-changbin.du@gmail.com>
References: <20190316080556.3075-4-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Fix errors under optimization level
 '-Og'
Git-Commit-ID: 11c1ea6f1a9bc97bf857fd12f72eacb6c69794e2
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

Commit-ID:  11c1ea6f1a9bc97bf857fd12f72eacb6c69794e2
Gitweb:     https://git.kernel.org/tip/11c1ea6f1a9bc97bf857fd12f72eacb6c69794e2
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:43 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:04 -0300

perf tools: Fix errors under optimization level '-Og'

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
