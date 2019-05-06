Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283CDC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F442082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfEFRik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:43224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfEFRik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:38:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C11E92082F;
        Mon,  6 May 2019 17:38:38 +0000 (UTC)
Date:   Mon, 6 May 2019 13:38:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [GIT PULL] ktest: Updates for 5.2
Message-ID: <20190506133837.55832171@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Minor updates to ktest.pl

 - Handle meta characters in grub memu
 - Use configurable reboot return code for handling ssh reboots
 - Display names and iteration number on error message


Please pull the latest ktest-v5.1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.1

Tag SHA1: 32cb828776e96e89268929a200aee24ea9a11a9e
Head SHA1: 37e1677330bdc2e96e70f18701e589876f054c67


Masayoshi Mizuma (2):
      ktest: Add support for meta characters in GRUB_MENU
      ktest: introduce REBOOT_RETURN_CODE to confirm the result of REBOOT

Steven Rostedt (VMware) (1):
      ktest: Show name and iteration on errors

----
 tools/testing/ktest/ktest.pl    | 41 +++++++++++++++++++++++++++++++++--------
 tools/testing/ktest/sample.conf |  4 ++++
 2 files changed, 37 insertions(+), 8 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 87af8a68ab25..275ad8ac8872 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -58,6 +58,7 @@ my %default = (
     "SCP_TO_TARGET"		=> "scp \$SRC_FILE \$SSH_USER\@\$MACHINE:\$DST_FILE",
     "SCP_TO_TARGET_INSTALL"	=> "\${SCP_TO_TARGET}",
     "REBOOT"			=> "ssh \$SSH_USER\@\$MACHINE reboot",
+    "REBOOT_RETURN_CODE"	=> 255,
     "STOP_AFTER_SUCCESS"	=> 10,
     "STOP_AFTER_FAILURE"	=> 60,
     "STOP_TEST_AFTER"		=> 600,
@@ -105,6 +106,7 @@ my $reboot_type;
 my $reboot_script;
 my $power_cycle;
 my $reboot;
+my $reboot_return_code;
 my $reboot_on_error;
 my $switch_to_good;
 my $switch_to_test;
@@ -278,6 +280,7 @@ my %option_map = (
     "POST_BUILD_DIE"		=> \$post_build_die,
     "POWER_CYCLE"		=> \$power_cycle,
     "REBOOT"			=> \$reboot,
+    "REBOOT_RETURN_CODE"	=> \$reboot_return_code,
     "BUILD_NOCLEAN"		=> \$noclean,
     "MIN_CONFIG"		=> \$minconfig,
     "OUTPUT_MIN_CONFIG"		=> \$output_minconfig,
@@ -1437,16 +1440,27 @@ sub do_not_reboot {
 
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
@@ -1462,7 +1476,8 @@ sub dodie {
     }
 
     if ($email_on_error) {
-        send_email("KTEST: critical failure for your [$test_type] test",
+	my $name = get_test_name;
+        send_email("KTEST: critical failure for test $i [$name]",
                 "Your test started at $script_start_time has failed with:\n@_\n");
     }
 
@@ -1737,6 +1752,7 @@ sub run_command {
     my $dord = 0;
     my $dostdout = 0;
     my $pid;
+    my $command_orig = $command;
 
     $command =~ s/\$SSH_USER/$ssh_user/g;
     $command =~ s/\$MACHINE/$machine/g;
@@ -1791,6 +1807,11 @@ sub run_command {
     # shift 8 for real exit status
     $run_command_status = $? >> 8;
 
+    if ($command_orig eq $default{REBOOT} &&
+	$run_command_status == $reboot_return_code) {
+	$run_command_status = 0;
+    }
+
     close(CMD);
     close(LOG) if ($dolog);
     close(RD)  if ($dord);
@@ -1866,9 +1887,10 @@ sub get_grub2_index {
 	or dodie "unable to get $grub_file";
 
     my $found = 0;
+    my $grub_menu_qt = quotemeta($grub_menu);
 
     while (<IN>) {
-	if (/^menuentry.*$grub_menu/) {
+	if (/^menuentry.*$grub_menu_qt/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
@@ -1909,9 +1931,10 @@ sub get_grub_index {
 	or dodie "unable to get menu.lst";
 
     my $found = 0;
+    my $grub_menu_qt = quotemeta($grub_menu);
 
     while (<IN>) {
-	if (/^\s*title\s+$grub_menu\s*$/) {
+	if (/^\s*title\s+$grub_menu_qt\s*$/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
@@ -4193,7 +4216,8 @@ sub send_email {
 
 sub cancel_test {
     if ($email_when_canceled) {
-        send_email("KTEST: Your [$test_type] test was cancelled",
+	my $name = get_test_name;
+        send_email("KTEST: Your [$name] test was cancelled",
                 "Your test started at $script_start_time was cancelled: sig int");
     }
     die "\nCaught Sig Int, test interrupted: $!\n"
@@ -4247,7 +4271,8 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
             run_command $pre_ktest;
         }
         if ($email_when_started) {
-            send_email("KTEST: Your [$test_type] test was started",
+	    my $name = get_test_name;
+            send_email("KTEST: Your [$name] test was started",
                 "Your test was started on $script_start_time");
         }
     }
@@ -4414,7 +4439,7 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
-    send_email("KTEST: Your [$test_type] test has finished!",
+    send_email("KTEST: Your test has finished!",
             "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
 }
 exit 0;
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 6ca6ca0ce695..8c893a58b68e 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -887,6 +887,10 @@
 # The variables SSH_USER and MACHINE are defined.
 #REBOOT = ssh $SSH_USER@$MACHINE reboot
 
+# The return code of REBOOT
+# (default 255)
+#REBOOT_RETURN_CODE = 255
+
 # The way triple faults are detected is by testing the kernel
 # banner. If the kernel banner for the kernel we are testing is
 # found, and then later a kernel banner for another kernel version
