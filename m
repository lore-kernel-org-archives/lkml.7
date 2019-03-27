Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4848AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183E1217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709984;
	bh=UPLGvYMO6j2NRm+G88+Ee/vioHvhLfEQVddOLANmdgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zD1ra1ycOuedNKFUEBYBIW14z6j6Nj5u2FpuKeZ2mnGWksRY4lwkJp6yyFgnWfUG+
	 T3CTztPh93jdtaj7j7ZaFsMxubuMzxwLrBFkEIx/hH9dfignGRW3/y5HcGXP+7LVOF
	 4aJxFygsSRWC/Lq7/XiBme5qLBmqIBNh9Oqbbuss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387930AbfC0SGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:06:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:47890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387912AbfC0SGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:06:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 346D121734;
        Wed, 27 Mar 2019 18:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709979;
        bh=UPLGvYMO6j2NRm+G88+Ee/vioHvhLfEQVddOLANmdgg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJtW0n/2ztBYpmbM5Y068KTb5N0iI8z3bqfRjS3n7fYinkNGq24wcSSUa2xCp2R9q
         OP/Bhwq0q7lByI85ogBs1pmP+QNc2usoVwGXivdU+G7meI+MgTW2WSFTvaRmdgtshb
         Wf9bRMuDJhJI6lh70VLTy5sXhwf9yv9kr37FJol0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 142/262] perf trace: Check if the 'fd' is negative when mapping it to pathname
Date:   Wed, 27 Mar 2019 13:59:57 -0400
Message-Id: <20190327180158.10245-142-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 051074867434cc520c08f188479d4757dcfdaef8 ]

We were crashing when processing a negative fd:

  Program received signal SIGSEGV, Segmentation fault.
  0x0000000000609bbf in syscall_arg__scnprintf_ioctl_cmd (bf=0x1172eca "", size=2038, arg=0x7fffffff8360) at trace/beauty/ioctl.c:182
  182			if (file->dev_maj == USB_DEVICE_MAJOR)
  Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-28.fc29.x86_64 elfutils-libelf-0.174-5.fc29.x86_64 elfutils-libs-0.174-5.fc29.x86_64 glib2-2.58.3-1.fc29.x86_64 libbabeltrace-1.5.6-1.fc29.x86_64 libunwind-1.2.1-6.fc29.x86_64 libuuid-2.32.1-1.fc29.x86_64 libxcrypt-4.4.3-2.fc29.x86_64 numactl-libs-2.0.12-1.fc29.x86_64 openssl-libs-1.1.1a-1.fc29.x86_64 pcre-8.42-6.fc29.x86_64 perl-libs-5.28.1-427.fc29.x86_64 popt-1.16-15.fc29.x86_64 python2-libs-2.7.15-11.fc29.x86_64 slang-2.3.2-4.fc29.x86_64 xz-libs-5.2.4-3.fc29.x86_64
  (gdb) bt
  #0  0x0000000000609bbf in syscall_arg__scnprintf_ioctl_cmd (bf=0x1172eca "", size=2038, arg=0x7fffffff8360) at trace/beauty/ioctl.c:182
  #1  0x000000000048e295 in syscall__scnprintf_val (sc=0x123b500, bf=0x1172eca "", size=2038, arg=0x7fffffff8360, val=21519)
      at builtin-trace.c:1594
  #2  0x000000000048e60d in syscall__scnprintf_args (sc=0x123b500, bf=0x1172ec6 "-1, ", size=2042, args=0x7ffff6a7c034 "\377\377\377\377",
      augmented_args=0x7ffff6a7c064, augmented_args_size=4, trace=0x7fffffffa8d0, thread=0x1175cd0) at builtin-trace.c:1661
  #3  0x000000000048f04e in trace__sys_enter (trace=0x7fffffffa8d0, evsel=0xb260b0, event=0x7ffff6a7bfe8, sample=0x7fffffff84f0)
      at builtin-trace.c:1880
  #4  0x00000000004915a4 in trace__handle_event (trace=0x7fffffffa8d0, event=0x7ffff6a7bfe8, sample=0x7fffffff84f0) at builtin-trace.c:2590
  #5  0x0000000000491eed in __trace__deliver_event (trace=0x7fffffffa8d0, event=0x7ffff6a7bfe8) at builtin-trace.c:2818
  #6  0x0000000000492030 in trace__deliver_event (trace=0x7fffffffa8d0, event=0x7ffff6a7bfe8) at builtin-trace.c:2845
  #7  0x0000000000492896 in trace__run (trace=0x7fffffffa8d0, argc=0, argv=0x7fffffffdb58) at builtin-trace.c:3040
  #8  0x000000000049603a in cmd_trace (argc=0, argv=0x7fffffffdb58) at builtin-trace.c:3952
  #9  0x00000000004d5103 in main (argc=1, argv=0x7fffffffdb58) at perf.c:474
  (gdb) p fd
  $1 = -1
  (gdb) p file
  $7 = (struct file *) 0xfffffffffffffff0
  (gdb) p ((struct thread_trace *)arg->thread)->files.table + fd
  $8 = (struct file *) 0xfffffffffffffff0
  (gdb)

Check for that and return NULL instead.

This problem was introduced recently, the other codepaths leading to
thread_trace__files_entry() check for negative fds, like thread__fd_path(),
but we need to do it at thread_trace__files_entry() as more users are now
calling it directly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 2d473389f87a ("perf trace beauty: Export function to get the files for a thread")
Link: https://lkml.kernel.org/n/tip-oq7bvaaf07gsd4yqty3107u2@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index b36061cd1ab8..2776ff8c3e81 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1039,6 +1039,9 @@ static const size_t trace__entry_str_size = 2048;
 
 static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int fd)
 {
+	if (fd < 0)
+		return NULL;
+
 	if (fd > ttrace->files.max) {
 		struct file *nfiles = realloc(ttrace->files.table, (fd + 1) * sizeof(struct file));
 
-- 
2.19.1

