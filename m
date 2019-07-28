Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3927CC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AB92070D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfG1XLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:11:38 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34281 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfG1XLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:11:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so41748641wmd.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 16:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=42lghrV63bcshzCGKSHua5vo/hvXi8DHZoy6o0Cat9Y=;
        b=jWB3bc6fdbo45KZCZr0TSltGlAJQ7JPwZQoojUuy+QmCyJKd1ttabKaQ/tFXOG7OlE
         Fmee9RzlQH5WBffCd3+6RhG0tCwzXGNadXamrKGmMXzjH3vq/SoNGNPxC16koaSZl4a5
         UbcDwang3auCTaucvmPIMvk2Rk+0gY5M7MpIDM4nk2Ffd5A3fj7hdOYG4i7tiXKX37Q+
         1BQJU/wIpzcvgObzsWZY0Ehvx6MgTeHCIAhqfgtwkqUJhsi4E3OLYErJyT0b+cAoRocm
         x7+2UyBOJV8S2sy1n+ndnx8P0/plX4HoX0+lQkQ3dKP1rltQ7aAw6B9qlzvOLBojSCGJ
         CjwQ==
X-Gm-Message-State: APjAAAWw8rqunIthvijOzRItaiAviefcZ1EGyGG6NGYwgA9yDpHPnLDb
        PomenoVGcCl0zkjMNippSxv9ww==
X-Google-Smtp-Source: APXvYqxPo7htNk7ZRI5iDnM8YMA9X9gv9/VMPzCI4aNrd3OhZP9OppJEggWVfYxwOlqvknmBwBcY6A==
X-Received: by 2002:a1c:d10c:: with SMTP id i12mr96083615wmg.152.1564355496144;
        Sun, 28 Jul 2019 16:11:36 -0700 (PDT)
Received: from mcroce-redhat.homenet.telecomitalia.it (host221-208-dynamic.27-79-r.retail.telecomitalia.it. [79.27.208.221])
        by smtp.gmail.com with ESMTPSA id 4sm137778934wro.78.2019.07.28.16.11.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 16:11:35 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: module: mark expected switch fall-through
Date:   Mon, 29 Jul 2019 01:11:32 +0200
Message-Id: <20190728231132.6367-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark switch cases where we are expecting to fall through,
fixes the following warning:

arch/arm64/kernel/module.c: In function ‘apply_relocate_add’:
arch/arm64/kernel/module.c:316:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
    overflow_check = false;
    ~~~~~~~~~~~~~~~^~~~~~~
arch/arm64/kernel/module.c:317:3: note: here
   case R_AARCH64_MOVW_UABS_G0:
   ^~~~
arch/arm64/kernel/module.c:322:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
    overflow_check = false;
    ~~~~~~~~~~~~~~~^~~~~~~
arch/arm64/kernel/module.c:323:3: note: here
   case R_AARCH64_MOVW_UABS_G1:
   ^~~~
arch/arm64/kernel/module.c:328:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
    overflow_check = false;
    ~~~~~~~~~~~~~~~^~~~~~~
arch/arm64/kernel/module.c:329:3: note: here
   case R_AARCH64_MOVW_UABS_G2:
   ^~~~
arch/arm64/kernel/module.c:395:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
    overflow_check = false;
    ~~~~~~~~~~~~~~~^~~~~~~
arch/arm64/kernel/module.c:396:3: note: here
   case R_AARCH64_ADR_PREL_PG_HI21:
   ^~~~

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 arch/arm64/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/module.c b/arch/arm64/kernel/module.c
index 46e643e30708..ffd76b291af2 100644
--- a/arch/arm64/kernel/module.c
+++ b/arch/arm64/kernel/module.c
@@ -314,18 +314,21 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		/* MOVW instruction relocations. */
 		case R_AARCH64_MOVW_UABS_G0_NC:
 			overflow_check = false;
+			/* fallthrough */
 		case R_AARCH64_MOVW_UABS_G0:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 0,
 					      AARCH64_INSN_IMM_MOVKZ);
 			break;
 		case R_AARCH64_MOVW_UABS_G1_NC:
 			overflow_check = false;
+			/* fallthrough */
 		case R_AARCH64_MOVW_UABS_G1:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 16,
 					      AARCH64_INSN_IMM_MOVKZ);
 			break;
 		case R_AARCH64_MOVW_UABS_G2_NC:
 			overflow_check = false;
+			/* fallthrough */
 		case R_AARCH64_MOVW_UABS_G2:
 			ovf = reloc_insn_movw(RELOC_OP_ABS, loc, val, 32,
 					      AARCH64_INSN_IMM_MOVKZ);
@@ -393,6 +396,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			break;
 		case R_AARCH64_ADR_PREL_PG_HI21_NC:
 			overflow_check = false;
+			/* fallthrough */
 		case R_AARCH64_ADR_PREL_PG_HI21:
 			ovf = reloc_insn_adrp(me, sechdrs, loc, val);
 			if (ovf && ovf != -ERANGE)
-- 
2.21.0

