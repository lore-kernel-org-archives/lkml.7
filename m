Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDE1C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7E4120651
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZCgFKcn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbfDQUMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:12:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33604 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:12:49 -0400
Received: by mail-qk1-f194.google.com with SMTP id k189so15180608qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=78vEBc9reM9YM8/f3/8CuxrOvyd7mTbu1OAcBFD8s4U=;
        b=FZCgFKcn8BCht+46g4iy7p6p8v2LOtTndu5g8Lvd6F2eQsBWHcYOM1d5DVVCItbps0
         uJzaHxrOOy0pQeLnobtt/0/Nno1sKsMaLfXEIyuYwH3zbaad9Tp2xc91m/FR+alxhbA7
         uQC4OXOHVatTx2d9lpqYWa61pNY3zKVsYSMpc/K42MKjPLKcREDg4gw7mHMobLKJCT3G
         nZxnmwAULwrvIsEVvdfpkWwWzVwnYqoaBDs111blw/Iq6KyQFcYR1E07BJiFl29UGOu8
         NElX0XQ5nkParhm5uNdgaCU66VtBqkpsstP3SdyNg99BF9ySsZFysxQ3dlTKvzrGf/Ck
         Bm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=78vEBc9reM9YM8/f3/8CuxrOvyd7mTbu1OAcBFD8s4U=;
        b=Atw5SiO4ujEUgH1MO1WB6lGAyzfjsDV6C0dx7I5Vplr/fw1e2JA4zfmIAAiJsMo0AV
         UKalPdnUgQcfIC1sWfiI4N2RZBno2dCC11VjvDuUZBOUiwhfAGx3YNHayCskaiE2nolA
         S8wrhd1avJrpNOwwC5D0QdN8sZ0iA5yiHMQOuc8uVe7ltu9MONcqSmden3Co8mQrcI+a
         YTQhEnmgKiPNKfg5g+6d9VOqymKyxciPQtAY4kGOkQC9P1SMW6JLxjvUki4HNVwYZcCG
         7xxh9EFK+Hy3cyOwVJXGZCg4bBs5qwrAEgRZSSpI67s9x2SlrJ8cX/jOLNPaDGJDfVdE
         I+IQ==
X-Gm-Message-State: APjAAAVOxWx0S2Cg+JUZvPXvu32qLSDj33E+bL9RwNmEfUfrpaZvoZ0j
        /tL63AfWgeG8nhGOiSKYpg==
X-Google-Smtp-Source: APXvYqzD5SElTsT+hf9qF8Amia8hAMGdY50KmV4YsMcsIQpmBJ302U9V5J4xsx7DPhmsPkhMaNGIPw==
X-Received: by 2002:a37:c15:: with SMTP id 21mr67837665qkm.50.1555531968203;
        Wed, 17 Apr 2019 13:12:48 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v8sm35659259qtc.69.2019.04.17.13.12.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 13:12:47 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ktest: Add support for meta characters in GRUB_MENU
Date:   Wed, 17 Apr 2019 16:11:14 -0400
Message-Id: <20190417201114.14839-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

ktest fails if meta characters are in GRUB_MENU, for example
GRUB_MENU = 'Fedora (test)'

The failure happens because the meta characters are not escaped,
so the menu doesn't match in any entries in GRUB_FILE.

Use quotameta() to escape the meta characters.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 87af8a68ab25..ea07d43856b8 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1866,9 +1866,10 @@ sub get_grub2_index {
 	or dodie "unable to get $grub_file";
 
     my $found = 0;
+    my $_grub_menu = quotemeta($grub_menu);
 
     while (<IN>) {
-	if (/^menuentry.*$grub_menu/) {
+	if (/^menuentry.*$_grub_menu/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
@@ -1909,9 +1910,10 @@ sub get_grub_index {
 	or dodie "unable to get menu.lst";
 
     my $found = 0;
+    my $_grub_menu = quotemeta($grub_menu);
 
     while (<IN>) {
-	if (/^\s*title\s+$grub_menu\s*$/) {
+	if (/^\s*title\s+$_grub_menu\s*$/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
-- 
2.20.1

