Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D78CC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AA120665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 18:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dMWe4iJV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403801AbfGWSQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 14:16:40 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35469 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403777AbfGWSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 14:16:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id s1so13507761pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 11:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0BCFdeQkYnJ8SOMMoAwAMdy5P1wF0gMIntmw6BTfuRo=;
        b=dMWe4iJV+IxYEzHyeVH7LrBuGUIajfndCRV8Tpfw6kMHcoGbiGIYaY8RBADGJy4eO0
         K+Jq762+zIrraoZO6rOtIyvKqh08nrI71xD4PcG3oJ1RDxToCgeJFF5OSPu8tqUvc5PV
         krF5LtbS2ZChkidy+wqooSKilchuznQ1ADTy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0BCFdeQkYnJ8SOMMoAwAMdy5P1wF0gMIntmw6BTfuRo=;
        b=RNmFbjb82syhlaSW4qFCZxZRnJTeVA6OrTfcAr/cvmICse/5S654JkHO1nC90qer4C
         08I20ald2otkT0Q8ftIfP48s+SMpFsb+wbv5vTJrMXRH5VJzXhGvDH+qy9Tmhkd75TGV
         BJeW168FWnKq+9WPvK7fu0s5zTu7CfejRbx9rpBLwQ36TZB4BKFbvovSTfmSB4Ic3Ql7
         IEO+vlHgQvLbyv2mBR7KVqP7R27BApeUPyutfSdVhYaUDNr8JmxHwlBF4CNYhHNsjDGE
         BWDlaVDulLFom5rD01t0X/HyQQtgz4GK/0Dlm1JGSOaSJoRUya40WsTxZmxXePO9UJxk
         b2Sg==
X-Gm-Message-State: APjAAAVozuznZp1qmbJ/W2T1MI7YaQrohRjhSEWREF84Ay3DCWql/JPk
        tufgZ9df9/ZvubI3g2GpCSQZ2w==
X-Google-Smtp-Source: APXvYqw9Q7TVNf7DYtWmqSDNRQ9ZHGbGfmgvwId4ZC944+eMr7URXEK0wOYIkDQCNGByP2XTNbjzPg==
X-Received: by 2002:a63:5765:: with SMTP id h37mr44988272pgm.183.1563905788232;
        Tue, 23 Jul 2019 11:16:28 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k64sm24849104pge.65.2019.07.23.11.16.26
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 11:16:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v4 2/3] treewide: Remove dev_err() usage after platform_get_irq()
Date:   Tue, 23 Jul 2019 11:16:23 -0700
Message-Id: <20190723181624.203864-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
In-Reply-To: <20190723181624.203864-1-swboyd@chromium.org>
References: <20190723181624.203864-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

Cc: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I'm not Ccing anyone specifically besides those on the previous patch.

 arch/arm/plat-omap/dma.c                      |  1 -
 arch/arm/plat-pxa/ssp.c                       |  1 -
 arch/arm/plat-samsung/adc.c                   |  1 -
 arch/mips/ralink/timer.c                      |  1 -
 drivers/ata/libahci_platform.c                |  2 --
 drivers/ata/pata_rb532_cf.c                   |  1 -
 drivers/ata/sata_highbank.c                   |  1 -
 drivers/bus/sunxi-rsb.c                       |  1 -
 drivers/char/hw_random/imx-rngc.c             |  1 -
 drivers/char/hw_random/omap-rng.c             |  2 --
 drivers/char/hw_random/xgene-rng.c            |  1 -
 drivers/clocksource/em_sti.c                  |  1 -
 drivers/clocksource/sh_cmt.c                  |  2 --
 drivers/clocksource/sh_tmu.c                  |  2 --
 drivers/cpufreq/brcmstb-avs-cpufreq.c         |  2 --
 drivers/crypto/atmel-aes.c                    |  1 -
 drivers/crypto/atmel-sha.c                    |  1 -
 drivers/crypto/atmel-tdes.c                   |  1 -
 drivers/crypto/ccree/cc_driver.c              |  1 -
 drivers/crypto/img-hash.c                     |  1 -
 drivers/crypto/mediatek/mtk-platform.c        |  1 -
 drivers/crypto/mxs-dcp.c                      |  2 --
 drivers/crypto/omap-aes.c                     |  1 -
 drivers/crypto/omap-des.c                     |  1 -
 drivers/crypto/omap-sham.c                    |  1 -
 drivers/crypto/sahara.c                       |  1 -
 drivers/crypto/stm32/stm32-cryp.c             |  1 -
 drivers/crypto/stm32/stm32-hash.c             |  1 -
 drivers/devfreq/tegra-devfreq.c               |  1 -
 drivers/dma/dma-jz4780.c                      |  1 -
 drivers/dma/fsl-edma.c                        |  2 --
 drivers/dma/fsl-qdma.c                        |  3 ---
 drivers/dma/mediatek/mtk-uart-apdma.c         |  1 -
 drivers/dma/qcom/hidma_mgmt.c                 |  1 -
 drivers/dma/s3c24xx-dma.c                     |  2 --
 drivers/dma/sh/rcar-dmac.c                    |  1 -
 drivers/dma/sh/usb-dmac.c                     |  1 -
 drivers/dma/st_fdma.c                         |  1 -
 drivers/dma/stm32-dma.c                       |  3 ---
 drivers/dma/stm32-mdma.c                      |  1 -
 drivers/dma/sun4i-dma.c                       |  1 -
 drivers/dma/sun6i-dma.c                       |  1 -
 drivers/dma/uniphier-mdmac.c                  |  2 --
 drivers/dma/xgene-dma.c                       |  2 --
 drivers/edac/altera_edac.c                    |  2 --
 drivers/edac/xgene_edac.c                     |  1 -
 drivers/extcon/extcon-adc-jack.c              |  1 -
 drivers/firmware/tegra/bpmp-tegra210.c        |  2 --
 drivers/fpga/zynq-fpga.c                      |  1 -
 drivers/gpio/gpio-brcmstb.c                   |  1 -
 drivers/gpio/gpio-eic-sprd.c                  |  1 -
 drivers/gpio/gpio-grgpio.c                    |  2 --
 drivers/gpio/gpio-max77620.c                  |  1 -
 drivers/gpio/gpio-pmic-eic-sprd.c             |  1 -
 drivers/gpio/gpio-sprd.c                      |  1 -
 drivers/gpio/gpio-tb10x.c                     |  1 -
 drivers/gpio/gpio-tegra.c                     |  1 -
 drivers/gpio/gpio-zx.c                        |  1 -
 drivers/gpio/gpio-zynq.c                      |  1 -
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |  1 -
 drivers/gpu/drm/exynos/exynos_drm_dsi.c       |  1 -
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |  1 -
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   |  1 -
 drivers/gpu/drm/exynos/exynos_drm_scaler.c    |  1 -
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |  1 -
 drivers/gpu/drm/imx/imx-tve.c                 |  1 -
 drivers/gpu/drm/ingenic/ingenic-drm.c         |  1 -
 drivers/gpu/drm/mediatek/mtk_cec.c            |  1 -
 drivers/gpu/drm/mediatek/mtk_dpi.c            |  1 -
 drivers/gpu/drm/mediatek/mtk_dsi.c            |  1 -
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |  1 -
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c      |  1 -
 drivers/gpu/drm/sun4i/sun4i_tcon.c            |  1 -
 drivers/gpu/drm/tegra/dc.c                    |  1 -
 drivers/gpu/drm/tegra/dpaux.c                 |  1 -
 drivers/gpu/drm/tegra/sor.c                   |  1 -
 drivers/gpu/host1x/dev.c                      |  1 -
 drivers/hsi/controllers/omap_ssi_core.c       |  1 -
 drivers/hsi/controllers/omap_ssi_port.c       |  1 -
 drivers/hwmon/jz4740-hwmon.c                  |  2 --
 drivers/hwmon/npcm750-pwm-fan.c               |  1 -
 drivers/i2c/busses/i2c-altera.c               |  1 -
 drivers/i2c/busses/i2c-axxia.c                |  1 -
 drivers/i2c/busses/i2c-bcm-kona.c             |  1 -
 drivers/i2c/busses/i2c-cht-wc.c               |  1 -
 drivers/i2c/busses/i2c-efm32.c                |  1 -
 drivers/i2c/busses/i2c-hix5hd2.c              |  1 -
 drivers/i2c/busses/i2c-img-scb.c              |  1 -
 drivers/i2c/busses/i2c-imx-lpi2c.c            |  1 -
 drivers/i2c/busses/i2c-imx.c                  |  1 -
 drivers/i2c/busses/i2c-lpc2k.c                |  1 -
 drivers/i2c/busses/i2c-meson.c                |  1 -
 drivers/i2c/busses/i2c-omap.c                 |  1 -
 drivers/i2c/busses/i2c-owl.c                  |  1 -
 drivers/i2c/busses/i2c-pnx.c                  |  1 -
 drivers/i2c/busses/i2c-pxa.c                  |  1 -
 drivers/i2c/busses/i2c-qcom-geni.c            |  1 -
 drivers/i2c/busses/i2c-qup.c                  |  1 -
 drivers/i2c/busses/i2c-rk3x.c                 |  1 -
 drivers/i2c/busses/i2c-sprd.c                 |  1 -
 drivers/i2c/busses/i2c-stm32f7.c              |  6 ------
 drivers/i2c/busses/i2c-sun6i-p2wi.c           |  1 -
 drivers/i2c/busses/i2c-synquacer.c            |  1 -
 drivers/i2c/busses/i2c-uniphier-f.c           |  1 -
 drivers/i2c/busses/i2c-uniphier.c             |  1 -
 drivers/i2c/busses/i2c-xlp9xx.c               |  1 -
 drivers/iio/adc/ad7606_par.c                  |  1 -
 drivers/iio/adc/at91_adc.c                    |  1 -
 drivers/iio/adc/axp288_adc.c                  |  1 -
 drivers/iio/adc/bcm_iproc_adc.c               |  1 -
 drivers/iio/adc/da9150-gpadc.c                |  1 -
 drivers/iio/adc/envelope-detector.c           |  2 --
 drivers/iio/adc/exynos_adc.c                  |  1 -
 drivers/iio/adc/fsl-imx25-gcq.c               |  1 -
 drivers/iio/adc/imx7d_adc.c                   |  1 -
 drivers/iio/adc/lpc32xx_adc.c                 |  1 -
 drivers/iio/adc/npcm_adc.c                    |  1 -
 drivers/iio/adc/rockchip_saradc.c             |  1 -
 drivers/iio/adc/sc27xx_adc.c                  |  1 -
 drivers/iio/adc/spear_adc.c                   |  1 -
 drivers/iio/adc/stm32-adc-core.c              |  1 -
 drivers/iio/adc/stm32-adc.c                   |  1 -
 drivers/iio/adc/stm32-dfsdm-adc.c             |  2 --
 drivers/iio/adc/sun4i-gpadc-iio.c             |  1 -
 drivers/iio/adc/twl6030-gpadc.c               |  1 -
 drivers/iio/adc/vf610_adc.c                   |  1 -
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c    |  1 -
 drivers/input/keyboard/bcm-keypad.c           |  1 -
 drivers/input/keyboard/davinci_keyscan.c      |  1 -
 drivers/input/keyboard/imx_keypad.c           |  1 -
 drivers/input/keyboard/lpc32xx-keys.c         |  1 -
 drivers/input/keyboard/nomadik-ske-keypad.c   |  1 -
 drivers/input/keyboard/nspire-keypad.c        |  1 -
 drivers/input/keyboard/opencores-kbd.c        |  1 -
 drivers/input/keyboard/pmic8xxx-keypad.c      |  2 --
 drivers/input/keyboard/pxa27x_keypad.c        |  1 -
 drivers/input/keyboard/pxa930_rotary.c        |  1 -
 drivers/input/keyboard/sh_keysc.c             |  1 -
 drivers/input/keyboard/snvs_pwrkey.c          |  1 -
 drivers/input/keyboard/spear-keyboard.c       |  1 -
 drivers/input/keyboard/st-keyscan.c           |  1 -
 drivers/input/keyboard/tegra-kbc.c            |  1 -
 drivers/input/keyboard/w90p910_keypad.c       |  1 -
 drivers/input/misc/88pm80x_onkey.c            |  1 -
 drivers/input/misc/88pm860x_onkey.c           |  1 -
 drivers/input/misc/ab8500-ponkey.c            |  2 --
 drivers/input/misc/axp20x-pek.c               |  4 ----
 drivers/input/misc/da9055_onkey.c             |  2 --
 drivers/input/misc/da9063_onkey.c             |  1 -
 drivers/input/misc/e3x0-button.c              |  4 ----
 drivers/input/misc/hisi_powerkey.c            |  2 --
 drivers/input/misc/max8925_onkey.c            |  2 --
 drivers/input/misc/pm8941-pwrkey.c            |  1 -
 drivers/input/misc/rk805-pwrkey.c             |  2 --
 drivers/input/misc/stpmic1_onkey.c            |  4 ----
 drivers/input/misc/tps65218-pwrbutton.c       |  1 -
 drivers/input/misc/twl6040-vibra.c            |  1 -
 drivers/input/mouse/pxa930_trkball.c          |  1 -
 drivers/input/serio/arc_ps2.c                 |  1 -
 drivers/input/serio/ps2-gpio.c                |  2 --
 drivers/input/touchscreen/88pm860x-ts.c       |  1 -
 drivers/input/touchscreen/bcm_iproc_tsc.c     |  1 -
 drivers/input/touchscreen/fsl-imx25-tcq.c     |  1 -
 drivers/input/touchscreen/imx6ul_tsc.c        |  2 --
 drivers/input/touchscreen/lpc32xx_ts.c        |  1 -
 drivers/iommu/exynos-iommu.c                  |  1 -
 drivers/iommu/msm_iommu.c                     |  1 -
 drivers/iommu/qcom_iommu.c                    |  1 -
 drivers/irqchip/irq-imgpdc.c                  |  2 --
 drivers/irqchip/irq-keystone.c                |  1 -
 drivers/irqchip/qcom-irq-combiner.c           |  1 -
 drivers/mailbox/armada-37xx-rwtm-mailbox.c    |  1 -
 drivers/mailbox/platform_mhu.c                |  1 -
 drivers/mailbox/stm32-ipcc.c                  |  5 -----
 drivers/mailbox/zynqmp-ipi-mailbox.c          |  1 -
 drivers/media/platform/am437x/am437x-vpfe.c   |  1 -
 .../media/platform/atmel/atmel-sama5d2-isc.c  |  1 -
 drivers/media/platform/exynos4-is/mipi-csis.c |  1 -
 drivers/media/platform/imx-pxp.c              |  1 -
 drivers/media/platform/omap3isp/isp.c         |  1 -
 drivers/media/platform/renesas-ceu.c          |  1 -
 drivers/media/platform/rockchip/rga/rga.c     |  1 -
 drivers/media/platform/s3c-camif/camif-core.c |  1 -
 .../platform/sti/c8sectpfe/c8sectpfe-core.c   |  2 --
 drivers/media/platform/sti/hva/hva-hw.c       |  2 --
 drivers/media/platform/stm32/stm32-dcmi.c     |  2 --
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |  1 -
 drivers/media/rc/img-ir/img-ir-core.c         |  1 -
 drivers/media/rc/ir-hix5hd2.c                 |  1 -
 drivers/media/rc/meson-ir.c                   |  1 -
 drivers/media/rc/mtk-cir.c                    |  1 -
 drivers/media/rc/sunxi-cir.c                  |  1 -
 drivers/memory/emif.c                         |  2 --
 drivers/memory/tegra/mc.c                     |  1 -
 drivers/mfd/ab8500-debugfs.c                  |  2 --
 drivers/mfd/db8500-prcmu.c                    |  1 -
 drivers/mfd/fsl-imx25-tsadc.c                 |  1 -
 drivers/mfd/intel_soc_pmic_bxtwc.c            |  1 -
 drivers/mfd/jz4740-adc.c                      |  2 --
 drivers/mfd/qcom_rpm.c                        |  3 ---
 drivers/mfd/sm501.c                           |  1 -
 drivers/misc/spear13xx_pcie_gadget.c          |  1 -
 drivers/mmc/host/bcm2835.c                    |  1 -
 drivers/mmc/host/jz4740_mmc.c                 |  1 -
 drivers/mmc/host/meson-gx-mmc.c               |  1 -
 drivers/mmc/host/mxcmmc.c                     |  1 -
 drivers/mmc/host/s3cmci.c                     |  1 -
 drivers/mmc/host/sdhci-msm.c                  |  2 --
 drivers/mmc/host/sdhci-pltfm.c                |  1 -
 drivers/mmc/host/sdhci-s3c.c                  |  1 -
 drivers/mmc/host/sdhci_f_sdh30.c              |  1 -
 drivers/mmc/host/uniphier-sd.c                |  1 -
 drivers/mtd/devices/spear_smi.c               |  1 -
 drivers/mtd/nand/raw/denali_dt.c              |  1 -
 drivers/mtd/nand/raw/hisi504_nand.c           |  1 -
 drivers/mtd/nand/raw/lpc32xx_mlc.c            |  1 -
 drivers/mtd/nand/raw/marvell_nand.c           |  1 -
 drivers/mtd/nand/raw/meson_nand.c             |  1 -
 drivers/mtd/nand/raw/mtk_ecc.c                |  1 -
 drivers/mtd/nand/raw/mtk_nand.c               |  1 -
 drivers/mtd/nand/raw/omap2.c                  |  2 --
 drivers/mtd/nand/raw/sh_flctl.c               |  1 -
 drivers/mtd/nand/raw/stm32_fmc2_nand.c        |  2 --
 drivers/mtd/nand/raw/sunxi_nand.c             |  1 -
 drivers/mtd/spi-nor/cadence-quadspi.c         |  1 -
 drivers/net/can/janz-ican3.c                  |  1 -
 drivers/net/can/rcar/rcar_can.c               |  1 -
 drivers/net/can/rcar/rcar_canfd.c             |  2 --
 drivers/net/can/sun4i_can.c                   |  1 -
 drivers/net/ethernet/amd/au1000_eth.c         |  1 -
 drivers/net/ethernet/amd/xgbe/xgbe-platform.c |  2 --
 drivers/net/ethernet/apm/xgene-v2/main.c      |  1 -
 .../net/ethernet/apm/xgene/xgene_enet_main.c  |  1 -
 drivers/net/ethernet/aurora/nb8800.c          |  1 -
 .../net/ethernet/broadcom/bgmac-platform.c    |  1 -
 drivers/net/ethernet/cortina/gemini.c         |  1 -
 drivers/net/ethernet/davicom/dm9000.c         |  2 --
 drivers/net/ethernet/hisilicon/hisi_femac.c   |  1 -
 drivers/net/ethernet/lantiq_xrx200.c          |  4 ----
 drivers/net/ethernet/nuvoton/w90p910_ether.c  |  2 --
 drivers/net/ethernet/qualcomm/emac/emac.c     |  2 --
 drivers/net/ethernet/socionext/sni_ave.c      |  1 -
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  4 ----
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  4 ----
 .../net/wireless/mediatek/mt76/mt7603/soc.c   |  1 -
 drivers/pci/controller/dwc/pci-dra7xx.c       |  2 --
 drivers/pci/controller/dwc/pci-exynos.c       |  2 --
 drivers/pci/controller/dwc/pci-imx6.c         |  1 -
 drivers/pci/controller/dwc/pci-keystone.c     |  1 -
 drivers/pci/controller/dwc/pci-meson.c        |  1 -
 drivers/pci/controller/dwc/pcie-armada8k.c    |  1 -
 drivers/pci/controller/dwc/pcie-artpec6.c     |  1 -
 drivers/pci/controller/dwc/pcie-histb.c       |  1 -
 drivers/pci/controller/dwc/pcie-kirin.c       |  2 --
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 -
 drivers/pci/controller/pci-tegra.c            |  2 --
 drivers/pci/controller/pci-v3-semi.c          |  1 -
 drivers/pci/controller/pci-xgene-msi.c        |  2 --
 drivers/pci/controller/pcie-altera-msi.c      |  1 -
 drivers/pci/controller/pcie-altera.c          |  1 -
 drivers/pci/controller/pcie-mobiveil.c        |  1 -
 drivers/pci/controller/pcie-rockchip-host.c   |  3 ---
 drivers/pci/controller/pcie-tango.c           |  1 -
 drivers/pci/controller/pcie-xilinx-nwl.c      |  5 -----
 drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c |  1 -
 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c  |  1 -
 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c  |  1 -
 drivers/perf/qcom_l2_pmu.c                    |  3 ---
 drivers/perf/xgene_pmu.c                      |  1 -
 drivers/pinctrl/intel/pinctrl-cherryview.c    |  1 -
 drivers/pinctrl/intel/pinctrl-intel.c         |  1 -
 drivers/pinctrl/pinctrl-amd.c                 |  1 -
 drivers/pinctrl/pinctrl-oxnas.c               |  1 -
 drivers/pinctrl/pinctrl-pic32.c               |  1 -
 drivers/pinctrl/pinctrl-stmfx.c               |  1 -
 drivers/pinctrl/qcom/pinctrl-msm.c            |  1 -
 drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c       |  2 --
 drivers/platform/mellanox/mlxreg-hotplug.c    |  2 --
 drivers/platform/x86/intel_bxtwc_tmu.c        |  1 -
 drivers/platform/x86/intel_int0002_vgpio.c    |  1 -
 drivers/platform/x86/intel_pmc_ipc.c          |  1 -
 drivers/power/supply/88pm860x_battery.c       |  2 --
 drivers/power/supply/axp288_charger.c         |  1 -
 drivers/power/supply/bd70528-charger.c        |  2 --
 drivers/power/supply/da9150-charger.c         |  2 --
 drivers/power/supply/da9150-fg.c              |  1 -
 drivers/power/supply/goldfish_battery.c       |  1 -
 drivers/power/supply/jz4740-battery.c         |  1 -
 drivers/power/supply/qcom_smbb.c              |  2 --
 drivers/power/supply/sc27xx_fuel_gauge.c      |  1 -
 drivers/pwm/pwm-sti.c                         |  1 -
 drivers/regulator/da9062-regulator.c          |  1 -
 drivers/regulator/da9063-regulator.c          |  1 -
 drivers/remoteproc/da8xx_remoteproc.c         |  1 -
 drivers/remoteproc/keystone_remoteproc.c      |  4 ----
 drivers/remoteproc/qcom_q6v5.c                | 20 -------------------
 drivers/rtc/rtc-88pm80x.c                     |  1 -
 drivers/rtc/rtc-88pm860x.c                    |  1 -
 drivers/rtc/rtc-ac100.c                       |  1 -
 drivers/rtc/rtc-armada38x.c                   |  1 -
 drivers/rtc/rtc-asm9260.c                     |  1 -
 drivers/rtc/rtc-at91rm9200.c                  |  1 -
 drivers/rtc/rtc-at91sam9.c                    |  1 -
 drivers/rtc/rtc-bd70528.c                     |  1 -
 drivers/rtc/rtc-davinci.c                     |  1 -
 drivers/rtc/rtc-jz4740.c                      |  1 -
 drivers/rtc/rtc-max77686.c                    |  2 --
 drivers/rtc/rtc-mt7622.c                      |  1 -
 drivers/rtc/rtc-pic32.c                       |  1 -
 drivers/rtc/rtc-pm8xxx.c                      |  1 -
 drivers/rtc/rtc-puv3.c                        |  2 --
 drivers/rtc/rtc-pxa.c                         |  2 --
 drivers/rtc/rtc-rk808.c                       |  3 ---
 drivers/rtc/rtc-s3c.c                         |  2 --
 drivers/rtc/rtc-sc27xx.c                      |  1 -
 drivers/rtc/rtc-spear.c                       |  1 -
 drivers/rtc/rtc-stm32.c                       |  1 -
 drivers/rtc/rtc-sun6i.c                       |  1 -
 drivers/rtc/rtc-sunxi.c                       |  1 -
 drivers/rtc/rtc-tegra.c                       |  1 -
 drivers/rtc/rtc-vt8500.c                      |  1 -
 drivers/rtc/rtc-xgene.c                       |  1 -
 drivers/rtc/rtc-zynqmp.c                      |  2 --
 drivers/scsi/ufs/ufshcd-pltfrm.c              |  1 -
 drivers/soc/fsl/qbman/bman_portal.c           |  1 -
 drivers/soc/fsl/qbman/qman_portal.c           |  1 -
 drivers/soc/qcom/smp2p.c                      |  1 -
 drivers/spi/atmel-quadspi.c                   |  1 -
 drivers/spi/spi-armada-3700.c                 |  1 -
 drivers/spi/spi-bcm2835.c                     |  1 -
 drivers/spi/spi-bcm2835aux.c                  |  1 -
 drivers/spi/spi-bcm63xx-hsspi.c               |  1 -
 drivers/spi/spi-bcm63xx.c                     |  1 -
 drivers/spi/spi-cadence.c                     |  1 -
 drivers/spi/spi-dw-mmio.c                     |  1 -
 drivers/spi/spi-efm32.c                       |  1 -
 drivers/spi/spi-ep93xx.c                      |  1 -
 drivers/spi/spi-fsl-dspi.c                    |  1 -
 drivers/spi/spi-fsl-qspi.c                    |  1 -
 drivers/spi/spi-geni-qcom.c                   |  1 -
 drivers/spi/spi-lantiq-ssc.c                  |  3 ---
 drivers/spi/spi-mt65xx.c                      |  1 -
 drivers/spi/spi-npcm-pspi.c                   |  1 -
 drivers/spi/spi-nuc900.c                      |  1 -
 drivers/spi/spi-nxp-fspi.c                    |  1 -
 drivers/spi/spi-pic32-sqi.c                   |  1 -
 drivers/spi/spi-pic32.c                       |  3 ---
 drivers/spi/spi-qcom-qspi.c                   |  1 -
 drivers/spi/spi-s3c24xx.c                     |  1 -
 drivers/spi/spi-sh-msiof.c                    |  1 -
 drivers/spi/spi-sh.c                          |  1 -
 drivers/spi/spi-sifive.c                      |  1 -
 drivers/spi/spi-slave-mt27xx.c                |  1 -
 drivers/spi/spi-sprd.c                        |  1 -
 drivers/spi/spi-stm32-qspi.c                  |  2 --
 drivers/spi/spi-sun4i.c                       |  1 -
 drivers/spi/spi-sun6i.c                       |  1 -
 drivers/spi/spi-synquacer.c                   |  2 --
 drivers/spi/spi-ti-qspi.c                     |  1 -
 drivers/spi/spi-uniphier.c                    |  1 -
 drivers/spi/spi-xlp.c                         |  1 -
 drivers/spi/spi-zynq-qspi.c                   |  1 -
 drivers/spi/spi-zynqmp-gqspi.c                |  1 -
 drivers/staging/emxx_udc/emxx_udc.c           |  1 -
 drivers/staging/goldfish/goldfish_audio.c     |  1 -
 .../staging/media/allegro-dvt/allegro-core.c  |  1 -
 drivers/staging/media/hantro/hantro_drv.c     |  1 -
 drivers/staging/media/imx/imx7-media-csi.c    |  1 -
 drivers/staging/media/imx/imx7-mipi-csis.c    |  1 -
 drivers/staging/media/meson/vdec/esparser.c   |  1 -
 drivers/staging/media/omap4iss/iss.c          |  1 -
 .../staging/media/sunxi/cedrus/cedrus_hw.c    |  2 --
 drivers/staging/most/dim2/dim2.c              |  2 --
 drivers/staging/mt7621-dma/mtk-hsdma.c        |  1 -
 drivers/staging/nvec/nvec.c                   |  1 -
 drivers/staging/ralink-gdma/ralink-gdma.c     |  1 -
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  1 -
 drivers/thermal/broadcom/brcmstb_thermal.c    |  1 -
 drivers/thermal/da9062-thermal.c              |  1 -
 drivers/thermal/db8500_thermal.c              |  2 --
 drivers/thermal/rockchip_thermal.c            |  1 -
 drivers/thermal/st/st_thermal_memmap.c        |  1 -
 drivers/thermal/st/stm_thermal.c              |  1 -
 drivers/thermal/ti-soc-thermal/ti-bandgap.c   |  1 -
 drivers/tty/serial/8250/8250_bcm2835aux.c     |  1 -
 drivers/tty/serial/8250/8250_lpc18xx.c        |  1 -
 drivers/tty/serial/8250/8250_uniphier.c       |  1 -
 drivers/tty/serial/amba-pl011.c               |  2 --
 drivers/tty/serial/fsl_lpuart.c               |  1 -
 drivers/tty/serial/lpc32xx_hs.c               |  2 --
 drivers/tty/serial/mvebu-uart.c               |  3 ---
 drivers/tty/serial/owl-uart.c                 |  1 -
 drivers/tty/serial/qcom_geni_serial.c         |  1 -
 drivers/tty/serial/rda-uart.c                 |  1 -
 drivers/tty/serial/sccnxp.c                   |  1 -
 drivers/tty/serial/serial-tegra.c             |  1 -
 drivers/tty/serial/sifive.c                   |  1 -
 drivers/tty/serial/sprd_serial.c              |  1 -
 drivers/tty/serial/stm32-usart.c              |  2 --
 drivers/uio/uio_dmem_genirq.c                 |  1 -
 drivers/usb/chipidea/core.c                   |  1 -
 drivers/usb/dwc2/platform.c                   |  1 -
 drivers/usb/dwc3/dwc3-keystone.c              |  1 -
 drivers/usb/dwc3/dwc3-omap.c                  |  1 -
 drivers/usb/gadget/udc/aspeed-vhub/core.c     |  1 -
 drivers/usb/gadget/udc/bcm63xx_udc.c          |  2 --
 drivers/usb/gadget/udc/bdc/bdc_core.c         |  1 -
 drivers/usb/gadget/udc/gr_udc.c               |  2 --
 drivers/usb/gadget/udc/lpc32xx_udc.c          |  2 --
 drivers/usb/gadget/udc/renesas_usb3.c         |  1 -
 drivers/usb/gadget/udc/s3c-hsudc.c            |  1 -
 drivers/usb/gadget/udc/udc-xilinx.c           |  1 -
 drivers/usb/host/ehci-atmel.c                 |  3 ---
 drivers/usb/host/ehci-omap.c                  |  1 -
 drivers/usb/host/ehci-orion.c                 |  3 ---
 drivers/usb/host/ehci-platform.c              |  1 -
 drivers/usb/host/ehci-sh.c                    |  3 ---
 drivers/usb/host/ehci-st.c                    |  1 -
 drivers/usb/host/imx21-hcd.c                  |  1 -
 drivers/usb/host/ohci-platform.c              |  1 -
 drivers/usb/host/ohci-st.c                    |  1 -
 drivers/usb/mtu3/mtu3_core.c                  |  1 -
 drivers/usb/phy/phy-ab8500-usb.c              |  3 ---
 drivers/usb/typec/tcpm/wcove.c                |  1 -
 drivers/video/fbdev/atmel_lcdfb.c             |  1 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c         |  1 -
 drivers/video/fbdev/nuc900fb.c                |  1 -
 drivers/video/fbdev/pxa168fb.c                |  1 -
 drivers/video/fbdev/pxa3xx-gcu.c              |  1 -
 drivers/video/fbdev/pxafb.c                   |  1 -
 drivers/video/fbdev/s3c2410fb.c               |  1 -
 drivers/video/fbdev/vt8500lcdfb.c             |  1 -
 drivers/watchdog/sprd_wdt.c                   |  1 -
 sound/soc/atmel/atmel-classd.c                |  1 -
 sound/soc/atmel/atmel-pdmic.c                 |  1 -
 sound/soc/bcm/cygnus-ssp.c                    |  1 -
 sound/soc/codecs/msm8916-wcd-analog.c         |  3 ---
 sound/soc/codecs/twl6040.c                    |  1 -
 sound/soc/fsl/fsl_asrc.c                      |  1 -
 sound/soc/fsl/fsl_esai.c                      |  1 -
 sound/soc/fsl/fsl_sai.c                       |  1 -
 sound/soc/fsl/fsl_spdif.c                     |  1 -
 sound/soc/fsl/fsl_ssi.c                       |  1 -
 sound/soc/fsl/imx-ssi.c                       |  1 -
 sound/soc/kirkwood/kirkwood-i2s.c             |  1 -
 sound/soc/mediatek/common/mtk-btcvsd.c        |  1 -
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c    |  1 -
 sound/soc/mediatek/mt8173/mt8173-afe-pcm.c    |  1 -
 sound/soc/mxs/mxs-saif.c                      |  2 --
 sound/soc/qcom/lpass-platform.c               |  2 --
 sound/soc/sof/intel/bdw.c                     |  2 --
 sound/soc/sof/intel/byt.c                     |  2 --
 sound/soc/sprd/sprd-mcdt.c                    |  1 -
 sound/soc/sti/sti_uniperif.c                  |  1 -
 sound/soc/stm/stm32_i2s.c                     |  2 --
 sound/soc/stm/stm32_sai.c                     |  1 -
 sound/soc/stm/stm32_spdifrx.c                 |  1 -
 sound/soc/sunxi/sun4i-i2s.c                   |  1 -
 sound/soc/uniphier/aio-dma.c                  |  1 -
 sound/soc/xilinx/xlnx_formatter_pcm.c         |  2 --
 sound/soc/xtensa/xtfpga-i2s.c                 |  1 -
 sound/x86/intel_hdmi_audio.c                  |  1 -
 462 files changed, 615 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 79f43acf9acb..9386b2e9b332 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1371,7 +1371,6 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		strcpy(irq_name, "0");
 		dma_irq = platform_get_irq_byname(pdev, irq_name);
 		if (dma_irq < 0) {
-			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
 			ret = dma_irq;
 			goto exit_dma_lch_fail;
 		}
