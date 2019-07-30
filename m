Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE648C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19EF8206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 05:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HClpqtJP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfG3Fi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 01:38:59 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:38191 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfG3Fi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 01:38:58 -0400
Received: by mail-pf1-f170.google.com with SMTP id y15so29221854pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 22:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rzh1fZ6HnslJUQtXCcog1yIHeZiWZzMmKYJsmDKRRkI=;
        b=HClpqtJPA7I27VHaMa/MQkyg/4ILc2ZbzK8cmtf/1JmEqQsY01IKdoU+5+5+uS2b35
         vS/FmuSkhY8fp362/SIG8FxH6BSdBPDCbcnzonFXwuBLw/DOwUKghpl/QNYmHNi8uZ1R
         FWwEGXuSeFA4nicUNeHKZjnDfjwYhXTj91nS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rzh1fZ6HnslJUQtXCcog1yIHeZiWZzMmKYJsmDKRRkI=;
        b=fNkpXp16Dc65MHwis7qXMKlsC8Ymx1GtTklKlAAwEldDAQgojSob8dF2qsr2Vcn6GA
         v6sZ0zrozPKI1YGiNHwCFOXl2hmDk3GliJl5cYj9J6yfr3BUs5HaHZNckC91yEQ8jbHy
         mmEPFAzWixewPg81Blvpq2ly2LsLkbcas23zE1YeVa0tsovQOQOG9jWE010aDsCmcOCY
         tvau41J/w+BqFmETfo1/QBEr+tGYIBYN9aNfO0fRCSWjw82TMvoWCGvVEE0DIwB0BIQc
         lopFKfDjMoQbinKXMgqgNSl2a1pTP+4LXkXTxdaqvWeiXfbZ6jaz+2q3SGte+2uujvZ3
         ALvg==
X-Gm-Message-State: APjAAAVv8TQWBBnbht8N6jzj22v/SZwD2tPcyr2ouzjEiNI0H7KBltyh
        nfZsWAOuTIbqc48uI9ruefEO4g==
X-Google-Smtp-Source: APXvYqzqGASq1+nou5JkkH/C+xtC+q6oOYb3Pt2++nbS05I4yjGLI0yKGcjwFHbqzhLseyTxP1p8OA==
X-Received: by 2002:a17:90a:bd8c:: with SMTP id z12mr40374138pjr.60.1564465130009;
        Mon, 29 Jul 2019 22:38:50 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r1sm59306805pgv.70.2019.07.29.22.38.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 22:38:49 -0700 (PDT)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH v5 2/3] treewide: Remove dev_err() usage after platform_get_irq()
Date:   Mon, 29 Jul 2019 22:38:44 -0700
Message-Id: <20190730053845.126834-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190730053845.126834-1-swboyd@chromium.org>
References: <20190730053845.126834-1-swboyd@chromium.org>
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

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Rob Herring <robh@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
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
index 9a6e4923bd69..88b5dd99f6bc 100644
--- a/arch/arm/plat-pxa/ssp.c
+++ b/arch/arm/plat-pxa/ssp.c
@@ -146,10 +146,9 @@ static int pxa_ssp_probe(struct platform_device *pdev)
 	}
 
 	ssp->irq = platform_get_irq(pdev, 0);
-	if (ssp->irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
+	if (ssp->irq < 0)
 		return -ENODEV;
-	}
+
 
 	if (dev->of_node) {
 		const struct of_device_id *id =
diff --git a/arch/arm/plat-samsung/adc.c b/arch/arm/plat-samsung/adc.c
index ee3d5c989a76..4bbeca3cbd9e 100644
--- a/arch/arm/plat-samsung/adc.c
+++ b/arch/arm/plat-samsung/adc.c
@@ -354,10 +354,8 @@ static int s3c_adc_probe(struct platform_device *pdev)
 	}
 
 	adc->irq = platform_get_irq(pdev, 1);
-	if (adc->irq <= 0) {
-		dev_err(dev, "failed to get adc irq\n");
+	if (adc->irq <= 0)
 		return -ENOENT;
-	}
 
 	ret = devm_request_irq(dev, adc->irq, s3c_adc_irq, 0, dev_name(dev),
 				adc);
diff --git a/arch/mips/ralink/timer.c b/arch/mips/ralink/timer.c
index 0ad8ff2e4f6e..652424d8ed51 100644
--- a/arch/mips/ralink/timer.c
+++ b/arch/mips/ralink/timer.c
@@ -106,10 +106,8 @@ static int rt_timer_probe(struct platform_device *pdev)
 	}
 
 	rt->irq = platform_get_irq(pdev, 0);
-	if (rt->irq < 0) {
-		dev_err(&pdev->dev, "failed to load irq\n");
+	if (rt->irq < 0)
 		return rt->irq;
-	}
 
 	rt->membase = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rt->membase))
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 72312ad2e142..433d54d269e1 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -583,11 +583,8 @@ int ahci_platform_init_host(struct platform_device *pdev,
 	int i, irq, n_ports, rc;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "no irq\n");
-		return irq;
-	}
+	if (irq <= 0)
+		return irq ? : -ENXIO;
 
 	hpriv->irq = irq;
 
diff --git a/drivers/ata/pata_rb532_cf.c b/drivers/ata/pata_rb532_cf.c
index 7c37f2ff09e4..4eea43a86e57 100644
--- a/drivers/ata/pata_rb532_cf.c
+++ b/drivers/ata/pata_rb532_cf.c
@@ -115,10 +115,8 @@ static int rb532_pata_driver_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
+	if (irq <= 0)
 		return -ENOENT;
-	}
 
 	gpiod = devm_gpiod_get(&pdev->dev, NULL, GPIOD_IN);
 	if (IS_ERR(gpiod)) {
diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
index ad3893c62572..efd1925a97b9 100644
--- a/drivers/ata/sata_highbank.c
+++ b/drivers/ata/sata_highbank.c
@@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
+	if (irq <= 0)
 		return -EINVAL;
-	}
 
 	hpriv = devm_kzalloc(dev, sizeof(*hpriv), GFP_KERNEL);
 	if (!hpriv) {
diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 1b76d9585902..be79d6c6a4e4 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -651,10 +651,8 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 		return PTR_ERR(rsb->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	rsb->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(rsb->clk)) {
diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 69f537980004..d996875862cc 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -216,10 +216,8 @@ static int imx_rngc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "Couldn't get irq %d\n", irq);
+	if (irq <= 0)
 		return irq;
-	}
 
 	ret = clk_prepare_enable(rngc->clk);
 	if (ret)
diff --git a/drivers/char/hw_random/omap-rng.c b/drivers/char/hw_random/omap-rng.c
index e9b6ac61fb7f..82261f1c4d63 100644
--- a/drivers/char/hw_random/omap-rng.c
+++ b/drivers/char/hw_random/omap-rng.c
@@ -385,11 +385,8 @@ static int of_get_omap_rng_device_details(struct omap_rng_dev *priv,
 	if (of_device_is_compatible(dev->of_node, "ti,omap4-rng") ||
 	    of_device_is_compatible(dev->of_node, "inside-secure,safexcel-eip76")) {
 		irq = platform_get_irq(pdev, 0);
-		if (irq < 0) {
-			dev_err(dev, "%s: error getting IRQ resource - %d\n",
-				__func__, irq);
+		if (irq < 0)
 			return irq;
-		}
 
 		err = devm_request_irq(dev, irq, omap4_rng_irq,
 				       IRQF_TRIGGER_NONE, dev_name(dev), priv);
diff --git a/drivers/char/hw_random/xgene-rng.c b/drivers/char/hw_random/xgene-rng.c
index 8c6f9f63da5e..b1439a3aaa1d 100644
--- a/drivers/char/hw_random/xgene-rng.c
+++ b/drivers/char/hw_random/xgene-rng.c
@@ -330,10 +330,8 @@ static int xgene_rng_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->csr_base);
 
 	rc = platform_get_irq(pdev, 0);
-	if (rc < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (rc < 0)
 		return rc;
-	}
 	ctx->irq = rc;
 
 	dev_dbg(&pdev->dev, "APM X-Gene RNG BASE %p ALARM IRQ %d",
diff --git a/drivers/clocksource/em_sti.c b/drivers/clocksource/em_sti.c
index 8e12b11e81b0..9039df4f90e2 100644
--- a/drivers/clocksource/em_sti.c
+++ b/drivers/clocksource/em_sti.c
@@ -291,10 +291,8 @@ static int em_sti_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, p);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	/* map memory, let base point to the STI instance */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 55d3e03f2cd4..f6424b61e212 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -776,11 +776,8 @@ static int sh_cmt_register_clockevent(struct sh_cmt_channel *ch,
 	int ret;
 
 	irq = platform_get_irq(ch->cmt->pdev, ch->index);
-	if (irq < 0) {
-		dev_err(&ch->cmt->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_irq(irq, sh_cmt_interrupt,
 			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 49f1c805fc95..8c4f3753b36e 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -462,11 +462,8 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 		ch->base = tmu->mapbase + 8 + ch->index * 12;
 
 	ch->irq = platform_get_irq(tmu->pdev, index);
-	if (ch->irq < 0) {
-		dev_err(&tmu->pdev->dev, "ch%u: failed to get irq\n",
-			ch->index);
+	if (ch->irq < 0)
 		return ch->irq;
-	}
 
 	ch->cs_enabled = false;
 	ch->enable_count = 0;
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
index 980aa04b655b..d611cfe6e8e5 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -339,10 +339,8 @@ static int init_cc_resources(struct platform_device *plat_dev)
 
 	/* Then IRQ */
 	new_drvdata->irq = platform_get_irq(plat_dev, 0);
-	if (new_drvdata->irq < 0) {
-		dev_err(dev, "Failed getting IRQ resource\n");
+	if (new_drvdata->irq < 0)
 		return new_drvdata->irq;
-	}
 
 	init_completion(&new_drvdata->hw_queue_avail);
 
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
index 125318a88cd4..4f43318ca14b 100644
--- a/drivers/crypto/mediatek/mtk-platform.c
+++ b/drivers/crypto/mediatek/mtk-platform.c
@@ -495,10 +495,8 @@ static int mtk_crypto_probe(struct platform_device *pdev)
 
 	for (i = 0; i < MTK_IRQ_NUM; i++) {
 		cryp->irq[i] = platform_get_irq(pdev, i);
-		if (cryp->irq[i] < 0) {
-			dev_err(cryp->dev, "no IRQ:%d resource info\n", i);
+		if (cryp->irq[i] < 0)
 			return cryp->irq[i];
-		}
 	}
 
 	cryp->clk_cryp = devm_clk_get(&pdev->dev, "cryp");
diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index f1fa637cb029..bf8d2197bc11 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -994,16 +994,12 @@ static int mxs_dcp_probe(struct platform_device *pdev)
 	}
 
 	dcp_vmi_irq = platform_get_irq(pdev, 0);
-	if (dcp_vmi_irq < 0) {
-		dev_err(dev, "Failed to get IRQ: (%d)!\n", dcp_vmi_irq);
+	if (dcp_vmi_irq < 0)
 		return dcp_vmi_irq;
-	}
 
 	dcp_irq = platform_get_irq(pdev, 1);
-	if (dcp_irq < 0) {
-		dev_err(dev, "Failed to get IRQ: (%d)!\n", dcp_irq);
+	if (dcp_irq < 0)
 		return dcp_irq;
-	}
 
 	sdcp = devm_kzalloc(dev, sizeof(*sdcp), GFP_KERNEL);
 	if (!sdcp)
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
index b0b8e3d48aef..8ac8ec6decd5 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -1403,10 +1403,8 @@ static int sahara_probe(struct platform_device *pdev)
 
 	/* Get the IRQ */
 	irq = platform_get_irq(pdev,  0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	err = devm_request_irq(&pdev->dev, irq, sahara_irq_handler,
 			       0, dev_name(&pdev->dev), dev);
diff --git a/drivers/crypto/stm32/stm32-cryp.c b/drivers/crypto/stm32/stm32-cryp.c
index 98ae02826e8f..72f86063b046 100644
--- a/drivers/crypto/stm32/stm32-cryp.c
+++ b/drivers/crypto/stm32/stm32-cryp.c
@@ -1975,10 +1975,8 @@ static int stm32_cryp_probe(struct platform_device *pdev)
 		return PTR_ERR(cryp->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Cannot get IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, stm32_cryp_irq,
 					stm32_cryp_irq_thread, IRQF_ONESHOT,
diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 2b70d8796f25..cfc8e0e37bee 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1450,10 +1450,8 @@ static int stm32_hash_probe(struct platform_device *pdev)
 		return ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Cannot get IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, stm32_hash_irq_handler,
 					stm32_hash_irq_thread, IRQF_ONESHOT,
diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 35c38aad8b4f..ffd17aba7533 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -674,10 +674,8 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	platform_set_drvdata(pdev, tegra);
 
diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
index 7fe9309a876b..b5547436ad7e 100644
--- a/drivers/dma/dma-jz4780.c
+++ b/drivers/dma/dma-jz4780.c
@@ -878,10 +878,8 @@ static int jz4780_dma_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 
 	jzdma->irq = ret;
 
diff --git a/drivers/dma/fsl-edma.c b/drivers/dma/fsl-edma.c
index fcbad6ae954a..71650fa01f18 100644
--- a/drivers/dma/fsl-edma.c
+++ b/drivers/dma/fsl-edma.c
@@ -125,16 +125,12 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
 	int ret;
 
 	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
-	if (fsl_edma->txirq < 0) {
-		dev_err(&pdev->dev, "Can't get edma-tx irq.\n");
+	if (fsl_edma->txirq < 0)
 		return fsl_edma->txirq;
-	}
 
 	fsl_edma->errirq = platform_get_irq_byname(pdev, "edma-err");
-	if (fsl_edma->errirq < 0) {
-		dev_err(&pdev->dev, "Can't get edma-err irq.\n");
+	if (fsl_edma->errirq < 0)
 		return fsl_edma->errirq;
-	}
 
 	if (fsl_edma->txirq == fsl_edma->errirq) {
 		ret = devm_request_irq(&pdev->dev, fsl_edma->txirq,
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 8e341c0c13bc..06664fbd2d91 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -758,10 +758,8 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 
 	fsl_qdma->error_irq =
 		platform_get_irq_byname(pdev, "qdma-error");
-	if (fsl_qdma->error_irq < 0) {
-		dev_err(&pdev->dev, "Can't get qdma controller irq.\n");
+	if (fsl_qdma->error_irq < 0)
 		return fsl_qdma->error_irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, fsl_qdma->error_irq,
 			       fsl_qdma_error_handler, 0,
@@ -776,11 +774,8 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 		fsl_qdma->queue_irq[i] =
 				platform_get_irq_byname(pdev, irq_name);
 
-		if (fsl_qdma->queue_irq[i] < 0) {
-			dev_err(&pdev->dev,
-				"Can't get qdma queue %d irq.\n", i);
+		if (fsl_qdma->queue_irq[i] < 0)
 			return fsl_qdma->queue_irq[i];
-		}
 
 		ret = devm_request_irq(&pdev->dev,
 				       fsl_qdma->queue_irq[i],
diff --git a/drivers/dma/mediatek/mtk-uart-apdma.c b/drivers/dma/mediatek/mtk-uart-apdma.c
index 546995c20876..f40051d6aecb 100644
--- a/drivers/dma/mediatek/mtk-uart-apdma.c
+++ b/drivers/dma/mediatek/mtk-uart-apdma.c
@@ -547,10 +547,8 @@ static int mtk_uart_apdma_probe(struct platform_device *pdev)
 		vchan_init(&c->vc, &mtkd->ddev);
 
 		rc = platform_get_irq(pdev, i);
-		if (rc < 0) {
-			dev_err(&pdev->dev, "failed to get IRQ[%d]\n", i);
+		if (rc < 0)
 			goto err_no_dma;
-		}
 		c->irq = rc;
 	}
 
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
index ad30f3d2c7f6..43da8eeb18ef 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1237,11 +1237,8 @@ static int s3c24xx_dma_probe(struct platform_device *pdev)
 		phy->host = s3cdma;
 
 		phy->irq = platform_get_irq(pdev, i);
-		if (phy->irq < 0) {
-			dev_err(&pdev->dev, "failed to get irq %d, err %d\n",
-				i, phy->irq);
+		if (phy->irq < 0)
 			continue;
-		}
 
 		ret = devm_request_irq(&pdev->dev, phy->irq, s3c24xx_dma_irq,
 				       0, pdev->name, phy);
diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 9c41a4e42575..eb6f2312a6a2 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1744,10 +1744,8 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
 	/* Request the channel interrupt. */
 	sprintf(pdev_irqname, "ch%u", index);
 	rchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (rchan->irq < 0) {
-		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
+	if (rchan->irq < 0)
 		return -ENODEV;
-	}
 
 	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index 17063aaf51bc..b218a013c260 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -717,10 +717,8 @@ static int usb_dmac_chan_probe(struct usb_dmac *dmac,
 	/* Request the channel interrupt. */
 	sprintf(pdev_irqname, "ch%u", index);
 	uchan->irq = platform_get_irq_byname(pdev, pdev_irqname);
-	if (uchan->irq < 0) {
-		dev_err(dmac->dev, "no IRQ specified for channel %u\n", index);
+	if (uchan->irq < 0)
 		return -ENODEV;
-	}
 
 	irqname = devm_kasprintf(dmac->dev, GFP_KERNEL, "%s:%u",
 				 dev_name(dmac->dev), index);
diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index a3ee0f6bb664..67087dbe2f9f 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -771,10 +771,8 @@ static int st_fdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, fdev);
 
 	fdev->irq = platform_get_irq(pdev, 0);
-	if (fdev->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq resource\n");
+	if (fdev->irq < 0)
 		return -EINVAL;
-	}
 
 	ret = devm_request_irq(&pdev->dev, fdev->irq, st_fdma_irq_handler, 0,
 			       dev_name(&pdev->dev), fdev);
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32-dma.c
index ef4d109e7189..e4cbe38d1b83 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32-dma.c
@@ -1366,12 +1366,8 @@ static int stm32_dma_probe(struct platform_device *pdev)
 	for (i = 0; i < STM32_DMA_MAX_CHANNELS; i++) {
 		chan = &dmadev->chan[i];
 		ret = platform_get_irq(pdev, i);
-		if (ret < 0)  {
-			if (ret != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"No irq resource for chan %d\n", i);
+		if (ret < 0)
 			goto err_unregister;
-		}
 		chan->irq = ret;
 
 		ret = devm_request_irq(&pdev->dev, chan->irq,
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index d6e919d3936a..d492b6e19735 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1638,10 +1638,8 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	}
 
 	dmadev->irq = platform_get_irq(pdev, 0);
-	if (dmadev->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dmadev->irq < 0)
 		return dmadev->irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, dmadev->irq, stm32_mdma_irq_handler,
 			       0, dev_name(&pdev->dev), dmadev);
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index 1f80568b2613..e397a50058c8 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -1132,10 +1132,8 @@ static int sun4i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index ed5b68dcfe50..06cd7f867f7c 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -1251,10 +1251,8 @@ static int sun6i_dma_probe(struct platform_device *pdev)
 		return PTR_ERR(sdc->base);
 
 	sdc->irq = platform_get_irq(pdev, 0);
-	if (sdc->irq < 0) {
-		dev_err(&pdev->dev, "Cannot claim IRQ\n");
+	if (sdc->irq < 0)
 		return sdc->irq;
-	}
 
 	sdc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->clk)) {
diff --git a/drivers/dma/uniphier-mdmac.c b/drivers/dma/uniphier-mdmac.c
index ec65a7430dc4..fde54687856b 100644
--- a/drivers/dma/uniphier-mdmac.c
+++ b/drivers/dma/uniphier-mdmac.c
@@ -354,11 +354,8 @@ static int uniphier_mdmac_chan_init(struct platform_device *pdev,
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, chan_id);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ number for ch%d\n",
-			chan_id);
+	if (irq < 0)
 		return irq;
-	}
 
 	irq_name = devm_kasprintf(dev, GFP_KERNEL, "uniphier-mio-dmac-ch%d",
 				  chan_id);
diff --git a/drivers/dma/xgene-dma.c b/drivers/dma/xgene-dma.c
index 957c269ce1fd..cd60fa6d6750 100644
--- a/drivers/dma/xgene-dma.c
+++ b/drivers/dma/xgene-dma.c
@@ -1678,20 +1678,16 @@ static int xgene_dma_get_resources(struct platform_device *pdev,
 
 	/* Get DMA error interrupt */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "Failed to get Error IRQ\n");
+	if (irq <= 0)
 		return -ENXIO;
-	}
 
 	pdma->err_irq = irq;
 
 	/* Get DMA Rx ring descriptor interrupts for all DMA channels */
 	for (i = 1; i <= XGENE_DMA_MAX_CHANNEL; i++) {
 		irq = platform_get_irq(pdev, i);
-		if (irq <= 0) {
-			dev_err(&pdev->dev, "Failed to get Rx IRQ\n");
+		if (irq <= 0)
 			return -ENXIO;
-		}
 
 		pdma->chan[i - 1].rx_irq = irq;
 	}
diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index c2e693e34d43..5405bd727731 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -347,11 +347,8 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		edac_printk(KERN_ERR, EDAC_MC,
-			    "No irq %d in DT\n", irq);
+	if (irq < 0)
 		return -ENODEV;
-	}
 
 	/* Arria10 has a 2nd IRQ */
 	irq2 = platform_get_irq(pdev, 1);
@@ -2177,10 +2174,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 
 	edac->sb_irq = platform_get_irq(pdev, 0);
-	if (edac->sb_irq < 0) {
-		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
+	if (edac->sb_irq < 0)
 		return edac->sb_irq;
-	}
 
 	irq_set_chained_handler_and_data(edac->sb_irq,
 					 altr_edac_a10_irq_handler,
@@ -2212,10 +2207,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
-	if (edac->db_irq < 0) {
-		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
+	if (edac->db_irq < 0)
 		return edac->db_irq;
-	}
 	irq_set_chained_handler_and_data(edac->db_irq,
 					 altr_edac_a10_irq_handler, edac);
 #endif
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
index ee9b5f70bfa4..ad02dc6747a4 100644
--- a/drivers/extcon/extcon-adc-jack.c
+++ b/drivers/extcon/extcon-adc-jack.c
@@ -140,10 +140,8 @@ static int adc_jack_probe(struct platform_device *pdev)
 		return err;
 
 	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
+	if (data->irq < 0)
 		return -ENODEV;
-	}
 
 	err = request_any_context_irq(data->irq, adc_jack_irq_thread,
 			pdata->irq_flags, pdata->name, data);
diff --git a/drivers/firmware/tegra/bpmp-tegra210.c b/drivers/firmware/tegra/bpmp-tegra210.c
index ae15940a078e..890186abeac0 100644
--- a/drivers/firmware/tegra/bpmp-tegra210.c
+++ b/drivers/firmware/tegra/bpmp-tegra210.c
@@ -202,10 +202,8 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 	}
 
 	err = platform_get_irq_byname(pdev, "tx");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get TX IRQ: %d\n", err);
+	if (err < 0)
 		return err;
-	}
 
 	priv->tx_irq_data = irq_get_irq_data(err);
 	if (!priv->tx_irq_data) {
@@ -214,10 +212,8 @@ static int tegra210_bpmp_init(struct tegra_bpmp *bpmp)
 	}
 
 	err = platform_get_irq_byname(pdev, "rx");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get rx IRQ: %d\n", err);
+	if (err < 0)
 		return err;
-	}
 
 	err = devm_request_irq(&pdev->dev, err, rx_irq,
 			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), bpmp);
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 31ef38e38537..ee7765049607 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -578,10 +578,8 @@ static int zynq_fpga_probe(struct platform_device *pdev)
 	init_completion(&priv->dma_done);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(dev, "No IRQ available\n");
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	priv->clk = devm_clk_get(dev, "ref_clk");
 	if (IS_ERR(priv->clk)) {
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index af936dcca659..05e3f99ae59c 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -636,10 +636,8 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 
 	if (of_property_read_bool(np, "interrupt-controller")) {
 		priv->parent_irq = platform_get_irq(pdev, 0);
-		if (priv->parent_irq <= 0) {
-			dev_err(dev, "Couldn't get IRQ");
+		if (priv->parent_irq <= 0)
 			return -ENOENT;
-		}
 	} else {
 		priv->parent_irq = -ENOENT;
 	}
diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
index 7b9ac4a12c20..fe7a73f52329 100644
--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -584,10 +584,8 @@ static int sprd_eic_probe(struct platform_device *pdev)
 	sprd_eic->type = pdata->type;
 
 	sprd_eic->irq = platform_get_irq(pdev, 0);
-	if (sprd_eic->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get EIC interrupt.\n");
+	if (sprd_eic->irq < 0)
 		return sprd_eic->irq;
-	}
 
 	for (i = 0; i < SPRD_EIC_MAX_BANK; i++) {
 		/*
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
index b7d89e30131e..47d05e357e61 100644
--- a/drivers/gpio/gpio-max77620.c
+++ b/drivers/gpio/gpio-max77620.c
@@ -270,10 +270,8 @@ static int max77620_gpio_probe(struct platform_device *pdev)
 	int ret;
 
 	gpio_irq = platform_get_irq(pdev, 0);
-	if (gpio_irq <= 0) {
-		dev_err(&pdev->dev, "GPIO irq not available %d\n", gpio_irq);
+	if (gpio_irq <= 0)
 		return -ENODEV;
-	}
 
 	mgpio = devm_kzalloc(&pdev->dev, sizeof(*mgpio), GFP_KERNEL);
 	if (!mgpio)
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 24228cf79afc..05000cace9b2 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -305,10 +305,8 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	mutex_init(&pmic_eic->buslock);
 
 	pmic_eic->irq = platform_get_irq(pdev, 0);
-	if (pmic_eic->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get PMIC EIC interrupt.\n");
+	if (pmic_eic->irq < 0)
 		return pmic_eic->irq;
-	}
 
 	pmic_eic->map = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!pmic_eic->map)
diff --git a/drivers/gpio/gpio-sprd.c b/drivers/gpio/gpio-sprd.c
index f5c8b3a351d5..d7314d39ab65 100644
--- a/drivers/gpio/gpio-sprd.c
+++ b/drivers/gpio/gpio-sprd.c
@@ -226,10 +226,8 @@ static int sprd_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	sprd_gpio->irq = platform_get_irq(pdev, 0);
-	if (sprd_gpio->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get GPIO interrupt.\n");
+	if (sprd_gpio->irq < 0)
 		return sprd_gpio->irq;
-	}
 
 	sprd_gpio->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sprd_gpio->base))
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index bd1f3f775ce9..5e375186f90e 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -171,10 +171,8 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 		struct irq_chip_generic *gc;
 
 		ret = platform_get_irq(pdev, 0);
-		if (ret < 0) {
-			dev_err(dev, "No interrupt specified.\n");
+		if (ret < 0)
 			return ret;
-		}
 
 		tb10x_gpio->gc.to_irq	= tb10x_gpio_to_irq;
 		tb10x_gpio->irq		= ret;
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 0f59161a4701..8a01d3694b28 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -624,10 +624,8 @@ static int tegra_gpio_probe(struct platform_device *pdev)
 
 	for (i = 0; i < tgi->bank_count; i++) {
 		ret = platform_get_irq(pdev, i);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Missing IRQ resource: %d\n", ret);
+		if (ret < 0)
 			return ret;
-		}
 
 		bank = &tgi->bank_info[i];
 		bank->bank = i;
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
index f241b6c13dbe..86b0bd256c13 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -849,10 +849,8 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(gpio->base_addr);
 
 	gpio->irq = platform_get_irq(pdev, 0);
-	if (gpio->irq < 0) {
-		dev_err(&pdev->dev, "invalid IRQ\n");
+	if (gpio->irq < 0)
 		return gpio->irq;
-	}
 
 	/* configure the gpio chip */
 	chip = &gpio->chip;
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 5418a1a87b2c..373077549aa4 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1733,10 +1733,8 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 
 	/* Get Interrupt: */
 	gpu->irq = platform_get_irq(pdev, 0);
-	if (gpu->irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", gpu->irq);
+	if (gpu->irq < 0)
 		return gpu->irq;
-	}
 
 	err = devm_request_irq(&pdev->dev, gpu->irq, irq_handler, 0,
 			       dev_name(gpu->dev), gpu);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 6926cee91b36..6b679c59c84d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1789,10 +1789,8 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	}
 
 	dsi->irq = platform_get_irq(pdev, 0);
-	if (dsi->irq < 0) {
-		dev_err(dev, "failed to request dsi irq resource\n");
+	if (dsi->irq < 0)
 		return dsi->irq;
-	}
 
 	irq_set_status_flags(dsi->irq, IRQ_NOAUTOEN);
 	ret = devm_request_threaded_irq(dev, dsi->irq, NULL,
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
index 8ebad2740ad5..a355f444210a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -290,10 +290,8 @@ static int rotator_probe(struct platform_device *pdev)
 		return PTR_ERR(rot->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, rotator_irq_handler, 0, dev_name(dev),
 			       rot);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 9af096479e1c..cef771d5956c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -499,10 +499,8 @@ static int scaler_probe(struct platform_device *pdev)
 		return PTR_ERR(scaler->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,	scaler_irq_handler,
 					IRQF_ONESHOT, "drm_scaler", scaler);
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index e81daaaa5965..f56e9c44e8c9 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -269,10 +269,8 @@ static int fsl_dcu_drm_probe(struct platform_device *pdev)
 	}
 
 	fsl_dev->irq = platform_get_irq(pdev, 0);
-	if (fsl_dev->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (fsl_dev->irq < 0)
 		return fsl_dev->irq;
-	}
 
 	fsl_dev->regmap = devm_regmap_init_mmio(dev, base,
 			&fsl_dcu_regmap_config);
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index e725af8a0025..8b768e0cf167 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -594,10 +594,8 @@ static int imx_tve_bind(struct device *dev, struct device *master, void *data)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					imx_tve_irq_handler, IRQF_ONESHOT,
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index e9f9e9fb9b17..faf8ac8ca1ef 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -630,10 +630,8 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get platform irq");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (soc_info->needs_dev_clk) {
 		priv->lcd_clk = devm_clk_get(dev, "lcd");
diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index cb29b649fcdb..332a4dfbdde7 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -208,10 +208,8 @@ static int mtk_cec_probe(struct platform_device *pdev)
 	}
 
 	cec->irq = platform_get_irq(pdev, 0);
