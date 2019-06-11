Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67394C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E9021851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279664;
	bh=XRbEgYL/bepZB1+Qwc/H6QVdx7itTvuPaTdGAM31RfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GRdqU7ODjMm8R7dDrK2/nX1g3X2ir79I5PvoTRHltiet5tuCfLseMgjq6q27fd8FB
	 FLKyM8Iz3uVFW5N2Z2yknx2eWmv8dP2UDJPhRNQIQpRbZgf7iAYnxLNiFtHw6TJ5+p
	 79++UExrc4Pc4BeNuoaeGMSeYV7jGoOKgXi5hvqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392282AbfFKTBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:37740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390751AbfFKTBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:01:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 138D121841;
        Tue, 11 Jun 2019 19:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279661;
        bh=XRbEgYL/bepZB1+Qwc/H6QVdx7itTvuPaTdGAM31RfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N1vXC5ojcJecq+8K4NT+z+2IOD+I5t7JyD+xmen7aEGRlZzjZJT0AxMKEQGlJfAnj
         MJ0Z+e1ZDJ2om2NY1CdNWv+Yy4quOQU5pfXs49sf5Vzy5NQtqX5JXZxnt8/xn6AYLE
         SPXbL4cxBhvDvQc+UnDq2AZxD2bZ7gBCx/o5DUe4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 28/85] perf augmented_raw_syscalls: Change helper to consider just the augmented_filename part
Date:   Tue, 11 Jun 2019 15:58:14 -0300
Message-Id: <20190611185911.11645-29-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can use it for multiple args, baby steps not to step into the
verifier toes.

In the process make sure we handle -EFAULT from bpf_prog_read_str(), as
this really is needed now that we'll handle more than one augmented
argument, i.e. if there is failure, then we have the argument that fails
have:

  (size = 0, err = -EFAULT, value = [] )

followed by the next, lets say that worked for a second pathname:

  (size = 4, err = 0, value = "/tmp" )

So we can skip the first while telling the user about the problem and
then process the second.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-deyvqi39um6gp6hux6jovos8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../examples/bpf/augmented_raw_syscalls.c     | 46 +++++++++++++------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 356513e81ec1..5054b4bc9e55 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -47,7 +47,7 @@ struct syscall_exit_args {
 
 struct augmented_filename {
 	unsigned int	size;
-	int		reserved;
+	int		err;
 	char		value[PATH_MAX];
 };
 
@@ -61,16 +61,28 @@ struct augmented_args_filename {
 bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
 
 static inline
-unsigned int augmented_args__read_filename(struct augmented_args_filename *augmented_args,
-					   const void *filename_arg, unsigned int filename_len)
+unsigned int augmented_filename__read(struct augmented_filename *augmented_filename,
+				      const void *filename_arg, unsigned int filename_len)
 {
-	unsigned int len = sizeof(*augmented_args);
+	unsigned int len = sizeof(*augmented_filename);
+	int size = probe_read_str(&augmented_filename->value, filename_len, filename_arg);
 
-	augmented_args->filename.reserved = 0;
-	augmented_args->filename.size = probe_read_str(&augmented_args->filename.value, filename_len, filename_arg);
-	if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
-		len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
-		len &= sizeof(augmented_args->filename.value) - 1;
+	augmented_filename->size = augmented_filename->err = 0;
+	/*
+	 * probe_read_str may return < 0, e.g. -EFAULT
+	 * So we leave that in the augmented_filename->size that userspace will
+	 */
+	if (size > 0) {
+		len -= sizeof(augmented_filename->value) - size;
+		len &= sizeof(augmented_filename->value) - 1;
+		augmented_filename->size = size;
+	} else {
+		/*
+		 * So that username notice the error while still being able
+		 * to skip this augmented arg record
+		 */
+		augmented_filename->err = size;
+		len = offsetof(struct augmented_filename, value);
 	}
 
 	return len;
@@ -80,7 +92,17 @@ SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_filename *augmented_args;
-	unsigned int len, filename_len;
+	/*
+	 * We start len, the amount of data that will be in the perf ring
+	 * buffer, if this is not filtered out by one of pid_filter__has(),
+	 * syscall->enabled, etc, with the non-augmented raw syscall payload,
+	 * i.e. sizeof(augmented_args->args).
+	 *
+	 * We'll add to this as we add augmented syscalls right after that
+	 * initial, non-augmented raw_syscalls:sys_enter payload.
+	 */
+	unsigned int len = sizeof(augmented_args->args);
+	unsigned int filename_len;
 	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
@@ -198,9 +220,7 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 	loop_iter_last(5)
 
 	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
-		len = augmented_args__read_filename(augmented_args, filename_arg, filename_len);
-	} else {
-		len = sizeof(augmented_args->args);
+		len += augmented_filename__read(&augmented_args->filename, filename_arg, filename_len);
 	}
 
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
-- 
2.20.1

