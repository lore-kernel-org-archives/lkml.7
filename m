Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CC6C742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFC32166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfGLJIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:08:55 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:39345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfGLJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:08:55 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MplTn-1iG0uE1AyL-00qEvZ; Fri, 12 Jul 2019 11:08:19 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Bill Metzenthen <billm@melbpc.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] x86: math-emu: hide clang warnings for 16-bit overflow
Date:   Fri, 12 Jul 2019 11:08:05 +0200
Message-Id: <20190712090816.350668-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uhLktPXipGj6UjosCrqPbx7X8MXcIoq8JHYIteyEjX5+chvN09m
 nduPEVAS3tXz5QEMuMJoSbjgSPxubfKqoNq9gelCGmZ4qUcJyCjVAX9IlCU44FSmVGd0kOY
 tJC59GiELBqUb7DBFtQomOTdVxux6lsCsNW2atgevOUK1GdUy3EXPCSuoI8GapZZHRoahDN
 1qkYo7cqbXOMbc9IYCY+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o6PG+rhksf0=:NUqwYYsc9m85a6HXmY8xe4
 7zgquXhqavLN5KLe0gnzkonSgYCYfpwXzsxMl0eFOuLzOu+AmbiF1os3kde3o9QMlRDdYumbJ
 U3zYPXsHexYZK87gPKiAYu0UlXwb9dmWNtnQeHaDDejnbTwK0SkHWPW+6ZSbCXQxgOoJr0+Eb
 tCt8/zLTRmC+aLS7az9vebwvzcp+/1AN45cOLO4lCW3DZwI0fwZRFMAsaVk2xO8cGoVQlHP1F
 izhaIeYKUPmyg/MCGRB80t+z2RpHp35cRsx6wBSKplzaVKxYKqz3qA9mJqfhMDnhFezfnwosc
 +n3gHYuXWeK0/CWg1WFf64huWV9nX7MrLNzf4gCDAFNK1T0SuavAc/tNRqSr18PEjOEHGtBDi
 Gp20XDw0xEfJ7BX7twyKru3tqq26WA8Gn2SoGqSZwskmYbHZSbQWRIZscitRClxy4xC5fCazT
 /Me3/1RnoFTttx6qvNalRXsIkOO/XI/pFY54+VNbI0zeQxPOxSRCXuyNMYqfFZb3KxTCn5zsD
 GX+bLZ/LV0w78NeLYXeNZgERNjsdsspk3kZd0NZKed+Ux6zxMT1zFBDtCztzauJPyPMN8ODdq
 wQ4FfXIXq7L5kU53y0I7PEnVoZ1dHnAkQrVAu44rrqgzd0sscFCNTf/3oP9EW+TejYK0+jEMJ
 peMJ5gky6ORCtVi8E2v8TNS9GMB00r8VJUivNYTaWwRe6iH/PakRraYWVOOsnXgOyyOaANonm
 XmYI7hDW5Jc6WDJkl6UUgJPbeK5jFBGXwwLhZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns about a few parts of the math-emu implementation
where a 16-bit integer becomes negative during assignment:

arch/x86/math-emu/poly_tan.c:88:35: error: implicit conversion from 'int' to 'short' changes value from 49216 to -16320 [-Werror,-Wconstant-conversion]
                                      (0x41 + EXTENDED_Ebias) | SIGN_Negative);
                                      ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~
arch/x86/math-emu/fpu_emu.h:180:58: note: expanded from macro 'setexponent16'
 #define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (y); }
                                                      ~  ^
arch/x86/math-emu/reg_constant.c:37:32: error: implicit conversion from 'int' to 'short' changes value from 49085 to -16451 [-Werror,-Wconstant-conversion]
FPU_REG const CONST_PI2extra = MAKE_REG(NEG, -66,
                               ^~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_constant.c:21:25: note: expanded from macro 'MAKE_REG'
                ((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_constant.c:48:28: error: implicit conversion from 'int' to 'short' changes value from 65535 to -1 [-Werror,-Wconstant-conversion]
FPU_REG const CONST_QNaN = MAKE_REG(NEG, EXP_OVER, 0x00000000, 0xC0000000);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/math-emu/reg_constant.c:21:25: note: expanded from macro 'MAKE_REG'
                ((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~

The code seems correct to me, so add a typecast to shut up the warnings.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/math-emu/fpu_emu.h      | 2 +-
 arch/x86/math-emu/reg_constant.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/math-emu/fpu_emu.h b/arch/x86/math-emu/fpu_emu.h
index a5a41ec58072..0c122226ca56 100644
--- a/arch/x86/math-emu/fpu_emu.h
+++ b/arch/x86/math-emu/fpu_emu.h
@@ -177,7 +177,7 @@ static inline void reg_copy(FPU_REG const *x, FPU_REG *y)
 #define setexponentpos(x,y) { (*(short *)&((x)->exp)) = \
   ((y) + EXTENDED_Ebias) & 0x7fff; }
 #define exponent16(x)         (*(short *)&((x)->exp))
-#define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (y); }
+#define setexponent16(x,y)  { (*(short *)&((x)->exp)) = (u16)(y); }
 #define addexponent(x,y)    { (*(short *)&((x)->exp)) += (y); }
 #define stdexp(x)           { (*(short *)&((x)->exp)) += EXTENDED_Ebias; }
 
diff --git a/arch/x86/math-emu/reg_constant.c b/arch/x86/math-emu/reg_constant.c
index 8dc9095bab22..742619e94bdf 100644
--- a/arch/x86/math-emu/reg_constant.c
+++ b/arch/x86/math-emu/reg_constant.c
@@ -18,7 +18,7 @@
 #include "control_w.h"
 
 #define MAKE_REG(s, e, l, h) { l, h, \
-		((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
+		(u16)((EXTENDED_Ebias+(e)) | ((SIGN_##s != 0)*0x8000)) }
 
 FPU_REG const CONST_1 = MAKE_REG(POS, 0, 0x00000000, 0x80000000);
 #if 0
-- 
2.20.0

