Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E365C73C46
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 260EB2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 18:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfGISpZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 14:45:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51369 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfGISpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 14:45:24 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mt7Pt-1idzjz2DuL-00tTez; Tue, 09 Jul 2019 20:45:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH] [v2] ARM: mtd-xip: work around clang/llvm bug
Date:   Tue,  9 Jul 2019 20:44:57 +0200
Message-Id: <20190709184509.2967503-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nUy/ge+wQYWTJFpTzajM48Zt0XR341x3ye6BHYNlezP3zD2R+Fl
 9o2NckE1O/IEMT9a7C+mPH6dOzZoanf6JBnCRem3dzLHQdHaEH0N3O5xdEcipjjfHjOj2N0
 O7du1CzjrDYrslT9HuNZjZwGI495tjDa33+cZu5GaujvauGiFl5jc6/ophvmYrq0SQrZNbO
 qZkUbiefWFywNY3tMYg5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gXOCuUaHk4U=:Bjom7hSzoUeYR7ZcaDToJH
 4hzyP0frf+d8a0d3kDrqFN9l57bKYZ67+WdHuGmFw7N9H00MKb1CGwSSYQLA5GBsCZYnSaydr
 VIwvJpqEAm9L2F45SMuqdYvsmgOhCmzaUL+EvxzWwYa2fViA8NDeHEEJyig6PMv9nKBANOJBo
 cM36r3OY1tra8vryoR8O+jYtIwNDSK9OMXIysfgbX/m+eoMqE+uTuHMbqIH6aTDB9ZOoYeU3d
 XcBt2/UYEsH6P25b/I8PcoakPqJJHxsayXhuhUMABppUPtVAOO6+npJtAVoq2zcTDDRuLovwR
 P9CbUH0wZKP7tGDCxkIxLiGoW0bf7f8Z9zUoDA6UDg15JVUp6Ib8reA07Kpm21YTtK4dYCj5d
 TODaXMOTPnMB04IvykU86zxyDeJuKDc+nsff37sv9ANTB5lBlBEnqVAmy3cIAazdsfcqLs5xZ
 k+QxitwDSj4xSkc+bJcR65wuk4IQ1nIWsjnNv1qgS3hccMrwUOvOKoQHZq+EvzJAL+zY/fMj4
 faaXseke75b5Boo7KG6/3ikiDhL/2UF22hEKb0K2GG3Ls6g4nnK/I/ESEB5QECfhDenHiKX1b
 blkFztg6R+hg+0a7SFEV+kKX+7iRdA5gyNrQDtZuGqiRrd7ylCbBDzliYt5qkXPe1WdX0HD+v
 HjoTH26jlsGx07wMjFunU9DgZh6dv4PGolGG4HK6K3oOJ2o0PaE0VxITdhxWSc00/zsmE0EPk
 79gGnYlxlR/AYisnh60ip+o2+o5EPNtB3q6W8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

llvm gets confused by inline asm with .rep directives, which
can lead to miscalculating the number of instructions inside it,
and in turn lead to an overflow for relative address calculation:

/tmp/cfi_cmdset_0002-539a47.s: Assembler messages:
/tmp/cfi_cmdset_0002-539a47.s:11288: Error: bad immediate value for offset (4100)
/tmp/cfi_cmdset_0002-539a47.s:11289: Error: bad immediate value for offset (4100)

This might be fixed in future clang versions, but is not hard
to work around by just replacing the .rep with a series of
eight unrolled nop instructions.

As Russell points out, the original code uses an undocumented
assembler directive, as .rep is normally spelled .rept, though
the shorter form is common on arch/x86 as well.

Link: https://bugs.llvm.org/show_bug.cgi?id=42539
Link: https://godbolt.org/z/DSM2Jy
Acked-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: mention .rep/.rept
    add missing "Link:" keyword.
---
 arch/arm/include/asm/mtd-xip.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/mtd-xip.h b/arch/arm/include/asm/mtd-xip.h
index dfcef0152e3d..5ad0325604e4 100644
--- a/arch/arm/include/asm/mtd-xip.h
+++ b/arch/arm/include/asm/mtd-xip.h
@@ -15,6 +15,8 @@
 #include <mach/mtd-xip.h>
 
 /* fill instruction prefetch */
-#define xip_iprefetch() 	do { asm volatile (".rep 8; nop; .endr"); } while (0)
+#define xip_iprefetch()	do {						\
+	 asm volatile ("nop; nop; nop; nop; nop; nop; nop; nop;");	\
+} while (0)								\
 
 #endif /* __ARM_MTD_XIP_H__ */
-- 
2.20.0

