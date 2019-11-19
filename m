Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE77C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FA821939
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574143203;
	bh=dEzwLHn/gns28QI/I6DAD2PkbwsGSScjoL8rw/ea1jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0w3qh4f8gYi47NF4ZJecFAe2Dnu2VOU6iPatFleKPULx2jbdE/kM+munFDvHIL4mB
	 lXFJlmkQLo8l3Z/vubFJm9+iaotSk9g+qtD7V22VWIWn3SHEw2XDPQ2X954Ef7dq6m
	 A4dgStYY25qiTyIZlFQULKirMHG69ud+T4wnPgRc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfKSGAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 01:00:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:42668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731108AbfKSFqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:46:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB8002071B;
        Tue, 19 Nov 2019 05:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142391;
        bh=dEzwLHn/gns28QI/I6DAD2PkbwsGSScjoL8rw/ea1jA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irUCiiCAoKZ2hefWbTUxQR3TIbKnIEEegJLRaY7wDI2nJMCYYqqgRir7Yvbj8iSFk
         MYCKvuvGLz59ZJOU+38pys+7DDzBNCp66GlHCAN1lLOBrlwUMzwrDCNRW8bZlNXS8P
         OTkOwikBsmHc/Z7Y8gNxL10oWxnvJjqf8NoKlz+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 065/239] ARM: dts: meson8b: fix the clock controller register size
Date:   Tue, 19 Nov 2019 06:17:45 +0100
Message-Id: <20191119051311.987520432@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit f31094fe8c16fbd2ca47921acf93b744b045aace ]

The clock controller registers are not 0x460 wide because the reset
controller starts at CBUS 0x4404. This currently overlaps with the
clock controller (which is at CBUS 0x4000).

There is no public documentation available on the actual size of the
clock controller's register area (also called "HHI"). However, in
Amlogic's GPL kernel sources the last "HHI" register is
HHI_HDMI_PHY_CNTL2 at CBUS + 0x43a8. 0x400 was chosen because that size
doesn't seem unlikely.

Fixes: 4a69fcd3a10803 ("ARM: meson: Add DTS for Odroid-C1 and Tronfy MXQ boards")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/meson8b.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index bc278da7df0d9..0f76da280ee76 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -121,7 +121,7 @@
 		#clock-cells = <1>;
 		#reset-cells = <1>;
 		compatible = "amlogic,meson8b-clkc";
-		reg = <0x8000 0x4>, <0x4000 0x460>;
+		reg = <0x8000 0x4>, <0x4000 0x400>;
 	};
 
 	reset: reset-controller@4404 {
-- 
2.20.1



