Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C18FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AEC21845
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfK2GC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:02:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47997 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfK2GC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:02:58 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMh-0008Hm-0T; Fri, 29 Nov 2019 07:02:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A9A3B1C1D25;
        Fri, 29 Nov 2019 07:02:50 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:50 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf regs: Make perf_reg_name() return "unknown"
 instead of NULL
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-95wjyv4o65nuaeweq31t7l1s@git.kernel.org>
References: <tip-95wjyv4o65nuaeweq31t7l1s@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737059.21853.15701174489164157405.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5b596e0ff0e1852197d4c82d3314db5e43126bf7
Gitweb:        https://git.kernel.org/tip/5b596e0ff0e1852197d4c82d3314db5e43126bf7
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 27 Nov 2019 10:13:34 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 28 Nov 2019 08:08:38 -03:00

perf regs: Make perf_reg_name() return "unknown" instead of NULL

To avoid breaking the build on arches where this is not wired up, at
least all the other features should be made available and when using
this specific routine, the "unknown" should point the user/developer to
the need to wire this up on this particular hardware architecture.

Detected in a container mipsel debian cross build environment, where it
shows up as:

  In file included from /usr/mipsel-linux-gnu/include/stdio.h:867,
                   from /git/linux/tools/perf/lib/include/perf/cpumap.h:6,
                   from util/session.c:13:
  In function 'printf',
      inlined from 'regs_dump__printf' at util/session.c:1103:3,
      inlined from 'regs__printf' at util/session.c:1131:2:
  /usr/mipsel-linux-gnu/include/bits/stdio2.h:107:10: error: '%-5s' directive argument is null [-Werror=format-overflow=]
    107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cross compiler details:

  mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909

Also on mips64:

  In file included from /usr/mips64-linux-gnuabi64/include/stdio.h:867,
                   from /git/linux/tools/perf/lib/include/perf/cpumap.h:6,
                   from util/session.c:13:
  In function 'printf',
      inlined from 'regs_dump__printf' at util/session.c:1103:3,
      inlined from 'regs__printf' at util/session.c:1131:2,
      inlined from 'regs_user__printf' at util/session.c:1139:3,
      inlined from 'dump_sample' at util/session.c:1246:3,
      inlined from 'machines__deliver_event' at util/session.c:1421:3:
  /usr/mips64-linux-gnuabi64/include/bits/stdio2.h:107:10: error: '%-5s' directive argument is null [-Werror=format-overflow=]
    107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  In function 'printf',
      inlined from 'regs_dump__printf' at util/session.c:1103:3,
      inlined from 'regs__printf' at util/session.c:1131:2,
      inlined from 'regs_intr__printf' at util/session.c:1147:3,
      inlined from 'dump_sample' at util/session.c:1249:3,
      inlined from 'machines__deliver_event' at util/session.c:1421:3:
  /usr/mips64-linux-gnuabi64/include/bits/stdio2.h:107:10: error: '%-5s' directive argument is null [-Werror=format-overflow=]
    107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cross compiler details:

  mips64-linux-gnuabi64-gcc (Debian 9.2.1-8) 9.2.1 20190909

Fixes: 2bcd355b71da ("perf tools: Add interface to arch registers sets")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-95wjyv4o65nuaeweq31t7l1s@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/perf_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index e014c2c..a454991 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -41,7 +41,7 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
 static inline const char *perf_reg_name(int id __maybe_unused)
 {
-	return NULL;
+	return "unknown";
 }
 
 static inline int perf_reg_value(u64 *valp __maybe_unused,
