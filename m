Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D66C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249532053B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbfH0I2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:28:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42753 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729721AbfH0I0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnv-0007o4-7y; Tue, 27 Aug 2019 10:26:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DD5681C0DDE;
        Tue, 27 Aug 2019 10:26:14 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:14 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf augmented_raw_syscalls: Rename
 augmented_filename to augmented_arg
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-w9nkt3tvmyn5i4qnwng3ap1k@git.kernel.org>
References: <tip-w9nkt3tvmyn5i4qnwng3ap1k@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156689437481.24496.10164644571260075841.tip-bot2@tip-bot2>
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

Commit-ID:     2ad926db78777148b07fced1e4bc88e20ad00268
Gitweb:        https://git.kernel.org/tip/2ad926db78777148b07fced1e4bc88e20ad00268
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 23 Aug 2019 10:37:47 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf augmented_raw_syscalls: Rename augmented_filename to augmented_arg

Because it is not used only for strings, we already use it for sockaddr
structs and will use it for all other types.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w9nkt3tvmyn5i4qnwng3ap1k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 42 +++++++--------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 79787cf..b85b177 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -60,7 +60,7 @@ struct syscall_exit_args {
 	long		   ret;
 };
 
-struct augmented_filename {
+struct augmented_arg {
 	unsigned int	size;
 	int		err;
 	char		value[PATH_MAX];
@@ -72,8 +72,7 @@ struct augmented_args_payload {
        struct syscall_enter_args args;
        union {
 		struct {
-			struct augmented_filename filename,
-						  filename2;
+			struct augmented_arg arg, arg2;
 		};
 		struct sockaddr_storage saddr;
 	};
@@ -82,31 +81,30 @@ struct augmented_args_payload {
 bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
 
 static inline
-unsigned int augmented_filename__read(struct augmented_filename *augmented_filename,
-				      const void *filename_arg, unsigned int filename_len)
+unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
-	unsigned int len = sizeof(*augmented_filename);
-	int size = probe_read_str(&augmented_filename->value, filename_len, filename_arg);
+	unsigned int augmented_len = sizeof(*augmented_arg);
+	int string_len = probe_read_str(&augmented_arg->value, arg_len, arg);
 
-	augmented_filename->size = augmented_filename->err = 0;
+	augmented_arg->size = augmented_arg->err = 0;
 	/*
 	 * probe_read_str may return < 0, e.g. -EFAULT
-	 * So we leave that in the augmented_filename->size that userspace will
+	 * So we leave that in the augmented_arg->size that userspace will
 	 */
-	if (size > 0) {
-		len -= sizeof(augmented_filename->value) - size;
-		len &= sizeof(augmented_filename->value) - 1;
-		augmented_filename->size = size;
+	if (string_len > 0) {
+		augmented_len -= sizeof(augmented_arg->value) - string_len;
+		augmented_len &= sizeof(augmented_arg->value) - 1;
+		augmented_arg->size = string_len;
 	} else {
 		/*
 		 * So that username notice the error while still being able
 		 * to skip this augmented arg record
 		 */
-		augmented_filename->err = size;
-		len = offsetof(struct augmented_filename, value);
+		augmented_arg->err = string_len;
+		augmented_len = offsetof(struct augmented_arg, value);
 	}
 
-	return len;
+	return augmented_len;
 }
 
 SEC("!raw_syscalls:unaugmented")
@@ -174,7 +172,7 @@ int sys_enter_open(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	len += augmented_filename__read(&augmented_args->filename, filename_arg, sizeof(augmented_args->filename.value));
+	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
@@ -191,7 +189,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	len += augmented_filename__read(&augmented_args->filename, filename_arg, sizeof(augmented_args->filename.value));
+	len += augmented_arg__read_str(&augmented_args->arg, filename_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
@@ -209,8 +207,8 @@ int sys_enter_rename(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	oldpath_len = augmented_filename__read(&augmented_args->filename, oldpath_arg, sizeof(augmented_args->filename.value));
-	len += oldpath_len + augmented_filename__read((void *)(&augmented_args->filename) + oldpath_len, newpath_arg, sizeof(augmented_args->filename.value));
+	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
+	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
@@ -228,8 +226,8 @@ int sys_enter_renameat(struct syscall_enter_args *args)
         if (augmented_args == NULL)
                 return 1; /* Failure: don't filter */
 
-	oldpath_len = augmented_filename__read(&augmented_args->filename, oldpath_arg, sizeof(augmented_args->filename.value));
-	len += oldpath_len + augmented_filename__read((void *)(&augmented_args->filename) + oldpath_len, newpath_arg, sizeof(augmented_args->filename.value));
+	oldpath_len = augmented_arg__read_str(&augmented_args->arg, oldpath_arg, sizeof(augmented_args->arg.value));
+	len += oldpath_len + augmented_arg__read_str((void *)(&augmented_args->arg) + oldpath_len, newpath_arg, sizeof(augmented_args->arg.value));
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
