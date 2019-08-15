Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EEEC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEA6208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 09:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DVR3V2eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfHOJW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 05:22:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45539 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730204AbfHOJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 05:22:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9MPAF2271316
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:22:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9MPAF2271316
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565860946;
        bh=Pkc2tGdMqyX7pbz1ZlPE7ujFK/VSlLjX5TLYmTWJ0bs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DVR3V2eRdGCxyqAlV0Hj+5ejGOKp1HPoNR/Cbk7XY2Juj5jzB5rh0emQh+4283F8G
         gKmGcBmGybAURUDvdpVF/n+h6ZrmKVZ7REAZDjTP4bSQ0bZk+PXTKM0uzse2wpBWfn
         EJNemVrrpi+iZc7rkcMAHdQt6Rh4jlwFg4yW1Uxo/sbxSvbZXpMvPPhvQVfwzhFvxr
         mBdvVvGk3WXGY36+3IuvdzyNMQ5Z8Poch0VabUXImJiZgch6WT7a9RKcth4R2XYKm9
         o11PJCQjK5MHKPwe2E8l2iR6Qxfk2w2bdWChJBCl/eb3wDPeJEzQCtvT8zXCXqOGvq
         jJKCcKeVzW6/g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9MOPJ2271313;
        Thu, 15 Aug 2019 02:22:24 -0700
Date:   Thu, 15 Aug 2019 02:22:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-3e70008a6021fffd2cd1614734603ea970773060@git.kernel.org>
Cc:     leo.yan@linaro.org, yhs@fb.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, daniel@iogearbox.net,
        hpa@zytor.com, kafai@fb.com, songliubraving@fb.com,
        mingo@kernel.org, acme@redhat.com
Reply-To: mingo@kernel.org, songliubraving@fb.com, daniel@iogearbox.net,
          alexander.shishkin@linux.intel.com, yhs@fb.com,
          leo.yan@linaro.org, acme@redhat.com, kafai@fb.com, hpa@zytor.com,
          namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190809104752.27338-1-leo.yan@linaro.org>
References: <20190809104752.27338-1-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Fix segmentation fault when access
 syscall info on arm64
Git-Commit-ID: 3e70008a6021fffd2cd1614734603ea970773060
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

Commit-ID:  3e70008a6021fffd2cd1614734603ea970773060
Gitweb:     https://git.kernel.org/tip/3e70008a6021fffd2cd1614734603ea970773060
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Fri, 9 Aug 2019 18:47:52 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 12 Aug 2019 16:26:02 -0300

perf trace: Fix segmentation fault when access syscall info on arm64

'perf trace' reports the segmentation fault as below on Arm64:

  # perf trace -e string -e augmented_raw_syscalls.c
  LLVM: dumping tools/perf/examples/bpf/augmented_raw_syscalls.o
  perf: Segmentation fault
  Obtained 12 stack frames.
  perf(sighandler_dump_stack+0x47) [0xaaaaac96ac87]
  linux-vdso.so.1(+0x5b7) [0xffffadbeb5b7]
  /lib/aarch64-linux-gnu/libc.so.6(strlen+0x10) [0xfffface7d5d0]
  /lib/aarch64-linux-gnu/libc.so.6(_IO_vfprintf+0x1ac7) [0xfffface49f97]
  /lib/aarch64-linux-gnu/libc.so.6(__vsnprintf_chk+0xc7) [0xffffacedfbe7]
  perf(scnprintf+0x97) [0xaaaaac9ca3ff]
  perf(+0x997bb) [0xaaaaac8e37bb]
  perf(cmd_trace+0x28e7) [0xaaaaac8ec09f]
  perf(+0xd4a13) [0xaaaaac91ea13]
  perf(main+0x62f) [0xaaaaac8a147f]
  /lib/aarch64-linux-gnu/libc.so.6(__libc_start_main+0xe3) [0xfffface22d23]
  perf(+0x57723) [0xaaaaac8a1723]
  Segmentation fault

This issue is introduced by commit 30a910d7d3e0 ("perf trace:
Preallocate the syscall table"), it allocates trace->syscalls.table[]
array and the element count is 'trace->sctbl->syscalls.nr_entries'; but
on Arm64, the system call number is not continuously used; e.g. the
syscall maximum id is 436 but the real entries is only 281.

So the table is allocated with 'nr_entries' as the element count, but it
accesses the table with the syscall id, which might be out of the bound
of the array and cause the segmentation fault.

This patch allocates trace->syscalls.table[] with the element count is
'trace->sctbl->syscalls.max_id + 1', this allows any id to access the
table without out of the bound.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: 30a910d7d3e0 ("perf trace: Preallocate the syscall table")
Link: http://lkml.kernel.org/r/20190809104752.27338-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 75eb3811e942..d553d06a9aeb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1492,7 +1492,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
 	const char *name = syscalltbl__name(trace->sctbl, id);
 
 	if (trace->syscalls.table == NULL) {
-		trace->syscalls.table = calloc(trace->sctbl->syscalls.nr_entries, sizeof(*sc));
+		trace->syscalls.table = calloc(trace->sctbl->syscalls.max_id + 1, sizeof(*sc));
 		if (trace->syscalls.table == NULL)
 			return -ENOMEM;
 	}
