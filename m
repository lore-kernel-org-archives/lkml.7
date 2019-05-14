Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1175C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1E3216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ryhyrzce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfENRJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:09:36 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40996 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfENRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:09:35 -0400
Received: by mail-pl1-f193.google.com with SMTP id f12so6546303plt.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RENsHOPWNFHShmkQ709uKFqDg37I2rBlsAOl/iPk0k=;
        b=RyhyrzceGfVWtkdzKPGazlBGf6vcn6oGXIibLQCRf08vU9CCKxjxdnd/G+xXx5Iu2i
         DhRWs0qBTPmv74/VtbVucR//SjnF6atyIXbMa5jFMO4amOhd6wAI7b4O8L7gi3kB0Ehq
         MuU6218Q7rohXemQq8z4GBUjcSxTWSCxNnYKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5RENsHOPWNFHShmkQ709uKFqDg37I2rBlsAOl/iPk0k=;
        b=TtHvSy2zpfZWb32VcYWFrWVN39o+OuytQdis+WeE7DEvEMjgwe/fSkkRQtqHKOtiP/
         SLIp1s5JR7RQPAi7QJAnNv9fjS5YlCmGpPa58Y0e4gtHobklBsFyRLF9wwSvojBxOw3d
         JeNIfdyJsHY8wnaszb3Hb2K7hGrlbd7KfVWc9bkXsgnOyIliSmS1o6nSZvAEDSZos81L
         QdQ5ZtrUgB+J3LeXiGUrzhfM5q+N2iXNWNYijnF0ICozJdJvNPkOXU7v43tjo9RSmjFv
         acMNuAdt9JpI5Y3Kpdk8fIluGYy7af+EwNAyA+//G6k6CLQaGXw/l7He5NxxKtAQv320
         JMvQ==
X-Gm-Message-State: APjAAAXC3CLLozv3t6Xs2b51+7B87k/CCqBHPCCqLF3j+QDbsoXA4xzz
        F+o1TDPCNkYA5XjygOJUejBSBQ==
X-Google-Smtp-Source: APXvYqxHKuj/Wn1Z8TofYmiw44QIWk2LKOY3+rklZ7K0SN9ENlnbMWa2qSYjxBPv0+6Y+cwxo0OJVQ==
X-Received: by 2002:a17:902:6809:: with SMTP id h9mr39044318plk.129.1557853773102;
        Tue, 14 May 2019 10:09:33 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g72sm39605194pfg.63.2019.05.14.10.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 10:09:32 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
X-Google-Original-From: Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Tero Kristo <t-kristo@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Crispin <john@phrozen.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] clk: Remove io.h from clk-provider.h
Date:   Tue, 14 May 2019 10:09:31 -0700
Message-Id: <20190514170931.56312-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we've gotten rid of clk_readl() we can remove io.h from the
clk-provider header and push out the io.h include to any code that isn't
already including the io.h header but using things like readl/writel,
etc.

Found with this grep:

  git grep -l clk-provider.h | grep '.c$' | xargs git grep -L 'linux/io.h' | \
  	xargs git grep -l \
	-e '\<__iowrite32_copy\>' --or \
	-e '\<__ioread32_copy\>' --or \
	-e '\<__iowrite64_copy\>' --or \
	-e '\<ioremap_page_range\>' --or \
	-e '\<ioremap_huge_init\>' --or \
	-e '\<arch_ioremap_pud_supported\>' --or \
	-e '\<arch_ioremap_pmd_supported\>' --or \
	-e '\<devm_ioport_map\>' --or \
	-e '\<devm_ioport_unmap\>' --or \
	-e '\<IOMEM_ERR_PTR\>' --or \
	-e '\<devm_ioremap\>' --or \
	-e '\<devm_ioremap_nocache\>' --or \
	-e '\<devm_ioremap_wc\>' --or \
	-e '\<devm_iounmap\>' --or \
	-e '\<devm_ioremap_release\>' --or \
	-e '\<devm_memremap\>' --or \
	-e '\<devm_memunmap\>' --or \
	-e '\<__devm_memremap_pages\>' --or \
	-e '\<pci_remap_cfgspace\>' --or \
	-e '\<arch_has_dev_port\>' --or \
	-e '\<arch_phys_wc_add\>' --or \
	-e '\<arch_phys_wc_del\>' --or \
	-e '\<memremap\>' --or \
	-e '\<memunmap\>' --or \
	-e '\<arch_io_reserve_memtype_wc\>' --or \
	-e '\<arch_io_free_memtype_wc\>' --or \
	-e '\<__io_aw\>' --or \
	-e '\<__io_pbw\>' --or \
	-e '\<__io_paw\>' --or \
	-e '\<__io_pbr\>' --or \
	-e '\<__io_par\>' --or \
	-e '\<__raw_readb\>' --or \
	-e '\<__raw_readw\>' --or \
	-e '\<__raw_readl\>' --or \
	-e '\<__raw_readq\>' --or \
	-e '\<__raw_writeb\>' --or \
	-e '\<__raw_writew\>' --or \
	-e '\<__raw_writel\>' --or \
	-e '\<__raw_writeq\>' --or \
	-e '\<readb\>' --or \
	-e '\<readw\>' --or \
	-e '\<readl\>' --or \
	-e '\<readq\>' --or \
	-e '\<writeb\>' --or \
	-e '\<writew\>' --or \
	-e '\<writel\>' --or \
	-e '\<writeq\>' --or \
	-e '\<readb_relaxed\>' --or \
	-e '\<readw_relaxed\>' --or \
	-e '\<readl_relaxed\>' --or \
	-e '\<readq_relaxed\>' --or \
	-e '\<writeb_relaxed\>' --or \
	-e '\<writew_relaxed\>' --or \
	-e '\<writel_relaxed\>' --or \
	-e '\<writeq_relaxed\>' --or \
	-e '\<readsb\>' --or \
	-e '\<readsw\>' --or \
	-e '\<readsl\>' --or \
	-e '\<readsq\>' --or \
	-e '\<writesb\>' --or \
	-e '\<writesw\>' --or \
	-e '\<writesl\>' --or \
	-e '\<writesq\>' --or \
	-e '\<inb\>' --or \
	-e '\<inw\>' --or \
	-e '\<inl\>' --or \
	-e '\<outb\>' --or \
	-e '\<outw\>' --or \
	-e '\<outl\>' --or \
	-e '\<inb_p\>' --or \
	-e '\<inw_p\>' --or \
	-e '\<inl_p\>' --or \
	-e '\<outb_p\>' --or \
	-e '\<outw_p\>' --or \
	-e '\<outl_p\>' --or \
	-e '\<insb\>' --or \
	-e '\<insw\>' --or \
	-e '\<insl\>' --or \
	-e '\<outsb\>' --or \
	-e '\<outsw\>' --or \
	-e '\<outsl\>' --or \
	-e '\<insb_p\>' --or \
	-e '\<insw_p\>' --or \
	-e '\<insl_p\>' --or \
	-e '\<outsb_p\>' --or \
	-e '\<outsw_p\>' --or \
	-e '\<outsl_p\>' --or \
	-e '\<ioread8\>' --or \
	-e '\<ioread16\>' --or \
	-e '\<ioread32\>' --or \
	-e '\<ioread64\>' --or \
	-e '\<iowrite8\>' --or \
	-e '\<iowrite16\>' --or \
	-e '\<iowrite32\>' --or \
	-e '\<iowrite64\>' --or \
	-e '\<ioread16be\>' --or \
	-e '\<ioread32be\>' --or \
	-e '\<ioread64be\>' --or \
	-e '\<iowrite16be\>' --or \
	-e '\<iowrite32be\>' --or \
	-e '\<iowrite64be\>' --or \
	-e '\<ioread8_rep\>' --or \
	-e '\<ioread16_rep\>' --or \
	-e '\<ioread32_rep\>' --or \
	-e '\<ioread64_rep\>' --or \
	-e '\<iowrite8_rep\>' --or \
	-e '\<iowrite16_rep\>' --or \
	-e '\<iowrite32_rep\>' --or \
	-e '\<iowrite64_rep\>' --or \
	-e '\<__io_virt\>' --or \
	-e '\<pci_iounmap\>' --or \
	-e '\<virt_to_phys\>' --or \
	-e '\<phys_to_virt\>' --or \
	-e '\<ioremap_uc\>' --or \
	-e '\<ioremap\>' --or \
	-e '\<__ioremap\>' --or \
	-e '\<iounmap\>' --or \
	-e '\<ioremap\>' --or \
	-e '\<ioremap_nocache\>' --or \
	-e '\<ioremap_uc\>' --or \
	-e '\<ioremap_wc\>' --or \
	-e '\<ioremap_wc\>' --or \
	-e '\<ioremap_wt\>' --or \
	-e '\<ioport_map\>' --or \
	-e '\<ioport_unmap\>' --or \
	-e '\<ioport_map\>' --or \
	-e '\<ioport_unmap\>' --or \
	-e '\<xlate_dev_kmem_ptr\>' --or \
	-e '\<xlate_dev_mem_ptr\>' --or \
	-e '\<unxlate_dev_mem_ptr\>' --or \
	-e '\<virt_to_bus\>' --or \
	-e '\<bus_to_virt\>' --or \
	-e '\<memset_io\>' --or \
	-e '\<memcpy_fromio\>' --or \
	-e '\<memcpy_toio\>'

