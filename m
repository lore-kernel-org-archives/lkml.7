Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85E8CA9EC9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD0020862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCHCfMc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJ3Vxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:53:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39021 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbfJ3Vxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:53:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id y3so4380097ljj.6;
        Wed, 30 Oct 2019 14:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iIhirnFklLn1OL2q/K6q4x2b2P+v7Ve0tVmAkHn4AI=;
        b=QCHCfMc6kANijIVQw1KJuxfSKSmH+jkHIRDJOlHmoBRlkPXBTBfa4uzzbYnldhoSS6
         7rH5rBWT5/0N8HBf4oeFpzsoo2e2AdUIwDiu93pt8xCNgNybwwwm9Hzdp9bUtCIPUFtN
         tzUFcxMosKRjlV6139fQUAU1EK8E1JQNy5Ay4kmuuvQE+p7F1sk4Xv3VmTeURhYUjwOw
         FnM1tJg6LXG3mjM9C7w6eOdO5y8Vqcno8rMvnGPJfKx7gsI26rLaLfpZQL77sP7q+qOl
         7p4BwOtOdebtkhNb21g1NCY8AiaUFQvI/vJHCc4IjAZmkS36UK4bOksU9uS98E2N9chj
         U1fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+iIhirnFklLn1OL2q/K6q4x2b2P+v7Ve0tVmAkHn4AI=;
        b=jFHreicbMneDVXPDEtYHXEVvetX+qT2xg8BkDAI9AN5Rbm6HRkNzx4aBq5/TNnyxzr
         9USU49RfUiiB7T8KR6zyR13O8Jyx7gIoDQfJKcA/iNe27Q5dL1FP/CZs5vmbqZ+BaLIF
         9zhrHHbwPUTGkC6Ch6zrhNmh2XjhNqUOs0/8FzlPlDb9ahBqWP3Y0plMWtkClDSumqKB
         0XStyUIOOTInm3Js5qw3MwuWhF7T0HKHPabo1jGTPJ9rX5+dbrkBa8YlsRHo6BJ6ogK2
         KR3SDWCnVwhM6g7OcD0gVANKKGzuimuyHOxY+6uw0g+Ur9mllHMfZ+xqn8MnuUXJngof
         vLXQ==
X-Gm-Message-State: APjAAAX+WzwFzv8+QsEEm0kFy9qsZGZSyF1rkIHiG0n8WMfR9gNrPhfq
        vrJXfgTj09YKTsBLlY1/A1E=
X-Google-Smtp-Source: APXvYqwpmKfbKgKXmoJ7VfD8jQr0W8/TDCuxscJdav/6f6yiLUtGDuMrdaXy306YXDn9OgGLsExE0A==
X-Received: by 2002:a2e:87c3:: with SMTP id v3mr1316353ljj.61.1572472433046;
        Wed, 30 Oct 2019 14:53:53 -0700 (PDT)
Received: from localhost.localdomain (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.gmail.com with ESMTPSA id a2sm520316lfh.73.2019.10.30.14.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 14:53:52 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
Date:   Thu, 31 Oct 2019 00:53:41 +0300
Message-Id: <20191030215342.14948-1-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The early-resume code shall not switch CPU to PLLX because PLLX
configuration could be unstable or PLLX should be simply disabled if
CPU enters into suspend running off some other PLL (the case if CPUFREQ
driver is active). The actual burst policy is restored by the clock
drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/sleep-tegra30.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
index 5942cec9b6ef..2f9e5076d201 100644
--- a/arch/arm/mach-tegra/sleep-tegra30.S
+++ b/arch/arm/mach-tegra/sleep-tegra30.S
@@ -383,11 +383,8 @@ _pll_m_c_x_done:
 	ldr	r4, [r5, #0x1C]		@ restore SCLK_BURST
 	str	r4, [r0, #CLK_RESET_SCLK_BURST]
 
-	cmp	r10, #TEGRA30
-	movweq	r4, #:lower16:((1 << 28) | (0x8))	@ burst policy is PLLX
-	movteq	r4, #:upper16:((1 << 28) | (0x8))
-	movwne	r4, #:lower16:((1 << 28) | (0xe))
-	movtne	r4, #:upper16:((1 << 28) | (0xe))
+	movw	r4, #:lower16:((1 << 28) | (0x4))	@ burst policy is PLLP
+	movt	r4, #:upper16:((1 << 28) | (0x4))
 	str	r4, [r0, #CLK_RESET_CCLK_BURST]
 
 	/* Restore pad power state to normal */
-- 
2.23.0

