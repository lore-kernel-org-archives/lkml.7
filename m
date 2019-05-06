Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A032C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E4620830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEFOCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:60142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbfEFOCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:02:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0356121479;
        Mon,  6 May 2019 14:02:34 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hNeCP-0006zM-4l; Mon, 06 May 2019 10:02:33 -0400
Message-Id: <20190506140233.037857277@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 06 May 2019 10:02:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [for-next][PATCH 3/3] ktest: introduce REBOOT_RETURN_CODE to confirm the result of REBOOT
References: <20190506140206.573397982@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Unexpected power cycle occurs while the installation of the
kernel.

   ssh root@Test sync ... [0 seconds] SUCCESS
   ssh root@Test reboot ... [1 second] FAILED!
   virsh destroy Test; sleep 5; virsh start Test ... [6 seconds] SUCCESS

That is because REBOOT, the default is "ssh $SSH_USER@$MACHINE
reboot", exits as 255 even if the reboot is successfully done,
like as:

   ]# ssh root@Test reboot
   Connection to Test closed by remote host.
   ]# echo $?
   255
   ]#

To avoid the unexpected power cycle, introduce a new parameter,
REBOOT_RETURN_CODE to judge whether REBOOT is successfully done
or not.

Link: http://lkml.kernel.org/r/20190418135943.12640-1-msys.mizuma@gmail.com

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl    | 9 +++++++++
 tools/testing/ktest/sample.conf | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 3bec099a6cf4..275ad8ac8872 100755
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
@@ -1749,6 +1752,7 @@ sub run_command {
     my $dord = 0;
     my $dostdout = 0;
     my $pid;
+    my $command_orig = $command;
 
     $command =~ s/\$SSH_USER/$ssh_user/g;
     $command =~ s/\$MACHINE/$machine/g;
@@ -1803,6 +1807,11 @@ sub run_command {
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
-- 
2.20.1


