Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A44C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FC92184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="iIeEZvto"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfDKJbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:31:34 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:48911 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKJbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:31:34 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x3B9ULYI018071;
        Thu, 11 Apr 2019 18:30:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x3B9ULYI018071
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554975021;
        bh=pamsHavWO/HjsWP8UtMBGwElWsTCMSpe/5Xz6rV18G0=;
        h=From:To:Cc:Subject:Date:From;
        b=iIeEZvtoUpr1/SIBNhL45jIZd/+85UWQbxMGYM88BUOXLF3oeTjzx2RBVZyeFNR3o
         Bg2BXC4gbUuo3F5IGBFqpZtTbstSWwK8ZV2Tf3I8xnQBAOM006PbzSLAuGYvml9X8k
         nHPxCRCzmSq8DS1RE2kQf8HJZcM9jfn1eIEXWUK8fu8vg4NAXdXWI6ZK/B15+Dolpr
         /WfHsrW2gzwqe3IOoMfGpy7/86vlfbhI9Xxvx6e1EmkM9c57T8tYdp/pRWUt6TQAVy
         q6b18KrxzvMnP+qk+Tb/nMWrS9azCjdB4Wa8Gs2chIjyg5kM9zLsBm/l8neEI9Fjtm
         dELs+eubnXlBA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: vdso: use $(LD) instead of $(CC) to link VDSO
Date:   Thu, 11 Apr 2019 18:30:15 +0900
Message-Id: <20190411093015.6529-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We use $(LD) to link vmlinux, modules, decompressors, etc.

VDSO is the only exceptional case where $(CC) is used as the linker
driver, but I do not know why we need to do so. VDSO uses a special
linker script, and does not link standard libraries at all.

I changed the Makefile to use $(LD) rather than $(CC). I tested this,
and VDSO worked for me.

Users will be able to use their favorite linker (e.g. lld instead of
of bfd) by passing LD= from the command line.

My plan is to rewrite all VDSO Makefiles to use $(LD), then delete
cc-ldoption.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/kernel/vdso/Makefile | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index a0af6bf6c11b..744b9dbaba03 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -12,17 +12,12 @@ obj-vdso := gettimeofday.o note.o sigreturn.o
 targets := $(obj-vdso) vdso.so vdso.so.dbg
 obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 
-ccflags-y := -shared -fno-common -fno-builtin
-ccflags-y += -nostdlib -Wl,-soname=linux-vdso.so.1 \
-		$(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
+ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 \
+		$(call ld-option, --hash-style=sysv) -n -T
 
 # Disable gcov profiling for VDSO code
 GCOV_PROFILE := n
 
-# Workaround for bare-metal (ELF) toolchains that neglect to pass -shared
-# down to collect2, resulting in silent corruption of the vDSO image.
-ccflags-y += -Wl,-shared
-
 obj-y += vdso.o
 extra-y += vdso.lds
 CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
@@ -32,7 +27,7 @@ $(obj)/vdso.o : $(obj)/vdso.so
 
 # Link rule for the .so file, .lds has to be first
 $(obj)/vdso.so.dbg: $(obj)/vdso.lds $(obj-vdso) FORCE
-	$(call if_changed,vdsold)
+	$(call if_changed,ld)
 
 # Strip rule for the .so file
 $(obj)/%.so: OBJCOPYFLAGS := -S
@@ -52,8 +47,6 @@ $(obj-vdso): %.o: %.S FORCE
 	$(call if_changed_dep,vdsoas)
 
 # Actual build commands
-quiet_cmd_vdsold = VDSOL   $@
-      cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $(real-prereqs) -o $@
 quiet_cmd_vdsoas = VDSOA   $@
       cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
 
-- 
2.17.1

