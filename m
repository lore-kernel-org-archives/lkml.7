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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05689C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB662177B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZH/FTyNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfEIVhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:37:31 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:36154 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfEIVhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:37:25 -0400
Received: by mail-qt1-f182.google.com with SMTP id a17so3077927qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=udMrcF8Of1Kowi6clBlRB69BZqF17mcJ3kdfDGcFgQ8=;
        b=ZH/FTyNG3gkHsr0lzHSB3/8sAPjTR9svQeO5P7KF81O8QAJeeBn7nGBBxcZg4KjiJ7
         b3HpT0gl1+ww3vpmIUAP5KdHavRYEmmomfeUfUHOc+hYR9SS8veehgFsrYFktBJE5/ca
         CyD2YZVr33G5t6AI+vk8cyLdUkSpwECZlGt/Nf7YH48Ye7BYQ/XKfHNoVVQpAgVUmKkn
         u1GKkuprUQGylBmgO0uRPQ+ivMyD/MyNXUPlcM1ded9fRuLVL0lZXWQd+6doZnOzp8Ce
         slORw59c4JfJQZz5W74CBhSitg+BQteXyIdiVPLX1QOgFmDxHbR2wAZQqoYSbCqC1h4S
         9I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=udMrcF8Of1Kowi6clBlRB69BZqF17mcJ3kdfDGcFgQ8=;
        b=C3p5Hj6ygZHy78776QK61ctIQkAr8YW4LbPNCH4DnvYUYNy1qJ8TdxLIxyMtcl+SRy
         kDNsTU2Ui3EPNQw6tojejUJAdZ7Rvc6LEro73tBHr4+TQACmG6HZ3tBHSt32+7RdX6yf
         R155xoduOJyWSLAOMg/waYNer6nt7m2Cq213+Y7ry6LwR/GwU6x3kPLpqJAaLJGrEvlG
         hR6aT0Eb0NvO73fINzzsRweU1/RoJWdsSuz9F5s9N+rt6VFzAP7Cmk1qREwjjLHzc+at
         EMt37sQPNtvBINLxUbDNHTfodfUZAuEmIkb2dDBWhTFs6jggmT3HLKm5ce9cKBK7PIVi
         6ArQ==
X-Gm-Message-State: APjAAAV0WMZ7l2Py73GyZBn7P+pTLofQUIdf+89SnZtaWzKUzfgsgwt5
        pNLr/ra2LTa5BbYSKZ5y/A==
X-Google-Smtp-Source: APXvYqyh016czYqlVcFLaP5AnpMwz6XtHBPDdZHClCTvRSPQL69smcnovaWp1+dDHE+J3Tn5bC4HdA==
X-Received: by 2002:aed:2121:: with SMTP id 30mr5808857qtc.47.1557437844657;
        Thu, 09 May 2019 14:37:24 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 76sm1899721qke.46.2019.05.09.14.37.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:37:24 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ktest: update sample.conf for grub2bls
Date:   Thu,  9 May 2019 17:36:47 -0400
Message-Id: <20190509213647.6276-7-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190509213647.6276-1-msys.mizuma@gmail.com>
References: <20190509213647.6276-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Update sample.conf for grub2bls

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
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

