Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D618C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205092070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c3Y+k5fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfJHSQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:16:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54948 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHSQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:16:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x98IFZYd055295;
        Tue, 8 Oct 2019 13:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570558535;
        bh=MHbt/egTxGNc/lCwyNbm8rdYzujVZ7DY1baO8ocVABU=;
        h=From:To:CC:Subject:Date;
        b=c3Y+k5fgd7o03DtgIecpJ/TGaYIJGTN0hde/Hu9HP21ivAvfZjAR1Ej1ZJJ/XE1L6
         HKJQrAhfAZyVGu4GLaEEjfgtY7u0vlZ5E12Fos/zlSNhfsz9UI38rlD2FwzH/GdKza
         OtOaDPet+pflnPMTxUc8wzLPMsCDRKOlogeoJTKo=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x98IFZ72085052
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Oct 2019 13:15:35 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 8 Oct
 2019 13:15:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 8 Oct 2019 13:15:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x98IFZD4029023;
        Tue, 8 Oct 2019 13:15:35 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <navada@ti.com>, <perex@perex.cz>,
        <tiwai@suse.com>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] ASoc: Add Texas Instruments TAS2562 amplifier binding
Date:   Tue, 8 Oct 2019 13:15:16 -0500
Message-ID: <20191008181517.5332-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding for the TAS2562 amplifier.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2562.txt     | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
new file mode 100644
index 000000000000..658e1fb18a99
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas2562.txt
@@ -0,0 +1,34 @@
+Texas Instruments TAS2562 Smart PA
+
+The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
+efficiently driving high peak power into small loudspeakers.
+Integrated speaker voltage and current sense provides for
+real time monitoring of loudspeaker behavior.
+
+Required properties:
+ - #address-cells  - Should be <1>.
+ - #size-cells     - Should be <0>.
+ - compatible:	   - Should contain "ti,tas2562".
+ - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
+ - ti,imon-slot-no:- TDM TX current sense time slot.
+
+Optional properties:
+- interrupt-parent: phandle to the interrupt controller which provides
+                    the interrupt.
+- interrupts: (GPIO) interrupt to which the chip is connected.
+- shut-down: GPIO used to control the state of the device.
+
+Examples:
+tas2562@4c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "ti,tas2562";
+        reg = <0x4c>;
+
+        interrupt-parent = <&gpio1>;
+        interrupts = <14>;
+
+	shut-down = <&gpio1 15 0>;
+        ti,imon-slot-no = <0>;
+};
+
-- 
2.22.0.214.g8dca754b1e

