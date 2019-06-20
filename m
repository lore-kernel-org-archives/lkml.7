Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AADC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AD1208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 00:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TLklH9nL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbfFTAdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 20:33:06 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40282 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfFTAdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 20:33:05 -0400
Received: by mail-pg1-f202.google.com with SMTP id t70so537128pgd.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 17:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=X+mFn9cHNXrPrO08PdLE+GlXqr2sZ9XFcYjGhCDrNT0=;
        b=TLklH9nLFOLMs3R7W5xVsUqCq48qjSe8I/QtOVXqNxfoDMw3JYAV9hS2AoxjNp5+CB
         P+5fc9CT6LeOC4KIoIwilv2R9vkqTZTyCQYo9aRk0BdzYMScE4Drq/06MqlWTUBH0noF
         P9NZUhFfIufeB+GQvEtwZN/1VqLYsC7DaEerdpUZYvDpBP3awLFB5AfFoYxkuQ5tUhFX
         n26KPlYJq0rUlyP6s2+t0zipmQFe0aNJ6+8TvgrGf/yuCdrpSwRfOkklvyFRzFxt88Rf
         oxhk4tG/H09xDMRJT0BZYbQj93Re6a488AbXmg4GVGV1HHS+sERPR5GVQ+7petvwmKlA
         Ml9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=X+mFn9cHNXrPrO08PdLE+GlXqr2sZ9XFcYjGhCDrNT0=;
        b=b16Pj8X/umKlu/G09tDcXaoKvdW3qPqJlqWNchKgYiO14DfUdypHGpQHwrEjdp/I/R
         qGKX1Bcw4YmofpiaWtdzgeZk0oMFERNHW02dSJCwTk5bXAy1OjMAR9QgnILfPVT+uoey
         yM6Fe5G+e8YQrzoTLSl/mkNCqTju/ScCd5qqHqeUP2ExfAst3Wf4BeLr0ynH1P3eamJb
         FbXINB2306AflIMT+svLATakQYt1RjzMkTdkL+VIol7xagtBxKDhdGOVmC/+Hmp4teVe
         Mcvti6nw0dIkKcmGx2sLzDDvDrWNdoD2M4ZVsWd/pfwgGhnPVDGhyZwtbon8owP/LwfY
         pcHA==
X-Gm-Message-State: APjAAAV/D4v0AXQu3jNrhOP/hdoM2tZiqvA+R8ViPHBfj51uh4srm7g7
        KA/lIe/VyR60ehQGxjGmutWHikduNCldo/GV57s=
X-Google-Smtp-Source: APXvYqzzVUV/nQqA+fJUnmpuX9ZNJBhzK4erSvtXYXSI6WT/je4RvhDA6zk5vGGhUNaR2ayYvRuDeBXmvoaoQxBxT1I=
X-Received: by 2002:a63:231c:: with SMTP id j28mr10162444pgj.430.1560990784744;
 Wed, 19 Jun 2019 17:33:04 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:32:42 -0700
Message-Id: <20190620003244.261595-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] arm64: defconfig: update and enable CONFIG_RANDOMIZE_BASE
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com
Cc:     ard.biesheuvel@linaro.org, broonie@kernel.org,
        mark.rutland@arm.com, Nick Desaulniers <ndesaulniers@google.com>,
        Olof Johansson <olof@lixom.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generated via:
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make menuconfig
<enable CONFIG_RANDOMIZE_BASE aka KASLR>
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make savedefconfig
$ mv defconfig arch/arm64/configs/defconfig

Removes explicit enablement of:
CONFIG_TI_SCI_PROTOCOL
CONFIG_TI_MESSAGE_MANAGER
CONFIG_SOC_TI
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/configs/defconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..54d35e847836 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -68,6 +68,7 @@ CONFIG_KEXEC=y
 CONFIG_CRASH_DUMP=y
 CONFIG_XEN=y
 CONFIG_COMPAT=y
+CONFIG_RANDOMIZE_BASE=y
 CONFIG_HIBERNATION=y
 CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
 CONFIG_ARM_CPUIDLE=y
@@ -86,7 +87,6 @@ CONFIG_ARM_TEGRA186_CPUFREQ=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_INTEL_STRATIX10_SERVICE=y
-CONFIG_TI_SCI_PROTOCOL=y
 CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_IMX_SCU=y
 CONFIG_IMX_SCU_PD=y
@@ -191,7 +191,6 @@ CONFIG_PCIE_QCOM=y
 CONFIG_PCIE_ARMADA_8K=y
 CONFIG_PCIE_KIRIN=y
 CONFIG_PCIE_HISI_STB=y
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_HISILICON_LPC=y
@@ -365,8 +364,8 @@ CONFIG_SPI_PL022=y
 CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
 CONFIG_SPI_S3C64XX=y
-CONFIG_SPI_SPIDEV=m
 CONFIG_SPI_SUN6I=y
+CONFIG_SPI_SPIDEV=m
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_PINCTRL_MAX77620=y
@@ -658,7 +657,6 @@ CONFIG_ARM_MHU=y
 CONFIG_IMX_MBOX=y
 CONFIG_PLATFORM_MHU=y
 CONFIG_BCM2835_MBOX=y
-CONFIG_TI_MESSAGE_MANAGER=y
 CONFIG_QCOM_APCS_IPC=y
 CONFIG_ROCKCHIP_IOMMU=y
 CONFIG_TEGRA_IOMMU_SMMU=y
@@ -696,9 +694,7 @@ CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_ARCH_TEGRA_186_SOC=y
 CONFIG_ARCH_TEGRA_194_SOC=y
 CONFIG_ARCH_K3_AM6_SOC=y
-CONFIG_SOC_TI=y
 CONFIG_TI_SCI_PM_DOMAINS=y
-CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_EXTCON_USBC_CROS_EC=y
 CONFIG_MEMORY=y
-- 
2.22.0.410.gd8fdbe21b5-goog

