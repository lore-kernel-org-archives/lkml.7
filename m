Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F44C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F4E214AF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfEFOCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726145AbfEFOCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:02:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF5A206BF;
        Mon,  6 May 2019 14:02:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hNeCO-0006yN-RJ; Mon, 06 May 2019 10:02:32 -0400
Message-Id: <20190506140232.735699092@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 06 May 2019 10:02:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 1/3] ktest: Show name and iteration on errors
References: <20190506140206.573397982@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a test has an error, display not only the what type of test failed, but
if the test was giving a name, display that too, as well as the current
iteration of the tests. Each test has an iteration number associated to it.
For error messages display that iteration number along with the test type
and test name. This includes the message that gets sent via email.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 87af8a68ab25..75f8cecdd549 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1437,16 +1437,27 @@ sub do_not_reboot {
 
 my $in_die = 0;
 
+sub get_test_name() {
+    my $name;
+
+    if (defined($test_name)) {
+	$name = "$test_name:$test_type";
+    } else {
+	$name = $test_type;
+    }
+    return $name;
+}
+
 sub dodie {
 
     # avoid recusion
     return if ($in_die);
     $in_die = 1;
 
-    doprint "CRITICAL FAILURE... ", @_, "\n";
-
     my $i = $iteration;
 
+    doprint "CRITICAL FAILURE... [TEST $i] ", @_, "\n";
+
     if ($reboot_on_error && !do_not_reboot) {
 
 	doprint "REBOOTING\n";
@@ -1462,7 +1473,8 @@ sub dodie {
     }
 
     if ($email_on_error) {
-        send_email("KTEST: critical failure for your [$test_type] test",
+	my $name = get_test_name;
+        send_email("KTEST: critical failure for test $i [$name]",
                 "Your test started at $script_start_time has failed with:\n@_\n");
     }
 
@@ -4193,7 +4205,8 @@ sub send_email {
 
 sub cancel_test {
     if ($email_when_canceled) {
-        send_email("KTEST: Your [$test_type] test was cancelled",
+	my $name = get_test_name;
+        send_email("KTEST: Your [$name] test was cancelled",
                 "Your test started at $script_start_time was cancelled: sig int");
     }
     die "\nCaught Sig Int, test interrupted: $!\n"
@@ -4247,7 +4260,8 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
             run_command $pre_ktest;
         }
         if ($email_when_started) {
-            send_email("KTEST: Your [$test_type] test was started",
+	    my $name = get_test_name;
+            send_email("KTEST: Your [$name] test was started",
                 "Your test was started on $script_start_time");
         }
     }
@@ -4414,7 +4428,7 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
-    send_email("KTEST: Your [$test_type] test has finished!",
+    send_email("KTEST: Your test has finished!",
             "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
 }
 exit 0;
-- 
2.20.1


