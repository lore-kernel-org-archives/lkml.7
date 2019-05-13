Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE96C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F4069208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="qSvI060C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfEMLZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:25:01 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:41393 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbfEMLZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:25:00 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x4DBMtr3032513;
        Mon, 13 May 2019 20:22:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x4DBMtr3032513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1557746576;
        bh=EU/CK6RIzPKe+JRQJjURxe4pIo5LQHgjibXAtioSisQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qSvI060CSPYmLRBCA4iRYFXdm9PWeqD3oF7SUtVayRcD6QY7sg1HjCzEmcLXYdpA/
         pjAw6StN5Mki/36nrnQLctAkGlx8ZwKhEzR+E74nxnnV2FJnMuwzZxks42K/aDQnVU
         qIq3z/2Q5MFnAPGuqxgTCOSFPpSqdsP4X7SSL6c/TVkgCWBc5u5ou3E8TYP3rsU+RI
         pOIf4h2MHLJIF1cCM3Ej4ZmJIfQ160kAncurfUDxkAa4Oa69jjytLRDVX/j9CI61ek
         bIesGFYqfWEiXqJWs8vwtVpXfclw0mLdmEK0guUbLor/VOmvn7cmiygyPHG751OOe4
         VTu5fprP9SDuw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Joel Stanley <joel@jms.id.au>,
        Mark Greer <mgreer@animalcreek.com>
Subject: [PATCH] powerpc/boot: fix broken way to pass CONFIG options
Date:   Mon, 13 May 2019 20:22:54 +0900
Message-Id: <20190513112254.22534-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
was wrong, but commit e41b93a6be57 ("powerpc/boot: Fix build failures
with -j 1") was also wrong.

Check-in source files never ever depend on build artifacts.

The correct dependency is:

  $(obj)/serial.o: $(obj)/autoconf.h

However, copying autoconf.h to arch/power/boot/ is questionable
in the first place.

arch/powerpc/Makefile adopted multiple ways to pass CONFIG options.

arch/powerpc/boot/decompress.c references CONFIG_KERNEL_GZIP and
CONFIG_KERNEL_XZ, which are passed via the command line.

arch/powerpc/boot/serial.c includes the copied autoconf.h to
reference a couple of CONFIG options.

Do not do this.

We should have already learned that including autoconf.h from each
source file is really fragile.

In fact, it is already broken.

arch/powerpc/boot/ppc_asm.h references CONFIG_PPC_8xx, but
arch/powerpc/boot/utils.S is not given any way to access CONFIG
options. So, CONFIG_PPC_8xx is never defined here.

Just pass $(LINUXINCLUDE) and remove all broken code.

I also removed the -traditional flag to make include/linux/kconfig.h
work. I do not understand why it needs to imitate the behavior of
pre-standard C preprocessors.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/boot/.gitignore |  2 --
 arch/powerpc/boot/Makefile   | 14 +++-----------
 arch/powerpc/boot/serial.c   |  1 -
 3 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 32034a0cc554..6610665fcf5e 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -44,5 +44,3 @@ fdt_sw.c
 fdt_wip.c
 libfdt.h
 libfdt_internal.h
-autoconf.h
-
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 73d1f3562978..b8a82be2af2a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -20,9 +20,6 @@
 
 all: $(obj)/zImage
 
-compress-$(CONFIG_KERNEL_GZIP) := CONFIG_KERNEL_GZIP
-compress-$(CONFIG_KERNEL_XZ)   := CONFIG_KERNEL_XZ
-
 ifdef CROSS32_COMPILE
     BOOTCC := $(CROSS32_COMPILE)gcc
     BOOTAR := $(CROSS32_COMPILE)ar
@@ -34,7 +31,7 @@ endif
 BOOTCFLAGS    := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
 		 -fno-strict-aliasing -O2 -msoft-float -mno-altivec -mno-vsx \
 		 -pipe -fomit-frame-pointer -fno-builtin -fPIC -nostdinc \
-		 -D$(compress-y)
+		 $(LINUXINCLUDE)
 
 ifdef CONFIG_PPC64_BOOT_WRAPPER
 BOOTCFLAGS	+= -m64
@@ -51,7 +48,7 @@ BOOTCFLAGS	+= -mlittle-endian
 BOOTCFLAGS	+= $(call cc-option,-mabi=elfv2)
 endif
 
-BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -traditional -nostdinc
+BOOTAFLAGS	:= -D__ASSEMBLY__ $(BOOTCFLAGS) -nostdinc
 
 BOOTARFLAGS	:= -cr$(KBUILD_ARFLAGS)
 
@@ -202,14 +199,9 @@ $(obj)/empty.c:
 $(obj)/zImage.coff.lds $(obj)/zImage.ps3.lds : $(obj)/%: $(srctree)/$(src)/%.S
 	$(Q)cp $< $@
 
-$(srctree)/$(src)/serial.c: $(obj)/autoconf.h
-
-$(obj)/autoconf.h: $(obj)/%: $(objtree)/include/generated/%
-	$(Q)cp $< $@
-
 clean-files := $(zlib-) $(zlibheader-) $(zliblinuxheader-) \
 		$(zlib-decomp-) $(libfdt) $(libfdtheader) \
-		autoconf.h empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
+		empty.c zImage.coff.lds zImage.ps3.lds zImage.lds
 
 quiet_cmd_bootcc = BOOTCC  $@
       cmd_bootcc = $(BOOTCC) -Wp,-MD,$(depfile) $(BOOTCFLAGS) -c -o $@ $<
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index b0491b8c0199..9457863147f9 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -18,7 +18,6 @@
 #include "stdio.h"
 #include "io.h"
 #include "ops.h"
-#include "autoconf.h"
 
 static int serial_open(void)
 {
-- 
2.17.1

