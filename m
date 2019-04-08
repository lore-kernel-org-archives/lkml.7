Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14949C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D627B20833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 05:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554700785;
	bh=ppZVzSxUnZ/lt5us2STnJNKfyB+oTXSY8r7SyVV/+Uw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bFdL2O+tG5S9Kj45ZqYPTsAR2RG+v7NNpGG33Irtkg4pvrBiFGz65tTNNFXMw3MF6
	 PgjVZk4rpaiIgDPX9W1n4auMvIOP6PNlkeLgnHUr6jAetPezf0lFgGSoIHsXNdvSeV
	 /oETdf9hz1f1fjtRdTTPUajqlDb6xbcU5Lc+7TUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbfDHFTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 01:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfDHFTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 01:19:42 -0400
Received: from kozik-book.CAR-A-WANv3.local (unknown [83.137.6.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55B0F20833;
        Mon,  8 Apr 2019 05:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554700781;
        bh=ppZVzSxUnZ/lt5us2STnJNKfyB+oTXSY8r7SyVV/+Uw=;
        h=From:To:Cc:Subject:Date:From;
        b=QMq+gTat+UfT5DT8/LgHSMvqREXpBQVNPwebUl58QkNsbuJMwYKQypAa2CVGMBoOr
         i7aZSvR8aaM54IqRdbtT1hRjZ18wTqgNv6gPuW0cu+SUv78MQf4JaZRjjk28OkY3gj
         y5+XeOsr+cR91B2l7BHpUWpmWANBmzEynyTrbyho=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     notify@kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 1/2] ARM: dts: exynos: Use stdout-path property instead of console in bootargs
Date:   Mon,  8 Apr 2019 07:19:25 +0200
Message-Id: <20190408051926.462-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing bootargs with stdout-path property in chosen node allows using
early console by adding just 'earlycon' parameter to the kernel command
line.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412-trats2.dts    | 3 ++-
 arch/arm/boot/dts/exynos5250-smdk5250.dts  | 3 ++-
 arch/arm/boot/dts/exynos5260-xyref5260.dts | 2 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts  | 2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts  | 3 ++-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 327ee980d3a5..aac533933c61 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -22,6 +22,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySAC2,115200N8 root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
+		bootargs = "root=/dev/mmcblk0p5 rootwait earlyprintk panic=5";
+		stdout-path = "serial2:115200n8";
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index d5e66189ed2a..6dc96948a9cc 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -24,7 +24,8 @@
 	};
 
 	chosen {
-		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
+		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M init=/linuxrc";
+		stdout-path = "serial2:115200n8";
 	};
 
 	vdd: fixed-regulator-vdd {
diff --git a/arch/arm/boot/dts/exynos5260-xyref5260.dts b/arch/arm/boot/dts/exynos5260-xyref5260.dts
index fa19c59b2fb6..36a2b77eeb9d 100644
--- a/arch/arm/boot/dts/exynos5260-xyref5260.dts
+++ b/arch/arm/boot/dts/exynos5260-xyref5260.dts
@@ -19,7 +19,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySAC2,115200";
+		stdout-path = "serial2:115200n8";
 	};
 
 	fin_pll: xxti {
diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
index 8fc8c841d34b..dffa5e3ed90c 100644
--- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
+++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
@@ -19,7 +19,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySAC2,115200";
+		stdout-path = "serial2:115200n8";
 	};
 
 	fin_pll: xxti {
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index 3cf905047893..8240e5186972 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -21,7 +21,8 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySAC2,115200 init=/linuxrc";
+		bootargs = "init=/linuxrc";
+		stdout-path = "serial2:115200n8";
 	};
 
 	fixed-rate-clocks {
-- 
2.17.1

