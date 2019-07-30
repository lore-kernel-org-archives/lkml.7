Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6671C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716DA2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 18:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T0MR/RiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387605AbfG3SUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 14:20:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37837 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfG3SQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 14:16:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so19736604pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 11:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=px/8sADDzE0T4NUQfC8QuPUlJOLkotDKLnvvXjVFwE4=;
        b=T0MR/RiBs5/kgxH4gCwoyWfcvA4fTsm5cGEiuzq9xPYEiUXN+bKVgLQd/35OCpIvKr
         BtN7b34IegB0MuTMRkEeKbV6xwbNwYgC6nWLB2/4RRnPQx59u42dxc6DTkM0YJpYqn9J
         K6gMq3qW4Yq7twE/LOG1cR2lgrfqB/hIyfr8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=px/8sADDzE0T4NUQfC8QuPUlJOLkotDKLnvvXjVFwE4=;
        b=ipiI9eS/O+Wj2BmmVV6oC+X1DBBi2UxfWUyx9Y2jFCAqQ10ozsB4w9cwYer5YcqW4h
         r6Guj+nhZkxX2F01US2Ej4swX6lMVGOQBsUHDZFj/hK/92Cxm7FZkY1grJ8V97H1XZuJ
         i+o0ezSU34IKErilM/ti/xMXrnQQ3gbMbEhMqBwYqSQIbzYCyVFqW3CI+MR1ZDMOW+sP
         Up3ddN6vsNZBImbhx7hWGgETFTfIdgaEoTE8pAndX7TPJivBBWSq8rd23b7wl9mR15XN
         NO6ABfOgCZ4XHKqkzTJxfEsAa84Q3QhPn+znFHdSHEn5YEAS/k9c/M1zp6VoZCRH0tDn
         8Pmw==
X-Gm-Message-State: APjAAAU9vS9ov3sYq50SBAF+NdGfLG91obA5KkB8gsOKOFwZ7R/wCs82
        AgmFcfbd6wvz5Vezr5nI4CvPGxHKVmk=
X-Google-Smtp-Source: APXvYqw2UhoM6Iuq/ZUqxfauHI3EeTeL44UkTy4tia+Z9NoWWih3tJ3Lft4xkHwldFFf09AmNm6KFw==
X-Received: by 2002:a63:3c5:: with SMTP id 188mr107937506pgd.394.1564510559219;
        Tue, 30 Jul 2019 11:15:59 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g1sm106744083pgg.27.2019.07.30.11.15.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 11:15:58 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v6 00/57] Add error message to platform_get_irq*()
Date:   Tue, 30 Jul 2019 11:15:00 -0700
Message-Id: <20190730181557.90391-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of patch 2/3 from the v5[1] series, but split 
up to be per-subsystem. Please apply patches directly to
subsystem trees if possible.

