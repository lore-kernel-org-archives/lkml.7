Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E830EC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5A20818
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfCBBSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:18:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:47552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727727AbfCBBSG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:18:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 177B5ADE3;
        Sat,  2 Mar 2019 01:18:04 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Tom Zanussi <tzanussi@gmail.com>
Subject: [PATCH v2 3/7] perf script python: add Python3 support to check-perf-trace.py
Date:   Fri,  1 Mar 2019 17:18:59 -0800
Message-Id: <20190302011903.2416-4-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302011903.2416-1-tonyj@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support both Python 2 and Python 3 in the check-perf-trace.py script.

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of from __future__ implies the minimum supported version of
Python2 is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Tom Zanussi <tzanussi@gmail.com>
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
-- 
2.16.4

