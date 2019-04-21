Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78489C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4842087B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 03:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfDUDzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 23:55:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbfDUDzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 23:55:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 14E6FC057F3E;
        Sun, 21 Apr 2019 03:55:52 +0000 (UTC)
Received: from localhost (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22A99608A6;
        Sun, 21 Apr 2019 03:55:48 +0000 (UTC)
X-Mailbox-Line: From dyoung@redhat.com Sun Apr 21 11:53:03 2019
Message-ID: <20190421035058.943630505@redhat.com>
User-Agent: quilt/0.66
Date:   Sun, 21 Apr 2019 11:50:59 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, vgoyal@redhat.com, bhe@redhat.com,
        piliu@redhat.com, Yinghai Lu <yinghai@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH 1/2] X86/kdump: move crashkernel=X to reserve under 4G by default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 21 Apr 2019 03:55:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kdump crashkernel low reservation is limited to under 896M even for
X86_64. This obscure and miserable limitation exists for old kexec-tools
compatibility, but the reason is not documented anywhere.

Some more tests/investigations about the background:
a) Previously old kexec-tools can only load purgatory to memory under 2G,
   Eric remove that limitation in 2012 in kexec-tools:
   Commit b4f9f8599679 ("kexec x86_64: Make purgatory relocatable anywhere
   in the 64bit address space.")

b) back in 2013 Yinghai removed all the limitations in new kexec-tools,
   bzImage64 can be loaded to anywhere.
   Commit 82c3dd2280d2 ("kexec, x86_64: Load bzImage64 above 4G")

c) test results with old kexec-tools with old and latest kernels.
  1. old kexec-tools can not build with modern toolchain anymore,
     I built it in a RHEL6 vm
  2. 2.0.0 kexec-tools does not work with latest kernel even with
     memory under 896M and give an error:
     "ELF core (kcore) parse failed", it needs below kexec-tools fix 
     Commit ed15ba1b9977 ("build_mem_phdrs(): check if p_paddr is invalid")
  3. even with patched kexec-tools which fixes 2),  it still needs some
     other fixes to work correctly for kaslr enabled kernels.

So the situation is:
* old kexec-tools is already broken with latest kernels
* we can not keep this limitations forever just for compatibility of very
  old kexec-tools.
* If one must use old tools then he/she can choose crashkernel=X@Y
* people have reported bugs crashkernel=384M failed because kaslr makes
  the 0-896M space sparse, 
* crashkernel can reserve in low or high area, it is natural to understand 
  low as memory under 4G

Hence drop the 896M limitation, and change crashkernel low reservation to
reserve under 4G by default.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/setup.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- linux-x86.orig/arch/x86/kernel/setup.c
+++ linux-x86/arch/x86/kernel/setup.c
@@ -71,6 +71,7 @@
 #include <linux/tboot.h>
 #include <linux/jiffies.h>
 #include <linux/mem_encrypt.h>
+#include <linux/sizes.h>
 
 #include <linux/usb/xhci-dbgp.h>
 #include <video/edid.h>
@@ -448,18 +449,17 @@ static void __init memblock_x86_reserve_
 #ifdef CONFIG_KEXEC_CORE
 
 /* 16M alignment for crash kernel regions */
-#define CRASH_ALIGN		(16 << 20)
+#define CRASH_ALIGN		SZ_16M
 
 /*
  * Keep the crash kernel below this limit.  On 32 bits earlier kernels
  * would limit the kernel to the low 512 MiB due to mapping restrictions.
- * On 64bit, old kexec-tools need to under 896MiB.
  */
 #ifdef CONFIG_X86_32
-# define CRASH_ADDR_LOW_MAX	(512 << 20)
-# define CRASH_ADDR_HIGH_MAX	(512 << 20)
+# define CRASH_ADDR_LOW_MAX	SZ_512M
+# define CRASH_ADDR_HIGH_MAX	SZ_512M
 #else
-# define CRASH_ADDR_LOW_MAX	(896UL << 20)
+# define CRASH_ADDR_LOW_MAX	SZ_4G
 # define CRASH_ADDR_HIGH_MAX	MAXMEM
 #endif
 


