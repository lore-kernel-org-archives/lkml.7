Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA350C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95972215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 09:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfJAJf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 05:35:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54658 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbfJAJf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 05:35:28 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFEYl-0006ps-V0; Tue, 01 Oct 2019 11:35:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4930A1C03AB;
        Tue,  1 Oct 2019 11:35:07 +0200 (CEST)
Date:   Tue, 01 Oct 2019 09:35:07 -0000
From:   "tip-bot2 for Bruce Ashfield" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] arch/x86/boot: Use prefix map to avoid embedded paths
Cc:     Bruce Ashfield <bruce.ashfield@gmail.com>,
        Ross Burton <ross.burton@intel.com>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        George Rimar <grimar@accesssoftek.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190926093226.8568-1-ross.burton@intel.com>
References: <20190926093226.8568-1-ross.burton@intel.com>
MIME-Version: 1.0
Message-ID: <156992250722.9978.12089821293615435249.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     9e2276fa6eb39817dcc4cda415f0199fb7016b37
Gitweb:        https://git.kernel.org/tip/9e2276fa6eb39817dcc4cda415f0199fb7016b37
Author:        Bruce Ashfield <bruce.ashfield@gmail.com>
AuthorDate:    Thu, 26 Sep 2019 10:32:26 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 11:19:40 +02:00

arch/x86/boot: Use prefix map to avoid embedded paths

It was observed that the kernel embeds the absolute build path in the
x86 boot image when the __FILE__ macro is expanded.

> From https://bugzilla.yoctoproject.org/show_bug.cgi?id=13458:

  If you turn on the buildpaths QA test, or try a reproducible build, you
  discover that the kernel image contains build paths.

  $ strings bzImage-5.0.19-yocto-standard |grep tmp/
  out of pgt_buf in
  /data/poky-tmp/reproducible/tmp/work-shared/qemux86-64/kernel-source/arch/x86/boot/compressed/kaslr_64.c!?

  But what's this in the top-level Makefile:

  $ git grep prefix-map
  Makefile:KBUILD_CFLAGS  += $(call
  cc-option,-fmacro-prefix-map=$(srctree)/=)

  So the __FILE__ shouldn't be using the full path.  However
  arch/x86/boot/compressed/Makefile has this:

  KBUILD_CFLAGS := -m$(BITS) -O2

  So that clears KBUILD_FLAGS, removing the -fmacro-prefix-map option.

Use -fmacro-prefix-map to have relative paths in the boot image too.

 [ bp: Massage commit message and put the KBUILD_CFLAGS addition in
   ..boot/Makefile after the KBUILD_AFLAGS assignment because gas
   doesn't support -fmacro-prefix-map. ]

Signed-off-by: Bruce Ashfield <bruce.ashfield@gmail.com>
Signed-off-by: Ross Burton <ross.burton@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: George Rimar <grimar@accesssoftek.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190926093226.8568-1-ross.burton@intel.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=204333
---
 arch/x86/boot/Makefile            | 1 +
 arch/x86/boot/compressed/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index e2839b5..3e9f554 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -67,6 +67,7 @@ clean-files += cpustr.h
 
 KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
+KBUILD_CFLAGS	+= $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6b84afd..b246f18 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -38,6 +38,7 @@ KBUILD_CFLAGS += $(call cc-option,-fno-stack-protector)
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
 KBUILD_CFLAGS += -Wno-pointer-sign
+KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
