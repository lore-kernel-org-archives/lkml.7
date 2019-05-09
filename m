Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB06CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBF5205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBXXzjzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfEIRrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:47:32 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35138 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfEIRr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:47:26 -0400
Received: by mail-qt1-f195.google.com with SMTP id a39so2700954qtk.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rZo7kGUe714qtzX0Xo9kFq/Ua2/ea5WXHDoDLZv3p5E=;
        b=DBXXzjzQ7UoapKgt9o2hnhIGBKp7ai3w/lXuKENOeqTjIG2dlc1UDSFwF4gP7x1//6
         KnyHzrgRutZxWE1C6OUb+n3UTgMjQfnuLB3c3hSF4gu7B16JN5drL+xUmy3ZqQ+7R5ys
         Eu+onpofcOJN8n6QUYDacr8Twvh46I/SNIcol8ROUMeMlMjq0c9S8AjUqlTWpm/3k9yF
         rEoI51NExApkAOAplfXXQ74lCCaxx4C7SFraoYTGnBvyHHhIxqYu8rnsqp2CRZQmG43Y
         IuGTvdRLNg3ZbD9N/UuvPweyTDX1eEX4sLRkiSdisziqpj/OvwiGKFM2+NB6F0wzVLW9
         3dTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rZo7kGUe714qtzX0Xo9kFq/Ua2/ea5WXHDoDLZv3p5E=;
        b=NITxQhsArXAHv42sCTmX9VCK51+0slRLqTQ6eZn7sVEBgdz6Yuq3oovEpDeLsu+WpO
         kPNcbBHtKACAaCygg4K6NhiXeIchK+veuYVeipO4yuBCu8fU5ENkXdSX1IerASlYMjNM
         guCa8F2td6kkj/OHyf6Z5s4k3mVEz5dKt93YOFo8o7x68zvu58/kF56ee+38tlCf1ug2
         Tb6cEJ7izAJaPACninX9bMKQHCBnluQDdmp5EDwTIvA7nmlx5OlPba8+sCtJ5rqCuRWq
         ZcEz93UZqkNxjRsZSa/JGSWi66mgB2wgz3l4BzfayjTGXRZ27UM0sPmGBkQkptpBh5xm
         bxyA==
X-Gm-Message-State: APjAAAVumHO3/GWL1a6xDaXTsbc8qJVjqPAUbfQFhT777znSupc4ZeBH
        5WlJNeE1DedlMdNFRHSwMA==
X-Google-Smtp-Source: APXvYqwkZLlUAeFtzesSFbU3lV85ZbtQGvh229Et95ZPrhd6EL0rEhMFgCU1XPlSL5CgVF+DH+uHpw==
X-Received: by 2002:aed:3596:: with SMTP id c22mr5048729qte.365.1557424045614;
        Thu, 09 May 2019 10:47:25 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z11sm1262953qki.95.2019.05.09.10.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:47:25 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ktest: remove get_grub2_index
Date:   Thu,  9 May 2019 13:46:29 -0400
Message-Id: <20190509174630.26713-5-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509174630.26713-1-msys.mizuma@gmail.com>
References: <20190509174630.26713-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Remove get_grub2_index() because it isn't used anywhere.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 36 ------------------------------------
 1 file changed, 36 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index c910d7921f48..e965751ad2da 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1904,42 +1904,6 @@ sub _get_grub_index {
     $last_machine = $machine;
 }
 
-sub get_grub2_index {
-
-    return if (defined($grub_number) && defined($last_grub_menu) &&
-	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
-	       $last_machine eq $machine);
-
-    doprint "Find grub2 menu ... ";
-    $grub_number = -1;
-
-    my $ssh_grub = $ssh_exec;
-    $ssh_grub =~ s,\$SSH_COMMAND,cat $grub_file,g;
-
-    open(IN, "$ssh_grub |")
-	or dodie "unable to get $grub_file";
-
-    my $found = 0;
-    my $grub_menu_qt = quotemeta($grub_menu);
-
-    while (<IN>) {
-	if (/^menuentry.*$grub_menu_qt/) {
-	    $grub_number++;
-	    $found = 1;
-	    last;
-	} elsif (/^menuentry\s|^submenu\s/) {
-	    $grub_number++;
-	}
-    }
-    close(IN);
-
-    dodie "Could not find '$grub_menu' in $grub_file on $machine"
-	if (!$found);
-    doprint "$grub_number\n";
-    $last_grub_menu = $grub_menu;
-    $last_machine = $machine;
-}
-
 sub get_grub_index {
 
     my $command;
-- 
2.20.1

