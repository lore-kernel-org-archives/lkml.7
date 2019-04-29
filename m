Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C66C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BAD21530
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556559392;
	bh=1qN7zw9SX539SvBWVdVLuEUJH8ykSSIFT8r6sWdCtpE=;
	h=From:To:Subject:Date:List-ID:From;
	b=MmFPBefA2wtKwVMbY+hLptpwvRX7Xq+ffDdB2AFYp2Z0FDq+ca9KsIZwXrzVEw+jS
	 sSy5bDe8J1tQMkFWU30kn9m+UCIcOh4pEuP9AO2surqLXAczTEfPqsiMF6oOUyorTW
	 Wpb8KOpCBOB9TknF8x/0MwIYtpoXFPccy5BSlxB8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbfD2Rgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 13:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfD2Rgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:36:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 855172087B;
        Mon, 29 Apr 2019 17:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556559391;
        bh=1qN7zw9SX539SvBWVdVLuEUJH8ykSSIFT8r6sWdCtpE=;
        h=From:To:Subject:Date:From;
        b=xW5xTQMHGezt8E4fUbMn4vmYibd5CAf5YIt7Sh0XksUCAbLxjMCjT+6CM2nLL2enj
         l1WPJFIljrV0eCawVQhQGYDO1f8hJ0zZ0XTYBik49/3C29F/Ol85fL5PbDJmooO58D
         enoyOgL4VD4u8CIDvOIy8K6sHLC/3hURWQn3N3UY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: exynos: Make ARCH_EXYNOS3 a default option
Date:   Mon, 29 Apr 2019 19:36:19 +0200
Message-Id: <20190429173620.5078-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default for ARMv7 Exynos platform we select all flavors.  One kernel
image simplifies testing and maintenance.  However Exynos3 was not
selected by default so far (thus it lacked in multi_v7 kernel).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-exynos/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 1c518b8ee520..21ad78d79d8d 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -49,6 +49,7 @@ config S5P_DEV_MFC
 
 config ARCH_EXYNOS3
 	bool "SAMSUNG EXYNOS3"
+	default y
 	select ARM_CPU_SUSPEND if PM
 	help
 	  Samsung EXYNOS3 (Cortex-A7) SoC based systems
-- 
2.17.1

