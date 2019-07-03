Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC3FC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA8621852
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfGCTxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfGCTxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:53:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2C6218A3;
        Wed,  3 Jul 2019 19:53:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hilJM-0006WB-AR; Wed, 03 Jul 2019 15:53:00 -0400
Message-Id: <20190703195300.213665674@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Jul 2019 15:50:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, shuah <shuah@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Po-Hsu Lin <po-hsu.lin@canonical.com>
Subject: [PATCH 1/2] ftrace/selftests: Return the skip code when tracing directory not
 configured in kernel
References: <20190703194959.596805445@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the kernel is not configured with ftrace enabled, the ftracetest
selftests should return the error code of "4" as that is the kselftests
"skip" code, and not "1" which means an error.

To determine if ftrace is enabled, first the newer "tracefs" is searched for
in /proc/mounts. If it is not found, then "debugfs" is searched for (as old
kernels do not have tracefs). If that is not found, an attempt to mount the
tracefs or debugfs is performed. This is done by seeing first if the
/sys/kernel/tracing directory exists. If it does than tracefs is configured
in the kernel and an attempt to mount it is performed.

If /sys/kernel/tracing does not exist, then /sys/kernel/debug is tested to
see if that directory exists. If it does, then an attempt to mount debugfs
on that directory is performed. If it does not exist, then debugfs is not
configured in the running kernel and the test exits with the skip code.

If either mount fails, then a normal error is returned as they do exist in
the kernel but something went wrong to mount them.

This changes the test to always try the tracefs file system first as it has
been in the kernel for some time now and it is better to test it if it is
available instead of always testing debugfs.

Link: http://lkml.kernel.org/r/20190702062358.7330-1-po-hsu.lin@canonical.com

Reported-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/ftrace/ftracetest | 38 +++++++++++++++++++----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 136387422b00..edf5ea35d2a7 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -23,9 +23,15 @@ echo "		            If <dir> is -, all logs output in console only"
 exit $1
 }
 
+# default error
+err_ret=1
+
+# kselftest skip code is 4
+err_skip=4
+
 errexit() { # message
   echo "Error: $1" 1>&2
-  exit 1
+  exit $err_ret
 }
 
 # Ensuring user privilege
@@ -116,11 +122,31 @@ parse_opts() { # opts
 }
 
 # Parameters
-DEBUGFS_DIR=`grep debugfs /proc/mounts | cut -f2 -d' ' | head -1`
-if [ -z "$DEBUGFS_DIR" ]; then
-    TRACING_DIR=`grep tracefs /proc/mounts | cut -f2 -d' ' | head -1`
-else
-    TRACING_DIR=$DEBUGFS_DIR/tracing
+TRACING_DIR=`grep tracefs /proc/mounts | cut -f2 -d' ' | head -1`
+if [ -z "$TRACING_DIR" ]; then
+    DEBUGFS_DIR=`grep debugfs /proc/mounts | cut -f2 -d' ' | head -1`
+    if [ -z "$DEBUGFS_DIR" ]; then
+	# If tracefs exists, then so does /sys/kernel/tracing
+	if [ -d "/sys/kernel/tracing" ]; then
+	    mount -t tracefs nodev /sys/kernel/tracing ||
+	      errexit "Failed to mount /sys/kernel/tracing"
+	    TRACING_DIR="/sys/kernel/tracing"
+	# If debugfs exists, then so does /sys/kernel/debug
+	elif [ -d "/sys/kernel/debug" ]; then
+	    mount -t debugfs nodev /sys/kernel/debug ||
+	      errexit "Failed to mount /sys/kernel/debug"
+	    TRACING_DIR="/sys/kernel/debug/tracing"
+	else
+	    err_ret=$err_skip
+	    errexit "debugfs and tracefs are not configured in this kernel"
+	fi
+    else
+	TRACING_DIR="$DEBUGFS_DIR/tracing"
+    fi
+fi
+if [ ! -d "$TRACING_DIR" ]; then
+    err_ret=$err_skip
+    errexit "ftrace is not configured in this kernel"
 fi
 
 TOP_DIR=`absdir $0`
-- 
2.20.1


