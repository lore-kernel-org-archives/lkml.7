Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D033C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D72B6205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO3AoZVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfEIRr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:47:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41092 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIRrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:47:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id g190so1987002qkf.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQe9Zkf+0yUTYC/ViEAV5j9gEyoYadU+fMjOcocTf+s=;
        b=hO3AoZVIHWLRtmQsKIPN8pSDew0rD4iWCSoPcfVS9voJVbW1Be1n0S8EQjCgbPk86p
         3yemyipPp1qt9vrFJMil9X6Pf7HR4hxyoeA9zv0XAEKL7MObkFRJ9ucjNw9/NGIxZqax
         qAwN229FMIfkID9u9/THqJOEssHAfaS0Wbc8dWGq84lVEGZq3ouDS5RjyiV5fHViWx2s
         6mcHBjC0KzuC6CugO2QPw8PNbdgapiznyEUF//lowvy5CK8FFn71JBOvMpntMEJIOejp
         6UloN3wZgtDLWjZzVXb3yOKLOO1rFeKzVDAvOMU4JHWCfQgM5wTAkc6uBmVKvlPfLhKl
         m/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQe9Zkf+0yUTYC/ViEAV5j9gEyoYadU+fMjOcocTf+s=;
        b=biAtDRujUhW58KeVMeGP5TybJVM3VGZmtNzOepw4aNg2Yb7CrMJffhZOE3BY7ox3V9
         qwnIQW0aLjLqkDFN1YLj3GI5mGd42oiqsvhPH7RXHyqvS1L55svA8KKgEvXLkdyWn0ZF
         pbHRdpLy+08aQuP7cXufNA4kyOgFRBPDRH5rOmmc2+fhdaVjrkJzbOKsTCOQSK2fR7dy
         e71AC5yV5iLoDEHiar6tP0CICMS3HD3II480/ypOzAXKv7QcDljD+KHTsuCFpRgSDsu5
         EXsOUROVpEez5V/mnU+RC+XNiTMSOMaUouPEf1wOLqUjKH1eJTtwnvBULckz+Nxyf8YE
         K/lA==
X-Gm-Message-State: APjAAAX3lruLYda/xAkUkWEpr4TnCJq7WHtrVwe+zk6irscYLOVpSf1d
        DSk+RXhPcPyTEcv+743Tig==
X-Google-Smtp-Source: APXvYqyiq550gIwP2D2u9mXWJ/wOk/QImo+XJYUAbr/uFPUQycBc/vwBUN3OW1vU1eCq0zbM2dfDYg==
X-Received: by 2002:a37:404b:: with SMTP id n72mr4610366qka.98.1557424043688;
        Thu, 09 May 2019 10:47:23 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z11sm1262953qki.95.2019.05.09.10.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:47:23 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] ktest: introduce grub2bls REBOOT_TYPE option
Date:   Thu,  9 May 2019 13:46:28 -0400
Message-Id: <20190509174630.26713-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509174630.26713-1-msys.mizuma@gmail.com>
References: <20190509174630.26713-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Fedora 30 introduces Boot Loader Specification (BLS),
it changes around grub entry configuration.

kernel entries aren't in grub.cfg. We can get the entries
by "grubby --info=ALL" command.

Introduce grub2bls as REBOOT_TYPE option for BLS.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 1255ea0d9df4..c910d7921f48 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -64,6 +64,7 @@ my %default = (
     "STOP_TEST_AFTER"		=> 600,
     "MAX_MONITOR_WAIT"		=> 1800,
     "GRUB_REBOOT"		=> "grub2-reboot",
+    "GRUB_BLS_GET"		=> "grubby --info=ALL",
     "SYSLINUX"			=> "extlinux",
     "SYSLINUX_PATH"		=> "/boot/extlinux",
     "CONNECT_TIMEOUT"		=> 25,
@@ -125,6 +126,7 @@ my $last_grub_menu;
 my $grub_file;
 my $grub_number;
 my $grub_reboot;
+my $grub_bls_get;
 my $syslinux;
 my $syslinux_path;
 my $syslinux_label;
@@ -295,6 +297,7 @@ my %option_map = (
     "GRUB_MENU"			=> \$grub_menu,
     "GRUB_FILE"			=> \$grub_file,
     "GRUB_REBOOT"		=> \$grub_reboot,
+    "GRUB_BLS_GET"		=> \$grub_bls_get,
     "SYSLINUX"			=> \$syslinux,
     "SYSLINUX_PATH"		=> \$syslinux_path,
     "SYSLINUX_LABEL"		=> \$syslinux_label,
@@ -440,7 +443,7 @@ EOF
     ;
 $config_help{"REBOOT_TYPE"} = << "EOF"
  Way to reboot the box to the test kernel.
- Only valid options so far are "grub", "grub2", "syslinux", and "script".
+ Only valid options so far are "grub", "grub2", "grub2bls", "syslinux", and "script".
 
  If you specify grub, it will assume grub version 1
  and will search in /boot/grub/menu.lst for the title \$GRUB_MENU
@@ -454,6 +457,8 @@ $config_help{"REBOOT_TYPE"} = << "EOF"
  If you specify grub2, then you also need to specify both \$GRUB_MENU
  and \$GRUB_FILE.
 
+ If you specify grub2bls, then you also need to specify \$GRUB_MENU.
+
  If you specify syslinux, then you may use SYSLINUX to define the syslinux
  command (defaults to extlinux), and SYSLINUX_PATH to specify the path to
  the syslinux install (defaults to /boot/extlinux). But you have to specify
@@ -479,6 +484,9 @@ $config_help{"GRUB_MENU"} = << "EOF"
  menu must be a non-nested menu. Add the quotes used in the menu
  to guarantee your selection, as the first menuentry with the content
  of \$GRUB_MENU that is found will be used.
+
+ For grub2bls, \$GRUB_MENU is searched on the result of \$GRUB_BLS_GET
+ command for the lines that begin with "title".
 EOF
     ;
 $config_help{"GRUB_FILE"} = << "EOF"
@@ -695,7 +703,7 @@ sub get_mandatory_configs {
 	}
     }
 
-    if ($rtype eq "grub") {
+    if (($rtype eq "grub") or ($rtype eq "grub2bls")) {
 	get_mandatory_config("GRUB_MENU");
     }
 
@@ -1939,7 +1947,8 @@ sub get_grub_index {
     my $skip;
     my $grub_menu_qt;
 
-    return if ($reboot_type ne "grub") and ($reboot_type ne "grub2");
+    return if ($reboot_type ne "grub") and ($reboot_type ne "grub2") and
+	($reboot_type ne "grub2bls");
 
     $grub_menu_qt = quotemeta($grub_menu);
 
@@ -1951,6 +1960,10 @@ sub get_grub_index {
 	$command = "cat $grub_file";
 	$target = '^menuentry.*' . $grub_menu_qt;
 	$skip = '^menuentry\s|^submenu\s';
+    } elsif ($reboot_type eq "grub2bls") {
+        $command = $grub_bls_get;
+        $target = '^title=.*' . $grub_menu_qt;
+        $skip = '^title=';
     }
 
     _get_grub_index($command, $target, $skip);
@@ -4306,7 +4319,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (!$buildonly) {
 	$target = "$ssh_user\@$machine";
-	if ($reboot_type eq "grub") {
+	if (($reboot_type eq "grub") or ($reboot_type eq "grub2bls")) {
 	    dodie "GRUB_MENU not defined" if (!defined($grub_menu));
 	} elsif ($reboot_type eq "grub2") {
 	    dodie "GRUB_MENU not defined" if (!defined($grub_menu));
-- 
2.20.1

