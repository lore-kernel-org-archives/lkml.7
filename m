Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08191C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E8B217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564434912;
	bh=29N9d4Vq4VHi9Jmd9mH00u5I+aUuGLGC70x8vQZEy6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d6hRF1D+4zW73SquzuysUhT/k1ILR6FyZUcBR0SS7kqsSGJkCj5n1sfooWWaKLqva
	 oLsaAJ1VtK7e1InZQSDym6WjvA6CNpuSwb6jcozN+MBBYIRS85lmbwQBEoFs+Rn3yF
	 Viyno88kWZIB2fyD3IiJ2P/aPvsqB8P3DjIzRScQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388582AbfG2VPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388482AbfG2VPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:15:08 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66B4A20C01;
        Mon, 29 Jul 2019 21:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564434908;
        bh=29N9d4Vq4VHi9Jmd9mH00u5I+aUuGLGC70x8vQZEy6U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eRbLIi4mcS/zCokdGNE2sk0qW29OIRef/fTMaC6xXqk27VcRuKl/QyUfW+L6KwZIl
         fBOx62k3LGgBAazpTQaCVLUQL5Yj7cc25bsma5WRNXuVpkv6ZbGpmiWF4SyZLk8D6K
         GWjfTLQJMezCHkwEapodz/t7m3pnPWpoU8tXC7pI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 01/12] tools include UAPI: Sync x86's syscalls_64.tbl and generic unistd.h to pick up clone3 and pidfd_open
Date:   Mon, 29 Jul 2019 18:14:48 -0300
Message-Id: <20190729211456.6380-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190729211456.6380-1-acme@kernel.org>
References: <20190729211456.6380-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  05a70a8ec287 ("unistd: protect clone3 via __ARCH_WANT_SYS_CLONE3")
  8f3220a80654 ("arch: wire-up clone3() syscall")
  7615d9e1780e ("arch: wire-up pidfd_open()")

Silencing the following tools/perf build warnings

  Warning: Kernel ABI header at 'tools/include/uapi/asm-generic/unistd.h' differs from latest version at 'include/uapi/asm-generic/unistd.h'
  diff -u tools/include/uapi/asm-generic/unistd.h include/uapi/asm-generic/unistd.h
  Warning: Kernel ABI header at 'tools/perf/arch/x86/entry/syscalls/syscall_64.tbl' differs from latest version at 'arch/x86/entry/syscalls/syscall_64.tbl'
  diff -u tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl

Now 'perf trace -e pidfd*,clone*' will trace those syscalls as well as the
others with those prefixes.

  $ diff -u /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c
  --- /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c.before	2019-07-26 12:24:55.020944201 -0300
  +++ /tmp/build/perf/arch/x86/include/generated/asm/syscalls_64.c	2019-07-26 12:25:03.919047217 -0300
  @@ -344,5 +344,7 @@
        [431] = "fsconfig",
        [432] = "fsmount",
        [433] = "fspick",
  +     [434] = "pidfd_open",
  +     [435] = "clone3",
   };
  -#define SYSCALLTBL_x86_64_MAX_ID 433
  +#define SYSCALLTBL_x86_64_MAX_ID 435
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Christian Brauner <christian@brauner.io>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-0isnnqxtr1ihz6p8wzjiy47d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm-generic/unistd.h           | 8 +++++++-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a87904daf103..1be0e798e362 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,15 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_pidfd_open 434
+__SYSCALL(__NR_pidfd_open, sys_pidfd_open)
+#ifdef __ARCH_WANT_SYS_CLONE3
+#define __NR_clone3 435
+__SYSCALL(__NR_clone3, sys_clone3)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 436
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..c29976eca4a8 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,8 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	pidfd_open		__x64_sys_pidfd_open
+435	common	clone3			__x64_sys_clone3/ptregs
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
-- 
2.21.0

