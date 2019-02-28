Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED43206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfB1IJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:09:12 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40897 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfB1IJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:09:11 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S88eNV2955477
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:08:40 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S88djn2955474;
        Thu, 28 Feb 2019 00:08:39 -0800
Date:   Thu, 28 Feb 2019 00:08:39 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-118af5bf799bd1876c3999766d1d2f845d45f019@git.kernel.org>
Cc:     tonyj@suse.de, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        acme@redhat.com, s1seetee@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, mingo@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, tonyj@suse.de, tglx@linutronix.de,
          hpa@zytor.com, ravi.bangoria@linux.ibm.com,
          s1seetee@linux.vnet.ibm.com, mingo@kernel.org, acme@redhat.com
In-Reply-To: <20190222230619.17887-10-tonyj@suse.de>
References: <20190222230619.17887-10-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add Python3 support to
 powerpc-hcalls.py
Git-Commit-ID: 118af5bf799bd1876c3999766d1d2f845d45f019
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

Commit-ID:  118af5bf799bd1876c3999766d1d2f845d45f019
Gitweb:     https://git.kernel.org/tip/118af5bf799bd1876c3999766d1d2f845d45f019
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 22 Feb 2019 15:06:13 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 17:16:57 -0300

perf script python: Add Python3 support to powerpc-hcalls.py

Support both Python2 and Python3 in the powerpc-hcalls.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-10-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/powerpc-hcalls.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/powerpc-hcalls.py b/tools/perf/scripts/python/powerpc-hcalls.py
index 00e0e7476e55..8b78dc790adb 100644
--- a/tools/perf/scripts/python/powerpc-hcalls.py
+++ b/tools/perf/scripts/python/powerpc-hcalls.py
@@ -4,6 +4,8 @@
 #
 # Hypervisor call statisics
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -149,7 +151,7 @@ hcall_table = {
 }
 
 def hcall_table_lookup(opcode):
-	if (hcall_table.has_key(opcode)):
+	if (opcode in hcall_table):
 		return hcall_table[opcode]
 	else:
 		return opcode
@@ -157,8 +159,8 @@ def hcall_table_lookup(opcode):
 print_ptrn = '%-28s%10s%10s%10s%10s'
 
 def trace_end():
-	print print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)')
-	print '-' * 68
+	print(print_ptrn % ('hcall', 'count', 'min(ns)', 'max(ns)', 'avg(ns)'))
+	print('-' * 68)
 	for opcode in output:
 		h_name = hcall_table_lookup(opcode)
 		time = output[opcode]['time']
@@ -166,14 +168,14 @@ def trace_end():
 		min_t = output[opcode]['min']
 		max_t = output[opcode]['max']
 
-		print print_ptrn % (h_name, cnt, min_t, max_t, time/cnt)
+		print(print_ptrn % (h_name, cnt, min_t, max_t, time//cnt))
 
 def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 			opcode, retval):
-	if (d_enter.has_key(cpu) and d_enter[cpu].has_key(opcode)):
+	if (cpu in d_enter and opcode in d_enter[cpu]):
 		diff = nsecs(sec, nsec) - d_enter[cpu][opcode]
 
-		if (output.has_key(opcode)):
+		if (opcode in output):
 			output[opcode]['time'] += diff
 			output[opcode]['cnt'] += 1
 			if (output[opcode]['min'] > diff):
@@ -190,11 +192,11 @@ def powerpc__hcall_exit(name, context, cpu, sec, nsec, pid, comm, callchain,
 
 		del d_enter[cpu][opcode]
 #	else:
-#		print "Can't find matching hcall_enter event. Ignoring sample"
+#		print("Can't find matching hcall_enter event. Ignoring sample")
 
 def powerpc__hcall_entry(event_name, context, cpu, sec, nsec, pid, comm,
 			 callchain, opcode):
-		if (d_enter.has_key(cpu)):
+		if (cpu in d_enter):
 			d_enter[cpu][opcode] = nsecs(sec, nsec)
 		else:
 			d_enter[cpu] = {opcode: nsecs(sec, nsec)}