I also reordered a couple includes when they weren't alphabetical and
removed clk.h from kona, replacing it with clk-provider.h because
that driver doesn't use clk consumer APIs.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com> 
Cc: John Crispin <john@phrozen.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

I'm going to push this into clk-next today and if nothing breaks, send
it off for inclusion in a couple days, at least before -rc1 is released.

 arch/arm/mach-davinci/da830.c               | 1 +
 arch/arm/mach-davinci/da850.c               | 1 +
 arch/arm/mach-davinci/devices-da8xx.c       | 1 +
 arch/arm/mach-davinci/dm355.c               | 1 +
 arch/arm/mach-davinci/dm365.c               | 1 +
 arch/arm/mach-davinci/dm644x.c              | 1 +
 arch/arm/mach-davinci/dm646x.c              | 1 +
 arch/arm/mach-dove/common.c                 | 1 +
 arch/arm/mach-mediatek/mediatek.c           | 1 +
 arch/arm/mach-mv78xx0/common.c              | 1 +
 arch/arm/mach-orion5x/common.c              | 1 +
 arch/arm/mach-rockchip/rockchip.c           | 1 +
 arch/arm/mach-zynq/common.c                 | 1 +
 arch/h8300/kernel/setup.c                   | 1 +
 arch/mips/ath79/clock.c                     | 1 +
 arch/mips/ath79/setup.c                     | 1 +
 arch/mips/txx9/generic/setup.c              | 1 +
 arch/xtensa/platforms/xtfpga/setup.c        | 1 +
 drivers/acpi/acpi_apd.c                     | 1 +
 drivers/clk/axs10x/i2s_pll_clock.c          | 1 +
 drivers/clk/axs10x/pll_clock.c              | 1 +
 drivers/clk/bcm/clk-bcm2835-aux.c           | 1 +
 drivers/clk/bcm/clk-bcm2835.c               | 1 +
 drivers/clk/bcm/clk-kona.c                  | 3 ++-
 drivers/clk/berlin/berlin2-div.c            | 1 +
 drivers/clk/berlin/bg2.c                    | 1 +
 drivers/clk/berlin/bg2q.c                   | 1 +
 drivers/clk/clk-fixed-mmio.c                | 3 ++-
 drivers/clk/clk-fractional-divider.c        | 1 +
 drivers/clk/clk-hsdk-pll.c                  | 1 +
 drivers/clk/clk-multiplier.c                | 1 +
 drivers/clk/davinci/pll-da850.c             | 1 +
 drivers/clk/h8300/clk-div.c                 | 1 +
 drivers/clk/h8300/clk-h8s2678.c             | 3 ++-
 drivers/clk/hisilicon/clk-hi3660-stub.c     | 1 +
 drivers/clk/imx/clk-composite-8m.c          | 3 ++-
 drivers/clk/imx/clk-frac-pll.c              | 1 +
 drivers/clk/imx/clk-imx21.c                 | 1 +
 drivers/clk/imx/clk-imx27.c                 | 1 +
 drivers/clk/imx/clk-pfdv2.c                 | 1 +
 drivers/clk/imx/clk-pllv4.c                 | 1 +
 drivers/clk/imx/clk-sccg-pll.c              | 1 +
 drivers/clk/ingenic/cgu.c                   | 1 +
 drivers/clk/ingenic/jz4740-cgu.c            | 1 +
 drivers/clk/ingenic/jz4770-cgu.c            | 1 +
 drivers/clk/ingenic/jz4780-cgu.c            | 1 +
 drivers/clk/loongson1/clk-loongson1c.c      | 1 +
 drivers/clk/microchip/clk-core.c            | 1 +
 drivers/clk/microchip/clk-pic32mzda.c       | 1 +
 drivers/clk/mvebu/armada-37xx-periph.c      | 1 +
 drivers/clk/mvebu/armada-37xx-tbg.c         | 1 +
 drivers/clk/mvebu/clk-corediv.c             | 1 +
 drivers/clk/nxp/clk-lpc18xx-ccu.c           | 1 +
 drivers/clk/nxp/clk-lpc18xx-cgu.c           | 1 +
 drivers/clk/nxp/clk-lpc32xx.c               | 1 +
 drivers/clk/pxa/clk-pxa.c                   | 1 +
 drivers/clk/renesas/clk-r8a73a4.c           | 1 +
 drivers/clk/renesas/clk-r8a7740.c           | 1 +
 drivers/clk/renesas/clk-rcar-gen2.c         | 1 +
 drivers/clk/renesas/clk-rz.c                | 1 +
 drivers/clk/renesas/clk-sh73a0.c            | 1 +
 drivers/clk/renesas/r9a06g032-clocks.c      | 1 +
 drivers/clk/renesas/rcar-usb2-clock-sel.c   | 1 +
 drivers/clk/renesas/renesas-cpg-mssr.c      | 1 +
 drivers/clk/rockchip/clk-half-divider.c     | 3 ++-
 drivers/clk/rockchip/clk-px30.c             | 1 +
 drivers/clk/rockchip/clk-rk3036.c           | 1 +
 drivers/clk/rockchip/clk-rk3128.c           | 1 +
 drivers/clk/rockchip/clk-rk3188.c           | 1 +
 drivers/clk/rockchip/clk-rk3228.c           | 1 +
 drivers/clk/rockchip/clk-rk3288.c           | 1 +
 drivers/clk/rockchip/clk-rk3328.c           | 1 +
 drivers/clk/rockchip/clk-rk3368.c           | 1 +
 drivers/clk/rockchip/clk-rk3399.c           | 1 +
 drivers/clk/rockchip/clk-rv1108.c           | 1 +
 drivers/clk/rockchip/clk.c                  | 1 +
 drivers/clk/samsung/clk-cpu.c               | 1 +
 drivers/clk/samsung/clk-exynos-clkout.c     | 1 +
 drivers/clk/samsung/clk-exynos3250.c        | 1 +
 drivers/clk/samsung/clk-exynos4.c           | 1 +
 drivers/clk/samsung/clk-exynos5-subcmu.c    | 1 +
 drivers/clk/samsung/clk-exynos5250.c        | 1 +
 drivers/clk/samsung/clk-pll.c               | 3 ++-
 drivers/clk/samsung/clk-s3c2410-dclk.c      | 1 +
 drivers/clk/samsung/clk-s3c2412.c           | 1 +
 drivers/clk/samsung/clk-s3c2443.c           | 1 +
 drivers/clk/samsung/clk.c                   | 1 +
 drivers/clk/sifive/fu540-prci.c             | 1 +
 drivers/clk/socfpga/clk-gate-s10.c          | 1 +
 drivers/clk/socfpga/clk-periph-s10.c        | 1 +
 drivers/clk/socfpga/clk-pll-s10.c           | 1 +
 drivers/clk/st/clkgen-mux.c                 | 1 +
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c        | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c       | 1 +
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c        | 1 +
 drivers/clk/sunxi-ng/ccu-sun5i.c            | 1 +
 drivers/clk/sunxi-ng/ccu-sun6i-a31.c        | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c        | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c        | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c       | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c         | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-r40.c        | 1 +
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c        | 1 +
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c        | 1 +
 drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c    | 1 +
 drivers/clk/sunxi-ng/ccu_div.c              | 1 +
 drivers/clk/sunxi-ng/ccu_frac.c             | 1 +
 drivers/clk/sunxi-ng/ccu_gate.c             | 1 +
 drivers/clk/sunxi-ng/ccu_mmc_timing.c       | 1 +
 drivers/clk/sunxi-ng/ccu_mp.c               | 1 +
 drivers/clk/sunxi-ng/ccu_mult.c             | 1 +
 drivers/clk/sunxi-ng/ccu_mux.c              | 1 +
 drivers/clk/sunxi-ng/ccu_nk.c               | 1 +
 drivers/clk/sunxi-ng/ccu_nkm.c              | 1 +
 drivers/clk/sunxi-ng/ccu_nkmp.c             | 1 +
 drivers/clk/sunxi-ng/ccu_nm.c               | 1 +
 drivers/clk/sunxi-ng/ccu_phase.c            | 1 +
 drivers/clk/sunxi-ng/ccu_sdm.c              | 1 +
 drivers/clk/sunxi/clk-a10-mod1.c            | 1 +
 drivers/clk/sunxi/clk-a10-pll2.c            | 1 +
 drivers/clk/sunxi/clk-a10-ve.c              | 1 +
 drivers/clk/sunxi/clk-a20-gmac.c            | 1 +
 drivers/clk/sunxi/clk-mod0.c                | 1 +
 drivers/clk/sunxi/clk-simple-gates.c        | 1 +
 drivers/clk/sunxi/clk-sun4i-display.c       | 1 +
 drivers/clk/sunxi/clk-sun4i-pll3.c          | 1 +
 drivers/clk/sunxi/clk-sun4i-tcon-ch1.c      | 1 +
 drivers/clk/sunxi/clk-sun8i-apb0.c          | 1 +
 drivers/clk/sunxi/clk-sun8i-bus-gates.c     | 1 +
 drivers/clk/sunxi/clk-sun8i-mbus.c          | 1 +
 drivers/clk/sunxi/clk-sun9i-cpus.c          | 1 +
 drivers/clk/sunxi/clk-sun9i-mmc.c           | 1 +
 drivers/clk/sunxi/clk-sunxi.c               | 1 +
 drivers/clk/sunxi/clk-usb.c                 | 1 +
 drivers/clk/tegra/clk-emc.c                 | 1 +
 drivers/clk/tegra/clk-periph-fixed.c        | 1 +
 drivers/clk/tegra/clk-sdmmc-mux.c           | 1 +
 drivers/clk/tegra/clk.c                     | 1 +
 drivers/clk/ti/adpll.c                      | 1 +
 drivers/clk/ti/clk.c                        | 1 +
 drivers/clk/ti/fapll.c                      | 1 +
 drivers/clk/versatile/clk-sp810.c           | 1 +
 drivers/clk/x86/clk-pmc-atom.c              | 1 +
 drivers/cpufreq/loongson1-cpufreq.c         | 1 +
 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 1 +
 drivers/gpu/drm/vc4/vc4_dsi.c               | 1 +
 drivers/mailbox/mtk-cmdq-mailbox.c          | 1 +
 drivers/memory/tegra/tegra124-emc.c         | 1 +
 drivers/mfd/intel-lpss.c                    | 1 +
 drivers/mmc/host/meson-mx-sdio.c            | 1 +
 drivers/net/ieee802154/ca8210.c             | 1 +
 include/linux/clk-provider.h                | 1 -
 sound/soc/mxs/mxs-saif.c                    | 1 +
 153 files changed, 158 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 63511f638ce4..e6b8ffd934a1 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,6 +12,7 @@
 #include <linux/clk/davinci.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/platform_data/gpio-davinci.h>
 
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 67ab71ba3ad3..77bc64d6e39b 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index b8dc674e06bc..036139fe0d0f 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -17,6 +17,7 @@
 #include <linux/dma-contiguous.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
 #include <linux/serial_8250.h>
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4a482445b9a2..c6073326be2e 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8e0a77315add..2f9ae6431bf5 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index cecc7ceb8d34..1b9e9a6192ef 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -14,6 +14,7 @@
 #include <linux/clkdev.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index f33392f77a03..62ca952fe161 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/irqchip/irq-davinci-aintc.h>
 #include <linux/platform_data/edma.h>
 #include <linux/platform_data/gpio-davinci.h>
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 0d420a2bfe3e..d7b826d2695c 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -11,6 +11,7 @@
 #include <linux/clk-provider.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/dma-mv_xor.h>
diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index b6a81ba1ce32..5a9c016b3c6c 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -15,6 +15,7 @@
  * GNU General Public License for more details.
  */
 #include <linux/init.h>
+#include <linux/io.h>
 #include <asm/mach/arch.h>
 #include <linux/of.h>
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index f72e1e9f5fc5..dd762d1b083f 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/serial_8250.h>
 #include <linux/ata_platform.h>
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index c67f92bfa30e..7bcb41137bbf 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
 #include <linux/serial_8250.h>
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/mach-rockchip/rockchip.c
index e41cabc4dc2b..06ab03b93109 100644
--- a/arch/arm/mach-rockchip/rockchip.c
+++ b/arch/arm/mach-rockchip/rockchip.c
@@ -17,6 +17,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/irqchip.h>
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 6aba9ebf8041..7f634eaeaf10 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/cpumask.h>
 #include <linux/platform_device.h>
diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index b32bfa1fe99e..23a979a85f14 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -13,6 +13,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
 #include <linux/console.h>
diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index d4ca97e2ec6c..228cdc736db7 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clkdev.h>
diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
index 25a57895a3a3..298b46b4e9cb 100644
--- a/arch/mips/ath79/setup.c
+++ b/arch/mips/ath79/setup.c
@@ -14,6 +14,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/memblock.h>
 #include <linux/err.h>
 #include <linux/clk.h>
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 70a1ab66d252..46537c2ca86a 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -26,6 +26,7 @@
 #include <linux/leds.h>
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/irq.h>
 #include <asm/bootinfo.h>
 #include <asm/idle.h>
diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 820e8738af11..b1506376d502 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -18,6 +18,7 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/errno.h>
 #include <linux/reboot.h>
 #include <linux/kdev_t.h>
diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index ddf598ae8b6b..c16f9460c4a2 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -17,6 +17,7 @@
 #include <linux/clkdev.h>
 #include <linux/acpi.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/pm.h>
 
 #include "internal.h"
diff --git a/drivers/clk/axs10x/i2s_pll_clock.c b/drivers/clk/axs10x/i2s_pll_clock.c
index 02d3bcd6216c..71c2e9519ca8 100644
--- a/drivers/clk/axs10x/i2s_pll_clock.c
+++ b/drivers/clk/axs10x/i2s_pll_clock.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/of.h>
diff --git a/drivers/clk/axs10x/pll_clock.c b/drivers/clk/axs10x/pll_clock.c
index c68dada97316..aba787b2e771 100644
--- a/drivers/clk/axs10x/pll_clock.c
+++ b/drivers/clk/axs10x/pll_clock.c
@@ -14,6 +14,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/bcm/clk-bcm2835-aux.c b/drivers/clk/bcm/clk-bcm2835-aux.c
index 2a2c7569336a..b6d07ca0164f 100644
--- a/drivers/clk/bcm/clk-bcm2835-aux.c
+++ b/drivers/clk/bcm/clk-bcm2835-aux.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <dt-bindings/clock/bcm2835-aux.h>
diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 9fcae932e082..770bb01f523e 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -29,6 +29,7 @@
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/bcm/clk-kona.c b/drivers/clk/bcm/clk-kona.c
index eee64b9e5d10..cc3b1e1bc087 100644
--- a/drivers/clk/bcm/clk-kona.c
+++ b/drivers/clk/bcm/clk-kona.c
@@ -15,8 +15,9 @@
 #include "clk-kona.h"
 
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/clk.h>
+#include <linux/clk-provider.h>
 
 /*
  * "Policies" affect the frequencies of bus clocks provided by a
diff --git a/drivers/clk/berlin/berlin2-div.c b/drivers/clk/berlin/berlin2-div.c
index 4d0be66aa6a8..eb14a5bc0507 100644
--- a/drivers/clk/berlin/berlin2-div.c
+++ b/drivers/clk/berlin/berlin2-div.c
@@ -7,6 +7,7 @@
  */
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/berlin/bg2.c b/drivers/clk/berlin/bg2.c
index 0b4b44a2579e..bccdfa00fd37 100644
--- a/drivers/clk/berlin/bg2.c
+++ b/drivers/clk/berlin/bg2.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/berlin/bg2q.c b/drivers/clk/berlin/bg2q.c
index 9b9db743df25..e9518d35f262 100644
--- a/drivers/clk/berlin/bg2q.c
+++ b/drivers/clk/berlin/bg2q.c
@@ -8,6 +8,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/clk-fixed-mmio.c b/drivers/clk/clk-fixed-mmio.c
index d1a97d971183..51f26619b6a2 100644
--- a/drivers/clk/clk-fixed-mmio.c
+++ b/drivers/clk/clk-fixed-mmio.c
@@ -10,8 +10,9 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/of_address.h>
+#include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 
 static struct clk_hw *fixed_mmio_clk_setup(struct device_node *node)
diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fractional-divider.c
index d81f1d2e9129..b1e556f20911 100644
--- a/drivers/clk/clk-fractional-divider.c
+++ b/drivers/clk/clk-fractional-divider.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/clk-hsdk-pll.c b/drivers/clk/clk-hsdk-pll.c
index a47c2b600f20..97d1e8c35b71 100644
--- a/drivers/clk/clk-hsdk-pll.c
+++ b/drivers/clk/clk-hsdk-pll.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
diff --git a/drivers/clk/clk-multiplier.c b/drivers/clk/clk-multiplier.c
index 94470b4eadf4..e507aa958da9 100644
--- a/drivers/clk/clk-multiplier.c
+++ b/drivers/clk/clk-multiplier.c
@@ -7,6 +7,7 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
index 0f7198191ea2..bf120bec59ae 100644
--- a/drivers/clk/davinci/pll-da850.c
+++ b/drivers/clk/davinci/pll-da850.c
@@ -11,6 +11,7 @@
 #include <linux/clkdev.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/mfd/syscon.h>
diff --git a/drivers/clk/h8300/clk-div.c b/drivers/clk/h8300/clk-div.c
index d413ade95c99..376be03bb546 100644
--- a/drivers/clk/h8300/clk-div.c
+++ b/drivers/clk/h8300/clk-div.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
diff --git a/drivers/clk/h8300/clk-h8s2678.c b/drivers/clk/h8300/clk-h8s2678.c
index c7ae653c8a16..67c495b67c18 100644
--- a/drivers/clk/h8300/clk-h8s2678.c
+++ b/drivers/clk/h8300/clk-h8s2678.c
@@ -6,8 +6,9 @@
  */
 
 #include <linux/clk-provider.h>
