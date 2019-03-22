Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B8CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF4432070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553258749;
	bh=tj1newpMcM4JR3gdhMBwCHqpt1G+RfwUyDsV6rpVpX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CwAayUcNUdLhGYVRrde8W1ZxcnGxq4QilabVkw9oU7+zCXNEhj1pNtYNVdjv7Yoyq
	 38yDTgDY/w246vjPdNjg23x3Hf9mN/YsNEkqYbVjY194hrQFJ6bB+F8JVonECJzQDm
	 6crIpI9/J3zCHImPq2z+7u9u6TKKwZfYjzHFR50g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388461AbfCVMps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388037AbfCVMBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93C7E2192D;
        Fri, 22 Mar 2019 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256089;
        bh=tj1newpMcM4JR3gdhMBwCHqpt1G+RfwUyDsV6rpVpX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYV/V4N+5EC/gS1IkHuPUFwGwk+hGO/cjUzOAcv6s0jqGxjyDVA8wReDJsRAnQXCc
         H2QV8jA3vyXsgGZKffue+CVPgwmL18VnsCyWAxWG8SbffQVd9QVjS9E2uX+qld54LX
         FVeS86wmTi0PzoI+71a2ci/asGfGKr8LGcrwCuxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/280] ARM: dts: armada-xp: fix Armada XP boards NAND description
Date:   Fri, 22 Mar 2019 12:14:02 +0100
Message-Id: <20190322111311.470883480@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



