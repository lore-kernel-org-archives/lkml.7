Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69AFC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8DB32145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfGAAni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 20:43:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:53048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbfGAAni (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 20:43:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2396EAE07;
        Mon,  1 Jul 2019 00:43:37 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 01 Jul 2019 10:43:07 +1000
Subject: [PATCH 1/2] staging: mt7621-dts: update sdhci config.
Cc:     devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>
Message-ID: <156194178761.1430.1625105851941268306.stgit@noble.brown>
In-Reply-To: <156194175140.1430.2478988354194078582.stgit@noble.brown>
References: <156194175140.1430.2478988354194078582.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mtk-sd driver has been updated to support
the IP in the mt7621, so update our configuration
to work with it.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-dts/mt7621.dtsi |   41 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 9c90cac82efc..549ff5a0699e 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -43,6 +43,30 @@
 		clock-frequency = <220000000>;
 	};
 
+	mmc_clock: mmc_clock@0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <48000000>;
+	};
+
+	mmc_fixed_3v3: fixedregulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_power";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		regulator-always-on;
+	  };
+
+	  mmc_fixed_1v8_io: fixedregulator@1 {
+		compatible = "regulator-fixed";
+		regulator-name = "mmc_io";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		enable-active-high;
+		regulator-always-on;
+	};
+
 	palmbus: palmbus@1E000000 {
 		compatible = "palmbus";
 		reg = <0x1E000000 0x100000>;
@@ -299,9 +323,24 @@
 	sdhci: sdhci@1E130000 {
 		status = "disabled";
 
-		compatible = "ralink,mt7620-sdhci";
+		compatible = "mediatek,mt7620-mmc";
 		reg = <0x1E130000 0x4000>;
 
+		bus-width = <4>;
+		max-frequency = <48000000>;
+		cap-sd-highspeed;
+		cap-mmc-highspeed;
+		vmmc-supply = <&mmc_fixed_3v3>;
+		vqmmc-supply = <&mmc_fixed_1v8_io>;
+		disable-wp;
+
+		pinctrl-names = "default", "state_uhs";
+		pinctrl-0 = <&sdhci_pins>;
+		pinctrl-1 = <&sdhci_pins>;
+
+		clocks = <&mmc_clock &mmc_clock>;
+		clock-names = "source", "hclk";
+
 		interrupt-parent = <&gic>;
 		interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
 	};


