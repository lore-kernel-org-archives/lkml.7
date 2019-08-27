Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB82AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81AF9217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbfH0I2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:28:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42741 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbfH0I0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnx-0007ov-4W; Tue, 27 Aug 2019 10:26:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2E1761C07DC;
        Tue, 27 Aug 2019 10:26:16 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:16 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf augmented_raw_syscalls: Reduce
 perf_event_output() boilerplate
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-ln99gt0j4fv0kw0778h6vphm@git.kernel.org>
References: <tip-ln99gt0j4fv0kw0778h6vphm@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689437609.24505.834539880681540435.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e051c2f69850e571cb408b555aaffb00c07dbb05
Gitweb:        https://git.kernel.org/tip/e051c2f69850e571cb408b555aaffb00c07dbb05
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 23 Aug 2019 15:54:02 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf augmented_raw_syscalls: Reduce perf_event_output() boilerplate

Add a augmented__output() helper to reduce the boilerplate of sending
the augmented tracepoint to the PERF_EVENT_ARRAY BPF map associated with
the bpf-output event used to communicate with the userspace perf trace
tool.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ln99gt0j4fv0kw0778h6vphm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 24 +++++++--------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 8fd5ea0..b804379 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -87,6 +87,12 @@ static inline struct augmented_args_payload *augmented_args_payload(void)
 	return bpf_map_lookup_elem(&augmented_args_tmp, &key);
 }
 
+static inline int augmented__output(void *ctx, struct augmented_args_payload *args, int len)
+{
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(ctx, &__augmented_syscalls__, BPF_F_CURRENT_CPU, args, len);
+}
+
 static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
@@ -142,8 +148,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 
 	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
+	return augmented__output(args, augmented_args, len + socklen);
 }
 
 SEC("!syscalls:sys_enter_sendto")
@@ -162,8 +167,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 
 	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
+	return augmented__output(args, augmented_args, len + socklen);
 }
 
 SEC("!syscalls:sys_enter_open")
@@ -178,8 +182,7 @@ int sys_enter_open(struct syscall_enter_args *args)
 
 	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("!syscalls:sys_enter_openat")
@@ -194,8 +197,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
 
 	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("!syscalls:sys_enter_rename")
@@ -212,8 +214,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
 	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
 	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("!syscalls:sys_enter_renameat")
@@ -230,8 +231,7 @@ int sys_enter_renameat(struct syscall_enter_args *args)
 	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
 	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
-	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+	return augmented__output(args, augmented_args, len);
 }
 
 SEC("raw_syscalls:sys_enter")
