Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9052E213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414373;
	bh=tBytdoyxnjGlMbp8U8DLJaRiqW+ZMyXx2dtpRvwLuK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LpJxG9/SYPsSKiubd2UXlrOBMVcurteFIgVil7ieqGO+D1w2OHVLDmMC7t1May749
	 Tzn5SpyK50jtoVoqY638bT3ARDSftP5mqUsnGMGJ3ZbxvvSEz7JOFH/31uViYmk131
	 En3YGzVLdBhwAdQBkmLrnfxhoFU1t1c6ssi7HJPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfCLSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:12:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbfCLRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:33 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22A4021773;
        Tue, 12 Mar 2019 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410693;
        bh=tBytdoyxnjGlMbp8U8DLJaRiqW+ZMyXx2dtpRvwLuK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r2o5aKfaESZTWO/RskXfbxjaRdbxjUqytso1P4+02Inztvhr935bO6iwcCT5EotHq
         9c+UgAgWZ1agv6CBrCvLXZBDTkpmU8wN/jnawK88aRCKcbxDEuVp8BQnKaYI1DLcQJ
         HMHJ0QjIkn2/w5+R+DNwN+6Ci8NVkFucPhSKmmeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Markus Reichl <m.reichl@fivetechno.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.0 10/25] ARM: dts: exynos: Fix pinctrl definition for eMMC RTSN line on Odroid X2/U3
Date:   Tue, 12 Mar 2019 10:08:48 -0700
Message-Id: <20190312170404.317770398@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit ec33745bccc8f336957c751f4153421cc9ef5a54 upstream.

Commit 225da7e65a03 ("ARM: dts: add eMMC reset line for
exynos4412-odroid-common") added MMC power sequence for eMMC card of
Odroid X2/U3. It reused generic sd1_cd pin control configuration node
and only disabled pull-up. However that time the pinctrl configuration
was not applied during MMC power sequence driver initialization. This
has been changed later by commit d97a1e5d7cd2 ("mmc: pwrseq: convert to
proper platform device").

It turned out then, that the provided pinctrl configuration is not
correct, because the eMMC_RTSN line is being re-configured as 'special
function/card detect function for mmc1 controller' not the simple
'output', thus the power sequence driver doesn't really set the pin
value. This in effect broke the reboot of Odroid X2/U3 boards. Fix this
by providing separate node with eMMC_RTSN pin configuration.

Cc: <stable@vger.kernel.org>
Reported-by: Markus Reichl <m.reichl@fivetechno.de>
Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Fixes: 225da7e65a03 ("ARM: dts: add eMMC reset line for exynos4412-odroid-common")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -49,7 +49,7 @@
 	};
 
 	emmc_pwrseq: pwrseq {
-		pinctrl-0 = <&sd1_cd>;
+		pinctrl-0 = <&emmc_rstn>;
 		pinctrl-names = "default";
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpk1 2 GPIO_ACTIVE_LOW>;
@@ -165,12 +165,6 @@
 	cpu0-supply = <&buck2_reg>;
 };
 
-/* RSTN signal for eMMC */
-&sd1_cd {
-	samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
-	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
-};
-
 &pinctrl_1 {
 	gpio_power_key: power_key {
 		samsung,pins = "gpx1-3";
@@ -188,6 +182,11 @@
 		samsung,pins = "gpx3-7";
 		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
 	};
+
+	emmc_rstn: emmc-rstn {
+		samsung,pins = "gpk1-2";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
 };
 
 &ehci {


