Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14857C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA24B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505524;
	bh=L0Enbu1fZ7K+UDS99HWcRdeF+WzSsW51aiihSnv1XEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1U6DYefwvdlqqoG0l5L/3gBuBnSVsEQ5bj06cYgGj64abyfAP3v5W274Ka7Z+jSB0
	 nf2GLFQ8sFrkoWaL+KtwDQ5sJGIBXqSXSZk0FLZp94vBOtNZ54AqdvlNMNvcmvL+vk
	 7WxyWwVtul/V0+wxP89FFNAwuvJjZifV9fUtw/sQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfCMTLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727412AbfCMTLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02E742173C;
        Wed, 13 Mar 2019 19:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504277;
        bh=L0Enbu1fZ7K+UDS99HWcRdeF+WzSsW51aiihSnv1XEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ox2svcknfZTWWUoPOqt+uusSgBOLT+FxL7q4KaQWHmcsgifeP+WeSX+Y4cxPhQ7sh
         AE9iuHWD0XCviK4qrgE1e7LDMYlk0S+R4ngFGOpxP90dGHjfEsl+P9gIWpNdQ2sdDM
         kGcK4rwMsrOz04Q72l6yceGqlnZ3DV6yE+X3uv7Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 27/60] ARM: dts: armada-xp: fix Armada XP boards NAND description
Date:   Wed, 13 Mar 2019 15:09:48 -0400
Message-Id: <20190313191021.158171-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

[ Upstream commit 6fc979179c98d2591784937d5618edc3e5cd31c1 ]

Commit 3b79919946cd2cf4dac47842afc9a893acec4ed7 ("ARM: dts:
armada-370-xp: update NAND node with new bindings") updated some
Marvell Armada DT description to use the new NAND controller bindings,
but did it incorrectly for a number of boards: armada-xp-gp,
armada-xp-db and armada-xp-lenovo-ix4-300d. Due to this, the NAND is
no longer detected on those platforms.

This commit fixes that by properly using the new NAND DT binding. This
commit was runtime-tested on Armada XP GP, the two other platforms are
only compile-tested.

Fixes: 3b79919946cd2 ("ARM: dts: armada-370-xp: update NAND node with new bindings")
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/armada-xp-db.dts            | 46 +++++-----
 arch/arm/boot/dts/armada-xp-gp.dts            | 13 +--
 .../boot/dts/armada-xp-lenovo-ix4-300d.dts    | 85 ++++++++++---------
 3 files changed, 76 insertions(+), 68 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index f3ac7483afed..5d04dc68cf57 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -144,30 +144,32 @@
 				status = "okay";
 			};
 
-			nand@d0000 {
+			nand-controller@d0000 {
 				status = "okay";
-				label = "pxa3xx_nand-0";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				nand-on-flash-bbt;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition@0 {
-						label = "U-Boot";
-						reg = <0 0x800000>;
-					};
-					partition@800000 {
-						label = "Linux";
-						reg = <0x800000 0x800000>;
-					};
-					partition@1000000 {
-						label = "Filesystem";
-						reg = <0x1000000 0x3f000000>;
 
+				nand@0 {
+					reg = <0>;
+					label = "pxa3xx_nand-0";
+					nand-rb = <0>;
+					nand-on-flash-bbt;
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0 {
+							label = "U-Boot";
+							reg = <0 0x800000>;
+						};
+						partition@800000 {
+							label = "Linux";
+							reg = <0x800000 0x800000>;
+						};
+						partition@1000000 {
+							label = "Filesystem";
+							reg = <0x1000000 0x3f000000>;
+						};
 					};
 				};
 			};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 1139e9469a83..b4cca507cf13 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -160,12 +160,15 @@
 				status = "okay";
 			};
 
-			nand@d0000 {
+			nand-controller@d0000 {
 				status = "okay";
-				label = "pxa3xx_nand-0";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				nand-on-flash-bbt;
+
+				nand@0 {
+					reg = <0>;
+					label = "pxa3xx_nand-0";
+					nand-rb = <0>;
+					nand-on-flash-bbt;
+				};
 			};
 		};
 
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index bbbb38888bb8..87dcb502f72d 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -81,49 +81,52 @@
 
 			};
 
-			nand@d0000 {
+			nand-controller@d0000 {
 				status = "okay";
-				label = "pxa3xx_nand-0";
-				num-cs = <1>;
-				marvell,nand-keep-config;
-				nand-on-flash-bbt;
-
-				partitions {
-					compatible = "fixed-partitions";
-					#address-cells = <1>;
-					#size-cells = <1>;
-
-					partition@0 {
-						label = "u-boot";
-						reg = <0x00000000 0x000e0000>;
-						read-only;
-					};
-
-					partition@e0000 {
-						label = "u-boot-env";
-						reg = <0x000e0000 0x00020000>;
-						read-only;
-					};
-
-					partition@100000 {
-						label = "u-boot-env2";
-						reg = <0x00100000 0x00020000>;
-						read-only;
-					};
-
-					partition@120000 {
-						label = "zImage";
-						reg = <0x00120000 0x00400000>;
-					};
-
-					partition@520000 {
-						label = "initrd";
-						reg = <0x00520000 0x00400000>;
-					};
 
-					partition@e00000 {
-						label = "boot";
-						reg = <0x00e00000 0x3f200000>;
+				nand@0 {
+					reg = <0>;
+					label = "pxa3xx_nand-0";
+					nand-rb = <0>;
+					nand-on-flash-bbt;
+
+					partitions {
+						compatible = "fixed-partitions";
+						#address-cells = <1>;
+						#size-cells = <1>;
+
+						partition@0 {
+							label = "u-boot";
+							reg = <0x00000000 0x000e0000>;
+							read-only;
+						};
+
+						partition@e0000 {
+							label = "u-boot-env";
+							reg = <0x000e0000 0x00020000>;
+							read-only;
+						};
+
+						partition@100000 {
+							label = "u-boot-env2";
+							reg = <0x00100000 0x00020000>;
+							read-only;
+						};
+
+						partition@120000 {
+							label = "zImage";
+							reg = <0x00120000 0x00400000>;
+						};
+
+						partition@520000 {
+							label = "initrd";
+							reg = <0x00520000 0x00400000>;
+						};
+
+						partition@e00000 {
+							label = "boot";
+							reg = <0x00e00000 0x3f200000>;
+						};
 					};
 				};
 			};
-- 
2.19.1

