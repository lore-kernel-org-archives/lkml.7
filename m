Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81B9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986A521903
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140000;
	bh=sZ1rHugOwgqtbB7Tni5fpC9vgRRPhKUX6+kzlFEqizY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aZzsrjMHIjQpcSMMbmwlokvLg1mf0ryinq8GDqZsYZJUJSew1x0g9xkLzvsne/mhR
	 VlFdcObXYGUBh7NXK/nX7KHezN1qMmMtPGL8yM1GKzThwjy7AVDRW7WHRRtJ/jhkh+
	 Vw1IugXekZ50EE/Ny4U4msTJmYBh1buw0o5fGGPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfDARdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387602AbfDARdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FF042171F;
        Mon,  1 Apr 2019 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139995;
        bh=sZ1rHugOwgqtbB7Tni5fpC9vgRRPhKUX6+kzlFEqizY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HWBBO9Bughjt3Zd8X/LDMH92N/j61U0r1JVFzVqoGXarhk0VELEMFCYL4OnLpGTse
         o8sf32nCjgaHLh0dTrVUTolVLucR+FC4yecLG54I82bvh1QxI5kJ78uSN70uiTjlRM
         4QPUgFftrCyNupL5RBFAqSppyYPIZ5Dp0oqtyh1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 074/131] arm64/kernel: fix incorrect EL0 check in inv_entry macro
Date:   Mon,  1 Apr 2019 19:02:24 +0200
Message-Id: <20190401170058.301826706@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 3028d9b028c7..586326981769 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -243,7 +243,7 @@ END(vectors)
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



