Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF30DC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902A320871
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 18:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfKNSS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 13:18:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbfKNSSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 13:18:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9704B20725;
        Thu, 14 Nov 2019 18:18:24 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92.2)
        (envelope-from <rostedt@goodmis.org>)
        id 1iVJhH-0000yn-Qh; Thu, 14 Nov 2019 13:18:23 -0500
Message-Id: <20191114181823.706316988@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 14 Nov 2019 13:17:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [for-next][PATCH 02/33] selftests/livepatch: Make dynamic debug setup and restore generic
References: <20191114181734.067922168@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Lawrence <joe.lawrence@redhat.com>

Livepatch selftests currently save the current dynamic debug config and
tweak it for the selftests. The config is restored at the end. Make the
infrastructure generic, so that more variables can be saved and
restored.

Link: http://lkml.kernel.org/r/20191016113316.13415-3-mbenes@suse.cz

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../testing/selftests/livepatch/functions.sh  | 22 +++++++++++--------
 .../selftests/livepatch/test-callbacks.sh     |  2 +-
 .../selftests/livepatch/test-livepatch.sh     |  2 +-
 .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 79b0affd21fb..b7e5a67ae434 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -29,29 +29,33 @@ function die() {
 	exit 1
 }
 
-function push_dynamic_debug() {
-        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
-                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
+function push_config() {
+	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
+			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
 }
 
-function pop_dynamic_debug() {
+function pop_config() {
 	if [[ -n "$DYNAMIC_DEBUG" ]]; then
 		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
 	fi
 }
 
-# set_dynamic_debug() - save the current dynamic debug config and tweak
-# 			it for the self-tests.  Set a script exit trap
-#			that restores the original config.
 function set_dynamic_debug() {
-        push_dynamic_debug
-        trap pop_dynamic_debug EXIT INT TERM HUP
         cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
 		file kernel/livepatch/* +p
 		func klp_try_switch_task -p
 		EOF
 }
 
+# setup_config - save the current config and set a script exit trap that
+#		 restores the original config.  Setup the dynamic debug
+#		 for verbose livepatching output.
+function setup_config() {
+	push_config
+	set_dynamic_debug
+	trap pop_config EXIT INT TERM HUP
+}
+
 # loop_until(cmd) - loop a command until it is successful or $MAX_RETRIES,
 #		    sleep $RETRY_INTERVAL between attempts
 #	cmd - command and its arguments to run
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index e97a9dcb73c7..a35289b13c9c 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -9,7 +9,7 @@ MOD_LIVEPATCH2=test_klp_callbacks_demo2
 MOD_TARGET=test_klp_callbacks_mod
 MOD_TARGET_BUSY=test_klp_callbacks_busy
 
-set_dynamic_debug
+setup_config
 
 
 # TEST: target module before livepatch
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index f05268aea859..493e3df415a1 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -7,7 +7,7 @@
 MOD_LIVEPATCH=test_klp_livepatch
 MOD_REPLACE=test_klp_atomic_replace
 
-set_dynamic_debug
+setup_config
 
 
 # TEST: basic function patching
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
index 04a37831e204..1aae73299114 100755
--- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -6,7 +6,7 @@
 
 MOD_TEST=test_klp_shadow_vars
 
-set_dynamic_debug
+setup_config
 
 
 # TEST: basic shadow variable API
-- 
2.23.0


