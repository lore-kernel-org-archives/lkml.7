Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C268FC2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99605206DF
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 13:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNVCAAj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLGNGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 08:06:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37394 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfLGNGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 08:06:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so4821696pfm.4;
        Sat, 07 Dec 2019 05:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6PpUMK/fvtT3W2NQbLvKL8csxRNa6vIgk1xEDsjC6bI=;
        b=NNVCAAj6R1V5V7V/PSONAwkW8RVZXFNsA2TQMJ+6ukcPGpSKS1R+wfpBcVK1pVwUoj
         /+760sCtrKCwXlJs3i0aJCUkOVG/Q1lLAOZmkAZ6TdOrzsThSeaaNvleTRL54tjCfOJw
         ueAc0J7rKPwUgZx5HF1RweVYqwrF+C+vh38sfBYx3SBHsXVmSRS1DNgjhX5/0gwH20HZ
         YpzQfa4+IUeV+b5UIshvK7vUgFvpwrfI6JUBpH8ztGpsjM9hFlk61XWc9UaVmHcA8sD4
         hfyqyk+9r6CfafJU/UaApak6CKqsRmQYSonhj8zpigXMVTdcMRe+LLWdmRTRLeTuDLGw
         L1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6PpUMK/fvtT3W2NQbLvKL8csxRNa6vIgk1xEDsjC6bI=;
        b=XAYVsODx2ii05yR1LpP5GNicv9KH/7bu3BqnOGx0bVmiBJAD3D2IaBU0KwGrd3Zx8f
         J6CqGM6dMuv3VpAub3aIf79XbgICNvYRFrvVePvldGhZ8WwhAVcZAq9yUA5AwI1WxwlN
         SFUOX1ruSnZz8y3KByAsjFl3puzmMD5cyKo//JtkQLdjmUHEXQb56xxTbYMBFCcLFNWC
         xDujqofmYC0ek/nPRfHwDms9K5lPJd+mXF/Dh1fwuRstQbUG1PGgNl2nUyaptHvFBrbS
         qjJXEZ2X1JtHt7JJdAAFHcmk2Y4pg5YMnLpO3HmICQJTzRFELRV4iPLo9DZVZ2xRNYIW
         gsRw==
X-Gm-Message-State: APjAAAU/nBvnbj9hn9w0aVYdMziFSVA3Bh7JjVXjcTk16gqOKMhpIpDC
        k01k9fSSgQRZ8hXzhzOm8yrF9v01
X-Google-Smtp-Source: APXvYqydIZpADSEqCwmvzLGTWJiUvwkFpQSPAm7NlY/5F6LhMpTJQm9IS4Mbyu5EgU42L7avFhDItQ==
X-Received: by 2002:a63:4757:: with SMTP id w23mr8748703pgk.366.1575723688187;
        Sat, 07 Dec 2019 05:01:28 -0800 (PST)
Received: from localhost.localdomain ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id f7sm10241246pfk.183.2019.12.07.05.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 05:01:27 -0800 (PST)
From:   Hyunki Koo <hyunki00.koo@gmail.com>
To:     linux@armlinux.org.uk, kgene@kernel.org, krzk@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Hyunki Koo <hyunki00.koo@samsung.com>
Subject: [PATCH 2/2] ARM: exynos: add select EXYNOS_IRQ_COMBINER
Date:   Sat,  7 Dec 2019 22:00:49 +0900
Message-Id: <20191207130049.27533-3-hyunki00.koo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191207130049.27533-1-hyunki00.koo@gmail.com>
References: <20191207130049.27533-1-hyunki00.koo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyunki Koo <hyunki00.koo@samsung.com>

This patch add select EXYNOS_IRQ_COMBINER
on aarch32 Exynos devices

Signed-off-by: Hyunki Koo <hyunki00.koo@samsung.com>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 4ef56571145b..c0efd544501e 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -18,6 +18,7 @@ menuconfig ARCH_EXYNOS
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
 	select EXYNOS_SROM
+	select EXYNOS_IRQ_COMBINER
 	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
 	select GPIOLIB
 	select HAVE_ARM_ARCH_TIMER if ARCH_EXYNOS5 && VIRTUALIZATION
-- 
2.17.1

