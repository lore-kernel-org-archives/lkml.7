Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6CBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C906120863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 23:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="FbW1sLSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbfCBXHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 18:07:39 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:42858 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfCBXHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 18:07:38 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465:0:5054:ff:fe4f:85bd])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id E5CA95C23AE;
        Sun,  3 Mar 2019 00:07:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551568057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CXhK/FBjan7/N7CuPcIKHePaIsXcmL2rMJadcisJ42g=;
        b=FbW1sLSUZGB/5mcjEJfKLD7zYpxDuuVZ4e+4JuvLMitiiIh/1sba4g7fwe3of70c+PsKeN
        TGR9JaWyZSezbHQR/hivsxJ7ZwAWpGsxFtCPLHlZ1OcqMld7g5YWI/oy9NaRKjmw6F2l2R
        y+Pb4m7e0Ms9JdrjLh4Hx54OcsYD7wg=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     ndesaulniers@google.com, natechancellor@gmail.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, nicolas.pitre@linaro.org,
        thierry.reding@gmail.com, will.deacon@arm.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 2/2] ARM: uaccess: use unified assembler language syntax
Date:   Sun,  3 Mar 2019 00:08:19 +0100
Message-Id: <9a4f9da0615ec658512dd334d931b5acd947ac5d.1551567941.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1ed0a317c3e9ae1cdd1b05fad5e1bd13a58a9036.1551567941.git.stefan@agner.ch>
References: <1ed0a317c3e9ae1cdd1b05fad5e1bd13a58a9036.1551567941.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the conditional infix to a postfix to make sure this inline
assembly is unified syntax. Since gcc assumes non-unified syntax
when emitting ARM instructions, make sure to define the syntax as
unified.

This allows to use LLVM's integrated assembler.

Additionally, for GCC ".syntax unified" for inline assembly.
When compiling non-Thumb2 GCC always emits a ".syntax divided"
at the beginning of the inline assembly which makes the
assembler fail. Since GCC 5 there is the -masm-syntax-unified
GCC option which make GCC assume unified syntax asm and hence
emits ".syntax unified" even in ARM mode. However, the option
is broken since GCC version 6 (see GCC PR88648 [1]). Work
around by adding ".syntax unified" as part of the inline
assembly.

[0] https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html#index-masm-syntax-unified
[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=88648

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
I missed this instance in my previous commits and realized only
after running some randconfig.

 arch/arm/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 89a28680934b..18303bcc9990 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -113,10 +113,11 @@ static inline void __user *__uaccess_mask_range_ptr(const void __user *ptr,
 	unsigned long tmp;
 
 	asm volatile(
+	"	.syntax unified\n"
 	"	sub	%1, %3, #1\n"
 	"	subs	%1, %1, %0\n"
 	"	addhs	%1, %1, #1\n"
-	"	subhss	%1, %1, %2\n"
+	"	subshs	%1, %1, %2\n"
 	"	movlo	%0, #0\n"
 	: "+r" (safe_ptr), "=&r" (tmp)
 	: "r" (size), "r" (current_thread_info()->addr_limit)
-- 
2.20.1

