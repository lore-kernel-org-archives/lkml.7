Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E0C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07E5E2190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817312;
	bh=3kvGACFQ6M/WOk/Zox8VwX9yht33PM6PYsSup23zzDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nj/gsiJ5NVwb0UIbn42zRLcFJOowOn9Fq3eYMmp9ksSaIOVGcO9hlppauhA8M2Cr7
	 8yD4k7CY8oOfj2ZoghfVA7lo32KoIVpcxtTHGvRZ6V6uUDjRpMJ6FQEf33APjmdIV/
	 so2+UjNBtAuB44G3Llb6AYiVJT+OzJf7kqVvX1Jc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbfGVRlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfGVRlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:41:50 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D57A21903;
        Mon, 22 Jul 2019 17:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817309;
        bh=3kvGACFQ6M/WOk/Zox8VwX9yht33PM6PYsSup23zzDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SS5fA7J9luW/0uuPBieMZSjDB/UvNMWd0EzFcjXuGCzLAmkp8nobt0hpSy3K37e/E
         EDZOJWgg/vKyEM82qTkcrjwqgUHoomdeIQvO9H1H+L//wlpeEER6IQYc+bE051K67d
         jOzCT5a56HYquE26wzefKZZ2bUFqVeFJAkiQ1xwM=
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
Subject: [PATCH 25/37] perf trace beauty: Beautify 'sendto's sockaddr arg
Date:   Mon, 22 Jul 2019 14:38:27 -0300
Message-Id: <20190722173839.22898-26-acme@kernel.org>
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
 .../examples/bpf/augmented_raw_syscalls.c     | 21 +++++++++++++++++++
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
-- 
2.21.0

