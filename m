Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9740FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6390623431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528027;
	bh=9OwpUQxQjkGWdwWltlQKTGXWR2s8Zhgbq2LrY6GIs8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UpKbYxHqfwuvIL0iHBbezwplh4eEjMPus5QDPkXnwzk421oczPf8aKRmJ4ehDMzKs
	 iGXR9tfn32D2VmSWvbc/TSVp5G3em9vukKjiENt8ryzk3OEBpwERB+pwHbyw6WzZ7l
	 e0SUMLg7ZA+RckiLjZTSXMXX9uCLl3fzLO1VcBPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730777AbfICQ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:27:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730255AbfICQ07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:26:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3BAC23789;
        Tue,  3 Sep 2019 16:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528018;
        bh=9OwpUQxQjkGWdwWltlQKTGXWR2s8Zhgbq2LrY6GIs8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyOSwxYQEt2hgOKtpyC+6/ihBkeqCj/Fts1aHJ1hyv6PzsJsb0IPWqy0VWgMHgLjQ
         ZvFd3d/jaQy4V7ml+OyELnRw+mV9W992rhmntfL2X9BEbF6FAL8FRrKje5+tKrBvI5
         U/kizBk4jC8S4lgGC9vHzdOyyRSE1yc68nch+IJI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Voytik <voytikd@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 055/167] arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64
Date:   Tue,  3 Sep 2019 12:23:27 -0400
Message-Id: <20190903162519.7136-55-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Voytik <voytikd@gmail.com>

[ Upstream commit 26e2d7b03ea7ff254bf78305aa44dda62e70b78e ]

After commit ef05bcb60c1a, boot from USB drives is broken.
Fix this problem by enabling usb-host regulators during boot time.

Fixes: ef05bcb60c1a ("arm64: dts: rockchip: fix vcc_host1_5v pin assign on rk3328-rock64")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Voytik <voytikd@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
index c142169a58fc5..e9147e35b7396 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -40,6 +40,7 @@
 		pinctrl-0 = <&usb30_host_drv>;
 		regulator-name = "vcc_host_5v";
 		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 	};
 
@@ -50,6 +51,7 @@
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
 		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 	};
 
-- 
2.20.1