-	if (cec->irq < 0) {
-		dev_err(dev, "Failed to get cec irq: %d\n", cec->irq);
+	if (cec->irq < 0)
 		return cec->irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, cec->irq, NULL,
 					mtk_cec_htplg_isr_thread,
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index bacd989cc9aa..87b848ca5f6c 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -717,10 +717,8 @@ static int mtk_dpi_probe(struct platform_device *pdev)
 	}
 
 	dpi->irq = platform_get_irq(pdev, 0);
-	if (dpi->irq <= 0) {
-		dev_err(dev, "Failed to get irq: %d\n", dpi->irq);
+	if (dpi->irq <= 0)
 		return -EINVAL;
-	}
 
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
 					  NULL, &dpi->bridge);
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index b91c4616644a..7a3aad0dc8a3 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -1155,10 +1155,8 @@ static int mtk_dsi_probe(struct platform_device *pdev)
 	}
 
 	irq_num = platform_get_irq(pdev, 0);
-	if (irq_num < 0) {
-		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
+	if (irq_num < 0)
 		return -EPROBE_DEFER;
-	}
 
 	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
 	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index df3f9ddd2234..e1099dab45b4 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -894,10 +894,8 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 		return PTR_ERR(dw_plat_data->regm);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get hdmi top irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, dw_hdmi_top_irq,
 					dw_hdmi_top_thread_irq, IRQF_SHARED,
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index 252f5ebb1acc..9feabccd34d6 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -822,10 +822,8 @@ static int omap_dmm_probe(struct platform_device *dev)
 	}
 
 	omap_dmm->irq = platform_get_irq(dev, 0);
-	if (omap_dmm->irq < 0) {
-		dev_err(&dev->dev, "failed to get IRQ resource\n");
+	if (omap_dmm->irq < 0)
 		goto fail;
-	}
 
 	omap_dmm->dev = &dev->dev;
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 64c43ee6bd92..7c4cb3f5d444 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -783,10 +783,8 @@ static int sun4i_tcon_init_irq(struct device *dev,
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Couldn't retrieve the TCON interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, sun4i_tcon_handler, 0,
 			       dev_name(dev), tcon);
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 4a75d149e368..e00bee26d29b 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -2469,10 +2469,8 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->regs);
 
 	dc->irq = platform_get_irq(pdev, 0);
-	if (dc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dc->irq < 0)
 		return -ENXIO;
-	}
 
 	err = tegra_dc_rgb_probe(dc);
 	if (err < 0 && err != -ENODEV) {
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index 2d94da225e51..edf5cfa9fb74 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -446,10 +446,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 		return PTR_ERR(dpaux->regs);
 
 	dpaux->irq = platform_get_irq(pdev, 0);
-	if (dpaux->irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (dpaux->irq < 0)
 		return -ENXIO;
-	}
 
 	if (!pdev->dev.pm_domain) {
 		dpaux->rst = devm_reset_control_get(&pdev->dev, "dpaux");
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 4ffe3794e6d3..651400485384 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3323,10 +3323,8 @@ static int tegra_sor_probe(struct platform_device *pdev)
 	}
 
 	err = platform_get_irq(pdev, 0);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", err);
+	if (err < 0)
 		goto remove;
-	}
 
 	sor->irq = err;
 
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index 5a3f797240d4..1fa55dc1a109 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -214,10 +214,8 @@ static int host1x_probe(struct platform_device *pdev)
 	}
 
 	syncpt_irq = platform_get_irq(pdev, 0);
-	if (syncpt_irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", syncpt_irq);
+	if (syncpt_irq < 0)
 		return syncpt_irq;
-	}
 
 	mutex_init(&host->devices_lock);
 	INIT_LIST_HEAD(&host->devices);
diff --git a/drivers/hsi/controllers/omap_ssi_core.c b/drivers/hsi/controllers/omap_ssi_core.c
index 0cba567ee2d7..4bc4a201f0f6 100644
--- a/drivers/hsi/controllers/omap_ssi_core.c
+++ b/drivers/hsi/controllers/omap_ssi_core.c
@@ -370,10 +370,8 @@ static int ssi_add_controller(struct hsi_controller *ssi,
 	if (err < 0)
 		goto out_err;
 	err = platform_get_irq_byname(pd, "gdd_mpu");
-	if (err < 0) {
-		dev_err(&pd->dev, "GDD IRQ resource missing\n");
+	if (err < 0)
 		goto out_err;
-	}
 	omap_ssi->gdd_irq = err;
 	tasklet_init(&omap_ssi->gdd_tasklet, ssi_gdd_tasklet,
 							(unsigned long)ssi);
diff --git a/drivers/hsi/controllers/omap_ssi_port.c b/drivers/hsi/controllers/omap_ssi_port.c
index 2cd93119515f..a0cb5be246e1 100644
--- a/drivers/hsi/controllers/omap_ssi_port.c
+++ b/drivers/hsi/controllers/omap_ssi_port.c
@@ -1038,10 +1038,8 @@ static int ssi_port_irq(struct hsi_port *port, struct platform_device *pd)
 	int err;
 
 	err = platform_get_irq(pd, 0);
-	if (err < 0) {
-		dev_err(&port->device, "Port IRQ resource missing\n");
+	if (err < 0)
 		return err;
-	}
 	omap_port->irq = err;
 	err = devm_request_threaded_irq(&port->device, omap_port->irq, NULL,
 				ssi_pio_thread, IRQF_ONESHOT, "SSI PORT", port);
diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index bec5befd1d8b..47bed41b55a1 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -93,11 +93,8 @@ static int jz4740_hwmon_probe(struct platform_device *pdev)
 	hwmon->cell = mfd_get_cell(pdev);
 
 	hwmon->irq = platform_get_irq(pdev, 0);
-	if (hwmon->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
-			hwmon->irq);
+	if (hwmon->irq < 0)
 		return hwmon->irq;
-	}
 
 	hwmon->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(hwmon->base))
diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index 09aaefa6fdb8..11a28609da3c 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -967,10 +967,8 @@ static int npcm7xx_pwm_fan_probe(struct platform_device *pdev)
 		spin_lock_init(&data->fan_lock[i]);
 
 		data->fan_irq[i] = platform_get_irq(pdev, i);
-		if (data->fan_irq[i] < 0) {
-			dev_err(dev, "get IRQ fan%d failed\n", i);
+		if (data->fan_irq[i] < 0)
 			return data->fan_irq[i];
-		}
 
 		sprintf(name, "NPCM7XX-FAN-MD%d", i);
 		ret = devm_request_irq(dev, data->fan_irq[i], npcm7xx_fan_isr,
diff --git a/drivers/i2c/busses/i2c-altera.c b/drivers/i2c/busses/i2c-altera.c
index 5255d3755411..b5cc7e81e943 100644
--- a/drivers/i2c/busses/i2c-altera.c
+++ b/drivers/i2c/busses/i2c-altera.c
@@ -396,10 +396,8 @@ static int altr_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(idev->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "missing interrupt resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	idev->i2c_clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(idev->i2c_clk)) {
diff --git a/drivers/i2c/busses/i2c-axxia.c b/drivers/i2c/busses/i2c-axxia.c
index ff3142b15cab..1ccbdd5e3360 100644
--- a/drivers/i2c/busses/i2c-axxia.c
+++ b/drivers/i2c/busses/i2c-axxia.c
@@ -612,10 +612,8 @@ static int axxia_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "missing interrupt resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	idev->i2c_clk = devm_clk_get(&pdev->dev, "i2c");
 	if (IS_ERR(idev->i2c_clk)) {
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
index 66af44bfa67d..63e31a580f80 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -269,10 +269,8 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 	int ret, reg, irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Error missing irq resource\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	adap = devm_kzalloc(&pdev->dev, sizeof(*adap), GFP_KERNEL);
 	if (!adap)
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
index 4df1434b3597..1830b19587be 100644
--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -417,10 +417,8 @@ static int hix5hd2_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "cannot find HS-I2C IRQ\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(priv->clk)) {
diff --git a/drivers/i2c/busses/i2c-img-scb.c b/drivers/i2c/busses/i2c-img-scb.c
index 20a4fbc53007..5a753e7c9765 100644
--- a/drivers/i2c/busses/i2c-img-scb.c
+++ b/drivers/i2c/busses/i2c-img-scb.c
@@ -1344,10 +1344,8 @@ static int img_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "can't get irq number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	i2c->sys_clk = devm_clk_get(&pdev->dev, "sys");
 	if (IS_ERR(i2c->sys_clk)) {
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index dc00fabc919a..f962c92d3daf 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -559,10 +559,8 @@ static int lpi2c_imx_probe(struct platform_device *pdev)
 		return PTR_ERR(lpi2c_imx->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "can't get irq number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	lpi2c_imx->adapter.owner	= THIS_MODULE;
 	lpi2c_imx->adapter.algo		= &lpi2c_imx_algo;
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index b1b8b938d7f4..1c31f35c5726 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1062,10 +1062,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 	dev_dbg(&pdev->dev, "<%s>\n", __func__);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "can't get irq number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/i2c/busses/i2c-lpc2k.c b/drivers/i2c/busses/i2c-lpc2k.c
index deea18b14add..9cf6957a3599 100644
--- a/drivers/i2c/busses/i2c-lpc2k.c
+++ b/drivers/i2c/busses/i2c-lpc2k.c
@@ -362,10 +362,8 @@ static int i2c_lpc2k_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->base);
 
 	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
-		dev_err(&pdev->dev, "can't get interrupt resource\n");
+	if (i2c->irq < 0)
 		return i2c->irq;
-	}
 
 	init_waitqueue_head(&i2c->wait);
 
diff --git a/drivers/i2c/busses/i2c-meson.c b/drivers/i2c/busses/i2c-meson.c
index 1e2647f9a2a7..46972f5ceb9a 100644
--- a/drivers/i2c/busses/i2c-meson.c
+++ b/drivers/i2c/busses/i2c-meson.c
@@ -395,10 +395,8 @@ static int meson_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "can't find IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, meson_i2c_irq, 0, NULL, i2c);
 	if (ret < 0) {
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 2dfea357b131..d2bba6d3e6bd 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1366,10 +1366,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	u16 minor, major;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	omap = devm_kzalloc(&pdev->dev, sizeof(struct omap_i2c_dev), GFP_KERNEL);
 	if (!omap)
diff --git a/drivers/i2c/busses/i2c-owl.c b/drivers/i2c/busses/i2c-owl.c
index b6b5a495118b..b35a139e5a97 100644
--- a/drivers/i2c/busses/i2c-owl.c
+++ b/drivers/i2c/busses/i2c-owl.c
@@ -412,10 +412,8 @@ static int owl_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_dev->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (of_property_read_u32(dev->of_node, "clock-frequency",
 				 &i2c_dev->bus_freq))
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
index 2c3c3d6935c0..ed81e9372a82 100644
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1218,10 +1218,8 @@ static int i2c_pxa_probe(struct platform_device *dev)
 		return PTR_ERR(i2c->reg_base);
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	/* Default adapter num to device id; i2c_pxa_probe_dt can override. */
 	i2c->adap.nr = dev->id;
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index a89bfce5388e..75e8009f377b 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -529,10 +529,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		ACPI_COMPANION_SET(&gi2c->adap.dev, ACPI_COMPANION(&pdev->dev));
 
 	gi2c->irq = platform_get_irq(pdev, 0);
-	if (gi2c->irq < 0) {
-		dev_err(&pdev->dev, "IRQ error for i2c-geni\n");
+	if (gi2c->irq < 0)
 		return gi2c->irq;
-	}
 
 	ret = geni_i2c_clk_map_idx(gi2c);
 	if (ret) {
diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index e09cd0775ae9..8f670d5d369f 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -1768,10 +1768,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(qup->base);
 
 	qup->irq = platform_get_irq(pdev, 0);
-	if (qup->irq < 0) {
-		dev_err(qup->dev, "No IRQ defined\n");
+	if (qup->irq < 0)
 		return qup->irq;
-	}
 
 	if (has_acpi_companion(qup->dev)) {
 		ret = device_property_read_u32(qup->dev,
diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index 1a33007b03e9..87f57a47201c 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -1262,10 +1262,8 @@ static int rk3x_i2c_probe(struct platform_device *pdev)
 
 	/* IRQ setup */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find rk3x IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, rk3x_i2c_irq,
 			       0, dev_name(&pdev->dev), i2c);
diff --git a/drivers/i2c/busses/i2c-sprd.c b/drivers/i2c/busses/i2c-sprd.c
index 961123529678..da89b768452a 100644
--- a/drivers/i2c/busses/i2c-sprd.c
+++ b/drivers/i2c/busses/i2c-sprd.c
@@ -493,10 +493,8 @@ static int sprd_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_dev->base);
 
 	i2c_dev->irq = platform_get_irq(pdev, 0);
-	if (i2c_dev->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
+	if (i2c_dev->irq < 0)
 		return i2c_dev->irq;
-	}
 
 	i2c_set_adapdata(&i2c_dev->adap, i2c_dev);
 	init_completion(&i2c_dev->complete);
diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 266d1c269b83..69207790af98 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -1839,20 +1839,12 @@ static int stm32f7_i2c_probe(struct platform_device *pdev)
 	phy_addr = (dma_addr_t)res->start;
 
 	irq_event = platform_get_irq(pdev, 0);
-	if (irq_event <= 0) {
-		if (irq_event != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get IRQ event: %d\n",
-				irq_event);
+	if (irq_event <= 0)
 		return irq_event ? : -ENOENT;
-	}
 
 	irq_error = platform_get_irq(pdev, 1);
-	if (irq_error <= 0) {
-		if (irq_error != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Failed to get IRQ error: %d\n",
-				irq_error);
+	if (irq_error <= 0)
 		return irq_error ? : -ENOENT;
-	}
 
 	i2c_dev->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c_dev->clk)) {
diff --git a/drivers/i2c/busses/i2c-sun6i-p2wi.c b/drivers/i2c/busses/i2c-sun6i-p2wi.c
index 7c07ce116e38..49ddd3a6d2db 100644
--- a/drivers/i2c/busses/i2c-sun6i-p2wi.c
+++ b/drivers/i2c/busses/i2c-sun6i-p2wi.c
@@ -238,10 +238,8 @@ static int p2wi_probe(struct platform_device *pdev)
 
 	strlcpy(p2wi->adapter.name, pdev->name, sizeof(p2wi->adapter.name));
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	p2wi->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(p2wi->clk)) {
diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index f724c8e6b360..8e00106a4388 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -580,10 +580,8 @@ static int synquacer_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c->base);
 
 	i2c->irq = platform_get_irq(pdev, 0);
-	if (i2c->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource found\n");
+	if (i2c->irq < 0)
 		return -ENODEV;
-	}
 
 	ret = devm_request_irq(&pdev->dev, i2c->irq, synquacer_i2c_isr,
 			       0, dev_name(&pdev->dev), i2c);
diff --git a/drivers/i2c/busses/i2c-uniphier-f.c b/drivers/i2c/busses/i2c-uniphier-f.c
index 7acca2599f04..e3ca4a8dfc8e 100644
--- a/drivers/i2c/busses/i2c-uniphier-f.c
+++ b/drivers/i2c/busses/i2c-uniphier-f.c
@@ -553,10 +553,8 @@ static int uniphier_fi2c_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->membase);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed))
 		bus_speed = UNIPHIER_FI2C_DEFAULT_SPEED;
diff --git a/drivers/i2c/busses/i2c-uniphier.c b/drivers/i2c/busses/i2c-uniphier.c
index 0173840c32af..548b60b9395b 100644
--- a/drivers/i2c/busses/i2c-uniphier.c
+++ b/drivers/i2c/busses/i2c-uniphier.c
@@ -341,10 +341,8 @@ static int uniphier_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->membase);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed))
 		bus_speed = UNIPHIER_I2C_DEFAULT_SPEED;
diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
index 8a873975cf12..d633aac876f5 100644
--- a/drivers/i2c/busses/i2c-xlp9xx.c
+++ b/drivers/i2c/busses/i2c-xlp9xx.c
@@ -517,10 +517,8 @@ static int xlp9xx_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq <= 0) {
-		dev_err(&pdev->dev, "invalid irq!\n");
-		return priv->irq;
-	}
+	if (priv->irq <= 0)
+		return priv->irq ? : -ENXIO;
 	/* SMBAlert irq */
 	priv->alert_data.irq = platform_get_irq(pdev, 1);
 	if (priv->alert_data.irq <= 0)
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index 1b08028facde..f732b3ac7878 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -53,10 +53,8 @@ static int ad7606_par_probe(struct platform_device *pdev)
 	int irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	addr = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 32f1c4a33b20..abe99856c823 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -1179,10 +1179,8 @@ static int at91_adc_probe(struct platform_device *pdev)
 	idev->info = &at91_adc_info;
 
 	st->irq = platform_get_irq(pdev, 0);
