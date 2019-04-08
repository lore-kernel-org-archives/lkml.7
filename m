Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651FC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766FB20863
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="b+oDcw0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfDHU7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:59:08 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:52484 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfDHU7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:59:08 -0400
Received: from zyt.lan (unknown [IPv6:2a02:169:3465::360])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D266B5C2195;
        Mon,  8 Apr 2019 22:59:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1554757145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vD7C3SpFDMxg92USPDGMEInDsi77a4O2+ZRx+UKL2OY=;
        b=b+oDcw0XVlNWr4gdAT5VL9uT9F7E6JInk5ReVmLNk1tcRoPUK/ZdNH2HfCljz+QF6ifqBZ
        XgvalTE3qa6Zzrp0gxrgWKbunZ+1f+/aPPehY/1pBKBdyi8CaZZtlTwd4KP2ycM7DnIqWP
        8mmft8kBvvIzmA9wiqBESa+OiWuQGjQ=
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
Subject: [PATCH v2 2/3] ARM: mvebu: drop unnecessary label
Date:   Mon,  8 Apr 2019 22:59:54 +0200
Message-Id: <bdb201f6118f5a48720115aebde7556c87f0dae2.1554757135.git.stefan@agner.ch>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
References: <7b3b9d2150d491b5cb3761d96b215749ea63175f.1554757135.git.stefan@agner.ch>
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
Acked-by: Nicolas Pitre <nico@fluxnic.net>
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

