Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0395DC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40E0217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="IWT/wP9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfGQWvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:51:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfGQWvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:51:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMoaRg1721355
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:50:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMoaRg1721355
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563403837;
        bh=YYHgzK0ZkcZPLXRZ6HIUDbV8W6wpK5J3a7+zN8gT+Xo=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=IWT/wP9gyY/pW0FIuVxH8dAZfZaXU7X7tqHpkV8QqiZzMoz3KiLg/013I1aDQjsY7
         Up6ASPjk1lIqcdE5vgxIm9wPyGC8kB2QcIABtDTeKdoXZB4j1HgIGV1+xEKPmFgO2v
         FbMO9ORKWEEt2UJ55/Aul3hElQnU+r+wA5Pjmdm4GLV+77FPOyv41KuSCCAh1K1X4e
         6l/o5uTneODb76a0m1Lan3ZDRwXZA/o9Vp7VPuWXXOjTt8GxxW3G3T1mRQjgmRMzTL
         e96R0qSu2tEFPbQNmTbFSBwYAxFAf+fSwGYRe9V2lejFfAlwu+xUy75WQhALeXSHUA
         WuZgIsXCjXitw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMoaVW1721352;
        Wed, 17 Jul 2019 15:50:36 -0700
Date:   Wed, 17 Jul 2019 15:50:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-j6f2ioa6hj9dinzpjvlhcjoc@git.kernel.org>
Cc:     hpa@zytor.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, daniel@iogearbox.net,
        mingo@kernel.org, ast@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, namhyung@kernel.org, acme@redhat.com
Reply-To: daniel@iogearbox.net, mingo@kernel.org, ast@kernel.org,
          hpa@zytor.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, acme@redhat.com, tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf trace: Auto bump rlimit(MEMLOCK) for eBPF
 maps sake
Git-Commit-ID: c3e78a3403dabcb7115c2fb7b538a1095d168cd5
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

Commit-ID:  c3e78a3403dabcb7115c2fb7b538a1095d168cd5
Gitweb:     https://git.kernel.org/tip/c3e78a3403dabcb7115c2fb7b538a1095d168cd5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 9 Jul 2019 16:36:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 16:36:45 -0300

perf trace: Auto bump rlimit(MEMLOCK) for eBPF maps sake

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
