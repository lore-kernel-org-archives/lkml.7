Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C04C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A6D218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355066;
	bh=1l3cfilLvsOisnoVcmhHfDyisf6xgAzHGWvzymanLQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2LrY0+Sew2Yq75/pBSncbrZH5NKGiaqaBhFKRaxS40Z7zZVAgq/aZdCHeH64uxG3k
	 d5saTrC+ezpTQKPJSm4rj/SBzDzeg4AYRhWybRdIA8uSYoMUzvNtavDHr8ElF3u60e
	 tFHXqK9e3qrL4AYNs4DFm67vY/ZEM0TrBJBXKyJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfDOTEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729519AbfDOTEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D92A21902;
        Mon, 15 Apr 2019 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355061;
        bh=1l3cfilLvsOisnoVcmhHfDyisf6xgAzHGWvzymanLQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EDjompcvuD6vthYxmAU6NE731tWuFyYhKfz/xyr8WmBrgldapZZssN/7/cPMFEOU1
         hUZOajELFOuiFhulHodBut1V39rR2U9rxFR4sSoA1Kh2kRWo0ZsqbXHytVDvZARowV
         Qv8nwdizyX0oKM2U6GVvquDIHc26IZoHImpHKl1E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.14 68/69] arm64: dts: rockchip: fix vcc_host1_5v pin assign on rk3328-rock64
Date:   Mon, 15 Apr 2019 20:59:26 +0200
Message-Id: <20190415183736.811764995@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Katsuhiro Suzuki <katsuhiro@katsuster.net>

commit ef05bcb60c1a8841e38c91923ba998181117a87c upstream.

This patch fixes pin assign of vcc_host1_5v. This regulator is
controlled by USB20_HOST_DRV signal.

ROCK64 schematic says that GPIO0_A2 pin is used as USB20_HOST_DRV.
GPIO0_D3 pin is for SPDIF_TX_M0.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -83,7 +83,7 @@
 	vcc_host1_5v: vcc_otg_5v: vcc-host1-5v-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
-		gpio = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
@@ -275,7 +275,7 @@
 
 	usb2 {
 		usb20_host_drv: usb20-host-drv {
-			rockchip,pins = <0 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
 


