Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0C4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7181720873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwzp0QAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733135AbfJOOwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:52:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40267 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733032AbfJOOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:52:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id o28so1623255wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VAVoEu24xaohbwzafdzyJGlubUQKQUGPXTLnsYm65Y8=;
        b=bwzp0QANI9ZAtq8ebhpNJc/C77CZR6FTzH+/cfmEERClacgLvpuSHHtyidwDPuvey7
         2+srWChtSJ08u/VocrpNHSezMmgEXrfg73hmVJ5V6I/IX8cmSHM9mweDVIYm3IFNz0Dm
         AXDFxGntAmh8J/NR1hmE1LCeCRUbmf+sdpB01ElSB8Jq5+afFFPUYW1h/xor3y9tPXst
         nSBA5TwwZP8lGioiDP7Ika8JxvuIsNcGTVQb5E6x7U7uP4c1vFKfl2Xh1Xf95g/yEsDs
         72MZ32zM32bT+1Th+LMSK/H6r6ntFyZHVKe+GNZZsPnQrIU0czOC4kLlz5uGvZqufrcD
         6/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VAVoEu24xaohbwzafdzyJGlubUQKQUGPXTLnsYm65Y8=;
        b=HWlvMPVbgZvYDCySMt6ShXuj9aswI64jhwZ9SDWSl4fELbMOidrWoKPp9ES7pw4p+g
         bELMxYYQpTfKOylyk/7MkXChkG3GPCvGVZoDniteAdrzvOji1yb6qJHMlj9zbMuK7EgC
         oAtaRpbc4pzg8bYKLnzmp0i8FAD6TKK/mWqhwgeG5NdGlOL6kEg9SYN4PFTyx4C2sfIW
         ED7KYhn2QNz71F6R2/xupFXI0ZSmYqXCtRgMVpv/VVds2DNenX2xmJjWFVvGH5CuBi/Y
         /hvCaNPRBimTHO87z0syUzN88nrAn2tU4/Pb/Xp0GdGK2PyMVUgdwkK98sOBOkqVshee
         QbPg==
X-Gm-Message-State: APjAAAU48H2VpjyJXWwO2SSoEY6fFN8hjYkcUtZVG6pdSDLl+ezerE68
        FopHNvmFZrJOhWGO7ExdNEo=
X-Google-Smtp-Source: APXvYqxhVxHqqgJpZEbxh6+QhqKe7xvgm6z1kpI/OiC4NTY0obJUmvAeKLRYIWZ9KloWkVuO1upBRw==
X-Received: by 2002:adf:ea07:: with SMTP id q7mr14227941wrm.102.1571151123439;
        Tue, 15 Oct 2019 07:52:03 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id u11sm20954003wmd.32.2019.10.15.07.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:52:02 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] ARM64: Remove arm_pm_restart()
Date:   Tue, 15 Oct 2019 16:51:46 +0200
Message-Id: <20191015145147.1106247-6-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015145147.1106247-1-thierry.reding@gmail.com>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

All users of arm_pm_restart() have been converted to use the kernel
restart handler.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/include/asm/system_misc.h | 2 --
 arch/arm64/kernel/process.c          | 7 +------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index 1ab63cfbbaf1..d02c5e5ea015 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -32,8 +32,6 @@ void hook_debug_fault_code(int nr, int (*fn)(unsigned long, unsigned int,
 struct mm_struct;
 extern void __show_regs(struct pt_regs *);
 
-extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* __ASM_SYSTEM_MISC_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a47462def04b..f11d2b261b4e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -64,8 +64,6 @@ EXPORT_SYMBOL(__stack_chk_guard);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
 
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
-
 static void __cpu_do_idle(void)
 {
 	dsb(sy);
@@ -195,10 +193,7 @@ void machine_restart(char *cmd)
 		efi_reboot(reboot_mode, NULL);
 
 	/* Now call the architecture specific reboot code. */
-	if (arm_pm_restart)
-		arm_pm_restart(reboot_mode, cmd);
-	else
-		do_kernel_restart(cmd);
+	do_kernel_restart(cmd);
 
 	/*
 	 * Whoops - the architecture was unable to reboot.
-- 
2.23.0

