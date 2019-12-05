Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF12DC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C79F224F8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 15:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agIiHZBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfLEPQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:16:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41979 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfLEPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 10:16:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id bd4so1372722plb.8;
        Thu, 05 Dec 2019 07:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6PpUMK/fvtT3W2NQbLvKL8csxRNa6vIgk1xEDsjC6bI=;
        b=agIiHZBwD4X5eZ0FNWuNuFEwyyeG1sXOLk5+FriDOsaSzxa3MftJloe+Eb3HU+mEMF
         +BFkAT2AYJcwIxM72XrI/wVwTmK77NJ0sDLSiIhv33rAuYzkN93P5sQ7E1d13EAvA7lC
         eaMCmZVA7V8OnShoviJE8zmCdeReAA7HHPxCPbyaZejfcj0LwDC3ns/yoZfLlC6rccwu
         FV0wL2F96vi4HN3hc+F5B8rYywfSeRXYae6W0JuatA5KCL9MoNiUfeC9Xttt+XUtQN8z
         77zv3RLRf8K6rFY5u2ikhCXV05beD2NU52hcEPDXRG6bdjyyAbcQxkh2xB3FLXKjjbIi
         wpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6PpUMK/fvtT3W2NQbLvKL8csxRNa6vIgk1xEDsjC6bI=;
        b=pweBpVLIenCzbkN2RhoUc3yD1S8SjwpQv3if8C0juVY2zwJZyuF76T5IicHav5rEBG
         qIT9OHOUJNebHxljoyux9qe8JUrGo/6wZCNWdI++oumVWiM4fHpWLYw4a4kw/CAHZPDN
         7eo8K0H9SvWkSpEGzIV4oh5nKT3Yy66rHCd8WOY0++B2+wTm8Gtfae0OmJaZJUM6UoS8
         5fmkTBL3/+dghUal120sBOC+EawM4aGJJiyaN+AM1TSxGBhH1pBH7AdzoQcOBM3rbtk5
         jXnhfZjTWDmkzEPhNUsjX9eqQIpou5+zXIGJloNDWOhTQ4ljh9MtBd+BddeX8uJkloz+
         vxJQ==
X-Gm-Message-State: APjAAAXtSCt1D4CBgCRS4kGNXd/CpVwmIDtYbk0feCi4/7M8Hly3vDC6
        NGYX2l6OQUUjVO35XmZ99yQ=
X-Google-Smtp-Source: APXvYqw3eI/RuygT54i529DFXj+zt6Jrf7+Fj+SlopqLW1OBVQAeuG03gyLEYDJ1t8s+hIVci3cAlw==
X-Received: by 2002:a17:90a:c68f:: with SMTP id n15mr9968588pjt.20.1575558990424;
        Thu, 05 Dec 2019 07:16:30 -0800 (PST)
Received: from localhost.localdomain ([211.243.117.64])
        by smtp.gmail.com with ESMTPSA id m68sm13055101pfm.85.2019.12.05.07.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 07:16:30 -0800 (PST)
From:   Hyunki Koo <hyunki00.koo@gmail.com>
To:     krzk@kernel.org
Cc:     Hyunki Koo <hyunki00.koo@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: exynos: add select EXYNOS_IRQ_COMBINER
Date:   Fri,  6 Dec 2019 00:16:14 +0900
Message-Id: <20191205151614.23268-1-hyunki00.koo@gmail.com>
X-Mailer: git-send-email 2.17.1
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

