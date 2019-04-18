Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61DFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733D221479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uuivzEpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbfDRJ6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:58:44 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:60748 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbfDRJ6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:58:44 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x3I9vr8v025261;
        Thu, 18 Apr 2019 18:57:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x3I9vr8v025261
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1555581474;
        bh=iCYGPRLl0wMWGlvfN/1qveyRnyzRthbp0RuhN/AgD1c=;
        h=From:To:Cc:Subject:Date:From;
        b=uuivzEpDR9sO7dZaN8xUiUwpV1SdXTqb/WwsrIcwjTdDgPU6Ji/kHdEvpwK5xEjOG
         BLSEpE3aMfkt/ZbjPy4BaegAYlsf3tV+SxvjoW+Vp5FkvIKXuXXgBfWdct7CqfB0cy
         hXlRJqChxXBgQGdoha04r4ElOAcKTJhi6q+BonKPInPtGXuDDnCw+fW6g02/8FOxKr
         ij6ffpFwNug3pHpm8gEWb9ZQz1Uszbo6XQp50VvSdleeCklttRHRLN8uXPGkL4c/EO
         xOUQSEwJO4NVy16Ye9wc5N/Ta9JaB8FsDzUQWXOsAz+NJdZluBE+EuC9PIHqMkUdSi
         SIpa8plHj/3Iw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     patches@arm.linux.org.uk
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: vdso: use $(LD) instead of $(CC) to link VDSO
Date:   Thu, 18 Apr 2019 18:57:49 +0900
Message-Id: <20190418095749.21422-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use $(LD) to link vmlinux, modules, decompressors, etc.

VDSO is the only exceptional case where $(CC) is used as the linker
driver, but I do not know why we need to do so. VDSO uses a special
linker script, and does not link standard libraries at all.

I changed the Makefile to use $(LD) rather than $(CC). I confirmed
the same vdso.so.raw was still produced.

Users will be able to use their favorite linker (e.g. lld instead of
of bfd) by passing LD= from the command line.

My plan is to rewrite all VDSO Makefiles to use $(LD), then delete
cc-ldoption.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

KernelVersion: 5.1-rc5


 arch/arm/vdso/Makefile | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index f4efff9d3afb..fadf554d9391 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -10,12 +10,12 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-VDSO_LDFLAGS := -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=linux-vdso.so.1
-VDSO_LDFLAGS += -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
-VDSO_LDFLAGS += -nostdlib -shared
-VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
-VDSO_LDFLAGS += $(call cc-ldoption, -Wl$(comma)--build-id)
-VDSO_LDFLAGS += $(call cc-ldoption, -fuse-ld=bfd)
+ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
+	    -z max-page-size=4096 -z common-page-size=4096 \
+	    -nostdlib -shared \
+	    $(call ld-option, --hash-style=sysv) \
+	    $(call ld-option, --build-id) \
+	    -T
 
 obj-$(CONFIG_VDSO) += vdso.o
 extra-$(CONFIG_VDSO) += vdso.lds
@@ -37,8 +37,8 @@ KCOV_INSTRUMENT := n
 $(obj)/vdso.o : $(obj)/vdso.so
 
 # Link rule for the .so file
-$(obj)/vdso.so.raw: $(src)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,vdsold)
+$(obj)/vdso.so.raw: $(obj)/vdso.lds $(obj-vdso) FORCE
+	$(call if_changed,ld)
 
 $(obj)/vdso.so.dbg: $(obj)/vdso.so.raw $(obj)/vdsomunge FORCE
 	$(call if_changed,vdsomunge)
@@ -48,11 +48,6 @@ $(obj)/%.so: OBJCOPYFLAGS := -S
 $(obj)/%.so: $(obj)/%.so.dbg FORCE
 	$(call if_changed,objcopy)
 
-# Actual build commands
-quiet_cmd_vdsold = VDSO    $@
-      cmd_vdsold = $(CC) $(c_flags) $(VDSO_LDFLAGS) \
-                   -Wl,-T $(filter %.lds,$^) $(filter %.o,$^) -o $@
-
 quiet_cmd_vdsomunge = MUNGE   $@
       cmd_vdsomunge = $(objtree)/$(obj)/vdsomunge $< $@
 
-- 
2.17.1

