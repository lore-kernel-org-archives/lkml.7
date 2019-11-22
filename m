Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AEBC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7489204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574404263;
	bh=rBaaCepDaC+PYJzZ8NE3MPbHgZYe5c/CjDWf7Ogf0ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cXtevogra6qr4XeVaF3IbpZCxbzZ0mGJR9qZQyNv3oK0xvo1eSbjorl4aqMCZVcYo
	 nUpGt5j+IjZb7da3xJq/9bFsjhd6JCzptAHfn/Lwrm1qQMIZVb88FPTua72gHEnng7
	 K/L/AL7lMWW1EzFR2nfWsoq620tte9deD5XjRN3c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfKVFtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:49:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:53202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfKVFtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:49:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479D72070B;
        Fri, 22 Nov 2019 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401756;
        bh=rBaaCepDaC+PYJzZ8NE3MPbHgZYe5c/CjDWf7Ogf0ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d0aicebpDbgpv6oZaWNZfGa4x2gT7Z4+Jc3Cdkcx3aAWGjUHa7+fkYl/haSIQQPvk
         gYMTZWKXZs8ft6zee4p8C7nNJH2VtDi+mVVxhKnG4n9n5nF4F3SMgSyjwrStzZttCd
         IbSAxX2HOlEjA/E7tCVV6R/aibokil8IuNKTN65E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 010/219] ARM: dts: imx31: Fix memory node duplication
Date:   Fri, 22 Nov 2019 00:45:42 -0500
Message-Id: <20191122054911.1750-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabio Estevam <festevam@gmail.com>

[ Upstream commit 013d37e4707e24c7b9bc3fc55aeda55ce9c2b262 ]

Boards based on imx31 have duplicate memory nodes:

- One coming from the board dts file: memory@

- One coming from the imx31.dtsi file.

Fix the duplication by removing the memory node from the dtsi file
and by adding 'device_type = "memory";' in the board dts.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Tested-by: Vladimir Zapolskiy <vz@mleia.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx31-bug.dts  | 1 +
 arch/arm/boot/dts/imx31-lite.dts | 1 +
 arch/arm/boot/dts/imx31.dtsi     | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx31-bug.dts b/arch/arm/boot/dts/imx31-bug.dts
index 6ee4ff8e4e8f0..9eb960cc02cc5 100644
--- a/arch/arm/boot/dts/imx31-bug.dts
+++ b/arch/arm/boot/dts/imx31-bug.dts
@@ -17,6 +17,7 @@
 	compatible = "buglabs,imx31-bug", "fsl,imx31";
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x8000000>; /* 128M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx31-lite.dts b/arch/arm/boot/dts/imx31-lite.dts
index db52ddccabc33..d17abdfb6330c 100644
--- a/arch/arm/boot/dts/imx31-lite.dts
+++ b/arch/arm/boot/dts/imx31-lite.dts
@@ -18,6 +18,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x8000000>;
 	};
 
diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index ca1419ca303c3..2fc64d2c7c88e 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -10,10 +10,8 @@
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