-	if (st->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ ID is designated\n");
+	if (st->irq < 0)
 		return -ENODEV;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 31d51bcc5f2c..adc9cf7a075d 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -225,10 +225,8 @@ static int axp288_adc_probe(struct platform_device *pdev)
 
 	info = iio_priv(indio_dev);
 	info->irq = platform_get_irq(pdev, 0);
-	if (info->irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (info->irq < 0)
 		return info->irq;
-	}
 	platform_set_drvdata(pdev, indio_dev);
 	info->regmap = axp20x->regmap;
 	/*
diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index c46c0aa15376..646ebdc0a8b4 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -540,11 +540,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	}
 
 	adc_priv->irqno = platform_get_irq(pdev, 0);
-	if (adc_priv->irqno <= 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
-		ret = -ENODEV;
-		return ret;
-	}
+	if (adc_priv->irqno <= 0)
+		return -ENODEV;
 
 	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
 				IPROC_ADC_AUXIN_SCAN_ENA, 0);
diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
index 354433996101..ae8bcc32f63d 100644
--- a/drivers/iio/adc/da9150-gpadc.c
+++ b/drivers/iio/adc/da9150-gpadc.c
@@ -337,10 +337,8 @@ static int da9150_gpadc_probe(struct platform_device *pdev)
 	init_completion(&gpadc->complete);
 
 	irq = platform_get_irq_byname(pdev, "GPADC");
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL, da9150_gpadc_irq,
 					IRQF_ONESHOT, "GPADC", gpadc);
diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
index 2f2b563c1162..28f3d6758eb5 100644
--- a/drivers/iio/adc/envelope-detector.c
+++ b/drivers/iio/adc/envelope-detector.c
@@ -357,11 +357,8 @@ static int envelope_detector_probe(struct platform_device *pdev)
 	}
 
 	env->comp_irq = platform_get_irq_byname(pdev, "comp");
-	if (env->comp_irq < 0) {
-		if (env->comp_irq != -EPROBE_DEFER)
-			dev_err(dev, "failed to get compare interrupt\n");
+	if (env->comp_irq < 0)
 		return env->comp_irq;
-	}
 
 	ret = devm_request_irq(dev, env->comp_irq, envelope_detector_comp_isr,
 			       0, "envelope-detector", env);
diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index d4c3ece21679..42a3ced11fbd 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -805,10 +805,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (irq < 0)
 		return irq;
-	}
 	info->irq = irq;
 
 	irq = platform_get_irq(pdev, 1);
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
index 26a7bbe4d534..2a2fbf788e95 100644
--- a/drivers/iio/adc/imx7d_adc.c
+++ b/drivers/iio/adc/imx7d_adc.c
@@ -492,10 +492,8 @@ static int imx7d_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(info->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "No irq resource?\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	info->clk = devm_clk_get(dev, "adc");
 	if (IS_ERR(info->clk)) {
diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
index a6ee1c3a9064..b896f7ff4572 100644
--- a/drivers/iio/adc/lpc32xx_adc.c
+++ b/drivers/iio/adc/lpc32xx_adc.c
@@ -172,10 +172,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "failed getting interrupt resource\n");
+	if (irq <= 0)
 		return -ENXIO;
-	}
 
 	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
 				  LPC32XXAD_NAME, st);
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
index dd8299831e09..582ba047c4a6 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -244,10 +244,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	init_completion(&info->completion);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
 			       0, dev_name(&pdev->dev), info);
diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
index f7f7a18904b4..bb616aa01f4f 100644
--- a/drivers/iio/adc/sc27xx_adc.c
+++ b/drivers/iio/adc/sc27xx_adc.c
@@ -528,10 +528,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
 	}
 
 	sc27xx_data->irq = platform_get_irq(pdev, 0);
-	if (sc27xx_data->irq < 0) {
-		dev_err(&pdev->dev, "failed to get ADC irq number\n");
+	if (sc27xx_data->irq < 0)
 		return sc27xx_data->irq;
-	}
 
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret < 0) {
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
index 205e1699f954..6a7dd08b1e0b 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1919,10 +1919,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	}
 
 	adc->irq = platform_get_irq(pdev, 0);
-	if (adc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (adc->irq < 0)
 		return adc->irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, adc->irq, stm32_adc_isr,
 			       0, pdev->name, adc);
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index ee1e0569d0e1..e493242c266e 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1601,11 +1601,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
 	 * So IRQ associated to filter instance 0 is dedicated to the Filter 0.
 	 */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
 			       0, pdev->name, adc);
diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index f13c6248a662..176e1cb4abb1 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -460,10 +460,8 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
 	atomic_set(atomic, 1);
 
 	ret = platform_get_irq_byname(pdev, name);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = regmap_irq_get_virq(mfd_dev->regmap_irqc, ret);
 	if (ret < 0) {
diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index 2fa6ec83bb13..f24148bd15de 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -905,10 +905,8 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 				twl6030_gpadc_irq_handler,
diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
index 41d3621c4787..98b30475bbc6 100644
--- a/drivers/iio/adc/vf610_adc.c
+++ b/drivers/iio/adc/vf610_adc.c
@@ -821,10 +821,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
 		return PTR_ERR(info->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(info->dev, irq,
 				vf610_adc_isr, 0,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
index 81e6dedb1e02..7541177eb648 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
@@ -4637,10 +4637,8 @@ static int hns_roce_get_cfg(struct hns_roce_dev *hr_dev)
 	/* fetch the interrupt numbers */
 	for (i = 0; i < HNS_ROCE_V1_MAX_IRQ_NUM; i++) {
 		hr_dev->irq[i] = platform_get_irq(hr_dev->pdev, i);
-		if (hr_dev->irq[i] <= 0) {
-			dev_err(dev, "platform get of irq[=%d] failed!\n", i);
+		if (hr_dev->irq[i] <= 0)
 			return -EINVAL;
-		}
 	}
 
 	return 0;
diff --git a/drivers/input/keyboard/bcm-keypad.c b/drivers/input/keyboard/bcm-keypad.c
index e1cf63ee148f..2b771c3a5578 100644
--- a/drivers/input/keyboard/bcm-keypad.c
+++ b/drivers/input/keyboard/bcm-keypad.c
@@ -413,10 +413,8 @@ static int bcm_kp_probe(struct platform_device *pdev)
 	bcm_kp_stop(kp);
 
 	kp->irq = platform_get_irq(pdev, 0);
-	if (kp->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ specified\n");
+	if (kp->irq < 0)
 		return -EINVAL;
-	}
 
 	error = devm_request_threaded_irq(&pdev->dev, kp->irq,
 					  NULL, bcm_kp_isr_thread,
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
index 97500a2de2d5..5a46d113e909 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -430,10 +430,8 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq defined in platform data\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	input_dev = devm_input_allocate_device(&pdev->dev);
 	if (!input_dev) {
diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index a34e3271b0c9..348af2aeb5de 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -172,10 +172,8 @@ static int lpc32xx_kscan_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get platform irq\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	kscandat = devm_kzalloc(&pdev->dev, sizeof(*kscandat),
 				GFP_KERNEL);
diff --git a/drivers/input/keyboard/nomadik-ske-keypad.c b/drivers/input/keyboard/nomadik-ske-keypad.c
index fa265fdce2c4..608446e14614 100644
--- a/drivers/input/keyboard/nomadik-ske-keypad.c
+++ b/drivers/input/keyboard/nomadik-ske-keypad.c
@@ -235,10 +235,8 @@ static int __init ske_keypad_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
diff --git a/drivers/input/keyboard/nspire-keypad.c b/drivers/input/keyboard/nspire-keypad.c
index 57eac91ecd76..63d5e488137d 100644
--- a/drivers/input/keyboard/nspire-keypad.c
+++ b/drivers/input/keyboard/nspire-keypad.c
@@ -165,10 +165,8 @@ static int nspire_keypad_probe(struct platform_device *pdev)
 	int error;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	keypad = devm_kzalloc(&pdev->dev, sizeof(struct nspire_keypad),
 			      GFP_KERNEL);
diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index 159346cb4060..b0ea387414c1 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -49,10 +49,8 @@ static int opencores_kbd_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "missing board IRQ resource\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	opencores_kbd = devm_kzalloc(&pdev->dev, sizeof(*opencores_kbd),
 				     GFP_KERNEL);
diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index d529768a1d06..91d5811d6f0e 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -544,16 +544,12 @@ static int pmic8xxx_kp_probe(struct platform_device *pdev)
 	}
 
 	kp->key_sense_irq = platform_get_irq(pdev, 0);
-	if (kp->key_sense_irq < 0) {
-		dev_err(&pdev->dev, "unable to get keypad sense irq\n");
+	if (kp->key_sense_irq < 0)
 		return kp->key_sense_irq;
-	}
 
 	kp->key_stuck_irq = platform_get_irq(pdev, 1);
-	if (kp->key_stuck_irq < 0) {
-		dev_err(&pdev->dev, "unable to get keypad stuck irq\n");
+	if (kp->key_stuck_irq < 0)
 		return kp->key_stuck_irq;
-	}
 
 	kp->input->name = "PMIC8XXX keypad";
 	kp->input->phys = "pmic8xxx_keypad/input0";
diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 39023664d2f2..7e65708b25a4 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -727,10 +727,8 @@ static int pxa27x_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res == NULL) {
diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index 585e7765cbf0..f7414091d94e 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -89,10 +89,8 @@ static int pxa930_rotary_probe(struct platform_device *pdev)
 	int err;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for rotary controller\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index 08ba41a81f14..27ad73f43451 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -181,10 +181,8 @@ static int sh_keysc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		goto err0;
-	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (priv == NULL) {
diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 5342d8d45f81..e76b7a400a1c 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -118,10 +118,8 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	pdata->wakeup = of_property_read_bool(np, "wakeup-source");
 
 	pdata->irq = platform_get_irq(pdev, 0);
-	if (pdata->irq < 0) {
-		dev_err(&pdev->dev, "no irq defined in platform data\n");
+	if (pdata->irq < 0)
 		return -EINVAL;
-	}
 
 	regmap_update_bits(pdata->snvs, SNVS_LPCR_REG, SNVS_LPCR_DEP_EN, SNVS_LPCR_DEP_EN);
 
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 7d25fa338ab4..9b8d78f87253 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -191,10 +191,8 @@ static int spear_kbd_probe(struct platform_device *pdev)
 	int error;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "not able to get irq for the device\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	kbd = devm_kzalloc(&pdev->dev, sizeof(*kbd), GFP_KERNEL);
 	if (!kbd) {
diff --git a/drivers/input/keyboard/st-keyscan.c b/drivers/input/keyboard/st-keyscan.c
index f097128b93fe..27562cd67fb6 100644
--- a/drivers/input/keyboard/st-keyscan.c
+++ b/drivers/input/keyboard/st-keyscan.c
@@ -187,10 +187,8 @@ static int keyscan_probe(struct platform_device *pdev)
 	keyscan_stop(keypad_data);
 
 	keypad_data->irq = platform_get_irq(pdev, 0);
-	if (keypad_data->irq < 0) {
-		dev_err(&pdev->dev, "no IRQ specified\n");
+	if (keypad_data->irq < 0)
 		return -EINVAL;
-	}
 
 	error = devm_request_irq(&pdev->dev, keypad_data->irq, keyscan_isr, 0,
 				 pdev->name, keypad_data);
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index a37a7a9e9171..d34d6947960f 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -631,10 +631,8 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	kbc->irq = platform_get_irq(pdev, 0);
-	if (kbc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get keyboard IRQ\n");
+	if (kbc->irq < 0)
 		return -ENXIO;
-	}
 
 	kbc->idev = devm_input_allocate_device(&pdev->dev);
 	if (!kbc->idev) {
diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index c88d05d6108a..2503f44dc335 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -132,10 +132,8 @@ static int w90p910_keypad_probe(struct platform_device *pdev)
 	keymap_data = pdata->keymap_data;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get keypad irq\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	keypad = kzalloc(sizeof(struct w90p910_keypad), GFP_KERNEL);
 	input_dev = input_allocate_device();
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
index cc87443aa2ee..685995cad73f 100644
--- a/drivers/input/misc/88pm860x_onkey.c
+++ b/drivers/input/misc/88pm860x_onkey.c
@@ -64,10 +64,8 @@ static int pm860x_onkey_probe(struct platform_device *pdev)
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	info = devm_kzalloc(&pdev->dev, sizeof(struct pm860x_onkey_info),
 			    GFP_KERNEL);
diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 12b18a8db315..ea3b8292acdd 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -55,16 +55,12 @@ static int ab8500_ponkey_probe(struct platform_device *pdev)
 	int error;
 
 	irq_dbf = platform_get_irq_byname(pdev, "ONKEY_DBF");
-	if (irq_dbf < 0) {
-		dev_err(&pdev->dev, "No IRQ for ONKEY_DBF, error=%d\n", irq_dbf);
+	if (irq_dbf < 0)
 		return irq_dbf;
-	}
 
 	irq_dbr = platform_get_irq_byname(pdev, "ONKEY_DBR");
-	if (irq_dbr < 0) {
-		dev_err(&pdev->dev, "No IRQ for ONKEY_DBR, error=%d\n", irq_dbr);
+	if (irq_dbr < 0)
 		return irq_dbr;
-	}
 
 	ponkey = devm_kzalloc(&pdev->dev, sizeof(struct ab8500_ponkey),
 			      GFP_KERNEL);
diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index debeeaeb8812..bb6462ee6abe 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -232,20 +232,14 @@ static int axp20x_pek_probe_input_device(struct axp20x_pek *axp20x_pek,
 	int error;
 
 	axp20x_pek->irq_dbr = platform_get_irq_byname(pdev, "PEK_DBR");
-	if (axp20x_pek->irq_dbr < 0) {
-		dev_err(&pdev->dev, "No IRQ for PEK_DBR, error=%d\n",
-				axp20x_pek->irq_dbr);
+	if (axp20x_pek->irq_dbr < 0)
 		return axp20x_pek->irq_dbr;
-	}
 	axp20x_pek->irq_dbr = regmap_irq_get_virq(axp20x->regmap_irqc,
 						  axp20x_pek->irq_dbr);
 
 	axp20x_pek->irq_dbf = platform_get_irq_byname(pdev, "PEK_DBF");
-	if (axp20x_pek->irq_dbf < 0) {
-		dev_err(&pdev->dev, "No IRQ for PEK_DBF, error=%d\n",
-				axp20x_pek->irq_dbf);
+	if (axp20x_pek->irq_dbf < 0)
 		return axp20x_pek->irq_dbf;
-	}
 	axp20x_pek->irq_dbf = regmap_irq_get_virq(axp20x->regmap_irqc,
 						  axp20x_pek->irq_dbf);
 
diff --git a/drivers/input/misc/da9055_onkey.c b/drivers/input/misc/da9055_onkey.c
index a4ff4782e605..7a0d3a1d503c 100644
--- a/drivers/input/misc/da9055_onkey.c
+++ b/drivers/input/misc/da9055_onkey.c
@@ -76,11 +76,8 @@ static int da9055_onkey_probe(struct platform_device *pdev)
 	int irq, err;
 
 	irq = platform_get_irq_byname(pdev, "ONKEY");
-	if (irq < 0) {
-		dev_err(&pdev->dev,
-			"Failed to get an IRQ for input device, %d\n", irq);
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	onkey = devm_kzalloc(&pdev->dev, sizeof(*onkey), GFP_KERNEL);
 	if (!onkey) {
diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
index fd355cf59397..dace8577fa43 100644
--- a/drivers/input/misc/da9063_onkey.c
+++ b/drivers/input/misc/da9063_onkey.c
@@ -248,11 +248,8 @@ static int da9063_onkey_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_byname(pdev, "ONKEY");
-	if (irq < 0) {
-		error = irq;
-		dev_err(&pdev->dev, "Failed to get platform IRQ: %d\n", error);
-		return error;
-	}
+	if (irq < 0)
+		return irq;
 
 	error = devm_request_threaded_irq(&pdev->dev, irq,
 					  NULL, da9063_onkey_irq_handler,
diff --git a/drivers/input/misc/e3x0-button.c b/drivers/input/misc/e3x0-button.c
index 4d7217f43888..e2fde6e1553f 100644
--- a/drivers/input/misc/e3x0-button.c
+++ b/drivers/input/misc/e3x0-button.c
@@ -65,18 +65,12 @@ static int e3x0_button_probe(struct platform_device *pdev)
 	int error;
 
 	irq_press = platform_get_irq_byname(pdev, "press");
-	if (irq_press < 0) {
-		dev_err(&pdev->dev, "No IRQ for 'press', error=%d\n",
-			irq_press);
+	if (irq_press < 0)
 		return irq_press;
-	}
 
 	irq_release = platform_get_irq_byname(pdev, "release");
-	if (irq_release < 0) {
-		dev_err(&pdev->dev, "No IRQ for 'release', error=%d\n",
-			irq_release);
+	if (irq_release < 0)
 		return irq_release;
-	}
 
 	input = devm_input_allocate_device(&pdev->dev);
 	if (!input)
diff --git a/drivers/input/misc/hisi_powerkey.c b/drivers/input/misc/hisi_powerkey.c
index dee6245f38d7..d3c293a95d32 100644
--- a/drivers/input/misc/hisi_powerkey.c
+++ b/drivers/input/misc/hisi_powerkey.c
@@ -90,12 +90,8 @@ static int hi65xx_powerkey_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(hi65xx_irq_info); i++) {
 
 		irq = platform_get_irq_byname(pdev, hi65xx_irq_info[i].name);
-		if (irq < 0) {
-			error = irq;
-			dev_err(dev, "couldn't get irq %s: %d\n",
-				hi65xx_irq_info[i].name, error);
-			return error;
-		}
+		if (irq < 0)
+			return irq;
 
 		error = devm_request_any_context_irq(dev, irq,
 						     hi65xx_irq_info[i].handler,
diff --git a/drivers/input/misc/max8925_onkey.c b/drivers/input/misc/max8925_onkey.c
index 7c49b8d23894..ffab4a490c75 100644
--- a/drivers/input/misc/max8925_onkey.c
+++ b/drivers/input/misc/max8925_onkey.c
@@ -71,16 +71,12 @@ static int max8925_onkey_probe(struct platform_device *pdev)
 	int irq[2], error;
 
 	irq[0] = platform_get_irq(pdev, 0);
-	if (irq[0] < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (irq[0] < 0)
 		return -EINVAL;
-	}
 
 	irq[1] = platform_get_irq(pdev, 1);
-	if (irq[1] < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (irq[1] < 0)
 		return -EINVAL;
-	}
 
 	info = devm_kzalloc(&pdev->dev, sizeof(struct max8925_onkey_info),
 			    GFP_KERNEL);
diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 017f81a66658..cf8104454e74 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -205,10 +205,8 @@ static int pm8941_pwrkey_probe(struct platform_device *pdev)
 		return error;
 
 	pwrkey->irq = platform_get_irq(pdev, 0);
-	if (pwrkey->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (pwrkey->irq < 0)
 		return pwrkey->irq;
-	}
 
 	error = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_REV2,
 			    &pwrkey->revision);
diff --git a/drivers/input/misc/rk805-pwrkey.c b/drivers/input/misc/rk805-pwrkey.c
index 4a6d4a5746e5..3fb64dbda1a2 100644
--- a/drivers/input/misc/rk805-pwrkey.c
+++ b/drivers/input/misc/rk805-pwrkey.c
@@ -53,16 +53,12 @@ static int rk805_pwrkey_probe(struct platform_device *pdev)
 	input_set_capability(pwr, EV_KEY, KEY_POWER);
 
 	fall_irq = platform_get_irq(pdev, 0);
-	if (fall_irq < 0) {
-		dev_err(&pdev->dev, "Can't get fall irq: %d\n", fall_irq);
+	if (fall_irq < 0)
 		return fall_irq;
-	}
 
 	rise_irq = platform_get_irq(pdev, 1);
-	if (rise_irq < 0) {
-		dev_err(&pdev->dev, "Can't get rise irq: %d\n", rise_irq);
+	if (rise_irq < 0)
 		return rise_irq;
-	}
 
 	err = devm_request_any_context_irq(&pwr->dev, fall_irq,
 					   pwrkey_fall_irq,
diff --git a/drivers/input/misc/stpmic1_onkey.c b/drivers/input/misc/stpmic1_onkey.c
index 7b49c9997df7..d8dc2f2f8000 100644
--- a/drivers/input/misc/stpmic1_onkey.c
+++ b/drivers/input/misc/stpmic1_onkey.c
@@ -61,18 +61,12 @@ static int stpmic1_onkey_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	onkey->irq_falling = platform_get_irq_byname(pdev, "onkey-falling");
-	if (onkey->irq_falling < 0) {
-		dev_err(dev, "failed: request IRQ onkey-falling %d\n",
-			onkey->irq_falling);
+	if (onkey->irq_falling < 0)
 		return onkey->irq_falling;
-	}
 
 	onkey->irq_rising = platform_get_irq_byname(pdev, "onkey-rising");
-	if (onkey->irq_rising < 0) {
-		dev_err(dev, "failed: request IRQ onkey-rising %d\n",
-			onkey->irq_rising);
+	if (onkey->irq_rising < 0)
 		return onkey->irq_rising;
-	}
 
 	if (!device_property_read_u32(dev, "power-off-time-sec", &val)) {
 		if (val > 0 && val <= 16) {
diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index a4455bb12ae0..f011447c44fb 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -124,10 +124,8 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
 	device_init_wakeup(dev, true);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "No IRQ resource!\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	error = devm_request_threaded_irq(dev, irq, NULL, tps6521x_pb_irq,
 					  IRQF_TRIGGER_RISING |
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 93235a007d07..bf6644927630 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -272,10 +272,8 @@ static int twl6040_vibra_probe(struct platform_device *pdev)
 	}
 
 	info->irq = platform_get_irq(pdev, 0);
-	if (info->irq < 0) {
-		dev_err(info->dev, "invalid irq\n");
+	if (info->irq < 0)
 		return -EINVAL;
-	}
 
 	error = devm_request_threaded_irq(&pdev->dev, info->irq, NULL,
 					  twl6040_vib_irq_handler,
diff --git a/drivers/input/mouse/pxa930_trkball.c b/drivers/input/mouse/pxa930_trkball.c
index 87bac8cff6f7..41acde60b60f 100644
--- a/drivers/input/mouse/pxa930_trkball.c
+++ b/drivers/input/mouse/pxa930_trkball.c
@@ -147,10 +147,8 @@ static int pxa930_trkball_probe(struct platform_device *pdev)
 	int irq, error;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get trkball irq\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
diff --git a/drivers/input/serio/arc_ps2.c b/drivers/input/serio/arc_ps2.c
index 443194a2b9e3..0af9fba5d16d 100644
--- a/drivers/input/serio/arc_ps2.c
+++ b/drivers/input/serio/arc_ps2.c
@@ -187,10 +187,8 @@ static int arc_ps2_probe(struct platform_device *pdev)
 	int error, id, i;
 
 	irq = platform_get_irq_byname(pdev, "arc_ps2_irq");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ defined\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	arc_ps2 = devm_kzalloc(&pdev->dev, sizeof(struct arc_ps2_data),
 				GFP_KERNEL);
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
index 1d1bbc8da949..81a3ea4b9a3d 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -185,10 +185,8 @@ static int pm860x_touch_probe(struct platform_device *pdev)
 	int irq, ret, res_x = 0, data = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	if (pm860x_touch_dt_init(pdev, chip, &res_x)) {
 		if (pdata) {
diff --git a/drivers/input/touchscreen/bcm_iproc_tsc.c b/drivers/input/touchscreen/bcm_iproc_tsc.c
index 4d11b27c7c43..7de1fd24ce36 100644
--- a/drivers/input/touchscreen/bcm_iproc_tsc.c
+++ b/drivers/input/touchscreen/bcm_iproc_tsc.c
@@ -489,10 +489,8 @@ static int iproc_ts_probe(struct platform_device *pdev)
 
 	/* get interrupt */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	error = devm_request_irq(&pdev->dev, irq,
 				 iproc_touchscreen_interrupt,
diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
index 1d6c8f490b40..5de58bd57a88 100644
--- a/drivers/input/touchscreen/fsl-imx25-tcq.c
+++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
@@ -528,10 +528,8 @@ static int mx25_tcq_probe(struct platform_device *pdev)
 	}
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq <= 0) {
-		dev_err(dev, "Failed to get IRQ\n");
+	if (priv->irq <= 0)
 		return priv->irq;
-	}
 
 	idev = devm_input_allocate_device(dev);
 	if (!idev) {
diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index e04eecd65bbb..9ed258854349 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -430,16 +430,12 @@ static int imx6ul_tsc_probe(struct platform_device *pdev)
 	}
 
 	tsc_irq = platform_get_irq(pdev, 0);
-	if (tsc_irq < 0) {
-		dev_err(&pdev->dev, "no tsc irq resource?\n");
+	if (tsc_irq < 0)
 		return tsc_irq;
-	}
 
 	adc_irq = platform_get_irq(pdev, 1);
-	if (adc_irq < 0) {
-		dev_err(&pdev->dev, "no adc irq resource?\n");
+	if (adc_irq < 0)
 		return adc_irq;
-	}
 
 	err = devm_request_threaded_irq(tsc->dev, tsc_irq,
 					NULL, tsc_irq_fn, IRQF_ONESHOT,
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 567ed64b5392..b2cd9472e2d1 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -212,10 +212,8 @@ static int lpc32xx_ts_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Can't get interrupt resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
 	input = input_allocate_device();
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index b0c1e5f9daae..1934c16a5abc 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -583,10 +583,8 @@ static int __init exynos_sysmmu_probe(struct platform_device *pdev)
 		return PTR_ERR(data->sfrbase);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Unable to find IRQ resource\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
 				dev_name(dev), data);
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
index 34d0b9783b3e..fb45486c6d14 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -696,10 +696,8 @@ static int qcom_iommu_ctx_probe(struct platform_device *pdev)
 		return PTR_ERR(ctx->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (irq < 0)
 		return -ENODEV;
-	}
 
 	/* clear IRQs before registering fault handler, just in case the
 	 * boot-loader left us a surprise:
diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index d00489a4b54f..698d07f48fed 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -362,10 +362,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	}
 	for (i = 0; i < priv->nr_perips; ++i) {
 		irq = platform_get_irq(pdev, 1 + i);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "cannot find perip IRQ #%u\n", i);
+		if (irq < 0)
 			return irq;
-		}
 		priv->perip_irqs[i] = irq;
 	}
 	/* check if too many were provided */
@@ -376,10 +374,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 
 	/* Get syswake IRQ number */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find syswake IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	priv->syswake_irq = irq;
 
 	/* Set up an IRQ domain */
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index efbcf8435185..8118ebe80b09 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -164,10 +164,8 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	}
 
 	kirq->irq = platform_get_irq(pdev, 0);
-	if (kirq->irq < 0) {
-		dev_err(dev, "no irq resource %d\n", kirq->irq);
+	if (kirq->irq < 0)
 		return kirq->irq;
-	}
 
 	kirq->dev = dev;
 	kirq->mask = ~0x0;
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index d88e993aa66d..abfe59284ff2 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -248,10 +248,8 @@ static int __init combiner_probe(struct platform_device *pdev)
 		return err;
 
 	combiner->parent_irq = platform_get_irq(pdev, 0);
-	if (combiner->parent_irq <= 0) {
-		dev_err(&pdev->dev, "Error getting IRQ resource\n");
+	if (combiner->parent_irq <= 0)
 		return -EPROBE_DEFER;
-	}
 
 	combiner->domain = irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
 						    &domain_ops, combiner);
diff --git a/drivers/mailbox/armada-37xx-rwtm-mailbox.c b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
index 97f90e97a83c..b52eb09a7c7e 100644
--- a/drivers/mailbox/armada-37xx-rwtm-mailbox.c
+++ b/drivers/mailbox/armada-37xx-rwtm-mailbox.c
@@ -165,10 +165,8 @@ static int armada_37xx_mbox_probe(struct platform_device *pdev)
 	}
 
 	mbox->irq = platform_get_irq(pdev, 0);
-	if (mbox->irq < 0) {
-		dev_err(&pdev->dev, "Cannot get irq\n");
+	if (mbox->irq < 0)
 		return mbox->irq;
-	}
 
 	mbox->dev = &pdev->dev;
 
diff --git a/drivers/mailbox/platform_mhu.c b/drivers/mailbox/platform_mhu.c
index b6e34952246b..c3bb07d66b53 100644
--- a/drivers/mailbox/platform_mhu.c
+++ b/drivers/mailbox/platform_mhu.c
@@ -137,10 +137,8 @@ static int platform_mhu_probe(struct platform_device *pdev)
 	for (i = 0; i < MHU_CHANS; i++) {
 		mhu->chan[i].con_priv = &mhu->mlink[i];
 		mhu->mlink[i].irq = platform_get_irq(pdev, i);
-		if (mhu->mlink[i].irq < 0) {
-			dev_err(dev, "failed to get irq%d\n", i);
+		if (mhu->mlink[i].irq < 0)
 			return mhu->mlink[i].irq;
-		}
 		mhu->mlink[i].rx_reg = mhu->base + platform_mhu_reg[i];
 		mhu->mlink[i].tx_reg = mhu->mlink[i].rx_reg + TX_REG_OFFSET;
 	}
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
index 86887c9a349a..bb15f62bb72c 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -668,10 +668,8 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 
 	/* IPI IRQ */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "unable to find IPI IRQ.\n");
+	if (ret < 0)
 		goto free_mbox_dev;
-	}
 	pdata->irq = ret;
 	ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
 			       IRQF_SHARED, dev_name(dev), pdata);
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
index 266df14da2d5..78381651238d 100644
--- a/drivers/media/platform/atmel/atmel-sama5d2-isc.c
+++ b/drivers/media/platform/atmel/atmel-sama5d2-isc.c
@@ -160,11 +160,8 @@ static int atmel_isc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		dev_err(dev, "failed to get irq: %d\n", ret);
-		return ret;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(dev, irq, isc_interrupt, 0,
 			       ATMEL_ISC_NAME, isc);
diff --git a/drivers/media/platform/exynos4-is/mipi-csis.c b/drivers/media/platform/exynos4-is/mipi-csis.c
index 3e9ac6066cf6..b9f1cc42b0ab 100644
--- a/drivers/media/platform/exynos4-is/mipi-csis.c
+++ b/drivers/media/platform/exynos4-is/mipi-csis.c
@@ -803,10 +803,8 @@ static int s5pcsis_probe(struct platform_device *pdev)
 		return PTR_ERR(state->regs);
 
 	state->irq = platform_get_irq(pdev, 0);
-	if (state->irq < 0) {
-		dev_err(dev, "Failed to get irq\n");
+	if (state->irq < 0)
 		return state->irq;
-	}
 
 	for (i = 0; i < CSIS_NUM_SUPPLIES; i++)
 		state->supplies[i].supply = csis_supply_name[i];
diff --git a/drivers/media/platform/imx-pxp.c b/drivers/media/platform/imx-pxp.c
index 8e7ef23b9a7e..38d942322302 100644
--- a/drivers/media/platform/imx-pxp.c
+++ b/drivers/media/platform/imx-pxp.c
@@ -1661,10 +1661,8 @@ static int pxp_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, pxp_irq_handler,
 			IRQF_ONESHOT, dev_name(&pdev->dev), dev);
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
index 57d0c0f9fa4b..197b3991330d 100644
--- a/drivers/media/platform/renesas-ceu.c
+++ b/drivers/media/platform/renesas-ceu.c
@@ -1659,10 +1659,8 @@ static int ceu_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "Failed to get irq: %d\n", ret);
+	if (ret < 0)
 		goto error_free_ceudev;
-	}
 	irq = ret;
 
 	ret = devm_request_irq(dev, irq, ceu_irq,
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
index b05ce0149ca1..b2d2098c01dd 100644
--- a/drivers/media/platform/s3c-camif/camif-core.c
+++ b/drivers/media/platform/s3c-camif/camif-core.c
@@ -386,10 +386,8 @@ static int camif_request_irqs(struct platform_device *pdev,
 		init_waitqueue_head(&vp->irq_queue);
 
 		irq = platform_get_irq(pdev, i);
-		if (irq <= 0) {
-			dev_err(&pdev->dev, "failed to get IRQ %d\n", i);
+		if (irq <= 0)
 			return -ENXIO;
-		}
 
 		ret = devm_request_irq(&pdev->dev, irq, s3c_camif_irq_handler,
 				       0, dev_name(&pdev->dev), vp);
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 3c05b3dc49ec..5baada4f65e5 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -693,16 +693,12 @@ static int c8sectpfe_probe(struct platform_device *pdev)
 	fei->sram_size = resource_size(res);
 
 	fei->idle_irq = platform_get_irq_byname(pdev, "c8sectpfe-idle-irq");
-	if (fei->idle_irq < 0) {
-		dev_err(dev, "Can't get c8sectpfe-idle-irq\n");
+	if (fei->idle_irq < 0)
 		return fei->idle_irq;
-	}
 
 	fei->error_irq = platform_get_irq_byname(pdev, "c8sectpfe-error-irq");
-	if (fei->error_irq < 0) {
-		dev_err(dev, "Can't get c8sectpfe-error-irq\n");
+	if (fei->error_irq < 0)
 		return fei->error_irq;
-	}
 
 	platform_set_drvdata(pdev, fei);
 
diff --git a/drivers/media/platform/sti/hva/hva-hw.c b/drivers/media/platform/sti/hva/hva-hw.c
index 7917fd2c4bd4..401aaafa1710 100644
--- a/drivers/media/platform/sti/hva/hva-hw.c
+++ b/drivers/media/platform/sti/hva/hva-hw.c
@@ -341,10 +341,8 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 
 	/* get status interruption resource */
 	ret  = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "%s     failed to get status IRQ\n", HVA_PREFIX);
+	if (ret < 0)
 		goto err_clk;
-	}
 	hva->irq_its = ret;
 
 	ret = devm_request_threaded_irq(dev, hva->irq_its, hva_hw_its_interrupt,
@@ -360,10 +358,8 @@ int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
 
 	/* get error interruption resource */
 	ret = platform_get_irq(pdev, 1);
-	if (ret < 0) {
-		dev_err(dev, "%s     failed to get error IRQ\n", HVA_PREFIX);
+	if (ret < 0)
 		goto err_clk;
-	}
 	hva->irq_err = ret;
 
 	ret = devm_request_threaded_irq(dev, hva->irq_err, hva_hw_err_interrupt,
diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
index d855e9c09c08..672a53195b56 100644
--- a/drivers/media/platform/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/stm32/stm32-dcmi.c
@@ -1699,11 +1699,8 @@ static int dcmi_probe(struct platform_device *pdev)
 	dcmi->bus.data_shift = ep.bus.parallel.data_shift;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Could not get irq\n");
+	if (irq <= 0)
 		return irq ? irq : -ENXIO;
-	}
 
 	dcmi->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!dcmi->res) {
diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
index 6e0e894154f4..055eb0b8e396 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
@@ -866,11 +866,8 @@ static int sun6i_csi_resource_request(struct sun6i_csi_dev *sdev,
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No csi IRQ specified\n");
-		ret = -ENXIO;
-		return ret;
-	}
+	if (irq < 0)
+		return -ENXIO;
 
 	ret = devm_request_irq(&pdev->dev, irq, sun6i_csi_isr, 0, MODULE_NAME,
 			       sdev);
diff --git a/drivers/media/rc/img-ir/img-ir-core.c b/drivers/media/rc/img-ir/img-ir-core.c
index 7e457f26a595..094aa6a06315 100644
--- a/drivers/media/rc/img-ir/img-ir-core.c
+++ b/drivers/media/rc/img-ir/img-ir-core.c
@@ -81,10 +81,8 @@ static int img_ir_probe(struct platform_device *pdev)
 
 	/* Get resources from platform device */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	/* Private driver data */
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 85561f6555a2..32ccefeff57d 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -232,10 +232,8 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(dev, "irq can not get\n");
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	rdev = rc_allocate_device(RC_DRIVER_IR_RAW);
 	if (!rdev)
diff --git a/drivers/media/rc/meson-ir.c b/drivers/media/rc/meson-ir.c
index 72a7bbbf6b1f..51c6dd3406a0 100644
--- a/drivers/media/rc/meson-ir.c
+++ b/drivers/media/rc/meson-ir.c
@@ -117,10 +117,8 @@ static int meson_ir_probe(struct platform_device *pdev)
 		return PTR_ERR(ir->reg);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
 	if (!ir->rc) {
diff --git a/drivers/media/rc/mtk-cir.c b/drivers/media/rc/mtk-cir.c
index 50fb0aebb8d4..4507f729a656 100644
--- a/drivers/media/rc/mtk-cir.c
+++ b/drivers/media/rc/mtk-cir.c
@@ -353,10 +353,8 @@ static int mtk_ir_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ir);
 
 	ir->irq = platform_get_irq(pdev, 0);
-	if (ir->irq < 0) {
-		dev_err(dev, "no irq resource\n");
+	if (ir->irq < 0)
 		return -ENODEV;
-	}
 
 	if (clk_prepare_enable(ir->clk)) {
 		dev_err(dev, "try to enable ir_clk failed\n");
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
index 402c6bc8e621..f021687ecc5c 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1563,11 +1563,8 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 		goto error;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(emif->dev, "%s: error getting IRQ resource - %d\n",
-			__func__, irq);
+	if (irq < 0)
 		goto error;
-	}
 
 	emif_onetime_settings(emif);
 	emif_debugfs_init(emif);
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 3d8d322511c5..851983c67fc1 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -677,10 +677,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	}
 
 	mc->irq = platform_get_irq(pdev, 0);
-	if (mc->irq < 0) {
-		dev_err(&pdev->dev, "interrupt not specified\n");
+	if (mc->irq < 0)
 		return mc->irq;
-	}
 
 	WARN(!mc->soc->client_id_mask, "missing client ID mask for this SoC\n");
 
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index d24c6ecccb88..e44a582050f2 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -2682,16 +2682,12 @@ static int ab8500_debug_probe(struct platform_device *plf)
 	irq_ab8500 = res->start;
 
 	irq_first = platform_get_irq_byname(plf, "IRQ_FIRST");
-	if (irq_first < 0) {
-		dev_err(&plf->dev, "First irq not found, err %d\n", irq_first);
+	if (irq_first < 0)
 		return irq_first;
-	}
 
 	irq_last = platform_get_irq_byname(plf, "IRQ_LAST");
-	if (irq_last < 0) {
-		dev_err(&plf->dev, "Last irq not found, err %d\n", irq_last);
+	if (irq_last < 0)
 		return irq_last;
-	}
 
 	ab8500_dir = debugfs_create_dir(AB8500_NAME_STRING, NULL);
 	if (!ab8500_dir)
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 3f21e26b8d36..2f4c9c9ed80f 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3128,10 +3128,8 @@ static int db8500_prcmu_probe(struct platform_device *pdev)
 	writel(ALL_MBOX_BITS, PRCM_ARM_IT1_CLR);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "no prcmu irq provided\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	err = request_threaded_irq(irq, prcmu_irq_handler,
 	        prcmu_irq_thread_fn, IRQF_NO_SUSPEND, "prcmu", NULL);
diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index 20791cab7263..a016b39fe9b0 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -69,10 +69,8 @@ static int mx25_tsadc_setup_irq(struct platform_device *pdev,
 	int irq;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Failed to get irq\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	tsadc->domain = irq_domain_add_simple(np, 2, 0, &mx25_tsadc_domain_ops,
 					      tsadc);
diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
index 6310c3bdb991..739cfb5b69fe 100644
--- a/drivers/mfd/intel_soc_pmic_bxtwc.c
+++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
@@ -450,10 +450,8 @@ static int bxtwc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Invalid IRQ\n");
+	if (ret < 0)
 		return ret;
-	}
 	pmic->irq = ret;
 
 	dev_set_drvdata(&pdev->dev, pmic);
diff --git a/drivers/mfd/jz4740-adc.c b/drivers/mfd/jz4740-adc.c
index 082f16917519..18344cd08ede 100644
--- a/drivers/mfd/jz4740-adc.c
+++ b/drivers/mfd/jz4740-adc.c
@@ -208,17 +208,12 @@ static int jz4740_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adc->irq = platform_get_irq(pdev, 0);
-	if (adc->irq < 0) {
-		ret = adc->irq;
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
-		return ret;
-	}
+	if (adc->irq < 0)
+		return adc->irq;
 
 	irq_base = platform_get_irq(pdev, 1);
-	if (irq_base < 0) {
-		dev_err(&pdev->dev, "Failed to get irq base: %d\n", irq_base);
+	if (irq_base < 0)
 		return irq_base;
-	}
 
 	mem_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem_base) {
diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 4d7e9008628c..71bc34b74bc9 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -561,22 +561,16 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 	clk_prepare_enable(rpm->ramclk); /* Accepts NULL */
 
 	irq_ack = platform_get_irq_byname(pdev, "ack");
-	if (irq_ack < 0) {
-		dev_err(&pdev->dev, "required ack interrupt missing\n");
+	if (irq_ack < 0)
 		return irq_ack;
-	}
 
 	irq_err = platform_get_irq_byname(pdev, "err");
-	if (irq_err < 0) {
-		dev_err(&pdev->dev, "required err interrupt missing\n");
+	if (irq_err < 0)
 		return irq_err;
-	}
 
 	irq_wakeup = platform_get_irq_byname(pdev, "wakeup");
-	if (irq_wakeup < 0) {
-		dev_err(&pdev->dev, "required wakeup interrupt missing\n");
+	if (irq_wakeup < 0)
 		return irq_wakeup;
-	}
 
 	match = of_match_device(qcom_rpm_of_match, &pdev->dev);
 	if (!match)
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 9b9b06d36cb1..d5e34a5eb250 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1394,10 +1394,8 @@ static int sm501_plat_probe(struct platform_device *dev)
 	sm->platdata = dev_get_platdata(&dev->dev);
 
 	ret = platform_get_irq(dev, 0);
-	if (ret < 0) {
-		dev_err(&dev->dev, "failed to get irq resource\n");
+	if (ret < 0)
 		goto err_res;
-	}
 	sm->irq = ret;
 
 	sm->io_res = platform_get_resource(dev, IORESOURCE_MEM, 1);
diff --git a/drivers/misc/spear13xx_pcie_gadget.c b/drivers/misc/spear13xx_pcie_gadget.c
index ee120dcbb3e6..5ceeee7cc305 100644
--- a/drivers/misc/spear13xx_pcie_gadget.c
+++ b/drivers/misc/spear13xx_pcie_gadget.c
@@ -702,10 +702,8 @@ static int spear_pcie_gadget_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, target);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no update irq?\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	status = devm_request_irq(&pdev->dev, irq, spear_pcie_gadget_irq,
 				  0, pdev->name, NULL);
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
index 750604f7fac9..011b59a3602e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1010,10 +1010,8 @@ static int mxcmci_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
 	if (!mmc)
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
index 8e4a8ba33f05..3d7fa948b4c3 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -490,10 +490,8 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq specified\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	host = sdhci_alloc_host(dev, sizeof(struct sdhci_s3c));
 	if (IS_ERR(host)) {
diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
index e369cbf1ff02..f8b939e63e02 100644
--- a/drivers/mmc/host/sdhci_f_sdh30.c
+++ b/drivers/mmc/host/sdhci_f_sdh30.c
@@ -119,10 +119,8 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
 	u32 reg = 0;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "%s: no irq specified\n", __func__);
+	if (irq < 0)
 		return irq;
-	}
 
 	host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
 	if (IS_ERR(host))
diff --git a/drivers/mmc/host/uniphier-sd.c b/drivers/mmc/host/uniphier-sd.c
index 49aad9a79c18..e09336f9166d 100644
--- a/drivers/mmc/host/uniphier-sd.c
+++ b/drivers/mmc/host/uniphier-sd.c
@@ -557,10 +557,8 @@ static int uniphier_sd_probe(struct platform_device *pdev)
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number");
+	if (irq < 0)
 		return irq;
-	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
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
index 5e14836f6bd5..df992554a66f 100644
--- a/drivers/mtd/nand/raw/denali_dt.c
+++ b/drivers/mtd/nand/raw/denali_dt.c
@@ -167,10 +167,8 @@ static int denali_dt_probe(struct platform_device *pdev)
 
 	denali->dev = dev;
 	denali->irq = platform_get_irq(pdev, 0);
-	if (denali->irq < 0) {
-		dev_err(dev, "no irq defined\n");
+	if (denali->irq < 0)
 		return denali->irq;
-	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "denali_reg");
 	denali->reg = devm_ioremap_resource(dev, res);
diff --git a/drivers/mtd/nand/raw/hisi504_nand.c b/drivers/mtd/nand/raw/hisi504_nand.c
index 6a4626a8bf95..0b48be54ba6f 100644
--- a/drivers/mtd/nand/raw/hisi504_nand.c
+++ b/drivers/mtd/nand/raw/hisi504_nand.c
@@ -751,10 +751,8 @@ static int hisi_nfc_probe(struct platform_device *pdev)
 	mtd  = nand_to_mtd(chip);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no IRQ resource defined\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->iobase = devm_ioremap_resource(dev, res);
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
index fc49e13d81ec..fb5abdcfb007 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -2862,10 +2862,8 @@ static int marvell_nfc_probe(struct platform_device *pdev)
 		return PTR_ERR(nfc->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	nfc->core_clk = devm_clk_get(&pdev->dev, "core");
 
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ea57ddcec41e..84b82d823952 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -1398,10 +1398,8 @@ static int meson_nfc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no NFC IRQ resource\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	ret = meson_nfc_clk_init(nfc);
 	if (ret) {
diff --git a/drivers/mtd/nand/raw/mtk_ecc.c b/drivers/mtd/nand/raw/mtk_ecc.c
index 74595b644b7c..75f1fa3d4d35 100644
--- a/drivers/mtd/nand/raw/mtk_ecc.c
+++ b/drivers/mtd/nand/raw/mtk_ecc.c
@@ -527,10 +527,8 @@ static int mtk_ecc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
 	if (ret) {
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
index 8d881a28140e..dccc927c5fa5 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -1967,10 +1967,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 
 	case NAND_OMAP_PREFETCH_IRQ:
 		info->gpmc_irq_fifo = platform_get_irq(info->pdev, 0);
-		if (info->gpmc_irq_fifo <= 0) {
-			dev_err(dev, "Error getting fifo IRQ\n");
+		if (info->gpmc_irq_fifo <= 0)
 			return -ENODEV;
-		}
 		err = devm_request_irq(dev, info->gpmc_irq_fifo,
 				       omap_nand_irq, IRQF_SHARED,
 				       "gpmc-nand-fifo", info);
@@ -1982,10 +1980,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 		}
 
 		info->gpmc_irq_count = platform_get_irq(info->pdev, 1);
-		if (info->gpmc_irq_count <= 0) {
-			dev_err(dev, "Error getting IRQ count\n");
+		if (info->gpmc_irq_count <= 0)
 			return -ENODEV;
-		}
 		err = devm_request_irq(dev, info->gpmc_irq_count,
 				       omap_nand_irq, IRQF_SHARED,
 				       "gpmc-nand-count", info);
diff --git a/drivers/mtd/nand/raw/sh_flctl.c b/drivers/mtd/nand/raw/sh_flctl.c
index e509c93737c4..058e99d0cbcf 100644
--- a/drivers/mtd/nand/raw/sh_flctl.c
+++ b/drivers/mtd/nand/raw/sh_flctl.c
@@ -1129,10 +1129,8 @@ static int flctl_probe(struct platform_device *pdev)
 	flctl->fifo = res->start + 0x24; /* FLDTFIFO */
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get flste irq data: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, flctl_handle_flste, IRQF_SHARED,
 			       "flste", flctl);
diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index e63acc077c18..1cc70fe2a4d7 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1912,11 +1912,8 @@ static int stm32_fmc2_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "IRQ error missing or invalid\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, stm32_fmc2_irq, 0,
 			       dev_name(dev), fmc2);
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 89773293c64d..37a4ac0dd85b 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2071,10 +2071,8 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
 		return PTR_ERR(nfc->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to retrieve irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	nfc->ahb_clk = devm_clk_get(dev, "ahb");
 	if (IS_ERR(nfc->ahb_clk)) {
diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
index 67f15a1f16fd..172d7a0a2454 100644
--- a/drivers/mtd/spi-nor/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/cadence-quadspi.c
@@ -1375,10 +1375,8 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	/* Obtain IRQ line. */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Cannot obtain IRQ.\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	pm_runtime_enable(dev);
 	ret = pm_runtime_get_sync(dev);
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
index d0f3dfb88202..dce9e59e8881 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-platform.c
@@ -467,10 +467,8 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 
 	/* Get the device interrupt */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "platform_get_irq 0 failed\n");
+	if (ret < 0)
 		goto err_io;
-	}
 	pdata->dev_irq = ret;
 
 	/* Get the per channel DMA interrupts */
@@ -479,12 +477,8 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 
 		for (i = 0; (i < max) && (dma_irqnum < dma_irqend); i++) {
 			ret = platform_get_irq(pdata->platdev, dma_irqnum++);
-			if (ret < 0) {
-				netdev_err(pdata->netdev,
-					   "platform_get_irq %u failed\n",
-					   dma_irqnum - 1);
+			if (ret < 0)
 				goto err_io;
-			}
 
 			pdata->channel_irq[i] = ret;
 		}
@@ -496,10 +490,8 @@ static int xgbe_platform_probe(struct platform_device *pdev)
 
 	/* Get the auto-negotiation interrupt */
 	ret = platform_get_irq(phy_pdev, phy_irqnum++);
-	if (ret < 0) {
-		dev_err(dev, "platform_get_irq phy 0 failed\n");
+	if (ret < 0)
 		goto err_io;
-	}
 	pdata->an_irq = ret;
 
 	/* Configure the netdev resource */
diff --git a/drivers/net/ethernet/apm/xgene-v2/main.c b/drivers/net/ethernet/apm/xgene-v2/main.c
index 79048cc46703..02b4f3af02b5 100644
--- a/drivers/net/ethernet/apm/xgene-v2/main.c
+++ b/drivers/net/ethernet/apm/xgene-v2/main.c
@@ -54,10 +54,8 @@ static int xge_get_resources(struct xge_pdata *pdata)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "Unable to get irq\n");
+	if (ret < 0)
 		return ret;
-	}
 	pdata->resources.irq = ret;
 
 	return 0;
diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 10b1c053e70a..a63baca97f53 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1636,9 +1636,7 @@ static int xgene_enet_get_irqs(struct xgene_enet_pdata *pdata)
 				pdata->cq_cnt = max_irqs / 2;
 				break;
 			}
-			dev_err(dev, "Unable to get ENET IRQ\n");
-			ret = ret ? : -ENXIO;
-			return ret;
+			return ret ? : -ENXIO;
 		}
 		pdata->irqs[i] = ret;
 	}
diff --git a/drivers/net/ethernet/aurora/nb8800.c b/drivers/net/ethernet/aurora/nb8800.c
index 3b3370a94a9c..37752d9514e7 100644
--- a/drivers/net/ethernet/aurora/nb8800.c
+++ b/drivers/net/ethernet/aurora/nb8800.c
@@ -1351,10 +1351,8 @@ static int nb8800_probe(struct platform_device *pdev)
 		ops = match->data;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(&pdev->dev, "No IRQ\n");
+	if (irq <= 0)
 		return -EINVAL;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 6dc0dd91ad11..c46c1b1416f7 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -199,10 +199,8 @@ static int bgmac_probe(struct platform_device *pdev)
 		dev_warn(&pdev->dev, "MAC address not present in device tree\n");
 
 	bgmac->irq = platform_get_irq(pdev, 0);
-	if (bgmac->irq < 0) {
-		dev_err(&pdev->dev, "Unable to obtain IRQ\n");
+	if (bgmac->irq < 0)
 		return bgmac->irq;
-	}
 
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "amac_base");
 	if (!regs) {
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 9003eb6716cd..5a8d7b44faf9 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2423,10 +2423,8 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	/* Interrupt */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "no IRQ\n");
+	if (irq <= 0)
 		return irq ? irq : -ENODEV;
-	}
 	port->irq = irq;
 
 	/* Clock the port */
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
index cda641ef89af..900affbdcc0e 100644
--- a/drivers/net/ethernet/lantiq_xrx200.c
+++ b/drivers/net/ethernet/lantiq_xrx200.c
@@ -458,17 +458,11 @@ static int xrx200_probe(struct platform_device *pdev)
 	}
 
 	priv->chan_rx.dma.irq = platform_get_irq_byname(pdev, "rx");
-	if (priv->chan_rx.dma.irq < 0) {
-		dev_err(dev, "failed to get RX IRQ, %i\n",
-			priv->chan_rx.dma.irq);
+	if (priv->chan_rx.dma.irq < 0)
 		return -ENOENT;
-	}
 	priv->chan_tx.dma.irq = platform_get_irq_byname(pdev, "tx");
-	if (priv->chan_tx.dma.irq < 0) {
-		dev_err(dev, "failed to get TX IRQ, %i\n",
-			priv->chan_tx.dma.irq);
+	if (priv->chan_tx.dma.irq < 0)
 		return -ENOENT;
-	}
 
 	/* get the clock */
 	priv->clk = devm_clk_get(dev, NULL);
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
index 59c2349b59df..bfe10464c81f 100644
--- a/drivers/net/ethernet/qualcomm/emac/emac.c
+++ b/drivers/net/ethernet/qualcomm/emac/emac.c
@@ -556,11 +556,8 @@ static int emac_probe_resources(struct platform_device *pdev,
 
 	/* Core 0 interrupt */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev,
-			"error: missing core0 irq resource (error=%i)\n", ret);
+	if (ret < 0)
 		return ret;
-	}
 	adpt->irq.irq = ret;
 
 	/* base register address */
diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index 51a7b48db4bc..87ab0b5da91e 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1573,10 +1573,8 @@ static int ave_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "IRQ not found\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 3a14cdd01f5f..cac32f7eb6f3 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -428,13 +428,8 @@ static int dwc_eth_dwmac_probe(struct platform_device *pdev)
 	 * resource initialization is done in the glue logic.
 	 */
 	stmmac_res.irq = platform_get_irq(pdev, 0);
-	if (stmmac_res.irq < 0) {
-		if (stmmac_res.irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"IRQ configuration information not found\n");
-
+	if (stmmac_res.irq < 0)
 		return stmmac_res.irq;
-	}
 	stmmac_res.wol_irq = stmmac_res.irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 73fc2524372e..1ca3d8009b55 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -602,13 +602,8 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
 	 * probe if needed before we went too far with resource allocation.
 	 */
 	stmmac_res->irq = platform_get_irq_byname(pdev, "macirq");
-	if (stmmac_res->irq < 0) {
-		if (stmmac_res->irq != -EPROBE_DEFER) {
-			dev_err(&pdev->dev,
-				"MAC IRQ configuration information not found\n");
-		}
+	if (stmmac_res->irq < 0)
 		return stmmac_res->irq;
-	}
 
 	/* On some platforms e.g. SPEAr the wake up irq differs from the mac irq
 	 * The external wake up irq can be passed through the platform code
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
index b920be1f5718..c6c1ce69bcbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/soc.c
@@ -17,10 +17,8 @@ mt76_wmac_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get device IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	mem_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(mem_base)) {
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 4234ddb4722f..5ab34ce963f1 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -462,10 +462,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 	struct resource *res;
 
 	pp->irq = platform_get_irq(pdev, 1);
-	if (pp->irq < 0) {
-		dev_err(dev, "missing IRQ resource\n");
+	if (pp->irq < 0)
 		return pp->irq;
-	}
 
 	ret = devm_request_irq(dev, pp->irq, dra7xx_pcie_msi_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
@@ -713,10 +711,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	pci->ops = &dw_pcie_ops;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
 	base = devm_ioremap_nocache(dev, res->start, resource_size(res));
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index cee5f2f590e2..a3e005b5f93d 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -402,10 +402,8 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 1);
-	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (pp->irq < 0)
 		return pp->irq;
-	}
 	ret = devm_request_irq(dev, pp->irq, exynos_pcie_irq_handler,
 				IRQF_SHARED, "exynos-pcie", ep);
 	if (ret) {
@@ -415,10 +413,8 @@ static int __init exynos_add_pcie_port(struct exynos_pcie *ep,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
-		if (pp->msi_irq < 0) {
-			dev_err(dev, "failed to get msi irq\n");
+		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-		}
 	}
 
 	pp->ops = &exynos_pcie_host_ops;
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 9b5cb5b70389..a969ec82ca5f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -867,10 +867,8 @@ static int imx6_add_pcie_port(struct imx6_pcie *imx6_pcie,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq <= 0) {
-			dev_err(dev, "failed to get MSI irq\n");
+		if (pp->msi_irq <= 0)
 			return -ENODEV;
-		}
 	}
 
 	pp->ops = &imx6_pcie_host_ops;
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index af677254a072..3878208cfd44 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1247,10 +1247,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	pci->version = version;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_irq(irq, ks_pcie_err_irq_handler, IRQF_SHARED,
 			  "ks-pcie-error-irq", ks_pcie);
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index e35e9eaa50ee..419c30034dc8 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -500,10 +500,8 @@ static int meson_add_pcie_port(struct meson_pcie *mp,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq(pdev, 0);
-		if (pp->msi_irq < 0) {
-			dev_err(dev, "failed to get MSI IRQ\n");
+		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-		}
 	}
 
 	pp->ops = &meson_pcie_host_ops;
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 3d55dc78d999..33309ce70ad5 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -249,10 +249,8 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 	pp->ops = &armada8k_pcie_host_ops;
 
 	pp->irq = platform_get_irq(pdev, 0);
-	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq for port\n");
+	if (pp->irq < 0)
 		return pp->irq;
-	}
 
 	ret = devm_request_irq(dev, pp->irq, armada8k_pcie_irq_handler,
 			       IRQF_SHARED, "armada8k-pcie", pcie);
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index d00252bd8fae..7fa7f8d134b6 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -393,10 +393,8 @@ static int artpec6_add_pcie_port(struct artpec6_pcie *artpec6_pcie,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq < 0) {
-			dev_err(dev, "failed to get MSI irq\n");
+		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-		}
 	}
 
 	pp->ops = &artpec6_pcie_host_ops;
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 954bc2b74bbc..6612072bd720 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -402,10 +402,8 @@ static int histb_pcie_probe(struct platform_device *pdev)
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		pp->msi_irq = platform_get_irq_byname(pdev, "msi");
-		if (pp->msi_irq < 0) {
-			dev_err(dev, "Failed to get MSI IRQ\n");
+		if (pp->msi_irq < 0)
 			return pp->msi_irq;
-		}
 	}
 
 	hipcie->phy = devm_phy_get(dev, "phy");
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 8df1914226be..dc08551e3f8d 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -455,11 +455,8 @@ static int kirin_pcie_add_msi(struct dw_pcie *pci,
 
 	if (IS_ENABLED(CONFIG_PCI_MSI)) {
 		irq = platform_get_irq(pdev, 0);
-		if (irq < 0) {
-			dev_err(&pdev->dev,
-				"failed to get MSI IRQ (%d)\n", irq);
+		if (irq < 0)
 			return irq;
-		}
 
 		pci->pp.msi_irq = irq;
 	}
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 7d0cdfd8138b..26d3a734ce0d 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -198,10 +198,8 @@ static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 	int ret;
 
 	pp->irq = platform_get_irq(pdev, 0);
-	if (pp->irq < 0) {
-		dev_err(dev, "failed to get irq\n");
+	if (pp->irq < 0)
 		return pp->irq;
-	}
 	ret = devm_request_irq(dev, pp->irq, spear13xx_pcie_irq_handler,
 			       IRQF_SHARED | IRQF_NO_THREAD,
 			       "spear1340-pcie", spear13xx_pcie);
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 9a917b2456f6..43b6e0848b91 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1549,10 +1549,8 @@ static int tegra_pcie_get_resources(struct tegra_pcie *pcie)
 
 	/* request interrupt */
 	err = platform_get_irq_byname(pdev, "intr");
-	if (err < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", err);
+	if (err < 0)
 		goto phys_put;
-	}
 
 	pcie->irq = err;
 
@@ -1767,10 +1765,8 @@ static int tegra_pcie_msi_setup(struct tegra_pcie *pcie)
 	}
 
 	err = platform_get_irq_byname(pdev, "msi");
-	if (err < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", err);
+	if (err < 0)
 		goto free_irq_domain;
-	}
 
 	msi->irq = err;
 
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index d219404bad92..7c9d898cde71 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -804,10 +804,8 @@ static int v3_pci_probe(struct platform_device *pdev)
 
 	/* Get and request error IRQ resource */
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
+	if (irq <= 0)
 		return -ENODEV;
-	}
 	ret = devm_request_irq(dev, irq, v3_irq, 0,
 			"PCIv3 error", v3);
 	if (ret < 0) {
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
index d2497ca43828..0ef01b06efda 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -747,10 +747,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
 
 	/* setup IRQ */
 	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq < 0) {
-		dev_err(dev, "failed to get IRQ: %d\n", pcie->irq);
+	if (pcie->irq < 0)
 		return pcie->irq;
-	}
 
 	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
 	return 0;
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 672e633601c7..34400ea5a7c3 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -453,10 +453,8 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 		pcie->ppio_wins = MAX_PIO_WINDOWS;
 
 	pcie->irq = platform_get_irq(pdev, 0);
-	if (pcie->irq <= 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
+	if (pcie->irq <= 0)
 		return -ENODEV;
-	}
 
 	return 0;
 }
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 8d20f1793a61..edbf872a76d5 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -549,10 +549,8 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	struct platform_device *pdev = to_platform_device(dev);
 
 	irq = platform_get_irq_byname(pdev, "sys");
-	if (irq < 0) {
-		dev_err(dev, "missing sys IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_subsys_irq_handler,
 			       IRQF_SHARED, "pcie-sys", rockchip);
@@ -562,20 +560,16 @@ static int rockchip_pcie_setup_irq(struct rockchip_pcie *rockchip)
 	}
 
 	irq = platform_get_irq_byname(pdev, "legacy");
