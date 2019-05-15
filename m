Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EB3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771602084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfEOR4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbfEOR4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:56:04 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF8172084E;
        Wed, 15 May 2019 17:56:02 +0000 (UTC)
Date:   Wed, 15 May 2019 13:56:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [GIT PULL] ktest: Updates for 5.2
Message-ID: <20190515135602.2a6e6012@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Updates to ktest.pl

 - Handle meta data in GRUB_MENU

 - Add variable to cusomize what return value the reboot code should return.

 - Add support for grub2bls boot loader

 - Show name and test iteration number in error message sent in mail

 - Minor fixes and clean ups


Please pull the latest ktest-v5.2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.2

Tag SHA1: dc82a4cd3af167da18747d7029afdb81c11e5fe9
Head SHA1: d20f6b41b7c2715b3d900f2da02029dbc14cd60a


Masayoshi Mizuma (8):
      ktest: Add support for meta characters in GRUB_MENU
      ktest: introduce REBOOT_RETURN_CODE to confirm the result of REBOOT
      ktest: introduce _get_grub_index
      ktest: cleanup get_grub_index
      ktest: introduce grub2bls REBOOT_TYPE option
      ktest: pass KERNEL_VERSION to POST_KTEST
      ktest: remove get_grub2_index
      ktest: update sample.conf for grub2bls

Steven Rostedt (VMware) (1):
      ktest: Show name and iteration on errors

----
 tools/testing/ktest/ktest.pl    | 122 ++++++++++++++++++++++++----------------
 tools/testing/ktest/sample.conf |  24 +++++++-
 2 files changed, 95 insertions(+), 51 deletions(-)
