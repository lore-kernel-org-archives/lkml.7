Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADFBC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82452206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215149;
	bh=XkpVBslqKuTdE5Rwg3WUgngD4asXjVjBos72JgaNb94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VTw8FLkzFOblcAfrostTCfxJ6l5Zr7SOEawtl5mq6fiMEm7iqqaYVmzQHZQ6BV9+Q
	 rdSp6AclNOiK1mue7A2mbySSxvXs3MRvvhOZYW5kOTxq7c0NddiIYUDtsyWFDMiV74
	 ysJnyVilamLHB/fS1ulAV1/0+1LDXk4MiU+tQ9sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391977AbfKHMM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:12:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:51784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732852AbfKHLir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C63EE20869;
        Fri,  8 Nov 2019 11:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213126;
        bh=XkpVBslqKuTdE5Rwg3WUgngD4asXjVjBos72JgaNb94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pbPmAcHfQcljEhJlvQ1b8S1WtiWTHAsUvyfmAUGLE6UR5BRMatMzGWDfRSAaMvjoE
         X1eDEfeH/57UY2tX7S9nc1LtU6/QiWgYA3iyjdzoa/09KBTWjPH1RjuKxoK4V7k9nR
         xhGi0Bnnuc2ESrEcPZQaY20WDbJQTN2+7/Ym2op4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 045/205] ARM: dts: exynos: Fix regulators configuration on Peach Pi/Pit Chromebooks
Date:   Fri,  8 Nov 2019 06:35:12 -0500
Message-Id: <20191108113752.12502-45-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit f8f3b7fc21b1cb59385b780acd9b9a26d04cb7b2 ]

Regulators, which are marked as 'on-in-suspend' seems to be critical for
board operation, thus they must not be disabled anytime. This can be
only assured by marking them as 'always-on', because otherwise some
actions of their clients might result in turning them off. This patch
restores suspend/resume operation on Peach-Pit Chromebook board. It
partially reverts 'always-on' property removal done by the commit
mentioned in the Fixes tag.

Fixes: 665c441eea3d ("ARM: dts: exynos: Remove unneded always-on for regulators on Peach boards")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Tomasz Figa <tfiga@chromium.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 3 +++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 25bdc9d97a4df..769d60d6c9006 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -312,6 +312,7 @@
 				regulator-name = "vdd_1v35";
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -333,6 +334,7 @@
 				regulator-name = "vdd_2v";
 				regulator-min-microvolt = <2000000>;
 				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -343,6 +345,7 @@
 				regulator-name = "vdd_1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 7989631b39ccf..492e2cd2e559e 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -312,6 +312,7 @@
 				regulator-name = "vdd_1v35";
 				regulator-min-microvolt = <1350000>;
 				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -333,6 +334,7 @@
 				regulator-name = "vdd_2v";
 				regulator-min-microvolt = <2000000>;
 				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
@@ -343,6 +345,7 @@
 				regulator-name = "vdd_1v8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
 				regulator-boot-on;
 				regulator-state-mem {
 					regulator-on-in-suspend;
-- 
2.20.1

