Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A1C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0EE921019
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 21:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BLc30wDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbfE1VXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 17:23:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36963 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfE1VXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 17:23:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4SLMgfI2238034
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 28 May 2019 14:22:42 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4SLMgfI2238034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559078563;
        bh=5kIVYq0t2CD5KdWGvolWWxDmy8CX0bGgpVx+8sYQbck=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BLc30wDwUdrHtl64TEJWmOZfZPSQdij44/gxiqEy/B1TvZb2rtUMmgwRzCa6X4AfX
         CR1uejlIhkAkmbZDy6tOAAnWCQRUlJF3ZmKbc9eu9Pt6Ye79m4tpwyoqiGgmbbVhks
         0jSV4jA3UIbvaOWP9eg1KfvwqwP3EgW0b1evxSOqZZxRDVzYNBUhdeV9rIHOHfRi0m
         WP+3L7yAL3t30zR78u46xKvJIRxsipSM7BasbSz/2YrMkEFkaN7bo9XacV3/Q9nXyL
         vYyFr750CiZg++TaejN9941yKRNGnzwIMpyrcY2B4AdYLY8FczDBg7xKVb2vEt+AOe
         WbeimgTtDie+Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4SLMftb2238031;
        Tue, 28 May 2019 14:22:41 -0700
Date:   Tue, 28 May 2019 14:22:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vitaly Chikunov <tipbot@zytor.com>
Message-ID: <tip-f95d050cdc5d34f9a4417e06c392ccbf146037bb@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, kim.phillips@arm.com,
        tglx@linutronix.de, mpetlan@redhat.com, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com,
        ravi.bangoria@linux.vnet.ibm.com, brueckner@linux.ibm.com,
        mingo@kernel.org, vt@altlinux.org
Reply-To: brueckner@linux.ibm.com, ravi.bangoria@linux.vnet.ibm.com,
          alexander.shishkin@linux.intel.com, mingo@kernel.org,
          vt@altlinux.org, mpetlan@redhat.com, kim.phillips@arm.com,
          tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          namhyung@kernel.org, jolsa@redhat.com, acme@redhat.com,
          peterz@infradead.org
In-Reply-To: <20190521030203.1447-1-vt@altlinux.org>
References: <20190521030203.1447-1-vt@altlinux.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf arm64: Fix mksyscalltbl when system kernel
 headers are ahead of the kernel
Git-Commit-ID: f95d050cdc5d34f9a4417e06c392ccbf146037bb
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

Commit-ID:  f95d050cdc5d34f9a4417e06c392ccbf146037bb
Gitweb:     https://git.kernel.org/tip/f95d050cdc5d34f9a4417e06c392ccbf146037bb
Author:     Vitaly Chikunov <vt@altlinux.org>
AuthorDate: Tue, 21 May 2019 06:02:03 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 09:49:03 -0300

perf arm64: Fix mksyscalltbl when system kernel headers are ahead of the kernel

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
