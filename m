Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E36C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4C420705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 14:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgAHOiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 09:38:16 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:35845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgAHOiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 09:38:15 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MC2o9-1iymor10Tl-00CVYi; Wed, 08 Jan 2020 15:36:44 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ard.biesheuvel@linaro.org, james.morse@arm.com, rabin@rab.in,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm/ftrace: fix building on BE32
Date:   Wed,  8 Jan 2020 15:36:30 +0100
Message-Id: <20200108143640.1034808-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DNg/f0DgH2AuFmls4CuTuds+KyudRqDqzfh6viVMfvvGdk8u9Q0
 yf8f7lprW7tAoIgat71ySCreHfiHJ7a5EY2p18mcMrgmgGEusFJ2Rrv8CsB/Ny/NyVIb4/H
 DGohQLlUBZmTTu2qasznjvrU7nxq3aTas5zlEKj5QdHDUqZ/6Lni94HX/qlXoZi7UJe6wZN
 SZqt2en9FiTgT8KNvLZyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WFVEuGhsmHc=:5Ehnd9BB2/wv3L7ZBxOOvK
 mBdj2KEKMtBAdFCvY2s40Q0UYqQsPm6WgiazzK3pEpOVb/GxiSZ303UtK2p7YHf9T8aptaISS
 tFgKevI6rbeQYrGBRMSDKZQo6/4HQ6LUPFpD1Wl3/y+j9YLyPyMASie8IbgG66er9A6CP66Gh
 rqLsDX92RbSBROptuOQvte6u0DmBzb740TgAybw8BBSWzOreRtrxPZVxCqAJh1cOPkCHYEKf2
 +OzUY2/KeHDE0kfnz7u/Nz0IrtuS5j9FY8ck64ssj/FBt9Qs4/DAWMlRg6tLT4/OW0Oh2cFMk
 M0UXudFGyWfwJQTUgNPkpE4LgUTHkbCoOoA30eLL82nHNavUgIuCUi6DEWyPaTRUthkvU40nE
 9D/RH80jyejtR2/gGXmaPuXNFJu1REfPrs/03nqv5ECbkF/oDdYZEIT1PMjkEKMjVSU2OOOGn
 YArsYMaOGmywUc4nFK1Mlj+wc9P4YAtW35LedEY5+lOr4+l9TnHw10ze2h/IAii82/AAZ17Tv
 Eb9ERvxeJ1gy1Y/0cKhUKH1+onKYwHaibjqu6+4hjm+BJlwbxO6gs8w5AapcKxFFTxf3/NTA3
 GCQmgyEBVWQYUM3O886BshWTgLmAMN/0gj3p+eBWck5PeDJnG3fjPQ2VJqWJQf42zEMYd7zrs
 An4ndfsWn0eHKchauHovwoUwasGxBJdHwOZblS4J7qzGXF/Jw1Z2ee1K2hMKDiNSGsdf8Fi/w
 JWwn7D3ieXPbYhCUNVYgbfxQxZO42Cwvye018COjOKoCuZeVTHqIvRJeViNOcC42iDmOKQR8a
 T9CuH0XYQgH3JoN6YVdGxAaDh7mCAaBwyO7DpF02xwGMgjkgmbdL2APK7dVUwXm9HRexhivu9
 EgbBF0i++dXX0ftUQ5nA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling patch.c on BE32 fails because there is no definition
of __opcode_to_mem_thumb32()

arch/arm/kernel/patch.c: In function '__patch_text_real':
arch/arm/kernel/patch.c:94:11: error: implicit declaration of function '__opcode_to_mem_thumb32' [-Werror=implicit-function-declaration]

Since we don't actually call it, only a declaration is required
here, add one without a definition that fixes the build here
but will cause a link failure if someone actually relies on the
result.

Fixes: 5a735583b764 ("arm/ftrace: Use __patch_text()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Not sure if this version is any less ugly than the first
approach of adding an #ifdef in patch.c
---
 arch/arm/include/asm/opcodes.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 6bff94b2372b..f75f59c1257a 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -110,14 +110,19 @@ extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #define __opcode_to_mem_thumb16(x) ___opcode_identity16(x)
 #define ___asm_opcode_to_mem_arm(x) ___asm_opcode_identity32(x)
 #define ___asm_opcode_to_mem_thumb16(x) ___asm_opcode_identity16(x)
-#ifndef CONFIG_CPU_ENDIAN_BE32
 /*
  * On BE32 systems, using 32-bit accesses to store Thumb instructions will not
  * work in all cases, due to alignment constraints.  For now, a correct
- * version is not provided for BE32.
+ * version is not provided for BE32, only an extern declaration to allow
+ * compiling patch.c
  */
+#ifndef CONFIG_CPU_ENDIAN_BE32
 #define __opcode_to_mem_thumb32(x) ___opcode_swahw32(x)
 #define ___asm_opcode_to_mem_thumb32(x) ___asm_opcode_swahw32(x)
+#else
+#ifndef __ASSEMBLY__
+extern unsigned __opcode_to_mem_thumb32(unsigned);
+#endif
 #endif
 
 #endif /* ! CONFIG_CPU_ENDIAN_BE8 */
-- 
2.20.0

