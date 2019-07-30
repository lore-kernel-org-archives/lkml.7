Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CC7C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A23206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="yUwRjwpt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbfG3SDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:03:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387722AbfG3SDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:03:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI38iM3322443
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:03:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI38iM3322443
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509789;
        bh=sNIiMsVBy5wdV6wrM2imJtCcq+XLNAhmQRImeAQBIUs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=yUwRjwptEKaoitJk12aj5Ym32yyNWVbaq8fpf7Ia0EtRXzoVRloLAze/kIrvE9XaH
         IY4CT/15pCiOF1zYaawXvkP35vAv3oQgpAXSV2sZYMPG2srVffQqoMsu13jMDp5bHR
         5g5XJZIu1sJensJdc/LP+NEhWw2EUVNN8XCIteQsNry7XE+ApwJ41gZ4G5qVT9i2TQ
         cf+4nDKKArnaqAjgjxddWEVmDTH52MhwT1yALPQJMz4BbVoFNIeqRdIyVhGt96x2mQ
         PUExiuOnYq6m4aWARKAvbSPG6LDo4U9qlRLWKBX18Onntoliwxy3lsNGTDpTvgn261
         XQw/yuwE4iVEQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI37ZY3322438;
        Tue, 30 Jul 2019 11:03:07 -0700
Date:   Tue, 30 Jul 2019 11:03:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-6hh2rl27uri6gsxhmk6q3hx5@git.kernel.org>
Cc:     acme@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@kernel.org, lclaudio@redhat.com, jolsa@kernel.org,
        adrian.hunter@intel.com, namhyung@kernel.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
          adrian.hunter@intel.com, jolsa@kernel.org, lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Add BPF augmenter for the
 'rename' syscall
Git-Commit-ID: cfa9ac73d6f9790f569959a729cbc9d52bff4270
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

Commit-ID:  cfa9ac73d6f9790f569959a729cbc9d52bff4270
Gitweb:     https://git.kernel.org/tip/cfa9ac73d6f9790f569959a729cbc9d52bff4270
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 17 Jul 2019 11:47:37 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:42 -0300

perf trace beauty: Add BPF augmenter for the 'rename' syscall

I.e. two strings:

  # perf trace -e rename
  systemd/1 rename("/run/systemd/units/.#invocation:dnf-makecache.service970761b7f2840dcc", "/run/systemd/units/invocation:dnf-makecache.service") = 0
  systemd-journa/715 rename("/run/systemd/journal/streams/.#9:17539785BJDblc", "/run/systemd/journal/streams/9:17539785") = 0
  mv/1936 rename("/tmp/build/perf/fd/.array.o.tmp", "/tmp/build/perf/fd/.array.o.cmd") = 0
  sh/1949 rename("/tmp/build/perf/.cpu.o.tmp", "/tmp/build/perf/.cpu.o.cmd") = 0
  mv/1954 rename("/tmp/build/perf/fs/.tracing_path.o.tmp", "/tmp/build/perf/fs/.tracing_path.o.cmd") = 0
  mv/1963 rename("/tmp/build/perf/common-cmds.h+", "/tmp/build/perf/common-cmds.h") = 0
  :1975/1975 rename("/tmp/build/perf/.exec-cmd.o.tmp", "/tmp/build/perf/.exec-cmd.o.cmd") = 0
  mv/1979 rename("/tmp/build/perf/fs/.fs.o.tmp", "/tmp/build/perf/fs/.fs.o.cmd") = 0
  mv/2005 rename("/tmp/build/perf/.debug.o.tmp", "/tmp/build/perf/.debug.o.cmd") = 0
  mv/2012 rename("/tmp/build/perf/.str_error_r.o.tmp", "/tmp/build/perf/.str_error_r.o.cmd") = 0
  mv/2019 rename("/tmp/build/perf/.help.o.tmp", "/tmp/build/perf/.help.o.cmd") = 0
  mv/2031 rename("/tmp/build/perf/.trace-seq.o.tmp", "/tmp/build/perf/.trace-seq.o.cmd") = 0
  make/2038  ... [continued]: rename())             = 0
  :2038/2038 rename("/tmp/build/perf/.event-plugin.o.tmp", "/tmp/build/perf/.event-plugin.o.cmd") ...
  ar/2035 rename("/tmp/build/perf/stzwBX3a", "/tmp/build/perf/libapi.a") = 0
  mv/2051 rename("/tmp/build/perf/.parse-utils.o.tmp", "/tmp/build/perf/.parse-utils.o.cmd") = 0
  mv/2069 rename("/tmp/build/perf/.subcmd-config.o.tmp", "/tmp/build/perf/.subcmd-config.o.cmd") = 0
  make/2080 rename("/tmp/build/perf/.parse-filter.o.tmp", "/tmp/build/perf/.parse-filter.o.cmd") = 0
  mv/2099 rename("/tmp/build/perf/.pager.o.tmp", "/tmp/build/perf/.pager.o.cmd") = 0
  :2124/2124 rename("/tmp/build/perf/.sigchain.o.tmp", "/tmp/build/perf/.sigchain.o.cmd") = 0
  make/2140 rename("/tmp/build/perf/.event-parse.o.tmp", "/tmp/build/perf/.event-parse.o.cmd") = 0
  mv/2164 rename("/tmp/build/perf/.kbuffer-parse.o.tmp", "/tmp/build/perf/.kbuffer-parse.o.cmd") = 0
  sh/2174 rename("/tmp/build/perf/.run-command.o.tmp", "/tmp/build/perf/.run-command.o.cmd") = 0
  mv/2190 rename("/tmp/build/perf/.tep_strerror.o.tmp", "/tmp/build/perf/.tep_strerror.o.cmd") = 0
  :2261/2261 rename("/tmp/build/perf/.event-parse-api.o.tmp", "/tmp/build/perf/.event-parse-api.o.cmd") = 0
  :2480/2480 rename("/tmp/build/perf/stLv3kG2", "/tmp/build/perf/libtraceevent.a") = 0
  ^C#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-6hh2rl27uri6gsxhmk6q3hx5@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index 9c2228b01ee6..79787cf4fce9 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -197,6 +197,25 @@ int sys_enter_openat(struct syscall_enter_args *args)
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
 }
 
+SEC("!syscalls:sys_enter_rename")
+int sys_enter_rename(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	const void *oldpath_arg = (const void *)args->args[0],
+		   *newpath_arg = (const void *)args->args[1];
+	unsigned int len = sizeof(augmented_args->args), oldpath_len;
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	oldpath_len = augmented_filename__read(&augmented_args->filename, oldpath_arg, sizeof(augmented_args->filename.value));
+	len += oldpath_len + augmented_filename__read((void *)(&augmented_args->filename) + oldpath_len, newpath_arg, sizeof(augmented_args->filename.value));
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len);
+}
+
 SEC("!syscalls:sys_enter_renameat")
 int sys_enter_renameat(struct syscall_enter_args *args)
 {
