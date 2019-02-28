Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268D4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FB12171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfB1IKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:10:09 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60697 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfB1IKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:10:08 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S89vp72955800
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 28 Feb 2019 00:09:57 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S89vpX2955797;
        Thu, 28 Feb 2019 00:09:57 -0800
Date:   Thu, 28 Feb 2019 00:09:57 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Jones <tipbot@zytor.com>
Message-ID: <tip-6d22d9991cf37edfe861569e2433342ad56206a7@git.kernel.org>
Cc:     tglx@linutronix.de, tonyj@suse.de, pbonzini@redhat.com,
        hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        s1seetee@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, s1seetee@linux.vnet.ibm.com,
          acme@redhat.com, mingo@kernel.org, pbonzini@redhat.com,
          hpa@zytor.com, tonyj@suse.de, tglx@linutronix.de
In-Reply-To: <20190222230619.17887-12-tonyj@suse.de>
References: <20190222230619.17887-12-tonyj@suse.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf script python: Add Python3 support to
 stackcollapse.py
Git-Commit-ID: 6d22d9991cf37edfe861569e2433342ad56206a7
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

Commit-ID:  6d22d9991cf37edfe861569e2433342ad56206a7
Gitweb:     https://git.kernel.org/tip/6d22d9991cf37edfe861569e2433342ad56206a7
Author:     Tony Jones <tonyj@suse.de>
AuthorDate: Fri, 22 Feb 2019 15:06:15 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 25 Feb 2019 17:17:05 -0300

perf script python: Add Python3 support to stackcollapse.py

Support both Python2 and Python3 in the stackcollapse.py script

There may be differences in the ordering of output lines due to
differences in dictionary ordering etc.  However the format within lines
should be unchanged.

The use of 'from __future__' implies the minimum supported Python2 version
is now v2.6

Signed-off-by: Tony Jones <tonyj@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com> <pbonzini@redhat.com>
Link: http://lkml.kernel.org/r/20190222230619.17887-12-tonyj@suse.de
Signed-off-by: Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/scripts/python/stackcollapse.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/stackcollapse.py b/tools/perf/scripts/python/stackcollapse.py
index 1697b5e18c96..5e703efaddcc 100755
--- a/tools/perf/scripts/python/stackcollapse.py
+++ b/tools/perf/scripts/python/stackcollapse.py
@@ -19,6 +19,8 @@
 # Written by Paolo Bonzini <pbonzini@redhat.com>
 # Based on Brendan Gregg's stackcollapse-perf.pl script.
 
+from __future__ import print_function
+
 import os
 import sys
 from collections import defaultdict
@@ -120,7 +122,6 @@ def process_event(param_dict):
     lines[stack_string] = lines[stack_string] + 1
 
 def trace_end():
-    list = lines.keys()
-    list.sort()
+    list = sorted(lines)
     for stack in list:
-        print "%s %d" % (stack, lines[stack])
+        print("%s %d" % (stack, lines[stack]))
