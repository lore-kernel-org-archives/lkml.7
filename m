Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA0EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E96D2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyqu6ddU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEIVhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:37:21 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34124 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfEIVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:37:20 -0400
Received: by mail-qk1-f196.google.com with SMTP id n68so2467692qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8zQ0gjjO56euSFEObPWmsvfCTOikaJBtrG7VqVmrbEA=;
        b=qyqu6ddUoaH6iUCLVGk97KmMO9HJx61UZT/MfIzzTWR9hYY5vSHsCHVbOdX3RpO9T3
         407flqe5QhFPkX2tmJxEjraU0dqKlgyAwXWGeLZV3D6lye7NP+YfXwDy8Zh42DI79OQ4
         +9QccnfNXIXoPfk0oANdCpJSGMmXq+YV4r+yxXONgXI5mZkuzv8GyI5tmLj0R07lnElH
         uj6HrOxsp/OsbpY3jDJ0HM6Wg0s3m9mZ8az6eNXLc5OIG6e/jRX0rIGe8ZFbleVm50FX
         FWmQ+A3yzWCad8p9RCNkchOtdJYf8rbSUsq2Gtky4AUMgGzZGOdUg8xLoJtn7EXAQtKK
         az2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8zQ0gjjO56euSFEObPWmsvfCTOikaJBtrG7VqVmrbEA=;
        b=bLC8aZzFXlf1AoRvvqd5nYYUNU3iJUc11Ek5he4pmGg00JP+7d2WNyrAJSRWZD6EHx
         xXTZh+hgSV0JlEf8BOZJoXYTox7B6ZF6OQqDuRMnkAkLQTiUT2U9K3qdWPHuJqUpYBKO
         cZqVyH+lgCSEbfndAI7CipcFmRD4k807woZzOsaiatqskjdiPwL2J9VBHLKCHA6vf8GU
         rkHUsDp0XYWlUwC+S8/TrDRKAUMUDxEduB7yjvToQDgFa/oHmTrM5ZKJLbhuoUSjax/Z
         ZJANq2DBVGOAA0Wa7uKhSj4qyqSeFTgiTIb8bcYdPuOCzAY8LAkb4ayJx3ZERWxD0uKG
         WZCw==
X-Gm-Message-State: APjAAAVE+RsnCit3lTjhYM0DdMqXqurayL4BOgDMsU5ARYwt5A53zzw+
        xC30r2cSTfLFSbD5e/M04w==
X-Google-Smtp-Source: APXvYqy9z5WPBUl8cBXC7eBCP01vMIPQDDb0vof34sNH1N7ww/BuIoUtVKLNxmX1of1nHO0t3nBj5g==
X-Received: by 2002:ae9:d881:: with SMTP id u123mr5521379qkf.294.1557437838893;
        Thu, 09 May 2019 14:37:18 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm1899721qke.46.2019.05.09.14.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:37:18 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ktest: introduce grub2bls REBOOT_TYPE option
Date:   Thu,  9 May 2019 17:36:44 -0400
Message-Id: <20190509213647.6276-4-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509213647.6276-1-msys.mizuma@gmail.com>
References: <20190509213647.6276-1-msys.mizuma@gmail.com>
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
 tools/testing/ktest/ktest.pl | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index ff43f8336da1..df0c609c7c50 100755
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
 
@@ -1965,6 +1973,10 @@ sub get_grub_index {
 	$command = "cat $grub_file";
 	$target = '^menuentry.*' . $grub_menu_qt;
 	$skip = '^menuentry\s|^submenu\s';
+    } elsif ($reboot_type eq "grub2bls") {
+        $command = $grub_bls_get;
+        $target = '^title=.*' . $grub_menu_qt;
+        $skip = '^title=';
     } else {
 	return;
     }
@@ -4324,7 +4336,7 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 
     if (!$buildonly) {
 	$target = "$ssh_user\@$machine";
-	if ($reboot_type eq "grub") {
+	if (($reboot_type eq "grub") or ($reboot_type eq "grub2bls")) {
 	    dodie "GRUB_MENU not defined" if (!defined($grub_menu));
 	} elsif ($reboot_type eq "grub2") {
 	    dodie "GRUB_MENU not defined" if (!defined($grub_menu));
-- 
2.20.1

