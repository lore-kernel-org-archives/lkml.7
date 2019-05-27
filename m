Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB41C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7429F21473
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 22:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558996693;
	bh=tCPtO5z470/cO4hF2Bk29YtIFPTxH6MYGGFO/n/gFNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xsT99Wyoj0BzTCGs7EV9TAgNRjrRG94NwtxMtuwDq+K/nAVwEpkzritW8gflSDVZu
	 BuXPjV+I/MBOgEkf2UHd3XTAvplwnmrhGxjmz1bhINHtX7C6jv1twwelsmHk5Qc4+c
	 Ll0HRvSAtogN85DrVjuHHV0mA2guXLxeZQczIqsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfE0WiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 18:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfE0WiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 18:38:08 -0400
Received: from quaco.ghostprotocols.net (179-240-171-7.3g.claro.net.br [179.240.171.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF2F420859;
        Mon, 27 May 2019 22:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558996687;
        bh=tCPtO5z470/cO4hF2Bk29YtIFPTxH6MYGGFO/n/gFNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/0p2Oen6DihDC/VaG2TNDz0wXZT6jtXnXoGF9s4jci32t89ZWp+PJab0W/Y5nvFT
         cD358vUONgxwMR+BQzYXeig7Hu9n627I8vTJcaHoSJeGwQPXzjoEQ/xM0v4gpvB22q
         jkcTPON8sM5TkFTq163NXYNqFKX8VCKMxPpOQ0cY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Vitaly Chikunov <vt@altlinux.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH 06/44] perf arm64: Fix mksyscalltbl when system kernel headers are ahead of the kernel
Date:   Mon, 27 May 2019 19:36:52 -0300
Message-Id: <20190527223730.11474-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Chikunov <vt@altlinux.org>

When a host system has kernel headers that are newer than a compiling
kernel, mksyscalltbl fails with errors such as:

  <stdin>: In function 'main':
  <stdin>:271:44: error: '__NR_kexec_file_load' undeclared (first use in this function)
  <stdin>:271:44: note: each undeclared identifier is reported only once for each function it appears in
  <stdin>:272:46: error: '__NR_pidfd_send_signal' undeclared (first use in this function)
  <stdin>:273:43: error: '__NR_io_uring_setup' undeclared (first use in this function)
  <stdin>:274:43: error: '__NR_io_uring_enter' undeclared (first use in this function)
  <stdin>:275:46: error: '__NR_io_uring_register' undeclared (first use in this function)
  tools/perf/arch/arm64/entry/syscalls//mksyscalltbl: line 48: /tmp/create-table-xvUQdD: Permission denied

mksyscalltbl is compiled with default host includes, but run with
compiling kernel tree includes, causing some syscall numbers to being
undeclared.

Committer testing:

Before this patch, in my cross build environment, no build problems, but
these new syscalls were not in the syscalls.c generated from the
unistd.h file, which is a bug, this patch fixes it:

perfbuilder@6e20056ed532:/git/perf$ tail /tmp/build/perf/arch/arm64/include/generated/asm/syscalls.c
	[292] = "io_pgetevents",
	[293] = "rseq",
	[294] = "kexec_file_load",
	[424] = "pidfd_send_signal",
	[425] = "io_uring_setup",
	[426] = "io_uring_enter",
	[427] = "io_uring_register",
	[428] = "syscalls",
};
perfbuilder@6e20056ed532:/git/perf$ strings /tmp/build/perf/perf | egrep '^(io_uring_|pidfd_|kexec_file)'
kexec_file_load
pidfd_send_signal
io_uring_setup
io_uring_enter
io_uring_register
perfbuilder@6e20056ed532:/git/perf$
$

Well, there is that last "syscalls" thing, but that looks like some
other bug.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Michael Petlan <mpetlan@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20190521030203.1447-1-vt@altlinux.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
index c88fd32563eb..459469b7222c 100755
--- a/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
+++ b/tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
@@ -56,7 +56,7 @@ create_table()
 	echo "};"
 }
 
-$gcc -E -dM -x c  $input	       \
+$gcc -E -dM -x c -I $incpath/include/uapi $input \
 	|sed -ne 's/^#define __NR_//p' \
 	|sort -t' ' -k2 -nu	       \
 	|create_table
-- 
2.20.1

