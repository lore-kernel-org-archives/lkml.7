Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B230C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 485CC206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455418;
	bh=bFI5KJTUeQZlc54AIC7b3lrsr4PJHrBFtFL6n+6YkmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jrA6ENhWHtMpVL2fG/E4s3xRlg91pvq0KIkVPuZoE5ey9K4CvOaGwJYihiqRh1Izf
	 BO5cDRBCzFRYB/CfZUxp+OeZRTSh+z2zcY93IRH6Ar5LT+vLJ8T1G7v3K4ri2bmsTv
	 W3z3He/26TkBN0g42MP/+GB/FgGaTpdUP7y+Lrx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbfG3C44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:56:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbfG3C4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:56:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8803E21773;
        Tue, 30 Jul 2019 02:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455412;
        bh=bFI5KJTUeQZlc54AIC7b3lrsr4PJHrBFtFL6n+6YkmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I3AxgSyxAHQh3sydkxvJ1D0nBkXZ4Lv/pHaFe67T6lbPF6Mfpy2CoMxHvfTXkBqM7
         MGtV4cWm2p/rOGAEVpmSXhxpy8AkeGS7t0jYO5tz1aYnH71Mm6YHL6gvClCRyewS+p
         1gYLDz38envVLu2Hn4XAnFTSX2hLY1u6o5h33CkI=
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
Subject: [PATCH 011/107] perf augmented_raw_syscalls: Add handler for "openat"
Date:   Mon, 29 Jul 2019 23:54:34 -0300
Message-Id: <20190730025610.22603-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I.e. for a syscall that has its second argument being a string, its
difficult these days to find 'open' being used in the wild :-)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-yf3kbzirqrukd3fb2sp5qx4p@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                      |  1 +
 .../perf/examples/bpf/augmented_raw_syscalls.c  | 17 +++++++++++++++++
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
-- 
2.21.0

