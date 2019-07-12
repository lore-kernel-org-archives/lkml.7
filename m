Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8458C742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847152084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OUtV2iht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfGLKQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:16:41 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59044 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfGLKQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562926600; x=1594462600;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AJoqHcIECcqLH0QUSRg33YPP63XfJj1vTpbOg4ozyvg=;
  b=OUtV2ihtwiEXouwIVXOS7tUnwQ3/R6hBVwVQHz14SDLNHOY2o9YiGha/
   qlWBh/FVoR2ECykh1X6Yc4xs9HLidS6qfmUr1WcFSxRvoNNg5kESkt/SH
   yspSlYmHmo/1RQ9vuZnDeWkt97aeFuP3zZh54Icq5qqe7zegPMq461YPs
   2nSMUVH6NuQOCIu9WERw3raSeSB27SnAZmn1H6Mn2Z6xeFx3l+qY6ZHaa
   QE583PD7zkesE4K0t8OCWpPCU7y8tF+N7J7mhpwOZq/c1nbE4ZypiYbTd
   zdDPzcIx1ovv1suN+CkoKsdL3YB+P9lOO91LTY4WZzHfa9X1g4viPKeZz
   A==;
IronPort-SDR: LJ8IhfzQMcVvRlligi3wgUH0zKQdp093sEojYp3ugumRzvEXCHWbOPs4FwHMWXhNO+F/mxFk8I
 sNq2QQr2dhh817a/JurQSu92avzez1gGkmqZon1Yb98y7ajFItmTOGL6bldWXJjsV2oFgM4I8W
 ZZyQBeLszYh4UtRefQ8gG986mxLXd6efz2p3BtJeuvIwh9fCFKzlXuVPsqGpTvwjJxVoQZIhFs
 vJ8kufkpb9y27irmTbrm7eCF4DgHfeX3Sa6JKsN45bC0nml3T8MFy46ZzmYkV30ttCc21XcNHG
 U4Y=
X-IronPort-AV: E=Sophos;i="5.63,482,1557158400"; 
   d="scan'208";a="219302715"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 18:16:39 +0800
IronPort-SDR: L2EHXYGXl6ObsZBdHzDYnuGnfrsXrfJE733KKTsAEEJngaG+Cxr+YBI7M+GcOVnP5w8F/8Lq+9
 Q9kdU6CvSTu4G4YIHgArrkktO1p3CLaGFEf59FSNQvkcuujqHJIB1YLzOwFIQaRocIEZAeDP1w
 UIJcL93a7QcbF0N6bUqH6xlkFPf0Y8/jkIiPi5yKEo4fnmA49lOWehhJAMdtnYg7XgDQEhJ+Q0
 aEZhsAk0weA4BJXsTl9ZLT6Iu5zupmUwQznZN6SHHPjqTuPsAZbWQURuW5UyBhN/lhM9E9SZ9y
 ilRZokl8kHS+jTGNKEW50R/O
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 12 Jul 2019 03:15:21 -0700
IronPort-SDR: IulP3MoeMaiHmqM2NTmWCM5KACyInQn5hl41aggyyqOkCzE+3S3dk5KTb69ZO6f9Iv9+geXDtQ
 GcNRn26rOfaxatIu9C6XoNPaKB3vuo1DN65P0e5cwGrx8x9oehzpMqz+KfPbVqeJiccYDXY4QV
 WzqZQRWTCc/EDvWJgEb9QYH0lIg2DZ2NvI/UWLzeJ7zn6RcGinszVc84I1+kGdnKrlPuQLg71+
 Evov7cwuHzxia9LJWVML4mSpbX/hoPF4lBYfpbGNIRfGSqZ4t0hdXQAEP8i32ctdnG+uaYUYSa
 WH4=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Jul 2019 03:16:38 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 1/2] x86/vdso: fix flip/flop vdso build bug
Date:   Fri, 12 Jul 2019 19:15:55 +0900
Message-Id: <20190712101556.17833-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two consecutive "make" on an already compiled kernel tree will show
different behavior:

$ make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  VDSOCHK arch/x86/entry/vdso/vdso64.so.dbg
  VDSOCHK arch/x86/entry/vdso/vdso32.so.dbg
Kernel: arch/x86/boot/bzImage is ready  (#3)
  Building modules, stage 2.
  MODPOST 12 modules

$ make
make
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CHK     include/generated/compile.h
  VDSO    arch/x86/entry/vdso/vdso64.so.dbg
  OBJCOPY arch/x86/entry/vdso/vdso64.so
  VDSO2C  arch/x86/entry/vdso/vdso-image-64.c
  CC      arch/x86/entry/vdso/vdso-image-64.o
  VDSO    arch/x86/entry/vdso/vdso32.so.dbg
  OBJCOPY arch/x86/entry/vdso/vdso32.so
  VDSO2C  arch/x86/entry/vdso/vdso-image-32.c
  CC      arch/x86/entry/vdso/vdso-image-32.o
  AR      arch/x86/entry/vdso/built-in.a
  AR      arch/x86/entry/built-in.a
  AR      arch/x86/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o
<snip>

This is causing "LD vmlinux" once every two times even without any
modifications. This is the same bug fixed in commit 92a4728608a8
("x86/boot: Fix if_changed build flip/flop bug"). We cannot use two
"if_changed" in one target. Fix this build bug by merging two commands into
one function.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Fixes: 7ac870747988 ("x86/vdso: Switch to generic vDSO implementation")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 arch/x86/entry/vdso/Makefile | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 39106111be86..34773395139a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -56,8 +56,7 @@ VDSO_LDFLAGS_vdso.lds = -m elf_x86_64 -soname linux-vdso.so.1 --no-undefined \
 			-z max-page-size=4096
 
 $(obj)/vdso64.so.dbg: $(obj)/vdso.lds $(vobjs) FORCE
-	$(call if_changed,vdso)
-	$(call if_changed,vdso_check)
+	$(call if_changed,vdso_and_check)
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include -I$(srctree)/include/uapi -I$(srctree)/arch/$(SUBARCH)/include/uapi
 hostprogs-y			+= vdso2c
@@ -127,8 +126,7 @@ $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
 $(obj)/vdsox32.so.dbg: $(obj)/vdsox32.lds $(vobjx32s) FORCE
-	$(call if_changed,vdso)
-	$(call if_changed,vdso_check)
+	$(call if_changed,vdso_and_check)
 
 CPPFLAGS_vdso32.lds = $(CPPFLAGS_vdso.lds)
 VDSO_LDFLAGS_vdso32.lds = -m elf_i386 -soname linux-gate.so.1
@@ -167,8 +165,7 @@ $(obj)/vdso32.so.dbg: FORCE \
 		      $(obj)/vdso32/note.o \
 		      $(obj)/vdso32/system_call.o \
 		      $(obj)/vdso32/sigreturn.o
-	$(call if_changed,vdso)
-	$(call if_changed,vdso_check)
+	$(call if_changed,vdso_and_check)
 
 #
 # The DSO images are built using a special linker script.
@@ -184,6 +181,9 @@ VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
 	-Bsymbolic
 GCOV_PROFILE := n
 
+quiet_cmd_vdso_and_check = VDSO    $@
+      cmd_vdso_and_check = $(cmd_vdso); $(cmd_vdso_check)
+
 #
 # Install the unstripped copies of vdso*.so.  If our toolchain supports
 # build-id, install .build-id links as well.
-- 
2.22.0

