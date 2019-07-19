Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20811C7619A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96D62082C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 23:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="sf5FBJU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733159AbfGSXy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 19:54:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36564 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733100AbfGSXyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 19:54:55 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so16347565plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDK4XQDNzQuAFT5PiIQ0FZ6rfOoKMe0qUz8cTiu+oC0=;
        b=sf5FBJU0SV415VBP6/yvIwJ6FP/VNmw/ES+/XOf8L0MPe0Mh/g4uJV3Jh8VM7j7SsF
         C9V8j3EXbG+gV8Pq6kFs7J+AAJar/wslV5JuDJ9s2x0ZcT8Wx14DTJ0BqdgEBWy1Jabx
         /nYRHiPWLyOs5Zf4rSbkGbM8zc4z3HvxFdZIio5ieD+B7WuBHDpWZA6cOuTCvIqYbe+m
         h+cl2tHsqmyk5efCxt7/+bKhKeoMxGVfXbbhYrTACgARWX5C+0Ynac8kPq3btLPEtu3F
         t3f2ukg6M1+kLtThLddkVxpEvN3BQcPcaBE+25vgoU7/K0FDnLghKzza42WDmW5tse2x
         DVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDK4XQDNzQuAFT5PiIQ0FZ6rfOoKMe0qUz8cTiu+oC0=;
        b=I/n6rnAwnXRmQ9QoukHaBr9jqAgN3sxL+sShuZk+ViDRTBhWC4jw6HXw5lWFtK3kV3
         UBYvIqiE8lcEo1BJDnwckeaOCSdZXAHr1kDwBIDXttj+ApyGMq5QFqo+v7123Eicawr3
         9raxGpRRkFd3MlsmpAtzy61Tnv3R4Exn5Xju7h0/nvXYbhbxIWyJb9kV1F9wV4iunuxf
         V7DJv5J9dwO59I7ubyv+bB9AUFCjNkgKFESaZg6heJYNFpJArapLk4GgEcZEn9MYT/dm
         0o6d24ZVMwg7Aa8Z44fJfCSE40/omV0uLi+Rphzy+JWqNAOxNG1eBp/ga4c4QOvSzR4d
         qh/g==
X-Gm-Message-State: APjAAAX+WS9/UBbOesiO9fF/ANI0dY3ty21E+WcbSDCQ9Cf9go8xGNWv
        dmwypwn3B5Pp9NMtItx/A9g=
X-Google-Smtp-Source: APXvYqwn1Wi8Ve+fIBxilEtZjKBZCl8AlSec2ge0I+dmsV7JXUuD12g89H1CqymH3mzz6GGJzqVmQg==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr60243542plb.79.1563580494833;
        Fri, 19 Jul 2019 16:54:54 -0700 (PDT)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id v184sm31975215pfb.82.2019.07.19.16.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Jul 2019 16:54:53 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>
Subject: [GIT PULL 4/4] ARM: SoC defconfig updates
Date:   Fri, 19 Jul 2019 16:54:34 -0700
Message-Id: <20190719235434.13214-5-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20190719235434.13214-1-olof@lixom.net>
References: <20190719235434.13214-1-olof@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We keep this in a separate branch to avoid cross-branch conflicts, but
most of the material here is fairly boring -- some new drivers turned on
for hardware since they were merged, and some refreshed files due to
time having moved a lot of entries around.

Merge conflicts:

arch/arm/configs/exynos_defconfig: Add/remove conflict w/ Russell's tree
	Remove CONFIG_ARCH_EXYNOS3=y
	Keep CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=y

----------------------------------------------------------------

The following changes since commit 77e071a5638b7d1a6a63fde99f1d23608539ce49:

  Merge tag 'armsoc-dt' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-defconfig

for you to fetch changes up to a151f27537250cf869c8d1c2549ccbb77dcbec2f:

  Merge tag 'samsung-defconfig-5.3' of https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into arm/defconfig

----------------------------------------------------------------

Abel Vesa (1):
      arm64: defconfig: Enable RTC_DRV_SNVS

Adam Ford (1):
      ARM: imx_v6_v7_defconfig: Add GPIO_PCF857X

Amelie Delaunay (1):
      ARM: multi_v7_defconfig: enable STMFX pinctrl support

Anson Huang (6):
      arm64: defconfig: add support for i.MX system controller watchdog
      ARM: imx_v6_v7_defconfig: Enable CONFIG_THERMAL_STATISTICS
      ARM: imx_v6_v7_defconfig: Add TPM PWM support by default
      arm64: defconfig: Enable CONFIG_QORIQ_THERMAL
      arm64: defconfig: Add i.MX SCU SoC info driver
      arm64: defconfig: Enable CONFIG_KEYBOARD_SNVS_PWRKEY as module

Biju Das (2):
      ARM: shmobile: Remove GENERIC_PHY from shmobile_defconfig
      arm64: defconfig: enable TYPEC_HD3SS3220 config option

