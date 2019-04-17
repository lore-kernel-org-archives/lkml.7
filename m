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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2055C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2C214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hE5dLaaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbfDQX7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:59:18 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:46517 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbfDQX7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:59:18 -0400
Received: by mail-qk1-f172.google.com with SMTP id x18so144732qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3XRhPvb4N6O2Yp22oGWiqnunQI/jsKYLTDZaTWQJAHg=;
        b=hE5dLaaM59AJfw7S7sHDXzvb1OJKEh52dkD/G1zEUdB6/U80wglrYO7YowriLWiYr+
         stXgQeTgaERkDxDHmGLi66wnNT9GDM0CsjMLYQiyAdiU7rCuOwPDxA8jivUjP3iwn1Pi
         OkdGMW1+CmL1LvMmP1YmM8SBuj6hg27Izo5IBxYA9YsJxnlIPy3xfcaKw2x/rsLrwLIJ
         MBCRjwpvX3/c0WwopScoMN6wbGZw5P5qg2oQ3VgiEkvRU84L+7hVK6/D+9eCQgvozqeF
         iNtIn+q6x/5VnNshTdJiQGIMXPUOcazanmj0uJF8G+iGXU0wWIGV+fwpepUVCugeX9EK
         bTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3XRhPvb4N6O2Yp22oGWiqnunQI/jsKYLTDZaTWQJAHg=;
        b=gDER9teFZ6BkBvON9XzEG5I9YxrP82jU01e/meJbbB65iiN/GwLTbHCMZuQz89DVtq
         ntsVaE94/hGZ6q8x+nsndm+8PJdEMRkSfuMWOXkv+PTQOFafHV3pRXvZC5lEtsObvVqX
         qQ+PkpnXzDanD2ZPPlef9H1s5vP4NbvZwOdllpMYXFlZIRBY7QQF0U4fhGqaerdmjKzM
         w7F3xgetmUW7gXKAzmOMTifhhFplEGMgZZbrUXHtO4RCcRwBoFk5DOGereuNrH1m6xQG
         X6yR97R5Am5CZ5NAsHes3sN//lsK1uVqvbYkDLbQoRhF/qAEO74uh5m6W0Y+DlrPkWE6
         uhTw==
X-Gm-Message-State: APjAAAWeNw2yMrZSLZg16gyR2eC3jv464ZZNojXEcbpNgE+dU4yS6TqI
        wh6ZnGnbcVJ3PMyIBJQXfA==
X-Google-Smtp-Source: APXvYqxtNG8EzpEGUCFtXB1KXX6C4IN88Y3WZmx4GuZQSyYbQmiw/HIm2qpy+jlJ6qAPmdg+derE4g==
X-Received: by 2002:a05:620a:12ea:: with SMTP id f10mr66950770qkl.86.1555545557148;
        Wed, 17 Apr 2019 16:59:17 -0700 (PDT)
Received: from gabell.cable.rcn.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id k41sm275584qtc.89.2019.04.17.16.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 16:59:16 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ktest: Add support for meta characters in GRUB_MENU
Date:   Wed, 17 Apr 2019 19:58:23 -0400
Message-Id: <20190417235823.18176-1-msys.mizuma@gmail.com>
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

Use quotemeta() to escape the meta characters.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 tools/testing/ktest/ktest.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 87af8a68ab25..fc6140d45280 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1866,9 +1866,10 @@ sub get_grub2_index {
 	or dodie "unable to get $grub_file";
 
     my $found = 0;
+    my $grub_menu_qt = quotemeta($grub_menu);
 
     while (<IN>) {
-	if (/^menuentry.*$grub_menu/) {
+	if (/^menuentry.*$grub_menu_qt/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
@@ -1909,9 +1910,10 @@ sub get_grub_index {
 	or dodie "unable to get menu.lst";
 
     my $found = 0;
+    my $grub_menu_qt = quotemeta($grub_menu);
 
     while (<IN>) {
-	if (/^\s*title\s+$grub_menu\s*$/) {
+	if (/^\s*title\s+$grub_menu_qt\s*$/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
-- 
2.20.1