---------------------------
diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 87af8a68ab25..4711f57e809a 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -58,11 +58,13 @@ my %default = (
     "SCP_TO_TARGET"		=> "scp \$SRC_FILE \$SSH_USER\@\$MACHINE:\$DST_FILE",
     "SCP_TO_TARGET_INSTALL"	=> "\${SCP_TO_TARGET}",
     "REBOOT"			=> "ssh \$SSH_USER\@\$MACHINE reboot",
+    "REBOOT_RETURN_CODE"	=> 255,
     "STOP_AFTER_SUCCESS"	=> 10,
     "STOP_AFTER_FAILURE"	=> 60,
     "STOP_TEST_AFTER"		=> 600,
     "MAX_MONITOR_WAIT"		=> 1800,
     "GRUB_REBOOT"		=> "grub2-reboot",
+    "GRUB_BLS_GET"		=> "grubby --info=ALL",
     "SYSLINUX"			=> "extlinux",
     "SYSLINUX_PATH"		=> "/boot/extlinux",
     "CONNECT_TIMEOUT"		=> 25,
@@ -105,6 +107,7 @@ my $reboot_type;
 my $reboot_script;
 my $power_cycle;
 my $reboot;
+my $reboot_return_code;
 my $reboot_on_error;
 my $switch_to_good;
 my $switch_to_test;
@@ -123,6 +126,7 @@ my $last_grub_menu;
 my $grub_file;
 my $grub_number;
 my $grub_reboot;
+my $grub_bls_get;
 my $syslinux;
 my $syslinux_path;
 my $syslinux_label;
@@ -278,6 +282,7 @@ my %option_map = (
     "POST_BUILD_DIE"		=> \$post_build_die,
     "POWER_CYCLE"		=> \$power_cycle,
     "REBOOT"			=> \$reboot,
+    "REBOOT_RETURN_CODE"	=> \$reboot_return_code,
     "BUILD_NOCLEAN"		=> \$noclean,
     "MIN_CONFIG"		=> \$minconfig,
     "OUTPUT_MIN_CONFIG"		=> \$output_minconfig,
@@ -292,6 +297,7 @@ my %option_map = (
     "GRUB_MENU"			=> \$grub_menu,
     "GRUB_FILE"			=> \$grub_file,
     "GRUB_REBOOT"		=> \$grub_reboot,
+    "GRUB_BLS_GET"		=> \$grub_bls_get,
     "SYSLINUX"			=> \$syslinux,
     "SYSLINUX_PATH"		=> \$syslinux_path,
     "SYSLINUX_LABEL"		=> \$syslinux_label,
@@ -437,7 +443,7 @@ EOF
     ;
 $config_help{"REBOOT_TYPE"} = << "EOF"
  Way to reboot the box to the test kernel.
- Only valid options so far are "grub", "grub2", "syslinux", and "script".
+ Only valid options so far are "grub", "grub2", "grub2bls", "syslinux", and "script".
 
  If you specify grub, it will assume grub version 1
  and will search in /boot/grub/menu.lst for the title \$GRUB_MENU
@@ -451,6 +457,8 @@ $config_help{"REBOOT_TYPE"} = << "EOF"
  If you specify grub2, then you also need to specify both \$GRUB_MENU
  and \$GRUB_FILE.
 
+ If you specify grub2bls, then you also need to specify \$GRUB_MENU.
+
  If you specify syslinux, then you may use SYSLINUX to define the syslinux
  command (defaults to extlinux), and SYSLINUX_PATH to specify the path to
  the syslinux install (defaults to /boot/extlinux). But you have to specify
@@ -476,6 +484,9 @@ $config_help{"GRUB_MENU"} = << "EOF"
  menu must be a non-nested menu. Add the quotes used in the menu
  to guarantee your selection, as the first menuentry with the content
  of \$GRUB_MENU that is found will be used.
+
+ For grub2bls, \$GRUB_MENU is searched on the result of \$GRUB_BLS_GET
+ command for the lines that begin with "title".
 EOF
     ;
 $config_help{"GRUB_FILE"} = << "EOF"
@@ -692,7 +703,7 @@ sub get_mandatory_configs {
 	}
     }
 
-    if ($rtype eq "grub") {
+    if (($rtype eq "grub") or ($rtype eq "grub2bls")) {
 	get_mandatory_config("GRUB_MENU");
     }
 
@@ -1437,16 +1448,27 @@ sub do_not_reboot {
 
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
@@ -1462,7 +1484,8 @@ sub dodie {
     }
 
     if ($email_on_error) {
-        send_email("KTEST: critical failure for your [$test_type] test",
+	my $name = get_test_name;
+        send_email("KTEST: critical failure for test $i [$name]",
                 "Your test started at $script_start_time has failed with:\n@_\n");
     }
 
@@ -1737,6 +1760,7 @@ sub run_command {
     my $dord = 0;
     my $dostdout = 0;
     my $pid;
+    my $command_orig = $command;
 
     $command =~ s/\$SSH_USER/$ssh_user/g;
     $command =~ s/\$MACHINE/$machine/g;
@@ -1791,6 +1815,11 @@ sub run_command {
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
@@ -1850,35 +1879,37 @@ sub run_scp_mod {
     return run_scp($src, $dst, $cp_scp);
 }
 
-sub get_grub2_index {
+sub _get_grub_index {
+
+    my ($command, $target, $skip) = @_;
 
     return if (defined($grub_number) && defined($last_grub_menu) &&
 	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
 	       $last_machine eq $machine);
 
-    doprint "Find grub2 menu ... ";
+    doprint "Find $reboot_type menu ... ";
     $grub_number = -1;
 
     my $ssh_grub = $ssh_exec;
-    $ssh_grub =~ s,\$SSH_COMMAND,cat $grub_file,g;
+    $ssh_grub =~ s,\$SSH_COMMAND,$command,g;
 
     open(IN, "$ssh_grub |")
-	or dodie "unable to get $grub_file";
+	or dodie "unable to execute $command";
 
     my $found = 0;
 
     while (<IN>) {
-	if (/^menuentry.*$grub_menu/) {
+	if (/$target/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
-	} elsif (/^menuentry\s|^submenu\s/) {
+	} elsif (/$skip/) {
 	    $grub_number++;
 	}
     }
     close(IN);
 
-    dodie "Could not find '$grub_menu' in $grub_file on $machine"
+    dodie "Could not find '$grub_menu' through $command on $machine"
 	if (!$found);
     doprint "$grub_number\n";
     $last_grub_menu = $grub_menu;
@@ -1887,45 +1918,34 @@ sub get_grub2_index {
 
 sub get_grub_index {
 
-    if ($reboot_type eq "grub2") {
-	get_grub2_index;
-	return;
-    }
+    my $command;
+    my $target;
+    my $skip;
+    my $grub_menu_qt;
 
-    if ($reboot_type ne "grub") {
+    if ($reboot_type !~ /^grub/) {
 	return;
     }
-    return if (defined($grub_number) && defined($last_grub_menu) &&
-	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
-	       $last_machine eq $machine);
 
-    doprint "Find grub menu ... ";
-    $grub_number = -1;
-
-    my $ssh_grub = $ssh_exec;
-    $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;
+    $grub_menu_qt = quotemeta($grub_menu);
 
-    open(IN, "$ssh_grub |")
-	or dodie "unable to get menu.lst";
-
-    my $found = 0;
-
-    while (<IN>) {
-	if (/^\s*title\s+$grub_menu\s*$/) {
-	    $grub_number++;
-	    $found = 1;
-	    last;
-	} elsif (/^\s*title\s/) {
-	    $grub_number++;
-	}
+    if ($reboot_type eq "grub") {
+	$command = "cat /boot/grub/menu.lst";
+	$target = '^\s*title\s+' . $grub_menu_qt . '\s*$';
+	$skip = '^\s*title\s';
+    } elsif ($reboot_type eq "grub2") {
+	$command = "cat $grub_file";
+	$target = '^menuentry.*' . $grub_menu_qt;
+	$skip = '^menuentry\s|^submenu\s';
+    } elsif ($reboot_type eq "grub2bls") {
+        $command = $grub_bls_get;
+        $target = '^title=.*' . $grub_menu_qt;
+        $skip = '^title=';
+    } else {
+	return;
     }
-    close(IN);
 
-    dodie "Could not find '$grub_menu' in /boot/grub/menu on $machine"
-	if (!$found);
-    doprint "$grub_number\n";
-    $last_grub_menu = $grub_menu;
-    $last_machine = $machine;
+    _get_grub_index($command, $target, $skip);
 }
 
 sub wait_for_input
@@ -4193,7 +4213,8 @@ sub send_email {
 
 sub cancel_test {
     if ($email_when_canceled) {
-        send_email("KTEST: Your [$test_type] test was cancelled",
+	my $name = get_test_name;
+        send_email("KTEST: Your [$name] test was cancelled",
                 "Your test started at $script_start_time was cancelled: sig int");
     }
     die "\nCaught Sig Int, test interrupted: $!\n"
@@ -4247,7 +4268,8 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
             run_command $pre_ktest;
         }
         if ($email_when_started) {
-            send_email("KTEST: Your [$test_type] test was started",
+	    my $name = get_test_name;
+            send_email("KTEST: Your [$name] test was started",
                 "Your test was started on $script_start_time");
         }
     }
@@ -4278,7 +4300,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (!$buildonly) {
 	$target = "$ssh_user\@$machine";
-	if ($reboot_type eq "grub") {
+	if (($reboot_type eq "grub") or ($reboot_type eq "grub2bls")) {
 	    dodie "GRUB_MENU not defined" if (!defined($grub_menu));
 	} elsif ($reboot_type eq "grub2") {
 	    dodie "GRUB_MENU not defined" if (!defined($grub_menu));
@@ -4398,7 +4420,9 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 }
 
 if (defined($final_post_ktest)) {
-    run_command $final_post_ktest;
+
+    my $cp_final_post_ktest = eval_kernel_version $final_post_ktest;
+    run_command $cp_final_post_ktest;
 }
 
 if ($opt{"POWEROFF_ON_SUCCESS"}) {
@@ -4414,7 +4438,7 @@ if ($opt{"POWEROFF_ON_SUCCESS"}) {
 doprint "\n    $successes of $opt{NUM_TESTS} tests were successful\n\n";
 
 if ($email_when_finished) {
-    send_email("KTEST: Your [$test_type] test has finished!",
+    send_email("KTEST: Your test has finished!",
             "$successes of $opt{NUM_TESTS} tests started at $script_start_time were successful!");
 }
 exit 0;
diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 6ca6ca0ce695..c3bc933d437b 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -349,13 +349,13 @@
 # option to boot to with GRUB_REBOOT
 #GRUB_FILE = /boot/grub2/grub.cfg
 
-# The tool for REBOOT_TYPE = grub2 to set the next reboot kernel
+# The tool for REBOOT_TYPE = grub2 or grub2bls to set the next reboot kernel
 # to boot into (one shot mode).
 # (default grub2_reboot)
 #GRUB_REBOOT = grub2_reboot
 
 # The grub title name for the test kernel to boot
-# (Only mandatory if REBOOT_TYPE = grub or grub2)
+# (Only mandatory if REBOOT_TYPE = grub or grub2 or grub2bls)
 #
 # Note, ktest.pl will not update the grub menu.lst, you need to
 # manually add an option for the test. ktest.pl will search
@@ -374,6 +374,10 @@
 # do a: GRUB_MENU = 'Test Kernel'
 # For customizing, add your entry in /etc/grub.d/40_custom.
 #
+# For grub2bls, a search of "title"s are done. The menu is found
+# by searching for the contents of GRUB_MENU in the line that starts
+# with "title".
+#
 #GRUB_MENU = Test Kernel
 
 # For REBOOT_TYPE = syslinux, the name of the syslinux executable
@@ -479,6 +483,11 @@
 # default (undefined)
 #POST_KTEST = ${SSH} ~/dismantle_test
 
+# If you want to remove the kernel entry in Boot Loader Specification (BLS)
+# environment, use kernel-install command.
+# Here's the example:
+#POST_KTEST = ssh root@Test "/usr/bin/kernel-install remove $KERNEL_VERSION"
+
 # The default test type (default test)
 # The test types may be:
 #   build   - only build the kernel, do nothing else
@@ -530,6 +539,11 @@
 # or on some systems:
 #POST_INSTALL = ssh user@target /sbin/dracut -f /boot/initramfs-test.img $KERNEL_VERSION
 
+# If you want to add the kernel entry in Boot Loader Specification (BLS)
+# environment, use kernel-install command.
+# Here's the example:
+#POST_INSTALL = ssh root@Test "/usr/bin/kernel-install add $KERNEL_VERSION /boot/vmlinuz-$KERNEL_VERSION"
+
 # If for some reason you just want to boot the kernel and you do not
 # want the test to install anything new. For example, you may just want
 # to boot test the same kernel over and over and do not want to go through
@@ -593,6 +607,8 @@
 # For REBOOT_TYPE = grub2, you must define both GRUB_MENU and
 # GRUB_FILE.
 #
+# For REBOOT_TYPE = grub2bls, you must define GRUB_MENU.
+#
 # For REBOOT_TYPE = syslinux, you must define SYSLINUX_LABEL, and
 # perhaps modify SYSLINUX (default extlinux) and SYSLINUX_PATH
 # (default /boot/extlinux)
@@ -887,6 +903,10 @@
 # The variables SSH_USER and MACHINE are defined.
 #REBOOT = ssh $SSH_USER@$MACHINE reboot
 
+# The return code of REBOOT
+# (default 255)
+#REBOOT_RETURN_CODE = 255
+
 # The way triple faults are detected is by testing the kernel
 # banner. If the kernel banner for the kernel we are testing is
 # found, and then later a kernel banner for another kernel version