diff --git a/arch/arm/plat-pxa/ssp.c b/arch/arm/plat-pxa/ssp.c
index 9a6e4923bd69..42a2297e4a73 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -147,7 +147,6 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 
 	ssp->irq = platform_get_irq(pdev, 0);
 	if (ssp->irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
 		return -ENODEV;
 	}
 
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index ee3d5c989a76..621d587ee9c1 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -355,7 +355,6 @@ static int s3c_adc_probe(struct platform_device *pdev)
 
 	adc->irq = platform_get_irq(pdev, 1);
 	if (adc->irq <= 0) {
-		dev_err(dev, "failed to get adc irq\n");
 		return -ENOENT;
 	}
 
diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index 0ad8ff2e4f6e..1e0a5c95dcf6 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -107,7 +107,6 @@ static int rt_timer_probe(struct platform_device *pdev)
 
 	rt->irq = platform_get_irq(pdev, 0);
 	if (rt->irq < 0) {
-		dev_err(&pdev->dev, "failed to load irq\n");
 		return rt->irq;
 	}
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 72312ad2e142..a3f8972925ca 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -584,8 +584,6 @@ int ahci_platform_init_host(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
 		return irq;
 	}
 
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 7c37f2ff09e4..9d8a9765a850 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -116,7 +116,6 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
 		return -ENOENT;
 	}
 
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index ad3893c62572..669ea2239019 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -470,7 +470,6 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 1b76d9585902..6678ce0bd963 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -652,7 +652,6 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 69f537980004..7532d83fb104 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -217,7 +217,6 @@ static int imx_rngc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "Couldn't get irq %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index e9b6ac61fb7f..e1455a03a7bc 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -386,8 +386,6 @@ static int of_get_omap_rng_device_details(struct omap_rng_dev *priv,
 	    of_device_is_compatible(dev->of_node, "inside-secure,safexcel-eip76")) {
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0) {
-			dev_err(dev, "%s: error getting IRQ resource - %d\n",
-				__func__, irq);
 			return irq;
 		}
 
diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 8c6f9f63da5e..b3d26b7b9397 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -331,7 +331,6 @@ static int xgene_rng_probe(struct platform_device *pdev)
 
 	rc = platform_get_irq(pdev, 0);
 	if (rc < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		return rc;
 	}
 	ctx->irq = rc;
diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 8e12b11e81b0..43ddf208cb66 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -292,7 +292,6 @@ static int em_sti_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 55d3e03f2cd4..8238e1cef970 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -777,8 +777,6 @@ static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 
 	irq = platform_get_irq(ch->cmt->pdev, ch->index);
 	if (irq < 0) {
-		dev_err(&ch->cmt->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
 		return irq;
 	}
 
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 49f1c805fc95..9d649a87f82d 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -463,8 +463,6 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 
 	ch->irq = platform_get_irq(tmu->pdev, index);
 	if (ch->irq < 0) {
-		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
 		return ch->irq;
 	}
 
diff --git a/drivers/cpufreq/brcmstb-avs-cpufreq.c b/drivers/cpufreq/brcmstb-avs-cpufreq.c
index 77b0e5d0fb13..27057c8bf035 100644
--- a/drivers/cpufreq/brcmstb-avs-cpufreq.c
+++ b/drivers/cpufreq/brcmstb-avs-cpufreq.c
@@ -538,8 +538,6 @@ static int brcm_avs_prepare_init(struct platform_device *pdev)
 
 	host_irq = platform_get_irq_byname(pdev, BRCM_AVS_HOST_INTR);
 	if (host_irq < 0) {
-		dev_err(dev, "Couldn't find interrupt %s -- %d\n",
-			BRCM_AVS_HOST_INTR, host_irq);
 		ret = host_irq;
 		goto unmap_intr_base;
 	}
diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
index 2b7af44c7b85..026f193556f9 100644
--- a/drivers/crypto/atmel-aes.c
+++ b/drivers/crypto/atmel-aes.c
@@ -2673,7 +2673,6 @@ static int atmel_aes_probe(struct platform_device *pdev)
 	/* Get the IRQ */
 	aes_dd->irq = platform_get_irq(pdev,  0);
 	if (aes_dd->irq < 0) {
-		dev_err(dev, "no IRQ resource info\n");
 		err = aes_dd->irq;
 		goto res_err;
 	}
diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index ab0cfe748931..84cb8748a795 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -2779,7 +2779,6 @@ static int atmel_sha_probe(struct platform_device *pdev)
 	/* Get the IRQ */
 	sha_dd->irq = platform_get_irq(pdev,  0);
 	if (sha_dd->irq < 0) {
-		dev_err(dev, "no IRQ resource info\n");
 		err = sha_dd->irq;
 		goto res_err;
 	}
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index fa76620281e8..6256883a89ed 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1281,7 +1281,6 @@ static int atmel_tdes_probe(struct platform_device *pdev)
 	/* Get the IRQ */
 	tdes_dd->irq = platform_get_irq(pdev,  0);
 	if (tdes_dd->irq < 0) {
-		dev_err(dev, "no IRQ resource info\n");
 		err = tdes_dd->irq;
 		goto res_err;
 	}
diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 980aa04b655b..eb5a1015c3b3 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -340,7 +340,6 @@ static int init_cc_resources(struct platform_device *plat_dev)
 	/* Then IRQ */
 	new_drvdata->irq = platform_get_irq(plat_dev, 0);
 	if (new_drvdata->irq < 0) {
-		dev_err(dev, "Failed getting IRQ resource\n");
 		return new_drvdata->irq;
 	}
 
diff --git a/drivers/crypto/img-hash.c b/drivers/crypto/img-hash.c
index d27c812c3d8d..6754eaafdc85 100644
--- a/drivers/crypto/img-hash.c
+++ b/drivers/crypto/img-hash.c
@@ -980,7 +980,6 @@ static int img_hash_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no IRQ resource info\n");
 		err = irq;
 		goto res_err;
 	}
diff --git a/drivers/crypto/mediatek/mtk-platform.c b/drivers/crypto/mediatek/mtk-platform.c
index 125318a88cd4..f396c8e1777f 100644
--- a/drivers/crypto/mediatek/mtk-platform.c
+++ b/drivers/crypto/mediatek/mtk-platform.c
@@ -496,7 +496,6 @@ static int mtk_crypto_probe(struct platform_device *pdev)
 	for (i = 0; i < MTK_IRQ_NUM; i++) {
 		cryp->irq[i] = platform_get_irq(pdev, i);
 		if (cryp->irq[i] < 0) {
-			dev_err(cryp->dev, "no IRQ:%d resource info\n", i);
 			return cryp->irq[i];
 		}
 	}
diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index f1fa637cb029..cc7710a5ca62 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -995,13 +995,11 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 
 	dcp_vmi_irq = platform_get_irq(pdev, 0);
 	if (dcp_vmi_irq < 0) {
-		dev_err(dev, "Failed to get IRQ: (%d)!\n", dcp_vmi_irq);
 		return dcp_vmi_irq;
 	}
 
 	dcp_irq = platform_get_irq(pdev, 1);
 	if (dcp_irq < 0) {
-		dev_err(dev, "Failed to get IRQ: (%d)!\n", dcp_irq);
 		return dcp_irq;
 	}
 
diff --git a/drivers/crypto/omap-aes.c b/drivers/crypto/omap-aes.c
index 45a4647f7030..2f53fbb74100 100644
--- a/drivers/crypto/omap-aes.c
+++ b/drivers/crypto/omap-aes.c
@@ -1180,7 +1180,6 @@ static int omap_aes_probe(struct platform_device *pdev)
 
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0) {
-			dev_err(dev, "can't get IRQ resource\n");
 			err = irq;
 			goto err_irq;
 		}
diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 1ee69a979677..484a693122af 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -1049,7 +1049,6 @@ static int omap_des_probe(struct platform_device *pdev)
 
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0) {
-			dev_err(dev, "can't get IRQ resource: %d\n", irq);
 			err = irq;
 			goto err_irq;
 		}
diff --git a/drivers/crypto/omap-sham.c b/drivers/crypto/omap-sham.c
index e8e2907bd9f4..ac80bc6af093 100644
--- a/drivers/crypto/omap-sham.c
+++ b/drivers/crypto/omap-sham.c
@@ -1989,7 +1989,6 @@ static int omap_sham_get_res_pdev(struct omap_sham_dev *dd,
 	/* Get the IRQ */
 	dd->irq = platform_get_irq(pdev, 0);
 	if (dd->irq < 0) {
-		dev_err(dev, "no IRQ resource info\n");
 		err = dd->irq;
 		goto err;
 	}
diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index b0b8e3d48aef..3283eb11a084 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -1404,7 +1404,6 @@ static int sahara_probe(struct platform_device *pdev)
 	/* Get the IRQ */
 	irq = platform_get_irq(pdev,  0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
 		return irq;
 	}
 
diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 98ae02826e8f..bfd922b52c93 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -1976,7 +1976,6 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Cannot get IRQ resource\n");
 		return irq;
 	}
 
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 2b70d8796f25..bf441be85a0c 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1451,7 +1451,6 @@ static int stm32_hash_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Cannot get IRQ resource\n");
 		return irq;
 	}
 
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 35c38aad8b4f..8439217b1196 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -675,7 +675,6 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7fe9309a876b..0397acc6923a 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -879,7 +879,6 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index fcbad6ae954a..4bbc218c8a48 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -126,13 +126,11 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
 	if (fsl_edma->txirq < 0) {
-		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
 		return fsl_edma->txirq;
 	}
 
 	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
 	if (fsl_edma->errirq < 0) {
-		dev_err(&pdev->dev, "Can't get edma-err irq.\n");
 		return fsl_edma->errirq;
 	}
 
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 8e341c0c13bc..334b506b1e7c 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -759,7 +759,6 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
 	if (fsl_qdma->error_irq < 0) {
-		dev_err(&pdev->dev, "Can't get qdma controller irq.\n");
 		return fsl_qdma->error_irq;
 	}
 
