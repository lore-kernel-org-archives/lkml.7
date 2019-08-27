Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13758C3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADE62184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 08:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfH0I0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 04:26:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729370AbfH0I0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 04:26:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2Wnw-0007oZ-3A; Tue, 27 Aug 2019 10:26:16 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B98C91C0DDE;
        Tue, 27 Aug 2019 10:26:15 +0200 (CEST)
Date:   Tue, 27 Aug 2019 08:26:15 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf augmented_raw_syscalls: Introduce helper to get
 the scratch space
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156689437565.24502.15798435536563381582.tip-bot2@tip-bot2>
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

Commit-ID:     c265784de7adff9e07934b712204556fb0b3ba43
Gitweb:        https://git.kernel.org/tip/c265784de7adff9e07934b712204556fb0b3ba43
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 23 Aug 2019 15:45:54 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 26 Aug 2019 11:58:29 -03:00

perf augmented_raw_syscalls: Introduce helper to get the scratch space

We need more than the BPF stack can give us to format the
raw_syscalls:sys_enter augmented tracepoint, so we use a PERCPU_ARRAY
map for that, use a helper to shorten the sequence to access that area.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 32 +++++++--------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 0a8d217..8fd5ea0 100644
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
 
