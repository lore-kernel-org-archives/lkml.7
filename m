Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC70C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7646E21D7E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 07:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404463AbfIFHEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 03:04:41 -0400
Received: from mail.thundersoft.com ([114.242.213.35]:59732 "EHLO
        mail1.thundersoft.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2404262AbfIFHEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 03:04:41 -0400
Received: from localhost (unknown [192.168.122.240])
        by mail1.thundersoft.com (Postfix) with ESMTPA id 94E6517455F5;
        Fri,  6 Sep 2019 15:04:38 +0800 (CST)
From:   shifu0704@thundersoft.com
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     dmurphy@ti.com, navada@ti.com,
        Frank Shi <shifu0704@thundersoft.com>
Subject: [PATCH] tas2770: add tas2770 smart PA dt bindings
Date:   Fri,  6 Sep 2019 15:06:03 +0800
Message-Id: <1567753564-13699-1-git-send-email-shifu0704@thundersoft.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Shi <shifu0704@thundersoft.com>

add tas2770 smart PA dt bindings

Signed-off-by: Frank Shi <shifu0704@thundersoft.com>
---
 Documentation/devicetree/bindings/tas2770.txt | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/tas2770.txt

diff --git a/Documentation/devicetree/bindings/tas2770.txt b/Documentation/devicetree/bindings/tas2770.txt
new file mode 100644
index 0000000..f70b310
--- /dev/null
+++ b/Documentation/devicetree/bindings/tas2770.txt
@@ -0,0 +1,38 @@
+Texas Instruments TAS2770 Smart PA
+
+The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
+efficiently driving high peak power into small loudspeakers.
+Integrated speaker voltage and current sense provides for
+real time monitoring of loudspeaker behavior.
+
+Required properties:
+
+ - compatible:	   - Should contain "ti,tas2770".
+ - reg:		       - The i2c address. Should contain <0x4c>, <0x4d>,<0x4e>, or <0x4f>.
+ - #address-cells  - Should be <1>.
+ - #size-cells     - Should be <0>.
+ - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
+ - ti,left-slot:   - Sets TDM RX left time slots.
+ - ti,right-slot:  - Sets TDM RX right time slots.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+ - ti,vmon-slot-no:- TDM TX voltage sense time slot.
+
+Optional properties:
+
+ - reset-gpio:	Reset GPIO number of left device.
+ - irq-gpio:  IRQ GPIO number of left device.
+
+Examples:
+
+    tas2770@4c {
+                compatible = "ti,tas2770";
+                reg = <0x4c>;
+                reset-gpio = <&gpio15 1 GPIO_ACTIVE_LOW>;
+                irq-gpio = <&gpio16 1 GPIO_ACTIVE_LOW>;
+                ti,asi-format = <0>;
+                ti,left-slot = <0>;
+                ti,right-slot = <1>;
+                ti,imon-slot-no = <0>;
+                ti,vmon-slot-no = <2>;
+        };
+
-- 
2.7.4

