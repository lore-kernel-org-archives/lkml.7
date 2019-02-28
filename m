Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B84C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 975D72171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731970AbfB1IKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:10:48 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56701 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1IKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:10:48 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S8Aa3U2955920
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:10:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S8AZwx2955917;
        Thu, 28 Feb 2019 00:10:35 -0800
Date:   Thu, 28 Feb 2019 00:10:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-e985bf761db7646cebcd236249da08bd264069de@git.kernel.org>
Cc:     s1seetee@linux.vnet.ibm.com, tonyj@suse.de, acme@redhat.com,
        jolsa@kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: s1seetee@linux.vnet.ibm.com, jolsa@kernel.org, tonyj@suse.de,
          acme@redhat.com, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190222230619.17887-13-tonyj@suse.de>
References: <20190222230619.17887-13-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add Python3 support to
 stat-cpi.py
Git-Commit-ID: e985bf761db7646cebcd236249da08bd264069de
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

Commit-ID:  e985bf761db7646cebcd236249da08bd264069de
Gitweb:     https://git.kernel.org/tip/e985bf761db7646cebcd236249da08bd264069de
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 22 Feb 2019 15:06:16 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 17:17:07 -0300

perf script python: Add Python3 support to stat-cpi.py

Support both Python2 and Python3 in the stat-cpi.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190222230619.17887-13-tonyj@suse.de
Signed-off-by: Tony Jones <tonyj@suse.de>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/stat-cpi.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/stat-cpi.py b/tools/perf/scripts/python/stat-cpi.py
index a81ad8835a74..01fa933ff3cf 100644
--- a/tools/perf/scripts/python/stat-cpi.py
+++ b/tools/perf/scripts/python/stat-cpi.py
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 data    = {}
 times   = []
 threads = []
@@ -19,8 +21,8 @@ def store_key(time, cpu, thread):
         threads.append(thread)
 
 def store(time, event, cpu, thread, val, ena, run):
-    #print "event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" % \
-    #      (event, cpu, thread, time, val, ena, run)
+    #print("event %s cpu %d, thread %d, time %d, val %d, ena %d, run %d" %
+    #      (event, cpu, thread, time, val, ena, run))
 
     store_key(time, cpu, thread)
     key = get_key(time, event, cpu, thread)
@@ -58,7 +60,7 @@ def stat__interval(time):
             if ins != 0:
                 cpi = cyc/float(ins)
 
-            print "%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins)
+            print("%15f: cpu %d, thread %d -> cpi %f (%d/%d)" % (time/(float(1000000000)), cpu, thread, cpi, cyc, ins))
 
 def trace_end():
     pass
@@ -74,4 +76,4 @@ def trace_end():
 #                if ins != 0:
 #                    cpi = cyc/float(ins)
 #
-#                print "time %.9f, cpu %d, thread %d -> cpi %f" % (time/(float(1000000000)), cpu, thread, cpi)
+#                print("time %.9f, cpu %d, thread %d -> cpi %f" % (time/(float(1000000000)), cpu, thread, cpi))
