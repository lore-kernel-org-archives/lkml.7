Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64B5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F262192D
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 15:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="jxrVYdkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCWPwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 11:52:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52096 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfCWPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 11:52:48 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::3e6])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id BC6F65C2395;
        Sat, 23 Mar 2019 16:52:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1553356366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4m/7wAJ7pyOeYlVByTZNxVECbOq6MabzAHtX1uI61u4=;
        b=jxrVYdkPkSOi4FbQ47MoPMx/julUG2tNyHWUflR2n1P7VCmgnzkexf884gkkbqZ8Wt32KW
        Qm2yGCtFVucbnKMt4GA5KKzO2ouMHcrGCrTqwnD/sln+Xy1vEGEmgWlVXle0ZrJKyGk78o
        irssKxExe/sUWEOBevYO8C7ZIFMM+CE=
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
Subject: [PATCH 2/3] ARM: mvebu: drop unnecessary label
Date:   Sat, 23 Mar 2019 16:52:57 +0100
Message-Id: <2046aa3ca5ae2f31188020d4f2df50de228a5d84.1553356359.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The label mvebu_boot_wa_start is not necessary and causes a build
issue when building with LLVM's integrated assembler:
    AS      arch/arm/mach-mvebu/pmsu_ll.o
  arch/arm/mach-mvebu/pmsu_ll.S:59:1: error: invalid symbol redefinition
  mvebu_boot_wa_start:
  ^

Drop the label.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/mach-mvebu/pmsu_ll.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index 88651221dbdd..c1fb713e9306 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -56,7 +56,6 @@ ENDPROC(armada_38x_cpu_resume)
 
 /* The following code will be executed from SRAM */
 ENTRY(mvebu_boot_wa_start)
-mvebu_boot_wa_start:
 ARM_BE8(setend	be)
 	adr	r0, 1f
 	ldr	r0, [r0]		@ load the address of the
-- 
2.21.0

