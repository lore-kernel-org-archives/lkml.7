Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A998C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 270452089E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfEORkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbfEORk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:40:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17E972166E;
        Wed, 15 May 2019 17:40:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hQxtB-0006R6-8I; Wed, 15 May 2019 13:40:25 -0400
Message-Id: <20190515174025.143536583@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 15 May 2019 13:39:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: [for-next][PATCH 6/6] ktest: update sample.conf for grub2bls
References: <20190515173951.753467660@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Update sample.conf for grub2bls

Link: http://lkml.kernel.org/r/20190509213647.6276-7-msys.mizuma@gmail.com

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/sample.conf | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/sample.conf b/tools/testing/ktest/sample.conf
index 8c893a58b68e..c3bc933d437b 100644
--- a/tools/testing/ktest/sample.conf
+++ b/tools/testing/ktest/sample.conf
@@ -349,13 +349,13 @@
 # option to boot to with GRUB_REBOOT
 #GRUB_FILE = /boot/grub2/grub.cfg
 
-# The tool for REBOOT_TYPE = grub2 to set the next reboot kernel
+# The tool for REBOOT_TYPE = grub2 or grub2bls to set the next reboot kernel
 # to boot into (one shot mode).
 # (default grub2_reboot)
 #GRUB_REBOOT = grub2_reboot
 
 # The grub title name for the test kernel to boot
-# (Only mandatory if REBOOT_TYPE = grub or grub2)
+# (Only mandatory if REBOOT_TYPE = grub or grub2 or grub2bls)
 #
 # Note, ktest.pl will not update the grub menu.lst, you need to
 # manually add an option for the test. ktest.pl will search
@@ -374,6 +374,10 @@
 # do a: GRUB_MENU = 'Test Kernel'
 # For customizing, add your entry in /etc/grub.d/40_custom.
 #
+# For grub2bls, a search of "title"s are done. The menu is found
+# by searching for the contents of GRUB_MENU in the line that starts
+# with "title".
+#
 #GRUB_MENU = Test Kernel
 
 # For REBOOT_TYPE = syslinux, the name of the syslinux executable
@@ -479,6 +483,11 @@
 # default (undefined)
 #POST_KTEST = ${SSH} ~/dismantle_test
 
+# If you want to remove the kernel entry in Boot Loader Specification (BLS)
+# environment, use kernel-install command.
+# Here's the example:
+#POST_KTEST = ssh root@Test "/usr/bin/kernel-install remove $KERNEL_VERSION"
+
 # The default test type (default test)
 # The test types may be:
 #   build   - only build the kernel, do nothing else
@@ -530,6 +539,11 @@
 # or on some systems:
 #POST_INSTALL = ssh user@target /sbin/dracut -f /boot/initramfs-test.img $KERNEL_VERSION
 
+# If you want to add the kernel entry in Boot Loader Specification (BLS)
+# environment, use kernel-install command.
+# Here's the example:
+#POST_INSTALL = ssh root@Test "/usr/bin/kernel-install add $KERNEL_VERSION /boot/vmlinuz-$KERNEL_VERSION"
+
 # If for some reason you just want to boot the kernel and you do not
 # want the test to install anything new. For example, you may just want
 # to boot test the same kernel over and over and do not want to go through
@@ -593,6 +607,8 @@
 # For REBOOT_TYPE = grub2, you must define both GRUB_MENU and
 # GRUB_FILE.
 #
+# For REBOOT_TYPE = grub2bls, you must define GRUB_MENU.
+#
 # For REBOOT_TYPE = syslinux, you must define SYSLINUX_LABEL, and
 # perhaps modify SYSLINUX (default extlinux) and SYSLINUX_PATH
 # (default /boot/extlinux)
-- 
2.20.1


