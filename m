Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923B9C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6282B21670
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567614055;
	bh=x4pvz7O8pF8aUNF3Co/a77ewOodvm2ER0JvB/S8Lq5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gllJGY2f28wGa5nD3aqB4i7lXARtM8a1aVOlO/u3o5VLpnGsxSdrDU0rhvchv4Ev/
	 KwJ5fgI970V40qDInuJHDJyH99rNyoq/uiDw62x324rY5R56r5Vdw+M8p9LeZFrh2v
	 vns6YqGWI7NzVIZJpb4YpjsoYbdwlWUITo6Mi6Q4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731621AbfIDP5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:59360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbfIDP5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:57:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC2872339D;
        Wed,  4 Sep 2019 15:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612664;
        bh=x4pvz7O8pF8aUNF3Co/a77ewOodvm2ER0JvB/S8Lq5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTsp0RPZrA/9J+BZSdJVTflAti3C7Pi72pp9AZ/jLwS8M9UO3KR9wuAoF0JHAEuhu
         JWWbHHz0Vr3i3vwVxTR3bG26Mw/gxQyI7IowkB0r4/f+rV316QmvKMMWmnOlS/7ZTt
         aixN9iWugCvgT2jHcIPbSt/FQ3htzYRyxuhIKlIQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Faiz Abbas <faiz_abbas@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 03/94] ARM: dts: am57xx: Disable voltage switching for SD card
Date:   Wed,  4 Sep 2019 11:56:08 -0400
Message-Id: <20190904155739.2816-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

[ Upstream commit fb59ee37cfe20d10d19568899d1458a58361246c ]

If UHS speed modes are enabled, a compatible SD card switches down to
1.8V during enumeration. If after this a software reboot/crash takes
place and on-chip ROM tries to enumerate the SD card, the difference in
IO voltages (host @ 3.3V and card @ 1.8V) may end up damaging the card.

The fix for this is to have support for power cycling the card in
hardware (with a PORz/soft-reset line causing a power cycle of the
card). Because the beaglebone X15 (rev A,B and C), am57xx-idks and
am57xx-evms don't have this capability, disable voltage switching for
these boards.

The major effect of this is that the maximum supported speed
mode is now high speed(50 MHz) down from SDR104(200 MHz).

commit 88a748419b84 ("ARM: dts: am57xx-idk: Remove support for voltage
switching for SD card") did this only for idk boards. Do it for all
affected boards.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am571x-idk.dts                | 7 +------
 arch/arm/boot/dts/am572x-idk.dts                | 7 +------
 arch/arm/boot/dts/am574x-idk.dts                | 7 +------
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 1 +
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   | 7 +------
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts    | 7 +------
 6 files changed, 6 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/am571x-idk.dts b/arch/arm/boot/dts/am571x-idk.dts
index 1d5e99964bbf8..0aaacea1d887b 100644
--- a/arch/arm/boot/dts/am571x-idk.dts
+++ b/arch/arm/boot/dts/am571x-idk.dts
@@ -175,14 +175,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50_rev20 &mmc1_iodelay_ddr50_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am572x-idk.dts b/arch/arm/boot/dts/am572x-idk.dts
index c65d7f6d3b5a6..ea1c119feaa57 100644
--- a/arch/arm/boot/dts/am572x-idk.dts
+++ b/arch/arm/boot/dts/am572x-idk.dts
@@ -16,14 +16,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev20_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am574x-idk.dts b/arch/arm/boot/dts/am574x-idk.dts
index dc5141c35610e..7935d70874ce2 100644
--- a/arch/arm/boot/dts/am574x-idk.dts
+++ b/arch/arm/boot/dts/am574x-idk.dts
@@ -24,14 +24,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default_no_clk_pu>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_default>;
-	pinctrl-3 = <&mmc1_pins_hs>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_conf>;
-	pinctrl-6 = <&mmc1_pins_ddr50 &mmc1_iodelay_sdr104_conf>;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index d02f5fa61e5f5..d50de7a6ea6c5 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -430,6 +430,7 @@
 
 	bus-width = <4>;
 	cd-gpios = <&gpio6 27 GPIO_ACTIVE_LOW>; /* gpio 219 */
+	no-1-8-v;
 };
 
 &mmc2 {
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
index a374b5cd6db0e..7b113b52c3fb6 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts
@@ -16,14 +16,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev11_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev11_conf>;
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&ldo1_reg>;
 };
diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
index 4badd2144db9a..30c500b15b219 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
@@ -16,14 +16,9 @@
 };
 
 &mmc1 {
-	pinctrl-names = "default", "hs", "sdr12", "sdr25", "sdr50", "ddr50", "sdr104";
+	pinctrl-names = "default", "hs";
 	pinctrl-0 = <&mmc1_pins_default>;
 	pinctrl-1 = <&mmc1_pins_hs>;
-	pinctrl-2 = <&mmc1_pins_sdr12>;
-	pinctrl-3 = <&mmc1_pins_sdr25>;
-	pinctrl-4 = <&mmc1_pins_sdr50>;
-	pinctrl-5 = <&mmc1_pins_ddr50 &mmc1_iodelay_ddr_rev20_conf>;
-	pinctrl-6 = <&mmc1_pins_sdr104 &mmc1_iodelay_sdr104_rev20_conf>;
 	vmmc-supply = <&vdd_3v3>;
 	vqmmc-supply = <&ldo1_reg>;
 };
-- 
2.20.1