-	if (irq < 0) {
-		dev_err(dev, "missing legacy IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	irq_set_chained_handler_and_data(irq,
 					 rockchip_pcie_legacy_int_handler,
 					 rockchip);
 
 	irq = platform_get_irq_byname(pdev, "client");
-	if (irq < 0) {
-		dev_err(dev, "missing client IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	err = devm_request_irq(dev, irq, rockchip_pcie_client_irq_handler,
 			       IRQF_SHARED, "pcie-client", rockchip);
diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
index 21a208da3f59..b87aa9041480 100644
--- a/drivers/pci/controller/pcie-tango.c
+++ b/drivers/pci/controller/pcie-tango.c
@@ -273,10 +273,8 @@ static int tango_pcie_probe(struct platform_device *pdev)
 		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
 
 	virq = platform_get_irq(pdev, 1);
-	if (virq <= 0) {
-		dev_err(dev, "Failed to map IRQ\n");
+	if (virq <= 0)
 		return -ENXIO;
-	}
 
 	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
 	if (!irq_dom) {
diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 45c0f344ccd1..743244db09d1 100644
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
@@ -728,11 +726,8 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 
 	/* Get misc IRQ number */
 	pcie->irq_misc = platform_get_irq_byname(pdev, "misc");
-	if (pcie->irq_misc < 0) {
-		dev_err(dev, "failed to get misc IRQ %d\n",
-			pcie->irq_misc);
+	if (pcie->irq_misc < 0)
 		return -EINVAL;
-	}
 
 	err = devm_request_irq(dev, pcie->irq_misc,
 			       nwl_pcie_misc_handler, IRQF_SHARED,
@@ -797,10 +792,8 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
 
 	/* Get intx IRQ number */
 	pcie->irq_intx = platform_get_irq_byname(pdev, "intx");
-	if (pcie->irq_intx < 0) {
-		dev_err(dev, "failed to get intx IRQ %d\n", pcie->irq_intx);
+	if (pcie->irq_intx < 0)
 		return pcie->irq_intx;
-	}
 
 	irq_set_chained_handler_and_data(pcie->irq_intx,
 					 nwl_pcie_leg_handler, pcie);
diff --git a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
index 6ad0823bcf23..e42d4464c2cf 100644
--- a/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_ddrc_pmu.c
@@ -217,10 +217,8 @@ static int hisi_ddrc_pmu_init_irq(struct hisi_pmu *ddrc_pmu,
 
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "DDRC PMU get irq fail; irq:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, hisi_ddrc_pmu_isr,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD,
diff --git a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
index 4f2917f3e25e..f28063873e11 100644
--- a/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_hha_pmu.c
@@ -207,10 +207,8 @@ static int hisi_hha_pmu_init_irq(struct hisi_pmu *hha_pmu,
 
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "HHA PMU get irq fail; irq:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, hisi_hha_pmu_isr,
 			      IRQF_NOBALANCING | IRQF_NO_THREAD,
diff --git a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
index 9153e093f9df..078b8dc57250 100644
--- a/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c
@@ -206,10 +206,8 @@ static int hisi_l3c_pmu_init_irq(struct hisi_pmu *l3c_pmu,
 
 	/* Read and init IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "L3C PMU get irq fail; irq:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, hisi_l3c_pmu_isr,
 			       IRQF_NOBALANCING | IRQF_NO_THREAD,
diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index d06182fe14b8..21d6991dbe0b 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -909,12 +909,8 @@ static int l2_cache_pmu_probe_cluster(struct device *dev, void *data)
 	cluster->cluster_id = fw_cluster_id;
 
 	irq = platform_get_irq(sdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev,
-			"Failed to get valid irq for cluster %ld\n",
-			fw_cluster_id);
+	if (irq < 0)
 		return irq;
-	}
 	irq_set_status_flags(irq, IRQ_NOAUTOEN);
 	cluster->irq = irq;
 
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 3259e2ebeb39..7e328d6385c3 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -1901,10 +1901,8 @@ static int xgene_pmu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	rc = devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
 				IRQF_NOBALANCING | IRQF_NO_THREAD,
diff --git a/drivers/pinctrl/intel/pinctrl-cherryview.c b/drivers/pinctrl/intel/pinctrl-cherryview.c
index 03ec7a5d9d0b..cd4a69b4c5a8 100644
--- a/drivers/pinctrl/intel/pinctrl-cherryview.c
+++ b/drivers/pinctrl/intel/pinctrl-cherryview.c
@@ -1703,10 +1703,8 @@ static int chv_pinctrl_probe(struct platform_device *pdev)
 		return PTR_ERR(pctrl->regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get interrupt number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	pctrl->pctldesc = chv_pinctrl_desc;
 	pctrl->pctldesc.name = dev_name(&pdev->dev);
diff --git a/drivers/pinctrl/intel/pinctrl-intel.c b/drivers/pinctrl/intel/pinctrl-intel.c
index a18d6eefe672..0487e8dc7654 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1354,10 +1354,8 @@ static int intel_pinctrl_probe(struct platform_device *pdev,
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get interrupt number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = intel_pinctrl_pm_init(pctrl);
 	if (ret)
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 9b9c61e3f065..60d88e1df272 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -861,10 +861,8 @@ static int amd_gpio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	irq_base = platform_get_irq(pdev, 0);
-	if (irq_base < 0) {
-		dev_err(&pdev->dev, "Failed to get gpio IRQ: %d\n", irq_base);
+	if (irq_base < 0)
 		return irq_base;
-	}
 
 #ifdef CONFIG_PM_SLEEP
 	gpio_dev->saved_regs = devm_kcalloc(&pdev->dev, amd_pinctrl_desc.npins,
diff --git a/drivers/pinctrl/pinctrl-oxnas.c b/drivers/pinctrl/pinctrl-oxnas.c
index b4edbe0d9a73..4f6a196a663a 100644
--- a/drivers/pinctrl/pinctrl-oxnas.c
+++ b/drivers/pinctrl/pinctrl-oxnas.c
@@ -1229,10 +1229,8 @@ static int oxnas_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(bank->reg_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "irq get failed\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	bank->id = id;
 	bank->gpio_chip.parent = &pdev->dev;
diff --git a/drivers/pinctrl/pinctrl-pic32.c b/drivers/pinctrl/pinctrl-pic32.c
index 6dc98e22f9f5..e7f6dd5ab578 100644
--- a/drivers/pinctrl/pinctrl-pic32.c
+++ b/drivers/pinctrl/pinctrl-pic32.c
@@ -2222,10 +2222,8 @@ static int pic32_gpio_probe(struct platform_device *pdev)
 		return PTR_ERR(bank->reg_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "irq get failed\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	bank->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(bank->clk)) {
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
index d3332da35637..5735ef5a71d5 100644
--- a/drivers/pinctrl/pinctrl-stmfx.c
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -608,10 +608,8 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(pctl->dev, "failed to get irq\n");
+	if (irq <= 0)
 		return -ENXIO;
-	}
 
 	mutex_init(&pctl->lock);
 
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7f35c196bb3e..45975ed31205 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1160,10 +1160,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 	msm_pinctrl_setup_pm_reset(pctrl);
 
 	pctrl->irq = platform_get_irq(pdev, 0);
-	if (pctrl->irq < 0) {
-		dev_err(&pdev->dev, "No interrupt defined for msmgpio\n");
+	if (pctrl->irq < 0)
 		return pctrl->irq;
-	}
 
 	pctrl->desc.owner = THIS_MODULE;
 	pctrl->desc.pctlops = &msm_pinctrl_ops;
diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
index 076ba085a6a1..3d8b1d74fa2f 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-mpp.c
@@ -791,11 +791,8 @@ static int pm8xxx_mpp_probe(struct platform_device *pdev)
 	for (i = 0; i < pctrl->desc.npins; i++) {
 		pin_data[i].reg = SSBI_REG_ADDR_MPP(i);
 		pin_data[i].irq = platform_get_irq(pdev, i);
-		if (pin_data[i].irq < 0) {
-			dev_err(&pdev->dev,
-				"missing interrupts for pin %d\n", i);
+		if (pin_data[i].irq < 0)
 			return pin_data[i].irq;
-		}
 
 		ret = pm8xxx_pin_populate(pctrl, &pin_data[i]);
 		if (ret)
diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index f85a1b9d129b..706207d192ae 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -642,11 +642,8 @@ static int mlxreg_hotplug_probe(struct platform_device *pdev)
 		priv->irq = pdata->irq;
 	} else {
 		priv->irq = platform_get_irq(pdev, 0);
-		if (priv->irq < 0) {
-			dev_err(&pdev->dev, "Failed to get platform irq: %d\n",
-				priv->irq);
+		if (priv->irq < 0)
 			return priv->irq;
-		}
 	}
 
 	priv->regmap = pdata->regmap;
diff --git a/drivers/platform/x86/intel_bxtwc_tmu.c b/drivers/platform/x86/intel_bxtwc_tmu.c
index 951c105bafc1..7ccf583649e6 100644
--- a/drivers/platform/x86/intel_bxtwc_tmu.c
+++ b/drivers/platform/x86/intel_bxtwc_tmu.c
@@ -60,11 +60,8 @@ static int bxt_wcove_tmu_probe(struct platform_device *pdev)
 	wctmu->regmap = pmic->regmap;
 
 	irq = platform_get_irq(pdev, 0);
-
-	if (irq < 0) {
-		dev_err(&pdev->dev, "invalid irq %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	regmap_irq_chip = pmic->irq_chip_data_tmu;
 	virq = regmap_irq_get_virq(regmap_irq_chip, irq);
diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
index d9542c661ddc..4f3f30152a27 100644
--- a/drivers/platform/x86/intel_int0002_vgpio.c
+++ b/drivers/platform/x86/intel_int0002_vgpio.c
@@ -166,10 +166,8 @@ static int int0002_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Error getting IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 55037ff258f8..5c1da2bb1435 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -936,10 +936,8 @@ static int ipc_plat_probe(struct platform_device *pdev)
 	spin_lock_init(&ipcdev.gcr_lock);
 
 	ipcdev.irq = platform_get_irq(pdev, 0);
-	if (ipcdev.irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq\n");
+	if (ipcdev.irq < 0)
 		return -EINVAL;
-	}
 
 	ret = ipc_plat_get_res(pdev);
 	if (ret) {
diff --git a/drivers/power/supply/88pm860x_battery.c b/drivers/power/supply/88pm860x_battery.c
index 5ca047b3f58f..1308f3a185f3 100644
--- a/drivers/power/supply/88pm860x_battery.c
+++ b/drivers/power/supply/88pm860x_battery.c
@@ -919,16 +919,12 @@ static int pm860x_battery_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	info->irq_cc = platform_get_irq(pdev, 0);
-	if (info->irq_cc <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (info->irq_cc <= 0)
 		return -EINVAL;
-	}
 
 	info->irq_batt = platform_get_irq(pdev, 1);
-	if (info->irq_batt <= 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (info->irq_batt <= 0)
 		return -EINVAL;
-	}
 
 	info->chip = chip;
 	info->i2c =
diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
index 1bbba6bba673..cb14d41b53e9 100644
--- a/drivers/power/supply/axp288_charger.c
+++ b/drivers/power/supply/axp288_charger.c
@@ -825,10 +825,8 @@ static int axp288_charger_probe(struct platform_device *pdev)
 	/* Register charger interrupts */
 	for (i = 0; i < CHRG_INTR_END; i++) {
 		pirq = platform_get_irq(info->pdev, i);
-		if (pirq < 0) {
-			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
+		if (pirq < 0)
 			return pirq;
-		}
 		info->irq[i] = regmap_irq_get_virq(info->regmap_irqc, pirq);
 		if (info->irq[i] < 0) {
 			dev_warn(&info->pdev->dev,
diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index 1bb32b7226d7..0d456fd28b21 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -168,11 +168,8 @@ static int bd70528_get_irqs(struct platform_device *pdev,
 
 	for (i = 0; i < ARRAY_SIZE(bd70528_chg_irqs); i++) {
 		irq = platform_get_irq_byname(pdev, bd70528_chg_irqs[i].n);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "Bad IRQ information for %s (%d)\n",
-				bd70528_chg_irqs[i].n, irq);
+		if (irq < 0)
 			return irq;
-		}
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						bd70528_chg_irqs[i].h,
 						IRQF_ONESHOT,
diff --git a/drivers/power/supply/da9150-charger.c b/drivers/power/supply/da9150-charger.c
index f9314cc0cd75..a9c1af2706ab 100644
--- a/drivers/power/supply/da9150-charger.c
+++ b/drivers/power/supply/da9150-charger.c
@@ -466,10 +466,8 @@ static int da9150_charger_register_irq(struct platform_device *pdev,
 	int irq, ret;
 
 	irq = platform_get_irq_byname(pdev, irq_name);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, irq_name,
 				   charger);
@@ -487,10 +485,8 @@ static void da9150_charger_unregister_irq(struct platform_device *pdev,
 	int irq;
 
 	irq = platform_get_irq_byname(pdev, irq_name);
-	if (irq < 0) {
-		dev_err(dev, "Failed to get IRQ CHG_STATUS: %d\n", irq);
+	if (irq < 0)
 		return;
-	}
 
 	free_irq(irq, charger);
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
index c2644a9fe80f..427347ce3841 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -221,10 +221,8 @@ static int goldfish_battery_probe(struct platform_device *pdev)
 	}
 
 	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
+	if (data->irq < 0)
 		return -ENODEV;
-	}
 
 	ret = devm_request_irq(&pdev->dev, data->irq,
 			       goldfish_battery_interrupt,
diff --git a/drivers/power/supply/jz4740-battery.c b/drivers/power/supply/jz4740-battery.c
index 6366bd61ea9f..517265ad3d70 100644
--- a/drivers/power/supply/jz4740-battery.c
+++ b/drivers/power/supply/jz4740-battery.c
@@ -258,10 +258,8 @@ static int jz_battery_probe(struct platform_device *pdev)
 	jz_battery->cell = mfd_get_cell(pdev);
 
 	jz_battery->irq = platform_get_irq(pdev, 0);
-	if (jz_battery->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq: %d\n", ret);
+	if (jz_battery->irq < 0)
 		return jz_battery->irq;
-	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
diff --git a/drivers/power/supply/qcom_smbb.c b/drivers/power/supply/qcom_smbb.c
index c890e1cec720..84cc9fba029d 100644
--- a/drivers/power/supply/qcom_smbb.c
+++ b/drivers/power/supply/qcom_smbb.c
@@ -929,11 +929,8 @@ static int smbb_charger_probe(struct platform_device *pdev)
 		int irq;
 
 		irq = platform_get_irq_byname(pdev, smbb_charger_irqs[i].name);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "failed to get irq '%s'\n",
-				smbb_charger_irqs[i].name);
+		if (irq < 0)
 			return irq;
-		}
 
 		smbb_charger_irqs[i].handler(irq, chg);
 
diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index 24895cc3b41e..04b9e8bb981f 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -1030,10 +1030,8 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource specified\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(data->dev, irq, NULL,
 					sc27xx_fgu_interrupt,
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 20450e34ad57..1508616d794c 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -564,10 +564,8 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pc->regmap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to obtain IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sti_pwm_interrupt, 0,
 			       pdev->name, pc);
diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 2ffc64622451..56f3f72d7707 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -1032,10 +1032,8 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
+	if (irq < 0)
 		return irq;
-	}
 	regulators->irq_ldo_lim = irq;
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index 02f816318fba..28b1b20f45bd 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -863,10 +863,8 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 
 	/* LDOs overcurrent event support */
 	irq = platform_get_irq_byname(pdev, "LDO_LIM");
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ.\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 				NULL, da9063_ldo_lim_event,
diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b2c7af323ed1..98e0be9476a4 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -249,10 +249,8 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 	int ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "platform_get_irq(pdev, 0) error: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	irq_data = irq_get_irq_data(irq);
 	if (!irq_data) {
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
index 0d33e3079f0d..cb0f4a0be032 100644
--- a/drivers/remoteproc/qcom_q6v5.c
+++ b/drivers/remoteproc/qcom_q6v5.c
@@ -187,13 +187,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	init_completion(&q6v5->stop_done);
 
 	q6v5->wdog_irq = platform_get_irq_byname(pdev, "wdog");
-	if (q6v5->wdog_irq < 0) {
-		if (q6v5->wdog_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve wdog IRQ: %d\n",
-				q6v5->wdog_irq);
+	if (q6v5->wdog_irq < 0)
 		return q6v5->wdog_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
 					NULL, q6v5_wdog_interrupt,
@@ -205,13 +200,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->fatal_irq = platform_get_irq_byname(pdev, "fatal");
-	if (q6v5->fatal_irq < 0) {
-		if (q6v5->fatal_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve fatal IRQ: %d\n",
-				q6v5->fatal_irq);
+	if (q6v5->fatal_irq < 0)
 		return q6v5->fatal_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->fatal_irq,
 					NULL, q6v5_fatal_interrupt,
@@ -223,13 +213,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->ready_irq = platform_get_irq_byname(pdev, "ready");
-	if (q6v5->ready_irq < 0) {
-		if (q6v5->ready_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve ready IRQ: %d\n",
-				q6v5->ready_irq);
+	if (q6v5->ready_irq < 0)
 		return q6v5->ready_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->ready_irq,
 					NULL, q6v5_ready_interrupt,
@@ -241,13 +226,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	}
 
 	q6v5->handover_irq = platform_get_irq_byname(pdev, "handover");
-	if (q6v5->handover_irq < 0) {
-		if (q6v5->handover_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve handover IRQ: %d\n",
-				q6v5->handover_irq);
+	if (q6v5->handover_irq < 0)
 		return q6v5->handover_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->handover_irq,
 					NULL, q6v5_handover_interrupt,
@@ -260,13 +240,8 @@ int qcom_q6v5_init(struct qcom_q6v5 *q6v5, struct platform_device *pdev,
 	disable_irq(q6v5->handover_irq);
 
 	q6v5->stop_irq = platform_get_irq_byname(pdev, "stop-ack");
-	if (q6v5->stop_irq < 0) {
-		if (q6v5->stop_irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev,
-				"failed to retrieve stop-ack IRQ: %d\n",
-				q6v5->stop_irq);
+	if (q6v5->stop_irq < 0)
 		return q6v5->stop_irq;
-	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, q6v5->stop_irq,
 					NULL, q6v5_stop_interrupt,
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
index 434285f495e0..4743b16a8d84 100644
--- a/drivers/rtc/rtc-88pm860x.c
+++ b/drivers/rtc/rtc-88pm860x.c
@@ -328,10 +328,8 @@ static int pm860x_rtc_probe(struct platform_device *pdev)
 	if (!info)
 		return -ENOMEM;
 	info->irq = platform_get_irq(pdev, 0);
-	if (info->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource!\n");
+	if (info->irq < 0)
 		return info->irq;
-	}
 
 	info->chip = chip;
 	info->i2c = (chip->id == CHIP_PM8607) ? chip->client : chip->companion;
diff --git a/drivers/rtc/rtc-ac100.c b/drivers/rtc/rtc-ac100.c
index 2e5a8b15b222..a4dcf2950396 100644
--- a/drivers/rtc/rtc-ac100.c
+++ b/drivers/rtc/rtc-ac100.c
@@ -578,10 +578,8 @@ static int ac100_rtc_probe(struct platform_device *pdev)
 	chip->regmap = ac100->regmap;
 
 	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (chip->irq < 0)
 		return chip->irq;
-	}
 
 	chip->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(chip->rtc))
diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
index 19d6980e90fb..8e8b8079b60a 100644
--- a/drivers/rtc/rtc-armada38x.c
+++ b/drivers/rtc/rtc-armada38x.c
@@ -530,11 +530,8 @@ static __init int armada38x_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(rtc->regs_soc);
 
 	rtc->irq = platform_get_irq(pdev, 0);
-
-	if (rtc->irq < 0) {
-		dev_err(&pdev->dev, "no irq\n");
+	if (rtc->irq < 0)
 		return rtc->irq;
-	}
 
 	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc_dev))
diff --git a/drivers/rtc/rtc-asm9260.c b/drivers/rtc/rtc-asm9260.c
index d45a44936308..10413d803caa 100644
--- a/drivers/rtc/rtc-asm9260.c
+++ b/drivers/rtc/rtc-asm9260.c
@@ -257,10 +257,8 @@ static int asm9260_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, priv);
 
 	irq_alarm = platform_get_irq(pdev, 0);
-	if (irq_alarm < 0) {
-		dev_err(dev, "No alarm IRQ resource defined\n");
+	if (irq_alarm < 0)
 		return irq_alarm;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->iobase = devm_ioremap_resource(dev, res);
diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 82a54e93ff04..d119c6e6353e 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -378,10 +378,8 @@ static int __init at91_rtc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource defined\n");
+	if (irq < 0)
 		return -ENXIO;
-	}
 
 	at91_rtc_regs = devm_ioremap(&pdev->dev, regs->start,
 				     resource_size(regs));
diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 4daf3789b978..bb3ba7bfe6a5 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -342,10 +342,8 @@ static int at91_rtc_probe(struct platform_device *pdev)
 	struct of_phandle_args args;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get interrupt resource\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
diff --git a/drivers/rtc/rtc-bd70528.c b/drivers/rtc/rtc-bd70528.c
index f9bdd555e1a2..3e745c05bc22 100644
--- a/drivers/rtc/rtc-bd70528.c
+++ b/drivers/rtc/rtc-bd70528.c
@@ -416,11 +416,8 @@ static int bd70528_probe(struct platform_device *pdev)
 	bd_rtc->dev = &pdev->dev;
 
 	irq = platform_get_irq_byname(pdev, "bd70528-rtc-alm");
-
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	platform_set_drvdata(pdev, bd_rtc);
 
diff --git a/drivers/rtc/rtc-davinci.c b/drivers/rtc/rtc-davinci.c
index fcb71bf4d492..d8e0db2e7fc6 100644
--- a/drivers/rtc/rtc-davinci.c
+++ b/drivers/rtc/rtc-davinci.c
@@ -477,10 +477,8 @@ static int __init davinci_rtc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	davinci_rtc->irq = platform_get_irq(pdev, 0);
-	if (davinci_rtc->irq < 0) {
-		dev_err(dev, "no RTC irq\n");
+	if (davinci_rtc->irq < 0)
 		return davinci_rtc->irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	davinci_rtc->base = devm_ioremap_resource(dev, res);
diff --git a/drivers/rtc/rtc-jz4740.c b/drivers/rtc/rtc-jz4740.c
index 9e7b3a04debc..3ec6bb230cd5 100644
--- a/drivers/rtc/rtc-jz4740.c
+++ b/drivers/rtc/rtc-jz4740.c
@@ -323,10 +323,8 @@ static int jz4740_rtc_probe(struct platform_device *pdev)
 		rtc->type = id->driver_data;
 
 	rtc->irq = platform_get_irq(pdev, 0);
-	if (rtc->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get platform irq\n");
+	if (rtc->irq < 0)
 		return -ENOENT;
-	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rtc->base = devm_ioremap_resource(&pdev->dev, mem);
diff --git a/drivers/rtc/rtc-max77686.c b/drivers/rtc/rtc-max77686.c
index 4aff349ae301..a6135d8258d9 100644
--- a/drivers/rtc/rtc-max77686.c
+++ b/drivers/rtc/rtc-max77686.c
@@ -673,11 +673,8 @@ static int max77686_init_rtc_regmap(struct max77686_rtc_info *info)
 		struct platform_device *pdev = to_platform_device(info->dev);
 
 		info->rtc_irq = platform_get_irq(pdev, 0);
-		if (info->rtc_irq < 0) {
-			dev_err(info->dev, "Failed to get rtc interrupts: %d\n",
-				info->rtc_irq);
+		if (info->rtc_irq < 0)
 			return info->rtc_irq;
-		}
 	} else {
 		info->rtc_irq =  parent_i2c->irq;
 	}
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
index 1c4de6e90da0..17653ed52ebb 100644
--- a/drivers/rtc/rtc-pic32.c
+++ b/drivers/rtc/rtc-pic32.c
@@ -308,10 +308,8 @@ static int pic32_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pdata);
 
 	pdata->alarm_irq = platform_get_irq(pdev, 0);
-	if (pdata->alarm_irq < 0) {
-		dev_err(&pdev->dev, "no irq for alarm\n");
+	if (pdata->alarm_irq < 0)
 		return pdata->alarm_irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pdata->reg_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
index 9f9839c47e2f..f5a30e0f16c2 100644
--- a/drivers/rtc/rtc-pm8xxx.c
+++ b/drivers/rtc/rtc-pm8xxx.c
@@ -468,10 +468,8 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc_dd->rtc_alarm_irq = platform_get_irq(pdev, 0);
-	if (rtc_dd->rtc_alarm_irq < 0) {
-		dev_err(&pdev->dev, "Alarm IRQ resource absent!\n");
+	if (rtc_dd->rtc_alarm_irq < 0)
 		return -ENXIO;
-	}
 
 	rtc_dd->allow_set_time = of_property_read_bool(pdev->dev.of_node,
 						      "allow-set-time");
diff --git a/drivers/rtc/rtc-puv3.c b/drivers/rtc/rtc-puv3.c
index 63b9e73fb97d..56a7cf1547a7 100644
--- a/drivers/rtc/rtc-puv3.c
+++ b/drivers/rtc/rtc-puv3.c
@@ -186,16 +186,12 @@ static int puv3_rtc_probe(struct platform_device *pdev)
 
 	/* find the IRQs */
 	puv3_rtc_tickno = platform_get_irq(pdev, 1);
-	if (puv3_rtc_tickno < 0) {
-		dev_err(&pdev->dev, "no irq for rtc tick\n");
+	if (puv3_rtc_tickno < 0)
 		return -ENOENT;
-	}
 
 	puv3_rtc_alarmno = platform_get_irq(pdev, 0);
-	if (puv3_rtc_alarmno < 0) {
-		dev_err(&pdev->dev, "no irq for alarm\n");
+	if (puv3_rtc_alarmno < 0)
 		return -ENOENT;
-	}
 
 	dev_dbg(&pdev->dev, "PKUnity_rtc: tick irq %d, alarm irq %d\n",
 		 puv3_rtc_tickno, puv3_rtc_alarmno);
diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
index a7827fe7fb7b..d2f1d8f754bf 100644
--- a/drivers/rtc/rtc-pxa.c
+++ b/drivers/rtc/rtc-pxa.c
@@ -324,15 +324,11 @@ static int __init pxa_rtc_probe(struct platform_device *pdev)
 	}
 
 	sa1100_rtc->irq_1hz = platform_get_irq(pdev, 0);
-	if (sa1100_rtc->irq_1hz < 0) {
-		dev_err(dev, "No 1Hz IRQ resource defined\n");
+	if (sa1100_rtc->irq_1hz < 0)
 		return -ENXIO;
-	}
 	sa1100_rtc->irq_alarm = platform_get_irq(pdev, 1);
-	if (sa1100_rtc->irq_alarm < 0) {
-		dev_err(dev, "No alarm IRQ resource defined\n");
+	if (sa1100_rtc->irq_alarm < 0)
 		return -ENXIO;
-	}
 
 	pxa_rtc->base = devm_ioremap(dev, pxa_rtc->ress->start,
 				resource_size(pxa_rtc->ress));
diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index c34540baa12a..c0334c602e88 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -434,12 +434,8 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 	rk808_rtc->rtc->ops = &rk808_rtc_ops;
 
 	rk808_rtc->irq = platform_get_irq(pdev, 0);
-	if (rk808_rtc->irq < 0) {
-		if (rk808_rtc->irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Wake up is not possible as irq = %d\n",
-				rk808_rtc->irq);
+	if (rk808_rtc->irq < 0)
 		return rk808_rtc->irq;
-	}
 
 	/* request alarm irq of rk808 */
 	ret = devm_request_threaded_irq(&pdev->dev, rk808_rtc->irq, NULL,
diff --git a/drivers/rtc/rtc-s3c.c b/drivers/rtc/rtc-s3c.c
index 74bf6473a05d..7801249c254b 100644
--- a/drivers/rtc/rtc-s3c.c
+++ b/drivers/rtc/rtc-s3c.c
@@ -453,10 +453,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 
 	/* find the IRQs */
 	info->irq_tick = platform_get_irq(pdev, 1);
-	if (info->irq_tick < 0) {
-		dev_err(&pdev->dev, "no irq for rtc tick\n");
+	if (info->irq_tick < 0)
 		return info->irq_tick;
-	}
 
 	info->dev = &pdev->dev;
 	info->data = of_device_get_match_data(&pdev->dev);
@@ -470,10 +468,8 @@ static int s3c_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, info);
 
 	info->irq_alarm = platform_get_irq(pdev, 0);
-	if (info->irq_alarm < 0) {
-		dev_err(&pdev->dev, "no irq for alarm\n");
+	if (info->irq_alarm < 0)
 		return info->irq_alarm;
-	}
 
 	dev_dbg(&pdev->dev, "s3c2410_rtc: tick irq %d, alarm irq %d\n",
 		info->irq_tick, info->irq_alarm);
diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index b4eb3b3c6c2c..698e1e51efca 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -614,10 +614,8 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->irq = platform_get_irq(pdev, 0);
-	if (rtc->irq < 0) {
-		dev_err(&pdev->dev, "failed to get RTC irq number\n");
+	if (rtc->irq < 0)
 		return rtc->irq;
-	}
 
 	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc))
diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index 0567944fd4f8..9f23b24f466c 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -358,10 +358,8 @@ static int spear_rtc_probe(struct platform_device *pdev)
 
 	/* alarm irqs */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no update irq?\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	status = devm_request_irq(&pdev->dev, irq, spear_rtc_irq, 0, pdev->name,
 			config);
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
index c0e75c373605..dbd676db431e 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -610,10 +610,8 @@ static int sun6i_rtc_probe(struct platform_device *pdev)
 	chip->dev = &pdev->dev;
 
 	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (chip->irq < 0)
 		return chip->irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, chip->irq, sun6i_rtc_alarmirq,
 			       0, dev_name(&pdev->dev), chip);
diff --git a/drivers/rtc/rtc-sunxi.c b/drivers/rtc/rtc-sunxi.c
index 6eeabb81106f..0bb69a7f9e46 100644
--- a/drivers/rtc/rtc-sunxi.c
+++ b/drivers/rtc/rtc-sunxi.c
@@ -442,10 +442,8 @@ static int sunxi_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(chip->base);
 
 	chip->irq = platform_get_irq(pdev, 0);
-	if (chip->irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (chip->irq < 0)
 		return chip->irq;
-	}
 	ret = devm_request_irq(&pdev->dev, chip->irq, sunxi_rtc_alarmirq,
 			0, dev_name(&pdev->dev), chip);
 	if (ret) {
diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
index 8fa1b3febf69..14bf835229e6 100644
--- a/drivers/rtc/rtc-tegra.c
+++ b/drivers/rtc/rtc-tegra.c
@@ -290,10 +290,8 @@ static int tegra_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(info->base);
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
-		dev_err(&pdev->dev, "failed to get platform IRQ: %d\n", ret);
+	if (ret <= 0)
 		return ret;
-	}
 
 	info->irq = ret;
 
diff --git a/drivers/rtc/rtc-vt8500.c b/drivers/rtc/rtc-vt8500.c
index f59d232810de..d5d14cf86e0d 100644
--- a/drivers/rtc/rtc-vt8500.c
+++ b/drivers/rtc/rtc-vt8500.c
@@ -212,10 +212,8 @@ static int vt8500_rtc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, vt8500_rtc);
 
 	vt8500_rtc->irq_alarm = platform_get_irq(pdev, 0);
-	if (vt8500_rtc->irq_alarm < 0) {
-		dev_err(&pdev->dev, "No alarm IRQ resource defined\n");
+	if (vt8500_rtc->irq_alarm < 0)
 		return vt8500_rtc->irq_alarm;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	vt8500_rtc->regbase = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/rtc/rtc-xgene.c b/drivers/rtc/rtc-xgene.c
index 9888383f0088..9683fbf7c78d 100644
--- a/drivers/rtc/rtc-xgene.c
+++ b/drivers/rtc/rtc-xgene.c
@@ -157,10 +157,8 @@ static int xgene_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(pdata->rtc);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "No IRQ resource\n");
+	if (irq < 0)
 		return irq;
-	}
 	ret = devm_request_irq(&pdev->dev, irq, xgene_rtc_interrupt, 0,
 			       dev_name(&pdev->dev), pdata);
 	if (ret) {
diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 00639594de0c..2c762757fb54 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -218,10 +218,8 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 		return PTR_ERR(xrtcdev->reg_base);
 
 	xrtcdev->alarm_irq = platform_get_irq_byname(pdev, "alarm");
-	if (xrtcdev->alarm_irq < 0) {
-		dev_err(&pdev->dev, "no irq resource\n");
+	if (xrtcdev->alarm_irq < 0)
 		return xrtcdev->alarm_irq;
-	}
 	ret = devm_request_irq(&pdev->dev, xrtcdev->alarm_irq,
 			       xlnx_rtc_interrupt, 0,
 			       dev_name(&pdev->dev), xrtcdev);
@@ -231,10 +229,8 @@ static int xlnx_rtc_probe(struct platform_device *pdev)
 	}
 
 	xrtcdev->sec_irq = platform_get_irq_byname(pdev, "sec");
-	if (xrtcdev->sec_irq < 0) {
-		dev_err(&pdev->dev, "no irq resource\n");
+	if (xrtcdev->sec_irq < 0)
 		return xrtcdev->sec_irq;
-	}
 	ret = devm_request_irq(&pdev->dev, xrtcdev->sec_irq,
 			       xlnx_rtc_interrupt, 0,
 			       dev_name(&pdev->dev), xrtcdev);
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
index cf4f10d6f590..e4ef35abb508 100644
--- a/drivers/soc/fsl/qbman/bman_portal.c
+++ b/drivers/soc/fsl/qbman/bman_portal.c
@@ -135,10 +135,8 @@ static int bman_portal_probe(struct platform_device *pdev)
 	pcfg->cpu = -1;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Can't get %pOF IRQ'\n", node);
+	if (irq <= 0)
 		goto err_ioremap1;
-	}
 	pcfg->irq = irq;
 
 	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index e2186b681d87..991c35a72e00 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -275,10 +275,8 @@ static int qman_portal_probe(struct platform_device *pdev)
 	pcfg->channel = val;
 	pcfg->cpu = -1;
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "Can't get %pOF IRQ\n", node);
+	if (irq <= 0)
 		goto err_ioremap1;
-	}
 	pcfg->irq = irq;
 
 	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index c7300d54e444..07183d731d74 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -474,10 +474,8 @@ static int qcom_smp2p_probe(struct platform_device *pdev)
 		goto report_read_failure;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to acquire smp2p interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	smp2p->mbox_client.dev = &pdev->dev;
 	smp2p->mbox_client.knows_txdone = true;
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
index 9a06ffdb73b8..373cb53579e0 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -338,10 +338,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	u32 reg, rate, num_cs = HSSPI_SPI_MAX_CS;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res_mem);
diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index df1c94a131e6..fdd7eaa0b8ed 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -520,10 +520,8 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no irq: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	clk = devm_clk_get(dev, "spi");
 	if (IS_ERR(clk)) {
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
index 18c06568805e..e6e1b9818c4d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -158,10 +158,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	}
 
 	dws->irq = platform_get_irq(pdev, 0);
