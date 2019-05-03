Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEFAC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59662087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JI3J7MIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfECFzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:55:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECFzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:55:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435t1fa2618371
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:55:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435t1fa2618371
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556862901;
        bh=MwORd4q2xfAFFRvpFXe1a4INuIQKvRj9r0qeRlPshkg=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=JI3J7MIlij0ELLCmRWcswOLvtxwOE9FOWzTazM+2IO+vI1+8BeQwzKLhNAUSjvaTP
         XO+VwskQ7yg8M7vK5XjTRpHRDWzKwRmVBXPq7CFd+uZphcgqCiSn43crPnHm42vbqG
         sbDCEFZrUnyllR6iD05/wVi20pWC0ZNsHutVLm3BDxAU+R2f9i8VK8JjNEzlTgG5EM
         +uLIqfresoHDqLKjfDKxgsHT8dSyU5rcH4sSJwn9CTuUpsfpNrctfYFlcXBfjltOin
         UU1VRXTctujL25fuogtMLsIQe715jkBFCS/hnEsjXoIOpJNPAL1ZJgrk5/Zrqzsltw
         tkULelQUsW5BQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435t0p62618368;
        Thu, 2 May 2019 22:55:00 -0700
Date:   Thu, 2 May 2019 22:55:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-2wb4r1gir9xrevbpq7qp0amk@git.kernel.org>
Cc:     Vineet.Gupta1@synopsys.com, linux-kernel@vger.kernel.org,
        acme@redhat.com, namhyung@kernel.org, mingo@kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, arnd@arndb.de, hpa@zytor.com
Reply-To: hpa@zytor.com, arnd@arndb.de, tglx@linutronix.de,
          jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          Vineet.Gupta1@synopsys.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf bench numa: Add define for RUSAGE_THREAD if
 not present
Git-Commit-ID: bf561d3c13423fc54daa19b5d49dc15fafdb7acc
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

Commit-ID:  bf561d3c13423fc54daa19b5d49dc15fafdb7acc
Gitweb:     https://git.kernel.org/tip/bf561d3c13423fc54daa19b5d49dc15fafdb7acc
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 25 Apr 2019 18:36:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

perf bench numa: Add define for RUSAGE_THREAD if not present

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
