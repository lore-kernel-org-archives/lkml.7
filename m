Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8F9C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17B5921872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869843;
	bh=YTj2OQ0bLnpmbV403KxQHmFyYkQKNaTl6BZw+TjWSKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aOmjQXAGg/qIT9NAq3eRAxkxUYUKWvLjnP3PdLLvBFnMq9RfDiSZInKtoxpCwZklD
	 pr2rs8gqpGd/wtiwBrlhYO1DuNKLoXaOO4qZrW8n9n4pTkNYJyRXXSPc/yWqdHMAcp
	 T3f2X0md5Badq0icWMTKpPfIENTK9MtPZJXTUx8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfH0BhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbfH0BhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:19 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A920C217F5;
        Tue, 27 Aug 2019 01:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869837;
        bh=YTj2OQ0bLnpmbV403KxQHmFyYkQKNaTl6BZw+TjWSKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tw81+GMjabAzu2Kp0AE4sz7ZzTRCChnB2Jhp/02fOucNfDY7t3K0sxAkc9p4c0cNu
         5HX4l/GiVJydpcznKTnNgxs+L/VQheS7G2DD+60V8DrYiKLrs/0OziuhKBqo7vfV7s
         Fgo5Wt1HDD8xXPyS74ohBvysba8ZV+82V5O3ARqM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 12/33] perf augmented_raw_syscalls: Reduce perf_event_output() boilerplate
Date:   Mon, 26 Aug 2019 22:36:13 -0300
Message-Id: <20190827013634.3173-13-acme@kernel.org>
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
 .../examples/bpf/augmented_raw_syscalls.c     | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 8fd5ea059903..b80437971d80 100644
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
-- 
2.21.0