-	if (dws->irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (dws->irq < 0)
 		return dws->irq; /* -ENXIO */
-	}
 
 	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dwsmmio->clk))
diff --git a/drivers/spi/spi-efm32.c b/drivers/spi/spi-efm32.c
index eb1f2142a335..64d4c441b641 100644
--- a/drivers/spi/spi-efm32.c
+++ b/drivers/spi/spi-efm32.c
@@ -400,10 +400,8 @@ static int efm32_spi_probe(struct platform_device *pdev)
 	}
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
-		dev_err(&pdev->dev, "failed to get rx irq (%d)\n", ret);
+	if (ret <= 0)
 		goto err;
-	}
 
 	ddata->rxirq = ret;
 
diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index 4034e3ec0ba2..4e1ccd4e52b6 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -656,10 +656,8 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resources\n");
+	if (irq < 0)
 		return -EBUSY;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
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
index 41a49b93ca60..443d4c1196c2 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -860,10 +860,8 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get the irq: %d\n", ret);
+	if (ret < 0)
 		goto err_disable_clk;
-	}
 
 	ret = devm_request_irq(dev, ret,
 			fsl_qspi_irq_handler, 0, pdev->name, q);
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 5f0b0d5bfef4..242b6c86cf12 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -539,10 +539,8 @@ static int spi_geni_probe(struct platform_device *pdev)
 	struct clk *clk;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Err getting IRQ %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 8f01858c0ae6..9dfe8b04e688 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -819,22 +819,16 @@ static int lantiq_ssc_probe(struct platform_device *pdev)
 	}
 
 	rx_irq = platform_get_irq_byname(pdev, LTQ_SPI_RX_IRQ_NAME);
-	if (rx_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_RX_IRQ_NAME);
+	if (rx_irq < 0)
 		return -ENXIO;
-	}
 
 	tx_irq = platform_get_irq_byname(pdev, LTQ_SPI_TX_IRQ_NAME);
-	if (tx_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_TX_IRQ_NAME);
+	if (tx_irq < 0)
 		return -ENXIO;
-	}
 
 	err_irq = platform_get_irq_byname(pdev, LTQ_SPI_ERR_IRQ_NAME);
-	if (err_irq < 0) {
-		dev_err(dev, "failed to get %s\n", LTQ_SPI_ERR_IRQ_NAME);
+	if (err_irq < 0)
 		return -ENXIO;
-	}
 
 	master = spi_alloc_master(dev, sizeof(struct lantiq_ssc_spi));
 	if (!master)
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
index 8894f98cc99c..501b923f2c27 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1007,10 +1007,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "failed to get the irq: %d\n", ret);
+	if (ret < 0)
 		goto err_disable_clk;
-	}
 
 	ret = devm_request_irq(dev, ret,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
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
index 10cebeaa1e6b..69f517ec59c6 100644
--- a/drivers/spi/spi-pic32.c
+++ b/drivers/spi/spi-pic32.c
@@ -711,22 +711,16 @@ static int pic32_spi_hw_probe(struct platform_device *pdev,
 
 	/* get irq resources: err-irq, rx-irq, tx-irq */
 	pic32s->fault_irq = platform_get_irq_byname(pdev, "fault");
-	if (pic32s->fault_irq < 0) {
-		dev_err(&pdev->dev, "fault-irq not found\n");
+	if (pic32s->fault_irq < 0)
 		return pic32s->fault_irq;
-	}
 
 	pic32s->rx_irq = platform_get_irq_byname(pdev, "rx");
-	if (pic32s->rx_irq < 0) {
-		dev_err(&pdev->dev, "rx-irq not found\n");
+	if (pic32s->rx_irq < 0)
 		return pic32s->rx_irq;
-	}
 
 	pic32s->tx_irq = platform_get_irq_byname(pdev, "tx");
-	if (pic32s->tx_irq < 0) {
-		dev_err(&pdev->dev, "tx-irq not found\n");
+	if (pic32s->tx_irq < 0)
 		return pic32s->tx_irq;
-	}
 
 	/* get clock */
 	pic32s->clk = devm_clk_get(&pdev->dev, "mck0");
diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
index e0f061139c8f..a0ad73f1cc01 100644
--- a/drivers/spi/spi-qcom-qspi.c
+++ b/drivers/spi/spi-qcom-qspi.c
@@ -454,10 +454,8 @@ static int qcom_qspi_probe(struct platform_device *pdev)
 		goto exit_probe_master_put;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "Failed to get irq %d\n", ret);
+	if (ret < 0)
 		goto exit_probe_master_put;
-	}
 	ret = devm_request_irq(dev, ret, qcom_qspi_irq,
 			IRQF_TRIGGER_HIGH, dev_name(dev), ctrl);
 	if (ret) {
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
index f1ee58208216..20bdae5fdf3b 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -437,10 +437,8 @@ static int spi_sh_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq error: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct spi_sh_data));
 	if (master == NULL) {
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
index 1b7eebb72c07..8c9021b7f7a9 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -843,10 +843,8 @@ static int sprd_spi_irq_init(struct platform_device *pdev, struct sprd_spi *ss)
 	int ret;
 
 	ss->irq = platform_get_irq(pdev, 0);
-	if (ss->irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
+	if (ss->irq < 0)
 		return ss->irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, ss->irq, sprd_spi_handle_irq,
 				0, pdev->name, ss);
diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 655e4afbfb2a..9ac6f9fe13cf 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -570,11 +570,8 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "IRQ error missing or invalid\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, stm32_qspi_irq, 0,
 			       dev_name(dev), qspi);
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
index 1dc479fab98c..4eb5bc9250fc 100644
--- a/drivers/spi/spi-xlp.c
+++ b/drivers/spi/spi-xlp.c
@@ -384,10 +384,8 @@ static int xlp_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(xspi->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ resource found: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	err = devm_request_irq(&pdev->dev, irq, xlp_spi_interrupt, 0,
 			pdev->name, xspi);
 	if (err) {
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
index 4f3c2c13a225..489cde4e915e 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -3094,10 +3094,8 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
 		return PTR_ERR(mmio_base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	status = devm_request_irq(&pdev->dev, irq, _nbu2ss_udc_irq,
 				  0, driver_name, udc);
 
diff --git a/drivers/staging/goldfish/goldfish_audio.c b/drivers/staging/goldfish/goldfish_audio.c
index 24a738238f9f..0c65a0121dde 100644
--- a/drivers/staging/goldfish/goldfish_audio.c
+++ b/drivers/staging/goldfish/goldfish_audio.c
@@ -302,10 +302,8 @@ static int goldfish_audio_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	data->irq = platform_get_irq(pdev, 0);
-	if (data->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed\n");
+	if (data->irq < 0)
 		return -ENODEV;
-	}
 	data->buffer_virt = dmam_alloc_coherent(&pdev->dev,
 						COMBINED_BUFFER_SIZE,
 						&buf_addr, GFP_KERNEL);
diff --git a/drivers/staging/media/allegro-dvt/allegro-core.c b/drivers/staging/media/allegro-dvt/allegro-core.c
index f050c7347fd5..6f0cd0784786 100644
--- a/drivers/staging/media/allegro-dvt/allegro-core.c
+++ b/drivers/staging/media/allegro-dvt/allegro-core.c
@@ -2947,10 +2947,8 @@ static int allegro_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq resource\n");
+	if (irq < 0)
 		return irq;
-	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq,
 					allegro_hardirq,
 					allegro_irq_thread,
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index c3665f0e87a2..4a7afad2af92 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -733,10 +733,8 @@ static int hantro_probe(struct platform_device *pdev)
 			continue;
 
 		irq = platform_get_irq_byname(vpu->pdev, irq_name);
-		if (irq <= 0) {
-			dev_err(vpu->dev, "Could not get %s IRQ.\n", irq_name);
+		if (irq <= 0)
 			return -ENXIO;
-		}
 
 		ret = devm_request_irq(vpu->dev, irq,
 				       vpu->variant->irqs[i].handler, 0,
diff --git a/drivers/staging/media/imx/imx7-media-csi.c b/drivers/staging/media/imx/imx7-media-csi.c
index 500b4c08d967..d7d38dd9f168 100644
--- a/drivers/staging/media/imx/imx7-media-csi.c
+++ b/drivers/staging/media/imx/imx7-media-csi.c
@@ -1194,10 +1194,8 @@ static int imx7_csi_probe(struct platform_device *pdev)
 	}
 
 	csi->irq = platform_get_irq(pdev, 0);
-	if (csi->irq < 0) {
-		dev_err(dev, "Missing platform resources data\n");
+	if (csi->irq < 0)
 		return csi->irq;
-	}
 
 	csi->regbase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(csi->regbase))
diff --git a/drivers/staging/media/imx/imx7-mipi-csis.c b/drivers/staging/media/imx/imx7-mipi-csis.c
index d1cdf011c8f1..73d8354e618c 100644
--- a/drivers/staging/media/imx/imx7-mipi-csis.c
+++ b/drivers/staging/media/imx/imx7-mipi-csis.c
@@ -975,10 +975,8 @@ static int mipi_csis_probe(struct platform_device *pdev)
 		return PTR_ERR(state->regs);
 
 	state->irq = platform_get_irq(pdev, 0);
-	if (state->irq < 0) {
-		dev_err(dev, "Failed to get irq\n");
+	if (state->irq < 0)
 		return state->irq;
-	}
 
 	ret = mipi_csis_clk_get(state);
 	if (ret < 0)
diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
index 3a21a8cec799..95102a4bdc62 100644
--- a/drivers/staging/media/meson/vdec/esparser.c
+++ b/drivers/staging/media/meson/vdec/esparser.c
@@ -301,10 +301,8 @@ int esparser_init(struct platform_device *pdev, struct amvdec_core *core)
 	int irq;
 
 	irq = platform_get_irq_byname(pdev, "esparser");
-	if (irq < 0) {
-		dev_err(dev, "Failed getting ESPARSER IRQ from dtb\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, esparser_isr, IRQF_SHARED,
 			       "esparserirq", core);
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
index c34aec7c6e40..9ce3a65903c5 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
@@ -160,11 +160,8 @@ int cedrus_hw_probe(struct cedrus_dev *dev)
 	dev->capabilities = variant->capabilities;
 
 	irq_dec = platform_get_irq(dev->pdev, 0);
-	if (irq_dec <= 0) {
-		dev_err(dev->dev, "Failed to get IRQ\n");
-
+	if (irq_dec <= 0)
 		return irq_dec;
-	}
 	ret = devm_request_irq(dev->dev, irq_dec, cedrus_irq,
 			       0, dev_name(dev->dev), dev);
 	if (ret) {
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
index 60db06768c8a..d964642d95a3 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -675,10 +675,8 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	tasklet_init(&hsdma->task, mtk_hsdma_tasklet, (unsigned long)hsdma);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 	ret = devm_request_irq(&pdev->dev, irq, mtk_hsdma_irq,
 			       0, dev_name(&pdev->dev), hsdma);
 	if (ret) {
diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
index 08027a36e0bc..1cbd7b71fc38 100644
--- a/drivers/staging/nvec/nvec.c
+++ b/drivers/staging/nvec/nvec.c
@@ -796,10 +796,8 @@ static int tegra_nvec_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	nvec->irq = platform_get_irq(pdev, 0);
-	if (nvec->irq < 0) {
-		dev_err(dev, "no irq resource?\n");
+	if (nvec->irq < 0)
 		return -ENODEV;
-	}
 
 	i2c_clk = devm_clk_get(dev, "div-clk");
 	if (IS_ERR(i2c_clk)) {
diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index 5854551d0a52..900424db9b97 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -826,10 +826,8 @@ static int gdma_dma_probe(struct platform_device *pdev)
 	tasklet_init(&dma_dev->task, gdma_dma_tasklet, (unsigned long)dma_dev);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "failed to get irq\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 	ret = devm_request_irq(&pdev->dev, irq, gdma_dma_irq,
 			       0, dev_name(&pdev->dev), dma_dev);
 	if (ret) {
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 61c69f353cdb..8dc730cfe7a6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -141,10 +141,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 		return PTR_ERR(g_regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		dev_err(dev, "failed to get IRQ\n");
+	if (irq <= 0)
 		return irq;
-	}
 
 	err = devm_request_irq(dev, irq, vchiq_doorbell_irq, IRQF_IRQPOLL,
 			       "VCHIQ doorbell", state);
diff --git a/drivers/thermal/broadcom/brcmstb_thermal.c b/drivers/thermal/broadcom/brcmstb_thermal.c
index 5825ac581f56..619ad86dbdbc 100644
--- a/drivers/thermal/broadcom/brcmstb_thermal.c
+++ b/drivers/thermal/broadcom/brcmstb_thermal.c
@@ -331,10 +331,8 @@ static int brcmstb_thermal_probe(struct platform_device *pdev)
 	priv->thermal = thermal;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					brcmstb_tmon_irq_thread, IRQF_ONESHOT,
 					DRV_NAME, priv);
diff --git a/drivers/thermal/da9062-thermal.c b/drivers/thermal/da9062-thermal.c
index c32709badeda..2917b1cee1e9 100644
--- a/drivers/thermal/da9062-thermal.c
+++ b/drivers/thermal/da9062-thermal.c
@@ -254,10 +254,8 @@ static int da9062_thermal_probe(struct platform_device *pdev)
 		thermal->zone->passive_delay);
 
 	ret = platform_get_irq_byname(pdev, "THERMAL");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to get platform IRQ.\n");
+	if (ret < 0)
 		goto err_zone;
-	}
 	thermal->irq = ret;
 
 	ret = request_threaded_irq(thermal->irq, NULL,
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
index 343c2f5c5a25..00169e5a719a 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1229,10 +1229,8 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return -ENXIO;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq resource?\n");
+	if (irq < 0)
 		return -EINVAL;
-	}
 
 	thermal = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_thermal_data),
 			       GFP_KERNEL);
diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
index a824b78dabf8..a0114452d11f 100644
--- a/drivers/thermal/st/st_thermal_memmap.c
+++ b/drivers/thermal/st/st_thermal_memmap.c
@@ -94,10 +94,8 @@ static int st_mmap_register_enable_irq(struct st_thermal_sensor *sensor)
 	int ret;
 
 	sensor->irq = platform_get_irq(pdev, 0);
-	if (sensor->irq < 0) {
-		dev_err(dev, "failed to register IRQ\n");
+	if (sensor->irq < 0)
 		return sensor->irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, sensor->irq,
 					NULL, st_mmap_thermal_trip_handler,
diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
index cf9ddc52f30e..4697849de1ca 100644
--- a/drivers/thermal/st/stm_thermal.c
+++ b/drivers/thermal/st/stm_thermal.c
@@ -487,10 +487,8 @@ static int stm_register_irq(struct stm_thermal_sensor *sensor)
 	int ret;
 
 	sensor->irq = platform_get_irq(pdev, 0);
-	if (sensor->irq < 0) {
-		dev_err(dev, "%s: Unable to find IRQ\n", __func__);
+	if (sensor->irq < 0)
 		return sensor->irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, sensor->irq,
 					stm_thermal_alarm_irq,
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index 2fa78f738568..1747dcaba365 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -787,10 +787,8 @@ static int ti_bandgap_talert_init(struct ti_bandgap *bgp,
 	int ret;
 
 	bgp->irq = platform_get_irq(pdev, 0);
-	if (bgp->irq < 0) {
-		dev_err(&pdev->dev, "get_irq failed\n");
+	if (bgp->irq < 0)
 		return bgp->irq;
-	}
 	ret = request_threaded_irq(bgp->irq, NULL,
 				   ti_bandgap_talert_irq_handler,
 				   IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
diff --git a/drivers/tty/serial/8250/8250_bcm2835aux.c b/drivers/tty/serial/8250/8250_bcm2835aux.c
index bd53661103eb..8ce700c1a7fc 100644
--- a/drivers/tty/serial/8250/8250_bcm2835aux.c
+++ b/drivers/tty/serial/8250/8250_bcm2835aux.c
@@ -56,10 +56,8 @@ static int bcm2835aux_serial_probe(struct platform_device *pdev)
 
 	/* get the interrupt */
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "irq not found - %i", ret);
+	if (ret < 0)
 		return ret;
-	}
 	data->uart.port.irq = ret;
 
 	/* map the main registers */
diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index eddf119374e1..570e25d6f37e 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -106,10 +106,8 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "irq not found");
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index 164ba133437a..e0b73a5402db 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -176,10 +176,8 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "failed to get IRQ number\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 5921a33b2a07..3a7d1a66f79c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2718,11 +2718,8 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "cannot obtain irq\n");
+	if (ret < 0)
 		return ret;
-	}
 	uap->port.irq	= ret;
 
 #ifdef CONFIG_ACPI_SPCR_TABLE
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 92dad2b4ec36..1b790cc1c0cf 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2346,10 +2346,8 @@ static int lpuart_probe(struct platform_device *pdev)
 	sport->port.type = PORT_LPUART;
 	sport->devtype = sdata->devtype;
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "cannot obtain irq\n");
+	if (ret < 0)
 		return ret;
-	}
 	sport->port.irq = ret;
 	sport->port.iotype = sdata->iotype;
 	if (lpuart_is_32(sport))
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0ad947..7c67e3afbac7 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -687,11 +687,8 @@ static int serial_hs_lpc32xx_probe(struct platform_device *pdev)
 	p->port.membase = NULL;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Error getting irq for HS UART port %d\n",
-			uarts_registered);
+	if (ret < 0)
 		return ret;
-	}
 	p->port.irq = ret;
 
 	p->port.iotype = UPIO_MEM32;
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index 7e7b1559fa36..c12a12556339 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -884,10 +884,8 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 	if (platform_irq_count(pdev) == 1) {
 		/* Old bindings: no name on the single unamed UART0 IRQ */
 		irq = platform_get_irq(pdev, 0);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get UART IRQ\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		mvuart->irq[UART_IRQ_SUM] = irq;
 	} else {
@@ -897,18 +895,14 @@ static int mvebu_uart_probe(struct platform_device *pdev)
 		 * uart-sum of UART0 port.
 		 */
 		irq = platform_get_irq_byname(pdev, "uart-rx");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get 'uart-rx' IRQ\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		mvuart->irq[UART_RX_IRQ] = irq;
 
 		irq = platform_get_irq_byname(pdev, "uart-tx");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "unable to get 'uart-tx' IRQ\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		mvuart->irq[UART_TX_IRQ] = irq;
 	}
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index 29a6dc6a8d23..03963af77b15 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -662,10 +662,8 @@ static int owl_uart_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (owl_uart_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 35e5f9c5d5be..f879710e23f1 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1291,10 +1291,8 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	uport->irq = irq;
 
 	uport->private_data = drv;
diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index 284623eefaeb..c1b0d7662ef9 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -735,10 +735,8 @@ static int rda_uart_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	if (rda_uart_ports[pdev->id]) {
 		dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
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
index d5269aaaf9b2..76ffbc7826ae 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -1307,10 +1307,8 @@ static int tegra_uart_probe(struct platform_device *pdev)
 
 	u->iotype = UPIO_MEM32;
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Couldn't get IRQ\n");
+	if (ret < 0)
 		return ret;
-	}
 	u->irq = ret;
 	u->regshift = 2;
 	ret = uart_add_one_port(&tegra_uart_driver, u);
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index be4687814353..d5f81b98e4d7 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -896,10 +896,8 @@ static int sifive_serial_probe(struct platform_device *pdev)
 	int irq, id, r;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "could not acquire interrupt\n");
+	if (irq < 0)
 		return -EPROBE_DEFER;
-	}
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, mem);
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 73d71a4e6c0c..284709f61831 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -1173,10 +1173,8 @@ static int sprd_probe(struct platform_device *pdev)
 	up->mapbase = res->start;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "not provide irq resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	up->irq = irq;
 
 	/*
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 24a2261f879a..222694352a17 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -927,11 +927,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->fifosize	= stm32port->info->cfg.fifosize;
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret <= 0) {
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "Can't get event IRQ: %d\n", ret);
-		return ret ? ret : -ENODEV;
-	}
+	if (ret <= 0)
+		return ret ? : -ENODEV;
 	port->irq = ret;
 
 	port->rs485_config = stm32_config_rs485;
@@ -940,14 +937,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
 
 	if (stm32port->info->cfg.has_wakeup) {
 		stm32port->wakeirq = platform_get_irq(pdev, 1);
-		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO) {
-			if (stm32port->wakeirq != -EPROBE_DEFER)
-				dev_err(&pdev->dev,
-					"Can't get event wake IRQ: %d\n",
-					stm32port->wakeirq);
-			return stm32port->wakeirq ? stm32port->wakeirq :
-				-ENODEV;
-		}
+		if (stm32port->wakeirq <= 0 && stm32port->wakeirq != -ENXIO)
+			return stm32port->wakeirq ? : -ENODEV;
 	}
 
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
diff --git a/drivers/uio/uio_dmem_genirq.c b/drivers/uio/uio_dmem_genirq.c
index f32cef94aa82..ebcf1434e296 100644
--- a/drivers/uio/uio_dmem_genirq.c
+++ b/drivers/uio/uio_dmem_genirq.c
@@ -200,10 +200,8 @@ static int uio_dmem_genirq_probe(struct platform_device *pdev)
 
 	if (!uioinfo->irq) {
 		ret = platform_get_irq(pdev, 0);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "failed to get IRQ\n");
+		if (ret < 0)
 			goto bad1;
-		}
 		uioinfo->irq = ret;
 	}
 	uiomem = &uioinfo->mem[0];
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
index 80fd3c6dcd1c..3c6ce09a6db5 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -407,10 +407,8 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	spin_lock_init(&hsotg->lock);
 
 	hsotg->irq = platform_get_irq(dev, 0);
-	if (hsotg->irq < 0) {
-		dev_err(&dev->dev, "missing IRQ resource\n");
+	if (hsotg->irq < 0)
 		return hsotg->irq;
-	}
 
 	dev_dbg(hsotg->dev, "registering common handler for irq%d\n",
 		hsotg->irq);
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
index ed8b86517675..6f711d58d82f 100644
--- a/drivers/usb/dwc3/dwc3-omap.c
+++ b/drivers/usb/dwc3/dwc3-omap.c
@@ -469,10 +469,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, omap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(dev, res);
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
index c1fcc77403ea..97b16463f3ef 100644
--- a/drivers/usb/gadget/udc/bcm63xx_udc.c
+++ b/drivers/usb/gadget/udc/bcm63xx_udc.c
@@ -2328,10 +2328,8 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 
 	/* IRQ resource #0: control interrupt (VBUS, speed, etc.) */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "missing IRQ resource #0\n");
+	if (irq < 0)
 		goto out_uninit;
-	}
 	if (devm_request_irq(dev, irq, &bcm63xx_udc_ctrl_isr, 0,
 			     dev_name(dev), udc) < 0)
 		goto report_request_failure;
