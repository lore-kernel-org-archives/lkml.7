Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1600EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D432184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfB1IJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:09:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1IJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:09:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S89IwA2955747
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:09:18 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S89I4R2955744;
        Thu, 28 Feb 2019 00:09:18 -0800
Date:   Thu, 28 Feb 2019 00:09:18 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-ee75a896ae535d4219a82cc361be96394536f3ba@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        tonyj@suse.de, tzanussi@gmail.com, acme@redhat.com, hpa@zytor.com,
        s1seetee@linux.vnet.ibm.com
Reply-To: tzanussi@gmail.com, hpa@zytor.com, s1seetee@linux.vnet.ibm.com,
          acme@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, mingo@kernel.org, tonyj@suse.de
In-Reply-To: <20190222230619.17887-11-tonyj@suse.de>
References: <20190222230619.17887-11-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add Python3 support to sctop.py
Git-Commit-ID: ee75a896ae535d4219a82cc361be96394536f3ba
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

Commit-ID:  ee75a896ae535d4219a82cc361be96394536f3ba
Gitweb:     https://git.kernel.org/tip/ee75a896ae535d4219a82cc361be96394536f3ba
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 22 Feb 2019 15:06:14 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 17:17:03 -0300

perf script python: Add Python3 support to sctop.py

Support both Python2 and Python3 in the sctop.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-11-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/sctop.py | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/sctop.py b/tools/perf/scripts/python/sctop.py
index 61621b93affb..987ffae7c8ca 100644
--- a/tools/perf/scripts/python/sctop.py
+++ b/tools/perf/scripts/python/sctop.py
@@ -8,7 +8,14 @@
 # will be refreshed every [interval] seconds.  The default interval is
 # 3 seconds.
 
-import os, sys, thread, time
+from __future__ import print_function
+
+import os, sys, time
+
+try:
+        import thread
+except ImportError:
+        import _thread as thread
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
 	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
@@ -62,18 +69,19 @@ def print_syscall_totals(interval):
 	while 1:
 		clear_term()
 		if for_comm is not None:
-			print "\nsyscall events for %s:\n\n" % (for_comm),
+			print("\nsyscall events for %s:\n" % (for_comm))
 		else:
-			print "\nsyscall events:\n\n",
+			print("\nsyscall events:\n")
 
-		print "%-40s  %10s\n" % ("event", "count"),
-		print "%-40s  %10s\n" % ("----------------------------------------", \
-						 "----------"),
+		print("%-40s  %10s" % ("event", "count"))
+		print("%-40s  %10s" %
+                        ("----------------------------------------",
+                        "----------"))
 
-		for id, val in sorted(syscalls.iteritems(), key = lambda(k, v): (v, k), \
+		for id, val in sorted(syscalls.items(), key = lambda kv: (kv[1], kv[0]), \
 					      reverse = True):
 			try:
-				print "%-40s  %10d\n" % (syscall_name(id), val),
+				print("%-40s  %10d" % (syscall_name(id), val))
 			except TypeError:
 				pass
 		syscalls.clear()