Brian Masney (2):
      ARM: qcom_defconfig: add display-related options
      ARM: qcom_defconfig: add support for USB networking

Clément Péron (2):
      arm64: defconfig: enable sunxi watchdog
      arm64: defconfig: enable Allwinner DMA drivers

Fabio Estevam (3):
      arm64: defconfig: Enable CONFIG_SPI_IMX
      ARM: imx_v6_v7_defconfig: Enable the OV2680 camera driver
      ARM: imx_v6_v7_defconfig: Select CONFIG_NVMEM_SNVS_LPGPR

Fabrizio Castro (1):
      arm64: defconfig: Enable TDA19988

Joel Stanley (3):
      ARM: configs: aspeed: Add new drivers
      ARM: configs: multi_v5: Add more ASPEED devices
      ARM: configs: multi_v5: Remove duplicate ASPEED options

Krzysztof Kozlowski (7):
      ARM: exynos_defconfig: Trim and reorganize with savedefconfig
      ARM: defconfig: samsung: Cleanup with savedefconfig
      ARM: config: Remove left-over BACKLIGHT_LCD_SUPPORT
      arm64: configs: Remove useless UEVENT_HELPER_PATH
      ARM: configs: Remove useless UEVENT_HELPER_PATH
      ARM: multi_v7_defconfig: Enable Panfrost and Lima drivers
      ARM: exynos_defconfig: Enable Panfrost and Lima drivers

Leonard Crestez (6):
      arm64: defconfig: Enable imx8mm clk/pinctrl
      arm64: defconfig: Enable lpi2c for imx8qxp and sensors
      arm64: defconfig: Enable ROHM_BD718XX PMIC for imx8mm-evk
      arm64: defconfig: NVMEM_IMX_OCOTP=y for imx8m
      arm64: defconfig: ARM_IMX_CPUFREQ_DT=m
      ARM: imx_v6_v7_defconfig: Enable CONFIG_ARM_IMX_CPUFREQ_DT

Marcin Juszkiewicz (3):
      arm64 defconfig: enable MPT3 SAS and BNX2X drivers
      arm64 defconfig: enable Mellanox cards
      arm64 defconfig: enable LVM support

Neil Armstrong (2):
      arm64: defconfig: enable Lima driver
      ARM: multi_v7_defconfig: enable Lima driver

Nicolin Chen (1):
      arm64: defconfig: Add HWMON INA3221 support

Olof Johansson (8):
      Merge tag 'qcom-defconfig-for-5.3' of git://git.kernel.org/.../qcom/linux into arm/defconfig
      Merge tag 'renesas-arm-defconfig-for-v5.3' of https://git.kernel.org/.../horms/renesas into arm/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v5.3' of https://git.kernel.org/.../horms/renesas into arm/defconfig
      Merge tag 'tegra-for-5.3-arm64-defconfig' of git://git.kernel.org/.../tegra/linux into arm/defconfig
      Merge tag 'aspeed-5.3-defconfig' of git://git.kernel.org/.../joel/aspeed into arm/defconfig
      Merge tag 'sunxi-config64-for-5.3-201906210813' of https://git.kernel.org/.../sunxi/linux into arm/defconfig
      Merge tag 'imx-defconfig-5.3' of git://git.kernel.org/.../shawnguo/linux into arm/defconfig
      Merge tag 'samsung-defconfig-5.3' of https://git.kernel.org/.../krzk/linux into arm/defconfig

Peng Fan (1):
      defconfig: arm64: enable i.MX8 SCU octop driver

Tomeu Vizoso (2):
      ARM: multi_v7_defconfig: add Panfrost driver
      arm64: defconfig: add Panfrost driver

Uwe Kleine-König (1):
      ARM: imx_v6_v7_defconfig: Enable SIOX bus

Vidya Sagar (1):
      arm64: defconfig: Add Tegra194 PCIe driver

