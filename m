Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C9AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08C5207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 10:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcc9/JwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfLDKLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 05:11:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46552 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfLDKLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 05:11:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id y14so2950378pfm.13;
        Wed, 04 Dec 2019 02:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X78/UEM1JDrsz2wbO1IYinDOnIrG936f4cZHAjiIgwM=;
        b=mcc9/JwGLQwm7ZMNhOYcNdyWvi4LosHbEB0fgv3GqhEDPCaay5uNwBREPTBg07YQIz
         qHnMQ92JxpZEGfkH162ZJj9Z+saw0h/pchkStOt9lIu9kziZWopAZbOcZwMyxCYlQarv
         ZmsRJN158PNPPcdNxF9tpswG9cyhXDpe5p/5bsCFvuqeCzDRs/KQcSJzGafpisXqu41U
         A9wbUDdNtbjrP9qLkHTsQgQH/mDuuexx/hLCz8bKoMgUJdAU1cfmLg7QHT74tu6mmVJc
         vC+A/KeqBbIfSAk18SVw5KRc1OCoQGcUDPKEQ7RjhBYluUsVZhEI9NNT2YYg4KitrjgL
         UEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X78/UEM1JDrsz2wbO1IYinDOnIrG936f4cZHAjiIgwM=;
        b=Ns6MwYB8oL62VBX/CIfVZm8jwQfFptcB7Saoghbtwi086/7eS5r0ttqhzkHdAOo8YS
         S7CcnHz+HEivXisSvYmLXMAhyBica1gKfSfE832LxUNc66uSAdXrPUVVnp3Zt6TTDQIi
         +DnFQuTbiM6JAhcx5icpB1kkqxOjGOAbgsKLDTO5tCJjwa6uI3jf4IGEo311Hl+oBcgQ
         M4blqSDgK6IHdnEPr50V0l3jLbRKQHOCyeepdxA2hToh/OamrDeZLXQuIRdEzW9zsrfB
         +l9uMfr0Jwj+lxK8XAPtWG4yXZd5K2UXuLcOZATiHCL8MPR7+9fs9lbMUoJpR9Xytlxe
         nhoQ==
X-Gm-Message-State: APjAAAUCxoo9DuEh+yZlfNXSr29Eq7aXOoYtFuzoSA+ABLJmhSmFlDVb
        S9eSwluvctJJsGDBnr2h+vQ=
X-Google-Smtp-Source: APXvYqyQuejC9ZsUSUtbnXdBdGeaFPuJgXkyfY8REXrYqG3MRu37xdNd4frWw3z4ixxam7xsojBTqg==
X-Received: by 2002:a63:5056:: with SMTP id q22mr2641312pgl.20.1575454282892;
        Wed, 04 Dec 2019 02:11:22 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 67sm7664259pfw.82.2019.12.04.02.11.20
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Dec 2019 02:11:22 -0800 (PST)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org
Cc:     baolin.wang7@gmail.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] hwspinlock: Allow drivers to be built with COMPILE_TEST
Date:   Wed,  4 Dec 2019 18:10:40 +0800
Message-Id: <808692052649aa2e80693a2734cb392e5eddd83c.1575454108.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow drivers to be built with COMPILE_TEST.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/hwspinlock/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
index 37740e9..cefaa4f 100644
--- a/drivers/hwspinlock/Kconfig
+++ b/drivers/hwspinlock/Kconfig
@@ -9,7 +9,7 @@ menuconfig HWSPINLOCK
 config HWSPINLOCK_OMAP
 	tristate "OMAP Hardware Spinlock device"
 	depends on HWSPINLOCK
-	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3
+	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3 || COMPILE_TEST
 	help
 	  Say y here to support the OMAP Hardware Spinlock device (firstly
 	  introduced in OMAP4).
@@ -19,7 +19,7 @@ config HWSPINLOCK_OMAP
 config HWSPINLOCK_QCOM
 	tristate "Qualcomm Hardware Spinlock device"
 	depends on HWSPINLOCK
-	depends on ARCH_QCOM
+	depends on ARCH_QCOM || COMPILE_TEST
 	select MFD_SYSCON
 	help
 	  Say y here to support the Qualcomm Hardware Mutex functionality, which
@@ -31,7 +31,7 @@ config HWSPINLOCK_QCOM
 config HWSPINLOCK_SIRF
 	tristate "SIRF Hardware Spinlock device"
 	depends on HWSPINLOCK
-	depends on ARCH_SIRF
+	depends on ARCH_SIRF || COMPILE_TEST
 	help
 	  Say y here to support the SIRF Hardware Spinlock device, which
 	  provides a synchronisation mechanism for the various processors
@@ -43,7 +43,7 @@ config HWSPINLOCK_SIRF
 config HWSPINLOCK_SPRD
 	tristate "SPRD Hardware Spinlock device"
 	depends on ARCH_SPRD
-	depends on HWSPINLOCK
+	depends on HWSPINLOCK || COMPILE_TEST
 	help
 	  Say y here to support the SPRD Hardware Spinlock device.
 
@@ -52,7 +52,7 @@ config HWSPINLOCK_SPRD
 config HWSPINLOCK_STM32
 	tristate "STM32 Hardware Spinlock device"
 	depends on MACH_STM32MP157
-	depends on HWSPINLOCK
+	depends on HWSPINLOCK || COMPILE_TEST
 	help
 	  Say y here to support the STM32 Hardware Spinlock device.
 
@@ -61,7 +61,7 @@ config HWSPINLOCK_STM32
 config HSEM_U8500
 	tristate "STE Hardware Semaphore functionality"
 	depends on HWSPINLOCK
-	depends on ARCH_U8500
+	depends on ARCH_U8500 || COMPILE_TEST
 	help
 	  Say y here to support the STE Hardware Semaphore functionality, which
 	  provides a synchronisation mechanism for the various processor on the
-- 
1.7.9.5

