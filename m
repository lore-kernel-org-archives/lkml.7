Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D2EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6AB52190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817358;
	bh=q1DbIInn9askfcnlT4d9h4V4aMp7JEtDvvjVLjwdUHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9WTIFsybLK/gIttzHcydlzaClJDJ9C+arVuTOff2BM7esbF57W6bRkTwOgZ+TIQ2
	 6svSfN/T+A5y0E1UjjogtorWC9A5c/w6mVxfBtNhtpBquyy426I79nEzGmobZpdTn2
	 XeeLN8sNv5RrGxD2e8JSj1qLigkuXyUyQWSBPsa4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731992AbfGVRmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731777AbfGVRkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:40:37 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565DD2190D;
        Mon, 22 Jul 2019 17:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817236;
        bh=q1DbIInn9askfcnlT4d9h4V4aMp7JEtDvvjVLjwdUHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAZ8AA/sjOzCH80MjV0O/iUdP94obyXx1KHs8qvyZYrtTz1Z9dwbGr5AnGqFSgXUE
         gnaSlxRuqQ1pzxcok1AqbIpn15lqMnDUAcMw024xngqqzJrIvu4TEqis8WLQlzfb7A
         8WiEZbiOH3Xx4nyVq1xdvxNv+nd4Zi4rgH1b+kGk=
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
Subject: [PATCH 15/37] perf augmented_raw_syscalls: Rename augmented_args_filename to augmented_args_payload
Date:   Mon, 22 Jul 2019 14:38:17 -0300
Message-Id: <20190722173839.22898-16-acme@kernel.org>
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

It'll get other stuff in there than just filenames, starting with
sockaddr for 'connect' and 'bind'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bsexidtsn91ehdpzcd6n5fm9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 22 ++++++++++---------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index df52d92e1c69..77bb6a0edce3 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -67,13 +67,15 @@ struct augmented_filename {
 
 pid_filter(pids_filtered);
 
-struct augmented_args_filename {
+struct augmented_args_payload {
        struct syscall_enter_args args;
-       struct augmented_filename filename;
-       struct augmented_filename filename2;
+       struct {
+	       struct augmented_filename filename;
+	       struct augmented_filename filename2;
+       };
 };
 
-bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
+bpf_map(augmented_args_tmp, PERCPU_ARRAY, int, struct augmented_args_payload, 1);
 
 static inline
 unsigned int augmented_filename__read(struct augmented_filename *augmented_filename,
@@ -111,7 +113,7 @@ int syscall_unaugmented(struct syscall_enter_args *args)
 
 /*
  * This will be tail_called from SEC("raw_syscalls:sys_enter"), so will find in
- * augmented_filename_map what was read by that raw_syscalls:sys_enter and go
+ * augmented_args_tmp what was read by that raw_syscalls:sys_enter and go
  * on from there, reading the first syscall arg as a string, i.e. open's
  * filename.
  */
@@ -119,7 +121,7 @@ SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
 	int key = 0;
-	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
 	const void *filename_arg = (const void *)args->args[0];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -136,7 +138,7 @@ SEC("!syscalls:sys_enter_openat")
 int sys_enter_openat(struct syscall_enter_args *args)
 {
 	int key = 0;
-	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
 	const void *filename_arg = (const void *)args->args[1];
 	unsigned int len = sizeof(augmented_args->args);
 
@@ -153,7 +155,7 @@ SEC("!syscalls:sys_enter_renameat")
 int sys_enter_renameat(struct syscall_enter_args *args)
 {
 	int key = 0;
-	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
 	const void *oldpath_arg = (const void *)args->args[1],
 		   *newpath_arg = (const void *)args->args[3];
 	unsigned int len = sizeof(augmented_args->args), oldpath_len;
@@ -171,7 +173,7 @@ int sys_enter_renameat(struct syscall_enter_args *args)
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
-	struct augmented_args_filename *augmented_args;
+	struct augmented_args_payload *augmented_args;
 	/*
 	 * We start len, the amount of data that will be in the perf ring
 	 * buffer, if this is not filtered out by one of pid_filter__has(),
@@ -185,7 +187,7 @@ int sys_enter(struct syscall_enter_args *args)
 	struct syscall *syscall;
 	int key = 0;
 
-        augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+        augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
         if (augmented_args == NULL)
                 return 1;
 
-- 
2.21.0

