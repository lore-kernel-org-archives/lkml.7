Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979AFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CB62184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbfB1IHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:07:36 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39133 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfB1IHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:07:36 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S87Kdg2955373
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:07:20 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S87K9j2955369;
        Thu, 28 Feb 2019 00:07:20 -0800
Date:   Thu, 28 Feb 2019 00:07:20 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-e4d053ddb4c48cbde27b4c5edd3cc8f957684e4f@git.kernel.org>
Cc:     s1seetee@linux.vnet.ibm.com, tonyj@suse.de,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        acme@redhat.com, mingo@kernel.org
Reply-To: mingo@kernel.org, acme@redhat.com, tonyj@suse.de,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          s1seetee@linux.vnet.ibm.com
In-Reply-To: <20190222230619.17887-8-tonyj@suse.de>
References: <20190222230619.17887-8-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add Python3 support to
 mem-phys-addr.py
Git-Commit-ID: e4d053ddb4c48cbde27b4c5edd3cc8f957684e4f
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

Commit-ID:  e4d053ddb4c48cbde27b4c5edd3cc8f957684e4f
Gitweb:     https://git.kernel.org/tip/e4d053ddb4c48cbde27b4c5edd3cc8f957684e4f
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 22 Feb 2019 15:06:11 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 17:16:51 -0300

perf script python: Add Python3 support to mem-phys-addr.py

Support both Python2 and Python3 in the mem-phys-addr.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Link: http://lkml.kernel.org/r/20190222230619.17887-8-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/mem-phys-addr.py | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/tools/perf/scripts/python/mem-phys-addr.py b/tools/perf/scripts/python/mem-phys-addr.py
index ebee2c5ae496..fb0bbcbfa0f0 100644
--- a/tools/perf/scripts/python/mem-phys-addr.py
+++ b/tools/perf/scripts/python/mem-phys-addr.py
@@ -4,6 +4,8 @@
 # Copyright (c) 2018, Intel Corporation.
 
 from __future__ import division
+from __future__ import print_function
+
 import os
 import sys
 import struct
@@ -31,21 +33,23 @@ def parse_iomem():
 	for i, j in enumerate(f):
 		m = re.split('-|:',j,2)
 		if m[2].strip() == 'System RAM':
-			system_ram.append(long(m[0], 16))
-			system_ram.append(long(m[1], 16))
+			system_ram.append(int(m[0], 16))
+			system_ram.append(int(m[1], 16))
 		if m[2].strip() == 'Persistent Memory':
-			pmem.append(long(m[0], 16))
-			pmem.append(long(m[1], 16))
+			pmem.append(int(m[0], 16))
+			pmem.append(int(m[1], 16))
 
 def print_memory_type():
-	print "Event: %s" % (event_name)
-	print "%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"),
-	print "%-40s  %10s  %10s\n" % ("----------------------------------------", \
+	print("Event: %s" % (event_name))
+	print("%-40s  %10s  %10s\n" % ("Memory type", "count", "percentage"), end='')
+	print("%-40s  %10s  %10s\n" % ("----------------------------------------",
 					"-----------", "-----------"),
+                                        end='');
 	total = sum(load_mem_type_cnt.values())
 	for mem_type, count in sorted(load_mem_type_cnt.most_common(), \
-					key = lambda(k, v): (v, k), reverse = True):
-		print "%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+					key = lambda kv: (kv[1], kv[0]), reverse = True):
+		print("%-40s  %10d  %10.1f%%\n" % (mem_type, count, 100 * count / total),
+                        end='')
 
 def trace_begin():
 	parse_iomem()
@@ -80,7 +84,7 @@ def find_memory_type(phys_addr):
 	f.seek(0, 0)
 	for j in f:
 		m = re.split('-|:',j,2)
-		if long(m[0], 16) <= phys_addr <= long(m[1], 16):
+		if int(m[0], 16) <= phys_addr <= int(m[1], 16):
 			return m[2]
 	return "N/A"
 
