Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB4CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E83AA2089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 23:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730551AbfJUXSy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 19:18:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38239 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbfJUXSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 19:18:53 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwm-0003o3-BM; Tue, 22 Oct 2019 01:18:44 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA8A11C0086;
        Tue, 22 Oct 2019 01:18:43 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf trace: Use STUL_STRARRAY_FLAGS with mmap
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-czw754b7m9rp9ibq2f6be2o1@git.kernel.org>
References: <tip-czw754b7m9rp9ibq2f6be2o1@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157169992330.29376.3168694023613817354.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     27198a893ba074407e7a87e346252b3e6fab454f
Gitweb:        https://git.kernel.org/tip/27198a893ba074407e7a87e346252b3e6fab454f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Sat, 19 Oct 2019 15:30:15 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:02 -03:00

perf trace: Use STUL_STRARRAY_FLAGS with mmap

The 'mmap' syscall has special needs so it doesn't use
SCA_STRARRAY_FLAGS, see its implementation in
syscall_arg__scnprintf_mmap_flags(), related to special handling of
MAP_ANONYMOUS, so set ->parm to the strarray__mmap_flags and hook up
with strarray__strtoul_flags manually, now we can filter by those or-ed
string expressions:

  # perf trace -e syscalls:sys_enter_mmap sleep 1
     0.000 syscalls:sys_enter_mmap(addr: NULL, len: 134346, prot: READ, flags: PRIVATE, fd: 3, off: 0)
     0.026 syscalls:sys_enter_mmap(addr: NULL, len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
     0.036 syscalls:sys_enter_mmap(addr: NULL, len: 1857472, prot: READ, flags: PRIVATE|DENYWRITE, fd: 3, off: 0)
     0.046 syscalls:sys_enter_mmap(addr: 0x7fae003d9000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
     0.052 syscalls:sys_enter_mmap(addr: 0x7fae00526000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
     0.055 syscalls:sys_enter_mmap(addr: 0x7fae00573000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
     0.062 syscalls:sys_enter_mmap(addr: 0x7fae00579000, len: 14272, prot: READ|WRITE, flags: PRIVATE|FIXED|ANONYMOUS)
     0.253 syscalls:sys_enter_mmap(addr: NULL, len: 217750512, prot: READ, flags: PRIVATE, fd: 3, off: 0)
  #

  # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|FIXED|DENYWRITE" sleep 1
     0.000 syscalls:sys_enter_mmap(addr: 0x7f6ab3dcb000, len: 1363968, prot: READ|EXEC, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x22000)
     0.010 syscalls:sys_enter_mmap(addr: 0x7f6ab3f18000, len: 311296, prot: READ, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x16f000)
     0.014 syscalls:sys_enter_mmap(addr: 0x7f6ab3f65000, len: 24576, prot: READ|WRITE, flags: PRIVATE|FIXED|DENYWRITE, fd: 3, off: 0x1bb000)
  # perf trace -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|ANONYMOUS" sleep 1
     0.000 syscalls:sys_enter_mmap(addr: NULL, len: 8192, prot: READ|WRITE, flags: PRIVATE|ANONYMOUS)
  #

  # perf trace -v -e syscalls:sys_enter_mmap --filter="flags==PRIVATE|ANONYMOUS" sleep 1 |& grep "New filter"
  New filter for syscalls:sys_enter_mmap: flags==0x22
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-czw754b7m9rp9ibq2f6be2o1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7bb84c4..43c05ea 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1015,7 +1015,9 @@ static struct syscall_fmt syscall_fmts[] = {
 	.alias = "old_mmap",
 #endif
 	  .arg = { [2] = { .scnprintf = SCA_MMAP_PROT,	/* prot */ },
-		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */ },
+		   [3] = { .scnprintf = SCA_MMAP_FLAGS,	/* flags */
+			   .strtoul   = STUL_STRARRAY_FLAGS,
+			   .parm      = &strarray__mmap_flags, },
 		   [5] = { .scnprintf = SCA_HEX,	/* offset */ }, }, },
 	{ .name	    = "mount",
 	  .arg = { [0] = { .scnprintf = SCA_FILENAME, /* dev_name */ },