-#include <linux/err.h>
 #include <linux/device.h>
+#include <linux/io.h>
+#include <linux/err.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
 
diff --git a/drivers/clk/hisilicon/clk-hi3660-stub.c b/drivers/clk/hisilicon/clk-hi3660-stub.c
index e8b2c43b1bb8..89934bee7c9e 100644
--- a/drivers/clk/hisilicon/clk-hi3660-stub.c
+++ b/drivers/clk/hisilicon/clk-hi3660-stub.c
@@ -24,6 +24,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
index 574fac1a169f..388bdb94f841 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -3,9 +3,10 @@
  * Copyright 2018 NXP
  */
 
+#include <linux/clk-provider.h>
 #include <linux/errno.h>
+#include <linux/io.h>
 #include <linux/slab.h>
-#include <linux/clk-provider.h>
 
 #include "clk.h"
 
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
index 76b9eb15604e..fece503e3610 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 #include <linux/bitfield.h>
diff --git a/drivers/clk/imx/clk-imx21.c b/drivers/clk/imx/clk-imx21.c
index e63188eb08ac..6e93284c397b 100644
--- a/drivers/clk/imx/clk-imx21.c
+++ b/drivers/clk/imx/clk-imx21.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx21-clock.h>
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 0a0ab95d16fe..a3753067fc12 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -3,6 +3,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/imx27-clock.h>
diff --git a/drivers/clk/imx/clk-pfdv2.c b/drivers/clk/imx/clk-pfdv2.c
index fb567dcc2118..a03bbed662c6 100644
--- a/drivers/clk/imx/clk-pfdv2.c
+++ b/drivers/clk/imx/clk-pfdv2.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 
diff --git a/drivers/clk/imx/clk-pllv4.c b/drivers/clk/imx/clk-pllv4.c
index d7e62c3620d3..8155b12cf0e1 100644
--- a/drivers/clk/imx/clk-pllv4.c
+++ b/drivers/clk/imx/clk-pllv4.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
index 991bbe63f156..5d65f65c512e 100644
--- a/drivers/clk/imx/clk-sccg-pll.c
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/slab.h>
 #include <linux/bitfield.h>
diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 510b685212d3..b80af61dc1f3 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -20,6 +20,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/ingenic/jz4740-cgu.c b/drivers/clk/ingenic/jz4740-cgu.c
index b86edd328249..25f7df028e67 100644
--- a/drivers/clk/ingenic/jz4740-cgu.c
+++ b/drivers/clk/ingenic/jz4740-cgu.c
@@ -17,6 +17,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <dt-bindings/clock/jz4740-cgu.h>
 #include <asm/mach-jz4740/clock.h>
diff --git a/drivers/clk/ingenic/jz4770-cgu.c b/drivers/clk/ingenic/jz4770-cgu.c
index bf46a0df2004..dfce740c25a8 100644
--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/syscore_ops.h>
 #include <dt-bindings/clock/jz4770-cgu.h>
diff --git a/drivers/clk/ingenic/jz4780-cgu.c b/drivers/clk/ingenic/jz4780-cgu.c
index 6427be117ff1..d03b7fcfd82b 100644
--- a/drivers/clk/ingenic/jz4780-cgu.c
+++ b/drivers/clk/ingenic/jz4780-cgu.c
@@ -17,6 +17,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <dt-bindings/clock/jz4780-cgu.h>
 #include "cgu.h"
diff --git a/drivers/clk/loongson1/clk-loongson1c.c b/drivers/clk/loongson1/clk-loongson1c.c
index 3466f7320b40..22a165ef65cf 100644
--- a/drivers/clk/loongson1/clk-loongson1c.c
+++ b/drivers/clk/loongson1/clk-loongson1c.c
@@ -9,6 +9,7 @@
 
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include <loongson1.h>
 #include "clk.h"
diff --git a/drivers/clk/microchip/clk-core.c b/drivers/clk/microchip/clk-core.c
index c3b301463425..4680064f1951 100644
--- a/drivers/clk/microchip/clk-core.c
+++ b/drivers/clk/microchip/clk-core.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <asm/mach-pic32/pic32.h>
 #include <asm/traps.h>
diff --git a/drivers/clk/microchip/clk-pic32mzda.c b/drivers/clk/microchip/clk-pic32mzda.c
index 9f734779be92..e6c05df2d47f 100644
--- a/drivers/clk/microchip/clk-pic32mzda.c
+++ b/drivers/clk/microchip/clk-pic32mzda.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 1f1cff428d78..5fc6d486a381 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
diff --git a/drivers/clk/mvebu/armada-37xx-tbg.c b/drivers/clk/mvebu/armada-37xx-tbg.c
index ee272d4d8c24..585a02e0b330 100644
--- a/drivers/clk/mvebu/armada-37xx-tbg.c
+++ b/drivers/clk/mvebu/armada-37xx-tbg.c
@@ -9,6 +9,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/mvebu/clk-corediv.c b/drivers/clk/mvebu/clk-corediv.c
index 1fc84b0e72ee..818b175391fa 100644
--- a/drivers/clk/mvebu/clk-corediv.c
+++ b/drivers/clk/mvebu/clk-corediv.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
diff --git a/drivers/clk/nxp/clk-lpc18xx-ccu.c b/drivers/clk/nxp/clk-lpc18xx-ccu.c
index 5969f620607a..f2e171a01fb4 100644
--- a/drivers/clk/nxp/clk-lpc18xx-ccu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-ccu.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18xx-cgu.c
index f5bc8bd192b7..8b686da5577b 100644
--- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
index 7524d19fe60b..7f67c1036ff9 100644
--- a/drivers/clk/nxp/clk-lpc32xx.c
+++ b/drivers/clk/nxp/clk-lpc32xx.c
@@ -11,6 +11,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index 42627bf8a09e..5326f77eb35a 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -13,6 +13,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/io.h>
 #include <linux/of.h>
 
 #include <dt-bindings/clock/pxa-clock.h>
diff --git a/drivers/clk/renesas/clk-r8a73a4.c b/drivers/clk/renesas/clk-r8a73a4.c
index 2719c248c67b..cfed11c659d9 100644
--- a/drivers/clk/renesas/clk-r8a73a4.c
+++ b/drivers/clk/renesas/clk-r8a73a4.c
@@ -8,6 +8,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/of.h>
diff --git a/drivers/clk/renesas/clk-r8a7740.c b/drivers/clk/renesas/clk-r8a7740.c
index 5967656c13cc..d8190f007a81 100644
--- a/drivers/clk/renesas/clk-r8a7740.c
+++ b/drivers/clk/renesas/clk-r8a7740.c
@@ -8,6 +8,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/of.h>
diff --git a/drivers/clk/renesas/clk-rcar-gen2.c b/drivers/clk/renesas/clk-rcar-gen2.c
index 2913b4148157..da9fe3f032eb 100644
--- a/drivers/clk/renesas/clk-rcar-gen2.c
+++ b/drivers/clk/renesas/clk-rcar-gen2.c
@@ -10,6 +10,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/of.h>
diff --git a/drivers/clk/renesas/clk-rz.c b/drivers/clk/renesas/clk-rz.c
index 3cda53a97f4e..fbc34beafc78 100644
--- a/drivers/clk/renesas/clk-rz.c
+++ b/drivers/clk/renesas/clk-rz.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/renesas/clk-sh73a0.c b/drivers/clk/renesas/clk-sh73a0.c
index dc8ffc7c727a..5f25a70bc61c 100644
--- a/drivers/clk/renesas/clk-sh73a0.c
+++ b/drivers/clk/renesas/clk-sh73a0.c
@@ -8,6 +8,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clk/renesas.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 97c72477cd54..7d042183aa37 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -11,6 +11,7 @@
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/math64.h>
 #include <linux/of.h>
