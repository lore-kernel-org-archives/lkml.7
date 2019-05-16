Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40356C04E84
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0666F20818
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 23:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558047873;
	bh=mzzMctVIovZvB7ParEj6De2dE0P6UZy3NRxNEfa2dek=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kZDovfHvDrxncdFP4U93amoXM6BnoDozvw7CiaGDP343Ajy08/l3lkWYD47y9kKMB
	 9X2AIS7ZMCEMWk5mYHrQv9a3kmlOl0jZeBmNg8y8ajftcAD6kVbdfWWQCgiZfSumh4
	 czUzH8B8sMWmPUhGJ9FEUSPsd2XHBK/znTDZeEFI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfEPXEc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 19:04:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfEPXEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 19:04:31 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563ED20818;
        Thu, 16 May 2019 23:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558047870;
        bh=mzzMctVIovZvB7ParEj6De2dE0P6UZy3NRxNEfa2dek=;
        h=From:To:Cc:Subject:Date:From;
        b=NK60+qrgIdeFud7860UMDYSQCMMUN/6xzxjY9tAkFy2JdYAH1hrRpFSaELQZZDoHy
         kd7N/aFp1X15ODDjwjFboRQ+a+dyaROHAYZVJPpilYQZLXn3cunzQmzHNse7GGQImQ
         d4b+HPfEC7a7kpTrv4Et32spBieSWPpPFHQAUQ9Q=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] One more clk change for the merge window
Date:   Thu, 16 May 2019 16:04:29 -0700
Message-Id: <20190516230429.124276-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c1157f60d72e8b20efc670cef28883832f42406c:

  Merge branch 'clk-parent-rewrite-1' into clk-next (2019-05-07 11:46:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

for you to fetch changes up to 62e59c4e69b3cdbad67e3c2d49e4df4cfe1679e3:

  clk: Remove io.h from clk-provider.h (2019-05-15 13:21:37 -0700)

----------------------------------------------------------------
One more patch to remove io.h from clk-provider.h. We used to need this
include when we had clk_readl() and clk_writel(), but those are gone now
so this patch pushes the dependency out to the users of clk-provider.h.

----------------------------------------------------------------
Stephen Boyd (1):
      clk: Remove io.h from clk-provider.h

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

-- 
Sent by a computer through tubes
