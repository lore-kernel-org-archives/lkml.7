Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1D1C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9BD2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 09:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="JqvTk2uS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfE1JlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 05:41:16 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:39838 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbfE1JlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 05:41:16 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D5D61C1DBA;
        Tue, 28 May 2019 09:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1559036484; bh=D731wz21YeITb5xPmWrEYvvhxG+m4OVL0X26qnGuol4=;
        h=From:To:Cc:Subject:Date:From;
        b=JqvTk2uSNMc3IlMREczO8QhAGmcQmdtNdaKnvNnTaT/Q7jAgKoqgC/vf4M5XjCIaX
         J5WHi0/I4pYBP8d9tjEoYDPIiwtepRVy4ZMG5hkRMZbJ5SZ05doYoSCvGGjIR9Sua5
         3G8iNWZsZaUU1eDN/0sN8MUdnlsA9EUZgOw9M8xHqHArJ13HWQaAWd7k/PYkog51Mi
         fOKXj8Yae7hfys5Rem0wnXmNSAcvVYPF6B+/JGYJOwZwgV1F0I1QT0n+PLKafxq2BL
         5DFTjMNk9nCpAWJvxVD/4K70CxCgENW793Y3LOQejVHfAeZGcr75fulqNkZSapq548
         vmQkdFGK6CXkg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.58])
        by mailhost.synopsys.com (Postfix) with ESMTP id CDF31A0093;
        Tue, 28 May 2019 09:41:11 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] ARC: [plat-hsdk]: enable creg-gpio controller
Date:   Tue, 28 May 2019 12:40:52 +0300
Message-Id: <20190528094052.2393-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HSDK SOC has CREG GPIO controller which can be used to control
SPI chip select lines.
Enable it in preparation of enabling SPI peripherals.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/boot/dts/hsdk.dts      | 8 ++++++++
 arch/arc/configs/hsdk_defconfig | 1 +
 2 files changed, 9 insertions(+)

diff --git a/arch/arc/boot/dts/hsdk.dts b/arch/arc/boot/dts/hsdk.dts
index 7425bb0f2d1b..83e163e51b34 100644
--- a/arch/arc/boot/dts/hsdk.dts
+++ b/arch/arc/boot/dts/hsdk.dts
@@ -237,6 +237,14 @@
 			dma-coherent;
 		};
 
+		creg_gpio: gpio@14b0 {
+			compatible = "snps,creg-gpio-hsdk";
+			reg = <0x14b0 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			ngpios = <2>;
+		};
+
 		gpio: gpio@3000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0x3000 0x20>;
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 0e5fd29ed238..0c4411f50948 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -49,6 +49,7 @@ CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_GPIOLIB=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_DWAPB=y
+CONFIG_GPIO_SNPS_CREG=y
 # CONFIG_HWMON is not set
 CONFIG_DRM=y
 # CONFIG_DRM_FBDEV_EMULATION is not set
-- 
2.21.0

