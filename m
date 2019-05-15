Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFA9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326402084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfEORkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:40:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:49708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbfEORk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:40:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FFD421473;
        Wed, 15 May 2019 17:40:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQxtA-0006P9-Mn; Wed, 15 May 2019 13:40:24 -0400
Message-Id: <20190515174024.594258502@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 15 May 2019 13:39:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [for-next][PATCH 2/6] ktest: cleanup get_grub_index
References: <20190515173951.753467660@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Cleanup get_grub_index().

Link: http://lkml.kernel.org/r/20190509213647.6276-3-msys.mizuma@gmail.com

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 50 ++++++++++++------------------------
 1 file changed, 17 insertions(+), 33 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 43868ee07e17..ff43f8336da1 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1946,46 +1946,30 @@ sub get_grub2_index {
 
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
-
-    doprint "Find grub menu ... ";
-    $grub_number = -1;
 
-    my $ssh_grub = $ssh_exec;
-    $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;
-
-    open(IN, "$ssh_grub |")
-	or dodie "unable to get menu.lst";
+    $grub_menu_qt = quotemeta($grub_menu);
 
-    my $found = 0;
-    my $grub_menu_qt = quotemeta($grub_menu);
-
-    while (<IN>) {
-	if (/^\s*title\s+$grub_menu_qt\s*$/) {
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
-- 
2.20.1


