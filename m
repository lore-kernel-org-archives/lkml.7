Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8087EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495FF2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999079;
	bh=OCAWUr3mFL5eDNWwXHfGhmryRAQg6yZrfx5cYtqBmug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Uo5B/M9Lc6nSstuljWs6d2fVbVbxEGTXKtXX9wrRpeiCfNaJVb/IzDID9vmNSHt3v
	 +N2f6DY7LTmjdhFvvuyAI8jgg29opiYHr6V/Xkgoe8LuTcsfxI4WxTGwkjiltJTa2h
	 rKvxzSSKc0Ms1dKpkUT/q8HFIsmox+K0p22aQ2f4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392134AbfGXT5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:57:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392107AbfGXT5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:57:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7347D22BED;
        Wed, 24 Jul 2019 19:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998270;
        bh=OCAWUr3mFL5eDNWwXHfGhmryRAQg6yZrfx5cYtqBmug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sog8bEWVZh39TW/DmaG3ak+NZdbpWCu/zZND3vm1609W2OcoHcgkQJLhDluOoxjfZ
         E+xGeKaJ18joqfN2a7vtYoRCz/SgsOiIJjZRdm+MC9a6h949WFegA1UE/k2alpK6ks
         J6HmTaFkTog/Dyx0GT16VrA0mR8JU5ULHPavUdc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 5.1 307/371] arm64: irqflags: Add condition flags to inline asm clobber list
Date:   Wed, 24 Jul 2019 21:20:59 +0200
Message-Id: <20190724191747.282263359@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

commit f57065782f245ca96f1472209a485073bbc11247 upstream.

Some of the inline assembly instruction use the condition flags and need
to include "cc" in the clobber list.

Fixes: 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
Cc: <stable@vger.kernel.org> # 5.1.x-
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/irqflags.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -92,7 +92,7 @@ static inline unsigned long arch_local_s
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=&r" (flags), "+r" (daif_bits)
 		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
-		: "memory");
+		: "cc", "memory");
 
 	return flags;
 }
@@ -136,7 +136,7 @@ static inline int arch_irqs_disabled_fla
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=&r" (res)
 		: "r" ((int) flags)
-		: "memory");
+		: "cc", "memory");
 
 	return res;
 }


