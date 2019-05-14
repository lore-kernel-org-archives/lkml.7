Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EEC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0813A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR0A1tsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfENQHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:07:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37917 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENQHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:07:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id 14so14856496ljj.5;
        Tue, 14 May 2019 09:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=l2kzXztgdqxiHBF3c7LPxlH8bIvFcECDZTDG91ehbx4=;
        b=PR0A1tsJWz8uRFCRpSiSR49AR79qD9JFrM3C5IFUaUKqkW9EOIRLCzUu8SOiWvWfZy
         id33CYsnCKhiUe31pvJOiP8Kk3eh/s+2VdQ2xf+/lyAZP4p6X1IMXMqr4bLV4vJw+tzL
         LGBSYQ0A1Q3l/HYvRmTYUcQ1xd/558FD9Czvp9+xVet/QRplBQ5+IlZYPuQCCLjBK+Dj
         MOAjyWMUgnYDLXmR7RCHxtUPns0CUWvcyy5V70NenKBgJx9z+gYmpuGUbDIbNN0Cby+O
         YUurbc2vI+8Isbo4KxBg/JtnkxUQ62/bY12IEzOc1C+CvH0tr1fc4qsUcDhi2BrPblEe
         U1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l2kzXztgdqxiHBF3c7LPxlH8bIvFcECDZTDG91ehbx4=;
        b=Plj6ImSdQT+ZrQNCf2ZxoW+nvKxc53poSmn3qzN5q4hcndsPBXzAGB8xgYHTcSo7Bk
         ej1D9Iw8QiPPpk3KenLZCryaBm1xgBsp/bTXGdMq5Pi/TD357aL/skbQx1RZZeErh12H
         CEsFgR5nDLrxPb/rwDflLxC/Qr+WKS769qegr6MN8toxejesjU1by+C5uguZIREa8zpv
         mJKZ05X/LYUW2aiOGC7PERjdroRvE7a+Wk/w4IdimHG61AIV7lm+YF4o6PKjBF7Q1Xfo
         5ujH9P6onFSol26pvGDBRxeLtyEFCLSc+1w82mHIamPSw5BoacM1E/Kbk6oxnDOtfsET
         Z+hQ==
X-Gm-Message-State: APjAAAXeXyymRvW9BHW8rHlEDK9KSlabA/FnrgSjSQtYX3j+EYZNTq1B
        TWLfkmIFTxsp1zzs0cwDowfcI7oU44A=
X-Google-Smtp-Source: APXvYqyi9avFiaNSir3/zoPi1mqHFZMT68ODr7pS8T4yik0qllHQ5PZQlG47sWcl2hMoonrhcP4CMQ==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr17263087ljg.145.1557850020781;
        Tue, 14 May 2019 09:07:00 -0700 (PDT)
Received: from otyshchenko.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id v23sm946597ljk.53.2019.05.14.09.06.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 14 May 2019 09:07:00 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     julien.grall@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux@armlinux.org.uk, geert@linux-m68k.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH V4] ARM: mach-shmobile: Don't init CNTVOFF/counter if PSCI is available
Date:   Tue, 14 May 2019 19:06:52 +0300
Message-Id: <1557850012-16612-1-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

If PSCI is available then most likely we are running on PSCI-enabled
U-Boot which, we assume, has already taken care of resetting CNTVOFF
and updating counter module before switching to non-secure mode
and we don't need to.

As the psci_smp_available() helper always returns false if CONFIG_SMP
is disabled, it can't be used safely as an indicator of PSCI usage.
For that reason, we check for the mandatory PSCI operation to be
available.

Please note, an extra check to prevent secure_cntvoff_init() from
being called for secondary CPUs in headsmp-apmu.S is not needed,
as SMP code for APMU based system is not executed if PSCI is in use.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
CC: Julien Grall <julien.grall@arm.com>

---
   You can find previous discussions here:
   [v1]  https://lkml.org/lkml/2019/4/17/810
   [v2]  https://lkml.org/lkml/2019/5/3/338
   [v3]  https://lkml.org/lkml/2019/5/10/415
   [RFC] https://lkml.org/lkml/2019/5/10/473

   Changes in v2:
      - Clarify patch subject/description
      - Don't use CONFIG_ARM_PSCI option, check whether the PSCI is available,
        by using psci_smp_available()
      - Check whether we are running on top of Xen, by using xen_domain()

   Changes in v3:
      - Don't check for the presence of Xen

   Changes in v4:
      - Don't use psci_smp_available() helper, check for psci_ops.cpu_on
        directly
      - Skip updating counter module if PSCI is available
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index eea60b2..64e3abd 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -17,6 +17,7 @@
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/of_platform.h>
+#include <linux/psci.h>
 #include <asm/mach/arch.h>
 #include <asm/secure_cntvoff.h>
 #include "common.h"
@@ -63,6 +64,15 @@ void __init rcar_gen2_timer_init(void)
 	void __iomem *base;
 	u32 freq;
 
+	/*
+	 * If PSCI is available then most likely we are running on PSCI-enabled
+	 * U-Boot which, we assume, has already taken care of resetting CNTVOFF
+	 * and updating counter module before switching to non-secure mode
+	 * and we don't need to.
+	 */
+	if (psci_ops.cpu_on)
+		goto skip_update;
+
 	secure_cntvoff_init();
 
 	if (of_machine_is_compatible("renesas,r8a7745") ||
@@ -102,6 +112,7 @@ void __init rcar_gen2_timer_init(void)
 
 	iounmap(base);
 
+skip_update:
 	of_clk_init(NULL);
 	timer_probe();
 }
-- 
2.7.4

