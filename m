Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451CEC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EA6208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="P8Dv0StE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbfFQTNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:13:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42051 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfFQTNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:13:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJDFfB3558898
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:13:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJDFfB3558898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560798796;
        bh=r1CfY9rcPUnd2q3fr1GZGCcyq9Ge3lFOzXVa0yuK7LM=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=P8Dv0StErRf+u3wX/m6nT5hkAj0JmVaQIvuzWIMmaznsCB6GtAtoczMI6Dmuc7j48
         Af4f4kbmz/PWdDz5xgy/fz3HESkJJk8G33k1Mro8MbQeRRAu6JFBjV2R8rHcr1diC6
         J462NakcSGvqXeO2829ZzLCMnIQ97Gv8IWi2BkTfTnDIZ1W3Dn2QOE7Q91pI+6O3oW
         d7lX8RfhfjOWWEk1kwSZnqXj/4bkMXa59sQCSU8C58v3WdOOUA83CzIcxV692HErPX
         Ikx4+uhs/6TlJQjSzeJGCTa34h1kCaOdFvoVLyx+Kgh8HM0ecNy9nwVGm360Ib34XK
         Bnggw3LAOBWow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJDFD13558895;
        Mon, 17 Jun 2019 12:13:15 -0700
Date:   Mon, 17 Jun 2019 12:13:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-xdqtjexdyp81oomm1rkzeifl@git.kernel.org>
Cc:     acme@redhat.com, brendan.d.gregg@gmail.com, namhyung@kernel.org,
        lclaudio@redhat.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        adrian.hunter@intel.com, mingo@kernel.org
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
          lclaudio@redhat.com, namhyung@kernel.org,
          brendan.d.gregg@gmail.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Move the
 probe_read_str to a separate function
Git-Commit-ID: 0c95a7ff76fb1c5bb614e6ee438fce06d1b957c8
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

Commit-ID:  0c95a7ff76fb1c5bb614e6ee438fce06d1b957c8
Gitweb:     https://git.kernel.org/tip/0c95a7ff76fb1c5bb614e6ee438fce06d1b957c8
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 4 Jun 2019 15:31:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:58 -0300

perf augmented_raw_syscalls: Move the probe_read_str to a separate function

One more step into copying multiple filenames to support syscalls like
rename*.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xdqtjexdyp81oomm1rkzeifl@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 27 ++++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index c9fd3b4d8e55..356513e81ec1 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -60,11 +60,27 @@ struct augmented_args_filename {
 
 bpf_map(augmented_filename_map, PERCPU_ARRAY, int, struct augmented_args_filename, 1);
 
+static inline
+unsigned int augmented_args__read_filename(struct augmented_args_filename *augmented_args,
+					   const void *filename_arg, unsigned int filename_len)
+{
+	unsigned int len = sizeof(*augmented_args);
+
+	augmented_args->filename.reserved = 0;
+	augmented_args->filename.size = probe_read_str(&augmented_args->filename.value, filename_len, filename_arg);
+	if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
+		len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
+		len &= sizeof(augmented_args->filename.value) - 1;
+	}
+
+	return len;
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
 	struct augmented_args_filename *augmented_args;
-	unsigned int len = sizeof(*augmented_args), filename_len;
+	unsigned int len, filename_len;
 	const void *filename_arg = NULL;
 	struct syscall *syscall;
 	int key = 0;
@@ -182,14 +198,7 @@ processed 46 insns (limit 1000000) max_states_per_insn 0 total_states 12 peak_st
 	loop_iter_last(5)
 
 	if (filename_arg != NULL && filename_len <= sizeof(augmented_args->filename.value)) {
-		augmented_args->filename.reserved = 0;
-		augmented_args->filename.size = probe_read_str(&augmented_args->filename.value,
-							      filename_len,
-							      filename_arg);
-		if (augmented_args->filename.size < sizeof(augmented_args->filename.value)) {
-			len -= sizeof(augmented_args->filename.value) - augmented_args->filename.size;
-			len &= sizeof(augmented_args->filename.value) - 1;
-		}
+		len = augmented_args__read_filename(augmented_args, filename_arg, filename_len);
 	} else {
 		len = sizeof(augmented_args->args);
 	}
