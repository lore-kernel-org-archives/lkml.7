Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13E2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6C2218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NiI80oTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfCPIGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:06:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38501 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfCPIGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:06:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id v1so3300262pgi.5;
        Sat, 16 Mar 2019 01:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BatEiN8TSrqKTiuAG+kfnJ6RuvMPntciT2BLT6L9U0=;
        b=NiI80oTxugyn8Gzkke8Q+wHZzqSsJFlBbzbF+s0tzWXPCfO4T1ePk9MKIIfeY7O+ax
         wnUB9iCKMMUC930SpeZIIsgTR9G8rflHnU3CWxt1KDFf1kvVIm4KOAHS2TO1BnLcXxSo
         uVS45utCizDVyAUlNnhSRcbL5yodwtgCERI86SZJBXv8cNSFCtMYpEemG31gbiNuXgtZ
         scypJaejQl7sGky+FEMLYcjfOC8mRIYEZXgYuorVoJlKgemSd6hns2uAr/PBeA7sePjK
         eora+7AEIsZ1Ou7FdPYITt288PPykM8pXLi8U+aGyCFxj3WoXPcbFk2gxGcvy1OC8cAZ
         O2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BatEiN8TSrqKTiuAG+kfnJ6RuvMPntciT2BLT6L9U0=;
        b=MzmNT76HfsFhtlarDWM2CJkmsX7T7H4apZJX2zhf5EsQ18qTqGkM3KQuiJePQ+EaZm
         nPVwQM7zntmnv6UMRJvbmd0Re9uElO3uACNT6yeDWWstv7XB9vlj6zovVGPQOn1dVFLp
         NuexZLbcZ0IL90lkSERpWURj73VSafKIYqjBdwsa9B36sz/vErAYiCRrURwKUDDo/mzC
         lKfZhL7/mRESVRl08s9CdaPNxvaHmWOnNgndG3q/U1aH3tX63PP7YYARi84gFajo//dd
         FzcIxsnGtgTfiyByqYuzJFbb2/jkDpZppwg0sueYu2eNznOL/ak98mMaVkTfxjUfwB3N
         ktNQ==
X-Gm-Message-State: APjAAAVEhtM03zJHN3M1PFtiV8ahmIEofJ88OV4vuvNcfWGfa86zarlS
        OfUS9MoqazViJivKq8Xq04Y=
X-Google-Smtp-Source: APXvYqxQWKTx+YhBBG6y+CifqGRzwRj4YRJXdeStDZ4LYNFw+a3tbhOB3MZ7DCfzmbKByL72bfY1UA==
X-Received: by 2002:a63:e101:: with SMTP id z1mr7546298pgh.190.1552723602542;
        Sat, 16 Mar 2019 01:06:42 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:06:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 03/16] perf: fix errors under optimization level '-Og'
Date:   Sat, 16 Mar 2019 16:05:43 +0800
Message-Id: <20190316080556.3075-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 tools/lib/bpf/libbpf.c                  | 2 +-
 tools/perf/bench/epoll-ctl.c            | 2 +-
 tools/perf/bench/epoll-wait.c           | 2 +-
 tools/perf/tests/backward-ring-buffer.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d5b830d60601..a37dac0a016e 100644
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
2.19.1

