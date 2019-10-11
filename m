Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46920ECE58D
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158A6214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824557;
	bh=hRssVjJozDbgXXqypSQuDtaSt0pFXyt01jIZuzIFxAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cP2D+011pHx5344mMzPpGLUnqt5CNW7JzBr4P3UtUVMK98jbsafRaMV0xLeY2xV0L
	 Bm9BxY/kIWqHz88c36JV+zooBooVZp1fNiP12u5vq14Fx6h2qzySojktqIemyQTA0h
	 BXK6QWiEKIwUjAN2Bi5MdNOYs+hOGNTFDG0ZknMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbfJKUJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfJKUJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:09:15 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9921C21D7C;
        Fri, 11 Oct 2019 20:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824554;
        bh=hRssVjJozDbgXXqypSQuDtaSt0pFXyt01jIZuzIFxAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Ch+zxMd089rm2lJ/sGJnWa2FZ/okuMhcm6o9hy3q0neyaQQtkf09yD8JEM6lEEt7
         vcjEKFFOUbJfMljL/iWPmRhX2vhhn53y1WTn6ZJBjI4FVGLtb9NEdJgo157mW6xJ6m
         on06WZJvmy5HMUTTjXvwJtQSUOZJ39wP7pLwo5Xk=
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
Subject: [PATCH 31/69] perf trace: Associate the "msr" tracepoint arg name with x86_MSR__scnprintf()
Date:   Fri, 11 Oct 2019 17:05:21 -0300
Message-Id: <20191011200559.7156-32-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can go from:

  # perf trace -e msr:write_msr --max-stack=16 sleep 1
       0.000 sleep/6740 msr:write_msr(msr: 3221225728, val: 139636317451648)
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_trace_write_msr ([kernel.kallsyms])
                                         do_arch_prctl_64 ([kernel.kallsyms])
                                         __x64_sys_arch_prctl ([kernel.kallsyms])
                                         do_syscall_64 ([kernel.kallsyms])
                                         entry_SYSCALL_64 ([kernel.kallsyms])
                                         init_tls (/usr/lib64/ld-2.29.so)
                                         dl_main (/usr/lib64/ld-2.29.so)
                                         _dl_sysdep_start (/usr/lib64/ld-2.29.so)
                                         _dl_start (/usr/lib64/ld-2.29.so)
  #

To:

  # perf trace -e msr:write_msr --max-stack=16 sleep 1
     0.000 sleep/8519 msr:write_msr(msr: FS_BASE, val: 139878031705472)
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_trace_write_msr ([kernel.kallsyms])
                                       do_arch_prctl_64 ([kernel.kallsyms])
                                       __x64_sys_arch_prctl ([kernel.kallsyms])
                                       do_syscall_64 ([kernel.kallsyms])
                                       entry_SYSCALL_64 ([kernel.kallsyms])
                                       init_tls (/usr/lib64/ld-2.29.so)
                                       dl_main (/usr/lib64/ld-2.29.so)
                                       _dl_sysdep_start (/usr/lib64/ld-2.29.so)
                                       _dl_start (/usr/lib64/ld-2.29.so)
  #

This, in reverse, will allow for symbolic system call/tracepoint
filtering.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-q1q4unmqja5ex7dy0kb5cjaa@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d52972ca6123..e9f132aa5a09 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1480,6 +1480,7 @@ static int syscall__alloc_arg_fmts(struct syscall *sc, int nr_args)
 }
 
 static struct syscall_arg_fmt syscall_arg_fmts__by_name[] = {
+	{ .name = "msr", .scnprintf = SCA_X86_MSR, }
 };
 
 static int syscall_arg_fmt__cmp(const void *name, const void *fmtp)
-- 
2.21.0

