Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559BBC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206CC20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ATAqjNbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfFGOeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:34:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41404 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfFGOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:34:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so2392738wrm.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRZZPd4CuOKccCO9n20pj6NCx0PtOoXNGKdvtL/yQh8=;
        b=ATAqjNbD3zSQ0mn1U+NeswlrlhdcptQ0U1v6/qsZKIIS8bxBmp4qpT9bwU3cwpsbc7
         lFKJwrsnKY+MMG02u/ivCJHvzk+Q8vbC0gkep7WB5VhjPoAsOQv2bjDPPpOCnL94XJ9x
         rN4wfb+Of4sR6npFW4RO65+j0dfHovQyaQ66c0bau89xx1jrwvRJfmNeMxeD0cWIQR3n
         y9Kb/F+6uPHzfDTVBJ9uV0Qeu79vaJvVdA2UHBHTFzN3FVRgDdAThjGsWW2S5PAlLglX
         0NaaTDbgXYpa+El8EXdEZApR8VnI3twXzIJd+fgS/+iDzgA4R1EWAZ8GAvtx5D0AjdtU
         vv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRZZPd4CuOKccCO9n20pj6NCx0PtOoXNGKdvtL/yQh8=;
        b=hHoSqHZe4dMfyx8v0qMUac6ROUC6tTZCJr9vlqYJ7PPb5/LwA4cEIR/UMLoVnTXErc
         sqhOqiqYrtOEXVrHC6Wa6itXHkZbc8NdvDGnVRq3xhKFMAgwsjSVVf5iwZs4Kf32ijf9
         zKaEyeIU94XcGLSbCNTRpbR4gna3vh2J8iurzioCF7+CPWUQYHDWBOKXYCKcSepEUOoM
         RNVAKRnlAZli+5EyCimdv43/sGmfr6KIQL1WDELEu8finXTdgeOX2Ax1nyw1xbrMJEeA
         4PcnLQg65KeyckqFUTuPF3dUY8bHhcWvFk3x+ZikdkO6JTPNGQ6liE7KyfPuxd/KGQNT
         okkQ==
X-Gm-Message-State: APjAAAVFy7E643YT4nTyBor6Iex7rEmSqHlTHKyDgSZo3Yqxoyo/H9Eo
        NAEnvlaUG7r+Uw9NCsHdo6AZ6Q==
X-Google-Smtp-Source: APXvYqzjPX0uTbJ4XdCTSAmUg9f2YMBqtaes35JdoKkeprFZ5Dvejyh+ekMdSkshyFKJ1LzaXyHy+g==
X-Received: by 2002:adf:e34e:: with SMTP id n14mr14515474wrj.169.1559918046002;
        Fri, 07 Jun 2019 07:34:06 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id h90sm4348456wrh.15.2019.06.07.07.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:34:05 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] ARM: davinci: da8xx: specify dma_coherent_mask for lcdc
Date:   Fri,  7 Jun 2019 16:33:50 +0200
Message-Id: <20190607143350.11214-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

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
---
 arch/arm/mach-davinci/devices-da8xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 9ff02de448c6..767cc6f7834c 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -683,6 +683,9 @@ static struct platform_device da8xx_lcdc_device = {
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(da8xx_lcdc_resources),
 	.resource	= da8xx_lcdc_resources,
+	.dev		= {
+		.coherent_dma_mask	= DMA_BIT_MASK(32)
+	}
 };
 
 int __init da8xx_register_lcdc(struct da8xx_lcdc_platform_data *pdata)
-- 
2.21.0

