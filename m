Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A42C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8527620657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505281;
	bh=L0Enbu1fZ7K+UDS99HWcRdeF+WzSsW51aiihSnv1XEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eo6UK/iPOYqFhcE3Vf7qPyOL2aQVSCB2O29oiJhst4AgQ/HeEbTjad6MxHc2cOxZ4
	 I1H2BCjZAlrBsu6GCIgZBw9WQuLz6KzwYv5rHkVwTzNvcBALdhn8B+NK/vbUE6d/oJ
	 pOOEhA7pEoZ0NHVBoYRnbCPTnKnB6t6YBtKj9SH4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbfCMT2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:28:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:44288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbfCMTNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:13:51 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDB9F2173C;
        Wed, 13 Mar 2019 19:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504430;
        bh=L0Enbu1fZ7K+UDS99HWcRdeF+WzSsW51aiihSnv1XEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hvpcUvZ7D0Bn43eUpOcVPycEqh8HTxoUCB22MQBWSYD4H9ofnKPBsJio4oGljk2f1
         U1+FXKjaf4IchRJo+HU3pmS3VgsVIFJSt1N2Jet70HvVN51TcCisRyLiCmS6eVUkAL
         2Me7krLyAPmuh2Jul1GyfJ/A0A3Kle0/lFUCTVBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/48] ARM: dts: armada-xp: fix Armada XP boards NAND description
Date:   Wed, 13 Mar 2019 15:12:25 -0400
Message-Id: <20190313191250.158955-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191250.158955-1-sashal@kernel.org>
References: <20190313191250.158955-1-sashal@kernel.org>
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

