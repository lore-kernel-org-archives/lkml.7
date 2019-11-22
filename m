Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C0BC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E9B20708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574400648;
	bh=qQ7ADBan6Cki+gjs7P4HZzdhbGN9+BaZSrq2OioHsOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RwfhLb/mnjPwpRP5Ec54qPHQv/W/5uuXxsDyoBihvTmtjHLtr7yKcCSQq9EBa5d8A
	 FIaStrtSJ1rYKNcmUdbU0Y9Itajh1vnaLdnNqrhwIwKNpe+w/SgkvPkWolAULXlp4C
	 UorhsTF/4Rl0earNrdwnilAJqDpqqRpR6P5OIXro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKVFar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:30:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfKVFaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:30:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E3F2070E;
        Fri, 22 Nov 2019 05:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574400621;
        bh=qQ7ADBan6Cki+gjs7P4HZzdhbGN9+BaZSrq2OioHsOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NR04yJcYIPy9vuLIH+rIWqCA703JtD6fwcp+Rog6FpnPmW76RnYKE2W2LHXe1l+b+
         wCpNI/Wd3U9w0dviEv8/9OtjpqC/YlYa+2dkspPPwrd8m8A2MTaUepep+7qp4yKi6H
         bt4z1Itc3XfrnZ9JOXOLojj2V9GpAfNrnMP1AD/c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 020/219] ARM: dts: imx25: Fix memory node duplication
Date:   Fri, 22 Nov 2019 00:26:42 -0500
Message-Id: <20191122053001.752-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122053001.752-1-sashal@kernel.org>
References: <20191122053001.752-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 59d8bb363f563e4a147a291037bf979cb8ff9a59 ]

Boards based on imx25 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx25.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi | 1 +
 arch/arm/boot/dts/imx25-karo-tx25.dts        | 1 +
 arch/arm/boot/dts/imx25-pdk.dts              | 1 +
 arch/arm/boot/dts/imx25.dtsi                 | 2 --
 4 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index e316fe08837a3..e4d7da267532d 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -18,6 +18,7 @@
 	compatible = "eukrea,cpuimx25", "fsl,imx25";
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x4000000>; /* 64M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index 5cb6967866c0a..f37e9a75a3ca7 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -37,6 +37,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index a5626b46ac4e1..f8544a9e46330 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -12,6 +12,7 @@
 	compatible = "fsl,imx25-pdk", "fsl,imx25";
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x4000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index 85c15ee632727..8c8ad80de4614 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -12,10 +12,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		ethernet0 = &fec;
-- 
2.20.1

