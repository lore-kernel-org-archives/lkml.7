Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E168C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF3E24067
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lDBVYM8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfE2SXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:23:34 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:47815 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2SXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:23:33 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c2fb5373;
        Wed, 29 May 2019 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=gYtRFTzPGPTPSkG9w5pOkEZn+Ho=; b=lDBVYM8WGc0FxLn08jwD
        nZgR+t9bpWIdm5oDXeDV+mP4rsRkT76wFFZUxDMIS2Uu+/5s/rDOpnw8S9lhdO4A
        /45dOCDJNbbnwrMM2xMEVIJy0XizNYAnSlOU6wnJiGSEBOdyVDciqhNRQHHgfM9T
        +rZXl69mtfOjsK6A+RmFJNVfwXDMj4sknWlfG9IWAEosSNEFevXzvBsM7JNLfdY0
        OdHr4EYjETQ14TOvHRoi92wXftInk7ivFN7TjB5P3VWMFTWCvDuuqPz8fmKXfXn3
        +JytPH4hYcawNt180N4YN4qXRBUMIvmH7aRGb1mmqovhIvuCQYgDmQ3PxmPCtb9b
        Xg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b8f6351b (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Wed, 29 May 2019 17:53:02 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm: vdso: pass --be8 to linker if necessary
Date:   Wed, 29 May 2019 20:23:24 +0200
Message-Id: <20190529182324.8140-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC)
to link VDSO") removed the passing of CFLAGS, since ld doesn't take
those directly. However, prior, big-endian ARM was relying on gcc to
translate its -mbe8 option into ld's --be8 option. Lacking this, ld
generated be32 code, making the VDSO generate SIGILL when called by
userspace.

This commit passes --be8 if CONFIG_CPU_ENDIAN_BE8 is enabled.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/vdso/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index fadf554d9391..1f5ec9741e6d 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -10,9 +10,10 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
 ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 
-ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
+ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
+ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
 	    -z max-page-size=4096 -z common-page-size=4096 \
-	    -nostdlib -shared \
+	    -nostdlib -shared $(ldflags-y) \
 	    $(call ld-option, --hash-style=sysv) \
 	    $(call ld-option, --build-id) \
 	    -T
-- 
2.21.0