@@ -2339,10 +2337,8 @@ static int bcm63xx_udc_probe(struct platform_device *pdev)
 	/* IRQ resources #1-6: data interrupts for IUDMA channels 0-5 */
 	for (i = 0; i < BCM63XX_NUM_IUDMA; i++) {
 		irq = platform_get_irq(pdev, i + 1);
-		if (irq < 0) {
-			dev_err(dev, "missing IRQ resource #%d\n", i + 1);
+		if (irq < 0)
 			goto out_uninit;
-		}
 		if (devm_request_irq(dev, irq, &bcm63xx_udc_data_isr, 0,
 				     dev_name(dev), &udc->iudma[i]) < 0)
 			goto report_request_failure;
diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index ccbd1d34eb2a..cc4a16e253ac 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -515,10 +515,8 @@ static int bdc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "platform_get_irq failed:%d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 	spin_lock_init(&bdc->lock);
 	platform_set_drvdata(pdev, bdc);
 	bdc->irq = irq;
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index 729e60e49564..7a0e9a58c2d8 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -2134,19 +2134,15 @@ static int gr_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	dev->irq = platform_get_irq(pdev, 0);
-	if (dev->irq <= 0) {
-		dev_err(dev->dev, "No irq found\n");
+	if (dev->irq <= 0)
 		return -ENODEV;
-	}
 
 	/* Some core configurations has separate irqs for IN and OUT events */
 	dev->irqi = platform_get_irq(pdev, 1);
 	if (dev->irqi > 0) {
 		dev->irqo = platform_get_irq(pdev, 2);
-		if (dev->irqo <= 0) {
-			dev_err(dev->dev, "Found irqi but not irqo\n");
+		if (dev->irqo <= 0)
 			return -ENODEV;
-		}
 	} else {
 		dev->irqi = 0;
 	}
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 5f1b14f3e5a0..e9cf20979bf6 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -3061,11 +3061,8 @@ static int lpc32xx_udc_probe(struct platform_device *pdev)
 	/* Get IRQs */
 	for (i = 0; i < 4; i++) {
 		udc->udp_irq[i] = platform_get_irq(pdev, i);
-		if (udc->udp_irq[i] < 0) {
-			dev_err(udc->dev,
-				"irq resource %d not available!\n", i);
+		if (udc->udp_irq[i] < 0)
 			return udc->udp_irq[i];
-		}
 	}
 
 	udc->udp_baseaddr = devm_ioremap_resource(dev, res);
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 87062d22134d..027a25694a68 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2743,10 +2743,8 @@ static int renesas_usb3_probe(struct platform_device *pdev)
 		priv = of_device_get_match_data(&pdev->dev);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	usb3 = devm_kzalloc(&pdev->dev, sizeof(*usb3), GFP_KERNEL);
 	if (!usb3)
diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 31c7c5587cf9..858993c73442 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -1311,10 +1311,8 @@ static int s3c_hsudc_probe(struct platform_device *pdev)
 	s3c_hsudc_setup_ep(hsudc);
 
 	ret = platform_get_irq(pdev, 0);
-	if (ret < 0) {
-		dev_err(dev, "unable to obtain IRQ number\n");
+	if (ret < 0)
 		goto err_res;
-	}
 	hsudc->irq = ret;
 
 	ret = devm_request_irq(&pdev->dev, hsudc->irq, s3c_hsudc_irq, 0,
diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index b1f4104d1283..29d8e5f8bb58 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -2074,10 +2074,8 @@ static int xudc_probe(struct platform_device *pdev)
 		return PTR_ERR(udc->addr);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "unable to get irq\n");
+	if (irq < 0)
 		return irq;
-	}
 	ret = devm_request_irq(&pdev->dev, irq, xudc_irq, 0,
 			       dev_name(&pdev->dev), udc);
 	if (ret < 0) {
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
index 7d20296cbe9f..fc125b3d06e7 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -115,10 +115,8 @@ static int ehci_hcd_omap_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "EHCI irq failed: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res =  platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	regs = devm_ioremap_resource(dev, res);
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
index 4c306fb6b069..769749ca5961 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -145,10 +145,8 @@ static int ehci_platform_probe(struct platform_device *dev)
 	}
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 
 	hcd = usb_create_hcd(&ehci_platform_hc_driver, &dev->dev,
 			     dev_name(&dev->dev));
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
index ccb4e611001d..f74433aac948 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -158,10 +158,8 @@ static int st_ehci_platform_probe(struct platform_device *dev)
 		return -ENODEV;
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res_mem) {
 		dev_err(&dev->dev, "no memory resource provided");
diff --git a/drivers/usb/host/imx21-hcd.c b/drivers/usb/host/imx21-hcd.c
index 6e3dad19d369..e406c5459a97 100644
--- a/drivers/usb/host/imx21-hcd.c
+++ b/drivers/usb/host/imx21-hcd.c
@@ -1836,10 +1836,8 @@ static int imx21_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENODEV;
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	hcd = usb_create_hcd(&imx21_hc_driver,
 		&pdev->dev, dev_name(&pdev->dev));
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 65a1c3fdc88c..7addfc2cbadc 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -111,10 +111,8 @@ static int ohci_platform_probe(struct platform_device *dev)
 		return err;
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 
 	hcd = usb_create_hcd(&ohci_platform_hc_driver, &dev->dev,
 			dev_name(&dev->dev));
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index 638a92bd2cdc..ac796ccd93ef 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -138,10 +138,8 @@ static int st_ohci_platform_probe(struct platform_device *dev)
 		return -ENODEV;
 
 	irq = platform_get_irq(dev, 0);
-	if (irq < 0) {
-		dev_err(&dev->dev, "no irq provided");
+	if (irq < 0)
 		return irq;
-	}
 
 	res_mem = platform_get_resource(dev, IORESOURCE_MEM, 0);
 	if (!res_mem) {
diff --git a/drivers/usb/mtu3/mtu3_core.c b/drivers/usb/mtu3/mtu3_core.c
index f8bd1d57e795..c3d5c1206eec 100644
--- a/drivers/usb/mtu3/mtu3_core.c
+++ b/drivers/usb/mtu3/mtu3_core.c
@@ -835,10 +835,8 @@ int ssusb_gadget_init(struct ssusb_mtk *ssusb)
 		return -ENOMEM;
 
 	mtu->irq = platform_get_irq(pdev, 0);
-	if (mtu->irq < 0) {
-		dev_err(dev, "fail to get irq number\n");
+	if (mtu->irq < 0)
 		return mtu->irq;
-	}
 	dev_info(dev, "irq %d\n", mtu->irq);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mac");
diff --git a/drivers/usb/phy/phy-ab8500-usb.c b/drivers/usb/phy/phy-ab8500-usb.c
index aaf363f19714..bda3ac2a321e 100644
--- a/drivers/usb/phy/phy-ab8500-usb.c
+++ b/drivers/usb/phy/phy-ab8500-usb.c
@@ -712,10 +712,8 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 
 	if (ab->flags & AB8500_USB_FLAG_USE_LINK_STATUS_IRQ) {
 		irq = platform_get_irq_byname(pdev, "USB_LINK_STATUS");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "Link status irq not found\n");
+		if (irq < 0)
 			return irq;
-		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_link_status_irq,
 				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
@@ -728,10 +726,8 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 
 	if (ab->flags & AB8500_USB_FLAG_USE_ID_WAKEUP_IRQ) {
 		irq = platform_get_irq_byname(pdev, "ID_WAKEUP_F");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "ID fall irq not found\n");
+		if (irq < 0)
 			return irq;
-		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_disconnect_irq,
 				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
@@ -744,10 +740,8 @@ static int ab8500_usb_irq_setup(struct platform_device *pdev,
 
 	if (ab->flags & AB8500_USB_FLAG_USE_VBUS_DET_IRQ) {
 		irq = platform_get_irq_byname(pdev, "VBUS_DET_F");
-		if (irq < 0) {
-			dev_err(&pdev->dev, "VBUS fall irq not found\n");
+		if (irq < 0)
 			return irq;
-		}
 		err = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 				ab8500_usb_disconnect_irq,
 				IRQF_NO_SUSPEND | IRQF_SHARED | IRQF_ONESHOT,
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 6b317c150bdd..edc271da14f4 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -617,10 +617,8 @@ static int wcove_typec_probe(struct platform_device *pdev)
 	wcove->regmap = pmic->regmap;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, irq);
 	if (irq < 0)
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
index 4fd851598584..c4606c734f44 100644
--- a/drivers/video/fbdev/nuc900fb.c
+++ b/drivers/video/fbdev/nuc900fb.c
@@ -526,10 +526,8 @@ static int nuc900fb_probe(struct platform_device *pdev)
 	display = mach_info->displays + mach_info->default_display;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	fbinfo = framebuffer_alloc(sizeof(struct nuc900fb_info), &pdev->dev);
 	if (!fbinfo)
diff --git a/drivers/video/fbdev/pxa168fb.c b/drivers/video/fbdev/pxa168fb.c
index 1410f476e135..d9e5258503f0 100644
--- a/drivers/video/fbdev/pxa168fb.c
+++ b/drivers/video/fbdev/pxa168fb.c
@@ -625,10 +625,8 @@ static int pxa168fb_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no IRQ defined\n");
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	info = framebuffer_alloc(sizeof(struct pxa168fb_info), &pdev->dev);
 	if (info == NULL) {
diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 74ffb446e00c..07414d43cb3f 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -614,10 +614,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
 
 	/* request the IRQ */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "no IRQ defined: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, pxa3xx_gcu_handle_irq,
 			       0, DRV_NAME, priv);
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
index a702da89910b..2a846fd5da2a 100644
--- a/drivers/video/fbdev/s3c2410fb.c
+++ b/drivers/video/fbdev/s3c2410fb.c
@@ -849,10 +849,8 @@ static int s3c24xxfb_probe(struct platform_device *pdev,
 	display = mach_info->displays + mach_info->default_display;
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for device\n");
+	if (irq < 0)
 		return -ENOENT;
-	}
 
 	fbinfo = framebuffer_alloc(sizeof(struct s3c2410fb_info), &pdev->dev);
 	if (!fbinfo)
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
index edba4e278685..0bb17b046140 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -284,10 +284,8 @@ static int sprd_wdt_probe(struct platform_device *pdev)
 	}
 
 	wdt->irq = platform_get_irq(pdev, 0);
-	if (wdt->irq < 0) {
-		dev_err(dev, "failed to get IRQ resource\n");
+	if (wdt->irq < 0)
 		return wdt->irq;
-	}
 
 	ret = devm_request_irq(dev, wdt->irq, sprd_wdt_isr, IRQF_NO_SUSPEND,
 			       "sprd-wdt", (void *)wdt);
diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 0f2c574f27f1..e98601eccfa3 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -571,11 +571,8 @@ static int atmel_classd_probe(struct platform_device *pdev)
 	dd->pdata = pdata;
 
 	dd->irq = platform_get_irq(pdev, 0);
-	if (dd->irq < 0) {
-		ret = dd->irq;
-		dev_err(dev, "failed to could not get irq: %d\n", ret);
-		return ret;
-	}
+	if (dd->irq < 0)
+		return dd->irq;
 
 	dd->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(dd->pclk)) {
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index e09c28349e0d..04ec6f0af179 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -612,11 +612,8 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 	dd->dev = dev;
 
 	dd->irq = platform_get_irq(pdev, 0);
-	if (dd->irq < 0) {
-		ret = dd->irq;
-		dev_err(dev, "failed to get irq: %d\n", ret);
-		return ret;
-	}
+	if (dd->irq < 0)
+		return dd->irq;
 
 	dd->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(dd->pclk)) {
diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index b7c358b48d8d..2f9357d7da96 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -1342,11 +1342,8 @@ static int cygnus_ssp_probe(struct platform_device *pdev)
 	}
 
 	cygaud->irq_num = platform_get_irq(pdev, 0);
-	if (cygaud->irq_num <= 0) {
-		dev_err(dev, "platform_get_irq failed\n");
-		err = cygaud->irq_num;
-		return err;
-	}
+	if (cygaud->irq_num <= 0)
+		return cygaud->irq_num;
 
 	err = audio_clk_init(pdev, cygaud);
 	if (err) {
diff --git a/sound/soc/codecs/msm8916-wcd-analog.c b/sound/soc/codecs/msm8916-wcd-analog.c
index 368b6c09474b..667e9f73aba3 100644
--- a/sound/soc/codecs/msm8916-wcd-analog.c
+++ b/sound/soc/codecs/msm8916-wcd-analog.c
@@ -1185,10 +1185,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq_byname(pdev, "mbhc_switch_int");
-	if (irq < 0) {
-		dev_err(dev, "failed to get mbhc switch irq\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 			       pm8916_mbhc_switch_irq_handler,
@@ -1200,10 +1198,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 
 	if (priv->mbhc_btn_enabled) {
 		irq = platform_get_irq_byname(pdev, "mbhc_but_press_det");
-		if (irq < 0) {
-			dev_err(dev, "failed to get button press irq\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_press_irq_handler,
@@ -1214,10 +1210,8 @@ static int pm8916_wcd_analog_spmi_probe(struct platform_device *pdev)
 			dev_err(dev, "cannot request mbhc button press irq\n");
 
 		irq = platform_get_irq_byname(pdev, "mbhc_but_rel_det");
-		if (irq < 0) {
-			dev_err(dev, "failed to get button release irq\n");
+		if (irq < 0)
 			return irq;
-		}
 
 		ret = devm_request_threaded_irq(dev, irq, NULL,
 				       mbhc_btn_release_irq_handler,
diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 472c2fff34a8..f34637afee51 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1108,10 +1108,8 @@ static int twl6040_probe(struct snd_soc_component *component)
 	priv->component = component;
 
 	priv->plug_irq = platform_get_irq(pdev, 0);
-	if (priv->plug_irq < 0) {
-		dev_err(component->dev, "invalid irq: %d\n", priv->plug_irq);
+	if (priv->plug_irq < 0)
 		return priv->plug_irq;
-	}
 
 	INIT_DELAYED_WORK(&priv->hs_jack.work, twl6040_accessory_work);
 
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index cbbf6257f08a..cfa40ef6b1ca 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -885,10 +885,8 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_asrc_isr, 0,
 			       dev_name(&pdev->dev), asrc_priv);
diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index 10d2210c91ef..19524ca9b4f1 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -824,10 +824,8 @@ static int fsl_esai_probe(struct platform_device *pdev)
 				PTR_ERR(esai_priv->spbaclk));
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, esai_isr, 0,
 			       esai_priv->name, esai_priv);
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index d58cc3ae90d8..6faf222add2b 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -832,10 +832,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, fsl_sai_isr, 0, np->name, sai);
 	if (ret) {
diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 4842e6df9a2d..7858a5499ac5 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1248,10 +1248,8 @@ static int fsl_spdif_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, spdif_isr, 0,
 			       dev_name(&pdev->dev), spdif_priv);
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index fa862af25c1a..b0a6fead1a6a 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -1510,10 +1510,8 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->irq = platform_get_irq(pdev, 0);
-	if (ssi->irq < 0) {
-		dev_err(dev, "no irq for node %s\n", pdev->name);
+	if (ssi->irq < 0)
 		return ssi->irq;
-	}
 
 	/* Set software limitations for synchronous mode except AC97 */
 	if (ssi->synchronous && !fsl_ssi_is_ac97(ssi)) {
diff --git a/sound/soc/fsl/imx-ssi.c b/sound/soc/fsl/imx-ssi.c
index 9038b61317be..42031ba7da31 100644
--- a/sound/soc/fsl/imx-ssi.c
+++ b/sound/soc/fsl/imx-ssi.c
@@ -520,10 +520,8 @@ static int imx_ssi_probe(struct platform_device *pdev)
 	}
 
 	ssi->irq = platform_get_irq(pdev, 0);
-	if (ssi->irq < 0) {
-		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", ssi->irq);
+	if (ssi->irq < 0)
 		return ssi->irq;
-	}
 
 	ssi->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(ssi->clk)) {
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3446a113f482..bf9aa58b31c6 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -539,10 +539,8 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->io);
 
 	priv->irq = platform_get_irq(pdev, 0);
-	if (priv->irq < 0) {
-		dev_err(&pdev->dev, "platform_get_irq failed: %d\n", priv->irq);
+	if (priv->irq < 0)
 		return priv->irq;
-	}
 
 	if (np) {
 		priv->burst = 128;		/* might be 32 or 128 */
diff --git a/sound/soc/mediatek/common/mtk-btcvsd.c b/sound/soc/mediatek/common/mtk-btcvsd.c
index c7a81c4be068..d00608c73c6e 100644
--- a/sound/soc/mediatek/common/mtk-btcvsd.c
+++ b/sound/soc/mediatek/common/mtk-btcvsd.c
@@ -1335,10 +1335,8 @@ static int mtk_btcvsd_snd_probe(struct platform_device *pdev)
 
 	/* irq */
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0) {
-		dev_err(dev, "%pOFn no irq found\n", dev->of_node);
+	if (irq_id <= 0)
 		return irq_id < 0 ? irq_id : -ENXIO;
-	}
 
 	ret = devm_request_irq(dev, irq_id, mtk_btcvsd_snd_irq_handler,
 			       IRQF_TRIGGER_LOW, "BTCVSD_ISR_Handle",
diff --git a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
index 7064a9fd6f74..9af76ae315a5 100644
--- a/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
+++ b/sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
@@ -1342,10 +1342,8 @@ static int mt2701_afe_pcm_dev_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	irq_id = platform_get_irq_byname(pdev, "asys");
-	if (irq_id < 0) {
-		dev_err(dev, "unable to get ASYS IRQ\n");
+	if (irq_id < 0)
 		return irq_id;
-	}
 
 	ret = devm_request_irq(dev, irq_id, mt2701_asys_isr,
 			       IRQF_TRIGGER_NONE, "asys-isr", (void *)afe);
diff --git a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
index 0382896c162e..2d45d44ee97b 100644
--- a/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
+++ b/sound/soc/mediatek/mt8173/mt8173-afe-pcm.c
@@ -1075,10 +1075,8 @@ static int mt8173_afe_pcm_dev_probe(struct platform_device *pdev)
 	afe->dev = &pdev->dev;
 
 	irq_id = platform_get_irq(pdev, 0);
-	if (irq_id <= 0) {
-		dev_err(afe->dev, "np %pOFn no irq\n", afe->dev->of_node);
+	if (irq_id <= 0)
 		return irq_id < 0 ? irq_id : -ENXIO;
-	}
 	ret = devm_request_irq(afe->dev, irq_id, mt8173_afe_irq_handler,
 			       0, "Afe_ISR_Handle", (void *)afe);
 	if (ret) {
diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 269b6d6df250..ccfec47f63e8 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -793,12 +793,8 @@ static int mxs_saif_probe(struct platform_device *pdev)
 		return PTR_ERR(saif->base);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		dev_err(&pdev->dev, "failed to get irq resource: %d\n",
-			ret);
-		return ret;
-	}
+	if (irq < 0)
+		return irq;
 
 	saif->dev = &pdev->dev;
 	ret = devm_request_irq(&pdev->dev, irq, mxs_saif_irq, 0,
diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index cf7a299f4547..4c745baa39f7 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -564,11 +564,8 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 	int ret;
 
 	drvdata->lpaif_irq = platform_get_irq_byname(pdev, "lpass-irq-lpaif");
-	if (drvdata->lpaif_irq < 0) {
-		dev_err(&pdev->dev, "error getting irq handle: %d\n",
-			drvdata->lpaif_irq);
+	if (drvdata->lpaif_irq < 0)
 		return -ENODEV;
-	}
 
 	/* ensure audio hardware is disabled */
 	ret = regmap_write(drvdata->lpaif_map,
diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 70d524ef9bc0..4bb9636da990 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -613,11 +613,8 @@ static int bdw_probe(struct snd_sof_dev *sdev)
 
 	/* register our IRQ */
 	sdev->ipc_irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
-	if (sdev->ipc_irq < 0) {
-		dev_err(sdev->dev, "error: failed to get IRQ at index %d\n",
-			desc->irqindex_host_ipc);
+	if (sdev->ipc_irq < 0)
 		return sdev->ipc_irq;
-	}
 
 	dev_dbg(sdev->dev, "using IRQ %d\n", sdev->ipc_irq);
 	ret = devm_request_threaded_irq(sdev->dev, sdev->ipc_irq,
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 107d711efc3f..000d576f6a8d 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -728,11 +728,8 @@ static int byt_acpi_probe(struct snd_sof_dev *sdev)
 irq:
 	/* register our IRQ */
 	sdev->ipc_irq = platform_get_irq(pdev, desc->irqindex_host_ipc);
-	if (sdev->ipc_irq < 0) {
-		dev_err(sdev->dev, "error: failed to get IRQ at index %d\n",
-			desc->irqindex_host_ipc);
+	if (sdev->ipc_irq < 0)
 		return sdev->ipc_irq;
-	}
 
 	dev_dbg(sdev->dev, "using IRQ %d\n", sdev->ipc_irq);
 	ret = devm_request_threaded_irq(sdev->dev, sdev->ipc_irq,
diff --git a/sound/soc/sprd/sprd-mcdt.c b/sound/soc/sprd/sprd-mcdt.c
index 7448015a4935..f439e5503a3c 100644
--- a/sound/soc/sprd/sprd-mcdt.c
+++ b/sound/soc/sprd/sprd-mcdt.c
@@ -959,10 +959,8 @@ static int sprd_mcdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mcdt);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Failed to get MCDT interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, sprd_mcdt_irq_handler,
 			       0, "sprd-mcdt", mcdt);
diff --git a/sound/soc/sti/sti_uniperif.c b/sound/soc/sti/sti_uniperif.c
index 645bcbe91601..ee4a0151e63e 100644
--- a/sound/soc/sti/sti_uniperif.c
+++ b/sound/soc/sti/sti_uniperif.c
@@ -426,10 +426,8 @@ static int sti_uniperiph_cpu_dai_of(struct device_node *node,
 				     UNIPERIF_FIFO_DATA_OFFSET(uni);
 
 	uni->irq = platform_get_irq(priv->pdev, 0);
-	if (uni->irq < 0) {
-		dev_err(dev, "Failed to get IRQ resource\n");
+	if (uni->irq < 0)
 		return -ENXIO;
-	}
 
 	uni->type = dev_data->type;
 
diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index ba6452dab69b..3e7226a53e53 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -855,11 +855,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	/* Get irqs */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
 			       dev_name(&pdev->dev), i2s);
diff --git a/sound/soc/stm/stm32_sai.c b/sound/soc/stm/stm32_sai.c
index 63f68e663676..1c4cc1ca1eaa 100644
--- a/sound/soc/stm/stm32_sai.c
+++ b/sound/soc/stm/stm32_sai.c
@@ -195,10 +195,8 @@ static int stm32_sai_probe(struct platform_device *pdev)
 
 	/* init irqs */
 	sai->irq = platform_get_irq(pdev, 0);
-	if (sai->irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+	if (sai->irq < 0)
 		return sai->irq;
-	}
 
 	/* reset */
 	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index ee71b898897b..cd4b235fce57 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -909,10 +909,8 @@ static int stm32_spdifrx_parse_of(struct platform_device *pdev,
 	}
 
 	spdifrx->irq = platform_get_irq(pdev, 0);
-	if (spdifrx->irq < 0) {
-		dev_err(&pdev->dev, "No irq for node %s\n", pdev->name);
+	if (spdifrx->irq < 0)
 		return spdifrx->irq;
-	}
 
 	return 0;
 }
diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 9b2232908b65..d97d694c48df 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1087,10 +1087,8 @@ static int sun4i_i2s_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Can't retrieve our interrupt\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	i2s->variant = of_device_get_match_data(&pdev->dev);
 	if (!i2s->variant) {
diff --git a/sound/soc/uniphier/aio-dma.c b/sound/soc/uniphier/aio-dma.c
index fa001d3c1a88..2261655be10d 100644
--- a/sound/soc/uniphier/aio-dma.c
+++ b/sound/soc/uniphier/aio-dma.c
@@ -291,10 +291,8 @@ int uniphier_aiodma_soc_register_platform(struct platform_device *pdev)
 		return PTR_ERR(chip->regmap);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(dev, "Could not get irq.\n");
+	if (irq < 0)
 		return irq;
-	}
 
 	ret = devm_request_irq(dev, irq, aiodma_irq,
 			       IRQF_SHARED, dev_name(dev), pdev);
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
index 5fd4e32247a6..cd389d21219a 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -1708,10 +1708,8 @@ static int hdmi_lpe_audio_probe(struct platform_device *pdev)
 
 	/* get resources */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "Could not get irq resource: %d\n", irq);
+	if (irq < 0)
 		return irq;
-	}
 
 	res_mmio = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res_mmio) {
-- 
Sent by a computer through tubes

