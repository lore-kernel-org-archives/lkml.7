Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AEAC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01B3217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Am/DuWnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389203AbfDROAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:00:39 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36323 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDROAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:00:39 -0400
Received: by mail-qk1-f195.google.com with SMTP id s83so1198801qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fU33i2t0JsbXbTrgFcHGxGxjaSIcKOBtCPoE/HmqfNs=;
        b=Am/DuWnRjzrUqI6+QfqM/uha/AEU1TjxWtdRleJWPQGRMUMHsPtT5ZLgIz3uSn7syp
         rD+2SG1qWR4iqoAxXFk0OQGGLgoHPW6r7tkRwGmS20q0037cnF1l/e7vw/iw3UBjT0n7
         m1trbtrtW8k3cK/tW+0IPOnVUkxnJfycGVqKTKg3HDohMzrSZ4tXZv0PUJoF71XiE6oc
         ZTXlsqwFnybQzU+4k+qhVnQ95w1TKq9FWR0KEN3AzuXdxhIN/VKHjuO9f5clVSe0R3ei
         i6qAcaSAOxPXwj6xm9h2ogfzsNUR/FuhVQud8/sYwmD5eMFMYEAHmDtIoc1jZDOKDWl5
         C40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fU33i2t0JsbXbTrgFcHGxGxjaSIcKOBtCPoE/HmqfNs=;
        b=IlxsK59vDgMWBLGoTtluuBb8/yPYosy+ihHMJqwmcxo09EwaX7wYukvlihrhtOzjNV
         ZPjluuDhZ6+9t2lTuvbPfw/d/v5/g7+udX4NVS47DQ1lgRMljC76jcOgD3eEfaR1X4w8
         +B80NTt+fQ9CzmvOaizXbAzbADWz3D7K+Vz5VV39fwpAWXn/Zp88BG2wTfX0arstzlvX
         Vrl0/OJAjVHh21gvLPKpv7NwqIdEo/yMnU1Xqfdr9DBSd5v6LgXAXLhuFydDJ45etN2W
         uJY4wbQ5NlR6MtSfvFJQe4kg7OwdvNo6ZvcoinRCFlkopioOaHCuMagCTY97qSsXV+3F
         DsCw==
X-Gm-Message-State: APjAAAV7tdaVG5NtmiCcrnJPdjIhSEebmZQG73bpsmRXpInKa9+cnKGH
        U/fmUVk78MJ5glGvWOdbGA==
X-Google-Smtp-Source: APXvYqwvOFpWOMBpV+AlC8X6HVE5dJth9w/PCsZ7kpa1TSxSFaRP73K5uL5UQs65kp49nM1r+1uSPw==
X-Received: by 2002:a37:a02:: with SMTP id 2mr29034870qkk.258.1555596038368;
        Thu, 18 Apr 2019 07:00:38 -0700 (PDT)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id b24sm980332qtr.51.2019.04.18.07.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 07:00:37 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ktest: introduce REBOOT_RETURN_CODE to confirm the result of REBOOT
Date:   Thu, 18 Apr 2019 09:59:43 -0400
Message-Id: <20190418135943.12640-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
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

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl    | 9 +++++++++
 tools/testing/ktest/sample.conf | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index fc6140d45280..751e32a31ed4 100755
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
@@ -1737,6 +1740,7 @@ sub run_command {
     my $dord = 0;
     my $dostdout = 0;
     my $pid;
+    my $command_orig = $command;
 
     $command =~ s/\$SSH_USER/$ssh_user/g;
     $command =~ s/\$MACHINE/$machine/g;
@@ -1791,6 +1795,11 @@ sub run_command {
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

