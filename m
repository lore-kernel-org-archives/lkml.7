Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438FBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1207B20652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611131;
	bh=NhXdt7TgWnNs+QEsbVp2LFmUXZjDpAh4OV8VssSm5fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gLoVoxJwSUYjKg3e1qsCI9iVIT2Zro7j5Qh7Tt+n01OSjbkyP9sa1cB1cevowgcVM
	 /Gs5o5qJets5Y5d1eWzCPRueJpGefNY6aUXFju1vWQ7otpPQ1IRV4Nl7WpoIGA98+G
	 N//earylct9oDwmzXlnCLukjmtWto5ooPHpFdu3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391993AbfDRSMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391980AbfDRSMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B2D921871;
        Thu, 18 Apr 2019 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611126;
        bh=NhXdt7TgWnNs+QEsbVp2LFmUXZjDpAh4OV8VssSm5fI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLcmpgExJWdyUsbvpLdyBytynHIyCsrqfApDK7pp9W/Sqo1VYw2qG5O5p/77jxpi7
         nBuvgfmbSKd6oP7EOT5RlZ3u2tf45PlKj5g/87UaS7TED/1bZJ7pXQO5V8pI4zGEm5
         bCjJHY0ulgOh2v7BIzsJqS4EbBPsUyTYhuIgr6zE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 35/93] perf tools: Fix errors under optimization level -Og
Date:   Thu, 18 Apr 2019 19:57:13 +0200
Message-Id: <20190418160440.660287035@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 11c1ea6f1a9bc97bf857fd12f72eacb6c69794e2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c                  | 2 +-
 tools/perf/bench/epoll-ctl.c            | 2 +-
 tools/perf/bench/epoll-wait.c           | 2 +-
 tools/perf/tests/backward-ring-buffer.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 169e347c76f6..9ba1a2e1ed7a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -627,7 +627,7 @@ bpf_object__init_maps(struct bpf_object *obj, int flags)
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
2.19.1