diff --git a/drivers/clk/renesas/rcar-usb2-clock-sel.c b/drivers/clk/renesas/rcar-usb2-clock-sel.c
index b241f9ca3d71..cc90b11a9c25 100644
--- a/drivers/clk/renesas/rcar-usb2-clock-sel.c
+++ b/drivers/clk/renesas/rcar-usb2-clock-sel.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index 30df0dc853f0..0201809bbd37 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
index 784b81e1ea7c..ba9f00dc9740 100644
--- a/drivers/clk/rockchip/clk-half-divider.c
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -3,8 +3,9 @@
  * Copyright (c) 2018 Fuzhou Rockchip Electronics Co., Ltd
  */
 
-#include <linux/slab.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
+#include <linux/slab.h>
 #include "clk.h"
 
 #define div_mask(width)	((1 << (width)) - 1)
diff --git a/drivers/clk/rockchip/clk-px30.c b/drivers/clk/rockchip/clk-px30.c
index 601a77f1af78..68d23be18cbc 100644
--- a/drivers/clk/rockchip/clk-px30.c
+++ b/drivers/clk/rockchip/clk-px30.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/rockchip/clk-rk3036.c b/drivers/clk/rockchip/clk-rk3036.c
index c3001980dbdc..3bf919b6c6e3 100644
--- a/drivers/clk/rockchip/clk-rk3036.c
+++ b/drivers/clk/rockchip/clk-rk3036.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/rockchip/clk-rk3128.c b/drivers/clk/rockchip/clk-rk3128.c
index 5970a50671b9..8278a54db343 100644
--- a/drivers/clk/rockchip/clk-rk3128.c
+++ b/drivers/clk/rockchip/clk-rk3128.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
index 5ecf28854876..378420b8835a 100644
--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -15,6 +15,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <dt-bindings/clock/rk3188-cru-common.h>
diff --git a/drivers/clk/rockchip/clk-rk3228.c b/drivers/clk/rockchip/clk-rk3228.c
index 7af48184b022..7176003b5c7c 100644
--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
index 24baeb56a1b3..85907f31c63f 100644
--- a/drivers/clk/rockchip/clk-rk3288.c
+++ b/drivers/clk/rockchip/clk-rk3288.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
index f12142d9cea2..9b03c1abf19c 100644
--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/rockchip/clk-rk3368.c b/drivers/clk/rockchip/clk-rk3368.c
index 7c4d242f19c1..d239bbc2fc77 100644
--- a/drivers/clk/rockchip/clk-rk3368.c
+++ b/drivers/clk/rockchip/clk-rk3368.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/rockchip/clk-rk3399.c b/drivers/clk/rockchip/clk-rk3399.c
index 5a628148f3f0..2322d712ba88 100644
--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
index 089cb17925e5..6c051aa04e59 100644
--- a/drivers/clk/rockchip/clk-rv1108.c
+++ b/drivers/clk/rockchip/clk-rv1108.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 0ea8e8080d1a..d5fac5a8a3d7 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/reboot.h>
diff --git a/drivers/clk/samsung/clk-cpu.c b/drivers/clk/samsung/clk-cpu.c
index a5fddebbe530..3f80bcd46074 100644
--- a/drivers/clk/samsung/clk-cpu.c
+++ b/drivers/clk/samsung/clk-cpu.c
@@ -33,6 +33,7 @@
 */
 
 #include <linux/errno.h>
+#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index 9c95390d2d77..ce41f36a0e29 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
diff --git a/drivers/clk/samsung/clk-exynos3250.c b/drivers/clk/samsung/clk-exynos3250.c
index 0e9a41a4cac8..facaad3c56a1 100644
--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 54066e6508d3..d2a68a792a21 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
index 8ae44b5db4c2..91db7894125d 100644
--- a/drivers/clk/samsung/clk-exynos5-subcmu.c
+++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
@@ -4,6 +4,7 @@
 // Author: Marek Szyprowski <m.szyprowski@samsung.com>
 // Common Clock Framework support for Exynos5 power-domain dependent clocks
 
+#include <linux/io.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index f14139bcb0c1..c8265c4cbc4f 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -12,6 +12,7 @@
 
 #include <dt-bindings/clock/exynos5250.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 1c4c7a3039f1..0c6782ceac48 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -13,7 +13,8 @@
 #include <linux/hrtimer.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/io.h>
 #include "clk.h"
 #include "clk-pll.h"
 
diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 82f8ae22fd34..0117e40c1d0a 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include "clk.h"
diff --git a/drivers/clk/samsung/clk-s3c2412.c b/drivers/clk/samsung/clk-s3c2412.c
index dd1159050a5a..ce21b89d1eb1 100644
--- a/drivers/clk/samsung/clk-s3c2412.c
+++ b/drivers/clk/samsung/clk-s3c2412.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reboot.h>
diff --git a/drivers/clk/samsung/clk-s3c2443.c b/drivers/clk/samsung/clk-s3c2443.c
index f38f0e24e3b6..b2ea4dfb5b8c 100644
--- a/drivers/clk/samsung/clk-s3c2443.c
+++ b/drivers/clk/samsung/clk-s3c2443.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reboot.h>
diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
index 1f6e47cd327d..9ad546a5f74c 100644
--- a/drivers/clk/samsung/clk.c
+++ b/drivers/clk/samsung/clk.c
@@ -15,6 +15,7 @@
 #include <linux/clkdev.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/syscore_ops.h>
 
diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index 0ec8bf7b4b28..6282ee2f361c 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -30,6 +30,7 @@
 #include <linux/clk/analogbits-wrpll-cln28hpc.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_clk.h>
diff --git a/drivers/clk/socfpga/clk-gate-s10.c b/drivers/clk/socfpga/clk-gate-s10.c
index eee2d48ab656..54a464fa63e0 100644
--- a/drivers/clk/socfpga/clk-gate-s10.c
+++ b/drivers/clk/socfpga/clk-gate-s10.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2017, Intel Corporation
  */
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/slab.h>
 #include "stratix10-clk.h"
 #include "clk.h"
diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
index 568f59b58ddf..5c50e723ecae 100644
--- a/drivers/clk/socfpga/clk-periph-s10.c
+++ b/drivers/clk/socfpga/clk-periph-s10.c
@@ -4,6 +4,7 @@
  */
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "stratix10-clk.h"
 #include "clk.h"
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index c4d0b6f6abf2..4705eb544f01 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -4,6 +4,7 @@
  */
 #include <linux/slab.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "stratix10-clk.h"
 #include "clk.h"
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index c514d39760cb..23497f07ad89 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
index 129ebd2588fd..2bbfb3343311 100644
--- a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
+++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index be0deee70182..d3fc1f5bf396 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 3c32d7798f27..9d3f98962779 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c b/drivers/clk/sunxi-ng/ccu-sun5i.c
index fa2c2dd77102..813e9bf73cbf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun5i.c
+++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
index 609970c0b666..b494c4fe0b2c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
+++ b/drivers/clk/sunxi-ng/ccu-sun6i-a31.c
@@ -16,6 +16,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 4b5f8f4e4ab8..a9c0c5406b85 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index c7bf814dfd2b..25bcf3fd2dfc 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 5f714b4d8ee4..be5920e8a9ca 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index e71e2451c2e3..0f3df565c6c1 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
index a22d11aa38ba..f9625f7b9ec2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index eada0e291859..ec64eb692ecf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index 8936ef87652c..0e23583e4f58 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 
diff --git a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
index dc9f0a365664..e748b8a6f3c5 100644
--- a/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
+++ b/drivers/clk/sunxi-ng/ccu-suniv-f1c100s.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 
 #include "ccu_common.h"
diff --git a/drivers/clk/sunxi-ng/ccu_div.c b/drivers/clk/sunxi-ng/ccu_div.c
index 302a18efd39f..6d407a8a61ee 100644
--- a/drivers/clk/sunxi-ng/ccu_div.c
+++ b/drivers/clk/sunxi-ng/ccu_div.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 #include "ccu_div.h"
diff --git a/drivers/clk/sunxi-ng/ccu_frac.c b/drivers/clk/sunxi-ng/ccu_frac.c
index d1d168d4c4f0..1842603f8f11 100644
--- a/drivers/clk/sunxi-ng/ccu_frac.c
+++ b/drivers/clk/sunxi-ng/ccu_frac.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/spinlock.h>
 
 #include "ccu_frac.h"
diff --git a/drivers/clk/sunxi-ng/ccu_gate.c b/drivers/clk/sunxi-ng/ccu_gate.c
index cd069d5da215..9c81644e9dfe 100644
--- a/drivers/clk/sunxi-ng/ccu_gate.c
+++ b/drivers/clk/sunxi-ng/ccu_gate.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 
diff --git a/drivers/clk/sunxi-ng/ccu_mmc_timing.c b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
index f9869f7353c0..b23410682088 100644
--- a/drivers/clk/sunxi-ng/ccu_mmc_timing.c
+++ b/drivers/clk/sunxi-ng/ccu_mmc_timing.c
@@ -13,6 +13,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/clk/sunxi-ng.h>
+#include <linux/io.h>
 
 #include "ccu_common.h"
 
diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.c
index 0357349eb767..e17fb4c9fcfe 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 #include "ccu_mp.h"
diff --git a/drivers/clk/sunxi-ng/ccu_mult.c b/drivers/clk/sunxi-ng/ccu_mult.c
index 12e0783caee6..c2a672797a74 100644
--- a/drivers/clk/sunxi-ng/ccu_mult.c
+++ b/drivers/clk/sunxi-ng/ccu_mult.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 #include "ccu_mult.h"
diff --git a/drivers/clk/sunxi-ng/ccu_mux.c b/drivers/clk/sunxi-ng/ccu_mux.c
index 312664155a54..f9b409c3a89c 100644
--- a/drivers/clk/sunxi-ng/ccu_mux.c
+++ b/drivers/clk/sunxi-ng/ccu_mux.c
@@ -11,6 +11,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 #include "ccu_mux.h"
diff --git a/drivers/clk/sunxi-ng/ccu_nk.c b/drivers/clk/sunxi-ng/ccu_nk.c
index 2485bda87a9a..50c7e6b1ba13 100644
--- a/drivers/clk/sunxi-ng/ccu_nk.c
+++ b/drivers/clk/sunxi-ng/ccu_nk.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 #include "ccu_nk.h"
diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
index 841840e35e61..aa5beaabc292 100644
--- a/drivers/clk/sunxi-ng/ccu_nkm.c
+++ b/drivers/clk/sunxi-ng/ccu_nkm.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkm.h"
diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
index cbcdf664f336..53ec4fb59880 100644
--- a/drivers/clk/sunxi-ng/ccu_nkmp.c
+++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_gate.h"
 #include "ccu_nkmp.h"
diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.c
index 424d8635b053..e15413174aa7 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "ccu_frac.h"
 #include "ccu_gate.h"
diff --git a/drivers/clk/sunxi-ng/ccu_phase.c b/drivers/clk/sunxi-ng/ccu_phase.c
index 400c58ad72fd..0a4a6fd13f5b 100644
--- a/drivers/clk/sunxi-ng/ccu_phase.c
+++ b/drivers/clk/sunxi-ng/ccu_phase.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/spinlock.h>
 
 #include "ccu_phase.h"
diff --git a/drivers/clk/sunxi-ng/ccu_sdm.c b/drivers/clk/sunxi-ng/ccu_sdm.c
index 3b3dc9bdf2b0..e510467ea24c 100644
--- a/drivers/clk/sunxi-ng/ccu_sdm.c
+++ b/drivers/clk/sunxi-ng/ccu_sdm.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/spinlock.h>
 
 #include "ccu_sdm.h"