[1] https://lkml.kernel.org/r/20190730053845.126834-1-swboyd@chromium.org

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Stephen Boyd (57):
  ata: Remove dev_err() usage after platform_get_irq()
  bus: sunxi-rsb: Remove dev_err() usage after platform_get_irq()
  hwrng: Remove dev_err() usage after platform_get_irq()
  clocksource: Remove dev_err() usage after platform_get_irq()
  crypto: Remove dev_err() usage after platform_get_irq()
  cpufreq: Remove dev_err() usage after platform_get_irq()
  ARM: Remove dev_err() usage after platform_get_irq()
  MIPS: Remove dev_err() usage after platform_get_irq()
  devfreq: Remove dev_err() usage after platform_get_irq()
  dmaengine: Remove dev_err() usage after platform_get_irq()
  edac: Remove dev_err() usage after platform_get_irq()
  extcon: Remove dev_err() usage after platform_get_irq()
  firmware: Remove dev_err() usage after platform_get_irq()
  fpga: Remove dev_err() usage after platform_get_irq()
  gpio: Remove dev_err() usage after platform_get_irq()
  HSI: Remove dev_err() usage after platform_get_irq()
  hwmon: Remove dev_err() usage after platform_get_irq()
  i2c: Remove dev_err() usage after platform_get_irq()
  iio: Remove dev_err() usage after platform_get_irq()
  infiniband: Remove dev_err() usage after platform_get_irq()
  Input: Remove dev_err() usage after platform_get_irq()
  iommu: Remove dev_err() usage after platform_get_irq()
  irqchip: Remove dev_err() usage after platform_get_irq()
  mailbox: Remove dev_err() usage after platform_get_irq()
  media: Remove dev_err() usage after platform_get_irq()
  memory: Remove dev_err() usage after platform_get_irq()
  mfd: Remove dev_err() usage after platform_get_irq()
  pcie-gadget-spear: Remove dev_err() usage after platform_get_irq()
  mmc: Remove dev_err() usage after platform_get_irq()
  mtd: Remove dev_err() usage after platform_get_irq()
  pci: Remove dev_err() usage after platform_get_irq()
  perf: Remove dev_err() usage after platform_get_irq()
  pinctrl: Remove dev_err() usage after platform_get_irq()
  pinctrl: intel: Remove dev_err() usage after platform_get_irq()
  power: supply: Remove dev_err() usage after platform_get_irq()
  pwm: Remove dev_err() usage after platform_get_irq()
  regulator: Remove dev_err() usage after platform_get_irq()
  remoteproc: Remove dev_err() usage after platform_get_irq()
  rtc: Remove dev_err() usage after platform_get_irq()
  soc: Remove dev_err() usage after platform_get_irq()
  spi: Remove dev_err() usage after platform_get_irq()
  staging: Remove dev_err() usage after platform_get_irq()
  thermal: Remove dev_err() usage after platform_get_irq()
  tty: Remove dev_err() usage after platform_get_irq()
  uio: Remove dev_err() usage after platform_get_irq()
  usb: Remove dev_err() usage after platform_get_irq()
  video: Remove dev_err() usage after platform_get_irq()
  watchdog: Remove dev_err() usage after platform_get_irq()
  ASoC: Remove dev_err() usage after platform_get_irq()
  gpu: Remove dev_err() usage after platform_get_irq()
  net: Remove dev_err() usage after platform_get_irq()
  platform/x86: intel_pmc_ipc: Remove dev_err() usage after
    platform_get_irq()
  platform/mellanox: mlxreg-hotplug: Remove dev_err() usage after
    platform_get_irq()
  platform/x86: intel_bxtwc_tmu: Remove dev_err() usage after
    platform_get_irq()
  platform/x86: intel_int0002_vgpio: Remove dev_err() usage after
    platform_get_irq()
  scsi: Remove dev_err() usage after platform_get_irq()
  ALSA: x86: Remove dev_err() usage after platform_get_irq()

 arch/arm/plat-omap/dma.c                      |  1 -
 arch/arm/plat-pxa/ssp.c                       |  5 ++-
 arch/arm/plat-samsung/adc.c                   |  4 +--
 arch/mips/ralink/timer.c                      |  4 +--
 drivers/ata/libahci_platform.c                |  7 ++--
 drivers/ata/pata_rb532_cf.c                   |  4 +--
 drivers/ata/sata_highbank.c                   |  4 +--
 drivers/bus/sunxi-rsb.c                       |  4 +--
 drivers/char/hw_random/imx-rngc.c             |  4 +--
 drivers/char/hw_random/omap-rng.c             |  5 +--
 drivers/char/hw_random/xgene-rng.c            |  4 +--
 drivers/clocksource/em_sti.c                  |  4 +--
 drivers/clocksource/sh_cmt.c                  |  5 +--
 drivers/clocksource/sh_tmu.c                  |  5 +--
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |  2 --
 drivers/crypto/atmel-aes.c                    |  1 -
 drivers/crypto/atmel-sha.c                    |  1 -
 drivers/crypto/atmel-tdes.c                   |  1 -
 drivers/crypto/ccree/cc_driver.c              |  4 +--
 drivers/crypto/img-hash.c                     |  1 -
 drivers/crypto/mediatek/mtk-platform.c        |  4 +--
 drivers/crypto/mxs-dcp.c                      |  8 ++---
 drivers/crypto/omap-aes.c                     |  1 -
 drivers/crypto/omap-des.c                     |  1 -
 drivers/crypto/omap-sham.c                    |  1 -
 drivers/crypto/sahara.c                       |  4 +--
 drivers/crypto/stm32/stm32-cryp.c             |  4 +--
 drivers/crypto/stm32/stm32-hash.c             |  4 +--
 drivers/devfreq/tegra-devfreq.c               |  4 +--
 drivers/dma/dma-jz4780.c                      |  4 +--
 drivers/dma/fsl-edma.c                        |  8 ++---
 drivers/dma/fsl-qdma.c                        |  9 ++---
 drivers/dma/mediatek/mtk-uart-apdma.c         |  4 +--
 drivers/dma/qcom/hidma_mgmt.c                 |  1 -
 drivers/dma/s3c24xx-dma.c                     |  5 +--
 drivers/dma/sh/rcar-dmac.c                    |  4 +--
 drivers/dma/sh/usb-dmac.c                     |  4 +--
 drivers/dma/st_fdma.c                         |  4 +--
 drivers/dma/stm32-dma.c                       |  6 +---
 drivers/dma/stm32-mdma.c                      |  4 +--
 drivers/dma/sun4i-dma.c                       |  4 +--
 drivers/dma/sun6i-dma.c                       |  4 +--
 drivers/dma/uniphier-mdmac.c                  |  5 +--
 drivers/dma/xgene-dma.c                       |  8 ++---
 drivers/edac/altera_edac.c                    | 13 ++-----
 drivers/edac/xgene_edac.c                     |  1 -
 drivers/extcon/extcon-adc-jack.c              |  4 +--
 drivers/firmware/tegra/bpmp-tegra210.c        |  8 ++---
 drivers/fpga/zynq-fpga.c                      |  4 +--
 drivers/gpio/gpio-brcmstb.c                   |  4 +--
 drivers/gpio/gpio-eic-sprd.c                  |  4 +--
 drivers/gpio/gpio-grgpio.c                    |  2 --
 drivers/gpio/gpio-max77620.c                  |  4 +--
 drivers/gpio/gpio-pmic-eic-sprd.c             |  4 +--
 drivers/gpio/gpio-sprd.c                      |  4 +--
 drivers/gpio/gpio-tb10x.c                     |  4 +--
 drivers/gpio/gpio-tegra.c                     |  4 +--
 drivers/gpio/gpio-zx.c                        |  1 -
 drivers/gpio/gpio-zynq.c                      |  4 +--
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_dsi.c       |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |  1 -
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   |  4 +--
 drivers/gpu/drm/exynos/exynos_drm_scaler.c    |  4 +--
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  4 +--
 drivers/gpu/drm/imx/imx-tve.c                 |  4 +--
 drivers/gpu/drm/ingenic/ingenic-drm.c         |  4 +--
 drivers/gpu/drm/mediatek/mtk_cec.c            |  4 +--
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  4 +--
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  4 +--
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |  4 +--
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c      |  4 +--
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  4 +--
 drivers/gpu/drm/tegra/dc.c                    |  4 +--
 drivers/gpu/drm/tegra/dpaux.c                 |  4 +--
 drivers/gpu/drm/tegra/sor.c                   |  4 +--
 drivers/gpu/host1x/dev.c                      |  4 +--
 drivers/hsi/controllers/omap_ssi_core.c       |  4 +--
 drivers/hsi/controllers/omap_ssi_port.c       |  4 +--
 drivers/hwmon/jz4740-hwmon.c                  |  5 +--
 drivers/hwmon/npcm750-pwm-fan.c               |  4 +--
 drivers/i2c/busses/i2c-altera.c               |  4 +--
 drivers/i2c/busses/i2c-axxia.c                |  4 +--
 drivers/i2c/busses/i2c-bcm-kona.c             |  1 -
 drivers/i2c/busses/i2c-cht-wc.c               |  4 +--
 drivers/i2c/busses/i2c-efm32.c                |  1 -
 drivers/i2c/busses/i2c-hix5hd2.c              |  4 +--
 drivers/i2c/busses/i2c-img-scb.c              |  4 +--
 drivers/i2c/busses/i2c-imx-lpi2c.c            |  4 +--
 drivers/i2c/busses/i2c-imx.c                  |  4 +--
 drivers/i2c/busses/i2c-lpc2k.c                |  4 +--
 drivers/i2c/busses/i2c-meson.c                |  4 +--
 drivers/i2c/busses/i2c-omap.c                 |  4 +--
 drivers/i2c/busses/i2c-owl.c                  |  4 +--
 drivers/i2c/busses/i2c-pnx.c                  |  1 -
 drivers/i2c/busses/i2c-pxa.c                  |  4 +--
 drivers/i2c/busses/i2c-qcom-geni.c            |  4 +--
 drivers/i2c/busses/i2c-qup.c                  |  4 +--
 drivers/i2c/busses/i2c-rk3x.c                 |  4 +--
 drivers/i2c/busses/i2c-sprd.c                 |  4 +--
 drivers/i2c/busses/i2c-stm32f7.c              | 12 ++-----
 drivers/i2c/busses/i2c-sun6i-p2wi.c           |  4 +--
 drivers/i2c/busses/i2c-synquacer.c            |  4 +--
 drivers/i2c/busses/i2c-uniphier-f.c           |  4 +--
 drivers/i2c/busses/i2c-uniphier.c             |  4 +--
 drivers/i2c/busses/i2c-xlp9xx.c               |  6 ++--
 drivers/iio/adc/ad7606_par.c                  |  4 +--
 drivers/iio/adc/at91_adc.c                    |  4 +--
 drivers/iio/adc/axp288_adc.c                  |  4 +--
 drivers/iio/adc/bcm_iproc_adc.c               |  7 ++--
 drivers/iio/adc/da9150-gpadc.c                |  4 +--
 drivers/iio/adc/envelope-detector.c           |  5 +--
 drivers/iio/adc/exynos_adc.c                  |  4 +--
 drivers/iio/adc/fsl-imx25-gcq.c               |  1 -
 drivers/iio/adc/imx7d_adc.c                   |  4 +--
 drivers/iio/adc/lpc32xx_adc.c                 |  4 +--
 drivers/iio/adc/npcm_adc.c                    |  1 -
 drivers/iio/adc/rockchip_saradc.c             |  4 +--
 drivers/iio/adc/sc27xx_adc.c                  |  4 +--
 drivers/iio/adc/spear_adc.c                   |  1 -
 drivers/iio/adc/stm32-adc-core.c              |  1 -
 drivers/iio/adc/stm32-adc.c                   |  4 +--
 drivers/iio/adc/stm32-dfsdm-adc.c             |  5 +--
 drivers/iio/adc/sun4i-gpadc-iio.c             |  4 +--
 drivers/iio/adc/twl6030-gpadc.c               |  4 +--
 drivers/iio/adc/vf610_adc.c                   |  4 +--
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |  4 +--
 drivers/input/keyboard/bcm-keypad.c           |  4 +--
 drivers/input/keyboard/davinci_keyscan.c      |  1 -
 drivers/input/keyboard/imx_keypad.c           |  4 +--
 drivers/input/keyboard/lpc32xx-keys.c         |  4 +--
 drivers/input/keyboard/nomadik-ske-keypad.c   |  4 +--
 drivers/input/keyboard/nspire-keypad.c        |  4 +--
 drivers/input/keyboard/opencores-kbd.c        |  4 +--
 drivers/input/keyboard/pmic8xxx-keypad.c      |  8 ++---
 drivers/input/keyboard/pxa27x_keypad.c        |  4 +--
 drivers/input/keyboard/pxa930_rotary.c        |  4 +--
 drivers/input/keyboard/sh_keysc.c             |  4 +--
 drivers/input/keyboard/snvs_pwrkey.c          |  4 +--
 drivers/input/keyboard/spear-keyboard.c       |  4 +--
 drivers/input/keyboard/st-keyscan.c           |  4 +--
 drivers/input/keyboard/tegra-kbc.c            |  4 +--
 drivers/input/keyboard/w90p910_keypad.c       |  4 +--
 drivers/input/misc/88pm80x_onkey.c            |  1 -
 drivers/input/misc/88pm860x_onkey.c           |  4 +--
 drivers/input/misc/ab8500-ponkey.c            |  8 ++---
 drivers/input/misc/axp20x-pek.c               | 10 ++----
 drivers/input/misc/da9055_onkey.c             |  5 +--
 drivers/input/misc/da9063_onkey.c             |  7 ++--
 drivers/input/misc/e3x0-button.c              | 10 ++----
 drivers/input/misc/hisi_powerkey.c            |  8 ++---
 drivers/input/misc/max8925_onkey.c            |  8 ++---
 drivers/input/misc/pm8941-pwrkey.c            |  4 +--
 drivers/input/misc/rk805-pwrkey.c             |  8 ++---
 drivers/input/misc/stpmic1_onkey.c            | 10 ++----
 drivers/input/misc/tps65218-pwrbutton.c       |  4 +--
 drivers/input/misc/twl6040-vibra.c            |  4 +--
 drivers/input/mouse/pxa930_trkball.c          |  4 +--
 drivers/input/serio/arc_ps2.c                 |  4 +--
 drivers/input/serio/ps2-gpio.c                |  2 --
 drivers/input/touchscreen/88pm860x-ts.c       |  4 +--
 drivers/input/touchscreen/bcm_iproc_tsc.c     |  4 +--
 drivers/input/touchscreen/fsl-imx25-tcq.c     |  4 +--
 drivers/input/touchscreen/imx6ul_tsc.c        |  8 ++---
 drivers/input/touchscreen/lpc32xx_ts.c        |  4 +--
 drivers/iommu/exynos-iommu.c                  |  4 +--
 drivers/iommu/msm_iommu.c                     |  1 -
 drivers/iommu/qcom_iommu.c                    |  4 +--
 drivers/irqchip/irq-imgpdc.c                  |  8 ++---
 drivers/irqchip/irq-keystone.c                |  4 +--
 drivers/irqchip/qcom-irq-combiner.c           |  4 +--
 drivers/mailbox/armada-37xx-rwtm-mailbox.c    |  4 +--
 drivers/mailbox/platform_mhu.c                |  4 +--
 drivers/mailbox/stm32-ipcc.c                  |  5 ---
 drivers/mailbox/zynqmp-ipi-mailbox.c          |  4 +--
 drivers/media/platform/am437x/am437x-vpfe.c   |  1 -
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  7 ++--
 drivers/media/platform/exynos4-is/mipi-csis.c |  4 +--
 drivers/media/platform/imx-pxp.c              |  4 +--
 drivers/media/platform/omap3isp/isp.c         |  1 -
 drivers/media/platform/renesas-ceu.c          |  4 +--
 drivers/media/platform/rockchip/rga/rga.c     |  1 -
 drivers/media/platform/s3c-camif/camif-core.c |  4 +--
 .../platform/sti/c8sectpfe/c8sectpfe-core.c   |  8 ++---
 drivers/media/platform/sti/hva/hva-hw.c       |  8 ++---
 drivers/media/platform/stm32/stm32-dcmi.c     |  5 +--
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  7 ++--
 drivers/media/rc/img-ir/img-ir-core.c         |  4 +--
 drivers/media/rc/ir-hix5hd2.c                 |  4 +--
 drivers/media/rc/meson-ir.c                   |  4 +--
 drivers/media/rc/mtk-cir.c                    |  4 +--
 drivers/media/rc/sunxi-cir.c                  |  1 -
 drivers/memory/emif.c                         |  5 +--
 drivers/memory/tegra/mc.c                     |  4 +--
 drivers/mfd/ab8500-debugfs.c                  |  8 ++---
 drivers/mfd/db8500-prcmu.c                    |  4 +--
 drivers/mfd/fsl-imx25-tsadc.c                 |  4 +--
 drivers/mfd/intel_soc_pmic_bxtwc.c            |  4 +--
 drivers/mfd/jz4740-adc.c                      | 11 ++----
 drivers/mfd/qcom_rpm.c                        | 12 ++-----
 drivers/mfd/sm501.c                           |  4 +--
 drivers/misc/spear13xx_pcie_gadget.c          |  4 +--
 drivers/mmc/host/bcm2835.c                    |  1 -
 drivers/mmc/host/jz4740_mmc.c                 |  1 -
 drivers/mmc/host/meson-gx-mmc.c               |  1 -
 drivers/mmc/host/mxcmmc.c                     |  4 +--
 drivers/mmc/host/s3cmci.c                     |  1 -
 drivers/mmc/host/sdhci-msm.c                  |  2 --
 drivers/mmc/host/sdhci-pltfm.c                |  1 -
 drivers/mmc/host/sdhci-s3c.c                  |  4 +--
 drivers/mmc/host/sdhci_f_sdh30.c              |  4 +--
 drivers/mmc/host/uniphier-sd.c                |  4 +--
 drivers/mtd/devices/spear_smi.c               |  1 -
 drivers/mtd/nand/raw/denali_dt.c              |  4 +--
 drivers/mtd/nand/raw/hisi504_nand.c           |  4 +--
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |  1 -
 drivers/mtd/nand/raw/marvell_nand.c           |  4 +--
 drivers/mtd/nand/raw/meson_nand.c             |  4 +--
 drivers/mtd/nand/raw/mtk_ecc.c                |  4 +--
 drivers/mtd/nand/raw/mtk_nand.c               |  1 -
 drivers/mtd/nand/raw/omap2.c                  |  8 ++---
 drivers/mtd/nand/raw/sh_flctl.c               |  4 +--
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        |  5 +--
 drivers/mtd/nand/raw/sunxi_nand.c             |  4 +--
 drivers/mtd/spi-nor/cadence-quadspi.c         |  4 +--
 drivers/net/can/janz-ican3.c                  |  1 -
 drivers/net/can/rcar/rcar_can.c               |  1 -
 drivers/net/can/rcar/rcar_canfd.c             |  2 --
 drivers/net/can/sun4i_can.c                   |  1 -
 drivers/net/ethernet/amd/au1000_eth.c         |  1 -
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c | 14 ++------
 drivers/net/ethernet/apm/xgene-v2/main.c      |  4 +--
 .../net/ethernet/apm/xgene/xgene_enet_main.c  |  4 +--
 drivers/net/ethernet/aurora/nb8800.c          |  4 +--
 .../net/ethernet/broadcom/bgmac-platform.c    |  4 +--
 drivers/net/ethernet/cortina/gemini.c         |  4 +--
 drivers/net/ethernet/davicom/dm9000.c         |  2 --
 drivers/net/ethernet/hisilicon/hisi_femac.c   |  1 -
 drivers/net/ethernet/lantiq_xrx200.c          | 10 ++----
 drivers/net/ethernet/nuvoton/w90p910_ether.c  |  2 --
 drivers/net/ethernet/qualcomm/emac/emac.c     |  5 +--
 drivers/net/ethernet/socionext/sni_ave.c      |  4 +--
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  7 +---
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  7 +---
 .../net/wireless/mediatek/mt76/mt7603/soc.c   |  4 +--
 drivers/pci/controller/dwc/pci-dra7xx.c       |  8 ++---
 drivers/pci/controller/dwc/pci-exynos.c       |  8 ++---
 drivers/pci/controller/dwc/pci-imx6.c         |  4 +--
 drivers/pci/controller/dwc/pci-keystone.c     |  4 +--
 drivers/pci/controller/dwc/pci-meson.c        |  4 +--
 drivers/pci/controller/dwc/pcie-armada8k.c    |  4 +--
 drivers/pci/controller/dwc/pcie-artpec6.c     |  4 +--
 drivers/pci/controller/dwc/pcie-histb.c       |  4 +--
 drivers/pci/controller/dwc/pcie-kirin.c       |  5 +--
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  4 +--
 drivers/pci/controller/pci-tegra.c            |  8 ++---
 drivers/pci/controller/pci-v3-semi.c          |  4 +--
 drivers/pci/controller/pci-xgene-msi.c        |  2 --
 drivers/pci/controller/pcie-altera-msi.c      |  1 -
 drivers/pci/controller/pcie-altera.c          |  4 +--
 drivers/pci/controller/pcie-mobiveil.c        |  4 +--
 drivers/pci/controller/pcie-rockchip-host.c   | 12 ++-----
 drivers/pci/controller/pcie-tango.c           |  4 +--
 drivers/pci/controller/pcie-xilinx-nwl.c      | 11 ++----
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  4 +--
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  4 +--
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |  4 +--
 drivers/perf/qcom_l2_pmu.c                    |  6 +---
 drivers/perf/xgene_pmu.c                      |  4 +--
 drivers/pinctrl/intel/pinctrl-cherryview.c    |  4 +--
 drivers/pinctrl/intel/pinctrl-intel.c         |  4 +--
 drivers/pinctrl/pinctrl-amd.c                 |  4 +--
 drivers/pinctrl/pinctrl-oxnas.c               |  4 +--
 drivers/pinctrl/pinctrl-pic32.c               |  4 +--
 drivers/pinctrl/pinctrl-stmfx.c               |  4 +--
 drivers/pinctrl/qcom/pinctrl-msm.c            |  4 +--
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c       |  5 +--
 drivers/platform/mellanox/mlxreg-hotplug.c    |  5 +--
 drivers/platform/x86/intel_bxtwc_tmu.c        |  5 +--
 drivers/platform/x86/intel_int0002_vgpio.c    |  4 +--
 drivers/platform/x86/intel_pmc_ipc.c          |  4 +--
 drivers/power/supply/88pm860x_battery.c       |  8 ++---
 drivers/power/supply/axp288_charger.c         |  4 +--
 drivers/power/supply/bd70528-charger.c        |  5 +--
 drivers/power/supply/da9150-charger.c         |  8 ++---
 drivers/power/supply/da9150-fg.c              |  1 -
 drivers/power/supply/goldfish_battery.c       |  4 +--
 drivers/power/supply/jz4740-battery.c         |  4 +--
 drivers/power/supply/qcom_smbb.c              |  5 +--
 drivers/power/supply/sc27xx_fuel_gauge.c      |  4 +--
 drivers/pwm/pwm-sti.c                         |  4 +--
 drivers/regulator/da9062-regulator.c          |  4 +--
 drivers/regulator/da9063-regulator.c          |  4 +--
 drivers/remoteproc/da8xx_remoteproc.c         |  4 +--
 drivers/remoteproc/keystone_remoteproc.c      |  4 ---
 drivers/remoteproc/qcom_q6v5.c                | 35 +++----------------
 drivers/rtc/rtc-88pm80x.c                     |  1 -
 drivers/rtc/rtc-88pm860x.c                    |  4 +--
 drivers/rtc/rtc-ac100.c                       |  4 +--
 drivers/rtc/rtc-armada38x.c                   |  5 +--
 drivers/rtc/rtc-asm9260.c                     |  4 +--
 drivers/rtc/rtc-at91rm9200.c                  |  4 +--
 drivers/rtc/rtc-at91sam9.c                    |  4 +--
 drivers/rtc/rtc-bd70528.c                     |  5 +--
 drivers/rtc/rtc-davinci.c                     |  4 +--
 drivers/rtc/rtc-jz4740.c                      |  4 +--
 drivers/rtc/rtc-max77686.c                    |  5 +--
 drivers/rtc/rtc-mt7622.c                      |  1 -
 drivers/rtc/rtc-pic32.c                       |  4 +--
 drivers/rtc/rtc-pm8xxx.c                      |  4 +--
 drivers/rtc/rtc-puv3.c                        |  8 ++---
 drivers/rtc/rtc-pxa.c                         |  8 ++---
 drivers/rtc/rtc-rk808.c                       |  6 +---
 drivers/rtc/rtc-s3c.c                         |  8 ++---
 drivers/rtc/rtc-sc27xx.c                      |  4 +--
 drivers/rtc/rtc-spear.c                       |  4 +--
 drivers/rtc/rtc-stm32.c                       |  1 -
 drivers/rtc/rtc-sun6i.c                       |  4 +--
 drivers/rtc/rtc-sunxi.c                       |  4 +--
 drivers/rtc/rtc-tegra.c                       |  4 +--
 drivers/rtc/rtc-vt8500.c                      |  4 +--
 drivers/rtc/rtc-xgene.c                       |  4 +--
 drivers/rtc/rtc-zynqmp.c                      |  8 ++---
 drivers/scsi/ufs/ufshcd-pltfrm.c              |  1 -
 drivers/soc/fsl/qbman/bman_portal.c           |  4 +--
 drivers/soc/fsl/qbman/qman_portal.c           |  4 +--
 drivers/soc/qcom/smp2p.c                      |  4 +--
 drivers/spi/atmel-quadspi.c                   |  1 -
 drivers/spi/spi-armada-3700.c                 |  1 -
 drivers/spi/spi-bcm2835.c                     |  1 -
 drivers/spi/spi-bcm2835aux.c                  |  1 -
 drivers/spi/spi-bcm63xx-hsspi.c               |  4 +--
 drivers/spi/spi-bcm63xx.c                     |  4 +--
 drivers/spi/spi-cadence.c                     |  1 -
 drivers/spi/spi-dw-mmio.c                     |  4 +--
 drivers/spi/spi-efm32.c                       |  4 +--
 drivers/spi/spi-ep93xx.c                      |  4 +--
 drivers/spi/spi-fsl-dspi.c                    |  1 -
 drivers/spi/spi-fsl-qspi.c                    |  4 +--
 drivers/spi/spi-geni-qcom.c                   |  4 +--
 drivers/spi/spi-lantiq-ssc.c                  | 12 ++-----
 drivers/spi/spi-mt65xx.c                      |  1 -
 drivers/spi/spi-npcm-pspi.c                   |  1 -
 drivers/spi/spi-nuc900.c                      |  1 -
 drivers/spi/spi-nxp-fspi.c                    |  4 +--
 drivers/spi/spi-pic32-sqi.c                   |  1 -
 drivers/spi/spi-pic32.c                       | 12 ++-----
 drivers/spi/spi-qcom-qspi.c                   |  4 +--
 drivers/spi/spi-s3c24xx.c                     |  1 -
 drivers/spi/spi-sh-msiof.c                    |  1 -
 drivers/spi/spi-sh.c                          |  4 +--
 drivers/spi/spi-sifive.c                      |  1 -
 drivers/spi/spi-slave-mt27xx.c                |  1 -
 drivers/spi/spi-sprd.c                        |  4 +--
 drivers/spi/spi-stm32-qspi.c                  |  5 +--
 drivers/spi/spi-sun4i.c                       |  1 -
 drivers/spi/spi-sun6i.c                       |  1 -
 drivers/spi/spi-synquacer.c                   |  2 --
 drivers/spi/spi-ti-qspi.c                     |  1 -
 drivers/spi/spi-uniphier.c                    |  1 -
 drivers/spi/spi-xlp.c                         |  4 +--
 drivers/spi/spi-zynq-qspi.c                   |  1 -
 drivers/spi/spi-zynqmp-gqspi.c                |  1 -
 drivers/staging/emxx_udc/emxx_udc.c           |  4 +--
 drivers/staging/goldfish/goldfish_audio.c     |  4 +--
 .../staging/media/allegro-dvt/allegro-core.c  |  4 +--
 drivers/staging/media/hantro/hantro_drv.c     |  4 +--
 drivers/staging/media/imx/imx7-media-csi.c    |  4 +--
 drivers/staging/media/imx/imx7-mipi-csis.c    |  4 +--
 drivers/staging/media/meson/vdec/esparser.c   |  4 +--
 drivers/staging/media/omap4iss/iss.c          |  1 -
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  5 +--
 drivers/staging/most/dim2/dim2.c              |  2 --
 drivers/staging/mt7621-dma/mtk-hsdma.c        |  4 +--
 drivers/staging/nvec/nvec.c                   |  4 +--
 drivers/staging/ralink-gdma/ralink-gdma.c     |  4 +--
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  4 +--
 drivers/thermal/broadcom/brcmstb_thermal.c    |  4 +--
 drivers/thermal/da9062-thermal.c              |  4 +--
 drivers/thermal/db8500_thermal.c              |  2 --
 drivers/thermal/rockchip_thermal.c            |  4 +--
 drivers/thermal/st/st_thermal_memmap.c        |  4 +--
 drivers/thermal/st/stm_thermal.c              |  4 +--
 drivers/thermal/ti-soc-thermal/ti-bandgap.c   |  4 +--
 drivers/tty/serial/8250/8250_bcm2835aux.c     |  4 +--
 drivers/tty/serial/8250/8250_lpc18xx.c        |  4 +--
 drivers/tty/serial/8250/8250_uniphier.c       |  4 +--
 drivers/tty/serial/amba-pl011.c               |  5 +--
 drivers/tty/serial/fsl_lpuart.c               |  4 +--
 drivers/tty/serial/lpc32xx_hs.c               |  5 +--
 drivers/tty/serial/mvebu-uart.c               | 12 ++-----
 drivers/tty/serial/owl-uart.c                 |  4 +--
 drivers/tty/serial/qcom_geni_serial.c         |  4 +--
 drivers/tty/serial/rda-uart.c                 |  4 +--
 drivers/tty/serial/sccnxp.c                   |  1 -
 drivers/tty/serial/serial-tegra.c             |  4 +--
 drivers/tty/serial/sifive.c                   |  4 +--
 drivers/tty/serial/sprd_serial.c              |  4 +--
 drivers/tty/serial/stm32-usart.c              | 17 +++------
 drivers/uio/uio_dmem_genirq.c                 |  4 +--
 drivers/usb/chipidea/core.c                   |  1 -
 drivers/usb/dwc2/platform.c                   |  4 +--
 drivers/usb/dwc3/dwc3-keystone.c              |  1 -
 drivers/usb/dwc3/dwc3-omap.c                  |  4 +--
 drivers/usb/gadget/udc/aspeed-vhub/core.c     |  1 -
 drivers/usb/gadget/udc/bcm63xx_udc.c          |  8 ++---
 drivers/usb/gadget/udc/bdc/bdc_core.c         |  4 +--
 drivers/usb/gadget/udc/gr_udc.c               |  8 ++---
 drivers/usb/gadget/udc/lpc32xx_udc.c          |  5 +--
 drivers/usb/gadget/udc/renesas_usb3.c         |  4 +--
 drivers/usb/gadget/udc/s3c-hsudc.c            |  4 +--
 drivers/usb/gadget/udc/udc-xilinx.c           |  4 +--
 drivers/usb/host/ehci-atmel.c                 |  3 --
 drivers/usb/host/ehci-omap.c                  |  4 +--
 drivers/usb/host/ehci-orion.c                 |  3 --
 drivers/usb/host/ehci-platform.c              |  4 +--
 drivers/usb/host/ehci-sh.c                    |  3 --
 drivers/usb/host/ehci-st.c                    |  4 +--
 drivers/usb/host/imx21-hcd.c                  |  4 +--
 drivers/usb/host/ohci-platform.c              |  4 +--
 drivers/usb/host/ohci-st.c                    |  4 +--
 drivers/usb/mtu3/mtu3_core.c                  |  4 +--
 drivers/usb/phy/phy-ab8500-usb.c              | 12 ++-----
 drivers/usb/typec/tcpm/wcove.c                |  4 +--
 drivers/video/fbdev/atmel_lcdfb.c             |  1 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c         |  1 -
 drivers/video/fbdev/nuc900fb.c                |  4 +--
 drivers/video/fbdev/pxa168fb.c                |  4 +--
 drivers/video/fbdev/pxa3xx-gcu.c              |  4 +--
 drivers/video/fbdev/pxafb.c                   |  1 -
 drivers/video/fbdev/s3c2410fb.c               |  4 +--
 drivers/video/fbdev/vt8500lcdfb.c             |  1 -
 drivers/watchdog/sprd_wdt.c                   |  4 +--
 sound/soc/atmel/atmel-classd.c                |  7 ++--
 sound/soc/atmel/atmel-pdmic.c                 |  7 ++--
 sound/soc/bcm/cygnus-ssp.c                    |  7 ++--
 sound/soc/codecs/msm8916-wcd-analog.c         | 12 ++-----
 sound/soc/codecs/twl6040.c                    |  4 +--
 sound/soc/fsl/fsl_asrc.c                      |  4 +--
 sound/soc/fsl/fsl_esai.c                      |  4 +--
 sound/soc/fsl/fsl_sai.c                       |  4 +--
 sound/soc/fsl/fsl_spdif.c                     |  4 +--
 sound/soc/fsl/fsl_ssi.c                       |  4 +--
 sound/soc/fsl/imx-ssi.c                       |  4 +--
 sound/soc/kirkwood/kirkwood-i2s.c             |  4 +--
 sound/soc/mediatek/common/mtk-btcvsd.c        |  4 +--
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    |  4 +--
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    |  4 +--
 sound/soc/mxs/mxs-saif.c                      |  8 ++---
 sound/soc/qcom/lpass-platform.c               |  5 +--
 sound/soc/sof/intel/bdw.c                     |  5 +--
 sound/soc/sof/intel/byt.c                     |  5 +--
 sound/soc/sprd/sprd-mcdt.c                    |  4 +--
 sound/soc/sti/sti_uniperif.c                  |  4 +--
 sound/soc/stm/stm32_i2s.c                     |  5 +--
 sound/soc/stm/stm32_sai.c                     |  4 +--
 sound/soc/stm/stm32_spdifrx.c                 |  4 +--
 sound/soc/sunxi/sun4i-i2s.c                   |  4 +--
 sound/soc/uniphier/aio-dma.c                  |  4 +--
 sound/soc/xilinx/xlnx_formatter_pcm.c         |  2 --
 sound/soc/xtensa/xtfpga-i2s.c                 |  1 -
 sound/x86/intel_hdmi_audio.c                  |  4 +--
 462 files changed, 441 insertions(+), 1504 deletions(-)


base-commit: 7b5cf701ea9c395c792e2a7e3b7caf4c68b87721
prerequisite-patch-id: 3886b1af0c4ad13235927e24e92fd468caa724af
-- 
Sent by a computer through tubes

