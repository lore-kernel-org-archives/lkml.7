Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB9BC06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C87C2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 00:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfGAAnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 20:43:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:53060 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726472AbfGAAno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 20:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C71F0AE21;
        Mon,  1 Jul 2019 00:43:42 +0000 (UTC)
From:   NeilBrown <neil@brown.name>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 01 Jul 2019 10:43:07 +1000
Subject: [PATCH 2/2] staging: mt7621-dts: add support for second network
 interface
Cc:     devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>
Message-ID: <156194178766.1430.12784163026696670896.stgit@noble.brown>
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

The mt7621 has two network interfaces, one that connects to an
internal switch, and one that can connect to either that switch
or an external phy, or possibly an internal phy.

The Gnubee-PC2 has an external phy for use with the second interface.

This patch add some support for the second interface to mt7621.dtsi
and add a gbpc2.dts which makes use of this.  This allows the second
interface to be used.

I don't fully understand how to configure this interface - the
documentation is thin - so there could well be room for improvement
here.

Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/mt7621-dts/Kconfig     |    7 ++++++-
 drivers/staging/mt7621-dts/Makefile    |    1 +
 drivers/staging/mt7621-dts/gbpc1.dts   |    2 +-
 drivers/staging/mt7621-dts/gbpc2.dts   |   21 +++++++++++++++++++++
 drivers/staging/mt7621-dts/mt7621.dtsi |   12 ++++++++----
 5 files changed, 37 insertions(+), 6 deletions(-)
 create mode 100644 drivers/staging/mt7621-dts/gbpc2.dts

diff --git a/drivers/staging/mt7621-dts/Kconfig b/drivers/staging/mt7621-dts/Kconfig
index 3ea08ab9d0d3..6932ab7acadf 100644
--- a/drivers/staging/mt7621-dts/Kconfig
+++ b/drivers/staging/mt7621-dts/Kconfig
@@ -1,6 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0
 config DTB_GNUBEE1
-	bool "GnuBee1 NAS"
+	bool "GnuBee1 2.5inch NAS"
+	depends on SOC_MT7621 && DTB_RT_NONE
+	select BUILTIN_DTB
+
+config DTB_GNUBEE2
+	bool "GnuBee2 3.5inch NAS"
 	depends on SOC_MT7621 && DTB_RT_NONE
 	select BUILTIN_DTB
 
diff --git a/drivers/staging/mt7621-dts/Makefile b/drivers/staging/mt7621-dts/Makefile
index aeec48a4edc7..b4ab99fed932 100644
--- a/drivers/staging/mt7621-dts/Makefile
+++ b/drivers/staging/mt7621-dts/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 dtb-$(CONFIG_DTB_GNUBEE1)      += gbpc1.dtb
+dtb-$(CONFIG_DTB_GNUBEE2)      += gbpc2.dtb
 
 obj-y				+= $(patsubst %.dtb, %.dtb.o, $(dtb-y))
diff --git a/drivers/staging/mt7621-dts/gbpc1.dts b/drivers/staging/mt7621-dts/gbpc1.dts
index 250c15ace2a7..1fb560ff059c 100644
--- a/drivers/staging/mt7621-dts/gbpc1.dts
+++ b/drivers/staging/mt7621-dts/gbpc1.dts
@@ -119,7 +119,7 @@
 
 &pinctrl {
 	state_default: pinctrl0 {
-		gpio {
+		default_gpio: gpio {
 			groups = "wdt", "rgmii2", "uart3";
 			function = "gpio";
 		};
diff --git a/drivers/staging/mt7621-dts/gbpc2.dts b/drivers/staging/mt7621-dts/gbpc2.dts
new file mode 100644
index 000000000000..52760e7351f6
--- /dev/null
+++ b/drivers/staging/mt7621-dts/gbpc2.dts
@@ -0,0 +1,21 @@
+/dts-v1/;
+
+#include "gbpc1.dts"
+
+/ {
+	compatible = "gnubee,gb-pc2", "mediatek,mt7621-soc";
+	model = "GB-PC2";
+};
+
+&default_gpio {
+	groups = "wdt", "uart3";
+	function = "gpio";
+};
+
+&gmac1 {
+	status = "ok";
+};
+
+&phy_external {
+	status = "ok";
+};
diff --git a/drivers/staging/mt7621-dts/mt7621.dtsi b/drivers/staging/mt7621-dts/mt7621.dtsi
index 549ff5a0699e..a4c08110094b 100644
--- a/drivers/staging/mt7621-dts/mt7621.dtsi
+++ b/drivers/staging/mt7621-dts/mt7621.dtsi
@@ -427,16 +427,20 @@
 			compatible = "mediatek,eth-mac";
 			reg = <1>;
 			status = "off";
-			phy-mode = "rgmii";
-			phy-handle = <&phy5>;
+			phy-mode = "rgmii-rxid";
+			phy-handle = <&phy_external>;
 		};
 		mdio-bus {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			phy5: ethernet-phy@5 {
+			phy_external: ethernet-phy@5 {
+				status = "off";
 				reg = <5>;
-				phy-mode = "rgmii";
+				phy-mode = "rgmii-rxid";
+
+				pinctrl-names = "default";
+				pinctrl-0 = <&rgmii2_pins>;
 			};
 
 			switch0: switch0@0 {


