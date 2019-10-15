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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C3ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E5C20873
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsHwC6na"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733148AbfJOOwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:52:10 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43873 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbfJOOwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:52:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id j18so24233410wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RPFfIsUzztDTg5YJoInm2ijzJI5IXTRMvl5P10kjmeg=;
        b=jsHwC6naQ5OuX54RSY+JJuYPK14+nigXz2HztsdprGqMfWYb9QmazRRVkibp0y9Lel
         bcIiIPU6RKwHbrNCiGloBmwIrHIF2UVGRn70Kgii4VC1cdPy4GCjwm18mO+1Xk5ERt12
         D06tPHqW7exAlyJQ1YnLk8kfBKHkVNuUN5e4pqhyWMpQwZXKmvyX20GVmPm5Q4OkwrSM
         /3WyxRnOAhC0cUvsICMi9KBjGNqM4Y1bfFwlj1bnWoYdew3sWgg4FRbInUzHbNQfDbr4
         R0Lj34korClWN8dwDzCoAm+Of5tkiPxZ1+NWasJm7xKDTvC6l69fDGHEzi3qDLd5qQvN
         QevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RPFfIsUzztDTg5YJoInm2ijzJI5IXTRMvl5P10kjmeg=;
        b=pm5q+YXFH8U1T5JODOgBseyfua0NEL4PZgs/SZhi2C8A2Lmj4JZ8Mulr/JOwuTvivK
         qSvhbe1+fsiQWTFu/MrvxL8LQ6XzHwLC2CVIWi2mTdZvN26s65iEGzBGci/WvuiXuJzu
         JxoFi5gLkra+jkXbRf/vKqAPfXtlQ/iXZKrhYjjNBBCb1xyz4KQ8bh65X24PALrA3x/B
         3yiUrtI9NC2rIPetwU//CzNpbPdieX37qdowzJiYvzZPpEAGvysbC1eQ8taDQAvZAkSZ
         l+MIER6klhuUo71FLYT/GdzWVADk8LluuYrDWhTl0nWJ0zAX3i5/ShswcSEcS59p1lUH
         hAoQ==
X-Gm-Message-State: APjAAAWGU6LFE1oyf+TEYPjhI3p/N6F6byUC7gG1Y9EW00C1ZScCL8rm
        Vp/E1H15wuzgVghypCxfQLM=
X-Google-Smtp-Source: APXvYqx6B/AkW6uHHqhBbtnHKOlMAiP2BhuoLGzI382W7+pRlx+dKDoKs6XGsxHH1Asvk4JHIsTrTg==
X-Received: by 2002:a5d:4a87:: with SMTP id o7mr5082013wrq.374.1571151125302;
        Tue, 15 Oct 2019 07:52:05 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id r7sm20592001wrt.28.2019.10.15.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:52:04 -0700 (PDT)
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
Subject: [PATCH 6/6] ARM: Remove arm_pm_restart()
Date:   Tue, 15 Oct 2019 16:51:47 +0200
Message-Id: <20191015145147.1106247-7-thierry.reding@gmail.com>
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/include/asm/system_misc.h | 1 -
 arch/arm/kernel/reboot.c           | 6 +-----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
index 66f6a3ae68d2..98b37340376b 100644
--- a/arch/arm/include/asm/system_misc.h
+++ b/arch/arm/include/asm/system_misc.h
@@ -13,7 +13,6 @@
 extern void cpu_init(void);
 
 void soft_restart(unsigned long);
-extern void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 extern void (*arm_pm_idle)(void);
 
 #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
diff --git a/arch/arm/kernel/reboot.c b/arch/arm/kernel/reboot.c
index bb18ed0539f4..1076b26aa699 100644
--- a/arch/arm/kernel/reboot.c
+++ b/arch/arm/kernel/reboot.c
@@ -18,7 +18,6 @@ typedef void (*phys_reset_t)(unsigned long, bool);
 /*
  * Function pointers to optional machine specific functions
  */
-void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL(pm_power_off);
 
@@ -138,10 +137,7 @@ void machine_restart(char *cmd)
 	local_irq_disable();
 	smp_send_stop();
 
-	if (arm_pm_restart)
-		arm_pm_restart(reboot_mode, cmd);
-	else
-		do_kernel_restart(cmd);
+	do_kernel_restart(cmd);
 
 	/* Give a grace period for failure to restart of 1s */
 	mdelay(1000);
-- 
2.23.0

