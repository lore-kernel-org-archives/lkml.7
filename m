Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80353C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5834E20857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbfDHV1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:27:44 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:50309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfDHV1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:27:44 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mzhzd-1h03663F6v-00vi17; Mon, 08 Apr 2019 23:27:35 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-s390@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] s390: don't build vdso32 with clang
Date:   Mon,  8 Apr 2019 23:26:15 +0200
Message-Id: <20190408212648.2407234-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x9YtJQSMNGl1cwp2C5TgeVDUYh7lr2dxuVL43QOSlFPx8jXUT5U
 zwopPNuIYebMlwf6c1CHitGGPVw5a3AXZnmNLnm63E+km4l6qvK3DmKpdEk/G6t9WJMbkGt
 pHzVfd9zGtiauvElZFv2t87HHZ1Q9V5euNhZ661WjGO3Q13hPu3p2nPAqXIyRyhvP6SkWCd
 TQX7PZakifOfekRrQhp4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rK8by7wZztg=:99Hqe2p/VYskq8fBPOptJw
 aKg/ki2/qE2m6JkIhJEhzLgetcbo0UwAzF4mSDHIeNQ6ZI/xPa0gTbPFsdlh6bBjhwGnOkE18
 pIhC+UWCemGuIGs26xvY4LBkreAWQxYYX9w0F5HA0qT/KKgWk3+GapGIqLUv7RPXI3s2fnX7X
 iqkZX1JzVTR4upvOExjD0htWVoRKJkVB00+o+FoDYCZ9/itbg6XbjWpyAjBoqoM1f/+A7/D7A
 wi1ZbaLyJnw5v3KANUuwYHiu+4SP+5QuOaJC2kAp7qjZ4Z72bucnVnrhD+1TbIKvC9cqTNmQd
 JUJZ9QqIiBMTfQPMPqOzlFEOuGxmq/rkc6ul+ooUp0w/uZgo8Zl1h+4X3u/zL52HEeByz97Bi
 iFM6wTK1Qp8hTumuIyXvmwMEVKGi5iO2ZSfrHKssVMgWrwoJtUpwZ/KOBbazdqtcHj3Uy5PZB
 wPeM3TqTAgHpKWyL4bMWAtQMGOubGCKjxUHEPjsMpx8UZ53cS946lQS6O5QuCyfvxpYVXjgOc
 IjZrWdfCB8F48bh1dcwPLAu4yiJ4lNU82dmx/Jec8arAiW90pmXv3a12tKZVNoku9xKTuHoSw
 /SUJbkTKQqpXLU5fOASJtplVY8PNVFJiCy0NwNely/VoT3U7N82ONTx/i9A9ET18/YUFzy0hI
 /Iv/kTYBYR8n80jSXpkYIIyIyfpuou1HjL8kYzjlEV0Rb4lBT63tb3X/r0neErVdTkMwtcEPM
 CK7gTRW+JXwkyjZzKyHDhnQTv40oDUkD7DXxKg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang does not support 31 bit object files on s390, so skip
the 32-bit vdso here, and only build it when using gcc to compile
the kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/s390/Kconfig         |  3 +++
 arch/s390/kernel/Makefile |  2 +-
 arch/s390/kernel/vdso.c   | 10 +++++-----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d0653002..8cd860cba4d1 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -388,6 +388,9 @@ config COMPAT
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
+config COMPAT_VDSO
+	def_bool COMPAT && !CC_IS_CLANG
+
 config SYSVIPC_COMPAT
 	def_bool y if COMPAT && SYSVIPC
 
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 8a62c7f72e1b..1222db6d4ee9 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -86,7 +86,7 @@ obj-$(CONFIG_TRACEPOINTS)	+= trace.o
 
 # vdso
 obj-y				+= vdso64/
-obj-$(CONFIG_COMPAT)		+= vdso32/
+obj-$(CONFIG_COMPAT_VDSO)	+= vdso32/
 
 chkbss := head64.o early_nobss.o
 include $(srctree)/arch/s390/scripts/Makefile.chkbss
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index e7920a68a12e..243d8b1185bf 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -29,7 +29,7 @@
 #include <asm/vdso.h>
 #include <asm/facility.h>
 
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 extern char vdso32_start, vdso32_end;
 static void *vdso32_kbase = &vdso32_start;
 static unsigned int vdso32_pages;
@@ -55,7 +55,7 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 
 	vdso_pagelist = vdso64_pagelist;
 	vdso_pages = vdso64_pages;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	if (vma->vm_mm->context.compat_mm) {
 		vdso_pagelist = vdso32_pagelist;
 		vdso_pages = vdso32_pages;
@@ -76,7 +76,7 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	unsigned long vdso_pages;
 
 	vdso_pages = vdso64_pages;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	if (vma->vm_mm->context.compat_mm)
 		vdso_pages = vdso32_pages;
 #endif
@@ -223,7 +223,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return 0;
 
 	vdso_pages = vdso64_pages;
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	mm->context.compat_mm = is_compat_task();
 	if (mm->context.compat_mm)
 		vdso_pages = vdso32_pages;
@@ -280,7 +280,7 @@ static int __init vdso_init(void)
 	int i;
 
 	vdso_init_data(vdso_data);
-#ifdef CONFIG_COMPAT
+#ifdef CONFIG_COMPAT_VDSO
 	/* Calculate the size of the 32 bit vDSO */
 	vdso32_pages = ((&vdso32_end - &vdso32_start
 			 + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
-- 
2.20.0

