Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1532BC10F05
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59B621934
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="sbTkzy89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfCWPwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:52:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52132 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbfCWPwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:52:49 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::3e6])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DE5F45C23A7;
        Sat, 23 Mar 2019 16:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1553356367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wIYrioksRXwlOk0IovzjY06kHsUw+fURLPHEj7Q7CNc=;
        b=sbTkzy891OFBoekrCVU+j1+52IS9QB7p10tJqNd5hlhnNmnV4n329ZrfVnvT7+Og366p1j
        e1IFKZJ/tkHxh8KzDwA319UUHGsZWF0iKKajh9Go+kNOv5I2w1st9zf8yVZmMYWZewN7Jc
        zptf8+DChnnvIzP2+hIjjP/lvgfld1U=
From:   Stefan Agner <stefan@agner.ch>
To:     linux@armlinux.org.uk
Cc:     arnd@arndb.de, ard.biesheuvel@linaro.org, robin.murphy@arm.com,
        nicolas.pitre@linaro.org, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        kgene@kernel.org, krzk@kernel.org, robh@kernel.org,
        ssantosh@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        tony@atomide.com, marc.w.gonzalez@free.fr, mans@mansr.com,
        ndesaulniers@google.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 3/3] ARM: mvebu: prefix coprocessor operand with p
Date:   Sat, 23 Mar 2019 16:52:58 +0100
Message-Id: <7258b06ce7f788dd5d8eedc55855205c08068c0b.1553356359.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
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