diff --git a/drivers/clk/sunxi/clk-a10-mod1.c b/drivers/clk/sunxi/clk-a10-mod1.c
index e2819fa09637..9e6796a7b4c4 100644
--- a/drivers/clk/sunxi/clk-a10-mod1.c
+++ b/drivers/clk/sunxi/clk-a10-mod1.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-a10-pll2.c b/drivers/clk/sunxi/clk-a10-pll2.c
index d8eab90ae661..a709b6a551af 100644
--- a/drivers/clk/sunxi/clk-a10-pll2.c
+++ b/drivers/clk/sunxi/clk-a10-pll2.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-a10-ve.c b/drivers/clk/sunxi/clk-a10-ve.c
index d9ea22ec4e25..d119b453dccd 100644
--- a/drivers/clk/sunxi/clk-a10-ve.c
+++ b/drivers/clk/sunxi/clk-a10-ve.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/clk/sunxi/clk-a20-gmac.c b/drivers/clk/sunxi/clk-a20-gmac.c
index 3437f734c9bf..e6d639d9ea70 100644
--- a/drivers/clk/sunxi/clk-a20-gmac.c
+++ b/drivers/clk/sunxi/clk-a20-gmac.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
index fc0278a1acc7..915954507d0a 100644
--- a/drivers/clk/sunxi/clk-mod0.c
+++ b/drivers/clk/sunxi/clk-mod0.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index a085c3bc127c..8130467d647a 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-sun4i-display.c b/drivers/clk/sunxi/clk-sun4i-display.c
index 9780fac6d029..bb2dc83fc697 100644
--- a/drivers/clk/sunxi/clk-sun4i-display.c
+++ b/drivers/clk/sunxi/clk-sun4i-display.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of_address.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/clk/sunxi/clk-sun4i-pll3.c b/drivers/clk/sunxi/clk-sun4i-pll3.c
index f66267e77d9c..c879d7e25ca0 100644
--- a/drivers/clk/sunxi/clk-sun4i-pll3.c
+++ b/drivers/clk/sunxi/clk-sun4i-pll3.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
index b6d29d1bedca..af8ca5019639 100644
--- a/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
+++ b/drivers/clk/sunxi/clk-sun4i-tcon-ch1.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-sun8i-apb0.c b/drivers/clk/sunxi/clk-sun8i-apb0.c
index d5c31804ee54..5a7d4dd09e85 100644
--- a/drivers/clk/sunxi/clk-sun8i-apb0.c
+++ b/drivers/clk/sunxi/clk-sun8i-apb0.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
diff --git a/drivers/clk/sunxi/clk-sun8i-bus-gates.c b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
index bee305bdddbe..bfbcd71b225d 100644
--- a/drivers/clk/sunxi/clk-sun8i-bus-gates.c
+++ b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
@@ -18,6 +18,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
diff --git a/drivers/clk/sunxi/clk-sun8i-mbus.c b/drivers/clk/sunxi/clk-sun8i-mbus.c
index 56db89b6979f..0e924c9cbd5c 100644
--- a/drivers/clk/sunxi/clk-sun8i-mbus.c
+++ b/drivers/clk/sunxi/clk-sun8i-mbus.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/sunxi/clk-sun9i-cpus.c b/drivers/clk/sunxi/clk-sun9i-cpus.c
index 4d5e14142e15..01255d827fc9 100644
--- a/drivers/clk/sunxi/clk-sun9i-cpus.c
+++ b/drivers/clk/sunxi/clk-sun9i-cpus.c
@@ -10,6 +10,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/of.h>
diff --git a/drivers/clk/sunxi/clk-sun9i-mmc.c b/drivers/clk/sunxi/clk-sun9i-mmc.c
index f00d8758ba24..da264d0f7f4b 100644
--- a/drivers/clk/sunxi/clk-sun9i-mmc.c
+++ b/drivers/clk/sunxi/clk-sun9i-mmc.c
@@ -18,6 +18,7 @@
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/reset.h>
diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index 892c29030b7b..f5b1c0067365 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/clk/sunxi/clk-usb.c b/drivers/clk/sunxi/clk-usb.c
index 917fc27a33dd..7d15e0432ed4 100644
--- a/drivers/clk/sunxi/clk-usb.c
+++ b/drivers/clk/sunxi/clk-usb.c
@@ -16,6 +16,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/clk/tegra/clk-emc.c b/drivers/clk/tegra/clk-emc.c
index 93ecb538e59b..b7f763f0ecd8 100644
--- a/drivers/clk/tegra/clk-emc.c
+++ b/drivers/clk/tegra/clk-emc.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/clkdev.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
diff --git a/drivers/clk/tegra/clk-periph-fixed.c b/drivers/clk/tegra/clk-periph-fixed.c
index c57dfb037b10..956f2215c733 100644
--- a/drivers/clk/tegra/clk-periph-fixed.c
+++ b/drivers/clk/tegra/clk-periph-fixed.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "clk.h"
 
diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
index 473d418533cb..a5cd3e31dbae 100644
--- a/drivers/clk/tegra/clk-sdmmc-mux.c
+++ b/drivers/clk/tegra/clk-sdmmc-mux.c
@@ -12,6 +12,7 @@
 
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/types.h>
 
 #include "clk.h"
diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
index ffaf17f71860..6f2862eddad7 100644
--- a/drivers/clk/tegra/clk.c
+++ b/drivers/clk/tegra/clk.c
@@ -18,6 +18,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/clk/tegra.h>
 #include <linux/reset-controller.h>
diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index 0c210984765a..fdfb90058504 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -14,6 +14,7 @@
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index ba17cc5bd04b..e0b8ed3a1e80 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -19,6 +19,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/clk/ti.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/list.h>
diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index ed24f20f63c7..95e36ba64acc 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -13,6 +13,7 @@
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/math64.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
diff --git a/drivers/clk/versatile/clk-sp810.c b/drivers/clk/versatile/clk-sp810.c
index c2b6bb814742..4fa0cd951d2e 100644
--- a/drivers/clk/versatile/clk-sp810.c
+++ b/drivers/clk/versatile/clk-sp810.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 
diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index 19174835693b..5970edb6d334 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -17,6 +17,7 @@
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/platform_data/x86/clk-pmc-atom.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/cpufreq/loongson1-cpufreq.c b/drivers/cpufreq/loongson1-cpufreq.c
index be89416e2358..21c9ce8526c0 100644
--- a/drivers/cpufreq/loongson1-cpufreq.c
+++ b/drivers/cpufreq/loongson1-cpufreq.c
@@ -13,6 +13,7 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
index fb985ba1a176..2598741a00a6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/io.h>
 
 #include "sun4i_hdmi.h"
 
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 11702e1d9011..b138c2c4ca50 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -41,6 +41,7 @@
 #include <linux/component.h>
 #include <linux/dmaengine.h>
 #include <linux/i2c.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 22811784dc7d..00d5219094e5 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/errno.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index eedb7d48e2ea..772716ab6b23 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -20,6 +20,7 @@
 #include <linux/clkdev.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
diff --git a/drivers/mfd/intel-lpss.c b/drivers/mfd/intel-lpss.c
index 50bffc3382d7..c75734b35888 100644
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -18,6 +18,7 @@
 #include <linux/clk-provider.h>
 #include <linux/debugfs.h>
 #include <linux/idr.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index ec980bda071c..b61de360f26f 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
diff --git a/drivers/net/ieee802154/ca8210.c b/drivers/net/ieee802154/ca8210.c
index b2ff903a9cb6..b188fce3f641 100644
--- a/drivers/net/ieee802154/ca8210.c
+++ b/drivers/net/ieee802154/ca8210.c
@@ -53,6 +53,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/ieee802154.h>
+#include <linux/io.h>
 #include <linux/kfifo.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 491d992d045d..bb6118f79784 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -6,7 +6,6 @@
 #ifndef __LINUX_CLK_PROVIDER_H
 #define __LINUX_CLK_PROVIDER_H
 
-#include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_clk.h>
 
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 156aa7c00787..2bbb92ed96c8 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -26,6 +26,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <linux/time.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
Sent by a computer through tubes

