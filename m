Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED6C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D16020863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="BCAZVeWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfDHU7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:59:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52514 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbfDHU7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:59:07 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::360])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id F30575C2196;
        Mon,  8 Apr 2019 22:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1554757146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mE+cgShggDTO6VFE2wiOyVFnlAoIaj8WJeqFxe4soyI=;
        b=BCAZVeWa1mumPCOFv9cVhuD6Al6kfVTKsPDwcYrH6KYhU/AkhUFUIbcXIFfBY+xVkpfBUQ
        Bv13fzLQcpNL+sR2HdW3jljur4ekgAsC3R2G4s7sIRZfqZhVRTGsExefA8l8nJm6GPyZbl
        EsXvRQdgcMGdKo41p77QkCAaPpzVk5I=
From:   Stefan Agner <stefan@agner.ch>
To:     arm@kernel.org
Cc:     linux@armlinux.org.uk, arnd@arndb.de, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nicolas.pitre@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH v2 3/3] ARM: mvebu: prefix coprocessor operand with p
Date:   Mon,  8 Apr 2019 22:59:55 +0200
Message-Id: <09e394aa9368227a45144f169a680747a454c95b.1554757135.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
References: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In every other instance where mrc is used the coprocessor operand
is prefix with p (e.g. p15). Use the p prefix in this case too.
This fixes a build issue when using LLVM's integrated assembler:
  arch/arm/mach-mvebu/coherency_ll.S:69:6: error: invalid operand for instruction
   mrc 15, 0, r3, cr0, cr0, 5
       ^
  arch/arm/mach-mvebu/pmsu_ll.S:19:6: error: invalid operand for instruction
   mrc 15, 0, r0, cr0, cr0, 5 @ get the CPU ID
       ^

Signed-off-by: Stefan Agner <stefan@agner.ch>
Acked-by: Nicolas Pitre <nico@fluxnic.net>
---
 arch/arm/mach-mvebu/coherency_ll.S | 2 +-
 arch/arm/mach-mvebu/pmsu_ll.S      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index 8b2fbc8b6bc6..2d962fe48821 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -66,7 +66,7 @@ ENDPROC(ll_get_coherency_base)
  * fabric registers
  */
 ENTRY(ll_get_coherency_cpumask)
-	mrc	15, 0, r3, cr0, cr0, 5
+	mrc	p15, 0, r3, cr0, cr0, 5
 	and	r3, r3, #15
 	mov	r2, #(1 << 24)
 	lsl	r3, r2, r3
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index c1fb713e9306..7aae9a25cfeb 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -16,7 +16,7 @@
 ENTRY(armada_38x_scu_power_up)
 	mrc     p15, 4, r1, c15, c0	@ get SCU base address
 	orr	r1, r1, #0x8		@ SCU CPU Power Status Register
-	mrc	15, 0, r0, cr0, cr0, 5	@ get the CPU ID
+	mrc	p15, 0, r0, cr0, cr0, 5	@ get the CPU ID
 	and	r0, r0, #15
 	add	r1, r1, r0
 	mov	r0, #0x0
-- 
2.21.0

