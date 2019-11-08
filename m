Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6ADFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C0C20674
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573240677;
	bh=2qkLcwpEbkvyB56eMwEwhqmMpsgXBqVREUPQsPDFVac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bwlHoKRTcn4RrghsWX2KiXs2wPUr+KsfmI1f8uV1V6rIdQu+wyrHcKV5N9cKF9hKj
	 Qa238JQQUrkeW4Nq3Rc+8T0/0gWPjdaaCYWvZDW2vJfF9WcJdAuhxxDBJnRRe6+J77
	 a1jANMEqWS5hXcpAah7vTvcYbFOvisZQ3ea/N3JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389840AbfKHTAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389663AbfKHTAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:00:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F0EC22459;
        Fri,  8 Nov 2019 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239473;
        bh=2qkLcwpEbkvyB56eMwEwhqmMpsgXBqVREUPQsPDFVac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oFs9lfsVSNvA7Ln6GdiQspbwamKI8iRPSiS4cKPndoUsozFZgpXWaVHzdNYXKpQ16
         FYDUdCvutjiCKlhl4rs9+LZ3kfbcNl4GybD+6NNH1w/x0UHdzYPkmXTucH3JrwycEa
         wOYVUPgaRjcMe2+QSF5XV6eJuOP4ZJZC7mT3Hzrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, afzal mohammed <afzal.mohd.ma@gmail.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 17/62] ARM: 8926/1: v7m: remove register save to stack before svc
Date:   Fri,  8 Nov 2019 19:50:05 +0100
Message-Id: <20191108174734.215367434@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174719.228826381@linuxfoundation.org>
References: <20191108174719.228826381@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: afzal mohammed <afzal.mohd.ma@gmail.com>

[ Upstream commit 2ecb287998a47cc0a766f6071f63bc185f338540 ]

r0-r3 & r12 registers are saved & restored, before & after svc
respectively. Intention was to preserve those registers across thread to
handler mode switch.

On v7-M, hardware saves the register context upon exception in AAPCS
complaint way. Restoring r0-r3 & r12 is done from stack location where
hardware saves it, not from the location on stack where these registers
were saved.

To clarify, on stm32f429 discovery board:

1. before svc, sp - 0x90009ff8
2. r0-r3,r12 saved to 0x90009ff8 - 0x9000a00b
3. upon svc, h/w decrements sp by 32 & pushes registers onto stack
4. after svc,  sp - 0x90009fd8
5. r0-r3,r12 restored from 0x90009fd8 - 0x90009feb

Above means r0-r3,r12 is not restored from the location where they are
saved, but since hardware pushes the registers onto stack, the registers
are restored correctly.

Note that during register saving to stack (step 2), it goes past
0x9000a000. And it seems, based on objdump, there are global symbols
residing there, and it perhaps can cause issues on a non-XIP Kernel
(on XIP, data section is setup later).

Based on the analysis above, manually saving registers onto stack is at
best no-op and at worst can cause data section corruption. Hence remove
storing of registers onto stack before svc.

Fixes: b70cd406d7fe ("ARM: 8671/1: V7M: Preserve registers across switch from Thread to Handler mode")
Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
Acked-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/proc-v7m.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index 92e84181933ad..c68408d51c4bc 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -135,7 +135,6 @@ __v7m_setup_cont:
 	dsb
 	mov	r6, lr			@ save LR
 	ldr	sp, =init_thread_union + THREAD_START_SP
-	stmia	sp, {r0-r3, r12}
 	cpsie	i
 	svc	#0
 1:	cpsid	i
-- 
2.20.1