@@ -777,8 +776,6 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 				platform_get_irq_byname(pdev, irq_name);
 
 		if (fsl_qdma->queue_irq[i] < 0) {
-			dev_err(&pdev->dev,
-				"Can't get qdma queue %d irq.\n", i);
 			return fsl_qdma->queue_irq[i];
 		}
 
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 546995c20876..75c1be372c31 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -548,7 +548,6 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 
 		rc = platform_get_irq(pdev, i);
 		if (rc < 0) {
-			dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
 			goto err_no_dma;
 		}
 		c->irq = rc;
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 3022d66e7a33..7cb81a50f3f3 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -183,7 +183,6 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "irq resources not found\n");
 		rc = irq;
 		goto out;
 	}
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index ad30f3d2c7f6..1f7dfdfd6dd8 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1238,8 +1238,6 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 
 		phy->irq = platform_get_irq(pdev, i);
 		if (phy->irq < 0) {
-			dev_err(&pdev->dev, "failed to get irq %d, err %d\n",
-				i, phy->irq);
 			continue;
 		}
 
diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 9c41a4e42575..5e9b6c8d3bf3 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1745,7 +1745,6 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	sprintf(pdev_irqname, "ch%u", index);
 	rchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
 	if (rchan->irq < 0) {
-		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
 		return -ENODEV;
 	}
 
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 17063aaf51bc..61bebf199e7b 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -718,7 +718,6 @@ static int usb_dmac_chan_probe(struct usb_dmac *dmac,
 	sprintf(pdev_irqname, "ch%u", index);
 	uchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
 	if (uchan->irq < 0) {
-		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
 		return -ENODEV;
 	}
 
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index a3ee0f6bb664..fdf01ead1db1 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -772,7 +772,6 @@ static int st_fdma_probe(struct platform_device *pdev)
 
 	fdev->irq = platform_get_irq(pdev, 0);
 	if (fdev->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq resource\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index ef4d109e7189..f9720991aa4d 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1367,9 +1367,6 @@ static int stm32_dma_probe(struct platform_device *pdev)
 		chan = &dmadev->chan[i];
 		ret = platform_get_irq(pdev, i);
 		if (ret < 0)  {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"No irq resource for chan %d\n", i);
 			goto err_unregister;
 		}
 		chan->irq = ret;
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index d6e919d3936a..29215e4806b9 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1639,7 +1639,6 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 
 	dmadev->irq = platform_get_irq(pdev, 0);
 	if (dmadev->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		return dmadev->irq;
 	}
 
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 1f80568b2613..3399296da306 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1133,7 +1133,6 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
 		return priv->irq;
 	}
 
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ed5b68dcfe50..4c10548b5fed 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1252,7 +1252,6 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 
 	sdc->irq = platform_get_irq(pdev, 0);
 	if (sdc->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
 		return sdc->irq;
 	}
 
diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index ec65a7430dc4..22104b02fd60 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -355,8 +355,6 @@ static int uniphier_mdmac_chan_init(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, chan_id);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
-			chan_id);
 		return irq;
 	}
 
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 957c269ce1fd..68a7dbb0bf51 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1679,7 +1679,6 @@ static int xgene_dma_get_resources(struct platform_device *pdev,
 	/* Get DMA error interrupt */
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "Failed to get Error IRQ\n");
 		return -ENXIO;
 	}
 
@@ -1689,7 +1688,6 @@ static int xgene_dma_get_resources(struct platform_device *pdev,
 	for (i = 1; i <= XGENE_DMA_MAX_CHANNEL; i++) {
 		irq = platform_get_irq(pdev, i);
 		if (irq <= 0) {
-			dev_err(&pdev->dev, "Failed to get Rx IRQ\n");
 			return -ENXIO;
 		}
 
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c2e693e34d43..badc683de9b3 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2178,7 +2178,6 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 
 	edac->sb_irq = platform_get_irq(pdev, 0);
 	if (edac->sb_irq < 0) {
-		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
 		return edac->sb_irq;
 	}
 
@@ -2213,7 +2212,6 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
 	if (edac->db_irq < 0) {
-		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
 		return edac->db_irq;
 	}
 	irq_set_chained_handler_and_data(edac->db_irq,
diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index e4a1032ba0b5..cb26ce5d5798 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1921,7 +1921,6 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		for (i = 0; i < 3; i++) {
 			irq = platform_get_irq(pdev, i);
 			if (irq < 0) {
-				dev_err(&pdev->dev, "No IRQ resource\n");
 				rc = -EINVAL;
 				goto out_err;
 			}
diff --git a/drivers/extcon/extcon-adc-jack.c b/drivers/extcon/extcon-adc-jack.c
index ee9b5f70bfa4..f162811f3427 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -141,7 +141,6 @@ static int adc_jack_probe(struct platform_device *pdev)
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/firmware/tegra/bpmp-tegra210.c b/drivers/firmware/tegra/bpmp-tegra210.c
index ae15940a078e..cb5debf83ff2 100644
--- a/drivers/firmware/tegra/bpmp-tegra210.c
+++ b/drivers/firmware/tegra/bpmp-tegra210.c
@@ -203,7 +203,6 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 
 	err = platform_get_irq_byname(pdev, "tx");
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get TX IRQ: %d\n", err);
 		return err;
 	}
 
@@ -215,7 +214,6 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 
 	err = platform_get_irq_byname(pdev, "rx");
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get rx IRQ: %d\n", err);
 		return err;
 	}
 
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 31ef38e38537..1d6939e5e452 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -579,7 +579,6 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq < 0) {
-		dev_err(dev, "No IRQ available\n");
 		return priv->irq;
 	}
 
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index af936dcca659..19cb072ac078 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -637,7 +637,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "interrupt-controller")) {
 		priv->parent_irq = platform_get_irq(pdev, 0);
 		if (priv->parent_irq <= 0) {
-			dev_err(dev, "Couldn't get IRQ");
 			return -ENOENT;
 		}
 	} else {
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 7b9ac4a12c20..1ee2a42b84f1 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -585,7 +585,6 @@ static int sprd_eic_probe(struct platform_device *pdev)
 
 	sprd_eic->irq = platform_get_irq(pdev, 0);
 	if (sprd_eic->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get EIC interrupt.\n");
 		return sprd_eic->irq;
 	}
 
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index 0937b605e134..08234e64993a 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -408,8 +408,6 @@ static int grgpio_probe(struct platform_device *ofdev)
 				 * Continue without irq functionality for that
 				 * gpio line
 				 */
-				dev_err(priv->dev,
-					"Failed to get irq for offset %d\n", i);
 				continue;
 			}
 			priv->uirqs[lirq->index].uirq = ret;
diff --git a/drivers/gpio/gpio-max77620.c b/drivers/gpio/gpio-max77620.c
index b7d89e30131e..952b1c6182a7 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -271,7 +271,6 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 
 	gpio_irq = platform_get_irq(pdev, 0);
 	if (gpio_irq <= 0) {
-		dev_err(&pdev->dev, "GPIO irq not available %d\n", gpio_irq);
 		return -ENODEV;
 	}
 
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 24228cf79afc..99b3dd1f7fc4 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -306,7 +306,6 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 
 	pmic_eic->irq = platform_get_irq(pdev, 0);
 	if (pmic_eic->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get PMIC EIC interrupt.\n");
 		return pmic_eic->irq;
 	}
 
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index f5c8b3a351d5..acb4fbf155d0 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -227,7 +227,6 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 
 	sprd_gpio->irq = platform_get_irq(pdev, 0);
 	if (sprd_gpio->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get GPIO interrupt.\n");
 		return sprd_gpio->irq;
 	}
 
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index bd1f3f775ce9..59fe0ecdb041 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -172,7 +172,6 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 
 		ret = platform_get_irq(pdev, 0);
 		if (ret < 0) {
-			dev_err(dev, "No interrupt specified.\n");
 			return ret;
 		}
 
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 0f59161a4701..48221d3f46fc 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -625,7 +625,6 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 	for (i = 0; i < tgi->bank_count; i++) {
 		ret = platform_get_irq(pdev, i);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "Missing IRQ resource: %d\n", ret);
 			return ret;
 		}
 
diff --git a/drivers/gpio/gpio-zx.c b/drivers/gpio/gpio-zx.c
index 8637adb6bc20..8d9b9bf8510a 100644
--- a/drivers/gpio/gpio-zx.c
+++ b/drivers/gpio/gpio-zx.c
@@ -253,7 +253,6 @@ static int zx_gpio_probe(struct platform_device *pdev)
 	writew_relaxed(0, chip->base + ZX_GPIO_IE);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "invalid IRQ\n");
 		gpiochip_remove(&chip->gc);
 		return -ENODEV;
 	}
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index f241b6c13dbe..7837b01697b9 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -850,7 +850,6 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 
 	gpio->irq = platform_get_irq(pdev, 0);
 	if (gpio->irq < 0) {
-		dev_err(&pdev->dev, "invalid IRQ\n");
 		return gpio->irq;
 	}
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 5418a1a87b2c..f3fd71bb4126 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1734,7 +1734,6 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	/* Get Interrupt: */
 	gpu->irq = platform_get_irq(pdev, 0);
 	if (gpu->irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", gpu->irq);
 		return gpu->irq;
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 6926cee91b36..21f3600ab94e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1790,7 +1790,6 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 
 	dsi->irq = platform_get_irq(pdev, 0);
 	if (dsi->irq < 0) {
-		dev_err(dev, "failed to request dsi irq resource\n");
 		return dsi->irq;
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 50904eee96f7..371419d3e8a6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1497,7 +1497,6 @@ static int g2d_probe(struct platform_device *pdev)
 
 	g2d->irq = platform_get_irq(pdev, 0);
 	if (g2d->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		ret = g2d->irq;
 		goto err_put_clk;
 	}
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 8ebad2740ad5..f7912654d208 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -291,7 +291,6 @@ static int rotator_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 9af096479e1c..00bbadef9fb1 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -500,7 +500,6 @@ static int scaler_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index e81daaaa5965..3b2db6ecdbe5 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -270,7 +270,6 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 
 	fsl_dev->irq = platform_get_irq(pdev, 0);
 	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return fsl_dev->irq;
 	}
 
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index e725af8a0025..3bdf7974b0d7 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -595,7 +595,6 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index e9f9e9fb9b17..d5f893c6deea 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -631,7 +631,6 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Failed to get platform irq");
 		return irq;
 	}
 
diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index cb29b649fcdb..663b0d711add 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -209,7 +209,6 @@ static int mtk_cec_probe(struct platform_device *pdev)
 
 	cec->irq = platform_get_irq(pdev, 0);
 	if (cec->irq < 0) {
-		dev_err(dev, "Failed to get cec irq: %d\n", cec->irq);
 		return cec->irq;
 	}
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bacd989cc9aa..08a2de4b0c64 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -718,7 +718,6 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 
 	dpi->irq = platform_get_irq(pdev, 0);
 	if (dpi->irq <= 0) {
-		dev_err(dev, "Failed to get irq: %d\n", dpi->irq);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b91c4616644a..2732d6c2c9da 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1156,7 +1156,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 
 	irq_num = platform_get_irq(pdev, 0);
 	if (irq_num < 0) {
-		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index df3f9ddd2234..53487fe025c1 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -895,7 +895,6 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Failed to get hdmi top irq\n");
 		return irq;
 	}
 
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 252f5ebb1acc..f7068d71bf5a 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -823,7 +823,6 @@ static int omap_dmm_probe(struct platform_device *dev)
 
 	omap_dmm->irq = platform_get_irq(dev, 0);
 	if (omap_dmm->irq < 0) {
-		dev_err(&dev->dev, "failed to get IRQ resource\n");
 		goto fail;
 	}
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 64c43ee6bd92..8e0ffcf446cb 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -784,7 +784,6 @@ static int sun4i_tcon_init_irq(struct device *dev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Couldn't retrieve the TCON interrupt\n");
 		return irq;
 	}
 
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 4a75d149e368..c3a5c356bb17 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2470,7 +2470,6 @@ static int tegra_dc_probe(struct platform_device *pdev)
 
 	dc->irq = platform_get_irq(pdev, 0);
 	if (dc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 2d94da225e51..ffdf4d289d6e 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -447,7 +447,6 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 
 	dpaux->irq = platform_get_irq(pdev, 0);
 	if (dpaux->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 4ffe3794e6d3..0a46c935e156 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3324,7 +3324,6 @@ static int tegra_sor_probe(struct platform_device *pdev)
 
 	err = platform_get_irq(pdev, 0);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
 		goto remove;
 	}
 
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 5a3f797240d4..f807f353b248 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -215,7 +215,6 @@ static int host1x_probe(struct platform_device *pdev)
 
 	syncpt_irq = platform_get_irq(pdev, 0);
 	if (syncpt_irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", syncpt_irq);
 		return syncpt_irq;
 	}
 
diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 0cba567ee2d7..29d0f1f88a24 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -371,7 +371,6 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 		goto out_err;
 	err = platform_get_irq_byname(pd, "gdd_mpu");
 	if (err < 0) {
-		dev_err(&pd->dev, "GDD IRQ resource missing\n");
 		goto out_err;
 	}
 	omap_ssi->gdd_irq = err;
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 2cd93119515f..a69e9888a1cf 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1039,7 +1039,6 @@ static int ssi_port_irq(struct hsi_port *port, struct platform_device *pd)
 
 	err = platform_get_irq(pd, 0);
 	if (err < 0) {
-		dev_err(&port->device, "Port IRQ resource missing\n");
 		return err;
 	}
 	omap_port->irq = err;
diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index bec5befd1d8b..df948003b462 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -94,8 +94,6 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
 
 	hwmon->irq = platform_get_irq(pdev, 0);
 	if (hwmon->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
-			hwmon->irq);
 		return hwmon->irq;
 	}
 
diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 09aaefa6fdb8..f907d4a08574 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -968,7 +968,6 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 
 		data->fan_irq[i] = platform_get_irq(pdev, i);
 		if (data->fan_irq[i] < 0) {
-			dev_err(dev, "get IRQ fan%d failed\n", i);
 			return data->fan_irq[i];
 		}
 
diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
index 5255d3755411..506f5d532a98 100644
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -397,7 +397,6 @@ static int altr_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing interrupt resource\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index ff3142b15cab..6fe9bc7b487d 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -613,7 +613,6 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing interrupt resource\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
index 4e489a9d16fb..47a6b6a747fc 100644
--- a/drivers/i2c/busses/i2c-bcm-kona.c
+++ b/drivers/i2c/busses/i2c-bcm-kona.c
@@ -823,7 +823,6 @@ static int bcm_kona_i2c_probe(struct platform_device *pdev)
 	/* Get the interrupt number */
 	dev->irq = platform_get_irq(pdev, 0);
 	if (dev->irq < 0) {
-		dev_err(dev->device, "no irq resource\n");
 		rc = -ENODEV;
 		goto probe_disable_clk;
 	}
diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 66af44bfa67d..02f9f3eccbed 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -270,7 +270,6 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Error missing irq resource\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/i2c/busses/i2c-efm32.c b/drivers/i2c/busses/i2c-efm32.c
index a8c6323e7f44..4de31fae72cd 100644
--- a/drivers/i2c/busses/i2c-efm32.c
+++ b/drivers/i2c/busses/i2c-efm32.c
@@ -352,7 +352,6 @@ static int efm32_i2c_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(&pdev->dev, "failed to get irq (%d)\n", ret);
 		if (!ret)
 			ret = -EINVAL;
 		return ret;
diff --git a/drivers/i2c/busses/i2c-hix5hd2.c b/drivers/i2c/busses/i2c-hix5hd2.c
index 4df1434b3597..a653decec161 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -418,7 +418,6 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "cannot find HS-I2C IRQ\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 20a4fbc53007..f98068cf4082 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1345,7 +1345,6 @@ static int img_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "can't get irq number\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index dc00fabc919a..dc87a09b6828 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -560,7 +560,6 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "can't get irq number\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index b1b8b938d7f4..517e8b46573e 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1063,7 +1063,6 @@ static int i2c_imx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "can't get irq number\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-lpc2k.c b/drivers/i2c/busses/i2c-lpc2k.c
index deea18b14add..c3dfc7348de7 100644
--- a/drivers/i2c/busses/i2c-lpc2k.c
+++ b/drivers/i2c/busses/i2c-lpc2k.c
@@ -363,7 +363,6 @@ static int i2c_lpc2k_probe(struct platform_device *pdev)
 
 	i2c->irq = platform_get_irq(pdev, 0);
 	if (i2c->irq < 0) {
-		dev_err(&pdev->dev, "can't get interrupt resource\n");
 		return i2c->irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 1e2647f9a2a7..3b7e416f982a 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -396,7 +396,6 @@ static int meson_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "can't find IRQ\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dfea357b131..9c4e0014a2c3 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1367,7 +1367,6 @@ omap_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index b6b5a495118b..f98f1f7610f9 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -413,7 +413,6 @@ static int owl_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 6e0e546ef83f..a9b48c0f186d 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -720,7 +720,6 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 
 	alg_data->irq = platform_get_irq(pdev, 0);
 	if (alg_data->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ from platform resource\n");
 		ret = alg_data->irq;
 		goto out_clock;
 	}
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
index 2c3c3d6935c0..971c5bf47343 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1219,7 +1219,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no irq resource: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a89bfce5388e..81c1eef1b432 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -530,7 +530,6 @@ static int geni_i2c_probe(struct platform_device *pdev)
 
 	gi2c->irq = platform_get_irq(pdev, 0);
 	if (gi2c->irq < 0) {
-		dev_err(&pdev->dev, "IRQ error for i2c-geni\n");
 		return gi2c->irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index e09cd0775ae9..01f9e1f10900 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1769,7 +1769,6 @@ static int qup_i2c_probe(struct platform_device *pdev)
 
 	qup->irq = platform_get_irq(pdev, 0);
 	if (qup->irq < 0) {
-		dev_err(qup->dev, "No IRQ defined\n");
 		return qup->irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 1a33007b03e9..7a62af96793d 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1263,7 +1263,6 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 	/* IRQ setup */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find rk3x IRQ\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 961123529678..75272549637d 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -494,7 +494,6 @@ static int sprd_i2c_probe(struct platform_device *pdev)
 
 	i2c_dev->irq = platform_get_irq(pdev, 0);
 	if (i2c_dev->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
 		return i2c_dev->irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 266d1c269b83..fb42aad715d0 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1840,17 +1840,11 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 
 	irq_event = platform_get_irq(pdev, 0);
 	if (irq_event <= 0) {
-		if (irq_event != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get IRQ event: %d\n",
-				irq_event);
 		return irq_event ? : -ENOENT;
 	}
 
 	irq_error = platform_get_irq(pdev, 1);
 	if (irq_error <= 0) {
-		if (irq_error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get IRQ error: %d\n",
-				irq_error);
 		return irq_error ? : -ENOENT;
 	}
 
diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 7c07ce116e38..53b0d227c8ab 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -239,7 +239,6 @@ static int p2wi_probe(struct platform_device *pdev)
 	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index f724c8e6b360..f89467bf6a1d 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -581,7 +581,6 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
 
 	i2c->irq = platform_get_irq(pdev, 0);
 	if (i2c->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 7acca2599f04..33c80187f064 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -554,7 +554,6 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 0173840c32af..300076e18ee3 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -342,7 +342,6 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
 		return irq;
 	}
 
diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 8a873975cf12..56ead0847a06 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -518,7 +518,6 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq <= 0) {
-		dev_err(&pdev->dev, "invalid irq!\n");
 		return priv->irq;
 	}
 	/* SMBAlert irq */
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 1b08028facde..177e0922eabb 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -54,7 +54,6 @@ static int ad7606_par_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 32f1c4a33b20..8dbc5444cd43 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1180,7 +1180,6 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st->irq = platform_get_irq(pdev, 0);
 	if (st->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ ID is designated\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 31d51bcc5f2c..af959c9db968 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -226,7 +226,6 @@ static int axp288_adc_probe(struct platform_device *pdev)
 	info = iio_priv(indio_dev);
 	info->irq = platform_get_irq(pdev, 0);
 	if (info->irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		return info->irq;
 	}
 	platform_set_drvdata(pdev, indio_dev);
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index c46c0aa15376..b9ce216f5f2e 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -541,7 +541,6 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
 	if (adc_priv->irqno <= 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
 		ret = -ENODEV;
 		return ret;
 	}
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 354433996101..e0bbd9566198 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -338,7 +338,6 @@ static int da9150_gpadc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "GPADC");
 	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 2f2b563c1162..9ceb8ebf27a0 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -358,8 +358,6 @@ static int envelope_detector_probe(struct platform_device *pdev)
 
 	env->comp_irq = platform_get_irq_byname(pdev, "comp");
 	if (env->comp_irq < 0) {
-		if (env->comp_irq != -EPROBE_DEFER)
-			dev_err(dev, "failed to get compare interrupt\n");
 		return env->comp_irq;
 	}
 
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index d4c3ece21679..764f26b83574 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -806,7 +806,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		return irq;
 	}
 	info->irq = irq;
diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index df19ecae52f7..fa71489195c6 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -340,7 +340,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq <= 0) {
-		dev_err(dev, "Failed to get IRQ\n");
 		ret = priv->irq;
 		if (!ret)
 			ret = -ENXIO;
diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
index 26a7bbe4d534..2deb457b8ab5 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -493,7 +493,6 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "No irq resource?\n");
 		return irq;
 	}
 
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index a6ee1c3a9064..7cbb166bc638 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -173,7 +173,6 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "failed getting interrupt resource\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index 193b3b81de4d..910f3585fa54 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -225,7 +225,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "failed getting interrupt resource\n");
 		ret = -EINVAL;
 		goto err_disable_clk;
 	}
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index dd8299831e09..23aac0cfacf4 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -245,7 +245,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		return irq;
 	}
 
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index f7f7a18904b4..77d905c51435 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -529,7 +529,6 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 
 	sc27xx_data->irq = platform_get_irq(pdev, 0);
 	if (sc27xx_data->irq < 0) {
-		dev_err(&pdev->dev, "failed to get ADC irq number\n");
 		return sc27xx_data->irq;
 	}
 
diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
index a33d0a4cc088..592b97c464da 100644
--- a/drivers/iio/adc/spear_adc.c
+++ b/drivers/iio/adc/spear_adc.c
@@ -301,7 +301,6 @@ static int spear_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "failed getting interrupt resource\n");
 		ret = -EINVAL;
 		goto errout2;
 	}
diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 1f7ce5186dfc..da292d2e424e 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -349,7 +349,6 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 			 */
 			if (i && priv->irq[i] == -ENXIO)
 				continue;
-			dev_err(&pdev->dev, "failed to get irq\n");
 
 			return priv->irq[i];
 		}
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 205e1699f954..bc59d56c136a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1920,7 +1920,6 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 	adc->irq = platform_get_irq(pdev, 0);
 	if (adc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
 		return adc->irq;
 	}
 
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index ee1e0569d0e1..82ec695b08eb 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1602,8 +1602,6 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	 */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index f13c6248a662..3b38a00396e2 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -461,7 +461,6 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 
 	ret = platform_get_irq_byname(pdev, name);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
 		return ret;
 	}
 
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 2fa6ec83bb13..8239613b6fa9 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -906,7 +906,6 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 41d3621c4787..5e5a039ea8a0 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -822,7 +822,6 @@ static int vf610_adc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		return irq;
 	}
 
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 81e6dedb1e02..3948607594ff 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4638,7 +4638,6 @@ static int hns_roce_get_cfg(struct hns_roce_dev *hr_dev)
 	for (i = 0; i < HNS_ROCE_V1_MAX_IRQ_NUM; i++) {
 		hr_dev->irq[i] = platform_get_irq(hr_dev->pdev, i);
 		if (hr_dev->irq[i] <= 0) {
-			dev_err(dev, "platform get of irq[=%d] failed!\n", i);
 			return -EINVAL;
 		}
 	}
diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index e1cf63ee148f..8bc84d9b9348 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -414,7 +414,6 @@ static int bcm_kp_probe(struct platform_device *pdev)
 
 	kp->irq = platform_get_irq(pdev, 0);
 	if (kp->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ specified\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index 1d94928db922..f489cd585b33 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -192,7 +192,6 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
 
 	davinci_ks->irq = platform_get_irq(pdev, 0);
 	if (davinci_ks->irq < 0) {
-		dev_err(dev, "no key scan irq\n");
 		error = davinci_ks->irq;
 		goto fail2;
 	}
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 97500a2de2d5..28af523cfa52 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -431,7 +431,6 @@ static int imx_keypad_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq defined in platform data\n");
 		return irq;
 	}
 
diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index a34e3271b0c9..f32154eda6fe 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -173,7 +173,6 @@ static int lpc32xx_kscan_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get platform irq\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index fa265fdce2c4..93fae2d9b780 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -236,7 +236,6 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index 57eac91ecd76..988ea4ad3b00 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -166,7 +166,6 @@ static int nspire_keypad_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index 159346cb4060..06fcb171ec01 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -50,7 +50,6 @@ static int opencores_kbd_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing board IRQ resource\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index d529768a1d06..7022f724dda0 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -545,13 +545,11 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
 
 	kp->key_sense_irq = platform_get_irq(pdev, 0);
 	if (kp->key_sense_irq < 0) {
-		dev_err(&pdev->dev, "unable to get keypad sense irq\n");
 		return kp->key_sense_irq;
 	}
 
 	kp->key_stuck_irq = platform_get_irq(pdev, 1);
 	if (kp->key_stuck_irq < 0) {
-		dev_err(&pdev->dev, "unable to get keypad stuck irq\n");
 		return kp->key_stuck_irq;
 	}
 
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 39023664d2f2..fd00ce68b5fa 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -728,7 +728,6 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index 585e7765cbf0..92a608843c2b 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -90,7 +90,6 @@ static int pxa930_rotary_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for rotary controller\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index 08ba41a81f14..77a98f7e81d5 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -182,7 +182,6 @@ static int sh_keysc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
 		goto err0;
 	}
 
diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 5342d8d45f81..eba72e50eaee 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -119,7 +119,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 
 	pdata->irq = platform_get_irq(pdev, 0);
 	if (pdata->irq < 0) {
-		dev_err(&pdev->dev, "no irq defined in platform data\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 7d25fa338ab4..6fef67dff292 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -192,7 +192,6 @@ static int spear_kbd_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "not able to get irq for the device\n");
 		return irq;
 	}
 
diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index f097128b93fe..291b89dc8710 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -188,7 +188,6 @@ static int keyscan_probe(struct platform_device *pdev)
 
 	keypad_data->irq = platform_get_irq(pdev, 0);
 	if (keypad_data->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ specified\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index a37a7a9e9171..c4de4a57929d 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -632,7 +632,6 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 
 	kbc->irq = platform_get_irq(pdev, 0);
 	if (kbc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index c88d05d6108a..63c6e7e8426d 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -133,7 +133,6 @@ static int w90p910_keypad_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/input/misc/88pm80x_onkey.c b/drivers/input/misc/88pm80x_onkey.c
index 45a09497f680..51c8a326fd06 100644
--- a/drivers/input/misc/88pm80x_onkey.c
+++ b/drivers/input/misc/88pm80x_onkey.c
@@ -77,7 +77,6 @@ static int pm80x_onkey_probe(struct platform_device *pdev)
 
 	info->irq = platform_get_irq(pdev, 0);
 	if (info->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		err = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/input/misc/88pm860x_onkey.c b/drivers/input/misc/88pm860x_onkey.c
index cc87443aa2ee..e54f66d1102f 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -65,7 +65,6 @@ static int pm860x_onkey_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 12b18a8db315..ec06109f190d 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -56,13 +56,11 @@ static int ab8500_ponkey_probe(struct platform_device *pdev)
 
 	irq_dbf = platform_get_irq_byname(pdev, "ONKEY_DBF");
 	if (irq_dbf < 0) {
-		dev_err(&pdev->dev, "No IRQ for ONKEY_DBF, error=%d\n", irq_dbf);
 		return irq_dbf;
 	}
 
 	irq_dbr = platform_get_irq_byname(pdev, "ONKEY_DBR");
 	if (irq_dbr < 0) {
-		dev_err(&pdev->dev, "No IRQ for ONKEY_DBR, error=%d\n", irq_dbr);
 		return irq_dbr;
 	}
 
diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index debeeaeb8812..8da5bbe0a4cb 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -233,8 +233,6 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
 
 	axp20x_pek->irq_dbr = platform_get_irq_byname(pdev, "PEK_DBR");
 	if (axp20x_pek->irq_dbr < 0) {
-		dev_err(&pdev->dev, "No IRQ for PEK_DBR, error=%d\n",
-				axp20x_pek->irq_dbr);
 		return axp20x_pek->irq_dbr;
 	}
 	axp20x_pek->irq_dbr = regmap_irq_get_virq(axp20x->regmap_irqc,
@@ -242,8 +240,6 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
 
 	axp20x_pek->irq_dbf = platform_get_irq_byname(pdev, "PEK_DBF");
 	if (axp20x_pek->irq_dbf < 0) {
-		dev_err(&pdev->dev, "No IRQ for PEK_DBF, error=%d\n",
-				axp20x_pek->irq_dbf);
 		return axp20x_pek->irq_dbf;
 	}
 	axp20x_pek->irq_dbf = regmap_irq_get_virq(axp20x->regmap_irqc,
diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index a4ff4782e605..41ec44b63529 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -77,8 +77,6 @@ static int da9055_onkey_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "ONKEY");
 	if (irq < 0) {
-		dev_err(&pdev->dev,
-			"Failed to get an IRQ for input device, %d\n", irq);
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index fd355cf59397..3ab1b15dc31b 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -250,7 +250,6 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	irq = platform_get_irq_byname(pdev, "ONKEY");
 	if (irq < 0) {
 		error = irq;
-		dev_err(&pdev->dev, "Failed to get platform IRQ: %d\n", error);
 		return error;
 	}
 
diff --git a/drivers/input/misc/e3x0-button.c b/drivers/input/misc/e3x0-button.c
index 4d7217f43888..9d7330093d84 100644
--- a/drivers/input/misc/e3x0-button.c
+++ b/drivers/input/misc/e3x0-button.c
@@ -66,15 +66,11 @@ static int e3x0_button_probe(struct platform_device *pdev)
 
 	irq_press = platform_get_irq_byname(pdev, "press");
 	if (irq_press < 0) {
-		dev_err(&pdev->dev, "No IRQ for 'press', error=%d\n",
-			irq_press);
 		return irq_press;
 	}
 
 	irq_release = platform_get_irq_byname(pdev, "release");
 	if (irq_release < 0) {
-		dev_err(&pdev->dev, "No IRQ for 'release', error=%d\n",
-			irq_release);
 		return irq_release;
 	}
 
diff --git a/drivers/input/misc/hisi_powerkey.c b/drivers/input/misc/hisi_powerkey.c
index dee6245f38d7..aae8caa73d05 100644
--- a/drivers/input/misc/hisi_powerkey.c
+++ b/drivers/input/misc/hisi_powerkey.c
@@ -92,8 +92,6 @@ static int hi65xx_powerkey_probe(struct platform_device *pdev)
 		irq = platform_get_irq_byname(pdev, hi65xx_irq_info[i].name);
 		if (irq < 0) {
 			error = irq;
-			dev_err(dev, "couldn't get irq %s: %d\n",
-				hi65xx_irq_info[i].name, error);
 			return error;
 		}
 
diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 7c49b8d23894..77bba2cc1bad 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -72,13 +72,11 @@ static int max8925_onkey_probe(struct platform_device *pdev)
 
 	irq[0] = platform_get_irq(pdev, 0);
 	if (irq[0] < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
 	irq[1] = platform_get_irq(pdev, 1);
 	if (irq[1] < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 017f81a66658..db708a115a8f 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -206,7 +206,6 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 
 	pwrkey->irq = platform_get_irq(pdev, 0);
 	if (pwrkey->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
 		return pwrkey->irq;
 	}
 
diff --git a/drivers/input/misc/rk805-pwrkey.c b/drivers/input/misc/rk805-pwrkey.c
index 4a6d4a5746e5..f2d958dbbba5 100644
--- a/drivers/input/misc/rk805-pwrkey.c
+++ b/drivers/input/misc/rk805-pwrkey.c
@@ -54,13 +54,11 @@ static int rk805_pwrkey_probe(struct platform_device *pdev)
 
 	fall_irq = platform_get_irq(pdev, 0);
 	if (fall_irq < 0) {
-		dev_err(&pdev->dev, "Can't get fall irq: %d\n", fall_irq);
 		return fall_irq;
 	}
 
 	rise_irq = platform_get_irq(pdev, 1);
 	if (rise_irq < 0) {
-		dev_err(&pdev->dev, "Can't get rise irq: %d\n", rise_irq);
 		return rise_irq;
 	}
 
diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
index 7b49c9997df7..cbdd963c4309 100644
--- a/drivers/input/misc/stpmic1_onkey.c
+++ b/drivers/input/misc/stpmic1_onkey.c
@@ -62,15 +62,11 @@ static int stpmic1_onkey_probe(struct platform_device *pdev)
 
 	onkey->irq_falling = platform_get_irq_byname(pdev, "onkey-falling");
 	if (onkey->irq_falling < 0) {
-		dev_err(dev, "failed: request IRQ onkey-falling %d\n",
-			onkey->irq_falling);
 		return onkey->irq_falling;
 	}
 
 	onkey->irq_rising = platform_get_irq_byname(pdev, "onkey-rising");
 	if (onkey->irq_rising < 0) {
-		dev_err(dev, "failed: request IRQ onkey-rising %d\n",
-			onkey->irq_rising);
 		return onkey->irq_rising;
 	}
 
diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index a4455bb12ae0..e2311c6445d0 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -125,7 +125,6 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 93235a007d07..fa9903cc0fda 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -273,7 +273,6 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 
 	info->irq = platform_get_irq(pdev, 0);
 	if (info->irq < 0) {
-		dev_err(info->dev, "invalid irq\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index 87bac8cff6f7..df14bc7a3a65 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -148,7 +148,6 @@ static int pxa930_trkball_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get trkball irq\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 443194a2b9e3..349a2f4fd03d 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -188,7 +188,6 @@ static int arc_ps2_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "arc_ps2_irq");
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ defined\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
index e0f18469d01b..8970b49ea09a 100644
--- a/drivers/input/serio/ps2-gpio.c
+++ b/drivers/input/serio/ps2-gpio.c
@@ -369,8 +369,6 @@ static int ps2_gpio_probe(struct platform_device *pdev)
 
 	drvdata->irq = platform_get_irq(pdev, 0);
 	if (drvdata->irq < 0) {
-		dev_err(dev, "failed to get irq from platform resource: %d\n",
-			drvdata->irq);
 		error = drvdata->irq;
 		goto err_free_serio;
 	}
diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index 1d1bbc8da949..68f87aa0bd45 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -186,7 +186,6 @@ static int pm860x_touch_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
index 4d11b27c7c43..54d0b689780b 100644
--- a/drivers/input/touchscreen/bcm_iproc_tsc.c
+++ b/drivers/input/touchscreen/bcm_iproc_tsc.c
@@ -490,7 +490,6 @@ static int iproc_ts_probe(struct platform_device *pdev)
 	/* get interrupt */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
index 1d6c8f490b40..361050d88407 100644
--- a/drivers/input/touchscreen/fsl-imx25-tcq.c
+++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
@@ -529,7 +529,6 @@ static int mx25_tcq_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq <= 0) {
-		dev_err(dev, "Failed to get IRQ\n");
 		return priv->irq;
 	}
 
diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index e04eecd65bbb..5ea565d5d846 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -431,13 +431,11 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 
 	tsc_irq = platform_get_irq(pdev, 0);
 	if (tsc_irq < 0) {
-		dev_err(&pdev->dev, "no tsc irq resource?\n");
 		return tsc_irq;
 	}
 
 	adc_irq = platform_get_irq(pdev, 1);
 	if (adc_irq < 0) {
-		dev_err(&pdev->dev, "no adc irq resource?\n");
 		return adc_irq;
 	}
 
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 567ed64b5392..55bd897b5a0d 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -213,7 +213,6 @@ static int lpc32xx_ts_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Can't get interrupt resource\n");
 		return irq;
 	}
 
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0c1e5f9daae..daf94a606122 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -584,7 +584,6 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "Unable to find IRQ resource\n");
 		return irq;
 	}
 
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index b25e2eb9e038..3df9266abe65 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -750,7 +750,6 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	iommu->irq = platform_get_irq(pdev, 0);
 	if (iommu->irq < 0) {
-		dev_err(iommu->dev, "could not get iommu irq\n");
 		ret = -ENODEV;
 		goto fail;
 	}
diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 34d0b9783b3e..1df487ec2798 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -697,7 +697,6 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index d00489a4b54f..4ee5ce0ba7e2 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -363,7 +363,6 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	for (i = 0; i < priv->nr_perips; ++i) {
 		irq = platform_get_irq(pdev, 1 + i);
 		if (irq < 0) {
-			dev_err(&pdev->dev, "cannot find perip IRQ #%u\n", i);
 			return irq;
 		}
 		priv->perip_irqs[i] = irq;
@@ -377,7 +376,6 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	/* Get syswake IRQ number */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find syswake IRQ\n");
 		return irq;
 	}
 	priv->syswake_irq = irq;
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index efbcf8435185..c63ebf2698b4 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -165,7 +165,6 @@ static int keystone_irq_probe(struct platform_device *pdev)
 
 	kirq->irq = platform_get_irq(pdev, 0);
 	if (kirq->irq < 0) {
-		dev_err(dev, "no irq resource %d\n", kirq->irq);
 		return kirq->irq;
 	}
 
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index d88e993aa66d..f48a85adfdf8 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -249,7 +249,6 @@ static int __init combiner_probe(struct platform_device *pdev)
 
 	combiner->parent_irq = platform_get_irq(pdev, 0);
 	if (combiner->parent_irq <= 0) {
-		dev_err(&pdev->dev, "Error getting IRQ resource\n");
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/mailbox/armada-37xx-rwtm-mailbox.c b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
index 97f90e97a83c..faa23980cc0b 100644
--- a/drivers/mailbox/armada-37xx-rwtm-mailbox.c
+++ b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
@@ -166,7 +166,6 @@ static int armada_37xx_mbox_probe(struct platform_device *pdev)
 
 	mbox->irq = platform_get_irq(pdev, 0);
 	if (mbox->irq < 0) {
-		dev_err(&pdev->dev, "Cannot get irq\n");
 		return mbox->irq;
 	}
 
diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index b6e34952246b..d526ef6a2fa8 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -138,7 +138,6 @@ static int platform_mhu_probe(struct platform_device *pdev)
 		mhu->chan[i].con_priv = &mhu->mlink[i];
 		mhu->mlink[i].irq = platform_get_irq(pdev, i);
 		if (mhu->mlink[i].irq < 0) {
-			dev_err(dev, "failed to get irq%d\n", i);
 			return mhu->mlink[i].irq;
 		}
 		mhu->mlink[i].rx_reg = mhu->base + platform_mhu_reg[i];
diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index 5c2d1e1f988b..43c27909d181 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -258,9 +258,6 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	for (i = 0; i < IPCC_IRQ_NUM; i++) {
 		ipcc->irqs[i] = platform_get_irq_byname(pdev, irq_name[i]);
 		if (ipcc->irqs[i] < 0) {
-			if (ipcc->irqs[i] != -EPROBE_DEFER)
-				dev_err(dev, "no IRQ specified %s\n",
-					irq_name[i]);
 			ret = ipcc->irqs[i];
 			goto err_clk;
 		}
@@ -284,8 +281,6 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "wakeup-source")) {
 		ipcc->wkp = platform_get_irq_byname(pdev, "wakeup");
 		if (ipcc->wkp < 0) {
-			if (ipcc->wkp != -EPROBE_DEFER)
-				dev_err(dev, "could not get wakeup IRQ\n");
 			ret = ipcc->wkp;
 			goto err_clk;
 		}
diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 86887c9a349a..0e2d7b69bda1 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -669,7 +669,6 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	/* IPI IRQ */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "unable to find IPI IRQ.\n");
 		goto free_mbox_dev;
 	}
 	pdata->irq = ret;
diff --git a/drivers/media/platform/am437x/am437x-vpfe.c b/drivers/media/platform/am437x/am437x-vpfe.c
index fe7b937eb5f2..c7109ba35ebf 100644
--- a/drivers/media/platform/am437x/am437x-vpfe.c
+++ b/drivers/media/platform/am437x/am437x-vpfe.c
@@ -2557,7 +2557,6 @@ static int vpfe_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		ret = -ENODEV;
 		goto probe_out_cleanup;
 	}
diff --git a/drivers/media/platform/atmel/atmel-sama5d2-isc.c b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
index 266df14da2d5..2438d8240617 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -162,7 +162,6 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		dev_err(dev, "failed to get irq: %d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/exynos4-is/mipi-csis.c
index 3e9ac6066cf6..de47c1283280 100644
--- a/drivers/media/platform/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/exynos4-is/mipi-csis.c
@@ -804,7 +804,6 @@ static int s5pcsis_probe(struct platform_device *pdev)
 
 	state->irq = platform_get_irq(pdev, 0);
 	if (state->irq < 0) {
-		dev_err(dev, "Failed to get irq\n");
 		return state->irq;
 	}
 
diff --git a/drivers/media/platform/imx-pxp.c b/drivers/media/platform/imx-pxp.c
index 8e7ef23b9a7e..5db948f0faf7 100644
--- a/drivers/media/platform/imx-pxp.c
+++ b/drivers/media/platform/imx-pxp.c
@@ -1662,7 +1662,6 @@ static int pxp_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq resource: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index 83216fc7156b..649c5c0bbd39 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -2324,7 +2324,6 @@ static int isp_probe(struct platform_device *pdev)
 	/* Interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(isp->dev, "No IRQ resource\n");
 		ret = -ENODEV;
 		goto error_iommu;
 	}
diff --git a/drivers/media/platform/renesas-ceu.c b/drivers/media/platform/renesas-ceu.c
index 57d0c0f9fa4b..83600ef41086 100644
--- a/drivers/media/platform/renesas-ceu.c
+++ b/drivers/media/platform/renesas-ceu.c
@@ -1660,7 +1660,6 @@ static int ceu_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "Failed to get irq: %d\n", ret);
 		goto error_free_ceudev;
 	}
 	irq = ret;
diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 5283d4533fa0..e9ff12b6b5bb 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -831,7 +831,6 @@ static int rga_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(rga->dev, "failed to get irq\n");
 		ret = irq;
 		goto err_put_clk;
 	}
diff --git a/drivers/media/platform/s3c-camif/camif-core.c b/drivers/media/platform/s3c-camif/camif-core.c
index b05ce0149ca1..9fa2da3ee021 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -387,7 +387,6 @@ static int camif_request_irqs(struct platform_device *pdev,
 
 		irq = platform_get_irq(pdev, i);
 		if (irq <= 0) {
-			dev_err(&pdev->dev, "failed to get IRQ %d\n", i);
 			return -ENXIO;
 		}
 
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 3c05b3dc49ec..a8496a58032a 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -694,13 +694,11 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 
 	fei->idle_irq = platform_get_irq_byname(pdev, "c8sectpfe-idle-irq");
 	if (fei->idle_irq < 0) {
-		dev_err(dev, "Can't get c8sectpfe-idle-irq\n");
 		return fei->idle_irq;
 	}
 
 	fei->error_irq = platform_get_irq_byname(pdev, "c8sectpfe-error-irq");
 	if (fei->error_irq < 0) {
-		dev_err(dev, "Can't get c8sectpfe-error-irq\n");
 		return fei->error_irq;
 	}
 
diff --git a/drivers/media/platform/sti/hva/hva-hw.c b/drivers/media/platform/sti/hva/hva-hw.c
index 7917fd2c4bd4..051e1e129a43 100644
--- a/drivers/media/platform/sti/hva/hva-hw.c
+++ b/drivers/media/platform/sti/hva/hva-hw.c
@@ -342,7 +342,6 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 	/* get status interruption resource */
 	ret  = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "%s     failed to get status IRQ\n", HVA_PREFIX);
 		goto err_clk;
 	}
 	hva->irq_its = ret;
@@ -361,7 +360,6 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 	/* get error interruption resource */
 	ret = platform_get_irq(pdev, 1);
 	if (ret < 0) {
-		dev_err(dev, "%s     failed to get error IRQ\n", HVA_PREFIX);
 		goto err_clk;
 	}
 	hva->irq_err = ret;
diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index d855e9c09c08..5f5c3236c61c 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1700,8 +1700,6 @@ static int dcmi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get irq\n");
 		return irq ? irq : -ENXIO;
 	}
 
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 6e0e894154f4..69f1ba2c2376 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -867,7 +867,6 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No csi IRQ specified\n");
 		ret = -ENXIO;
 		return ret;
 	}
diff --git a/drivers/media/rc/img-ir/img-ir-core.c b/drivers/media/rc/img-ir/img-ir-core.c
index 7e457f26a595..62071899cd75 100644
--- a/drivers/media/rc/img-ir/img-ir-core.c
+++ b/drivers/media/rc/img-ir/img-ir-core.c
@@ -82,7 +82,6 @@ static int img_ir_probe(struct platform_device *pdev)
 	/* Get resources from platform device */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find IRQ resource\n");
 		return irq;
 	}
 
diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 85561f6555a2..c8da4f5f057d 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -233,7 +233,6 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq < 0) {
-		dev_err(dev, "irq can not get\n");
 		return priv->irq;
 	}
 
diff --git a/drivers/media/rc/meson-ir.c b/drivers/media/rc/meson-ir.c
index 72a7bbbf6b1f..77f7d7bf977b 100644
--- a/drivers/media/rc/meson-ir.c
+++ b/drivers/media/rc/meson-ir.c
@@ -118,7 +118,6 @@ static int meson_ir_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no irq resource\n");
 		return irq;
 	}
 
diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
index 50fb0aebb8d4..b0b3c3c3ec6a 100644
--- a/drivers/media/rc/mtk-cir.c
+++ b/drivers/media/rc/mtk-cir.c
@@ -354,7 +354,6 @@ static int mtk_ir_probe(struct platform_device *pdev)
 
 	ir->irq = platform_get_irq(pdev, 0);
 	if (ir->irq < 0) {
-		dev_err(dev, "no irq resource\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index aa719d0ae6b0..905e4cc382e9 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -233,7 +233,6 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 	/* IRQ */
 	ir->irq = platform_get_irq(pdev, 0);
 	if (ir->irq < 0) {
-		dev_err(dev, "no irq resource\n");
 		ret = ir->irq;
 		goto exit_free_dev;
 	}
diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 402c6bc8e621..001aa86657c2 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1564,8 +1564,6 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(emif->dev, "%s: error getting IRQ resource - %d\n",
-			__func__, irq);
 		goto error;
 	}
 
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3d8d322511c5..0a426a9471e5 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -678,7 +678,6 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 	mc->irq = platform_get_irq(pdev, 0);
 	if (mc->irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
 		return mc->irq;
 	}
 
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index d24c6ecccb88..48d1d785ccc1 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2683,13 +2683,11 @@ static int ab8500_debug_probe(struct platform_device *plf)
 
 	irq_first = platform_get_irq_byname(plf, "IRQ_FIRST");
 	if (irq_first < 0) {
-		dev_err(&plf->dev, "First irq not found, err %d\n", irq_first);
 		return irq_first;
 	}
 
 	irq_last = platform_get_irq_byname(plf, "IRQ_LAST");
 	if (irq_last < 0) {
-		dev_err(&plf->dev, "Last irq not found, err %d\n", irq_last);
 		return irq_last;
 	}
 
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3f21e26b8d36..fd1d2fb032cd 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3129,7 +3129,6 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "no prcmu irq provided\n");
 		return irq;
 	}
 
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 20791cab7263..f6bdb3ddfe6c 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -70,7 +70,6 @@ static int mx25_tsadc_setup_irq(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "Failed to get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 6310c3bdb991..3bbd16628581 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -451,7 +451,6 @@ static int bxtwc_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Invalid IRQ\n");
 		return ret;
 	}
 	pmic->irq = ret;
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index 082f16917519..577478e217ad 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -210,13 +210,11 @@ static int jz4740_adc_probe(struct platform_device *pdev)
 	adc->irq = platform_get_irq(pdev, 0);
 	if (adc->irq < 0) {
 		ret = adc->irq;
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
 		return ret;
 	}
 
 	irq_base = platform_get_irq(pdev, 1);
 	if (irq_base < 0) {
-		dev_err(&pdev->dev, "Failed to get irq base: %d\n", irq_base);
 		return irq_base;
 	}
 
diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 4d7e9008628c..f3c061211826 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -562,19 +562,16 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 
 	irq_ack = platform_get_irq_byname(pdev, "ack");
 	if (irq_ack < 0) {
-		dev_err(&pdev->dev, "required ack interrupt missing\n");
 		return irq_ack;
 	}
 
 	irq_err = platform_get_irq_byname(pdev, "err");
 	if (irq_err < 0) {
-		dev_err(&pdev->dev, "required err interrupt missing\n");
 		return irq_err;
 	}
 
 	irq_wakeup = platform_get_irq_byname(pdev, "wakeup");
 	if (irq_wakeup < 0) {
-		dev_err(&pdev->dev, "required wakeup interrupt missing\n");
 		return irq_wakeup;
 	}
 
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 9b9b06d36cb1..b7345a4f14db 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1395,7 +1395,6 @@ static int sm501_plat_probe(struct platform_device *dev)
 
 	ret = platform_get_irq(dev, 0);
 	if (ret < 0) {
-		dev_err(&dev->dev, "failed to get irq resource\n");
 		goto err_res;
 	}
 	sm->irq = ret;
diff --git a/drivers/misc/spear13xx_pcie_gadget.c b/drivers/misc/spear13xx_pcie_gadget.c
index ee120dcbb3e6..8afebf3fe05d 100644
--- a/drivers/misc/spear13xx_pcie_gadget.c
+++ b/drivers/misc/spear13xx_pcie_gadget.c
@@ -703,7 +703,6 @@ static int spear_pcie_gadget_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no update irq?\n");
 		return irq;
 	}
 
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 7e0d3a49c06d..e1b7757c48fe 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1409,7 +1409,6 @@ static int bcm2835_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(dev, "get IRQ failed\n");
 		ret = -EINVAL;
 		goto err;
 	}
diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index ffdbfaadd3f2..672708543a11 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -969,7 +969,6 @@ static int jz4740_mmc_probe(struct platform_device* pdev)
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
 		ret = host->irq;
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
 		goto err_free_host;
 	}
 
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 037311db3551..e712315c7e8d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1091,7 +1091,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto free_host;
 	}
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 750604f7fac9..965df0f7fc16 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1011,7 +1011,6 @@ static int mxcmci_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index ccc5f095775f..bce9c33bc4b5 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1614,7 +1614,6 @@ static int s3cmci_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq <= 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource.\n");
 		ret = -EINVAL;
 		goto probe_iounmap;
 	}
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 9cf14b359c14..b75c82d8d6c1 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1917,8 +1917,6 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	/* Setup IRQ for handling power/voltage tasks with PMIC */
 	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
 	if (msm_host->pwr_irq < 0) {
-		dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
-			msm_host->pwr_irq);
 		ret = msm_host->pwr_irq;
 		goto clk_disable;
 	}
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index d268b3b8850a..caf0ad5de604 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -131,7 +131,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number\n");
 		ret = irq;
 		goto err;
 	}
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8e4a8ba33f05..f3b95b1131a0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -491,7 +491,6 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no irq specified\n");
 		return irq;
 	}
 
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index e369cbf1ff02..e24f486d3cee 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -120,7 +120,6 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "%s: no irq specified\n", __func__);
 		return irq;
 	}
 
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 49aad9a79c18..d2499007d9b3 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -558,7 +558,6 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number");
 		return irq;
 	}
 
diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index 986f81d2f93e..7f6f6f1d965f 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -933,7 +933,6 @@ static int spear_smi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = -ENODEV;
-		dev_err(&pdev->dev, "invalid smi irq\n");
 		goto err;
 	}
 
diff --git a/drivers/mtd/nand/raw/denali_dt.c b/drivers/mtd/nand/raw/denali_dt.c
index 5e14836f6bd5..dd1cec53aebb 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -168,7 +168,6 @@ static int denali_dt_probe(struct platform_device *pdev)
 	denali->dev = dev;
 	denali->irq = platform_get_irq(pdev, 0);
 	if (denali->irq < 0) {
-		dev_err(dev, "no irq defined\n");
 		return denali->irq;
 	}
 
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 6a4626a8bf95..3b9f18ef1bd9 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -752,7 +752,6 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/mtd/nand/raw/lpc32xx_mlc.c b/drivers/mtd/nand/raw/lpc32xx_mlc.c
index 78b31f845c50..241b58b83240 100644
--- a/drivers/mtd/nand/raw/lpc32xx_mlc.c
+++ b/drivers/mtd/nand/raw/lpc32xx_mlc.c
@@ -773,7 +773,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		dev_err(&pdev->dev, "failed to get platform irq\n");
 		res = -EINVAL;
 		goto release_dma_chan;
 	}
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index fc49e13d81ec..482b45726499 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2863,7 +2863,6 @@ static int marvell_nfc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq\n");
 		return irq;
 	}
 
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ea57ddcec41e..605db9fbcff0 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1399,7 +1399,6 @@ static int meson_nfc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no NFC IRQ resource\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index 74595b644b7c..7d91b00aecdf 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -528,7 +528,6 @@ static int mtk_ecc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index 373d47d1ba4c..b8305e39ab51 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1540,7 +1540,6 @@ static int mtk_nfc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no nfi irq resource\n");
 		ret = -EINVAL;
 		goto clk_disable;
 	}
diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 8d881a28140e..b0e4c9fb9a4b 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1968,7 +1968,6 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 	case NAND_OMAP_PREFETCH_IRQ:
 		info->gpmc_irq_fifo = platform_get_irq(info->pdev, 0);
 		if (info->gpmc_irq_fifo <= 0) {
-			dev_err(dev, "Error getting fifo IRQ\n");
 			return -ENODEV;
 		}
 		err = devm_request_irq(dev, info->gpmc_irq_fifo,
@@ -1983,7 +1982,6 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 
 		info->gpmc_irq_count = platform_get_irq(info->pdev, 1);
 		if (info->gpmc_irq_count <= 0) {
-			dev_err(dev, "Error getting IRQ count\n");
 			return -ENODEV;
 		}
 		err = devm_request_irq(dev, info->gpmc_irq_count,
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index e509c93737c4..3beec120734d 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1130,7 +1130,6 @@ static int flctl_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get flste irq data: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index e63acc077c18..17194c99ddf3 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1913,8 +1913,6 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "IRQ error missing or invalid\n");
 		return irq;
 	}
 
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 89773293c64d..25c06a00eb5a 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2072,7 +2072,6 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq\n");
 		return irq;
 	}
 
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 67f15a1f16fd..e4c2f69fbedd 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -1376,7 +1376,6 @@ static int cqspi_probe(struct platform_device *pdev)
 	/* Obtain IRQ line. */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Cannot obtain IRQ.\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
index 19d4f52a8f90..a761092e6ac9 100644
--- a/drivers/net/can/janz-ican3.c
+++ b/drivers/net/can/janz-ican3.c
@@ -1936,7 +1936,6 @@ static int ican3_probe(struct platform_device *pdev)
 	/* find our IRQ number */
 	mod->irq = platform_get_irq(pdev, 0);
 	if (mod->irq < 0) {
-		dev_err(dev, "IRQ line not found\n");
 		ret = -ENODEV;
 		goto out_free_ndev;
 	}
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 13e66297b65f..cf218949a8fb 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -759,7 +759,6 @@ static int rcar_can_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		err = irq;
 		goto fail;
 	}
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 05410008aa6b..51eecc7cdcdd 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1651,14 +1651,12 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	ch_irq = platform_get_irq(pdev, 0);
 	if (ch_irq < 0) {
-		dev_err(&pdev->dev, "no Channel IRQ resource\n");
 		err = ch_irq;
 		goto fail_dev;
 	}
 
 	g_irq = platform_get_irq(pdev, 1);
 	if (g_irq < 0) {
-		dev_err(&pdev->dev, "no Global IRQ resource\n");
 		err = g_irq;
 		goto fail_dev;
 	}
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 093fc9a529f0..f4cd88196404 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -787,7 +787,6 @@ static int sun4ican_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get a valid irq\n");
 		err = -ENODEV;
 		goto exit;
 	}
diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 650d1bae5f56..1793950f0582 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -1100,7 +1100,6 @@ static int au1000_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to retrieve IRQ\n");
 		err = -ENODEV;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
index d0f3dfb88202..6a1f74bb7584 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -468,7 +468,6 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 	/* Get the device interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "platform_get_irq 0 failed\n");
 		goto err_io;
 	}
 	pdata->dev_irq = ret;
@@ -497,7 +496,6 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 	/* Get the auto-negotiation interrupt */
 	ret = platform_get_irq(phy_pdev, phy_irqnum++);
 	if (ret < 0) {
-		dev_err(dev, "platform_get_irq phy 0 failed\n");
 		goto err_io;
 	}
 	pdata->an_irq = ret;
diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 79048cc46703..d74edfd132d0 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -55,7 +55,6 @@ static int xge_get_resources(struct xge_pdata *pdata)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "Unable to get irq\n");
 		return ret;
 	}
 	pdata->resources.irq = ret;
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 10b1c053e70a..b57c53d72e3d 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1636,7 +1636,6 @@ static int xgene_enet_get_irqs(struct xgene_enet_pdata *pdata)
 				pdata->cq_cnt = max_irqs / 2;
 				break;
 			}
-			dev_err(dev, "Unable to get ENET IRQ\n");
 			ret = ret ? : -ENXIO;
 			return ret;
 		}
diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index 3b3370a94a9c..8e0b8967feb1 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -1352,7 +1352,6 @@ static int nb8800_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev, "No IRQ\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 6dc0dd91ad11..46189264594b 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -200,7 +200,6 @@ static int bgmac_probe(struct platform_device *pdev)
 
 	bgmac->irq = platform_get_irq(pdev, 0);
 	if (bgmac->irq < 0) {
-		dev_err(&pdev->dev, "Unable to obtain IRQ\n");
 		return bgmac->irq;
 	}
 
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 9003eb6716cd..35615c12d369 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2424,7 +2424,6 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	/* Interrupt */
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "no IRQ\n");
 		return irq ? irq : -ENODEV;
 	}
 	port->irq = irq;
diff --git a/drivers/net/ethernet/davicom/dm9000.c b/drivers/net/ethernet/davicom/dm9000.c
index 386bdc1378d1..cce90b5925d9 100644
--- a/drivers/net/ethernet/davicom/dm9000.c
+++ b/drivers/net/ethernet/davicom/dm9000.c
@@ -1500,8 +1500,6 @@ dm9000_probe(struct platform_device *pdev)
 
 	ndev->irq = platform_get_irq(pdev, 0);
 	if (ndev->irq < 0) {
-		dev_err(db->dev, "interrupt resource unavailable: %d\n",
-			ndev->irq);
 		ret = ndev->irq;
 		goto out;
 	}
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index 689f18e3100f..90ab7ade44c4 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -877,7 +877,6 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 
 	ndev->irq = platform_get_irq(pdev, 0);
 	if (ndev->irq <= 0) {
-		dev_err(dev, "No irq resource\n");
 		ret = -ENODEV;
 		goto out_disconnect_phy;
 	}
diff --git a/drivers/net/ethernet/lantiq_xrx200.c b/drivers/net/ethernet/lantiq_xrx200.c
index cda641ef89af..8f3decc0d3f3 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -459,14 +459,10 @@ static int xrx200_probe(struct platform_device *pdev)
 
 	priv->chan_rx.dma.irq = platform_get_irq_byname(pdev, "rx");
 	if (priv->chan_rx.dma.irq < 0) {
-		dev_err(dev, "failed to get RX IRQ, %i\n",
-			priv->chan_rx.dma.irq);
 		return -ENOENT;
 	}
 	priv->chan_tx.dma.irq = platform_get_irq_byname(pdev, "tx");
 	if (priv->chan_tx.dma.irq < 0) {
-		dev_err(dev, "failed to get TX IRQ, %i\n",
-			priv->chan_tx.dma.irq);
 		return -ENOENT;
 	}
 
diff --git a/drivers/net/ethernet/nuvoton/w90p910_ether.c b/drivers/net/ethernet/nuvoton/w90p910_ether.c
index 3d73970b3a2e..219b0b863c89 100644
--- a/drivers/net/ethernet/nuvoton/w90p910_ether.c
+++ b/drivers/net/ethernet/nuvoton/w90p910_ether.c
@@ -993,14 +993,12 @@ static int w90p910_ether_probe(struct platform_device *pdev)
 
 	ether->txirq = platform_get_irq(pdev, 0);
 	if (ether->txirq < 0) {
-		dev_err(&pdev->dev, "failed to get ether tx irq\n");
 		error = -ENXIO;
 		goto failed_free_io;
 	}
 
 	ether->rxirq = platform_get_irq(pdev, 1);
 	if (ether->rxirq < 0) {
-		dev_err(&pdev->dev, "failed to get ether rx irq\n");
 		error = -ENXIO;
 		goto failed_free_io;
 	}
diff --git a/drivers/net/ethernet/qualcomm/emac/emac.c b/drivers/net/ethernet/qualcomm/emac/emac.c
index 59c2349b59df..992b4a4c7d85 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -557,8 +557,6 @@ static int emac_probe_resources(struct platform_device *pdev,
 	/* Core 0 interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"error: missing core0 irq resource (error=%i)\n", ret);
 		return ret;
 	}
 	adpt->irq.irq = ret;
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 51a7b48db4bc..5d5f55eab768 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1574,7 +1574,6 @@ static int ave_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "IRQ not found\n");
 		return irq;
 	}
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 3a14cdd01f5f..bc8c2b0c1674 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -429,10 +429,6 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	 */
 	stmmac_res.irq = platform_get_irq(pdev, 0);
 	if (stmmac_res.irq < 0) {
-		if (stmmac_res.irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"IRQ configuration information not found\n");
-
 		return stmmac_res.irq;
 	}
 	stmmac_res.wol_irq = stmmac_res.irq;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 73fc2524372e..a32db2bd61ed 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -603,10 +603,6 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 	 */
 	stmmac_res->irq = platform_get_irq_byname(pdev, "macirq");
 	if (stmmac_res->irq < 0) {
-		if (stmmac_res->irq != -EPROBE_DEFER) {
-			dev_err(&pdev->dev,
-				"MAC IRQ configuration information not found\n");
-		}
 		return stmmac_res->irq;
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index b920be1f5718..9d7ac11f74e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -18,7 +18,6 @@ mt76_wmac_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get device IRQ\n");
 		return irq;
 	}
 
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4234ddb4722f..9271a41a3adc 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -463,7 +463,6 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
-		dev_err(dev, "missing IRQ resource\n");
 		return pp->irq;
 	}
 
