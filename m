Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32BAC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896DF20645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfDWHmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:42:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6676 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726402AbfDWHkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:40:16 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BC1F7A01CA3849F01B45;
        Tue, 23 Apr 2019 15:40:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 23 Apr 2019 15:40:02 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH next 00/25] cleanup: use dev_get_drvdata() directly
Date:   Tue, 23 Apr 2019 15:49:55 +0800
Message-ID: <20190423075020.173734-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers call to_platform_device() to get platform_device, then
get drvdata by platform_get_drvdata(), but in platfrom_get_drvdata(),
the platform_device is converted back to struct device again.

Using dev_get_drvdata() directly, only build test on arm64/x86_64.

Kefeng Wang (25):
  ACPI / DPTF: Use dev_get_drvdata()
  crypto: picoxcell: Use dev_get_drvdata()
  dmaengine: Use dev_get_drvdata()
  drm/exynos: Use dev_get_drvdata()
  drm/msm: Use dev_get_drvdata()
  drm/omap: Use dev_get_drvdata()
  hwmon: s3c: Use dev_get_drvdata()
  iio: adc: at91: Use dev_get_drvdata()
  input: keyboard: Use dev_get_drvdata()
  input: misc: Use dev_get_drvdata()
  input: mouse: Use dev_get_drvdata()
  input: touchscreen: Use dev_get_drvdata()
  iommu/omap: Use dev_get_drvdata()
  mailbox: bcm-flexrm-mailbox: Use dev_get_drvdata()
  media: platform: Use dev_get_drvdata()
  mfd: Use dev_get_drvdata()
  mmc: omap_hsmmc: Use dev_get_drvdata()
  net: can: Use dev_get_drvdata()
  net: calxedaxgmac: Use dev_get_drvdata()
  platform/x86: asus-wmi: Use dev_get_drvdata()
  rtc: Use dev_get_drvdata()
  media: staging/imx7: Use dev_get_drvdata()
  thermal: Use dev_get_drvdata()
  usb: musb: dsps: Use dev_get_drvdata()
  video: fbdev: Use dev_get_drvdata()

 drivers/acpi/dptf/dptf_power.c                |  3 +--
 drivers/crypto/picoxcell_crypto.c             |  2 +-
 drivers/dma/bcm-sba-raid.c                    |  3 +--
 drivers/dma/nbpfaxi.c                         |  4 ++--
 drivers/gpu/drm/exynos/exynos_drm_fimc.c      |  8 +++----
 drivers/gpu/drm/exynos/exynos_drm_gsc.c       |  5 ++---
 drivers/gpu/drm/msm/adreno/adreno_device.c    |  6 ++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       | 13 +++++-------
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      |  6 ++----
 drivers/gpu/drm/msm/dsi/dsi_host.c            |  6 ++----
 drivers/gpu/drm/msm/msm_drv.c                 |  3 +--
 drivers/gpu/drm/msm/msm_gpu.c                 |  6 +++---
 .../gpu/drm/omapdrm/displays/panel-dsi-cm.c   | 18 ++++++----------
 drivers/hwmon/s3c-hwmon.c                     |  4 ++--
 drivers/iio/adc/at91-sama5d2_adc.c            | 12 ++++-------
 drivers/iio/adc/at91_adc.c                    |  4 ++--
 drivers/input/keyboard/ep93xx_keypad.c        | 10 ++++-----
 drivers/input/keyboard/gpio_keys.c            |  6 ++----
 drivers/input/keyboard/imx_keypad.c           | 10 ++++-----
 drivers/input/keyboard/lpc32xx-keys.c         |  6 ++----
 drivers/input/keyboard/matrix_keypad.c        | 10 ++++-----
 drivers/input/keyboard/omap4-keypad.c         | 10 ++++-----
 drivers/input/keyboard/pmic8xxx-keypad.c      |  6 ++----
 drivers/input/keyboard/pxa27x_keypad.c        | 10 ++++-----
 drivers/input/keyboard/samsung-keypad.c       | 12 ++++-------
 drivers/input/keyboard/snvs_pwrkey.c          | 10 ++++-----
 drivers/input/keyboard/spear-keyboard.c       | 10 ++++-----
 drivers/input/keyboard/st-keyscan.c           |  6 ++----
 drivers/input/keyboard/tegra-kbc.c            | 10 ++++-----
 drivers/input/misc/max77693-haptic.c          |  6 ++----
 drivers/input/misc/max8925_onkey.c            | 10 ++++-----
 drivers/input/misc/max8997_haptic.c           |  3 +--
 drivers/input/misc/msm-vibrator.c             |  6 ++----
 drivers/input/misc/palmas-pwrbutton.c         |  6 ++----
 drivers/input/misc/regulator-haptic.c         |  6 ++----
 drivers/input/misc/stpmic1_onkey.c            |  6 ++----
 drivers/input/misc/twl4030-vibra.c            |  3 +--
 drivers/input/misc/twl6040-vibra.c            |  3 +--
 drivers/input/mouse/navpoint.c                |  6 ++----
 drivers/input/touchscreen/imx6ul_tsc.c        |  6 ++----
 drivers/input/touchscreen/s3c2410_ts.c        |  3 +--
 drivers/iommu/omap-iommu.c                    |  3 +--
 drivers/mailbox/bcm-flexrm-mailbox.c          |  6 ++----
 .../media/platform/cros-ec-cec/cros-ec-cec.c  |  6 ++----
 drivers/mfd/ssbi.c                            |  2 +-
 drivers/mfd/t7l66xb.c                         | 12 ++++-------
 drivers/mfd/tc6387xb.c                        | 12 ++++-------
 drivers/mfd/tc6393xb.c                        | 21 +++++++------------
 drivers/mmc/host/omap_hsmmc.c                 |  4 ++--
 drivers/net/can/softing/softing_main.c        |  4 ++--
 drivers/net/ethernet/calxeda/xgmac.c          |  4 ++--
 drivers/platform/x86/asus-wmi.c               |  3 +--
 drivers/rtc/rtc-hid-sensor-time.c             |  3 +--
 drivers/rtc/rtc-pxa.c                         |  3 +--
 drivers/rtc/rtc-rk808.c                       |  6 ++----
 drivers/rtc/rtc-tx4939.c                      | 17 ++++++---------
 drivers/rtc/rtc-wm831x.c                      | 18 +++++++---------
 drivers/rtc/rtc-wm8350.c                      | 12 ++++-------
 drivers/staging/media/imx/imx7-mipi-csis.c    |  6 ++----
 .../processor_thermal_device.c                |  8 +------
 drivers/thermal/st/stm_thermal.c              |  6 ++----
 drivers/usb/musb/musb_dsps.c                  |  6 ++----
 drivers/video/fbdev/nuc900fb.c                |  2 +-
 drivers/video/fbdev/s3c2410fb.c               |  2 +-
 drivers/video/fbdev/uvesafb.c                 | 16 +++++++-------
 65 files changed, 171 insertions(+), 294 deletions(-)

-- 
2.20.1

