Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B7AC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 05:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F298B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 05:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qVVBjdi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfGLFqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 01:46:14 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:24294 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfGLFqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 01:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562910480; x=1594446480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HMccxVoT58JbGUKu3aE4TUzBGUQZO3PA2N2cx5/gbsk=;
  b=qVVBjdi5upa83FyQa5ooKIPMIFpDy0Em7z/ghgDFej1eX54XxDM5C0U5
   dT5l/c8SDgQzddTvpDEdG0mVfk2NdulZ1zavOUvQ1WnANwRej+qrGhNK8
   +TCHMPTECDrP14lhJWK9oe8qOFDTaZ8xSww9rr/kimuhQZsUSszD9D7Ih
   +eqYFfeaGPkjdb7/ujwWYWYRBA89ENhuqTM5jsBGL6agXuLAoh2CWRY92
   QE9zPrVazq/rx+TwaqTJxfvmw7/d3aj/v0QPLmMUzAM7CQMLwOniDGx8W
   gPDV0J1CEDykIjiRBkPRIG5L4fgB0fCiS2M6XiIXewRtIJGWo7fF/owR4
   g==;
IronPort-SDR: dQ66BDnIiyJX515QKFX4JwlqthoRarkATnPGoIoj5yKeMteihzGm0mYzPFBkdvkD/NF6zdL5Ai
 5XKNfCZ9+ADxiwUlkS8V2G//k6jhNgG01NEoFL6Z9w8AUmMx67RavM3wbQmMfaASnoJe3c41wy
 P4r443xvCQLMRqfMlaRT/Bz5mMhvsNPUlwZy95317OZkJQsHanGcETDiBtk7T2A1t3GvBA2DTM
 A6xyed6Sg+AjbMxsk6/dkBO5Ury1oc8qGPNcxKrfm5tGrjXvELwR7vVP4WCAWIzlHIES1HX/Cu
 MqI=
X-IronPort-AV: E=Sophos;i="5.63,481,1557158400"; 
   d="scan'208";a="212793229"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 13:48:00 +0800
IronPort-SDR: s9UjXmipDKgosrWBBPsRxGEjgQ9NCRg/ARzcfSPCCnZ39icXg0UCgG6PfIXrPpC3cTyFCUn9IW
 9oAnM8qHF9p5yBTy6eTDSRITpxta8v7YqENsllh4y0rGRTNR7m4U2ivt3luwHLMExoWywDAqFg
 Q0VkPhhfvAsHJGEkf8v9wU7C175ICA337Mg1huYppsxCBPp26k62yTiHOMZonKKYg+Fh6dMiwG
 PTCLC6Di9VKXdKgZCZ2kG+Z1bExRIejIEWJZfTUp2DXM71ahpuXVVc10TqTjERPOnsHEU+8uJ3
 sqlU7VQNIgiPBYLinuRxscEk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 11 Jul 2019 22:44:49 -0700
IronPort-SDR: 313OrxWLSUllI8cSKrpMXSlz7dgiG3qVqIKMWYrkV6i/sLYz5zdqmiCdMt6Yz2M+Zi+ANKXuRT
 asaTMF4Icm06nY/LO9fcBRTcCs1oVsr0Sk6SA0G315QMrWlwid63cnqmruM2qzLtwQeD8+M+PV
 +qQiRTApaNzjBfJu7l3Aj6aREDQGUdFLOnlxyzMdoKPXl/aJ3+miipd0z89hb5OZrSdunY5MFG
 +dwhRQscDzohUbXVJtE+OwwTvDVu8k4gv4voZSoo7awi8lHsK1zAJsdrBQf+arvWmgI13nRyPZ
 5y4=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 11 Jul 2019 22:46:12 -0700
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
Subject: [PATCH] x86/vdso, arm64/vdso: fix flip/flop vdso build bug
Date:   Fri, 12 Jul 2019 14:43:50 +0900
Message-Id: <20190712054350.12300-1-naohiro.aota@wdc.com>
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
("x86/boot: Fix if_changed build flip/flop bug").  We cannot use two
"if_changed" in one target. Fix this build bug by merging two commands
into one function.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 arch/arm64/kernel/vdso/Makefile |  6 ++++--
 arch/x86/entry/vdso/Makefile    | 12 ++++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 4ab863045188..068c614b1231 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -57,8 +57,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
 
 # Link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,ld)
-	$(call if_changed,vdso_check)
+	$(call if_changed,ld_and_vdso_check)
 
 # Strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -77,6 +76,9 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 quiet_cmd_vdsocc = VDSOCC   $@
       cmd_vdsocc = $(CC) $(a_flags) $(c_flags) -c -o $@ $<
 
+quiet_cmd_ld_and_vdso_check = LD      $@
+      cmd_ld_and_vdso_check = $(cmd_ld); $(cmd_vdso_check)
+
 # Install commands for the unstripped file
 quiet_cmd_vdso_install = INSTALL $@
       cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
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

