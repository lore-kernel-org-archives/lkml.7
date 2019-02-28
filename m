Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB99C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B892171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731739AbfB1IJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:09:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60813 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfB1IJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:09:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S881AW2955424
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:08:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S880xi2955420;
        Thu, 28 Feb 2019 00:08:00 -0800
Date:   Thu, 28 Feb 2019 00:08:00 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-8c42b9600e561666233b9c557a5209d0dc853ba1@git.kernel.org>
Cc:     tglx@linutronix.de, nhorman@tuxdriver.com, mingo@kernel.org,
        s1seetee@linux.vnet.ibm.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tonyj@suse.de
Reply-To: tglx@linutronix.de, nhorman@tuxdriver.com, acme@redhat.com,
          mingo@kernel.org, s1seetee@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, tonyj@suse.de
In-Reply-To: <20190222230619.17887-9-tonyj@suse.de>
References: <20190222230619.17887-9-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add Python3 support to
 net_dropmonitor.py
Git-Commit-ID: 8c42b9600e561666233b9c557a5209d0dc853ba1
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

Commit-ID:  8c42b9600e561666233b9c557a5209d0dc853ba1
Gitweb:     https://git.kernel.org/tip/8c42b9600e561666233b9c557a5209d0dc853ba1
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 22 Feb 2019 15:06:12 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 17:16:55 -0300

perf script python: Add Python3 support to net_dropmonitor.py

Support both Python2 and Python3 in the net_dropmonitor.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Acked-by: Neil Horman <nhorman@tuxdriver.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-9-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/net_dropmonitor.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/scripts/python/net_dropmonitor.py b/tools/perf/scripts/python/net_dropmonitor.py
index a150164b44a3..212557a02c50 100755
--- a/tools/perf/scripts/python/net_dropmonitor.py
+++ b/tools/perf/scripts/python/net_dropmonitor.py
@@ -1,6 +1,8 @@
 # Monitor the system for dropped packets and proudce a report of drop locations and counts
 # SPDX-License-Identifier: GPL-2.0
 
+from __future__ import print_function
+
 import os
 import sys
 
@@ -50,19 +52,19 @@ def get_sym(sloc):
 		return (None, 0)
 
 def print_drop_table():
-	print "%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT")
+	print("%25s %25s %25s" % ("LOCATION", "OFFSET", "COUNT"))
 	for i in drop_log.keys():
 		(sym, off) = get_sym(i)
 		if sym == None:
 			sym = i
-		print "%25s %25s %25s" % (sym, off, drop_log[i])
+		print("%25s %25s %25s" % (sym, off, drop_log[i]))
 
 
 def trace_begin():
-	print "Starting trace (Ctrl-C to dump results)"
+	print("Starting trace (Ctrl-C to dump results)")
 
 def trace_end():
-	print "Gathering kallsyms data"
+	print("Gathering kallsyms data")
 	get_kallsyms_table()
 	print_drop_table()
 
