Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475C9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A74218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116763;
	bh=4CR2co9QDeM2sqBObX24OTDizYn3UMzcVDWciRdYp7Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=f4RG1od7vV9bKeFkgaHRnIlosdud74K8xLmiOKtD6x4bacdIVdf5gN49NLfpVh9KR
	 DigQ+diluLPEgv0VMy1a4xNHqjgnZTETTRjA2VW62y/36BBke268UHFHU4HcphdvXI
	 snQyViakV/SJiknBU5nMDyXe3/qM1FymsrLMiiLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbfDXOjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731484AbfDXOjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:39:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6CE6218FE;
        Wed, 24 Apr 2019 14:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116755;
        bh=4CR2co9QDeM2sqBObX24OTDizYn3UMzcVDWciRdYp7Y=;
        h=From:To:Cc:Subject:Date:From;
        b=Fqy9+QLf75atkVNo0nux+CqrBqCiQYz78nzFnpbQTVBg75r3lClv6xYAKED4kXvON
         5n9a0BBt8UQRvJqbJhNd5340r6jGze1vnXvAX7gSqZBI4Gz7/zJ2JG2wOVZpVtvQou
         Hso+3Gz/VUYQgvs794IPO6FqucplFCFHjNLGnJlA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 01/52] arm64: dts: rockchip: fix rk3328-roc-cc gmac2io tx/rx_delay
Date:   Wed, 24 Apr 2019 10:38:19 -0400
Message-Id: <20190424143911.28890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Leonidas P. Papadakos" <papadakospan@gmail.com>

[ Upstream commit 924726888f660b2a86382a5dd051ec9ca1b18190 ]

The rk3328-roc-cc board exhibits tx stability issues with large packets,
as does the rock64 board, which was fixed with this patch
https://patchwork.kernel.org/patch/10178969/

A similar patch was merged for the rk3328-roc-cc here
https://patchwork.kernel.org/patch/10804863/
but it doesn't include the tx/rx_delay tweaks, and I find that they
help with an issue where large transfers would bring the ethernet
link down, causing a link reset regularly.

Signed-off-by: Leonidas P. Papadakos <papadakospan@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 246c317f6a68..91061d9cf78b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -94,8 +94,8 @@
 	snps,reset-gpio = <&gpio1 RK_PC2 GPIO_ACTIVE_LOW>;
 	snps,reset-active-low;
 	snps,reset-delays-us = <0 10000 50000>;
-	tx_delay = <0x25>;
-	rx_delay = <0x11>;
+	tx_delay = <0x24>;
+	rx_delay = <0x18>;
 	status = "okay";
 };
 
-- 
2.19.1

