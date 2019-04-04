Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBE9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5572075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369245;
	bh=MW3QXtTB3k8m5N7D6z9Bv0AB/+N9url5x7poAwKSVr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NL0VUNAXeE/co+j6YmeTGSIsJcAWAa3GgWmigmTodkyOqrnPOCTWawSpFCimUdYJw
	 iZt+54P3HnTHr1kn4UHHj8x+9g6fCjbZ5uSfCww6CCVdnUsICFwn+aPcr6esxKudMu
	 JByFLp+oAc+hL93ar5p/nGZka8Lot3j6Jy6DTrkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfDDJOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387637AbfDDJNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:13:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF672075E;
        Thu,  4 Apr 2019 09:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369235;
        bh=MW3QXtTB3k8m5N7D6z9Bv0AB/+N9url5x7poAwKSVr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEOeWOjr4sKJIMW8DXPjS/aDxSks57UqEif9wMC/03TZZxzbRLvnII2cSM88a/wkg
         k0l2m4igJuu1axBpzc8c4ZXk5W4m+Wm1m8xhWeubnq6Gix0S+5N4SusVB1sj4L8WG9
         NLfQFQoV60PzIS9RGqXyfvqR1LisycLRhpOqPaxY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 134/246] perf trace: Check if the fd is negative when mapping it to pathname
Date:   Thu,  4 Apr 2019 10:47:14 +0200
Message-Id: <20190404084623.857259861@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

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



