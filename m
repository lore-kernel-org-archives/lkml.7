Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67D3C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E3820661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980857;
	bh=K5myyb6aDJyxfGS23Px04yxGvvCZI7z989KJXOfeqtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2e51Df14xZUA9sxxW8QONWAR57DjUG7XRhUDfVE5m0HR70+4MjboMk/trhpcLyqeR
	 zZq164VWKwt+2aHONrR7aavXcTYHROcW5bAEnxR5ZBHfQBTcn5HHJ51XJndPDyuuHK
	 TYVaZIapkD15TkayVUq7g/x07/2bWUvUPhA5H1iA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfCGRqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:46:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfCGRqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:46:37 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C470B2146E;
        Thu,  7 Mar 2019 17:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980796;
        bh=K5myyb6aDJyxfGS23Px04yxGvvCZI7z989KJXOfeqtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iEsrddhxaYVjEftPfhKhF2tJHuJ7IvbJg+9BEQ7HNrH7oILa2tyhZbufB46Jh1A2h
         zR1PijuTRa23GU/TSBJ3d3WiP/dePQ+sMCzG8JURPnDwDZk2fPMOEswkfhIbtM/JbB
         ZanwFSs8HceqwEyc9893CJy3r7IhWsEGHWpTk3Ks=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>, Tom Zanussi <tzanussi@gmail.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/35] perf script python: add Python3 support to check-perf-trace.py
Date:   Thu,  7 Mar 2019 14:44:24 -0300
Message-Id: <20190307174433.28819-27-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Jones <tonyj@suse.de>

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
 tools/perf/scripts/python/check-perf-trace.py | 31 ++++++++++---------
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
2.20.1