Yangtao Li (1):
      arm64: defconfig: add allwinner sid support


 arch/arm/configs/acs5k_defconfig          |  1 -
 arch/arm/configs/acs5k_tiny_defconfig     |  1 -
 arch/arm/configs/am200epdkit_defconfig    |  1 -
 arch/arm/configs/aspeed_g4_defconfig      | 11 +++--
 arch/arm/configs/aspeed_g5_defconfig      | 15 ++++--
 arch/arm/configs/at91_dt_defconfig        |  1 -
 arch/arm/configs/axm55xx_defconfig        |  1 -
 arch/arm/configs/cm_x2xx_defconfig        |  2 -
 arch/arm/configs/cm_x300_defconfig        |  2 -
 arch/arm/configs/cns3420vb_defconfig      |  1 -
 arch/arm/configs/colibri_pxa270_defconfig |  2 -
 arch/arm/configs/colibri_pxa300_defconfig |  2 -
 arch/arm/configs/collie_defconfig         |  1 -
 arch/arm/configs/corgi_defconfig          |  2 -
 arch/arm/configs/dove_defconfig           |  1 -
 arch/arm/configs/em_x270_defconfig        |  2 -
 arch/arm/configs/ep93xx_defconfig         |  1 -
 arch/arm/configs/eseries_pxa_defconfig    |  2 -
 arch/arm/configs/exynos_defconfig         | 66 +++++++++++---------------
 arch/arm/configs/ezx_defconfig            |  2 -
 arch/arm/configs/gemini_defconfig         |  1 -
 arch/arm/configs/h3600_defconfig          |  1 -
 arch/arm/configs/h5000_defconfig          |  1 -
 arch/arm/configs/imote2_defconfig         |  2 -
 arch/arm/configs/imx_v4_v5_defconfig      |  1 -
 arch/arm/configs/imx_v6_v7_defconfig      |  9 ++++
 arch/arm/configs/integrator_defconfig     |  1 -
 arch/arm/configs/iop13xx_defconfig        |  1 -
 arch/arm/configs/iop32x_defconfig         |  1 -
 arch/arm/configs/iop33x_defconfig         |  1 -
 arch/arm/configs/ixp4xx_defconfig         |  1 -
 arch/arm/configs/jornada720_defconfig     |  2 -
 arch/arm/configs/keystone_defconfig       |  1 -
 arch/arm/configs/ks8695_defconfig         |  1 -
 arch/arm/configs/lpc18xx_defconfig        |  1 -
 arch/arm/configs/lpc32xx_defconfig        |  2 -
 arch/arm/configs/magician_defconfig       |  2 -
 arch/arm/configs/mini2440_defconfig       | 45 +++++++-----------
 arch/arm/configs/mmp2_defconfig           |  1 -
 arch/arm/configs/moxart_defconfig         |  1 -
 arch/arm/configs/multi_v5_defconfig       | 11 +++--
 arch/arm/configs/multi_v7_defconfig       |  4 +-
 arch/arm/configs/mv78xx0_defconfig        |  1 -
 arch/arm/configs/mvebu_v5_defconfig       |  1 -
 arch/arm/configs/mvebu_v7_defconfig       |  1 -
 arch/arm/configs/mxs_defconfig            |  1 -
 arch/arm/configs/nhk8815_defconfig        |  2 -
 arch/arm/configs/nuc910_defconfig         |  1 -
 arch/arm/configs/nuc950_defconfig         |  1 -
 arch/arm/configs/nuc960_defconfig         |  1 -
 arch/arm/configs/omap1_defconfig          |  2 -
 arch/arm/configs/orion5x_defconfig        |  1 -
 arch/arm/configs/palmz72_defconfig        |  2 -
 arch/arm/configs/pcm027_defconfig         |  1 -
 arch/arm/configs/prima2_defconfig         |  1 -
 arch/arm/configs/pxa168_defconfig         |  1 -
 arch/arm/configs/pxa3xx_defconfig         |  2 -
 arch/arm/configs/pxa910_defconfig         |  1 -
 arch/arm/configs/pxa_defconfig            |  2 -
 arch/arm/configs/qcom_defconfig           |  7 ++-
 arch/arm/configs/realview_defconfig       |  2 -
 arch/arm/configs/s3c2410_defconfig        | 25 ++++------
 arch/arm/configs/s3c6400_defconfig        | 13 ++---
 arch/arm/configs/s5pv210_defconfig        |  1 -
 arch/arm/configs/sama5_defconfig          |  2 -
 arch/arm/configs/shmobile_defconfig       |  1 -
 arch/arm/configs/socfpga_defconfig        |  1 -
 arch/arm/configs/spear13xx_defconfig      |  1 -
 arch/arm/configs/spear3xx_defconfig       |  2 -
 arch/arm/configs/spear6xx_defconfig       |  1 -
 arch/arm/configs/spitz_defconfig          |  2 -
 arch/arm/configs/tango4_defconfig         |  1 -
 arch/arm/configs/tct_hammer_defconfig     |  1 -
 arch/arm/configs/trizeps4_defconfig       |  1 -
 arch/arm/configs/u300_defconfig           |  2 -
 arch/arm/configs/u8500_defconfig          |  1 -
 arch/arm/configs/versatile_defconfig      |  1 -
 arch/arm/configs/vexpress_defconfig       |  2 -
 arch/arm/configs/viper_defconfig          |  2 -
 arch/arm/configs/xcep_defconfig           |  1 -
 arch/arm/configs/zeus_defconfig           |  2 -
 arch/arm/configs/zx_defconfig             |  1 -
 arch/arm64/configs/defconfig              | 44 ++++++++++++++++-
 83 files changed, 149 insertions(+), 198 deletions(-)
