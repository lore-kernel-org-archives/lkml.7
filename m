Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A10C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 980FD20842
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=golovin.in header.i=@golovin.in header.b="ucwdZ079"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKJPhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:37:12 -0500
Received: from forward104j.mail.yandex.net ([5.45.198.247]:55889 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726653AbfKJPhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 10:37:12 -0500
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Nov 2019 10:37:11 EST
Received: from forward103q.mail.yandex.net (forward103q.mail.yandex.net [IPv6:2a02:6b8:c0e:50:0:640:b21c:d009])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 5D05A4A11C7;
        Sun, 10 Nov 2019 18:31:47 +0300 (MSK)
Received: from mxback7q.mail.yandex.net (mxback7q.mail.yandex.net [IPv6:2a02:6b8:c0e:41:0:640:cbbf:d618])
        by forward103q.mail.yandex.net (Yandex) with ESMTP id 5572161E0005;
        Sun, 10 Nov 2019 18:31:47 +0300 (MSK)
Received: from vla5-9cb0c276d29e.qloud-c.yandex.net (vla5-9cb0c276d29e.qloud-c.yandex.net [2a02:6b8:c18:3588:0:640:9cb0:c276])
        by mxback7q.mail.yandex.net (mxback/Yandex) with ESMTP id FSAetauLC0-VkeGYqD8;
        Sun, 10 Nov 2019 18:31:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=golovin.in; s=mail; t=1573399907;
        bh=J9gGtCi1bqhoTbjtK0ZLFDb2RPEmtebHwiHCJTTfQV4=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=ucwdZ079I8uW6r0LnYZ6jCy87vyQV/a6SlR1OCEI9A8r0pCWur7Fsl0l1ylRp3pRs
         hP2VnvyYLwr+9Ubr+KsA9K644hmpAFsP8dQgaVC+IVoJ/+OYI1CBDuoxmim/V8pnOf
         n9wWCRy2u1z8KR2O7Nx/GutWx28wD4GXy0+pyx10=
Authentication-Results: mxback7q.mail.yandex.net; dkim=pass header.i=@golovin.in
Received: by vla5-9cb0c276d29e.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 5WwNymo0nq-Vi0mgFID;
        Sun, 10 Nov 2019 18:31:45 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Dmitry Golovin <dima@golovin.in>
Cc:     Dmitry Golovin <dima@golovin.in>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Maennich <maennich@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] ARM: kbuild: use correct nm executable
Date:   Sun, 10 Nov 2019 17:30:39 +0200
Message-Id: <20191110153043.111710-1-dima@golovin.in>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since $(NM) variable can be easily overridden for the whole build, it's
better to use it instead of $(CROSS_COMPILE)nm. The use of $(CROSS_COMPILE)
prefixed variables where their calculated equivalents can be used is
incorrect. This fixes issues with builds where $(NM) is set to llvm-nm.

Link: https://github.com/ClangBuiltLinux/linux/issues/766
Signed-off-by: Dmitry Golovin <dima@golovin.in>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Cc: Matthias Maennich <maennich@google.com>
---
 arch/arm/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 9219389bbe61..a1e883c5e5c4 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -121,7 +121,7 @@ ccflags-y := -fpic $(call cc-option,-mno-single-pic-base,) -fno-builtin -I$(obj)
 asflags-y := -DZIMAGE
 
 # Supply kernel BSS size to the decompressor via a linker symbol.
-KBSS_SZ = $(shell echo $$(($$($(CROSS_COMPILE)nm $(obj)/../../../../vmlinux | \
+KBSS_SZ = $(shell echo $$(($$($(NM) $(obj)/../../../../vmlinux | \
 		sed -n -e 's/^\([^ ]*\) [AB] __bss_start$$/-0x\1/p' \
 		       -e 's/^\([^ ]*\) [AB] __bss_stop$$/+0x\1/p') )) )
 LDFLAGS_vmlinux = --defsym _kernel_bss_size=$(KBSS_SZ)
@@ -165,7 +165,7 @@ $(obj)/bswapsdi2.S: $(srctree)/arch/$(SRCARCH)/lib/bswapsdi2.S
 # The .data section is already discarded by the linker script so no need
 # to bother about it here.
 check_for_bad_syms = \
-bad_syms=$$($(CROSS_COMPILE)nm $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
+bad_syms=$$($(NM) $@ | sed -n 's/^.\{8\} [bc] \(.*\)/\1/p') && \
 [ -z "$$bad_syms" ] || \
   ( echo "following symbols must have non local/private scope:" >&2; \
     echo "$$bad_syms" >&2; false )
-- 
2.23.0

