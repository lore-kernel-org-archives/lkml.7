Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619A2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 344C7206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PKv1GtQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbfG3Ry7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:54:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51387 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfG3Ry5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:54:57 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHsooW3320933
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:54:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHsooW3320933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509291;
        bh=G54+OAPEE9fldhCjiqee2BL6P9a1CRZgZySzYQuRExo=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=PKv1GtQsVPMg8aMaeQYjBmEugAjFzWUU4UnNwVEYo+iPyItaBc0cKk3kta3TmT2kV
         uHg4cOmFzsZ+Z25yaxYV+JMqg/Ab4irCkIQiCT/64soLF77Z8zc0rUOltA7PnBDI93
         eJg/aoI/f1E84mkyqNUeieNbVjTZXdPbPiYcFRjd0Rwxb7dtzDKfy0pIjFHJKaKaHt
         1A3PLEx7SwB64rkJp0H4caavwbKzZPAeivN4+xsVbvLOuLG1HJFuexZd1eqj1oIyJV
         E15QvwfAQAfgqNOyjzc++arpMS5P/vygBcggU7oJ97VmqS53YKenPy9/4jtMiSy+xL
         p2tC5dk3oMufA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHsn113320930;
        Tue, 30 Jul 2019 10:54:49 -0700
Date:   Tue, 30 Jul 2019 10:54:49 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yf3kbzirqrukd3fb2sp5qx4p@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, namhyung@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, jolsa@kernel.org, lclaudio@redhat.com,
        tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, jolsa@kernel.org, lclaudio@redhat.com,
          tglx@linutronix.de, hpa@zytor.com, acme@redhat.com,
          namhyung@kernel.org, mingo@kernel.org,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf augmented_raw_syscalls: Add handler for
 "openat"
Git-Commit-ID: 236dd5838871024d58d354ff8d0dab00ee59a867
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

Commit-ID:  236dd5838871024d58d354ff8d0dab00ee59a867
Gitweb:     https://git.kernel.org/tip/236dd5838871024d58d354ff8d0dab00ee59a867
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 12:31:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf augmented_raw_syscalls: Add handler for "openat"

I.e. for a syscall that has its second argument being a string, its
difficult these days to find 'open' being used in the wild :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-yf3kbzirqrukd3fb2sp5qx4p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                       |  1 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 872c9cc982a5..a681b8c2ee4e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -836,6 +836,7 @@ static struct syscall_fmt {
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "openat",
+	  .bpf_prog_name = { .sys_enter = "!syscalls:sys_enter_openat", },
 	  .arg = { [0] = { .scnprintf = SCA_FDAT,	/* dfd */ },
 		   [2] = { .scnprintf = SCA_OPEN_FLAGS, /* flags */ }, }, },
 	{ .name	    = "perf_event_open",
diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index c66474a6ccf4..661936f90fe0 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -131,6 +131,23 @@ int sys_enter_open(struct syscall_enter_args *args)
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
 
+SEC("!syscalls:sys_enter_openat")
+int sys_enter_openat(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_filename *augmented_args = bpf_map_lookup_elem(&augmented_filename_map, &key);
+	const void *filename_arg = (const void *)args->args[1];
+	unsigned int len = sizeof(augmented_args->args);
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	len += augmented_filename__read(&augmented_args->filename, filename_arg, sizeof(augmented_args->filename.value));
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+}
+
 SEC("raw_syscalls:sys_enter")
 int sys_enter(struct syscall_enter_args *args)
 {
