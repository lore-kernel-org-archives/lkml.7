Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067A8C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CF52089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oqnkJpat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfG3SBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:01:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3SBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:01:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UI1dJp3322030
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 11:01:39 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UI1dJp3322030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509699;
        bh=1OlgqSvUGeBROryyBiZsTZTNNaumYpmf4gr3ODSVCdA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=oqnkJpatR7SiOJdUq6eH2i6vlpQs0gOdJlqcQLupUmLei6e4A05XTJ4Y1hgkFpQ6Z
         OQfzCC1GV3yHAS6oELY1FqNy4X0y6bdehvBOoLBS/vGtZ5rRjDqK4MvKcDRNEnT68+
         GA+/x7sm+3B3t+bwV+xxN16zv9jNwvGj6plvxYw55e3YmTQBAZMD7qZ7g9m7qzykKa
         vcQAlIZFe0/IrMY9vifiSjmD0G2kMLd5Ne/UeM+L9O9tSUwXh0tb41rvb7JSgZ8yoI
         3Amrk4g0bFmhMF+CTXIDBF1fNCSjalgmeSOr2w2HIu8VjMIILJqEJNb7cfOJi0NHJ1
         btnYp39qvAv1A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UI1cE43322027;
        Tue, 30 Jul 2019 11:01:38 -0700
Date:   Tue, 30 Jul 2019 11:01:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-p0l0rlvq19v5zf8qc2x2itow@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, lclaudio@redhat.com, hpa@zytor.com
Reply-To: mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
          jolsa@kernel.org, acme@redhat.com, hpa@zytor.com,
          adrian.hunter@intel.com, lclaudio@redhat.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace beauty: Beautify 'sendto's sockaddr arg
Git-Commit-ID: 3c475bc021be1f5e0a00dc1a13dc85ce7924a7d6
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

Commit-ID:  3c475bc021be1f5e0a00dc1a13dc85ce7924a7d6
Gitweb:     https://git.kernel.org/tip/3c475bc021be1f5e0a00dc1a13dc85ce7924a7d6
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 16 Jul 2019 17:33:39 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace beauty: Beautify 'sendto's sockaddr arg

By just writing the collector in the augmented_raw_syscalls.c BPF
program:

  # perf trace -e sendto
  <SNIP>
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  Socket Thread/3573 sendto(247, 0x7fb32d49c000, 120, NONE, { .family: PF_UNSPEC }, NULL) = 120
  DNS Res~er #18/11374 sendto(242, 0x7fb342cfe420, 20, NONE, { .family: PF_NETLINK }, 0xc) = 20
  DNS Res~er #18/11374 sendto(242, 0x7fb342cfcca0, 42, MSG_NOSIGNAL, { .family: PF_UNSPEC }, NULL) = 42
  DNS Res~er #18/11374 sendto(242, 0x7fb342cfcccc, 42, MSG_NOSIGNAL, { .family: PF_UNSPEC }, NULL) = 42
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  Socket Thread/3573 sendto(242, 0x7fb308bb1c08, 296, NONE, { .family: PF_UNSPEC }, NULL) = 296
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ping/23492 sendto(3, 0x56253bbef700, 64, NONE, { .family: PF_INET, port: 0, addr: 10.10.161.32 }, 0x10) = 64
  ^C
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-p0l0rlvq19v5zf8qc2x2itow@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/examples/bpf/augmented_raw_syscalls.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/perf/examples/bpf/augmented_raw_syscalls.c b/tools/perf/examples/bpf/augmented_raw_syscalls.c
index d7a292d7ee2f..9c2228b01ee6 100644
--- a/tools/perf/examples/bpf/augmented_raw_syscalls.c
+++ b/tools/perf/examples/bpf/augmented_raw_syscalls.c
@@ -142,6 +142,27 @@ int sys_enter_connect(struct syscall_enter_args *args)
 	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
 }
 
+SEC("!syscalls:sys_enter_sendto")
+int sys_enter_sendto(struct syscall_enter_args *args)
+{
+	int key = 0;
+	struct augmented_args_payload *augmented_args = bpf_map_lookup_elem(&augmented_args_tmp, &key);
+	const void *sockaddr_arg = (const void *)args->args[4];
+	unsigned int socklen = args->args[5];
+	unsigned int len = sizeof(augmented_args->args);
+
+        if (augmented_args == NULL)
+                return 1; /* Failure: don't filter */
+
+	if (socklen > sizeof(augmented_args->saddr))
+		socklen = sizeof(augmented_args->saddr);
+
+	probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
+
+	/* If perf_event_output fails, return non-zero so that it gets recorded unaugmented */
+	return perf_event_output(args, &__augmented_syscalls__, BPF_F_CURRENT_CPU, augmented_args, len + socklen);
+}
+
 SEC("!syscalls:sys_enter_open")
 int sys_enter_open(struct syscall_enter_args *args)
 {
