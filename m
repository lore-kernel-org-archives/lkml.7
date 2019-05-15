Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3742089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfEORkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfEORk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:40:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B5721726;
        Wed, 15 May 2019 17:40:25 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQxtA-0006Q7-VX; Wed, 15 May 2019 13:40:24 -0400
Message-Id: <20190515174024.866501626@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 15 May 2019 13:39:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [for-next][PATCH 4/6] ktest: pass KERNEL_VERSION to POST_KTEST
References: <20190515173951.753467660@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

For BLS, kernel entry is added by kernel-install command through
POST_INSALL, for example,

POST_INSTALL = ssh root@Test "/usr/bin/kernel-install \
    add $KERNEL_VERSION /boot/vmlinuz-$KERNEL_VERSION"

The entry is removed by kernel-install command and the kernel
version is needed for the argument.

Pass KERNEL_VERSION variable to POST_KTEST so that kernel-install
command can remove the entry like as follows:

POST_KTEST = ssh root@Test "/usr/bin/kernel-install remove $KERNEL_VERSION"

Link: http://lkml.kernel.org/r/20190509213647.6276-5-msys.mizuma@gmail.com

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index df0c609c7c50..abd6f37b0561 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4456,7 +4456,9 @@ for (my $i = 1; $i <= $opt{"NUM_TESTS"}; $i++) {
 }
 
 if (defined($final_post_ktest)) {
-    run_command $final_post_ktest;
+
+    my $cp_final_post_ktest = eval_kernel_version $final_post_ktest;
+    run_command $cp_final_post_ktest;
 }
 
 if ($opt{"POWEROFF_ON_SUCCESS"}) {
-- 
2.20.1


