Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE38C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E65D7206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 21:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LLMNtyr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387730AbfG2V3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 17:29:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34015 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfG2V3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 17:29:04 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6TLSf2o2940582
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Jul 2019 14:28:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6TLSf2o2940582
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564435721;
        bh=tHNdYHgq9WQYeHJWzgcv/Lkf2KXCSAw3tN4GYDF1uEo=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=LLMNtyr0bPhr/kLMCuMHh+HxkCt951Hkq9G6gY12Ns4Cd8NKsahH9FsVFYoSjVMJG
         yrJQ5Zk54kA+7Kw0n9DkRFRyRss2sJ5VqJLt28CKJbhGKgr6f396cUL8iez6x8bwlo
         nsspMTbXoTwWujuiDGedzfXlz9VG/IWmSMJ+NMuU0dVhzLne4wdcsaG1WXMwM1vLIy
         NjagsbmXUp+CYF3BEQydF5xh8iPZXhzYQWAIhzCcIc1XmiDvZVn/3OqcIIWJALUZ2z
         +/TWNW6sqMEkPZMUHDXcE3qBDbrir1ZcDsmGWH+4vYgCN5XxPBxu0Y4W8mwA5o1Rg2
         PfkoqBxoFpPoQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6TLSe452940579;
        Mon, 29 Jul 2019 14:28:40 -0700
Date:   Mon, 29 Jul 2019 14:28:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-0isnnqxtr1ihz6p8wzjiy47d@git.kernel.org>
Cc:     namhyung@kernel.org, christian@brauner.io,
        linux-kernel@vger.kernel.org, brendan.d.gregg@gmail.com,
        acme@redhat.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, lclaudio@redhat.com, adrian.hunter@intel.com,
        hpa@zytor.com
Reply-To: acme@redhat.com, tglx@linutronix.de, mingo@kernel.org,
          christian@brauner.io, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, brendan.d.gregg@gmail.com,
          adrian.hunter@intel.com, hpa@zytor.com, jolsa@kernel.org,
          lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools include UAPI: Sync x86's syscalls_64.tbl
 and generic unistd.h to pick up clone3 and pidfd_open
Git-Commit-ID: 820571af721990e354649368e641313f85a29976
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

Commit-ID:  820571af721990e354649368e641313f85a29976
Gitweb:     https://git.kernel.org/tip/820571af721990e354649368e641313f85a29976
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 26 Jul 2019 12:31:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 26 Jul 2019 12:31:28 -0300

tools include UAPI: Sync x86's syscalls_64.tbl and generic unistd.h to pick up clone3 and pidfd_open

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
