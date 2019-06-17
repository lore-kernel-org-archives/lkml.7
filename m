Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12150C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D67A420863
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="sr5Fe4w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfFQTOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:14:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:14:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJEcS03559157
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:14:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJEcS03559157
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798879;
        bh=4ZGJP86/KmJ/0AYcdgilVrJcN/roudMe4uSZ0W0J4jU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=sr5Fe4w6UFquwkmxsjPKE8PI2kM1ztLD/CQeMHKeioqvoJ3OpX2nFf3ya8N0FNlnP
         0izjSFYNKX1lUH6x9xMRJl8Ow60Gwtt4xSjGuM2g6q/GSOV3uoxppLrPhfCkqsTUjD
         0b7d1G95WoC7oyf8UQgghuCwLUPZjdDxob3Kswo2IxjC0bia+u+46NFD+4RjlkrJ+g
         U0D2YlMya8UtKz9U7nr2TF6hi/nB6NXhajqzEEKL14jw42FUTOKwnEyYoh8MDKVqI9
         MTf5o//NEALIrJASB/h9KkywXWgdBTpwYK12OYFjuyp4C5GGt0llnhnRRHyVEJRbpy
         HYpyplcfkBfcA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJEcwi3559154;
        Mon, 17 Jun 2019 12:14:38 -0700
Date:   Mon, 17 Jun 2019 12:14:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-uf6u0pld6xe4xuo16f04owlz@git.kernel.org>
Cc:     brendan.d.gregg@gmail.com, mingo@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, lclaudio@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, acme@redhat.com,
        jolsa@kernel.org
Reply-To: hpa@zytor.com, adrian.hunter@intel.com, lclaudio@redhat.com,
          brendan.d.gregg@gmail.com, mingo@kernel.org, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          tglx@linutronix.de, jolsa@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Move reading filename
 to the loop
Git-Commit-ID: 602bce09fb43ca6fc41f1bdcba155b839b5e7f38
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

Commit-ID:  602bce09fb43ca6fc41f1bdcba155b839b5e7f38
Gitweb:     https://git.kernel.org/tip/602bce09fb43ca6fc41f1bdcba155b839b5e7f38
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 4 Jun 2019 16:04:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:48:55 -0300

perf augmented_raw_syscalls: Move reading filename to the loop

Almost there, next step is to copy more than one filename payload.

Probably to read syscall arg structs, etc we'll need just a variation of
this that will decide what to use, if probe_read_str() or plain
probe_read for structs, i.e. fixed size.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-uf6u0pld6xe4xuo16f04owlz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 5054b4bc9e55..2f822bb51717 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -102,8 +102,6 @@ int sys_enter(struct syscall_enter_args *args)
 	 * initial, non-augmented raw_syscalls:sys_enter payload.
 	 */
 	unsigned int len = sizeof(augmented_args->args);
-	unsigned int filename_len;
-	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
 
@@ -206,8 +204,10 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 
 #define __loop_iter(arg) \
 	if (syscall->string_args_len[arg] != 0) { \
-		filename_len = syscall->string_args_len[arg]; \
-		filename_arg = (const void *)args->args[arg];
+		unsigned int filename_len = syscall->string_args_len[arg]; \
+		const void *filename_arg = (const void *)args->args[arg]; \
+		if (filename_len <= sizeof(augmented_args->filename.value)) \
+			len += augmented_filename__read(&augmented_args->filename, filename_arg, filename_len);
 #define loop_iter_first() __loop_iter(0); }
 #define loop_iter(arg) else __loop_iter(arg); }
 #define loop_iter_last(arg) else __loop_iter(arg); __asm__ __volatile__("": : :"memory"); }
@@ -219,10 +219,6 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 	loop_iter(4)
 	loop_iter_last(5)
 
-	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
-		len += augmented_filename__read(&augmented_args->filename, filename_arg, filename_len);
-	}
-
 	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