@@ -714,7 +713,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index cee5f2f590e2..31a493aaea10 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -403,7 +403,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 
 	pp->irq = platform_get_irq(pdev, 1);
 	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return pp->irq;
 	}
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
@@ -416,7 +415,6 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0) {
-			dev_err(dev, "failed to get msi irq\n");
 			return pp->msi_irq;
 		}
 	}
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9b5cb5b70389..484b04dccbdf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -868,7 +868,6 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq <= 0) {
-			dev_err(dev, "failed to get MSI irq\n");
 			return -ENODEV;
 		}
 	}
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index af677254a072..43394ac85e40 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1248,7 +1248,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index e35e9eaa50ee..0de8db939a78 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -501,7 +501,6 @@ static int meson_add_pcie_port(struct meson_pcie *mp,
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
 		if (pp->msi_irq < 0) {
-			dev_err(dev, "failed to get MSI IRQ\n");
 			return pp->msi_irq;
 		}
 	}
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 3d55dc78d999..61bb84f5130c 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -250,7 +250,6 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 
 	pp->irq = platform_get_irq(pdev, 0);
 	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq for port\n");
 		return pp->irq;
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index d00252bd8fae..4a1519bb577a 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -394,7 +394,6 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq < 0) {
-			dev_err(dev, "failed to get MSI irq\n");
 			return pp->msi_irq;
 		}
 	}
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 954bc2b74bbc..d04ee91696b9 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -403,7 +403,6 @@ static int histb_pcie_probe(struct platform_device *pdev)
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
 		if (pp->msi_irq < 0) {
-			dev_err(dev, "Failed to get MSI IRQ\n");
 			return pp->msi_irq;
 		}
 	}
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 8df1914226be..35b3e69b766f 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -456,8 +456,6 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0) {
-			dev_err(&pdev->dev,
-				"failed to get MSI IRQ (%d)\n", irq);
 			return irq;
 		}
 
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 7d0cdfd8138b..75ada802ca99 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -199,7 +199,6 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 
 	pp->irq = platform_get_irq(pdev, 0);
 	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
 		return pp->irq;
 	}
 	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9a917b2456f6..b8f6a300d3c0 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1550,7 +1550,6 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 	/* request interrupt */
 	err = platform_get_irq_byname(pdev, "intr");
 	if (err < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", err);
 		goto phys_put;
 	}
 
@@ -1768,7 +1767,6 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 
 	err = platform_get_irq_byname(pdev, "msi");
 	if (err < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", err);
 		goto free_irq_domain;
 	}
 
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index d219404bad92..9105fd79e219 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -805,7 +805,6 @@ static int v3_pci_probe(struct platform_device *pdev)
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
 		return -ENODEV;
 	}
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
index f4c02da84e59..02271c6d17a1 100644
--- a/drivers/pci/controller/pci-xgene-msi.c
+++ b/drivers/pci/controller/pci-xgene-msi.c
@@ -478,8 +478,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
 	for (irq_index = 0; irq_index < NR_HW_IRQS; irq_index++) {
 		virt_msir = platform_get_irq(pdev, irq_index);
 		if (virt_msir < 0) {
-			dev_err(&pdev->dev, "Cannot translate IRQ index %d\n",
-				irq_index);
 			rc = virt_msir;
 			goto error;
 		}
diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
index 16d938920ca5..bec666eda1eb 100644
--- a/drivers/pci/controller/pcie-altera-msi.c
+++ b/drivers/pci/controller/pcie-altera-msi.c
@@ -256,7 +256,6 @@ static int altera_msi_probe(struct platform_device *pdev)
 
 	msi->irq = platform_get_irq(pdev, 0);
 	if (msi->irq < 0) {
-		dev_err(&pdev->dev, "failed to map IRQ: %d\n", msi->irq);
 		ret = msi->irq;
 		goto err;
 	}
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index d2497ca43828..43ae44a8be89 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -748,7 +748,6 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);
 	if (pcie->irq < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", pcie->irq);
 		return pcie->irq;
 	}
 
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 672e633601c7..8935c5bd9143 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -454,7 +454,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 
 	pcie->irq = platform_get_irq(pdev, 0);
 	if (pcie->irq <= 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
 		return -ENODEV;
 	}
 
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 8d20f1793a61..912b6b2d8d50 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -550,7 +550,6 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 
 	irq = platform_get_irq_byname(pdev, "sys");
 	if (irq < 0) {
-		dev_err(dev, "missing sys IRQ resource\n");
 		return irq;
 	}
 
@@ -563,7 +562,6 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 
 	irq = platform_get_irq_byname(pdev, "legacy");
 	if (irq < 0) {
-		dev_err(dev, "missing legacy IRQ resource\n");
 		return irq;
 	}
 
@@ -573,7 +571,6 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 
 	irq = platform_get_irq_byname(pdev, "client");
 	if (irq < 0) {
-		dev_err(dev, "missing client IRQ resource\n");
 		return irq;
 	}
 
diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index 21a208da3f59..55e251f81fcd 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -274,7 +274,6 @@ static int tango_pcie_probe(struct platform_device *pdev)
 
 	virq = platform_get_irq(pdev, 1);
 	if (virq <= 0) {
-		dev_err(dev, "Failed to map IRQ\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 45c0f344ccd1..6c3314ff4aa8 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -586,7 +586,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	/* Get msi_1 IRQ number */
 	msi->irq_msi1 = platform_get_irq_byname(pdev, "msi1");
 	if (msi->irq_msi1 < 0) {
-		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi1);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -597,7 +596,6 @@ static int nwl_pcie_enable_msi(struct nwl_pcie *pcie)
 	/* Get msi_0 IRQ number */
 	msi->irq_msi0 = platform_get_irq_byname(pdev, "msi0");
 	if (msi->irq_msi0 < 0) {
-		dev_err(dev, "failed to get IRQ#%d\n", msi->irq_msi0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -729,8 +727,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	/* Get misc IRQ number */
 	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
 	if (pcie->irq_misc < 0) {
-		dev_err(dev, "failed to get misc IRQ %d\n",
-			pcie->irq_misc);
 		return -EINVAL;
 	}
 
@@ -798,7 +794,6 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 	/* Get intx IRQ number */
 	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
 	if (pcie->irq_intx < 0) {
-		dev_err(dev, "failed to get intx IRQ %d\n", pcie->irq_intx);
 		return pcie->irq_intx;
 	}
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 6ad0823bcf23..318893842007 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -218,7 +218,6 @@ static int hisi_ddrc_pmu_init_irq(struct hisi_pmu *ddrc_pmu,
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "DDRC PMU get irq fail; irq:%d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 4f2917f3e25e..17dd0af974ca 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -208,7 +208,6 @@ static int hisi_hha_pmu_init_irq(struct hisi_pmu *hha_pmu,
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "HHA PMU get irq fail; irq:%d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 9153e093f9df..6fb296ffce08 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -207,7 +207,6 @@ static int hisi_l3c_pmu_init_irq(struct hisi_pmu *l3c_pmu,
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "L3C PMU get irq fail; irq:%d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index d06182fe14b8..27dd11ad06b0 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -910,9 +910,6 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 
 	irq = platform_get_irq(sdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev,
-			"Failed to get valid irq for cluster %ld\n",
-			fw_cluster_id);
 		return irq;
 	}
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 3259e2ebeb39..42b3f0d26eed 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1902,7 +1902,6 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 03ec7a5d9d0b..98f8b276db51 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1704,7 +1704,6 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get interrupt number\n");
 		return irq;
 	}
 
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index a18d6eefe672..f37c4a7ff313 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1355,7 +1355,6 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get interrupt number\n");
 		return irq;
 	}
 
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9b9c61e3f065..4360903c2ef8 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -862,7 +862,6 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	irq_base = platform_get_irq(pdev, 0);
 	if (irq_base < 0) {
-		dev_err(&pdev->dev, "Failed to get gpio IRQ: %d\n", irq_base);
 		return irq_base;
 	}
 
diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index b4edbe0d9a73..6973b03ba7e5 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -1230,7 +1230,6 @@ static int oxnas_gpio_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "irq get failed\n");
 		return irq;
 	}
 
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index 6dc98e22f9f5..8904e5868595 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -2223,7 +2223,6 @@ static int pic32_gpio_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "irq get failed\n");
 		return irq;
 	}
 
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index d3332da35637..f8299f2fb52e 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -609,7 +609,6 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(pctl->dev, "failed to get irq\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7f35c196bb3e..a105a126f244 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1161,7 +1161,6 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 
 	pctrl->irq = platform_get_irq(pdev, 0);
 	if (pctrl->irq < 0) {
-		dev_err(&pdev->dev, "No interrupt defined for msmgpio\n");
 		return pctrl->irq;
 	}
 
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 076ba085a6a1..f232082a345b 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -792,8 +792,6 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 		pin_data[i].reg = SSBI_REG_ADDR_MPP(i);
 		pin_data[i].irq = platform_get_irq(pdev, i);
 		if (pin_data[i].irq < 0) {
-			dev_err(&pdev->dev,
-				"missing interrupts for pin %d\n", i);
 			return pin_data[i].irq;
 		}
 
diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index f85a1b9d129b..1f4eb3b5c601 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -643,8 +643,6 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
 	} else {
 		priv->irq = platform_get_irq(pdev, 0);
 		if (priv->irq < 0) {
-			dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
-				priv->irq);
 			return priv->irq;
 		}
 	}
diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel_bxtwc_tmu.c
index 951c105bafc1..fe609b937def 100644
--- a/drivers/platform/x86/intel_bxtwc_tmu.c
+++ b/drivers/platform/x86/intel_bxtwc_tmu.c
@@ -62,7 +62,6 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 
 	if (irq < 0) {
-		dev_err(&pdev->dev, "invalid irq %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index d9542c661ddc..cca021e42baa 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -167,7 +167,6 @@ static int int0002_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Error getting IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 55037ff258f8..b5b9baf3e898 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -937,7 +937,6 @@ static int ipc_plat_probe(struct platform_device *pdev)
 
 	ipcdev.irq = platform_get_irq(pdev, 0);
 	if (ipcdev.irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 5ca047b3f58f..589790c38161 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -920,13 +920,11 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 
 	info->irq_cc = platform_get_irq(pdev, 0);
 	if (info->irq_cc <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
 	info->irq_batt = platform_get_irq(pdev, 1);
 	if (info->irq_batt <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 1bbba6bba673..f6e27ff79331 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -826,7 +826,6 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	for (i = 0; i < CHRG_INTR_END; i++) {
 		pirq = platform_get_irq(info->pdev, i);
 		if (pirq < 0) {
-			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
 			return pirq;
 		}
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index 1bb32b7226d7..9c5f102c5848 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -169,8 +169,6 @@ static int bd70528_get_irqs(struct platform_device *pdev,
 	for (i = 0; i < ARRAY_SIZE(bd70528_chg_irqs); i++) {
 		irq = platform_get_irq_byname(pdev, bd70528_chg_irqs[i].n);
 		if (irq < 0) {
-			dev_err(&pdev->dev, "Bad IRQ information for %s (%d)\n",
-				bd70528_chg_irqs[i].n, irq);
 			return irq;
 		}
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index f9314cc0cd75..3a1e71beb938 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -467,7 +467,6 @@ static int da9150_charger_register_irq(struct platform_device *pdev,
 
 	irq = platform_get_irq_byname(pdev, irq_name);
 	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
 		return irq;
 	}
 
@@ -488,7 +487,6 @@ static void da9150_charger_unregister_irq(struct platform_device *pdev,
 
 	irq = platform_get_irq_byname(pdev, irq_name);
 	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
 		return;
 	}
 
diff --git a/drivers/power/supply/da9150-fg.c b/drivers/power/supply/da9150-fg.c
index 6e367826aae9..026a98741c12 100644
--- a/drivers/power/supply/da9150-fg.c
+++ b/drivers/power/supply/da9150-fg.c
@@ -514,7 +514,6 @@ static int da9150_fg_probe(struct platform_device *pdev)
 	/* Register IRQ */
 	irq = platform_get_irq_byname(pdev, "FG");
 	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ FG: %d\n", irq);
 		ret = irq;
 		goto irq_fail;
 	}
diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index c2644a9fe80f..a045dc227e94 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -222,7 +222,6 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/power/supply/jz4740-battery.c b/drivers/power/supply/jz4740-battery.c
index 6366bd61ea9f..6ddfc021e2e3 100644
--- a/drivers/power/supply/jz4740-battery.c
+++ b/drivers/power/supply/jz4740-battery.c
@@ -259,7 +259,6 @@ static int jz_battery_probe(struct platform_device *pdev)
 
 	jz_battery->irq = platform_get_irq(pdev, 0);
 	if (jz_battery->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
 		return jz_battery->irq;
 	}
 
diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index c890e1cec720..4d72ed5ced3f 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -930,8 +930,6 @@ static int smbb_charger_probe(struct platform_device *pdev)
 
 		irq = platform_get_irq_byname(pdev, smbb_charger_irqs[i].name);
 		if (irq < 0) {
-			dev_err(&pdev->dev, "failed to get irq '%s'\n",
-				smbb_charger_irqs[i].name);
 			return irq;
 		}
 
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 24895cc3b41e..dcaac6dde999 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1031,7 +1031,6 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource specified\n");
 		return irq;
 	}
 
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 20450e34ad57..d79a8e17841e 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -565,7 +565,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
 		return irq;
 	}
 
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 2ffc64622451..a4de36eb133b 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1033,7 +1033,6 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
 		return irq;
 	}
 	regulators->irq_ldo_lim = irq;
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 02f816318fba..a6cdc280db56 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -864,7 +864,6 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
 		return irq;
 	}
 
diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b2c7af323ed1..d84cfb0d6db8 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -250,7 +250,6 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/remoteproc/keystone_remoteproc.c b/drivers/remoteproc/keystone_remoteproc.c
index 4cb44017af8a..5c4658f00b3d 100644
--- a/drivers/remoteproc/keystone_remoteproc.c
+++ b/drivers/remoteproc/keystone_remoteproc.c
@@ -424,16 +424,12 @@ static int keystone_rproc_probe(struct platform_device *pdev)
 	ksproc->irq_ring = platform_get_irq_byname(pdev, "vring");
 	if (ksproc->irq_ring < 0) {
 		ret = ksproc->irq_ring;
-		dev_err(dev, "failed to get vring interrupt, status = %d\n",
-			ret);
 		goto disable_clk;
 	}
 
 	ksproc->irq_fault = platform_get_irq_byname(pdev, "exception");
 	if (ksproc->irq_fault < 0) {
 		ret = ksproc->irq_fault;
-		dev_err(dev, "failed to get exception interrupt, status = %d\n",
-			ret);
 		goto disable_clk;
 	}
 
diff --git a/drivers/remoteproc/qcom_q6v5.c b/drivers/remoteproc/qcom_q6v5.c
index 0d33e3079f0d..df7d38b1ba75 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -188,10 +188,6 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
 	if (q6v5->wdog_irq < 0) {
-		if (q6v5->wdog_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve wdog IRQ: %d\n",
-				q6v5->wdog_irq);
 		return q6v5->wdog_irq;
 	}
 
@@ -206,10 +202,6 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
 	if (q6v5->fatal_irq < 0) {
-		if (q6v5->fatal_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve fatal IRQ: %d\n",
-				q6v5->fatal_irq);
 		return q6v5->fatal_irq;
 	}
 
@@ -224,10 +216,6 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
 	if (q6v5->ready_irq < 0) {
-		if (q6v5->ready_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve ready IRQ: %d\n",
-				q6v5->ready_irq);
 		return q6v5->ready_irq;
 	}
 
@@ -242,10 +230,6 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
 	if (q6v5->handover_irq < 0) {
-		if (q6v5->handover_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve handover IRQ: %d\n",
-				q6v5->handover_irq);
 		return q6v5->handover_irq;
 	}
 
@@ -261,10 +245,6 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
 	if (q6v5->stop_irq < 0) {
-		if (q6v5->stop_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve stop-ack IRQ: %d\n",
-				q6v5->stop_irq);
 		return q6v5->stop_irq;
 	}
 
diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index e4d5a19fd1c9..9aa4a59dbf47 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -264,7 +264,6 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	info->irq = platform_get_irq(pdev, 0);
 	if (info->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		ret = -EINVAL;
 		goto out;
 	}
diff --git a/drivers/rtc/rtc-88pm860x.c b/drivers/rtc/rtc-88pm860x.c
index 434285f495e0..630b7d21716f 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -329,7 +329,6 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	info->irq = platform_get_irq(pdev, 0);
 	if (info->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
 		return info->irq;
 	}
 
diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 2e5a8b15b222..2a3fa7b0def6 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -579,7 +579,6 @@ static int ac100_rtc_probe(struct platform_device *pdev)
 
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		return chip->irq;
 	}
 
diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 19d6980e90fb..906735b38400 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -532,7 +532,6 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 	rtc->irq = platform_get_irq(pdev, 0);
 
 	if (rtc->irq < 0) {
-		dev_err(&pdev->dev, "no irq\n");
 		return rtc->irq;
 	}
 
diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index d45a44936308..a59dc5e5bd73 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -258,7 +258,6 @@ static int asm9260_rtc_probe(struct platform_device *pdev)
 
 	irq_alarm = platform_get_irq(pdev, 0);
 	if (irq_alarm < 0) {
-		dev_err(dev, "No alarm IRQ resource defined\n");
 		return irq_alarm;
 	}
 
diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 82a54e93ff04..99dbed5b872f 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -379,7 +379,6 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource defined\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 4daf3789b978..09b53bb2a0fb 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -343,7 +343,6 @@ static int at91_rtc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource\n");
 		return irq;
 	}
 
diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index f9bdd555e1a2..6c29962d186e 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -418,7 +418,6 @@ static int bd70528_probe(struct platform_device *pdev)
 	irq = platform_get_irq_byname(pdev, "bd70528-rtc-alm");
 
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index fcb71bf4d492..918ad5dc1baf 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -478,7 +478,6 @@ static int __init davinci_rtc_probe(struct platform_device *pdev)
 
 	davinci_rtc->irq = platform_get_irq(pdev, 0);
 	if (davinci_rtc->irq < 0) {
-		dev_err(dev, "no RTC irq\n");
 		return davinci_rtc->irq;
 	}
 
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 9e7b3a04debc..2f70737874cc 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -324,7 +324,6 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 
 	rtc->irq = platform_get_irq(pdev, 0);
 	if (rtc->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq\n");
 		return -ENOENT;
 	}
 
diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 4aff349ae301..efee5b7d9c3f 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -674,8 +674,6 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 
 		info->rtc_irq = platform_get_irq(pdev, 0);
 		if (info->rtc_irq < 0) {
-			dev_err(info->dev, "Failed to get rtc interrupts: %d\n",
-				info->rtc_irq);
 			return info->rtc_irq;
 		}
 	} else {
diff --git a/drivers/rtc/rtc-mt7622.c b/drivers/rtc/rtc-mt7622.c
index 82b0816ec6c1..16bd26b5aa6f 100644
--- a/drivers/rtc/rtc-mt7622.c
+++ b/drivers/rtc/rtc-mt7622.c
@@ -329,7 +329,6 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		ret = hw->irq;
 		goto err;
 	}
diff --git a/drivers/rtc/rtc-pic32.c b/drivers/rtc/rtc-pic32.c
index 1c4de6e90da0..54026ba8c461 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -309,7 +309,6 @@ static int pic32_rtc_probe(struct platform_device *pdev)
 
 	pdata->alarm_irq = platform_get_irq(pdev, 0);
 	if (pdata->alarm_irq < 0) {
-		dev_err(&pdev->dev, "no irq for alarm\n");
 		return pdata->alarm_irq;
 	}
 
diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 9f9839c47e2f..6119507e5e83 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -469,7 +469,6 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 
 	rtc_dd->rtc_alarm_irq = platform_get_irq(pdev, 0);
 	if (rtc_dd->rtc_alarm_irq < 0) {
-		dev_err(&pdev->dev, "Alarm IRQ resource absent!\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index 63b9e73fb97d..26e3ad58566e 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -187,13 +187,11 @@ static int puv3_rtc_probe(struct platform_device *pdev)
 	/* find the IRQs */
 	puv3_rtc_tickno = platform_get_irq(pdev, 1);
 	if (puv3_rtc_tickno < 0) {
-		dev_err(&pdev->dev, "no irq for rtc tick\n");
 		return -ENOENT;
 	}
 
 	puv3_rtc_alarmno = platform_get_irq(pdev, 0);
 	if (puv3_rtc_alarmno < 0) {
-		dev_err(&pdev->dev, "no irq for alarm\n");
 		return -ENOENT;
 	}
 
diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index a7827fe7fb7b..669af9cf5ed6 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -325,12 +325,10 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 
 	sa1100_rtc->irq_1hz = platform_get_irq(pdev, 0);
 	if (sa1100_rtc->irq_1hz < 0) {
-		dev_err(dev, "No 1Hz IRQ resource defined\n");
 		return -ENXIO;
 	}
 	sa1100_rtc->irq_alarm = platform_get_irq(pdev, 1);
 	if (sa1100_rtc->irq_alarm < 0) {
-		dev_err(dev, "No alarm IRQ resource defined\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index c34540baa12a..c878837054b4 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -435,9 +435,6 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 
 	rk808_rtc->irq = platform_get_irq(pdev, 0);
 	if (rk808_rtc->irq < 0) {
-		if (rk808_rtc->irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Wake up is not possible as irq = %d\n",
-				rk808_rtc->irq);
 		return rk808_rtc->irq;
 	}
 
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 74bf6473a05d..1be0c83b487d 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -454,7 +454,6 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	/* find the IRQs */
 	info->irq_tick = platform_get_irq(pdev, 1);
 	if (info->irq_tick < 0) {
-		dev_err(&pdev->dev, "no irq for rtc tick\n");
 		return info->irq_tick;
 	}
 
@@ -471,7 +470,6 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	info->irq_alarm = platform_get_irq(pdev, 0);
 	if (info->irq_alarm < 0) {
-		dev_err(&pdev->dev, "no irq for alarm\n");
 		return info->irq_alarm;
 	}
 
diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index b4eb3b3c6c2c..de090cdd25ab 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -615,7 +615,6 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 
 	rtc->irq = platform_get_irq(pdev, 0);
 	if (rtc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get RTC irq number\n");
 		return rtc->irq;
 	}
 
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 0567944fd4f8..e9bc017d6c15 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -359,7 +359,6 @@ static int spear_rtc_probe(struct platform_device *pdev)
 	/* alarm irqs */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no update irq?\n");
 		return irq;
 	}
 
diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
index 773a1990b93f..2999e33a7e37 100644
--- a/drivers/rtc/rtc-stm32.c
+++ b/drivers/rtc/rtc-stm32.c
@@ -776,7 +776,6 @@ static int stm32_rtc_probe(struct platform_device *pdev)
 
 	rtc->irq_alarm = platform_get_irq(pdev, 0);
 	if (rtc->irq_alarm <= 0) {
-		dev_err(&pdev->dev, "no alarm irq\n");
 		ret = rtc->irq_alarm;
 		goto err;
 	}
diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index c0e75c373605..cff318962af8 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -611,7 +611,6 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		return chip->irq;
 	}
 
diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 6eeabb81106f..385578dc02db 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -443,7 +443,6 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 
 	chip->irq = platform_get_irq(pdev, 0);
 	if (chip->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		return chip->irq;
 	}
 	ret = devm_request_irq(&pdev->dev, chip->irq, sunxi_rtc_alarmirq,
diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 8fa1b3febf69..f7f8c1659fcd 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -291,7 +291,6 @@ static int tegra_rtc_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(&pdev->dev, "failed to get platform IRQ: %d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index f59d232810de..02907d22a518 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -213,7 +213,6 @@ static int vt8500_rtc_probe(struct platform_device *pdev)
 
 	vt8500_rtc->irq_alarm = platform_get_irq(pdev, 0);
 	if (vt8500_rtc->irq_alarm < 0) {
-		dev_err(&pdev->dev, "No alarm IRQ resource defined\n");
 		return vt8500_rtc->irq_alarm;
 	}
 
diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 9888383f0088..e34e93e155af 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -158,7 +158,6 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		return irq;
 	}
 	ret = devm_request_irq(&pdev->dev, irq, xgene_rtc_interrupt, 0,
diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 00639594de0c..d6892bebc2e5 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -219,7 +219,6 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 
 	xrtcdev->alarm_irq = platform_get_irq_byname(pdev, "alarm");
 	if (xrtcdev->alarm_irq < 0) {
-		dev_err(&pdev->dev, "no irq resource\n");
 		return xrtcdev->alarm_irq;
 	}
 	ret = devm_request_irq(&pdev->dev, xrtcdev->alarm_irq,
@@ -232,7 +231,6 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 
 	xrtcdev->sec_irq = platform_get_irq_byname(pdev, "sec");
 	if (xrtcdev->sec_irq < 0) {
-		dev_err(&pdev->dev, "no irq resource\n");
 		return xrtcdev->sec_irq;
 	}
 	ret = devm_request_irq(&pdev->dev, xrtcdev->sec_irq,
diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index d7d521b394c3..f84943553454 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -404,7 +404,6 @@ int ufshcd_pltfrm_init(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "IRQ resource not available\n");
 		err = -ENODEV;
 		goto out;
 	}
diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
index cf4f10d6f590..a5e7e34aebde 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -136,7 +136,6 @@ static int bman_portal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "Can't get %pOF IRQ'\n", node);
 		goto err_ioremap1;
 	}
 	pcfg->irq = irq;
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e2186b681d87..68cef22e08f7 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -276,7 +276,6 @@ static int qman_portal_probe(struct platform_device *pdev)
 	pcfg->cpu = -1;
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "Can't get %pOF IRQ\n", node);
 		goto err_ioremap1;
 	}
 	pcfg->irq = irq;
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c7300d54e444..8f11bd268e23 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -475,7 +475,6 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
 		return irq;
 	}
 
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 6a7d7b553d95..fd8007ebb145 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -526,7 +526,6 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	/* Request the IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing IRQ\n");
 		err = irq;
 		goto disable_qspick;
 	}
diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 032888344822..119ae87cc26e 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -864,7 +864,6 @@ static int a3700_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "could not get irq: %d\n", irq);
 		ret = -ENXIO;
 		goto error;
 	}
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 6f243a90c844..c96797844688 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -1015,7 +1015,6 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0) {
-		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
 		err = bs->irq ? bs->irq : -ENODEV;
 		goto out_controller_put;
 	}
diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index bb57035c5770..b18ce69c0375 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -540,7 +540,6 @@ static int bcm2835aux_spi_probe(struct platform_device *pdev)
 
 	bs->irq = platform_get_irq(pdev, 0);
 	if (bs->irq <= 0) {
-		dev_err(&pdev->dev, "could not get IRQ: %d\n", bs->irq);
 		err = bs->irq ? bs->irq : -ENODEV;
 		goto out_master_put;
 	}
diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 9a06ffdb73b8..ebd1db88101e 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -339,7 +339,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no irq: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index df1c94a131e6..03fa79716689 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -521,7 +521,6 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no irq: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 7c41e4e82849..1c35eaaac838 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -540,7 +540,6 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
 		ret = -ENXIO;
-		dev_err(&pdev->dev, "irq number is invalid\n");
 		goto clk_dis_all;
 	}
 
diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 18c06568805e..fedc490de3f5 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -159,7 +159,6 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	dws->irq = platform_get_irq(pdev, 0);
 	if (dws->irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		return dws->irq; /* -ENXIO */
 	}
 
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index eb1f2142a335..1e4a8617c73c 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -401,7 +401,6 @@ static int efm32_spi_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(&pdev->dev, "failed to get rx irq (%d)\n", ret);
 		goto err;
 	}
 
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 4034e3ec0ba2..36e8a52af438 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -657,7 +657,6 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resources\n");
 		return -EBUSY;
 	}
 
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 53335ccc98f6..96eacbe6ae27 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1105,7 +1105,6 @@ static int dspi_probe(struct platform_device *pdev)
 	dspi_init(dspi);
 	dspi->irq = platform_get_irq(pdev, 0);
 	if (dspi->irq < 0) {
-		dev_err(&pdev->dev, "can't get platform irq\n");
 		ret = dspi->irq;
 		goto out_clk_put;
 	}
diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 41a49b93ca60..49af641d8420 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -861,7 +861,6 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "failed to get the irq: %d\n", ret);
 		goto err_disable_clk;
 	}
 
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5f0b0d5bfef4..aad2e2324ccd 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -540,7 +540,6 @@ static int spi_geni_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 8f01858c0ae6..31271fb367de 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -820,19 +820,16 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 
 	rx_irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
 	if (rx_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_RX_IRQ_NAME);
 		return -ENXIO;
 	}
 
 	tx_irq = platform_get_irq_byname(pdev, LTQ_SPI_TX_IRQ_NAME);
 	if (tx_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_TX_IRQ_NAME);
 		return -ENXIO;
 	}
 
 	err_irq = platform_get_irq_byname(pdev, LTQ_SPI_ERR_IRQ_NAME);
 	if (err_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_ERR_IRQ_NAME);
 		return -ENXIO;
 	}
 
diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 45d8a7048b6c..1f5f716016a2 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -664,7 +664,6 @@ static int mtk_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq (%d)\n", irq);
 		ret = irq;
 		goto err_put_master;
 	}
diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 734a2b956959..5c56caea04f0 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -388,7 +388,6 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		ret = irq;
 		goto out_disable_clk;
 	}
diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
index 37e2034ad4d5..f65a029e3fe9 100644
--- a/drivers/spi/spi-nuc900.c
+++ b/drivers/spi/spi-nuc900.c
@@ -367,7 +367,6 @@ static int nuc900_spi_probe(struct platform_device *pdev)
 
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ specified\n");
 		err = -ENOENT;
 		goto err_pdata;
 	}
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 8894f98cc99c..dd99324ab728 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1008,7 +1008,6 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "failed to get the irq: %d\n", ret);
 		goto err_disable_clk;
 	}
 
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index b635526ad414..11b692923fd7 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -590,7 +590,6 @@ static int pic32_sqi_probe(struct platform_device *pdev)
 	/* irq */
 	sqi->irq = platform_get_irq(pdev, 0);
 	if (sqi->irq < 0) {
-		dev_err(&pdev->dev, "no irq found\n");
 		ret = sqi->irq;
 		goto err_free_master;
 	}
diff --git a/drivers/spi/spi-pic32.c b/drivers/spi/spi-pic32.c
index 10cebeaa1e6b..f0dc941c2927 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -712,19 +712,16 @@ static int pic32_spi_hw_probe(struct platform_device *pdev,
 	/* get irq resources: err-irq, rx-irq, tx-irq */
 	pic32s->fault_irq = platform_get_irq_byname(pdev, "fault");
 	if (pic32s->fault_irq < 0) {
-		dev_err(&pdev->dev, "fault-irq not found\n");
 		return pic32s->fault_irq;
 	}
 
 	pic32s->rx_irq = platform_get_irq_byname(pdev, "rx");
 	if (pic32s->rx_irq < 0) {
-		dev_err(&pdev->dev, "rx-irq not found\n");
 		return pic32s->rx_irq;
 	}
 
 	pic32s->tx_irq = platform_get_irq_byname(pdev, "tx");
 	if (pic32s->tx_irq < 0) {
-		dev_err(&pdev->dev, "tx-irq not found\n");
 		return pic32s->tx_irq;
 	}
 
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index e0f061139c8f..f334a4410a6f 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -455,7 +455,6 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "Failed to get irq %d\n", ret);
 		goto exit_probe_master_put;
 	}
 	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index 48d8dff05a3a..aea8fd98a31f 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -545,7 +545,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 
 	hw->irq = platform_get_irq(pdev, 0);
 	if (hw->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ specified\n");
 		err = -ENOENT;
 		goto err_no_pdata;
 	}
diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index b50bdbc27e58..f73f811c9ba7 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1346,7 +1346,6 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	i = platform_get_irq(pdev, 0);
 	if (i < 0) {
-		dev_err(&pdev->dev, "cannot get IRQ\n");
 		ret = i;
 		goto err1;
 	}
diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index f1ee58208216..b83124030b2f 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -438,7 +438,6 @@ static int spi_sh_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq error: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 93ec2c6cdbfd..5bf2b57e6929 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -323,7 +323,6 @@ static int sifive_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Unable to find interrupt\n");
 		ret = irq;
 		goto put_master;
 	}
diff --git a/drivers/spi/spi-slave-mt27xx.c b/drivers/spi/spi-slave-mt27xx.c
index d1075433f6a6..61bc43b0fe57 100644
--- a/drivers/spi/spi-slave-mt27xx.c
+++ b/drivers/spi/spi-slave-mt27xx.c
@@ -410,7 +410,6 @@ static int mtk_spi_slave_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq (%d)\n", irq);
 		ret = irq;
 		goto err_put_ctlr;
 	}
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 1b7eebb72c07..53cf1af3b393 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -844,7 +844,6 @@ static int sprd_spi_irq_init(struct platform_device *pdev, struct sprd_spi *ss)
 
 	ss->irq = platform_get_irq(pdev, 0);
 	if (ss->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
 		return ss->irq;
 	}
 
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 655e4afbfb2a..bfe5794a6a5a 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -571,8 +571,6 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "IRQ error missing or invalid\n");
 		return irq;
 	}
 
diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index 5194bc07fd60..92e5c667b6a1 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -449,7 +449,6 @@ static int sun4i_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No spi IRQ specified\n");
 		ret = -ENXIO;
 		goto err_free_master;
 	}
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ee2bdaf5b856..1cf3051bba5e 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -456,7 +456,6 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No spi IRQ specified\n");
 		ret = -ENXIO;
 		goto err_free_master;
 	}
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index f99abd85c50a..ae17c99cce03 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -670,7 +670,6 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	rx_irq = platform_get_irq(pdev, 0);
 	if (rx_irq <= 0) {
-		dev_err(&pdev->dev, "get rx_irq failed (%d)\n", rx_irq);
 		ret = rx_irq;
 		goto put_spi;
 	}
@@ -685,7 +684,6 @@ static int synquacer_spi_probe(struct platform_device *pdev)
 
 	tx_irq = platform_get_irq(pdev, 1);
 	if (tx_irq <= 0) {
-		dev_err(&pdev->dev, "get tx_irq failed (%d)\n", tx_irq);
 		ret = tx_irq;
 		goto put_spi;
 	}
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 6ca600702470..3cb65371ae3b 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -717,7 +717,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		ret = irq;
 		goto free_master;
 	}
diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index b32c77df5d49..c1e6f3245557 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -454,7 +454,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		ret = irq;
 		goto out_disable_clk;
 	}
diff --git a/drivers/spi/spi-xlp.c b/drivers/spi/spi-xlp.c
index 1dc479fab98c..a299d4955356 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -385,7 +385,6 @@ static int xlp_spi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource found: %d\n", irq);
 		return irq;
 	}
 	err = devm_request_irq(&pdev->dev, irq, xlp_spi_interrupt, 0,
diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index c6bee67decb5..3155e2cabb1e 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -671,7 +671,6 @@ static int zynq_qspi_probe(struct platform_device *pdev)
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
-		dev_err(&pdev->dev, "irq resource not found\n");
 		goto remove_master;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynq_qspi_irq,
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 07a83ca164c2..5e9ea8a38163 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1077,7 +1077,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
-		dev_err(dev, "irq resource not found\n");
 		goto clk_dis_all;
 	}
 	ret = devm_request_irq(&pdev->dev, xqspi->irq, zynqmp_qspi_irq,
diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 4f3c2c13a225..ec8ea7924db0 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -3095,7 +3095,6 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
 		return irq;
 	}
 	status = devm_request_irq(&pdev->dev, irq, _nbu2ss_udc_irq,
diff --git a/drivers/staging/goldfish/goldfish_audio.c b/drivers/staging/goldfish/goldfish_audio.c
index 24a738238f9f..88f8159351e2 100644
--- a/drivers/staging/goldfish/goldfish_audio.c
+++ b/drivers/staging/goldfish/goldfish_audio.c
@@ -303,7 +303,6 @@ static int goldfish_audio_probe(struct platform_device *pdev)
 
 	data->irq = platform_get_irq(pdev, 0);
 	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
 		return -ENODEV;
 	}
 	data->buffer_virt = dmam_alloc_coherent(&pdev->dev,
diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index f050c7347fd5..c93b92482eff 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -2948,7 +2948,6 @@ static int allegro_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
 		return irq;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index c3665f0e87a2..ff189129ffd5 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -734,7 +734,6 @@ static int hantro_probe(struct platform_device *pdev)
 
 		irq = platform_get_irq_byname(vpu->pdev, irq_name);
 		if (irq <= 0) {
-			dev_err(vpu->dev, "Could not get %s IRQ.\n", irq_name);
 			return -ENXIO;
 		}
 
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 500b4c08d967..01190316007f 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1195,7 +1195,6 @@ static int imx7_csi_probe(struct platform_device *pdev)
 
 	csi->irq = platform_get_irq(pdev, 0);
 	if (csi->irq < 0) {
-		dev_err(dev, "Missing platform resources data\n");
 		return csi->irq;
 	}
 
diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index d1cdf011c8f1..b016e950f081 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -976,7 +976,6 @@ static int mipi_csis_probe(struct platform_device *pdev)
 
 	state->irq = platform_get_irq(pdev, 0);
 	if (state->irq < 0) {
-		dev_err(dev, "Failed to get irq\n");
 		return state->irq;
 	}
 
diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index 3a21a8cec799..09ed84b7ba32 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -302,7 +302,6 @@ int esparser_init(struct platform_device *pdev, struct amvdec_core *core)
 
 	irq = platform_get_irq_byname(pdev, "esparser");
 	if (irq < 0) {
-		dev_err(dev, "Failed getting ESPARSER IRQ from dtb\n");
 		return irq;
 	}
 
diff --git a/drivers/staging/media/omap4iss/iss.c b/drivers/staging/media/omap4iss/iss.c
index c8be1db532ab..1a966cb2f3a6 100644
--- a/drivers/staging/media/omap4iss/iss.c
+++ b/drivers/staging/media/omap4iss/iss.c
@@ -1276,7 +1276,6 @@ static int iss_probe(struct platform_device *pdev)
 	/* Interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		dev_err(iss->dev, "No IRQ resource\n");
 		ret = -ENODEV;
 		goto error_iss;
 	}
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
index c34aec7c6e40..6305a1369e88 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -161,8 +161,6 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 
 	irq_dec = platform_get_irq(dev->pdev, 0);
 	if (irq_dec <= 0) {
-		dev_err(dev->dev, "Failed to get IRQ\n");
-
 		return irq_dec;
 	}
 	ret = devm_request_irq(dev->dev, irq_dec, cedrus_irq,
diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index 31fbc1a75b06..c8bec3c34c2c 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -797,7 +797,6 @@ static int dim2_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, AHB0_INT_IDX);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get ahb0_int irq: %d\n", irq);
 		ret = irq;
 		goto err_shutdown_dim;
 	}
@@ -811,7 +810,6 @@ static int dim2_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, MLB_INT_IDX);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get mlb_int irq: %d\n", irq);
 		ret = irq;
 		goto err_shutdown_dim;
 	}
diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index 60db06768c8a..e8c9f4551941 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -676,7 +676,6 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
 		return -EINVAL;
 	}
 	ret = devm_request_irq(&pdev->dev, irq, mtk_hsdma_irq,
diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 08027a36e0bc..5a620df8762a 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -797,7 +797,6 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 
 	nvec->irq = platform_get_irq(pdev, 0);
 	if (nvec->irq < 0) {
-		dev_err(dev, "no irq resource?\n");
 		return -ENODEV;
 	}
 
diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 5854551d0a52..7f0dead772d9 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -827,7 +827,6 @@ static int gdma_dma_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
 		return -EINVAL;
 	}
 	ret = devm_request_irq(&pdev->dev, irq, gdma_dma_irq,
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 61c69f353cdb..97e5ae1896b0 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -142,7 +142,6 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "failed to get IRQ\n");
 		return irq;
 	}
 
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 5825ac581f56..d66b0b2f0ed1 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -332,7 +332,6 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get IRQ\n");
 		return irq;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index c32709badeda..0cdc30e8e532 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -255,7 +255,6 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
 		goto err_zone;
 	}
 	thermal->irq = ret;
diff --git a/drivers/thermal/db8500_thermal.c b/drivers/thermal/db8500_thermal.c
index b71a999d17d6..e391b5687147 100644
--- a/drivers/thermal/db8500_thermal.c
+++ b/drivers/thermal/db8500_thermal.c
@@ -408,7 +408,6 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	low_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_LOW");
 	if (low_irq < 0) {
-		dev_err(&pdev->dev, "Get IRQ_HOTMON_LOW failed.\n");
 		ret = low_irq;
 		goto out_unlock;
 	}
@@ -423,7 +422,6 @@ static int db8500_thermal_probe(struct platform_device *pdev)
 
 	high_irq = platform_get_irq_byname(pdev, "IRQ_HOTMON_HIGH");
 	if (high_irq < 0) {
-		dev_err(&pdev->dev, "Get IRQ_HOTMON_HIGH failed.\n");
 		ret = high_irq;
 		goto out_unlock;
 	}
diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 343c2f5c5a25..2637de9228c3 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1230,7 +1230,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index a824b78dabf8..c6acc81f34d8 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -95,7 +95,6 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 
 	sensor->irq = platform_get_irq(pdev, 0);
 	if (sensor->irq < 0) {
-		dev_err(dev, "failed to register IRQ\n");
 		return sensor->irq;
 	}
 
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index cf9ddc52f30e..9f550952e397 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -488,7 +488,6 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 
 	sensor->irq = platform_get_irq(pdev, 0);
 	if (sensor->irq < 0) {
-		dev_err(dev, "%s: Unable to find IRQ\n", __func__);
 		return sensor->irq;
 	}
 
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..84f0ee9d2ea6 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -788,7 +788,6 @@ static int ti_bandgap_talert_init(struct ti_bandgap *bgp,
 
 	bgp->irq = platform_get_irq(pdev, 0);
 	if (bgp->irq < 0) {
-		dev_err(&pdev->dev, "get_irq failed\n");
 		return bgp->irq;
 	}
 	ret = request_threaded_irq(bgp->irq, NULL,
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index bd53661103eb..b5f9d56e6643 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -57,7 +57,6 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "irq not found - %i", ret);
 		return ret;
 	}
 	data->uart.port.irq = ret;
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index eddf119374e1..719637550f49 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -107,7 +107,6 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "irq not found");
 		return irq;
 	}
 
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 164ba133437a..72207dd96550 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -177,7 +177,6 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
 		return irq;
 	}
 
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33b2a07..32fcbe8bdf6f 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2719,8 +2719,6 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "cannot obtain irq\n");
 		return ret;
 	}
 	uap->port.irq	= ret;
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 92dad2b4ec36..0bec6d94abb6 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2347,7 +2347,6 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->devtype = sdata->devtype;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot obtain irq\n");
 		return ret;
 	}
 	sport->port.irq = ret;
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0ad947..e18b939de972 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -688,8 +688,6 @@ static int serial_hs_lpc32xx_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Error getting irq for HS UART port %d\n",
-			uarts_registered);
 		return ret;
 	}
 	p->port.irq = ret;
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 7e7b1559fa36..37f28bc89b39 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -885,7 +885,6 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		/* Old bindings: no name on the single unamed UART0 IRQ */
 		irq = platform_get_irq(pdev, 0);
 		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get UART IRQ\n");
 			return irq;
 		}
 
@@ -898,7 +897,6 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		 */
 		irq = platform_get_irq_byname(pdev, "uart-rx");
 		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get 'uart-rx' IRQ\n");
 			return irq;
 		}
 
