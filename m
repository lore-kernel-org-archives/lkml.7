Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFA6C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA6E20830
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfEFOCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfEFOCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:02:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C759A20C01;
        Mon,  6 May 2019 14:02:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hNeCO-0006ys-W4; Mon, 06 May 2019 10:02:33 -0400
Message-Id: <20190506140232.883315684@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 06 May 2019 10:02:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [for-next][PATCH 2/3] ktest: Add support for meta characters in GRUB_MENU
References: <20190506140206.573397982@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
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

Link: http://lkml.kernel.org/r/20190417235823.18176-1-msys.mizuma@gmail.com

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 75f8cecdd549..3bec099a6cf4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1878,9 +1878,10 @@ sub get_grub2_index {
 	or dodie "unable to get $grub_file";
 
     my $found = 0;
+    my $grub_menu_qt = quotemeta($grub_menu);
 
     while (<IN>) {
-	if (/^menuentry.*$grub_menu/) {
+	if (/^menuentry.*$grub_menu_qt/) {
 	    $grub_number++;
 	    $found = 1;
 	    last;
@@ -1921,9 +1922,10 @@ sub get_grub_index {
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


