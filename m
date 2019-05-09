Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6016AC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0A121848
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427463;
	bh=U9CTq3I/rLV1LufqLJb85uD7bOGN5SH9NgAN5kkw4eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iIPyAfEMezhOyKEpWkqfJjjoKK7HlPQI8Qq+y0JNyV/qJzQdKql4fv14fTpm/6dYO
	 P575fUERLgWKcYRttr73bPSE7vS+ogeitTNkuQuRsxqTKFxTxT27Q2n9NxQeXdpHL3
	 /BUpb5gnmGpQKozjEwwL36EJH8lxS8L1dHpiZTg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfEISoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:35588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726620AbfEISoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:44:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA10217D6;
        Thu,  9 May 2019 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427457;
        bh=U9CTq3I/rLV1LufqLJb85uD7bOGN5SH9NgAN5kkw4eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tcj1+9/cP3SfpfqoDv55x8ohHY6439IWH/PvMx+Kp8MfQOtWWfSsLkQPEBH3HPoGf
         55kef1uhXpEbdTH2geBkraLAlTfnX5Sl8j6iOdawiHmjG9tkObN4kMXH6Ak2fnWMwJ
         nrt/AOoA29wr7TIqGX5/130n7/gk8qelNYJPTVHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 18/28] ARM: 8680/1: boot/compressed: fix inappropriate Thumb2 mnemonic for __nop
Date:   Thu,  9 May 2019 20:42:10 +0200
Message-Id: <20190509181254.093026560@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181247.647767531@linuxfoundation.org>
References: <20190509181247.647767531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 60ce2858514ed9ccaf00dc7e9f4dc219537e9855 ]

Commit 06a4b6d009a1 ("ARM: 8677/1: boot/compressed: fix decompressor
header layout for v7-M") fixed an issue in the layout of the header
of the compressed kernel image that was caused by the assembler
emitting narrow opcodes for 'mov r0, r0', and for this reason, the
mnemonic was updated to use the W() macro, which will append the .w
suffix (which forces a wide encoding) if required, i.e., when building
the kernel in Thumb2 mode.

However, this failed to take into account that on Thumb2 kernels built
for CPUs that are also ARM capable, the entry point is entered in ARM
mode, and so the instructions emitted here will be ARM instructions
that only exist in a wide encoding to begin with, which is why the
assembler rejects the .w suffix here and aborts the build with the
following message:

  head.S: Assembler messages:
  head.S:132: Error: width suffixes are invalid in ARM mode -- `mov.w r0,r0'

So replace the W(mov) with separate ARM and Thumb2 instructions, where
the latter will only be used for THUMB2_ONLY builds.

Fixes: 06a4b6d009a1 ("ARM: 8677/1: boot/compressed: fix decompressor ...")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/compressed/efi-header.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index 3f7d1b74c5e02..a17ca8d78656d 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -17,7 +17,8 @@
 		@ there.
 		.inst	'M' | ('Z' << 8) | (0x1310 << 16)   @ tstne r0, #0x4d000
 #else
-		W(mov)	r0, r0
+ AR_CLASS(	mov	r0, r0		)
+  M_CLASS(	nop.w			)
 #endif
 		.endm
 
-- 
2.20.1



