Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1FF2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140257;
	bh=YjZYWCc81vyI2zxbIp0/1C9HSVMnPAEpnR03ok+iEjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iOwlEnhTlUIym/iPPpkhqjifHpseQLcC2lTq2cYnfd1DLtl6+1EzZT2Zl8fzNMw8I
	 pyFg0f0vIV79kcjHyw12HAA+Qh/GkyBweJveErtO5Kr+5KnQAiJK4zU2EyBfoNLqUU
	 wRdkNAXy3OGMETURohsOjNNvVjiYpazEkCO3SY1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388204AbfDARhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387981AbfDARhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395902070B;
        Mon,  1 Apr 2019 17:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140252;
        bh=YjZYWCc81vyI2zxbIp0/1C9HSVMnPAEpnR03ok+iEjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQVA9qUKW2ZXRiDFiuNZ6JheiCxXeDkewPB+5U99K29aEmpTt3qjP3hkowXreky0F
         fz5yXJ0LdGxC2PfZkZ1YZilP7WwyBwc7G0LDUsvmQXJjnxuXnyTC6xaWdkE2iJ/cIj
         RXqluPCwwQ7+NrMQ++xZtxzDCxfiEXC3sItanbxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 20/50] arm64/kernel: fix incorrect EL0 check in inv_entry macro
Date:   Mon,  1 Apr 2019 19:03:03 +0200
Message-Id: <20190401170043.696026489@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit b660950c60a7278f9d8deb7c32a162031207c758 ]

The implementation of macro inv_entry refers to its 'el' argument without
the required leading backslash, which results in an undefined symbol
'el' to be passed into the kernel_entry macro rather than the index of
the exception level as intended.

This undefined symbol strangely enough does not result in build failures,
although it is visible in vmlinux:

     $ nm -n vmlinux |head
                      U el
     0000000000000000 A _kernel_flags_le_hi32
     0000000000000000 A _kernel_offset_le_hi32
     0000000000000000 A _kernel_size_le_hi32
     000000000000000a A _kernel_flags_le_lo32
     .....

However, it does result in incorrect code being generated for invalid
exceptions taken from EL0, since the argument check in kernel_entry
assumes EL1 if its argument does not equal '0'.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 00f7ba3d82b8..2dfbb831e4af 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -234,7 +234,7 @@ END(vectors)
  * Invalid mode handlers
  */
 	.macro	inv_entry, el, reason, regsize = 64
-	kernel_entry el, \regsize
+	kernel_entry \el, \regsize
 	mov	x0, sp
 	mov	x1, #\reason
 	mrs	x2, esr_el1
-- 
2.19.1



