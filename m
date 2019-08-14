Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E89C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBFCD216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808190;
	bh=qEVYPB6Jqk3jXn6eFfy5VXy3R2qvcSmsFFkS0W7NS4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yYNT5z4joOSBoHffgZVe3o3ZiMRA1Jqi3ePeUTf/ynMh/Okny8zctV8l1O/58fPSK
	 0UfEPyNTyFs0/kwZBnnB1xz3k9FIVUtKdt31BFcWk9LtyOQz1dx9djKnNxvgmzcJsa
	 FjGspxrUVkkpel0JRQ4YR3AZ9c6Cx68lgNkB6Zho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfHNSnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfHNSnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:43:09 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2208E2064A;
        Wed, 14 Aug 2019 18:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808188;
        bh=qEVYPB6Jqk3jXn6eFfy5VXy3R2qvcSmsFFkS0W7NS4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4do9aP6AuWHy9mptA2b4eHpSEWTw1CTZm+fcoBqQOZew09nDt13y+l9nB50ZW+3B
         v7F3UmIV4cSOBHlC8w5Zrh8mqXhKezImrfNGObHjnBzeBAWcXj6RAnr854soDVQTvz
         bx67OtKUtmU4xJb0DJM7fHRFFHxuqJ0MQ8fApHHc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/28] perf trace: Fix segmentation fault when access syscall info on arm64
Date:   Wed, 14 Aug 2019 15:40:32 -0300
Message-Id: <20190814184051.3125-10-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
-- 
2.21.0

