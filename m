Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F858C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476D222CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 01:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566869839;
	bh=PfTkofYOoploZD3H8O6hsDoTI4mgk5XrrRr4HO2t0rs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bzRkmLd1w3V7T1g2+Pp5QxYTPvtDgeW3qdy6nMIZsQqKAA317H+9MpuJdbcvL7Bij
	 bMD6vu+hVPWKItxwYXBrVWOZrLU6JgVR7s/A+xSolMMCrnUVCXLYgzTB4IeuNyem+g
	 X3KPiPUDFczgBMed5SZbEEP+VcR9N+jvIDfMXD8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfH0BhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 21:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbfH0BhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 21:37:15 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1422080C;
        Tue, 27 Aug 2019 01:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566869835;
        bh=PfTkofYOoploZD3H8O6hsDoTI4mgk5XrrRr4HO2t0rs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=089YeveEY4wcyiusqVIMSSp/9BvvBOWd8qHrcv919Jeu2ug5Qzx0t6nz2v0SAF7jB
         JfQ/Zk4x5xl1BHpXbDrsItW/kMlHfATJMaRdW0wc90TehcxCCzIFablEC9oA9Bsstg
         n8A2yG5p3D/grMjj2wm7yDk0Ci3hlyh7bdRMaTiU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/33] perf augmented_raw_syscalls: Introduce helper to get the scratch space
Date:   Mon, 26 Aug 2019 22:36:12 -0300
Message-Id: <20190827013634.3173-12-acme@kernel.org>
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

We need more than the BPF stack can give us to format the
raw_syscalls:sys_enter augmented tracepoint, so we use a PERCPU_ARRAY
map for that, use a helper to shorten the sequence to access that area.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 0a8d217d65c7..8fd5ea059903 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -78,8 +78,15 @@ struct augmented_args_payload {
 	};
 };
 
+// We need more tmp space than the BPF stack can give us
 bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
 
+static inline struct augmented_args_payload *augmented_args_payload(void)
+{
+	int key = 0;
+	return bpf_map_lookup_elem(&augmented_args_tmp, &key);
+}
+
 static inline
 unsigned int augmented_arg__read_str(struct augmented_arg *augmented_arg, const void *arg, unsigned int arg_len)
 {
@@ -122,8 +129,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_connect")
 int sys_enter_connect(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[1];
 	unsigned int socklen = args->args[2];
 	unsigned int len = sizeof(augmented_args->args);
@@ -143,8 +149,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_sendto")
 int sys_enter_sendto(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *sockaddr_arg = (const void *)args->args[4];
 	unsigned int socklen = args->args[5];
 	unsigned int len = sizeof(augmented_args->args);
@@ -164,8 +169,7 @@ int sys_enter_sendto(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[0];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -181,8 +185,7 @@ int sys_enter_open(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_openat")
 int sys_enter_openat(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *filename_arg = (const void *)args->args[1];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -198,8 +201,7 @@ int sys_enter_openat(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_rename")
 int sys_enter_rename(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[0],
 		   *newpath_arg = (const void *)args->args[1];
 	unsigned int len = sizeof(augmented_args->args), oldpath_len;
@@ -217,8 +219,7 @@ int sys_enter_rename(struct syscall_enter_args *args)
 SEC("!syscalls:sys_enter_renameat")
 int sys_enter_renameat(struct syscall_enter_args *args)
 {
-	int key = 0;
-	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
 	const void *oldpath_arg = (const void *)args->args[1],
 		   *newpath_arg = (const void *)args->args[3];
 	unsigned int len = sizeof(augmented_args->args), oldpath_len;
@@ -248,14 +249,13 @@ int sys_enter(struct syscall_enter_args *args)
 	 */
 	unsigned int len = sizeof(augmented_args->args);
 	struct syscall *syscall;
-	int key = 0;
 
 	if (pid_filter__has(&pids_filtered, getpid()))
 		return 0;
 
-        augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
-        if (augmented_args == NULL)
-                return 1;
+	augmented_args = augmented_args_payload();
+	if (augmented_args == NULL)
+		return 1;
 
 	probe_read(&augmented_args->args, sizeof(augmented_args->args), args);
 
-- 
2.21.0

