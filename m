Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7008FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBCE2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XutfWr/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfEIVh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:37:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:32959 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfEIVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:37:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id m32so1277776qtf.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U8Ht5zt/54JxWBMl7h0lyToG7ZZcMzVgDcBSG5cH950=;
        b=XutfWr/57XDgJkWEWm/IUsYiYPIADlqtGq+eIS+bvm/kj9l7rXLmiRg2dJe7zetRGY
         dMAx28YwNN73tN3gtkWvyaPWyjKLbWWYe/pZEuCpDzbALaBhbxWe7A+cFrpruNRT7yOT
         6tEWfUQIzKLboYGULGMJD4TAToiWbgfwDWeWoYKiJIeZEmhtm3QxFygwZ7WFHHnuXgrz
         74Aty5Vu0Gawgk0JfngU2nQHlpvtme5vske5Lv3XrnHmdcXcUkAFeXZPJhx5A55NZjiC
         JCNL+e3Owz946nSFKBlRuD7uVyMb8sAE2D7E3DzbHpa0tFU8CaL8B6HmKfMEOhmORwYY
         eXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U8Ht5zt/54JxWBMl7h0lyToG7ZZcMzVgDcBSG5cH950=;
        b=CFOtiYWLF2wYeSoae/9hkjjva5SHw56OV/oitB+QZ/JoEyt0NGNwc6uUzm/mXTLXrf
         Hp1C8CLZeFksFnnwHEBWdUKLIe+Bv2jcqjBya/KsK5bG/n5Qh0zYr9CuExFTHYrEJ3LB
         HcVZzk2ikz7zobL0biEXUSnjeVBews50cb0MxwJdkRwTicVTQzAG/Kw/mcjJ5s/emUCw
         AE2A4OCFJnqVPf6rxoR6SnikH8cHVLOgslf+EM9VyvH2kSBRH2iV159gDHKVBu8bJghj
         dLrwOa0mI/5Nxz4AY/wRQYfWageNIAZb5lKEecqNjvCypTNPNYOiaTC4MPEGmnhxyQiF
         SJoA==
X-Gm-Message-State: APjAAAWFT0AbBVo5PfF1IDyhr8XHcOgTkDZymN7+l2Jn3KQ5kp3ZiMzf
        3GUe6gPh7+kiB2X3tANMMg==
X-Google-Smtp-Source: APXvYqwGqMLNIY5mSZIo3og4umWMO3mVo5PW/bBzmgyiDqN/OA41/KV1DAcBhZRDbxbgNdyh9G1hEA==
X-Received: by 2002:ac8:fa3:: with SMTP id b32mr5802063qtk.89.1557437842895;
        Thu, 09 May 2019 14:37:22 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm1899721qke.46.2019.05.09.14.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:37:22 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] ktest: remove get_grub2_index
Date:   Thu,  9 May 2019 17:36:46 -0400
Message-Id: <20190509213647.6276-6-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509213647.6276-1-msys.mizuma@gmail.com>
References: <20190509213647.6276-1-msys.mizuma@gmail.com>
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
index abd6f37b0561..4711f57e809a 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1916,42 +1916,6 @@ sub _get_grub_index {
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

