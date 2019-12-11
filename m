Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD46C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F1E2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079535;
	bh=5Sp5yUHgoMyXmrbW9X9JdEoez6QcUp6xJ50vpCzx0b0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B8ufr1nUFMnEzySQ0mcVZJYgjDugCr+fN9t/lmnfyYkig/kmpMbU+BX8zLOmi3Tjz
	 eFULlFUA7CG3qHaPn33Mzy+fgOWLV7SqZ0Yetfi75Qyr2pmdyJmC0LK4SFpMAP3gLr
	 HKwJmNhOx+aoVLx28ib9X3Ej6/k4l1GmCKOJI0No=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732437AbfLKPVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:21:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:51292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732167AbfLKPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:21:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 030732073D;
        Wed, 11 Dec 2019 15:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077670;
        bh=5Sp5yUHgoMyXmrbW9X9JdEoez6QcUp6xJ50vpCzx0b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hk1qsV43cV4abeYPFzmDHZz17e4IVyNGUWz67mOxqDBj373Y3dKvcTOQC5AEr9HBT
         2/AmZA2hhmw17zHgtybEd0beckBsoygSuv5Pg9Um1flBBhuZsZ67NoywAHUT0R4MLo
         8OQb1g9GTMOjnVYn+1OTDYqi46AtAkWKtUGuEnz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 127/243] ARM: dts: sun8i: a23/a33: Fix OPP DTC warnings
Date:   Wed, 11 Dec 2019 16:04:49 +0100
Message-Id: <20191211150347.699074067@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

[ Upstream commit a858f569b80a69076c521532a289097af905cf1e ]

DTC will emit a warning on our OPPs nodes for the common DTSI between the
A23 and A33 since those nodes use the frequency as unit addresses, but
don't have a matching reg property.

Fix this by moving the frequency to the node name instead.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi              | 6 +++---
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index f0096074a4678..97de6ad133dc2 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -47,19 +47,19 @@
 		compatible = "operating-points-v2";
 		opp-shared;
 
-		opp@648000000 {
+		opp-648000000 {
 			opp-hz = /bits/ 64 <648000000>;
 			opp-microvolt = <1040000 1040000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@816000000 {
+		opp-816000000 {
 			opp-hz = /bits/ 64 <816000000>;
 			opp-microvolt = <1100000 1100000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
-		opp@1008000000 {
+		opp-1008000000 {
 			opp-hz = /bits/ 64 <1008000000>;
 			opp-microvolt = <1200000 1200000 1300000>;
 			clock-latency-ns = <244144>; /* 8 32k periods */
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index 0dbdb29a8fff9..ee7ce3752581b 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -103,13 +103,13 @@
 };
 
 &cpu0_opp_table {
-	opp@1104000000 {
+	opp-1104000000 {
 		opp-hz = /bits/ 64 <1104000000>;
 		opp-microvolt = <1320000>;
 		clock-latency-ns = <244144>; /* 8 32k periods */
 	};
 
-	opp@1200000000 {
+	opp-1200000000 {
 		opp-hz = /bits/ 64 <1200000000>;
 		opp-microvolt = <1320000>;
 		clock-latency-ns = <244144>; /* 8 32k periods */
-- 
2.20.1



