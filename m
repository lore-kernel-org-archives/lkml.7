Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D39DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2706D218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbfB1IMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:12:10 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49817 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbfB1IMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:12:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S8BtLE2956047
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:11:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S8Bs912956044;
        Thu, 28 Feb 2019 00:11:54 -0800
Date:   Thu, 28 Feb 2019 00:11:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-de667cce7f4f96b6e22da8fd9c065b961f355080@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, tonyj@suse.de, mingo@kernel.org,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        s1seetee@linux.vnet.ibm.com
Reply-To: s1seetee@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
          acme@redhat.com, mingo@kernel.org, tonyj@suse.de,
          tglx@linutronix.de, hpa@zytor.com
In-Reply-To: <20190222230619.17887-15-tonyj@suse.de>
References: <20190222230619.17887-15-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add Python3 support to
 syscall-counts-by-pid.py
Git-Commit-ID: de667cce7f4f96b6e22da8fd9c065b961f355080
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

Commit-ID:  de667cce7f4f96b6e22da8fd9c065b961f355080
Gitweb:     https://git.kernel.org/tip/de667cce7f4f96b6e22da8fd9c065b961f355080
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 22 Feb 2019 15:06:18 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 17:17:13 -0300

perf script python: Add Python3 support to syscall-counts-by-pid.py

Support both Python2 and Python3 in the syscall-counts-by-pid.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190222230619.17887-15-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/syscall-counts-by-pid.py | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/syscall-counts-by-pid.py b/tools/perf/scripts/python/syscall-counts-by-pid.py
index daf314cc5dd3..42782487b0e9 100644
--- a/tools/perf/scripts/python/syscall-counts-by-pid.py
+++ b/tools/perf/scripts/python/syscall-counts-by-pid.py
@@ -5,6 +5,8 @@
 # Displays system-wide system call totals, broken down by syscall.
 # If a [comm] arg is specified, only syscalls called by [comm] are displayed.
 
+from __future__ import print_function
+
 import os, sys
 
 sys.path.append(os.environ['PERF_EXEC_PATH'] + \
@@ -31,7 +33,7 @@ if len(sys.argv) > 1:
 syscalls = autodict()
 
 def trace_begin():
-	print "Press control+C to stop and show the summary"
+	print("Press control+C to stop and show the summary")
 
 def trace_end():
 	print_syscall_totals()
@@ -55,20 +57,20 @@ def syscalls__sys_enter(event_name, context, common_cpu,
 
 def print_syscall_totals():
     if for_comm is not None:
-	    print "\nsyscall events for %s:\n\n" % (for_comm),
+	    print("\nsyscall events for %s:\n" % (for_comm))
     else:
-	    print "\nsyscall events by comm/pid:\n\n",
+	    print("\nsyscall events by comm/pid:\n")
 
-    print "%-40s  %10s\n" % ("comm [pid]/syscalls", "count"),
-    print "%-40s  %10s\n" % ("----------------------------------------", \
-                                 "----------"),
+    print("%-40s  %10s" % ("comm [pid]/syscalls", "count"))
+    print("%-40s  %10s" % ("----------------------------------------",
+                            "----------"))
 
     comm_keys = syscalls.keys()
     for comm in comm_keys:
 	    pid_keys = syscalls[comm].keys()
 	    for pid in pid_keys:
-		    print "\n%s [%d]\n" % (comm, pid),
+		    print("\n%s [%d]" % (comm, pid))
 		    id_keys = syscalls[comm][pid].keys()
-		    for id, val in sorted(syscalls[comm][pid].iteritems(), \
-				  key = lambda(k, v): (v, k),  reverse = True):
-			    print "  %-38s  %10d\n" % (syscall_name(id), val),
+		    for id, val in sorted(syscalls[comm][pid].items(), \
+				  key = lambda kv: (kv[1], kv[0]),  reverse = True):
+			    print("  %-38s  %10d" % (syscall_name(id), val))
