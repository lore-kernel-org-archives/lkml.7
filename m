Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC2EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AD521655
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153328;
	bh=3GcbrGHkMX6rPWyyfZFHFlN5ULYIIE5qIZaKRc4no4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWARqxP8eGdOG3mrbHC38UkLxrEjjYZkdsihJaav2jl5ijKooT1FVolk37uM66BIc
	 Eg9B6JY+Sdv7vkSKbFxg42r70YeIsstvydsQlIJvnw2kJcsseytoBqIUqAO2L0QoPP
	 nUXmK14ncRdtvm2FBDCT2uXSGgZw/UezZq95bwUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfEFOf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:35:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfEFOfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:35:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D95921655;
        Mon,  6 May 2019 14:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153324;
        bh=3GcbrGHkMX6rPWyyfZFHFlN5ULYIIE5qIZaKRc4no4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dQX3omvSIJie/FN9u/OgJsDuGWtWEpne+HIvCmFNCyPMDXyeUxHA0FTDpD42/SPQQ
         /rBGUXIn5BqbSKHirb1tuUbMR3UD4okJ1/Z0rRbxVxXG3z1mgXRc+gmNP11maApGvQ
         VlYzo3CtUz/TewvxoDcC9ncvZya8J90kmlSF/n14=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Leonidas P. Papadakos" <papadakospan@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 025/122] arm64: dts: rockchip: fix rk3328-roc-cc gmac2io tx/rx_delay
Date:   Mon,  6 May 2019 16:31:23 +0200
Message-Id: <20190506143057.015219799@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
index 99d0d9912950..a91f87df662e 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
@@ -107,8 +107,8 @@
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
2.20.1



