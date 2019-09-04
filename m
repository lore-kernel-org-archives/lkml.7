Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE946C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A732087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567612677;
	bh=NZ1BsXKgGPlCcAzGWiNt0D1XMpiB4ymc0WgYmkVRm7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=roJ/MllST/pJiwkhVmEYi5GGAFJVvRDMQKt8PKkJ352LfXNgmFRug0WGChi5fmXqh
	 P7vhMHkbBlQEotlZtUpXiq8LYL2r+B5hSEG+WH7Xp1ly1Sui4p+LFxi3upcL4BpMh4
	 S5N7R6UK+xMDBpiwWaRG7SzuKh0GB1nt7Z3MNB9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbfIDP55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731384AbfIDP5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:57:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 124CC23404;
        Wed,  4 Sep 2019 15:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567612672;
        bh=NZ1BsXKgGPlCcAzGWiNt0D1XMpiB4ymc0WgYmkVRm7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kG474HSxDx2KmvZzMCp+BEGC3DDkrlqKysPbhFg3eCFCXiFTAI0D3FdBiVA0uHdSm
         9Gz5XqldFNVlTRXpVj7PqoShx2n5DtAm4lVlq5CgNjBvTFVPF/+tcerL90elGAT76t
         VZlA7sIxTdr6PtP7YoZhobBrQQwddxMKUO5KTP/M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>,
        Keerthy <j-keerthy@ti.com>, Sasha Levin <sashal@kernel.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 07/94] ARM: dts: Fix flags for gpio7
Date:   Wed,  4 Sep 2019 11:56:12 -0400
Message-Id: <20190904155739.2816-7-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 2e8647bbe1c8233a20c32fd2648258f2c05c7335 ]

The ti,no-idle-on-init and ti,no-reset-on-init flags need to be at
the interconnect target module level for the modules that have it
defined. Otherwise we get the following warnings:

dts flag should be at module level for ti,no-idle-on-init
dts flag should be at module level for ti,no-reset-on-init

Reviewed-by: Suman Anna <s-anna@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 2 +-
 arch/arm/boot/dts/dra7-evm.dts                  | 2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index d50de7a6ea6c5..bc76f1705c0f6 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -379,7 +379,7 @@
 	};
 };
 
-&gpio7 {
+&gpio7_target {
 	ti,no-reset-on-init;
 	ti,no-idle-on-init;
 };
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 714e971b912a4..de7f85efaa512 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -498,7 +498,7 @@
 	phy-supply = <&ldousb_reg>;
 };
 
-&gpio7 {
+&gpio7_target {
 	ti,no-reset-on-init;
 	ti,no-idle-on-init;
 };
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 23faedec08abd..63628e166c0cd 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -1261,7 +1261,7 @@
 			};
 		};
 
-		target-module@51000 {			/* 0x48051000, ap 45 2e.0 */
+		gpio7_target: target-module@51000 {		/* 0x48051000, ap 45 2e.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "gpio7";
 			reg = <0x51000 0x4>,
-- 
2.20.1

