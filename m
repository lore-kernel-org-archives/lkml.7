Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00B1C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A210217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869834;
	bh=6lUoHpraf7AlyGIVDkUwMNzP4XZFFvusfzpUIeS32JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MW/+Fj1Zh6YqgD/Plki2Bi6l+BeC6rd4lBNowKQh23vg9XJdUMqDF41f1I9tnYtPP
	 rvnUnb96vcFyz7iu2NRWygMEccac8qjhUITjdvp81kyLJ0EiLMcQ0Myv75sLzfNpaO
	 E8U2kqCkOuJoCxj0P0mNah9bSL1JLrzO5rusOZ9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfH0BhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfH0BhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:11 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B42BE2173E;
        Tue, 27 Aug 2019 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869829;
        bh=6lUoHpraf7AlyGIVDkUwMNzP4XZFFvusfzpUIeS32JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjZl0otA+vo/Plhn1zk3LcQBonkFiD4SCWVav9/wMJqlVtrH58HXxNNrGdU5L/BFq
         WsKsPucRankurhAOPZ0t9Z1Wx9UnTzFypGG0o43y/1tDnpnofoopre8UUFU1xH9Tl4
         bHQwUfVXNOPZtXrxBasFAgeFYkeYG5Sg2RzyEkc8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 09/33] perf augmented_raw_syscalls: Rename augmented_filename to augmented_arg
Date:   Mon, 26 Aug 2019 22:36:10 -0300
Message-Id: <20190827013634.3173-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190827013634.3173-1-acme@kernel.org>
References: <20190827013634.3173-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Because it is not used only for strings, we already use it for sockaddr
structs and will use it for all other types.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w9nkt3tvmyn5i4qnwng3ap1k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 42 +++++++++----------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 79787cf4fce9..b85b177c6726 100644
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
-- 
2.21.0

