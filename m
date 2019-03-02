Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC59C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D692075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfCBBSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:18:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:47538 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfCBBSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:18:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56C59AD3E;
        Sat,  2 Mar 2019 01:18:01 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2 2/7] perf script python: add Python3 support to futex-contention.py
Date:   Fri,  1 Mar 2019 17:18:58 -0800
Message-Id: <20190302011903.2416-3-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302011903.2416-1-tonyj@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python2 and Python3 in the futex-contention.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/futex-contention.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/futex-contention.py b/tools/perf/scripts/python/futex-contention.py
index f221c62e0a10..0c4841acf75d 100644
--- a/tools/perf/scripts/python/futex-contention.py
+++ b/tools/perf/scripts/python/futex-contention.py
@@ -10,6 +10,8 @@
 #
 # Measures futex contention
 
+from __future__ import print_function
+
 import os, sys
 sys.path.append(os.environ['PERF_EXEC_PATH'] + '/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
 from Util import *
@@ -33,18 +35,18 @@ def syscalls__sys_enter_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 
 def syscalls__sys_exit_futex(event, ctxt, cpu, s, ns, tid, comm, callchain,
 			     nr, ret):
-	if thread_blocktime.has_key(tid):
+	if tid in thread_blocktime:
 		elapsed = nsecs(s, ns) - thread_blocktime[tid]
 		add_stats(lock_waits, (tid, thread_thislock[tid]), elapsed)
 		del thread_blocktime[tid]
 		del thread_thislock[tid]
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	for (tid, lock) in lock_waits:
 		min, max, avg, count = lock_waits[tid, lock]
-		print "%s[%d] lock %x contended %d times, %d avg ns" % \
-			(process_names[tid], tid, lock, count, avg)
+		print("%s[%d] lock %x contended %d times, %d avg ns" %
+			(process_names[tid], tid, lock, count, avg))
 
-- 
2.16.4

