Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB98C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44393206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380219;
	bh=p9mHRsmfBsXdcwHg/vnu6HtpVEgWh8FoLp6eVRBalP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wEDft5QuEeQpEUMA4WcZVWjbcT1AMUZo0lETPj1RLH8i8YzyV4CUlLOtoJyK2d1yE
	 nuTWBTMHq1dBBEjMxchcpPbilIC6z8LWEv4vykJBy0mLf7ZVp3O2W7N86nkccyzeeq
	 UU2APPgySf2VSJesRQcGA00A51365tnkvlbx7A+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388726AbfIMNKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388711AbfIMNKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:10:15 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25F0F208C0;
        Fri, 13 Sep 2019 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380214;
        bh=p9mHRsmfBsXdcwHg/vnu6HtpVEgWh8FoLp6eVRBalP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B4G6VmpzCc9awfX4TuJZ+8iCMPiB6nc/2jFG9lewX9nhGLqP6RMg4ZyXf2fj7PooB
         hbXkbU4qknMMNEmCkgQ+e8pmLYoll0SSVzJyNrhAaiHP8WETZPrUJXUzfVCNeyOKHi
         KKeQ1uOUSNEslavztNSDNLuNc8/w5NAdYjbDXUs8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Voytik <voytikd@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 16/21] arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-rock64
Date:   Fri, 13 Sep 2019 14:07:09 +0100
Message-Id: <20190913130508.059005072@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130501.285837292@linuxfoundation.org>
References: <20190913130501.285837292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index e720f40bbd5d7..3f8f528099a80 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
@@ -77,6 +77,7 @@
 		pinctrl-0 = <&usb30_host_drv>;
 		regulator-name = "vcc_host_5v";
 		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 	};
 
@@ -87,6 +88,7 @@
 		pinctrl-0 = <&usb20_host_drv>;
 		regulator-name = "vcc_host1_5v";
 		regulator-always-on;
+		regulator-boot-on;
 		vin-supply = <&vcc_sys>;
 	};
 
-- 
2.20.1



