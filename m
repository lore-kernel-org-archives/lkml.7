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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B87C04AB3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A02205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 17:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tL9DprA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfEIRrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 13:47:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34350 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIRrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 13:47:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id j6so3539038qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 10:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1dFVVz37ajk0vT9Cxtgo0ta09uw+YtMfeYk/oR/p3AM=;
        b=tL9DprA0gLTYPzx6vBPshwIOr1QAnRTZtgaLbl4E3/jkHku/pnkPeucDJ12V3jmu9M
         pHW4syKG3BvPcq32f176TQvD1ECaZfR3fQmZAZyVtI2fXNh86TdYB16nEAgoVmUIiK2i
         Vt5AWWEFiiW57dRR9igXHs0bcL+famtU1G2XC6GKHh9iBP8Zkzke7yXs+08UPp44oBD0
         kVuJ8gnUJEM2UWt8Dhi7fjVRjowYcOjlo5QxEdVOBOPTnmyAK9Mrfv1yLEx8T39VoM0d
         ejnnQlM86bUCRtDxdtOJUfER/HDHHi9c1lW1Obix24xge3JMygr0QP0tOa41DI/fc6tF
         EgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1dFVVz37ajk0vT9Cxtgo0ta09uw+YtMfeYk/oR/p3AM=;
        b=kVabNdzbAhhd5PRNFMMyxqdHAmEWAG2kcL0beK50/IDxU4YN4tcAnylhaif+EUN4YD
         vi3LVjRwuDKO2ryWtvUNT6BYSqiuvYyktisfT23whJuXHafrmes2yL5BmMLZvQwwtImP
         593p3wyLr2oWWSENMPAsoattuhHeT7ID2cfIhL95b7zj8uRo7deoxkOkzN7RQJV1X5hL
         txgw077asa52Luju0h96mZMQL3zeTDH+gkVR8B6+3c0Iys2tP6TDnldfU1g3eYphzU2a
         TW6OxlvJfz6KRsXZo+WDbvTF2JWvJJOUyDF3Bk+0O7zWHEkeYT0HkwcYQVS+KSUFHE5R
         Zivg==
X-Gm-Message-State: APjAAAUNUQTfUQoZgC37Tpt/i7Ckdg2K4iciPc0SY0KuYby2ngNyo2LN
        fDv/y7CUlrCBFx++lOvJCA==
X-Google-Smtp-Source: APXvYqzIJxdYQAqJ8m7PCbD4qANFRAxCtRofeQa75FwgP0OArAYvl5wXMyAtqaj6QmhG5Dvaqlj20w==
X-Received: by 2002:ac8:16c9:: with SMTP id y9mr4977065qtk.50.1557424037184;
        Thu, 09 May 2019 10:47:17 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z11sm1262953qki.95.2019.05.09.10.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 10:47:15 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ktest: introduce _get_grub_index
Date:   Thu,  9 May 2019 13:46:26 -0400
Message-Id: <20190509174630.26713-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509174630.26713-1-msys.mizuma@gmail.com>
References: <20190509174630.26713-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Introduce _get_grub_index() to deal with Boot Loader
Specification (BLS) and cleanup.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 751e32a31ed4..3862b23672f7 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1859,6 +1859,43 @@ sub run_scp_mod {
     return run_scp($src, $dst, $cp_scp);
 }
 
+sub _get_grub_index {
+
+    my ($command, $target, $skip) = @_;
+
+    return if (defined($grub_number) && defined($last_grub_menu) &&
+	       $last_grub_menu eq $grub_menu && defined($last_machine) &&
+	       $last_machine eq $machine);
+
+    doprint "Find $reboot_type menu ... ";
+    $grub_number = -1;
+
+    my $ssh_grub = $ssh_exec;
+    $ssh_grub =~ s,\$SSH_COMMAND,$command,g;
+
+    open(IN, "$ssh_grub |")
+	or dodie "unable to execute $command";
+
+    my $found = 0;
+
+    while (<IN>) {
+	if (/$target/) {
+	    $grub_number++;
+	    $found = 1;
+	    last;
+	} elsif (/$skip/) {
+	    $grub_number++;
+	}
+    }
+    close(IN);
+
+    dodie "Could not find '$grub_menu' through $command on $machine"
+	if (!$found);
+    doprint "$grub_number\n";
+    $last_grub_menu = $grub_menu;
+    $last_machine = $machine;
+}
+
 sub get_grub2_index {
 
     return if (defined($grub_number) && defined($last_grub_menu) &&
-- 
2.20.1

