Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540FD206BA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 20:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfCIUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 15:03:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:37267 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfCIUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 15:03:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29K3XrP3203951
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 12:03:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29K3X2b3203948;
        Sat, 9 Mar 2019 12:03:33 -0800
Date:   Sat, 9 Mar 2019 12:03:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-57e604b16362273af6a517abaa6cd1133a7fc732@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, s1seetee@linux.vnet.ibm.com,
        acme@redhat.com, tonyj@suse.de, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, tzanussi@gmail.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, tzanussi@gmail.com,
          tonyj@suse.de, hpa@zytor.com, s1seetee@linux.vnet.ibm.com,
          acme@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20190302011903.2416-4-tonyj@suse.de>
References: <20190302011903.2416-4-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script python: add Python3 support to
 check-perf-trace.py
Git-Commit-ID: 57e604b16362273af6a517abaa6cd1133a7fc732
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

Commit-ID:  57e604b16362273af6a517abaa6cd1133a7fc732
Gitweb:     https://git.kernel.org/tip/57e604b16362273af6a517abaa6cd1133a7fc732
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 1 Mar 2019 17:18:59 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Mar 2019 18:10:46 -0300

perf script python: add Python3 support to check-perf-trace.py

Support both Python 2 and Python 3 in the check-perf-trace.py script.

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of from __future__ implies the minimum supported version of
Python2 is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Tom Zanussi <tzanussi@gmail.com>
Link: http://lkml.kernel.org/r/20190302011903.2416-4-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/check-perf-trace.py | 31 +++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/perf/scripts/python/check-perf-trace.py b/tools/perf/scripts/python/check-perf-trace.py
index f4838db3e518..d2c22954800d 100644
--- a/tools/perf/scripts/python/check-perf-trace.py
+++ b/tools/perf/scripts/python/check-perf-trace.py
@@ -7,6 +7,8 @@
 # events, etc.  Basically, if this script runs successfully and
 # displays expected results, Python scripting support should be ok.
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -19,7 +21,7 @@ from perf_trace_context import *
 unhandled = autodict()
 
 def trace_begin():
-	print "trace_begin"
+	print("trace_begin")
 	pass
 
 def trace_end():
@@ -33,7 +35,7 @@ def irq__softirq_entry(event_name, context, common_cpu,
 
 	print_uncommon(context)
 
-	print "vec=%s\n" % (symbol_str("irq__softirq_entry", "vec", vec)),
+	print("vec=%s" % (symbol_str("irq__softirq_entry", "vec", vec)))
 
 def kmem__kmalloc(event_name, context, common_cpu,
 		  common_secs, common_nsecs, common_pid, common_comm,
@@ -44,10 +46,10 @@ def kmem__kmalloc(event_name, context, common_cpu,
 
 	print_uncommon(context)
 
-	print "call_site=%u, ptr=%u, bytes_req=%u, " \
-		"bytes_alloc=%u, gfp_flags=%s\n" % \
+	print("call_site=%u, ptr=%u, bytes_req=%u, "
+		"bytes_alloc=%u, gfp_flags=%s" %
 		(call_site, ptr, bytes_req, bytes_alloc,
-		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)),
+		flag_str("kmem__kmalloc", "gfp_flags", gfp_flags)))
 
 def trace_unhandled(event_name, context, event_fields_dict):
 	try:
@@ -56,26 +58,27 @@ def trace_unhandled(event_name, context, event_fields_dict):
 		unhandled[event_name] = 1
 
 def print_header(event_name, cpu, secs, nsecs, pid, comm):
-	print "%-20s %5u %05u.%09u %8u %-20s " % \
+	print("%-20s %5u %05u.%09u %8u %-20s " %
 		(event_name, cpu, secs, nsecs, pid, comm),
+		end=' ')
 
 # print trace fields not included in handler args
 def print_uncommon(context):
-	print "common_preempt_count=%d, common_flags=%s, " \
-		"common_lock_depth=%d, " % \
+	print("common_preempt_count=%d, common_flags=%s, "
+		"common_lock_depth=%d, " %
 		(common_pc(context), trace_flag_str(common_flags(context)),
-		common_lock_depth(context))
+		common_lock_depth(context)))
 
 def print_unhandled():
 	keys = unhandled.keys()
 	if not keys:
 		return
 
-	print "\nunhandled events:\n\n",
+	print("\nunhandled events:\n")
 
-	print "%-40s  %10s\n" % ("event", "count"),
-	print "%-40s  %10s\n" % ("----------------------------------------", \
-				"-----------"),
+	print("%-40s  %10s" % ("event", "count"))
+	print("%-40s  %10s" % ("----------------------------------------",
+				"-----------"))
 
 	for event_name in keys:
-		print "%-40s  %10d\n" % (event_name, unhandled[event_name])
+		print("%-40s  %10d\n" % (event_name, unhandled[event_name]))
