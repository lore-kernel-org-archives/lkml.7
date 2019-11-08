Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCA9FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C44206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215284;
	bh=c/ibTNbMklbkWTbukVx7j2j/iB5SSjr6ytTVhUTXei8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qxMDO48OvRKOoJbAu6wbz+JcQ4G0INU26S/h6WIFhj+LYed3kCR+SfLbaBGf7ZZFx
	 UszLkWSJXLWt5fB6Kc4dWbiBif7HPfQlKYhwv7pLxFeWrKCUW9gtR5TjuRXo5r92BH
	 e04sEqGNbm6Ae3jODt1H9w9EnMmGIKBjm5hudo/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392053AbfKHMOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:14:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732145AbfKHLiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89C7622466;
        Fri,  8 Nov 2019 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213083;
        bh=c/ibTNbMklbkWTbukVx7j2j/iB5SSjr6ytTVhUTXei8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BybzZFFxFZ/+W2qexF4BIxROzDqXLndHiVJxbSeLxjcqGNBfMq0oFJAn+jHS6731E
         KoBbyS1Z3vDCudKLYFo7Lslm0JlkMQKBXsCU+wmsC8aXiKjn8Akoofus4obIwUF1KL
         DKZbIVffVbtlEtszO/nyfP8SHes9zPNhmtvo7SgQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Martin Lucina <martin@lucina.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 009/205] arm64: dts: allwinner: a64: Olinuxino: fix DRAM voltage
Date:   Fri,  8 Nov 2019 06:34:36 -0500
Message-Id: <20191108113752.12502-9-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andre Przywara <andre.przywara@arm.com>

[ Upstream commit 93366b49a35f3a190052734b3f32c8fe2535b53f ]

The Olinuxino board uses DDR3L chips which are supposed to be driven
with 1.35V. The reset default of the AXP is properly set to 1.36V.

While technically the chips can also run at 1.5 volts, changing the
voltage on the fly while booting Linux is asking for trouble. Also
running at a lower voltage saves power.

So fix the DCDC5 value to match the actual board design.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Martin Lucina <martin@lucina.net>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index 3f531393eaee9..b3f186434f363 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -142,10 +142,14 @@
 
 /* DCDC3 is polyphased with DCDC2 */
 
+/*
+ * The board uses DDR3L DRAM chips. 1.36V is the closest to the nominal
+ * 1.35V that the PMIC can drive.
+ */
 &reg_dcdc5 {
 	regulator-always-on;
-	regulator-min-microvolt = <1500000>;
-	regulator-max-microvolt = <1500000>;
+	regulator-min-microvolt = <1360000>;
+	regulator-max-microvolt = <1360000>;
 	regulator-name = "vcc-ddr3";
 };
 
-- 
2.20.1

