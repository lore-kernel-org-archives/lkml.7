Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0A2C76190
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D6321BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817229;
	bh=M5XEr0dqw/nUhoTlq67JgVnvePrWQBTKeglRxeN69WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eARIPM/or3Qv1Zmhall5ciy4wjJ53zOd6lHUNwbn7pP+Ectk9Ucj3prnvZezSCypP
	 4UJuXZ3ArsytXb+t16ReUyMKzGCGxc9oXyi+zl6Z5YeXL2qrC46UG7YO1DnUDfMGJg
	 uUh7rSzY/WuBd3bOws7tq47Kp3yofQecMj1OHJ+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfGVRk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfGVRk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:26 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3840F21955;
        Mon, 22 Jul 2019 17:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817225;
        bh=M5XEr0dqw/nUhoTlq67JgVnvePrWQBTKeglRxeN69WM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqigOkivy+9QndyCCMJEDGvme/HW/QoVYqWUy1NQi88INH+g+NcYDb8VCkDHqUIPH
         dGNpso5ei7pRwALOzSoXZRp/NVk3dZKaYWBQe61eFN1j/5wTsbYSOYloJzaEawCn8s
         /aoa8LjDd+dy5/gxEhNU4Mw+wM5HAb4z54fixS+k=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 13/37] perf augmented_raw_syscalls: Support copying two string syscall args
Date:   Mon, 22 Jul 2019 14:38:15 -0300
Message-Id: <20190722173839.22898-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
 tools/perf/builtin-trace.c                    |  2 ++
 .../examples/bpf/augmented_raw_syscalls.c     | 20 +++++++++++++++++++
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
-- 
2.21.0

