Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E8DC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D666D2184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fu0pN7Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfDKJba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:31:30 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:31118 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfDKJb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:31:29 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id x3B9TtpK023735;
        Thu, 11 Apr 2019 18:29:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com x3B9TtpK023735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1554974996;
        bh=cR0BcHB4II9sS744pV1/BqkrB8S9Q7JJv9+ER0XDJFk=;
        h=From:To:Cc:Subject:Date:From;
        b=fu0pN7NkSbPJLn/v4mXFTFZbCP3+SPB7p45YW3PlI2ryHu0+LPTrisRF1CuvsBAef
         OhbiS2EbdFH/VHjjfgnNNLe8Umg8dVmXjhZGRQ1Ui7FiiFI/J8DyS0cpEYunKtlIza
         st77sUTH2Gbl/ExXVDfdmoDME09IPOO+wWavoqaG4qSetLiGitszsoMpCKTTmq87gp
         RNjpZMGbbF07k9KHQAJgKh6CFhsplu/JO3lwa1jiWWDbB16ZplobwmUXDbg5ufgSoN
         EQcn8w7vrfK+aPyYBvEGFX4tm3YjsKKNmcfVLO2/SGHTrry8AFV4024J46+OcdHWKU
         Fv1WrXvDDCP1w==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH] ARM: vdso: use $(LD) instead of $(CC) to link VDSO
Date:   Thu, 11 Apr 2019 18:29:33 +0900
Message-Id: <20190411092933.6413-1-yamada.masahiro@socionext.com>
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
---

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

