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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB6FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31CA82182B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0khjSsD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfEIRrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:47:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42891 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfEIRrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:47:20 -0400
Received: by mail-qt1-f195.google.com with SMTP id j53so3480734qta.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cj0DlhFnSLAXH8ArFEaurqQD8JYO47YeBdLQtQ9/QVc=;
        b=j0khjSsDQ+XotdNTQOii0x/GJROhNyKRcRxPjSoMJOawGSM/UPXykPs8Oa9AEw8OPn
         KgqhrQY3t5ZWdcD63P8+nKWr4eBrtbactYWg23xPTtwa8xYR6Pze8KFJ7pTJqWVdx9dd
         8oUTxuirKZOvFvKMPO4wcSlsYO35o6aiuw3ARSFFPv3MLtyWNF75Yfh+OQcORI3N0lVJ
         wPsPP3RnHdxfGMyBLqdCDdvRqTOSa2Gh1cVoLiQrm5exIhoPUrYlrGx1SqKOm/xa2OxJ
         08qITYXjQeAAy03bGUjdUIdbZa8kRyxXfSEHD9vQwWZPWXv8jHyE3VNownq2qkQV3432
         P79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cj0DlhFnSLAXH8ArFEaurqQD8JYO47YeBdLQtQ9/QVc=;
        b=hFFoSid92RgbLUdVBGqmQpU/c5UUTLdna5H/nw6OPu5qNCwQ9YmClpm0JVCFls34GI
         Io/Lg5519eKCGybYQxrg4k6Pb940y3BQMQkPptaSD28N86zkxdEIxw3WjjtzZ89dYVEG
         LBIYCdnpYiE3YibaBcLhacifNCnjjxSt6ZIDSVl4cpYYxZay389Q91ZGJXZaDJoAFsJy
         EMVyj2teoApIaJ0aileB+am6EUiMGdg1NTxE4gp84jF45xeJW6HIj0Y2FbC/bP06Gj2D
         Oi0r70SboPot3NCNsZX+yOmxw21liDhQmVcFy3Mjx0n7x8n/obQzKQAxAOOfllfO6Goj
         rBRw==
X-Gm-Message-State: APjAAAWy4IF68SnexvXvIQ+gxuAAqn1Q6ssUbrc2lM0vV0mBCj6Ek4JC
        RaXzES68uW5s19bS7FIGkw==
X-Google-Smtp-Source: APXvYqwi71S3G+Om9u0RA039UEkIPCqFUnw6Ct/YrWp/qlxyU4qXf8Q87zJH0XltypQpolL+PbApCQ==
X-Received: by 2002:aed:3fa7:: with SMTP id s36mr5012741qth.124.1557424039826;
        Thu, 09 May 2019 10:47:19 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z11sm1262953qki.95.2019.05.09.10.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:47:19 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] ktest: cleanup get_grub_index
Date:   Thu,  9 May 2019 13:46:27 -0400
Message-Id: <20190509174630.26713-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509174630.26713-1-msys.mizuma@gmail.com>
References: <20190509174630.26713-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Cleanup get_grub_index().

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 50 +++++++++++-------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 3862b23672f7..1255ea0d9df4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1934,46 +1934,26 @@ sub get_grub2_index {
 
 sub get_grub_index {
 
-    if ($reboot_type eq "grub2") {
-	get_grub2_index;
-	return;
-    }
-
-    if ($reboot_type ne "grub") {
-	return;
-    }
-    return if (defined($grub_number) && defined($last_grub_menu) &&
-	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
-	       $last_machine eq $machine);
-
-    doprint "Find grub menu ... ";
-    $grub_number = -1;
+    my $command;
+    my $target;
+    my $skip;
+    my $grub_menu_qt;
 
-    my $ssh_grub = $ssh_exec;
-    $ssh_grub =~ s,\$SSH_COMMAND,cat /boot/grub/menu.lst,g;
+    return if ($reboot_type ne "grub") and ($reboot_type ne "grub2");
 
-    open(IN, "$ssh_grub |")
-	or dodie "unable to get menu.lst";
-
-    my $found = 0;
-    my $grub_menu_qt = quotemeta($grub_menu);
+    $grub_menu_qt = quotemeta($grub_menu);
 
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

