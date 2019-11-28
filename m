Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2FFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700262176D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948515;
	bh=SBvTJLGCaw9pIWbGSTLHg5II4/ZJz5UVTMRnbPO+C9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YQ5yDlosomKDNNOfaTJZ7PlL6FAECD6QMBQ3BvB04XJUtjE6OUQ14jWTKWawTYUBy
	 wMAhLsbqP7uRx6SRtR+KbBb1Tog7JHG9OcrtOEySWVUmDPCe08tcHxxR8Bx4qiIz7A
	 CKUHkXf2wj6AcfqpWImnGOaGxZ4bbdsg06qMVU7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfK1Nli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfK1Nle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:34 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBC2216F4;
        Thu, 28 Nov 2019 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948493;
        bh=SBvTJLGCaw9pIWbGSTLHg5II4/ZJz5UVTMRnbPO+C9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rv8O0agd3ZpcwLWPBUXfcDo0b+g/jxdUXjuh8ylNka9WOye98+GZ3CJpyBP/cpk1k
         NKVE45d5gpfsVLT7RpQCmjSEvbvL2an6mG+wlWIbKQiNXNv7ZpLh42gw7G2sUSIqR6
         ULQXQp72e2LbDWts/cOlixQNpKMSzfAEnSnaqi/A=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/22] perf regs: Make perf_reg_name() return "unknown" instead of NULL
Date:   Thu, 28 Nov 2019 10:40:23 -0300
Message-Id: <20191128134027.23726-19-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index e014c2c038f4..a45499126184 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -41,7 +41,7 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
 
 static inline const char *perf_reg_name(int id __maybe_unused)
 {
-	return NULL;
+	return "unknown";
 }
 
 static inline int perf_reg_value(u64 *valp __maybe_unused,
-- 
2.21.0

