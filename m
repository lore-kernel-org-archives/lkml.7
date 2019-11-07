Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E154C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 502CA21D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J69UedwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfKGURa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:17:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33176 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfKGURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:17:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id a17so4944470wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T+zsluzS/T4QlV+amlXXzj5zuhGksPk6IuGM8tASFHM=;
        b=J69UedwDH6qm/d/QY5IaFKnLBYOqIVP0y9qtbza0hVQLaDDn7dW1HHq4iXHHLyTBzl
         JzG4DDQFjUi576WuidaONs8q5hxghV9y8rlC42ZmP9n2OsIwUVPwixWPTssgCO9YMvNy
         AoesUy4qA7O2zzgNtS25nLDcg1ZDEzqVmwEcYnC2AkDw90FIdravTeMVzm1qhn9Zy+0D
         y26p6Cw4cEHXgX+8uwo6/w9xkh8XeGuJ89KNrHujCwCo6q0GNXGbht7l32zcYBNKClYn
         LAVreQ2L6G19/YDVCyUnvStjOXvozavkSHR25B5mQYDeV6Cpt/k5Jlbte9FkaUBo8n5O
         QoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T+zsluzS/T4QlV+amlXXzj5zuhGksPk6IuGM8tASFHM=;
        b=GvsB+0bthF0azLPug3IM6nkmWItGojnROsxmq2ayqjin+BgL3r8FLwhrXK/+Deuyfz
         icviSc+PNiuWlg11C3++HJdY9VZGffSSgZZYDe90h9b2vBCLOP5R78wouEwMXFLXMDVI
         LvJknm2ZA0xp6Ub8VQei74ZZ/r1oAs9UnPnsCW3G13c5sTjkwULjKqWEw6XRqHiJlfnU
         LbdJ/6jWg1WqXdiUNyDiG2v3cWRX8axGP+Arly2KN+55WkEx96a7oBEWIUg8VI0DEKuU
         z3d2xL8jgFtphejfSC+C5AqeNqFZ+YEYKGHSRcctzgYVNRV3ESys3v432tkEJ8bzPqFw
         shVg==
X-Gm-Message-State: APjAAAXBHaVxgmzudg1lPeyT/CFl0LctFxD0Gv66iZ+cOs7M5uU/m47i
        CkZZH/pJeUoOZytAp/VCs1TQGA==
X-Google-Smtp-Source: APXvYqyK+1+T6i/yZeGbXEMqaSWkBh7UUTFmvC0ZviyeqEbr6Z+uJWb/xiiKwTmnU2t6XRADAYsdzw==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr4601632wmh.94.1573157834195;
        Thu, 07 Nov 2019 12:17:14 -0800 (PST)
Received: from localhost.localdomain ([95.147.198.88])
        by smtp.gmail.com with ESMTPSA id d11sm3215162wrn.28.2019.11.07.12.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:17:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, Sasha Levin <sashal@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 09/10] ARM: davinci: da8xx: specify dma_coherent_mask for lcdc
Date:   Thu,  7 Nov 2019 20:17:01 +0000
Message-Id: <20191107201702.27023-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191107201702.27023-1-lee.jones@linaro.org>
References: <20191107201702.27023-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

[ Upstream commit 68f2515bb31a664ba3e2bc1eb78dd9f529b10067 ]

The lcdc device is missing the dma_coherent_mask definition causing the
following warning on da850-evm:

da8xx_lcdc da8xx_lcdc.0: found Sharp_LK043T1DG01 panel
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at kernel/dma/mapping.c:247 dma_alloc_attrs+0xc8/0x110
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 5.2.0-rc3-00077-g16d72dd4891f #18
Hardware name: DaVinci DA850/OMAP-L138/AM18x EVM
[<c000fce8>] (unwind_backtrace) from [<c000d900>] (show_stack+0x10/0x14)
[<c000d900>] (show_stack) from [<c001a4f8>] (__warn+0xec/0x114)
[<c001a4f8>] (__warn) from [<c001a634>] (warn_slowpath_null+0x3c/0x48)
[<c001a634>] (warn_slowpath_null) from [<c0065860>] (dma_alloc_attrs+0xc8/0x110)
[<c0065860>] (dma_alloc_attrs) from [<c02820f8>] (fb_probe+0x228/0x5a8)
[<c02820f8>] (fb_probe) from [<c02d3e9c>] (platform_drv_probe+0x48/0x9c)
[<c02d3e9c>] (platform_drv_probe) from [<c02d221c>] (really_probe+0x1d8/0x2d4)
[<c02d221c>] (really_probe) from [<c02d2474>] (driver_probe_device+0x5c/0x168)
[<c02d2474>] (driver_probe_device) from [<c02d2728>] (device_driver_attach+0x58/0x60)
[<c02d2728>] (device_driver_attach) from [<c02d27b0>] (__driver_attach+0x80/0xbc)
[<c02d27b0>] (__driver_attach) from [<c02d047c>] (bus_for_each_dev+0x64/0xb4)
[<c02d047c>] (bus_for_each_dev) from [<c02d1590>] (bus_add_driver+0xe4/0x1d8)
[<c02d1590>] (bus_add_driver) from [<c02d301c>] (driver_register+0x78/0x10c)
[<c02d301c>] (driver_register) from [<c000a5c0>] (do_one_initcall+0x48/0x1bc)
[<c000a5c0>] (do_one_initcall) from [<c05cae6c>] (kernel_init_freeable+0x10c/0x1d8)
[<c05cae6c>] (kernel_init_freeable) from [<c048a000>] (kernel_init+0x8/0xf4)
[<c048a000>] (kernel_init) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc6837fb0 to 0xc6837ff8)
7fa0:                                     00000000 00000000 00000000 00000000
7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
7fe0: 00000000 00000000 00000000 00000000 00000013 00000000
---[ end trace 8a8073511be81dd2 ]---

Add a 32-bit mask to the platform device's definition.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>

Signed-off-by: Lee Jones <lee.jones@linaro.org>
Change-Id: I835e72dbeb9ded2ffc7be0561f8f3544c3cc29ed
---
 arch/arm/mach-davinci/devices-da8xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index e83874ba6e6d..49716ba0bbb1 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -626,6 +626,9 @@ static struct platform_device da8xx_lcdc_device = {
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(da8xx_lcdc_resources),
 	.resource	= da8xx_lcdc_resources,
+	.dev		= {
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	}
 };
 
 int __init da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata)
-- 
2.24.0

