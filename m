Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190E9C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCB9218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556117233;
	bh=V5GB3aXi80ipnkQvJl9loEgreFbDz9Jlgp4bdhfP/QE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GiaR9LQUSNDQVFhN06ePFRQHICylNBN46t9ZWYmvAKcIPq49E86hA4reo7q6ueVyR
	 fwNQyIg7iHnuVWAzw7bJFvROjrgovaQYZnvXcWzAq+xoHF8WYB6g5EOupZc3UbJoSQ
	 m991lT9bFX4zPXnME4vKDac+THBLXxXWu9F1YmRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbfDXOrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730859AbfDXOeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E31A218FE;
        Wed, 24 Apr 2019 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116455;
        bh=V5GB3aXi80ipnkQvJl9loEgreFbDz9Jlgp4bdhfP/QE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmTRk/a7bNNmxkxQlxNYM6260dnJMIyXaS2T/V+EYZoG2yz4CLVCRR4veE+WjFK10
         C1ejw9kOI6dVQTHooygIxnyEqpHakilW+OoK3+gSSco4SGUdurcvQNNscMiWRc6nFi
         mtnGqveoWwHcpFXb09kdOMoi5+v+M11KNv18iIdU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 14/66] ARM: dts: Fix dcan clkctrl clock for am3
Date:   Wed, 24 Apr 2019 10:32:48 -0400
Message-Id: <20190424143341.27665-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 7d56bedb2730dc2ea8abf0fd7240ee99ecfee3c9 ]

We must not use legacy clock defines for dts clckctrl clocks as the offsets
will be wrong.

Fixes: 87fc89ced3a7 ("ARM: dts: am335x: Move l4 child devices to probe them with ti-sysc")
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/boot/dts/am33xx-l4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx-l4.dtsi b/arch/arm/boot/dts/am33xx-l4.dtsi
index 7b818d9d2eab..8396faa9ac28 100644
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1763,7 +1763,7 @@
 			reg = <0xcc000 0x4>;
 			reg-names = "rev";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM3_D_CAN0_CLKCTRL 0>;
+			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN0_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -1786,7 +1786,7 @@
 			reg = <0xd0000 0x4>;
 			reg-names = "rev";
 			/* Domains (P, C): per_pwrdm, l4ls_clkdm */
-			clocks = <&l4ls_clkctrl AM3_D_CAN1_CLKCTRL 0>;
+			clocks = <&l4ls_clkctrl AM3_L4LS_D_CAN1_CLKCTRL 0>;
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.19.1

