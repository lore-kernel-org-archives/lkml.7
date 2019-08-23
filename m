Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110FCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC9C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 02:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390435AbfHWC2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:28:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33788 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390210AbfHWC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJ8-00018J-AD; Fri, 23 Aug 2019 04:28:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C572D1C07E4;
        Fri, 23 Aug 2019 04:28:05 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:05 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] tools headers: Fixup bitsperlong per arch includes
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-8f8cfqywmf6jk8a3ucr0ixhu@git.kernel.org>
References: <tip-8f8cfqywmf6jk8a3ucr0ixhu@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652728564.12678.6447900186465158550.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     42fc2e9ef9603a7948aaa4ffd8dfb94b30294ad8
Gitweb:        https://git.kernel.org/tip/42fc2e9ef9603a7948aaa4ffd8dfb94b30294ad8
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 20 Aug 2019 11:45:17 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:23:00 -03:00

tools headers: Fixup bitsperlong per arch includes

We were getting the file by luck, from one of the paths in -I, fix it to
get it from the proper place:

  $ cd tools/include/uapi/asm/
  [acme@quaco asm]$ grep include bitsperlong.h
  #include "../../arch/x86/include/uapi/asm/bitsperlong.h"
  #include "../../arch/arm64/include/uapi/asm/bitsperlong.h"
  #include "../../arch/powerpc/include/uapi/asm/bitsperlong.h"
  #include "../../arch/s390/include/uapi/asm/bitsperlong.h"
  #include "../../arch/sparc/include/uapi/asm/bitsperlong.h"
  #include "../../arch/mips/include/uapi/asm/bitsperlong.h"
  #include "../../arch/ia64/include/uapi/asm/bitsperlong.h"
  #include "../../arch/riscv/include/uapi/asm/bitsperlong.h"
  #include "../../arch/alpha/include/uapi/asm/bitsperlong.h"
  #include <asm-generic/bitsperlong.h>
  $ ls -la ../../arch/x86/include/uapi/asm/bitsperlong.h
  ls: cannot access '../../arch/x86/include/uapi/asm/bitsperlong.h': No such file or directory
  $ ls -la ../../../arch/*/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 237 ../../../arch/alpha/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 841 ../../../arch/arm64/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 966 ../../../arch/hexagon/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 234 ../../../arch/ia64/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 100 ../../../arch/microblaze/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 244 ../../../arch/mips/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 352 ../../../arch/parisc/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 312 ../../../arch/powerpc/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 353 ../../../arch/riscv/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 292 ../../../arch/s390/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 323 ../../../arch/sparc/include/uapi/asm/bitsperlong.h
  -rw-rw-r--. 1 320 ../../../arch/x86/include/uapi/asm/bitsperlong.h
  $

Found while fixing some other problem, before it was escaping the
tools/ chroot and using stuff in the kernel sources:

    CC       /tmp/build/perf/util/find_bit.o
In file included from /git/linux/tools/include/../../arch/x86/include/uapi/asm/bitsperlong.h:11,
                 from /git/linux/tools/include/uapi/asm/bitsperlong.h:3,
                 from /git/linux/tools/include/linux/bits.h:6,
                 from /git/linux/tools/include/linux/bitops.h:13,
                 from ../lib/find_bit.c:17:

  # cd /git/linux/tools/include/../../arch/x86/include/uapi/asm/
  # pwd
  /git/linux/arch/x86/include/uapi/asm
  #

Now it is getting the one we want it to, i.e. the one inside tools/:

    CC       /tmp/build/perf/util/find_bit.o
  In file included from /git/linux/tools/arch/x86/include/uapi/asm/bitsperlong.h:11,
                   from /git/linux/tools/include/linux/bits.h:6,
                   from /git/linux/tools/include/linux/bitops.h:13,

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8f8cfqywmf6jk8a3ucr0ixhu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/asm/bitsperlong.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/include/uapi/asm/bitsperlong.h b/tools/include/uapi/asm/bitsperlong.h
index 57aaeaf..edba4d9 100644
--- a/tools/include/uapi/asm/bitsperlong.h
+++ b/tools/include/uapi/asm/bitsperlong.h
@@ -1,22 +1,22 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #if defined(__i386__) || defined(__x86_64__)
-#include "../../arch/x86/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/x86/include/uapi/asm/bitsperlong.h"
 #elif defined(__aarch64__)
-#include "../../arch/arm64/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/arm64/include/uapi/asm/bitsperlong.h"
 #elif defined(__powerpc__)
-#include "../../arch/powerpc/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/powerpc/include/uapi/asm/bitsperlong.h"
 #elif defined(__s390__)
-#include "../../arch/s390/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/s390/include/uapi/asm/bitsperlong.h"
 #elif defined(__sparc__)
-#include "../../arch/sparc/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/sparc/include/uapi/asm/bitsperlong.h"
 #elif defined(__mips__)
-#include "../../arch/mips/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/mips/include/uapi/asm/bitsperlong.h"
 #elif defined(__ia64__)
-#include "../../arch/ia64/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/ia64/include/uapi/asm/bitsperlong.h"
 #elif defined(__riscv)
-#include "../../arch/riscv/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/riscv/include/uapi/asm/bitsperlong.h"
 #elif defined(__alpha__)
-#include "../../arch/alpha/include/uapi/asm/bitsperlong.h"
+#include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
 #else
 #include <asm-generic/bitsperlong.h>
 #endif
