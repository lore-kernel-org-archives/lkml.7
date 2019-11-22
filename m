Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2534C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4AE32071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574418916;
	bh=sqb++TXGGyVWzTbjaKuwOI/0PkCaHEm9xxhq7qwYYes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bh3bDOhJziYYlPnL3I1kYVQjB3OPU+MZeX2RU+Os9QeuxH3gb4MqwXBR0CNVF7Lsa
	 ECUzEjIvWghZVwC2jAwP2xbqq+1BCWRCsE71XGFmose0kUbmSoYW87OD4U2ElAbmdQ
	 gGv7H5KZbRD/yba02yOAz4i5U1SsGnObnbVICOVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfKVKfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:35:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:32966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbfKVKfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:35:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD96E20708;
        Fri, 22 Nov 2019 10:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574418912;
        bh=sqb++TXGGyVWzTbjaKuwOI/0PkCaHEm9xxhq7qwYYes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fjlmm52Cs8+QQOZtQywMkf3NLwm+kv2qergEdF5ndw1o/Qsyu8qy2xR015ot2wqyB
         hVJUgPBots2ZXtyLAvidnb/xJMVZDyxwRUh7oi3I8NSHv5vh/HsyYEUnVnftB6alF8
         K7+JRTEIlcPjycaV9gOsAyravc4vMavQjE+2p+U4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 094/159] arm64: dts: amd: Fix SPI bus warnings
Date:   Fri, 22 Nov 2019 11:28:05 +0100
Message-Id: <20191122100815.429043688@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100704.194776704@linuxfoundation.org>
References: <20191122100704.194776704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit e9f0878c4b2004ac19581274c1ae4c61ae3ca70e ]

dtc has new checks for SPI buses. Fix the warnings in node names.

arch/arm64/boot/dts/amd/amd-overdrive.dtb: Warning (spi_bus_bridge): /smb/ssp@e1030000: node name for SPI buses should be 'spi'
arch/arm64/boot/dts/amd/amd-overdrive-rev-b0.dtb: Warning (spi_bus_bridge): /smb/ssp@e1030000: node name for SPI buses should be 'spi'
arch/arm64/boot/dts/amd/amd-overdrive-rev-b1.dtb: Warning (spi_bus_bridge): /smb/ssp@e1030000: node name for SPI buses should be 'spi'

Cc: Brijesh Singh <brijeshkumar.singh@amd.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 2874d92881fda..a3030c868be5f 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -84,7 +84,7 @@
 			clock-names = "uartclk", "apb_pclk";
 		};
 
-		spi0: ssp@e1020000 {
+		spi0: spi@e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			#gpio-cells = <2>;
@@ -95,7 +95,7 @@
 			clock-names = "apb_pclk";
 		};
 
-		spi1: ssp@e1030000 {
+		spi1: spi@e1030000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			#gpio-cells = <2>;
-- 
2.20.1



