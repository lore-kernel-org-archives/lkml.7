Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9614C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0542075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kj2mRpXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfCLOVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:21:42 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19193 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLOVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:21:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c87c0770000>; Tue, 12 Mar 2019 07:21:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 12 Mar 2019 07:21:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 12 Mar 2019 07:21:41 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Mar
 2019 14:21:41 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 12 Mar 2019 14:21:41 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c87c0710000>; Tue, 12 Mar 2019 07:21:41 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <heiko@sntech.de>, <horms+renesas@verge.net.au>,
        <andy.gross@linaro.org>, <maxime.ripard@bootlin.com>,
        <olof@lixom.net>, <bjorn.andersson@linaro.org>,
        <jagan@amarulasolutions.com>, <enric.balletbo@collabora.com>,
        <ezequiel@collabora.com>, <stefan.wahren@i2se.com>,
        <marc.w.gonzalez@free.fr>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] arm64: defconfig: build aconnect and adma drivers as modules
Date:   Tue, 12 Mar 2019 19:51:34 +0530
Message-ID: <1552400494-770-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552400503; bh=MPnk3UxObB5pAE9nWIpz8NMwgv7cxRPJvAsy1AAbKvA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=kj2mRpXwni5sSr9L8l68pGu3crq7p3cgNxEGFHAEC5UbHuMdk9eubzg8EaeTY6fu5
         oJ0/zhvhq5MgIMU7ZlA6fC1t5JngbmU4tLgk/kvnKAXvmn7B5CNPyKoCOVELqIC3wU
         3y9KiogJRG5UO7+WHrw8t6gH+6D+D7T96wlTiyT8Lk++oXuacGLsDtlTvBz52AC5bf
         CTbIeNrSzmGtYeM4rQ+GxHFNtTichUSfCyxkXSFJo+5HmmAa4uigGIEpf5y3a5ugNZ
         yDPXbK3Z6Ndn0K1NNnyp0dPM8EZ1wE7ozWypsqLwkQaEBEYCmdHnC96rchXEgmJoBF
         K/XFR5K4SdJGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following configs/drivers are enabled as modules,
 - TEGRA_ACONNECT (drivers/bus/tegra-aconnect.c)
 - TEGRA210_ADMA (drivers/dma/tegra210-adma.c)

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c390..e9d514c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -203,6 +203,7 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=32
 CONFIG_HISILICON_LPC=y
 CONFIG_SIMPLE_PM_BUS=y
+CONFIG_TEGRA_ACONNECT=m
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_M25P80=y
@@ -622,6 +623,7 @@ CONFIG_K3_DMA=y
 CONFIG_MV_XOR_V2=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
+CONFIG_TEGRA210_ADMA=m
 CONFIG_QCOM_BAM_DMA=y
 CONFIG_QCOM_HIDMA_MGMT=y
 CONFIG_QCOM_HIDMA=y
-- 
2.7.4

