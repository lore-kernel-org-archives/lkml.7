Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5CCC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33352173C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225153;
	bh=W97iYoqobcLZMt3u4WRzTTOyjcoDCDvRMydlZ7S5uA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JtktrT5L1X7Mycp7voGvBwfXd16bVq5LtlIZ+NQySEFyfPlNk0wO4lgJK2W/tH7WS
	 IZsYhqkMOWHbdtms0CWWcvoXs4G+r7zfHjhMJQv1W8CwZLgDTH4LA0gCc+rbOBtyNX
	 r0bedBcJhzzElh4B/RqUn7J6xN8Iph0oYrFctQ4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbfGOVMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbfGOVMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:32 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400022171F;
        Mon, 15 Jul 2019 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225151;
        bh=W97iYoqobcLZMt3u4WRzTTOyjcoDCDvRMydlZ7S5uA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BkA/HedtulIhfmmeV754auBQUMJJvw9Q8ukcd7PTLWm+0EXFDkytDXMu1tW8vBXKn
         ySBlqAIxxqR735V7dAGfhgiikoidOG71LxEaN1+BHES6EQxi1OqDK6wi7cB/fYWZ9Y
         8Eh7/VGKyft9jmSRnj51tm7dL18kuzvEBr/0AMZQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 03/28] perf trace: Auto bump rlimit(MEMLOCK) for eBPF maps sake
Date:   Mon, 15 Jul 2019 18:11:35 -0300
Message-Id: <20190715211200.10984-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Circa v5.2 this started to fail:

  # perf trace -e /wb/augmented_raw_syscalls.o
  event syntax error: '/wb/augmented_raw_syscalls.o'
                       \___ Operation not permitted

  (add -v to see detail)
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

In verbose mode we some -EPERM when creating a BPF map:

  # perf trace -v -e /wb/augmented_raw_syscalls.o
  <SNIP>
  libbpf: failed to create map (name: '__augmented_syscalls__'): Operation not permitted
  libbpf: failed to load object '/wb/augmented_raw_syscalls.o'
  bpf: load objects failed: err=-1: (Operation not permitted)
  event syntax error: '/wb/augmented_raw_syscalls.o'
                       \___ Operation not permitted

  (add -v to see detail)
  Run 'perf list' for a list of valid events

   Usage: perf trace [<options>] [<command>]
      or: perf trace [<options>] -- <command> [<options>]
      or: perf trace record [<options>] [<command>]
      or: perf trace record [<options>] -- <command> [<options>]

      -e, --event <event>   event/syscall selector. use 'perf list' to list available events
  #

If we bumped 'ulimit -l 128' to get it from the 64k default to double that, it
worked, so use the recently added rlimit__bump_memlock() helper:

  # perf trace -e /wb/augmented_raw_syscalls.o -e open*,*sleep sleep 1
       0.000 ( 0.007 ms): sleep/28042 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC) = 3
       0.022 ( 0.004 ms): sleep/28042 openat(dfd: CWD, filename: "/lib64/libc.so.6", flags: RDONLY|CLOEXEC) = 3
       0.201 ( 0.007 ms): sleep/28042 openat(dfd: CWD, filename: "", flags: RDONLY|CLOEXEC)                 = 3
       0.241 (1000.421 ms): sleep/28042 nanosleep(rqtp: 0x7ffd6c3e6ed0)                                       = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-j6f2ioa6hj9dinzpjvlhcjoc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1aa2ed096f65..4f0bbffee05f 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -19,6 +19,7 @@
 #include <api/fs/tracing_path.h>
 #include <bpf/bpf.h>
 #include "util/bpf_map.h"
+#include "util/rlimit.h"
 #include "builtin.h"
 #include "util/cgroup.h"
 #include "util/color.h"
@@ -3864,6 +3865,15 @@ int cmd_trace(int argc, const char **argv)
 		goto out;
 	}
 
+	/*
+	 * Parsing .perfconfig may entail creating a BPF event, that may need
+	 * to create BPF maps, so bump RLIM_MEMLOCK as the default 64K setting
+	 * is too small. This affects just this process, not touching the
+	 * global setting. If it fails we'll get something in 'perf trace -v'
+	 * to help diagnose the problem.
+	 */
+	rlimit__bump_memlock();
+
 	err = perf_config(trace__config, &trace);
 	if (err)
 		goto out;
-- 
2.21.0

