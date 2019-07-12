Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D7DC742B3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C4BE2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 10:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rT3Le7HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfGLKQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 06:16:50 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59063 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfGLKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 06:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1562926609; x=1594462609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PGuUZOvPqeH8cfH1ZCqYrXfrlJmayJeW4a2GOMCC7mE=;
  b=rT3Le7HZcsHYctZz4VGCYE1Vg3sdB96k8LundB3gOOM7F1bLBEjKc581
   sFSiuOsmclDbLrVtCk9d8F/VpnRLdFe77XkKawKbNVMdNC7XxUu4HKti6
   NW69pO206K6z/Mn+G40CyXZBkSBHXNFiWqaoXN5uh3n2jzSHn8hC+toLA
   NYoNA9QnkJj63No1T3IoJivh4lc+mh67FEmJxW6bgS5m2N9pPKJn/wcuB
   pjJGUDMRgUG1UalayhWydheLPSK7zXCCLQ5zDSJT5rwcxXJxQoWlXBjv3
   NCqcVSJUILJkuUiifLn9hAbk7opA1v7IbdB0gUssR37hyDDNjbgSxM/6L
   A==;
IronPort-SDR: JNQiCm34if0ePkdGSH1at57VdFRYOfO1lZ/GUb/u7jvJyaUdfc03xb+/E16G83GV6smniIs2Z0
 qbkQjpjj2aIiklUTfv3Bv8nWSu5XrfdRZ12aLl3P1COlRW/t2IyiBrAhONF6ApoHQQOQpuYgSi
 oJC9Jc7mWR6EGKrHOAOcDg/IVNYAmAFOJgPKWaTcdw86ULCYiht8YSn19Qzr0cMcHZSterfgfl
 9ZNR2p+apQdItMFSTQnt/6Vke82JsmThEjDM7g6nHMkUpzWVpM1/YOhHiHXJ+E2LIyeNqIHlZa
 BCo=
X-IronPort-AV: E=Sophos;i="5.63,482,1557158400"; 
   d="scan'208";a="219302724"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2019 18:16:49 +0800
IronPort-SDR: 9Iq5dxu1LzmIjjhcdKdRIwTi919HAGNutd2OpOq9aye9MoMhnLIbPPu+cqg93yJDg34ByDc7eA
 9jxgt2LDxnJqwsytobJE5OdediRoHsnfvFHJXhwtq59+vCy3iSRyKXUljyP+Kj8/SkdeTexF6j
 V9MkQZncpmNkp440ehraW6i0aA0c0tEzgiz7VpGW+sOBx4tom5gid5B+/QhDMvw9IPnq/1ZeNX
 CoiKt7R/FQY30UqOjLE91nXnHGnoJRB8g/nXqSutrp8F6Xqu6K5eI1xWSZwkcRLU4WmMkldQMv
 LeJ99++PqBkXHefGgJ2cMvG5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 12 Jul 2019 03:15:31 -0700
IronPort-SDR: bRBvx4E7fSDpWJTso1KTOfIWHdz7gAqqjueqfEORwydlIAUkrEAaWYLnznr8SdQ9nM3pPIuML3
 YfhvGb9/ueFfK+/grzW32AXWDxuhzc4FC6WpCN2NLKo8q4CpwB8kQZvaUIipt9fvjrRGIVuuVC
 vMfCEvWWeEZ+NDm4AAadLLWJiU5B9P7Q8QJhDxTj+sZRxUH7tVCbe6kcofwK0i8rpmokhvpCWQ
 nbKluPVuuhggE20FWOojHejOnepS9YeKvcpJC2L6ixwcc0Wl7TSW6h/h44yu/kq//kMA9jeTsP
 tKI=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Jul 2019 03:16:48 -0700
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
Subject: [PATCH v2 2/2] arm64/vdso: fix flip/flop vdso build bug
Date:   Fri, 12 Jul 2019 19:15:56 +0900
Message-Id: <20190712101556.17833-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712101556.17833-1-naohiro.aota@wdc.com>
References: <20190712101556.17833-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running "make" on an already compiled kernel tree will rebuild the kernel
even without any modifications:

$ make ARCH=arm64 CROSS_COMPILE=/usr/bin/aarch64-unknown-linux-gnu-
arch/arm64/Makefile:58: CROSS_COMPILE_COMPAT not defined or empty, the compat vDSO will not be built
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  VDSOCHK arch/arm64/kernel/vdso/vdso.so.dbg
  VDSOSYM include/generated/vdso-offsets.h
  CHK     include/generated/compile.h
  CC      arch/arm64/kernel/signal.o
  CC      arch/arm64/kernel/vdso.o
  CC      arch/arm64/kernel/signal32.o
  LD      arch/arm64/kernel/vdso/vdso.so.dbg
  OBJCOPY arch/arm64/kernel/vdso/vdso.so
  AS      arch/arm64/kernel/vdso/vdso.o
  AR      arch/arm64/kernel/vdso/built-in.a
  AR      arch/arm64/kernel/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  UPD     include/generated/compile.h
  CC      init/version.o
  AR      init/built-in.a
  LD      vmlinux.o

This is the same bug fixed in commit 92a4728608a8 ("x86/boot: Fix
if_changed build flip/flop bug"). We cannot use two "if_changed" in one
target. Fix this build bug by merging two commands into one function.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Fixes: 28b1a824a4f4 ("arm64: vdso: Substitute gettimeofday() with C implementation")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 arch/arm64/kernel/vdso/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

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
-- 
2.22.0

