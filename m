Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEB5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C6C213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbfCVNIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:08:06 -0400
Received: from vegas.theobroma-systems.com ([144.76.126.164]:57576 "EHLO
        mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730582AbfCVLfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:40 -0400
Received: from ip092042140082.rev.nessus.at ([92.42.140.82]:55276 helo=purcell.lan)
        by mail.theobroma-systems.com with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <christoph.muellner@theobroma-systems.com>)
        id 1h7ISG-0006u1-Jj; Fri, 22 Mar 2019 12:35:20 +0100
From:   Christoph Muellner <christoph.muellner@theobroma-systems.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de,
        shawn.lin@rock-chips.com
Cc:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Randy Li <ayaka@soulik.info>,
        Tony Xie <tony.xie@rock-chips.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH v3 2/4] dt-bindings: phy: Add a new property drive-impedance-ohm for RK's emmc PHY
Date:   Fri, 22 Mar 2019 12:34:51 +0100
Message-Id: <20190322113456.16324-2-christoph.muellner@theobroma-systems.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190322113456.16324-1-christoph.muellner@theobroma-systems.com>
References: <20190322113456.16324-1-christoph.muellner@theobroma-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents the new proprty drive-impedance-ohm for
Rockchip's eMMC PHY node.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
---
 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
index e3ea55763b0a..e728786f21e0 100644
--- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
+++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
@@ -7,12 +7,15 @@ Required properties:
  - reg: PHY register address offset and length in "general
    register files"
 
-Optional clocks using the clock bindings (see ../clock/clock-bindings.txt),
-specified by name:
+Optional properties:
  - clock-names: Should contain "emmcclk".  Although this is listed as optional
 		(because most boards can get basic functionality without having
 		access to it), it is strongly suggested.
+		See ../clock/clock-bindings.txt for details.
  - clocks: Should have a phandle to the card clock exported by the SDHCI driver.
+ - drive-impedance-ohm: Specifies the drive impedance in Ohm.
+                        Possible values are 33, 40, 50, 66 and 100.
+                        If not set, the default value of 50 will be applied.
 
 Example:
 
@@ -29,6 +32,7 @@ grf: syscon@ff770000 {
 		reg = <0xf780 0x20>;
 		clocks = <&sdhci>;
 		clock-names = "emmcclk";
+		drive-impedance-ohm = <50>;
 		#phy-cells = <0>;
 	};
 };
-- 
2.11.0

