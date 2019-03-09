Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6FEC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56AB206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCIUDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:03:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48171 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfCIUDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:03:02 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K2qj23203686
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:02:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K2pNW3203683;
        Sat, 9 Mar 2019 12:02:51 -0800
Date:   Sat, 9 Mar 2019 12:02:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-de2ec16bd438945813198d4de2339a396904c206@git.kernel.org>
Cc:     acme@redhat.com, mingo@kernel.org, tonyj@suse.de,
        tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        s1seetee@linux.vnet.ibm.com
Reply-To: acme@redhat.com, mingo@kernel.org, tonyj@suse.de,
          tglx@linutronix.de, hpa@zytor.com, s1seetee@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190302011903.2416-3-tonyj@suse.de>
References: <20190302011903.2416-3-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: Add Python3 support to
 futex-contention.py
Git-Commit-ID: de2ec16bd438945813198d4de2339a396904c206
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

Commit-ID:  de2ec16bd438945813198d4de2339a396904c206
Gitweb:     https://git.kernel.org/tip/de2ec16bd438945813198d4de2339a396904c206
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 1 Mar 2019 17:18:58 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:10:43 -0300

perf script python: Add Python3 support to futex-contention.py

Support both Python2 and Python3 in the futex-contention.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190302011903.2416-3-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
 
