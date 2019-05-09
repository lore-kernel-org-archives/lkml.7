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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD95EC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3D221850
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrEvjfNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfEIVhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:37:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37924 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfEIVhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:37:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so4326930qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8fYnx3XpP10omEG1ZlzyLWO7BR4wnnd7ASZ6KJ5Ot/0=;
        b=mrEvjfNsD8myC2b92BMGcZ2DzYdXgm6EuEnq/dFCKUWNstBXwYrWDboB329TQZRaCr
         IGcPqzRHqkVXXEPL2cfeVRg2nMpJB1yLeNTD9+fxNJruXr55/1IEAeVMzeLGV5AvA7Cx
         gOq5biTsuTWjaeKkGvxC1xu6jtW3z7ZYn9kl0q1E4FCpCOPgPLbRQ08MjzG2UBOHHH6M
         wGi+wS6U/edWmEyawcUXDB0G15+5NiWHmgzcvSgYbnQAxiOadQ7SEn5wVngb2IFz36g8
         hteMHj4iCQgyD4wQL0GZII+CDpIeS6ZF8IU3XWtEhTffjhKAQ4ldiMXKGsrpQP+hJZq6
         XA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8fYnx3XpP10omEG1ZlzyLWO7BR4wnnd7ASZ6KJ5Ot/0=;
        b=L0VSxbuy0QbiIRqz3blK3GeUnCB/BlOTh+EIuBM7qsuO9HqhdDSrYhKvJHt4s5VHBl
         2ux3whDu4pqcvP9MTj5qrsu/EnjSN/lFdr6+7G/tyJ7KciglNxmwaJxCnQdLayE4hs4+
         +JDtfbSWo4GW4i53JCAXJy/RVbBd8f4VnPnKAUvJnezRs62r5q5/SnhJSaLw3/DQ6RRq
         +4bJvksrVwjPDz4SXIj/QuwYOYuV8bNdc1jR7u+9G8TtbsEwzWNn4lgl8ZL1sRbgwZjo
         3xlSI3IB2hvlXBikRhgae5sppVEKF06qWuE8VegIu3X9ES/vC60SEZZSknM0UJ1qEwmt
         2VUQ==
X-Gm-Message-State: APjAAAXvZweWautDfbfxTZYnvVpflhjpIj0FnDuc/Wf64+3VrWDZUgT6
        4ti0rsR4BJELnkTdS2gq8Q==
X-Google-Smtp-Source: APXvYqzETWRlCvITMdl7gn5+JnNF1N1Jx6/nlbFe/cyJHz4xNGQSoVG/9U1nRjt+QKD1jH/n3n+MVg==
X-Received: by 2002:ac8:1af9:: with SMTP id h54mr5912239qtk.292.1557437835522;
        Thu, 09 May 2019 14:37:15 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm1899721qke.46.2019.05.09.14.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:37:15 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] ktest: cleanup get_grub_index
Date:   Thu,  9 May 2019 17:36:43 -0400
Message-Id: <20190509213647.6276-3-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509213647.6276-1-msys.mizuma@gmail.com>
References: <20190509213647.6276-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Cleanup get_grub_index().

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
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

