Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897D7C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542832084F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="lSdKS8NJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCQXFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:05:35 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:58964 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfCQXFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 19:05:35 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::564])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 6EFCA5C0D18;
        Mon, 18 Mar 2019 00:05:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1552863933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=NNacmohDY8QaFKTP29fc7SErMbZgJCv6ERX09++33yM=;
        b=lSdKS8NJ95pzEg3ovBK2als63igadCOM4ZLTUrOdZpbZlNUBHR8cvTGC4DuavdKWIXYLad
        yZ+QMWgHSJwxK67ZTFLMuTBoDKeLPafdsnA/WxLEXpI6q/HqGPt5jf1892s2ON4ifW0USK
        vVb00RJ29m6YfxBLpgeEUoA5AqvF0dA=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     robin.murphy@arm.com, will.deacon@arm.com, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        nicolas.pitre@linaro.org, thierry.reding@gmail.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 1/2] ARM: drop WASM to work around LLVM issue
Date:   Mon, 18 Mar 2019 00:05:26 +0100
Message-Id: <e3f3bf27430712ee88c0b600f3d62cb86d327b75.1552863571.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently LLVM's integrated assembler does not recognize .w form
of the pld instructions (LLVM Bug 40972 [0]):

  ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
                          "pldw.w\t%a0 \n"
                           ^
  <inline asm>:2:1: note: instantiated into assembly here
  pldw.w  [r0]
  ^
  1 error generated.

The W macro for generating wide instructions when targeting Thumb-2
is not strictly required for the preload data instructions (pld, pldw)
since they are only available as wide instructions. The GNU assembler
works with or without the .w appended when compiling an Thumb-2 kernel.

Drop the macro to work around LLVM Bug 40972 issue.

[0] https://bugs.llvm.org/show_bug.cgi?id=40972

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
Changes in v2:
- Reword commit message to reflect the fact that this is a work around
  for LLVM.

 arch/arm/include/asm/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 57fe73ea0f72..5d06f75ffad4 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -135,8 +135,8 @@ static inline void prefetchw(const void *ptr)
 	__asm__ __volatile__(
 		".arch_extension	mp\n"
 		__ALT_SMP_ASM(
-			WASM(pldw)		"\t%a0",
-			WASM(pld)		"\t%a0"
+			"pldw\t%a0",
+			"pld\t%a0"
 		)
 		:: "p" (ptr));
 }
-- 
2.21.0

