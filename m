Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A36FC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF9F206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="A1CMlslN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387573AbfG3R4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:56:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387552AbfG3R4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:56:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHuMqd3321149
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:56:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHuMqd3321149
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509382;
        bh=Q7dnEjRKcxj+idUbt/mjPfjqQ1TUuOf0lfyRiUPvdmI=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=A1CMlslNfyKQ4EmjsYVwXUzKpTHJpaH1dyTFalC7wK5oQ87HRFPs+OxnYI75GGma2
         pvMx3qi5njN7h9YNc48GPqTE2s9OMplUUXf/4Z2FEbcRRkirUbKMo5xL9JN6gKZxGH
         aQe1ATiQF9moHYxNj/fcHNU5KW8s88eewpo61A83LexZxv672B78pH+WXS6494pfdL
         UwXO0YqlnaFQryOHIRbPcxZZOCoSZmmLxTK86s+YRNZ0IOalJz1fIFJ8j6UTFcaHiQ
         WC8IJpG1g4ckcCMwMmhCTZGCMtJFO+Jo4MRqmombOE5V31mvIodzFcqZ4XiUM5iwj1
         jKRPSczGI1x0A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHuLLC3321146;
        Tue, 30 Jul 2019 10:56:21 -0700
Date:   Tue, 30 Jul 2019 10:56:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-x2uboyg5kx2wqeru288209b6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
        lclaudio@redhat.com, adrian.hunter@intel.com, namhyung@kernel.org,
        acme@redhat.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com, namhyung@kernel.org,
          lclaudio@redhat.com, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Support copying two
 string syscall args
Git-Commit-ID: 8d5da2649d8211e63c5f65ccf8945f2c46a9c0b8
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

Commit-ID:  8d5da2649d8211e63c5f65ccf8945f2c46a9c0b8
Gitweb:     https://git.kernel.org/tip/8d5da2649d8211e63c5f65ccf8945f2c46a9c0b8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 14:55:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf augmented_raw_syscalls: Support copying two string syscall args

Starting with the renameat and renameat2 syscall, that both receive as
second and fourth parameters a pathname:

  # perf trace -e rename* mv one ANOTHER
  LLVM: dumping /home/acme/git/perf/tools/perf/examples/bpf/augmented_raw_syscalls.o
  mv: cannot stat 'one': No such file or directory
  renameat2(AT_FDCWD, "one", AT_FDCWD, "ANOTHER", RENAME_NOREPLACE) = -1 ENOENT (No such file or directory)
  #

Since the per CPU scratch buffer map has space for two maximum sized
pathnames, the verifier is satisfied that there will be no overrun.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-x2uboyg5kx2wqeru288209b6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                       |  2 ++
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 20 ++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a681b8c2ee4e..c64f7c99db15 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -873,9 +873,11 @@ static struct syscall_fmt {
 	{ .name	    = "recvmsg",
 	  .arg = { [2] = { .scnprintf = SCA_MSG_FLAGS, /* flags */ }, }, },
 	{ .name	    = "renameat",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_renameat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ }, }, },
 	{ .name	    = "renameat2",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_renameat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* olddirfd */ },
 		   [2] = { .scnprintf = SCA_FDAT, /* newdirfd */ },
 		   [4] = { .scnprintf = SCA_RENAMEAT2_FLAGS, /* flags */ }, }, },
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index ce308b9a317c..df52d92e1c69 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -70,6 +70,7 @@ pid_filter(pids_filtered);
 struct augmented_args_filename {
        struct syscall_enter_args args;
        struct augmented_filename filename;
+       struct augmented_filename filename2;
 };
 
 bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
@@ -148,6 +149,25 @@ int sys_enter_openat(struct syscall_enter_args *args)
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
 
+SEC("!syscalls:sys_enter_renameat")
+int sys_enter_renameat(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	const void *oldpath_arg = (const void *)args->args[1],
+		   *newpath_arg = (const void *)args->args[3];
+	unsigned int len = sizeof(augmented_args->args), oldpath_len;
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	oldpath_len = augmented_filename__read(&augmented_args->filename, oldpath_arg, sizeof(augmented_args->filename.value));
+	len += oldpath_len + augmented_filename__read((void *)(&augmented_args->filename) + oldpath_len, newpath_arg, sizeof(augmented_args->filename.value));
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
