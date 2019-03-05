Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6E2C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F081620675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="CERV/X50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfCEWRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:17:38 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:57038 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfCEWRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:17:38 -0500
Received: from zyt.lan (unknown [IPv6:2a02:169:3465:0:5054:ff:fe4f:85bd])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id ACDC85C0089;
        Tue,  5 Mar 2019 23:17:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1551824256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=BhPOyo0jn/O7Sy5qMeouEojl4oA0Rax7qDdY/h4DGZs=;
        b=CERV/X502pnbiqwcd5ykIisV7jDSf4TcT94RuftRlotp3Be5P3oq3EJvk9ZCjaEX6gMIjb
        ZuALtGs1xDEMmJmT4itKKiw1HrBE5SICurjvNqsB/os9yRRWeHCKNJTrOfSPz4ZDSs2gmj
        e9/zIBEQAowx21hcPUPYdS3v9c2wcSE=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     will.deacon@arm.com, ndesaulniers@google.com,
        natechancellor@gmail.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        nicolas.pitre@linaro.org, thierry.reding@gmail.com,
        julien.thierry@arm.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/2] ARM: drop unnecessary WASM
Date:   Tue,  5 Mar 2019 23:18:26 +0100
Message-Id: <13835555f8ef44b21d1b7ddfe1c4203d0981f77e.1551824161.git.stefan@agner.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The W macro for generating wide instructions when targeting Thumb-2
is not required for the preload data instructions (pld, pldw) since
they are only available as wide instructions. The GNU assembler seems
to work with or without the .w appended when compiling an Thumb-2
kernel. However, Clang's integrated assembler does not consider the
.w variants as valid instructions:

  ./arch/arm/include/asm/processor.h:133:5: error: invalid instruction
                          "pldw.w\t%a0 \n"
                           ^
  <inline asm>:2:1: note: instantiated into assembly here
  pldw.w  [r0]
  ^
  1 error generated.

Drop the macro to make sure non-wide variants of pld and pldw are
emitted in all cases.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/include/asm/processor.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
index 120f4c9bbfde..042d77cf686d 100644
--- a/arch/arm/include/asm/processor.h
+++ b/arch/arm/include/asm/processor.h
@@ -131,8 +131,8 @@ static inline void prefetchw(const void *ptr)
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
2.20.1