@@ -906,7 +904,6 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 
 		irq = platform_get_irq_byname(pdev, "uart-tx");
 		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get 'uart-tx' IRQ\n");
 			return irq;
 		}
 
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 29a6dc6a8d23..e709a020cd36 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -663,7 +663,6 @@ static int owl_uart_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 35e5f9c5d5be..307633055862 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1292,7 +1292,6 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ %d\n", irq);
 		return irq;
 	}
 	uport->irq = irq;
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 284623eefaeb..4438fc68ecdb 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -736,7 +736,6 @@ static int rda_uart_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get irq\n");
 		return irq;
 	}
 
diff --git a/drivers/tty/serial/sccnxp.c b/drivers/tty/serial/sccnxp.c
index 68a24a14f6b7..d2b77aae42ae 100644
--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -961,7 +961,6 @@ static int sccnxp_probe(struct platform_device *pdev)
 	if (!s->poll) {
 		s->irq = platform_get_irq(pdev, 0);
 		if (s->irq < 0) {
-			dev_err(&pdev->dev, "Missing irq resource data\n");
 			ret = -ENXIO;
 			goto err_out;
 		}
diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d5269aaaf9b2..c60fedfd6b69 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1308,7 +1308,6 @@ static int tegra_uart_probe(struct platform_device *pdev)
 	u->iotype = UPIO_MEM32;
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't get IRQ\n");
 		return ret;
 	}
 	u->irq = ret;
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index be4687814353..cd553311e31d 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -897,7 +897,6 @@ static int sifive_serial_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "could not acquire interrupt\n");
 		return -EPROBE_DEFER;
 	}
 
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4e6c0c..9a9937d72b19 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1174,7 +1174,6 @@ static int sprd_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
 		return irq;
 	}
 	up->irq = irq;
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 24a2261f879a..0619438079a5 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -928,8 +928,6 @@ static int stm32_init_port(struct stm32_port *stm32port,
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret <= 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get event IRQ: %d\n", ret);
 		return ret ? ret : -ENODEV;
 	}
 	port->irq = ret;
diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index f32cef94aa82..a717038d58d4 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -201,7 +201,6 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 	if (!uioinfo->irq) {
 		ret = platform_get_irq(pdev, 0);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get IRQ\n");
 			goto bad1;
 		}
 		uioinfo->irq = ret;
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 26062d610c20..36c964cd40a3 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -1008,7 +1008,6 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 
 	ci->irq = platform_get_irq(pdev, 0);
 	if (ci->irq < 0) {
-		dev_err(dev, "missing IRQ\n");
 		ret = ci->irq;
 		goto deinit_phy;
 	}
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 80fd3c6dcd1c..874a34903919 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -408,7 +408,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 
 	hsotg->irq = platform_get_irq(dev, 0);
 	if (hsotg->irq < 0) {
-		dev_err(&dev->dev, "missing IRQ resource\n");
 		return hsotg->irq;
 	}
 
diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
index cbee5fb9b9fb..a69eb4a7b832 100644
--- a/drivers/usb/dwc3/dwc3-keystone.c
+++ b/drivers/usb/dwc3/dwc3-keystone.c
@@ -112,7 +112,6 @@ static int kdwc3_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "missing irq\n");
 		error = irq;
 		goto err_irq;
 	}
diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
index ed8b86517675..d85ac2cd298b 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -470,7 +470,6 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
index db3628be38c0..c08d385e2723 100644
--- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
+++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
@@ -348,7 +348,6 @@ static int ast_vhub_probe(struct platform_device *pdev)
 	/* Find interrupt and install handler */
 	vhub->irq = platform_get_irq(pdev, 0);
 	if (vhub->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get interrupt\n");
 		rc = vhub->irq;
 		goto err;
 	}
diff --git a/drivers/usb/gadget/udc/bcm63xx_udc.c b/drivers/usb/gadget/udc/bcm63xx_udc.c
index c1fcc77403ea..1b696d1a678b 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2329,7 +2329,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource #0\n");
 		goto out_uninit;
 	}
 	if (devm_request_irq(dev, irq, &bcm63xx_udc_ctrl_isr, 0,
@@ -2340,7 +2339,6 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 	for (i = 0; i < BCM63XX_NUM_IUDMA; i++) {
 		irq = platform_get_irq(pdev, i + 1);
 		if (irq < 0) {
-			dev_err(dev, "missing IRQ resource #%d\n", i + 1);
 			goto out_uninit;
 		}
 		if (devm_request_irq(dev, irq, &bcm63xx_udc_data_isr, 0,
diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index ccbd1d34eb2a..5019fce7fa2e 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -516,7 +516,6 @@ static int bdc_probe(struct platform_device *pdev)
 	}
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "platform_get_irq failed:%d\n", irq);
 		return irq;
 	}
 	spin_lock_init(&bdc->lock);
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 729e60e49564..d46a181eed6f 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2135,7 +2135,6 @@ static int gr_probe(struct platform_device *pdev)
 
 	dev->irq = platform_get_irq(pdev, 0);
 	if (dev->irq <= 0) {
-		dev_err(dev->dev, "No irq found\n");
 		return -ENODEV;
 	}
 
@@ -2144,7 +2143,6 @@ static int gr_probe(struct platform_device *pdev)
 	if (dev->irqi > 0) {
 		dev->irqo = platform_get_irq(pdev, 2);
 		if (dev->irqo <= 0) {
-			dev_err(dev->dev, "Found irqi but not irqo\n");
 			return -ENODEV;
 		}
 	} else {
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 5f1b14f3e5a0..da219f3e98ee 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3062,8 +3062,6 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	for (i = 0; i < 4; i++) {
 		udc->udp_irq[i] = platform_get_irq(pdev, i);
 		if (udc->udp_irq[i] < 0) {
-			dev_err(udc->dev,
-				"irq resource %d not available!\n", i);
 			return udc->udp_irq[i];
 		}
 	}
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 87062d22134d..205d39e857a6 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2744,7 +2744,6 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 31c7c5587cf9..9486ed871ae9 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -1312,7 +1312,6 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
-		dev_err(dev, "unable to obtain IRQ number\n");
 		goto err_res;
 	}
 	hsudc->irq = ret;
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index b1f4104d1283..8bc7b8c5bcef 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -2075,7 +2075,6 @@ static int xudc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to get irq\n");
 		return irq;
 	}
 	ret = devm_request_irq(&pdev->dev, irq, xudc_irq, 0,
diff --git a/drivers/usb/host/ehci-atmel.c b/drivers/usb/host/ehci-atmel.c
index 3ba140ceaf52..e893467d659c 100644
--- a/drivers/usb/host/ehci-atmel.c
+++ b/drivers/usb/host/ehci-atmel.c
@@ -100,9 +100,6 @@ static int ehci_atmel_drv_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev,
-			"Found HC with no IRQ. Check %s setup!\n",
-			dev_name(&pdev->dev));
 		retval = -ENODEV;
 		goto fail_create_hcd;
 	}
diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7d20296cbe9f..fc84142898fe 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -116,7 +116,6 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "EHCI irq failed: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 790acf3633e8..a319b1df3011 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -223,9 +223,6 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev,
-			"Found HC with no IRQ. Check %s setup!\n",
-			dev_name(&pdev->dev));
 		err = -ENODEV;
 		goto err;
 	}
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index 4c306fb6b069..4746096a010c 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -146,7 +146,6 @@ static int ehci_platform_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
 		return irq;
 	}
 
diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index a9ee767952c1..ef75b9d70eb4 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -85,9 +85,6 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(&pdev->dev,
-			"Found HC with no IRQ. Check %s setup!\n",
-			dev_name(&pdev->dev));
 		ret = -ENODEV;
 		goto fail_create_hcd;
 	}
diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index ccb4e611001d..d460cf431a57 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -159,7 +159,6 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
 		return irq;
 	}
 	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
diff --git a/drivers/usb/host/imx21-hcd.c b/drivers/usb/host/imx21-hcd.c
index 6e3dad19d369..3912104b47e4 100644
--- a/drivers/usb/host/imx21-hcd.c
+++ b/drivers/usb/host/imx21-hcd.c
@@ -1837,7 +1837,6 @@ static int imx21_probe(struct platform_device *pdev)
 		return -ENODEV;
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 65a1c3fdc88c..6fe0ea1efa4a 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -112,7 +112,6 @@ static int ohci_platform_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
 		return irq;
 	}
 
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index 638a92bd2cdc..e8c2f1e52e5c 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -139,7 +139,6 @@ static int st_ohci_platform_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
 		return irq;
 	}
 
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index f8bd1d57e795..92111fd5dab0 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -836,7 +836,6 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 
 	mtu->irq = platform_get_irq(pdev, 0);
 	if (mtu->irq < 0) {
-		dev_err(dev, "fail to get irq number\n");
 		return mtu->irq;
 	}
 	dev_info(dev, "irq %d\n", mtu->irq);
diff --git a/drivers/usb/phy/phy-ab8500-usb.c b/drivers/usb/phy/phy-ab8500-usb.c
index aaf363f19714..0d92ef4d4833 100644
--- a/drivers/usb/phy/phy-ab8500-usb.c
+++ b/drivers/usb/phy/phy-ab8500-usb.c
@@ -713,7 +713,6 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 	if (ab->flags & AB8500_USB_FLAG_USE_LINK_STATUS_IRQ) {
 		irq = platform_get_irq_byname(pdev, "USB_LINK_STATUS");
 		if (irq < 0) {
-			dev_err(&pdev->dev, "Link status irq not found\n");
 			return irq;
 		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
@@ -729,7 +728,6 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 	if (ab->flags & AB8500_USB_FLAG_USE_ID_WAKEUP_IRQ) {
 		irq = platform_get_irq_byname(pdev, "ID_WAKEUP_F");
 		if (irq < 0) {
-			dev_err(&pdev->dev, "ID fall irq not found\n");
 			return irq;
 		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
@@ -745,7 +743,6 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 	if (ab->flags & AB8500_USB_FLAG_USE_VBUS_DET_IRQ) {
 		irq = platform_get_irq_byname(pdev, "VBUS_DET_F");
 		if (irq < 0) {
-			dev_err(&pdev->dev, "VBUS fall irq not found\n");
 			return irq;
 		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 6b317c150bdd..8ba525cc7bd9 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -618,7 +618,6 @@ static int wcove_typec_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 5ff8e0320d95..4a16354d65c8 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1114,7 +1114,6 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 
 	sinfo->irq_base = platform_get_irq(pdev, 0);
 	if (sinfo->irq_base < 0) {
-		dev_err(dev, "unable to get irq\n");
 		ret = sinfo->irq_base;
 		goto stop_clk;
 	}
diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 17174cd7a5bb..d6124976139b 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -447,7 +447,6 @@ static int mmphw_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "%s: no IRQ defined\n", __func__);
 		ret = -ENOENT;
 		goto failed;
 	}
diff --git a/drivers/video/fbdev/nuc900fb.c b/drivers/video/fbdev/nuc900fb.c
index 4fd851598584..781f14515227 100644
--- a/drivers/video/fbdev/nuc900fb.c
+++ b/drivers/video/fbdev/nuc900fb.c
@@ -527,7 +527,6 @@ static int nuc900fb_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
 		return -ENOENT;
 	}
 
diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 1410f476e135..8ad3828ca618 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -626,7 +626,6 @@ static int pxa168fb_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ defined\n");
 		return -ENOENT;
 	}
 
diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 74ffb446e00c..9e24237eddf6 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -615,7 +615,6 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 	/* request the IRQ */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "no IRQ defined: %d\n", irq);
 		return irq;
 	}
 
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 4282cb117b92..b44f402ce552 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2353,7 +2353,6 @@ static int pxafb_probe(struct platform_device *dev)
 
 	irq = platform_get_irq(dev, 0);
 	if (irq < 0) {
-		dev_err(&dev->dev, "no IRQ defined\n");
 		ret = -ENODEV;
 		goto failed_free_mem;
 	}
diff --git a/drivers/video/fbdev/s3c2410fb.c b/drivers/video/fbdev/s3c2410fb.c
index a702da89910b..d1b4e93a189d 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -850,7 +850,6 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
 		return -ENOENT;
 	}
 
diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index be8d9702cbb2..a10088e1cdb0 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -372,7 +372,6 @@ static int vt8500lcd_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ defined\n");
 		ret = -ENODEV;
 		goto failed_free_palette;
 	}
diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index edba4e278685..5313def49f35 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -285,7 +285,6 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 
 	wdt->irq = platform_get_irq(pdev, 0);
 	if (wdt->irq < 0) {
-		dev_err(dev, "failed to get IRQ resource\n");
 		return wdt->irq;
 	}
 
diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 0f2c574f27f1..41c8fafe2763 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -573,7 +573,6 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	dd->irq = platform_get_irq(pdev, 0);
 	if (dd->irq < 0) {
 		ret = dd->irq;
-		dev_err(dev, "failed to could not get irq: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index e09c28349e0d..d7bf194802b6 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -614,7 +614,6 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	dd->irq = platform_get_irq(pdev, 0);
 	if (dd->irq < 0) {
 		ret = dd->irq;
-		dev_err(dev, "failed to get irq: %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index b7c358b48d8d..e4d6e6dc79cc 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1343,7 +1343,6 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 
 	cygaud->irq_num = platform_get_irq(pdev, 0);
 	if (cygaud->irq_num <= 0) {
-		dev_err(dev, "platform_get_irq failed\n");
 		err = cygaud->irq_num;
 		return err;
 	}
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 368b6c09474b..8ced37b19fca 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1186,7 +1186,6 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq_byname(pdev, "mbhc_switch_int");
 	if (irq < 0) {
-		dev_err(dev, "failed to get mbhc switch irq\n");
 		return irq;
 	}
 
@@ -1201,7 +1200,6 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	if (priv->mbhc_btn_enabled) {
 		irq = platform_get_irq_byname(pdev, "mbhc_but_press_det");
 		if (irq < 0) {
-			dev_err(dev, "failed to get button press irq\n");
 			return irq;
 		}
 
@@ -1215,7 +1213,6 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 
 		irq = platform_get_irq_byname(pdev, "mbhc_but_rel_det");
 		if (irq < 0) {
-			dev_err(dev, "failed to get button release irq\n");
 			return irq;
 		}
 
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 472c2fff34a8..2bcdd93113f9 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1109,7 +1109,6 @@ static int twl6040_probe(struct snd_soc_component *component)
 
 	priv->plug_irq = platform_get_irq(pdev, 0);
 	if (priv->plug_irq < 0) {
-		dev_err(component->dev, "invalid irq: %d\n", priv->plug_irq);
 		return priv->plug_irq;
 	}
 
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index cbbf6257f08a..8d65c4b749b0 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -886,7 +886,6 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return irq;
 	}
 
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 10d2210c91ef..b0197d597438 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -825,7 +825,6 @@ static int fsl_esai_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return irq;
 	}
 
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d58cc3ae90d8..472825b27fab 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -833,7 +833,6 @@ static int fsl_sai_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return irq;
 	}
 
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 4842e6df9a2d..531c0e278d9f 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1249,7 +1249,6 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return irq;
 	}
 
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fa862af25c1a..20c97eaba7ce 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1511,7 +1511,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 
 	ssi->irq = platform_get_irq(pdev, 0);
 	if (ssi->irq < 0) {
-		dev_err(dev, "no irq for node %s\n", pdev->name);
 		return ssi->irq;
 	}
 
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 9038b61317be..21b122edde59 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -521,7 +521,6 @@ static int imx_ssi_probe(struct platform_device *pdev)
 
 	ssi->irq = platform_get_irq(pdev, 0);
 	if (ssi->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", ssi->irq);
 		return ssi->irq;
 	}
 
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3446a113f482..d66df1dfcc71 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -540,7 +540,6 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 
 	priv->irq = platform_get_irq(pdev, 0);
 	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed: %d\n", priv->irq);
 		return priv->irq;
 	}
 
diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index c7a81c4be068..735420c7ae6d 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -1336,7 +1336,6 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 	/* irq */
 	irq_id = platform_get_irq(pdev, 0);
 	if (irq_id <= 0) {
-		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
 		return irq_id < 0 ? irq_id : -ENXIO;
 	}
 
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 7064a9fd6f74..b00c72cb3501 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1343,7 +1343,6 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	irq_id = platform_get_irq_byname(pdev, "asys");
 	if (irq_id < 0) {
-		dev_err(dev, "unable to get ASYS IRQ\n");
 		return irq_id;
 	}
 
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 0382896c162e..7ddc4eb7feb2 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1076,7 +1076,6 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 
 	irq_id = platform_get_irq(pdev, 0);
 	if (irq_id <= 0) {
-		dev_err(afe->dev, "np %pOFn no irq\n", afe->dev->of_node);
 		return irq_id < 0 ? irq_id : -ENXIO;
 	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 269b6d6df250..df2b706a9ef8 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -795,8 +795,6 @@ static int mxs_saif_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
-			ret);
 		return ret;
 	}
 
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index cf7a299f4547..8a05dfa6b96f 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -565,8 +565,6 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 
 	drvdata->lpaif_irq = platform_get_irq_byname(pdev, "lpass-irq-lpaif");
 	if (drvdata->lpaif_irq < 0) {
-		dev_err(&pdev->dev, "error getting irq handle: %d\n",
-			drvdata->lpaif_irq);
 		return -ENODEV;
 	}
 
diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 70d524ef9bc0..6757313853a8 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -614,8 +614,6 @@ static int bdw_probe(struct snd_sof_dev *sdev)
 	/* register our IRQ */
 	sdev->ipc_irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
 	if (sdev->ipc_irq < 0) {
-		dev_err(sdev->dev, "error: failed to get IRQ at index %d\n",
-			desc->irqindex_host_ipc);
 		return sdev->ipc_irq;
 	}
 
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 107d711efc3f..5349b1d53548 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -729,8 +729,6 @@ static int byt_acpi_probe(struct snd_sof_dev *sdev)
 	/* register our IRQ */
 	sdev->ipc_irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
 	if (sdev->ipc_irq < 0) {
-		dev_err(sdev->dev, "error: failed to get IRQ at index %d\n",
-			desc->irqindex_host_ipc);
 		return sdev->ipc_irq;
 	}
 
diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index 7448015a4935..6f7836c75bf2 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -960,7 +960,6 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get MCDT interrupt\n");
 		return irq;
 	}
 
diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 645bcbe91601..c655ca2dd945 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -427,7 +427,6 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 
 	uni->irq = platform_get_irq(priv->pdev, 0);
 	if (uni->irq < 0) {
-		dev_err(dev, "Failed to get IRQ resource\n");
 		return -ENXIO;
 	}
 
diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index ba6452dab69b..66c4629a3aff 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -856,8 +856,6 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	/* Get irqs */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return irq;
 	}
 
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 63f68e663676..e0a3674212a9 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -196,7 +196,6 @@ static int stm32_sai_probe(struct platform_device *pdev)
 	/* init irqs */
 	sai->irq = platform_get_irq(pdev, 0);
 	if (sai->irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
 		return sai->irq;
 	}
 
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index ee71b898897b..94125952500d 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -910,7 +910,6 @@ static int stm32_spdifrx_parse_of(struct platform_device *pdev,
 
 	spdifrx->irq = platform_get_irq(pdev, 0);
 	if (spdifrx->irq < 0) {
-		dev_err(&pdev->dev, "No irq for node %s\n", pdev->name);
 		return spdifrx->irq;
 	}
 
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9b2232908b65..40e4e8e03428 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1088,7 +1088,6 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Can't retrieve our interrupt\n");
 		return irq;
 	}
 
diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index fa001d3c1a88..65bafc38ad54 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -292,7 +292,6 @@ int uniphier_aiodma_soc_register_platform(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(dev, "Could not get irq.\n");
 		return irq;
 	}
 
diff --git a/sound/soc/xilinx/xlnx_formatter_pcm.c b/sound/soc/xilinx/xlnx_formatter_pcm.c
index dc8721f4f56b..48970efe7838 100644
--- a/sound/soc/xilinx/xlnx_formatter_pcm.c
+++ b/sound/soc/xilinx/xlnx_formatter_pcm.c
@@ -613,7 +613,6 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		aud_drv_data->mm2s_irq = platform_get_irq_byname(pdev,
 								 "irq_mm2s");
 		if (aud_drv_data->mm2s_irq < 0) {
-			dev_err(dev, "xlnx audio mm2s irq resource failed\n");
 			ret = aud_drv_data->mm2s_irq;
 			goto clk_err;
 		}
@@ -640,7 +639,6 @@ static int xlnx_formatter_pcm_probe(struct platform_device *pdev)
 		aud_drv_data->s2mm_irq = platform_get_irq_byname(pdev,
 								 "irq_s2mm");
 		if (aud_drv_data->s2mm_irq < 0) {
-			dev_err(dev, "xlnx audio s2mm irq resource failed\n");
 			ret = aud_drv_data->s2mm_irq;
 			goto clk_err;
 		}
diff --git a/sound/soc/xtensa/xtfpga-i2s.c b/sound/soc/xtensa/xtfpga-i2s.c
index 9ce2c75186b9..e635bf08d935 100644
--- a/sound/soc/xtensa/xtfpga-i2s.c
+++ b/sound/soc/xtensa/xtfpga-i2s.c
@@ -572,7 +572,6 @@ static int xtfpga_i2s_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
 		err = irq;
 		goto err;
 	}
diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 5fd4e32247a6..e7c2e1a7d77c 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1709,7 +1709,6 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Could not get irq resource: %d\n", irq);
 		return irq;
 	}
 
-- 
Sent by a computer through tubes

