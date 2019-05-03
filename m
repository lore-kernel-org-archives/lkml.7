Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD4C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AEB2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 00:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556843165;
	bh=ptuapJiqTvB4gNmOD/1cNqPZiOmxIe8gYrXtfjCkDXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dDM4g2jW+dByVEcWeEVSU1F3GL8BO7ZlcJPCLphr7dmMzIb76CWY2qIXVZ5QZu7mv
	 rag9BiB9wofjCrOPYoXdkaLwW+SA0XQuQI4q+Ru7tSYNovqT0+rRW0ScTHNL166Knb
	 X3ovaqcXorZy+yr7aAZQfR2GzVFBZqVfQ/R8fDe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfECA0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 20:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbfECA0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 20:26:01 -0400
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF0620B7C;
        Fri,  3 May 2019 00:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556843160;
        bh=ptuapJiqTvB4gNmOD/1cNqPZiOmxIe8gYrXtfjCkDXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WpPFHLFJwoZDjZpbKzU9qkBU7kKg/Zl0iZJD7ugxzSbridP6NMqlJY4WMsoUaLOGB
         vSKQQeifLdzougefWv7w1VxaJGV3sNUd3tmPuLy6B0dLZvL24kr1OfxlEl6CI4bfwZ
         f27VgQvuNufWotFsQrcxy4kFYKkAqXjIjDdMA/s4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 05/11] perf bench numa: Add define for RUSAGE_THREAD if not present
Date:   Thu,  2 May 2019 20:25:27 -0400
Message-Id: <20190503002533.29359-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503002533.29359-1-acme@kernel.org>
References: <20190503002533.29359-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

While cross building perf to the ARC architecture on a fedora 30 host,
we were failing with:

      CC       /tmp/build/perf/bench/numa.o
  bench/numa.c: In function ‘worker_thread’:
  bench/numa.c:1261:12: error: ‘RUSAGE_THREAD’ undeclared (first use in this function); did you mean ‘SIGEV_THREAD’?
    getrusage(RUSAGE_THREAD, &rusage);
              ^~~~~~~~~~~~~
              SIGEV_THREAD
  bench/numa.c:1261:12: note: each undeclared identifier is reported only once for each function it appears in

[perfbuilder@60d5802468f6 perf]$ /arc_gnu_2019.03-rc1_prebuilt_uclibc_le_archs_linux_install/bin/arc-linux-gcc --version | head -1
arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
[perfbuilder@60d5802468f6 perf]$

Trying to reproduce a report by Vineet, I noticed that, with just
cross-built zlib and numactl libraries, I ended up with the above
failure.

So, since RUSAGE_THREAD is available as a define, check for that and
numactl libraries, I ended up with the above failure.

So, since RUSAGE_THREAD is available as a define in the system headers,
check if it is defined in the 'perf bench numa' sources and define it if
not.

Now it builds and I have to figure out if the problem reported by Vineet
only takes place if we have libelf or some other library available.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: linux-snps-arc@lists.infradead.org
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Link: https://lkml.kernel.org/n/tip-2wb4r1gir9xrevbpq7qp0amk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/numa.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
index 98ad783efc69..a7784554a80d 100644
--- a/tools/perf/bench/numa.c
+++ b/tools/perf/bench/numa.c
@@ -39,6 +39,10 @@
 #include <numa.h>
 #include <numaif.h>
 
+#ifndef RUSAGE_THREAD
+# define RUSAGE_THREAD 1
+#endif
+
 /*
  * Regular printout to the terminal, supressed if -q is specified:
  */
-- 
2.20.1

