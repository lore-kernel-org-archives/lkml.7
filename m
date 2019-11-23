Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A05EC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCDD2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfKWUi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:38:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:34350 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726752AbfKWUiM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:38:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C9A29B00A;
        Sat, 23 Nov 2019 20:38:10 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 4/8] ARM: dts: rtd1195: Exclude boot ROM from memory ranges
Date:   Sat, 23 Nov 2019 21:37:55 +0100
Message-Id: <20191123203759.20708-5-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191123203759.20708-1-afaerber@suse.de>
References: <20191123203759.20708-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carve out 0xa800 for the boot ROM from the /memory@0 node,
updating it to /memory@a800, and add it to /soc ranges.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Could be squashed.
 
 v4: New
 
 arch/arm/boot/dts/rtd1195-mele-x1000.dts | 4 ++--
 arch/arm/boot/dts/rtd1195.dtsi           | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rtd1195-mele-x1000.dts b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
index e2050cb64474..c7951b9a2c97 100644
--- a/arch/arm/boot/dts/rtd1195-mele-x1000.dts
+++ b/arch/arm/boot/dts/rtd1195-mele-x1000.dts
@@ -19,9 +19,9 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@0 {
+	memory@a800 {
 		device_type = "memory";
-		reg = <0x00000000 0x18000000>, /* up to r-bus */
+		reg = <0x0000a800 0x17ff5800>, /* boot ROM to r-bus */
 		      <0x18070000 0x00090000>, /* r-bus to NOR flash */
 		      <0x19100000 0x26f00000>; /* NOR flash to 1 GiB */
 	};
diff --git a/arch/arm/boot/dts/rtd1195.dtsi b/arch/arm/boot/dts/rtd1195.dtsi
index c5713a5ef472..0d7c2be750f6 100644
--- a/arch/arm/boot/dts/rtd1195.dtsi
+++ b/arch/arm/boot/dts/rtd1195.dtsi
@@ -88,7 +88,8 @@
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-		ranges = <0x18000000 0x18000000 0x00070000>,
+		ranges = <0x00000000 0x00000000 0x0000a800>,
+			 <0x18000000 0x18000000 0x00070000>,
 			 <0x18100000 0x18100000 0x01000000>,
 			 <0x80000000 0x80000000 0x80000000>;
 
-- 
2.16.4

