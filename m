Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F598C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6FA20637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419221;
	bh=WGnB8l6nh78KgnYEQaV1JLhwTwx6oRVh2j+0HHYbXbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jZNog6WoW05yxQ8gqw9iHdIuOMZ6cILxcZM1k0b/YgaZcb16TAvGFWKIYBdxgORpU
	 8mLtrxhR5PnIHy1HgvPBgXuq2cjpDI/7hzDt3kgY+S3OrrgcsMmiKe+7HJC+GIY2h3
	 yae/gjAe8Imrk4CN1Lf+Na/Q7lY7td3yuI0uJoF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfKVKkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:44060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728280AbfKVKkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:40:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6B8620717;
        Fri, 22 Nov 2019 10:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419218;
        bh=WGnB8l6nh78KgnYEQaV1JLhwTwx6oRVh2j+0HHYbXbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJe3hvxTsVadiOjVcvrW4UWRWuIbBvU7eBAmPqvqbTNkMd9NEM0kBF7h6qDbve6no
         bj2O6e08dWxREQBlwxB1Oe2sptQmCuJ7UZsFIh1vHFidrrw7K34MA/aoICvEqGnYje
         mt0svrgAzJoZeOLtbGQolyanbfdneIES9ZtDSTBE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 038/222] ARM: dts: exynos: Disable pull control for S5M8767 PMIC
Date:   Fri, 22 Nov 2019 11:26:18 +0100
Message-Id: <20191122100848.389084910@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit ef2ecab9af5feae97c47b7f61cdd96f7f49b2c23 ]

S5M8767 PMIC interrupt line on Exynos5250-based Arndale board has
external pull-up resistors, so disable any pull control for it in
in controller node. This fixes support for S5M8767 interrupts and
enables operation of wakeup from S5M8767 RTC alarm.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5250-arndale.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 6098dacd09f11..1b2709af2a42b 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -170,6 +170,8 @@
 		reg = <0x66>;
 		interrupt-parent = <&gpx3>;
 		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&s5m8767_irq>;
 
 		vinb1-supply = <&main_dc_reg>;
 		vinb2-supply = <&main_dc_reg>;
@@ -547,6 +549,13 @@
 	cap-sd-highspeed;
 };
 
+&pinctrl_0 {
+	s5m8767_irq: s5m8767-irq {
+		samsung,pins = "gpx3-2";
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.20.1



