Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66753C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D985208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="AdkScDuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfFQTOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:14:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57831 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:14:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJDvkf3559031
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:13:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJDvkf3559031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798837;
        bh=A0bpck4xFWC7Lg4DIRaQcxjDX1sEtBmETVEWEt1YHjM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=AdkScDuy+beOMK5Wi8FqolGbtCupv+uGlbmIakai9qQ84r1felx2hMMcUOvhFzvIe
         eSVI9kWmJsgEuCG7IBU4CsNLV3XCZgxeFNhba21ks11DuM/005X2KsbsYDahsKZxGK
         x7mEdQ+wyomrmroU0AZu80Pv9zgxKx3LYgijbEFMwcHtX7fJfdwOcC2xt/xjEFwNoB
         BjcT6savDZ5HwLFFXeTAGs/FkOMLtJ8O0aOVoyH6ybQW0hxjYTNoZr+vkKztYTMea8
         mgX4gDje6AKyoNZlsUdZ00jK0jLProiUXlvqThguvOnlv/tFPkOgSoNKfYvrb7GONY
         c/gHOyKuCDWpA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJDuNj3559028;
        Mon, 17 Jun 2019 12:13:56 -0700
Date:   Mon, 17 Jun 2019 12:13:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-deyvqi39um6gp6hux6jovos8@git.kernel.org>
Cc:     mingo@kernel.org, brendan.d.gregg@gmail.com, lclaudio@redhat.com,
        acme@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        namhyung@kernel.org, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
          tglx@linutronix.de, hpa@zytor.com, namhyung@kernel.org,
          jolsa@kernel.org, mingo@kernel.org, brendan.d.gregg@gmail.com,
          lclaudio@redhat.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Change helper to
 consider just the augmented_filename part
Git-Commit-ID: deaf4da48a67f73eb7d5d1802c14eaf58d33f2da
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

Commit-ID:  deaf4da48a67f73eb7d5d1802c14eaf58d33f2da
Gitweb:     https://git.kernel.org/tip/deaf4da48a67f73eb7d5d1802c14eaf58d33f2da
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 4 Jun 2019 15:57:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:48:54 -0300

perf augmented_raw_syscalls: Change helper to consider just the augmented_filename part

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
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 46 +++++++++++++++++-------
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
