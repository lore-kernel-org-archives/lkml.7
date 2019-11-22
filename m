Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F8CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B312070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574400656;
	bh=QMfJafxbKV6VqZ8NBZCoKoHf49qSMqnZYPlVj1ehGus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rk3K51YH20QTsw2M34RsUyPLQeX+2rEcUjiJCNiOLcMMajBZNzRv43GTzEjf2WVfN
	 Mr5N3YsKrI2YmfFb8DSU2eOKOtk9mEXJjO5xApa8icgh2/ceh0wo1sYUJLaxe/5BI+
	 /iBCsCgAukggTMfKVzr3zbdaIrd17B7PaDiWiMFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfKVFaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:30:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:47966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727232AbfKVFaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:30:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67C8820708;
        Fri, 22 Nov 2019 05:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574400618;
        bh=QMfJafxbKV6VqZ8NBZCoKoHf49qSMqnZYPlVj1ehGus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k7+vc6uCh9Q+uWwxLZwLWLIKiM4laeL06cY0ZiEYrzbkOzNhaVv3sKZf+79AZBSI1
         qvqgw88UErYmFF/TZBfmeoDSkACmRSWPCDSfC9Ya1Vn28mHdZFfUDvbw7w6A3aYB+U
         t9C7zd9QXfdrorPfJzTdqkjoBhSeGxAt12ginHvw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 018/219] ARM: dts: imx1: Fix memory node duplication
Date:   Fri, 22 Nov 2019 00:26:40 -0500
Message-Id: <20191122053001.752-11-sashal@kernel.org>
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

[ Upstream commit 62864d5665c4fc636d3021f829b3ac00fa058e30 ]

Boards based on imx1 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx1.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx1-ads.dts     | 1 +
 arch/arm/boot/dts/imx1-apf9328.dts | 1 +
 arch/arm/boot/dts/imx1.dtsi        | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx1-ads.dts b/arch/arm/boot/dts/imx1-ads.dts
index a1d81badb5c8a..119b19ba53b6d 100644
--- a/arch/arm/boot/dts/imx1-ads.dts
+++ b/arch/arm/boot/dts/imx1-ads.dts
@@ -21,6 +21,7 @@
 	};
 
 	memory@8000000 {
+		device_type = "memory";
 		reg = <0x08000000 0x04000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx1-apf9328.dts b/arch/arm/boot/dts/imx1-apf9328.dts
index 11515c0cb195c..ee4b1b106b1ae 100644
--- a/arch/arm/boot/dts/imx1-apf9328.dts
+++ b/arch/arm/boot/dts/imx1-apf9328.dts
@@ -21,6 +21,7 @@
 	};
 
 	memory@8000000 {
+		device_type = "memory";
 		reg = <0x08000000 0x00800000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx1.dtsi b/arch/arm/boot/dts/imx1.dtsi
index 3edc7b5550d88..2b6e77029de4d 100644
--- a/arch/arm/boot/dts/imx1.dtsi
+++ b/arch/arm/boot/dts/imx1.dtsi
@@ -15,10 +15,8 @@
 	 * The decompressor and also some bootloaders rely on a
 	 * pre-existing /chosen node to be available to insert the
 	 * command line and merge other ATAGS info.
-	 * Also for U-Boot there must be a pre-existing /memory node.
 	 */
 	chosen {};
-	memory { device_type = "memory"; };
 
 	aliases {
 		gpio0 = &gpio1;
-- 
2.20.1

