Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6134BC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B620644
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfHPMZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:25:15 -0400
Received: from foss.arm.com ([217.140.110.172]:55892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfHPMZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:25:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1341E360;
        Fri, 16 Aug 2019 05:25:03 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C984F3F706;
        Fri, 16 Aug 2019 05:25:01 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [RFC v4 16/18] arm64: crypto: Add exceptions for crypto object to prevent stack analysis
Date:   Fri, 16 Aug 2019 13:24:01 +0100
Message-Id: <20190816122403.14994-17-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
References: <20190816122403.14994-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some crypto modules contain `.word` of data in the .text section.
Since objtool can't make the distinction between data and incorrect
instruction, it gives a warning about the instruction beeing unknown
and stops the analysis of the object file.

The exception can be removed if the data are moved to another section
or if objtool is tweaked to handle this particular case.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/crypto/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/crypto/Makefile b/arch/arm64/crypto/Makefile
index 0435f2a0610e..e2a25919ebaa 100644
--- a/arch/arm64/crypto/Makefile
+++ b/arch/arm64/crypto/Makefile
@@ -43,9 +43,11 @@ aes-neon-blk-y := aes-glue-neon.o aes-neon.o
 
 obj-$(CONFIG_CRYPTO_SHA256_ARM64) += sha256-arm64.o
 sha256-arm64-y := sha256-glue.o sha256-core.o
+OBJECT_FILES_NON_STANDARD_sha256-core.o := y
 
 obj-$(CONFIG_CRYPTO_SHA512_ARM64) += sha512-arm64.o
 sha512-arm64-y := sha512-glue.o sha512-core.o
+OBJECT_FILES_NON_STANDARD_sha512-core.o := y
 
 obj-$(CONFIG_CRYPTO_CHACHA20_NEON) += chacha-neon.o
 chacha-neon-y := chacha-neon-core.o chacha-neon-glue.o
@@ -58,6 +60,7 @@ aes-arm64-y := aes-cipher-core.o aes-cipher-glue.o
 
 obj-$(CONFIG_CRYPTO_AES_ARM64_BS) += aes-neon-bs.o
 aes-neon-bs-y := aes-neonbs-core.o aes-neonbs-glue.o
+OBJECT_FILES_NON_STANDARD_aes-neonbs-core.o := y
 
 CFLAGS_aes-glue-ce.o	:= -DUSE_V8_CRYPTO_EXTENSIONS
 
-- 
2.17.1

