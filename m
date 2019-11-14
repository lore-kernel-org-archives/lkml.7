Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26E1C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874B920727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfKNSSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727534AbfKNSSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B666C20801;
        Thu, 14 Nov 2019 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhH-0000zH-VG; Thu, 14 Nov 2019 13:18:23 -0500
Message-Id: <20191114181823.850815518@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [for-next][PATCH 03/33] selftests/livepatch: Test interaction with ftrace_enabled
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Lawrence <joe.lawrence@redhat.com>

Since livepatching depends upon ftrace handlers to implement "patched"
code functionality, verify that the ftrace_enabled sysctl value
interacts with livepatch registration as expected.  At the same time,
ensure that ftrace_enabled is set and part of the test environment
configuration that is saved and restored when running the selftests.

Link: http://lkml.kernel.org/r/20191016113316.13415-4-mbenes@suse.cz

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/selftests/livepatch/Makefile    |  3 +-
 .../testing/selftests/livepatch/functions.sh  | 14 +++-
 .../selftests/livepatch/test-ftrace.sh        | 65 +++++++++++++++++++
 3 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/livepatch/test-ftrace.sh

diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
index fd405402c3ff..1886d9d94b88 100644
--- a/tools/testing/selftests/livepatch/Makefile
+++ b/tools/testing/selftests/livepatch/Makefile
@@ -4,6 +4,7 @@ TEST_PROGS_EXTENDED := functions.sh
 TEST_PROGS := \
 	test-livepatch.sh \
 	test-callbacks.sh \
-	test-shadow-vars.sh
+	test-shadow-vars.sh \
+	test-ftrace.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index b7e5a67ae434..31eb09e38729 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -32,12 +32,16 @@ function die() {
 function push_config() {
 	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
+	FTRACE_ENABLED=$(sysctl --values kernel.ftrace_enabled)
 }
 
 function pop_config() {
 	if [[ -n "$DYNAMIC_DEBUG" ]]; then
 		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
 	fi
+	if [[ -n "$FTRACE_ENABLED" ]]; then
+		sysctl kernel.ftrace_enabled="$FTRACE_ENABLED" &> /dev/null
+	fi
 }
 
 function set_dynamic_debug() {
@@ -47,12 +51,20 @@ function set_dynamic_debug() {
 		EOF
 }
 
+function set_ftrace_enabled() {
+	local sysctl="$1"
+	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
+	echo "livepatch: $result" > /dev/kmsg
+}
+
 # setup_config - save the current config and set a script exit trap that
 #		 restores the original config.  Setup the dynamic debug
-#		 for verbose livepatching output.
+#		 for verbose livepatching output and turn on
+#		 the ftrace_enabled sysctl.
 function setup_config() {
 	push_config
 	set_dynamic_debug
+	set_ftrace_enabled 1
 	trap pop_config EXIT INT TERM HUP
 }
 
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
new file mode 100755
index 000000000000..e2a76887f40a
--- /dev/null
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -0,0 +1,65 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2019 Joe Lawrence <joe.lawrence@redhat.com>
+
+. $(dirname $0)/functions.sh
+
+MOD_LIVEPATCH=test_klp_livepatch
+
+setup_config
+
+
+# TEST: livepatch interaction with ftrace_enabled sysctl
+# - turn ftrace_enabled OFF and verify livepatches can't load
+# - turn ftrace_enabled ON and verify livepatch can load
+# - verify that ftrace_enabled can't be turned OFF while a livepatch is loaded
+
+echo -n "TEST: livepatch interaction with ftrace_enabled sysctl ... "
+dmesg -C
+
+set_ftrace_enabled 0
+load_failing_mod $MOD_LIVEPATCH
+
+set_ftrace_enabled 1
+load_lp $MOD_LIVEPATCH
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+
+set_ftrace_enabled 0
+if [[ "$(cat /proc/cmdline)" != "$MOD_LIVEPATCH: this has been live patched" ]] ; then
+	echo -e "FAIL\n\n"
+	die "livepatch kselftest(s) failed"
+fi
+disable_lp $MOD_LIVEPATCH
+unload_lp $MOD_LIVEPATCH
+
+check_result "livepatch: kernel.ftrace_enabled = 0
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
+livepatch: failed to patch object 'vmlinux'
+livepatch: failed to enable patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+modprobe: ERROR: could not insert '$MOD_LIVEPATCH': Device or resource busy
+livepatch: kernel.ftrace_enabled = 1
+% modprobe $MOD_LIVEPATCH
+livepatch: enabling patch '$MOD_LIVEPATCH'
+livepatch: '$MOD_LIVEPATCH': initializing patching transition
+livepatch: '$MOD_LIVEPATCH': starting patching transition
+livepatch: '$MOD_LIVEPATCH': completing patching transition
+livepatch: '$MOD_LIVEPATCH': patching complete
+livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
+% echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
+livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
+livepatch: '$MOD_LIVEPATCH': starting unpatching transition
+livepatch: '$MOD_LIVEPATCH': completing unpatching transition
+livepatch: '$MOD_LIVEPATCH': unpatching complete
+% rmmod $MOD_LIVEPATCH"
+
+
+exit 0
-- 
2.23.0


